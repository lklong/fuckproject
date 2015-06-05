package com.zhigu.service.goods.impl;

import java.io.File;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.SessionUser;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.StoreNoticeType;
import com.zhigu.common.constant.enumconst.GoodsStatus;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.common.exception.ServiceException;
import com.zhigu.common.utils.DateUtil;
import com.zhigu.common.utils.StringUtil;
import com.zhigu.common.utils.ZhiguConfig;
import com.zhigu.mapper.CategoryMapper;
import com.zhigu.mapper.GoodsAndStoreRefreshMapper;
import com.zhigu.mapper.GoodsMapper;
import com.zhigu.mapper.StoreMapper;
import com.zhigu.mapper.StoreNoticeMapper;
import com.zhigu.model.DownloadHistory;
import com.zhigu.model.Goods;
import com.zhigu.model.GoodsAndStroeRefresh;
import com.zhigu.model.GoodsAux;
import com.zhigu.model.GoodsCondition;
import com.zhigu.model.GoodsImage;
import com.zhigu.model.GoodsProperty;
import com.zhigu.model.GoodsSku;
import com.zhigu.model.PageBean;
import com.zhigu.model.Store;
import com.zhigu.model.StoreNotice;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.goods.IGoodsService;

/**
 * 商品
 * 
 * @author zhouqibing 2014年9月30日上午11:31:49
 */
@Service
public class GoodsServiceImpl implements IGoodsService {
	private static final Logger logger = Logger.getLogger(GoodsServiceImpl.class);
	@Autowired
	private GoodsMapper goodsDao;
	@Autowired
	private StoreMapper storeDao;
	@Autowired
	private CategoryMapper categoryDao;
	@Autowired
	private StoreNoticeMapper storeNoticeMapper;

	@Autowired
	private GoodsAndStoreRefreshMapper goodsAndStoreRefreshMapper;
	/** 用户刷新商品次数限制 */
	private static final int GOODS_REFRESH_NUM_LIMIT = 3;

	@Override
	public MsgBean saveGoods(Goods goods, List<GoodsSku> skus, List<GoodsProperty> properties, List<GoodsImage> images) {
		// 店铺id设置
		SessionUser user = SessionHelper.getSessionUser();
		int userID = user.getUserID();
		Store store = storeDao.queryStoreByUserID(userID);
		goods.setStoreId(store.getID());
		// 图片处理
		String root = ZhiguConfig.getSaveFileRoot();
		File srcFile = null;
		// String prefix = "";
		// String suffix = "";
		for (GoodsImage img : images) {
			srcFile = new File(root + img.getImage());
			if (!srcFile.exists()) {
				continue;
			}
			String img300 = img.getImage();
			img.setImage300(img300);

			// 主图
			if (img.isMain()) {
				goods.setImage300(img300);

				// 最新商品主图设为店铺logo
				if (!store.getLogoPath().contains("80x80")) {
					store.setLogoPath(img300);
					storeDao.updateStore(store);
				}
			}
		}
		goods.setStatus(GoodsStatus.NORMAL.getValue());// 上架

		// script标签转义
		goods.setDescription(goods.getDescription().replaceAll("<sript.*>", "&lt;sript&gt;").replaceAll("</sript.*>", "&lt;/sript&gt;"));

		// 设置新增商品的刷新时间
		goods.setRefreshDate(new Date());

		// 设置删除标示
		goods.setDeleteFlag(false);

		goodsDao.saveGoods(goods);

		int goodsId = goods.getId();

		// 保存图片信息
		for (int i = 0; i < images.size(); i++) {
			images.get(i).setGoodsId(goodsId);
			images.get(i).setPosition(i + 1);
		}
		goodsDao.saveGoodsImage(images);

		// 商品sku（如果添加的商品没有sku,则默认加一个，为方便下单操作）
		if (skus == null || skus.isEmpty()) {
			GoodsSku sku = new GoodsSku();
			sku.setAmount(-1);// 没有限制
			sku.setPrice(goods.getMinPrice());// 没有suk价格，挂牌价必填
			sku.setStatus(1);

			skus = new ArrayList<GoodsSku>();
			skus.add(sku);
		}

		int amount = 0;
		BigDecimal minPrice = new BigDecimal(0);
		BigDecimal maxPrice = new BigDecimal(0);
		boolean floop = true;
		// 设置商品ID
		for (GoodsSku sku : skus) {
			sku.setGoodsId(goodsId);
			sku.setStatus(1);
			amount += sku.getAmount();

			if (floop) {
				minPrice = sku.getPrice();
				maxPrice = sku.getPrice();
				floop = false;
			}

			minPrice = minPrice.min(sku.getPrice());
			maxPrice = maxPrice.max(sku.getPrice());

		}
		goodsDao.saveGoodsSku(skus);

		// 修改商品最低、最高价格
		goods = goodsDao.queryGoodsById(goodsId);
		goods.setMinPrice(minPrice);
		goods.setMaxPrice(maxPrice);
		goodsDao.updateGoods(goods);

		// 保存商品附属信息
		GoodsAux aux = new GoodsAux(goodsId);
		aux.setAmount(amount);
		goodsDao.saveGoodsAux(aux);

		// 反查取得sku
		List<GoodsSku> dbskus = goodsDao.queryGoodsSkus(goodsId);
		// 将skuId设置到属性上
		for (GoodsSku sku : dbskus) {
			if (!StringUtil.isEmpty(sku.getPropertyStr())) {

				String[] ays = sku.getPropertyStr().split(",");
				for (String p : ays) {
					for (GoodsProperty gp : properties) {
						if (!gp.isSku() || gp.getSkuId() > 0)
							continue;

						if ((gp.getPropertyId() + ":" + gp.getPropertyValueId()).equals(p)) {
							gp.setSkuId(sku.getId());
							break;
						}
					}
				}
			}
		}

		for (GoodsProperty gp : properties)
			gp.setGoodsId(goodsId);

		goodsDao.saveGoodsProperty(properties);

		StoreNotice notice = new StoreNotice();
		notice.setType(StoreNoticeType.GOODS);
		notice.setStoreID(goods.getStoreId());
		notice.setContent(store.getStoreName() + "  添加了  " + goods.getName() + "  商品!");
		storeNoticeMapper.saveStoreNotice(notice);

		return new MsgBean(Code.SUCCESS, "保存成功", MsgLevel.NORMAL).setData(goods.getId());
	}

	@Override
	public MsgBean updateGoods(Goods goods, List<GoodsSku> skus, List<GoodsProperty> properties, List<GoodsImage> images) {
		int goodsId = goods.getId();
		// 验证
		Store store = storeDao.queryStoreByUserID(SessionHelper.getSessionUser().getUserID());
		Goods ogoods = goodsDao.queryGoodsById(goodsId);
		if (ogoods == null || ogoods.getStoreId() != store.getID()) {
			throw new ServiceException("非法操作！不能更新非自己的商品。");
		}

		// 图片处理
		String root = ZhiguConfig.getSaveFileRoot();
		File srcFile = null;
		for (GoodsImage img : images) {
			if (!StringUtil.isEmpty(img.getImage()) && !img.getImage().contains("uploadimg")) {
				srcFile = new File(root + img.getImage());
				if (!srcFile.exists()) {
					continue;
				}
				String img300 = img.getImage();
				img.setImage300(img300);
			}
			// 主图
			if (img.isMain()) {
				goods.setImage300(img.getImage300());
			}
		}

		goods.setStatus(ogoods.getStatus());

		// 保存图片信息
		for (int i = 0; i < images.size(); i++) {
			images.get(i).setGoodsId(goodsId);
			images.get(i).setPosition(i + 1);
		}
		goodsDao.deleteGoodsImage(goodsId);
		goodsDao.saveGoodsImage(images);

		// 商品sku（如果添加的商品没有sku,则默认加一个，为方便下单操作）
		if (skus == null || skus.isEmpty()) {
			GoodsSku sku = new GoodsSku();
			sku.setAmount(-1);// 没有限制
			sku.setPrice(goods.getMinPrice());// 没有suk价格，挂牌价必填
			sku.setStatus(1);

			skus = new ArrayList<GoodsSku>();
			skus.add(sku);
		}

		int amount = 0;
		BigDecimal minPrice = new BigDecimal(0);
		BigDecimal maxPrice = new BigDecimal(0);
		boolean floop = true;
		// 设置商品ID
		for (GoodsSku sku : skus) {
			sku.setGoodsId(goodsId);
			sku.setStatus(1);
			amount += sku.getAmount();

			if (floop) {
				minPrice = sku.getPrice();
				maxPrice = sku.getPrice();
				floop = false;
			}

			minPrice = minPrice.min(sku.getPrice());
			maxPrice = maxPrice.max(sku.getPrice());

		}
		goods.setMinPrice(minPrice);
		goods.setMaxPrice(maxPrice);

		goodsDao.deleteGoodsSku(goodsId);
		goodsDao.saveGoodsSku(skus);

		// 保存商品附属信息
		GoodsAux aux = ogoods.getAux();
		aux.setAmount(amount);
		goodsDao.updateGoodsAux(aux);

		// 反查取得sku
		List<GoodsSku> dbskus = goodsDao.queryGoodsSkus(goodsId);
		// 将skuId设置到属性上
		for (GoodsSku sku : dbskus) {
			if (!StringUtil.isEmpty(sku.getPropertyStr())) {

				String[] ays = sku.getPropertyStr().split(",");
				for (String p : ays) {
					for (GoodsProperty gp : properties) {
						if (!gp.isSku() || gp.getSkuId() > 0)
							continue;

						if ((gp.getPropertyId() + ":" + gp.getPropertyValueId()).equals(p)) {
							gp.setSkuId(sku.getId());
							break;
						}
					}
				}
			}
		}
		for (GoodsProperty gp : properties)
			gp.setGoodsId(goodsId);

		goodsDao.deleteGoodsProperty(goodsId);
		goodsDao.saveGoodsProperty(properties);
		goodsDao.updateGoods(goods);
		// 店铺公告
		StoreNotice notice = new StoreNotice();
		notice.setType(StoreNoticeType.GOODS);
		notice.setStoreID(store.getID());
		notice.setContent(store.getStoreName() + "  修改了  " + goods.getName() + "  商品!");
		storeNoticeMapper.saveStoreNotice(notice);

		// script标签转义
		goods.setDescription(goods.getDescription().replaceAll("<sript.*>", "&lt;sript&gt;").replaceAll("</sript.*>", "&lt;/sript&gt;"));

		return new MsgBean(Code.SUCCESS, "更新成功", MsgLevel.NORMAL).setData(goods.getId());
	}

	@Override
	public List<GoodsSku> queryGoodsSkus(int goodsId) {
		return goodsDao.queryGoodsSkus(goodsId);
	}

	@Override
	public List<Goods> queryGoodsList(GoodsCondition gc, PageBean<Goods> page) {
		if (gc == null) {
			gc = new GoodsCondition();
		}
		if (!StringUtil.isEmpty(gc.getGoodsName())) {
			gc.setGoodsName(gc.getGoodsName().trim().replaceAll("[ ]+", "%"));
		}

		List<Goods> list = goodsDao.queryGoodsByPage(gc, page);

		// 货号处理
		for (Goods goods : list) {
			Store store = storeDao.queryStoreByID(goods.getStoreId());
			String name = store.getStoreName();
			String propValueName = goodsDao.queryItemNoInGoodsProperty(goods.getId());
			if (StringUtils.isBlank(propValueName)) {
				propValueName = "156-3";
			}
			goods.setItemNo(name + "&" + propValueName);
		}

		page.setDatas(list);
		return list;
	}

	@Override
	public Goods queryGoods(int goodsId) {
		return goodsDao.queryGoodsById(goodsId);
	}

	@Override
	public boolean updateGoods(Goods goods) {
		return goodsDao.updateGoods(goods);
	}

	@Override
	public int queryStoreGoodsNum(GoodsCondition gc) {
		return goodsDao.queryStoreGoodsNum(gc);
	}

	@Override
	public GoodsAux queryGoodsAux(int goodsId) {
		return goodsDao.queryGoodsAux(goodsId);
	}

	@Override
	public boolean updateGoodsAux(GoodsAux aux) {
		return goodsDao.updateGoodsAux(aux);
	}

	@Override
	public void queryDownloadHistory(PageBean<DownloadHistory> page, int goodsId) {
		List<DownloadHistory> downloadHistories = goodsDao.queryDownloadHistoryByPage(page, goodsId);
		page.setDatas(downloadHistories);
	}

	@Override
	public List<String> queryGoodsNames(String keyword) {

		return goodsDao.queryGoodsNames(keyword);
	}

	@Override
	public MsgBean updateGoodsRefreshDate(Integer goodsId) {
		Integer userId = SessionHelper.getSessionUser().getUserID();
		Date now = new Date();
		int refreshCount = goodsAndStoreRefreshMapper.countNum(DateUtil.format(now, DateUtil.yyyy_MM_dd), userId, goodsId, null);
		int usableRefreshNum = GOODS_REFRESH_NUM_LIMIT - refreshCount;
		if (usableRefreshNum <= 0) {
			return new MsgBean(Code.FAIL, "已超过刷新次数限制", MsgLevel.ERROR);
		} else {
			GoodsAndStroeRefresh goodsRefresh = new GoodsAndStroeRefresh();
			goodsRefresh.setGoodsId(goodsId);
			goodsRefresh.setUserId(userId);
			goodsRefresh.setRefreshDate(now);

			goodsAndStoreRefreshMapper.insert(goodsRefresh);

			goodsDao.updateGoodsRefreshDate(now, goodsId);
			return new MsgBean(Code.SUCCESS, "刷新成功，今天还可刷新 " + (usableRefreshNum - 1) + " 次", MsgLevel.NORMAL);
		}
	}

	public Map<String, List<GoodsProperty>> queryGoodsSkuFromProperty(int goodsId) {

		List<GoodsProperty> skuProps = goodsDao.queryGoodsSkuFromProperty(goodsId);
		Map<String, List<GoodsProperty>> skuMap = new HashMap<String, List<GoodsProperty>>();
		List<GoodsProperty> _skuProp = null;
		for (GoodsProperty prop : skuProps) {
			_skuProp = skuMap.get(prop.getPropertyName());
			if (_skuProp == null) {
				_skuProp = new ArrayList<GoodsProperty>();
				_skuProp.add(prop);
				skuMap.put(prop.getPropertyName(), _skuProp);
			} else {
				_skuProp.add(prop);
			}
		}

		return skuMap;
	}

	public List<GoodsSku> queryGoodsSkuByPropStr(int goodsId, String skuStr) {

		return goodsDao.queryGoodsSkuByPropStr(goodsId, skuStr);
	}

	@Override
	public PageBean<Goods> queryForHome(Integer pageNo, String propName, String goodsName) {

		PageBean<Goods> page = new PageBean<Goods>();
		if (pageNo != null) {
			page.setPageNo(pageNo);
		}
		page.setPageSize(30);
		page.setOrderBy(15);// 刷新时间

		String storeName = null;
		goodsName = StringUtils.isBlank(goodsName) ? null : goodsName;

		propName = StringUtils.isBlank(propName) ? null : propName;
		String _propName = null;
		if (!StringUtils.isBlank(propName) && propName.indexOf("&") != -1) {
			int mid = propName.indexOf('&');
			storeName = propName.substring(0, mid);
			_propName = propName.substring(mid + 1);
		} else {
			_propName = propName;
		}

		List<Goods> goodsList = goodsDao.queryForHomeByPage(page, storeName, _propName, goodsName);

		// 货号处理
		for (Goods goods : goodsList) {
			Store store = storeDao.queryStoreByID(goods.getStoreId());
			String name = store.getStoreName();
			String propValueName = goodsDao.queryItemNoInGoodsProperty(goods.getId());
			if (StringUtils.isBlank(propValueName)) {
				propValueName = "156-3";
			}
			goods.setItemNo(name + "&" + propValueName);
		}

		page.setDatas(goodsList);

		return page;
	}

	@Override
	public int updateGoodsDeleteFlagByGoodsID(Integer goodsID, boolean deleteFlag) {
		return goodsDao.updateGoodsDeleteFlagByGoodsID(goodsID, deleteFlag);
	}

}

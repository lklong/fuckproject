package com.zhigu.service.store.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.util.HtmlUtils;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.SessionUser;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.Flg;
import com.zhigu.common.constant.StoreType;
import com.zhigu.common.constant.SystemConstants;
import com.zhigu.common.constant.enumconst.FavouriteType;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.common.constant.enumconst.StoreApproveState;
import com.zhigu.common.exception.ServiceException;
import com.zhigu.common.utils.DateUtil;
import com.zhigu.common.utils.StringUtil;
import com.zhigu.common.utils.VerifyUtil;
import com.zhigu.common.utils.sms.SMSUtil;
import com.zhigu.mapper.FavouriteMapper;
import com.zhigu.mapper.GoodsAndStoreRefreshMapper;
import com.zhigu.mapper.RealStoreAuthMapper;
import com.zhigu.mapper.StoreMapper;
import com.zhigu.mapper.UserMapper;
import com.zhigu.model.Favourite;
import com.zhigu.model.Goods;
import com.zhigu.model.GoodsAndStroeRefresh;
import com.zhigu.model.GoodsCondition;
import com.zhigu.model.PageBean;
import com.zhigu.model.Store;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.goods.IGoodsService;
import com.zhigu.service.store.IStoreService;
import com.zhigu.service.user.IUserService;

@Service
public class StoreServiceImpl implements IStoreService {
	private static final Logger logger = Logger.getLogger(StoreServiceImpl.class);
	@Autowired
	private StoreMapper storeDao;
	@Autowired
	private FavouriteMapper favouriteDao;
	@Autowired
	private RealStoreAuthMapper realStoreAuthDao;
	@Autowired
	private UserMapper userDao;
	@Autowired
	private IGoodsService goodsService;
	@Autowired
	private IUserService userService;
	@Autowired
	private GoodsAndStoreRefreshMapper goodsAndStoreRefreshMapper;

	/** 用户刷新店铺次数限制 */
	private static final int GOODS_REFRESH_NUM_LIMIT = 3;

	@Override
	public Store queryStoreByUserID(int userID) {
		return storeDao.queryStoreByUserID(userID);
	}

	@Override
	public Store queryStoreByDomain(String domain) {

		return storeDao.queryStoreByDomain(domain);
	}

	@Override
	public Store queryStoreByStoreName(String storeName) {

		return storeDao.queryStoreByStoreName(storeName);
	}

	@Override
	public MsgBean registerStore(Store store) {
		store.setUserID(SessionHelper.getSessionUser().getUserID());
		// 默认logo
		store.setLogoPath("/img/storelogo.jpg");
		// 输入数据check
		MsgBean checkResult = checkStoreInfo(store, null);

		if (checkResult.getCode() != Code.SUCCESS) {
			return checkResult;
		}
		// 以下数据注册时初期化
		store.setStoreNameModify(3);
		store.setDomainModify(3);
		store.setLevelPoint(0);
		store.setIntegrityAuth(0);
		store.setCompanyAuth(0);
		store.setRealStoreAuth(0);
		store.setApplyTime(new Date());
		store.setOpenStoreDate(new Date());
		store.setFullMemberFlg(Flg.OFF);
		// 注册后等待审核状态
		store.setApproveState(StoreApproveState.WAIT_APPROVED.getValue());

		// 现在只开放供应商注册
		store.setSupplierType(StoreType.SUPPLIER);
		if (storeDao.queryStoreByUserID(store.getUserID()) != null) {
			storeDao.updateStore(store);
		} else {
			storeDao.addStore(store);
		}

		return new MsgBean(Code.SUCCESS, "申请提交成功", MsgLevel.NORMAL);
	}

	/**
	 * 检查店铺基本信息正确性
	 * 
	 * @param store
	 * @param oldStore
	 *            旧店铺，新注册则为null
	 * @return
	 */
	private MsgBean checkStoreInfo(Store store, Store oldStore) {
		// 验证域名
		if (StringUtil.isEmpty(store.getDomain()) || store.getDomain().length() < 4 || store.getDomain().length() > 16 || !store.getDomain().matches("^[A-Za-z0-9]*$")) {
			return new MsgBean(Code.FAIL, "域名只能为长度4-16的字母或数字！", MsgLevel.ERROR);
		} else {
			if (oldStore == null || !oldStore.getDomain().equalsIgnoreCase(store.getDomain())) {
				// 用户没有店铺或店铺新域名不等于原域名，进行重复检查
				Store storeDomainRepeat = storeDao.queryStoreByDomain(store.getDomain());
				if (storeDomainRepeat != null) {
					return new MsgBean(Code.FAIL, "域名已被注册使用！", MsgLevel.ERROR);
				}
			}
		}
		// 验证网店名
		if (StringUtil.isEmpty(store.getStoreName()) || store.getStoreName().length() > 18) {
			return new MsgBean(Code.FAIL, "请正确填写商店名称！", MsgLevel.ERROR);
		} else {
			if (oldStore == null || !oldStore.getStoreName().equalsIgnoreCase(store.getStoreName())) {
				// 用户没有店铺或店铺新名字不等于原名字，进行重复检查
				Store storeNameRepeat = storeDao.queryStoreByStoreName(store.getStoreName());
				if (storeNameRepeat != null) {
					return new MsgBean(Code.FAIL, "商店名称已被注册使用！", MsgLevel.ERROR);
				}
			}
		}
		// 验证城区
		if (StringUtil.isEmpty(store.getDistrict())) {
			return new MsgBean(Code.FAIL, "城区不能为空！", MsgLevel.ERROR);
		}
		// 验证具体地址
		if (StringUtil.isEmpty(store.getStreet())) {
			return new MsgBean(Code.FAIL, "具体地址不能为空！", MsgLevel.ERROR);
		}
		// 验证商圈
		if (!(VerifyUtil.isNumber(store.getBusinessArea() + ""))) {
			return new MsgBean(Code.FAIL, "请选择正确的商圈！", MsgLevel.ERROR);
		}
		// 验证供应商姓名
		if (StringUtil.isEmpty(store.getContactName())) {
			return new MsgBean(Code.FAIL, "联系人姓名称不能为空！", MsgLevel.ERROR);
		}
		// 验证电话号码
		if (!(VerifyUtil.phoneVerify(store.getPhone())) || store.getPhone().length() != 11) {
			return new MsgBean(Code.FAIL, "请输入正确的手机号码！", MsgLevel.ERROR);
		}
		// 验证QQ
		if (StringUtils.isNotBlank(store.getQQ())) {
			if (!VerifyUtil.isNumber(store.getQQ())) {
				return new MsgBean(Code.FAIL, "请输入正确的QQ！", MsgLevel.ERROR);
			}
		}
		return new MsgBean(Code.SUCCESS, "ok", MsgLevel.NORMAL);
	}

	@Override
	public MsgBean updateStoreBase(Store store) {
		store.setUserID(SessionHelper.getSessionUser().getUserID());
		Store storeOld = storeDao.queryStoreByUserID(store.getUserID());
		MsgBean checkResult = this.checkStoreInfo(store, storeOld);
		if (checkResult.getCode() != Code.SUCCESS) {
			return checkResult;
		}
		if (storeOld != null) {
			if (!storeOld.getDomain().equals(store.getDomain()) && storeOld.getDomainModify() > 0) {
				storeOld.setDomain(store.getDomain());
				storeOld.setDomainModify(storeOld.getDomainModify() - 1);
			}
			if (!storeOld.getStoreName().equals(store.getStoreName()) && storeOld.getStoreNameModify() > 0) {
				storeOld.setStoreNameModify(storeOld.getStoreNameModify() - 1);
				storeOld.setStoreName(store.getStoreName());
			}
			storeOld.setProvince(store.getProvince());
			storeOld.setCity(store.getCity());
			storeOld.setDistrict(store.getDistrict());
			storeOld.setStreet(store.getStreet());
			storeOld.setBusinessArea(store.getBusinessArea());
			storeOld.setContactName(store.getContactName());
			storeOld.setPhone(store.getPhone());
			storeOld.setQQ(store.getQQ());
			storeOld.setAliWangWang(store.getAliWangWang());
			storeDao.updateStore(storeOld);
		}
		return new MsgBean(Code.SUCCESS, "更新成功", MsgLevel.NORMAL);
	}

	@Override
	public void updateStoreDecorate(Store store) {
		Store storeOld = storeDao.queryStoreByUserID(store.getUserID());
		if (storeOld != null) {
			store.setID(storeOld.getID());
			if (StringUtils.isNotBlank(store.getLogoPath())) {
				storeOld.setLogoPath(store.getLogoPath());
			}
			if (StringUtils.isNotBlank(store.getSignagePath())) {
				storeOld.setSignagePath(store.getSignagePath());
			}
			// html 标签转义保存
			storeOld.setIntroduction(HtmlUtils.htmlEscape(store.getIntroduction()));
			storeDao.updateStore(storeOld);
		}
	}

	@Override
	public PageBean<Goods> queryStoreGoodsByPage(PageBean<Goods> page, int storeID) {
		List<Goods> list = storeDao.queryStoreGoodsByPage(page, storeID);
		page.setDatas(list);
		return page;
	}

	@Override
	public Store queryStoreByID(int storeID) {
		Store store = storeDao.queryStoreByID(storeID);
		if (store == null)
			return null;
		SessionUser loginUser = SessionHelper.getSessionUser();
		if (loginUser != null && store != null) {
			Favourite favourite = favouriteDao.queryFavourite(loginUser.getUserID(), storeID, FavouriteType.STORE.getValue());
			store.setIsFavourite(favourite == null ? 0 : 1);
		}
		GoodsCondition gc = new GoodsCondition();
		gc.setStoreId(store.getID());
		store.setCommodityOnSaleTotal(goodsService.queryStoreGoodsNum(gc));
		return store;
	}

	@Override
	public PageBean<Store> queryStoreByPage(PageBean<Store> page, Integer businessArea, String storeName) {
		page.setDatas(storeDao.queryStoreByPage(page, businessArea, storeName));
		return page;
	}

	@Override
	public void updateFullMemberFlg(int ID, int flg) {
		storeDao.updateFullMemberFlg(ID, flg);
	}

	@Override
	public List<Goods> queryStoreGoods(Map<String, Object> map) {
		return storeDao.queryStoreGoods(map);
	}

	@Override
	public Store getByID(Integer storeID) {
		return storeDao.queryStoreByID(storeID);
	}

	@Override
	public MsgBean updateApproveState(Integer status, Integer id) {
		// if (status == StoreApproveState.FAIL.getValue()) { // 审核不通过
		// int row =
		// storeDao.updateApproveState(StoreApproveState.FAIL.getValue(), id);
		// if (row != 1) {
		// throw new ServiceException(SystemConstants.DB_UPDATE_FAILED_MSG);
		// }
		// return new MsgBean(Code.SUCCESS, "店铺已更新为审核未通过", MsgLevel.NORMAL);
		// } else {
		int row = storeDao.updateApproveState(status, id);// 审核通过
		if (row != 1) {
			throw new ServiceException(SystemConstants.DB_UPDATE_FAILED_MSG);
		}
		Store store = storeDao.queryStoreByID(id);
		if (StoreApproveState.OPEN.getValue() == status) {
			// 修改用户类型
			int userRow = userDao.updateUserType(store.getUserID(), store.getSupplierType());
			if (userRow != 1) {
				throw new ServiceException(SystemConstants.DB_UPDATE_FAILED_MSG);
			}
			SMSUtil.sendMsg("你申请的店铺（" + store.getStoreName() + ")审核已通过并开启，请重新登录后开始使用，欢迎来到智谷同城货源网。", store.getPhone());
		}
		return new MsgBean(Code.SUCCESS, "店铺审核状态修改成功", MsgLevel.NORMAL);
		// }
	}

	@Override
	public List<Store> queryStoreByPage(PageBean<Store> page, Store store, String startDate, String endDate) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("store", store);
		param.put("startDate", startDate);
		param.put("endDate", endDate);

		page.setParas(param);
		return storeDao.queryStoreListByPage(page);
	}

	@Override
	public MsgBean updateRefreshDate() {
		SessionUser sessionUser = SessionHelper.getSessionUser();
		int userId = sessionUser.getUserID();
		Integer storeId = sessionUser.getStoreId();
		Date now = new Date();
		int refreshCount = goodsAndStoreRefreshMapper.countNum(DateUtil.format(now, DateUtil.yyyy_MM_dd), userId, null, storeId);
		int usableRefreshNum = GOODS_REFRESH_NUM_LIMIT - refreshCount;
		if (usableRefreshNum <= 0) {
			return new MsgBean(Code.FAIL, "已超过刷新次数限制", MsgLevel.ERROR);
		} else {
			GoodsAndStroeRefresh goodsRefresh = new GoodsAndStroeRefresh();
			goodsRefresh.setUserId(userId);
			goodsRefresh.setRefreshDate(now);
			goodsRefresh.setStoreId(storeId);

			goodsAndStoreRefreshMapper.insert(goodsRefresh);

			storeDao.updateStoreRefreshDateByStoreId(now, storeId);
			return new MsgBean(Code.SUCCESS, "刷新成功，今天还可刷新 " + (usableRefreshNum - 1) + " 次", MsgLevel.NORMAL);
		}
	}

}

package com.zhigu.service.goods;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import com.zhigu.model.DownloadHistory;
import com.zhigu.model.Goods;
import com.zhigu.model.GoodsAux;
import com.zhigu.model.GoodsCondition;
import com.zhigu.model.GoodsImage;
import com.zhigu.model.GoodsProperty;
import com.zhigu.model.GoodsSku;
import com.zhigu.model.PageBean;
import com.zhigu.model.dto.MsgBean;

/**
 * 商品服务
 * 
 * @author zhouqibing 2014年9月30日上午11:29:17
 */
public interface IGoodsService {
	/**
	 * 商品保存
	 * 
	 * @param goods
	 * @param skus
	 * @param properties
	 * @param images
	 * @return
	 * @throws IOException
	 */
	public MsgBean saveGoods(Goods goods, List<GoodsSku> skus, List<GoodsProperty> properties, List<GoodsImage> images);

	/**
	 * 修改商品
	 * 
	 * @param goods
	 * @param skus
	 * @param properties
	 * @param images
	 * @return
	 */
	public MsgBean updateGoods(Goods goods, List<GoodsSku> skus, List<GoodsProperty> properties, List<GoodsImage> images);

	/**
	 * 修改商品
	 * 
	 * @param goods
	 * @return
	 */
	public boolean updateGoods(Goods goods);

	/**
	 * 修改商品\店铺的刷新时间
	 * 
	 * @param goodsID
	 * @return
	 */
	public MsgBean updateGoodsRefreshDate(Integer goodsID);

	/**
	 * 修改商品删除标示 逻辑删除
	 * 
	 * @param goodsID
	 * @param deleteFlag
	 * @return
	 */
	public int updateGoodsDeleteFlagByGoodsID(Integer goodsID, boolean deleteFlag);

	/**
	 * 查询商品SKU
	 * 
	 * @param goodsId
	 * @return
	 */
	public List<GoodsSku> queryGoodsSkus(int goodsId);

	/**
	 * 查询商品
	 * 
	 * @param goodsId
	 * @return
	 */
	public Goods queryGoods(int goodsId);

	/**
	 * 查询商品
	 * 
	 * @param page
	 * @return
	 */
	public List<Goods> queryGoodsList(GoodsCondition gc, PageBean<Goods> page);

	/**
	 * 查询店铺的商品数量
	 * 
	 * @param gc
	 * @return
	 */
	public int queryStoreGoodsNum(GoodsCondition gc);

	/**
	 * 查询商品附属信息
	 * 
	 * @param goodsId
	 * @return
	 */
	public GoodsAux queryGoodsAux(int goodsId);

	/**
	 * 修改商品附属信息(全修改，需要先查询)
	 * 
	 * @param aux
	 * @return
	 */
	public boolean updateGoodsAux(GoodsAux aux);

	/**
	 * 下载历史
	 * 
	 * @param page
	 * @param goodsId
	 * @return
	 */
	public void queryDownloadHistory(PageBean<DownloadHistory> page, int goodsId);

	/**
	 * 正则查询商品名称集合
	 * 
	 * @param keyword
	 * @return 匹配的商品名称集合
	 */
	List<String> queryGoodsNames(String keyword);

	/**
	 * sku分类组合
	 * 
	 * @param goodsId
	 * @return
	 */
	Map<String, List<GoodsProperty>> queryGoodsSkuFromProperty(int goodsId);

	/**
	 * sku组合查询
	 * 
	 * @param goodsId
	 *            商品id
	 * @param sku1
	 *            idstr1
	 * @param sku2
	 *            idstr1
	 * @return
	 */
	List<GoodsSku> queryGoodsSkuByPropStr(int goodsId, String skuStr);

	/**
	 * 首页检索
	 * 
	 * @param propName
	 *            货号
	 * @param goodsName
	 *            商品名称
	 * @param page
	 *            分页
	 * @return
	 */
	PageBean<Goods> queryForHome(Integer pageNo, String propName, String goodsName, String city);

}

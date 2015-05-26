package com.zhigu.service.goods;

import java.util.List;
import java.util.Map;

import com.zhigu.model.GoodsEvaluate;
import com.zhigu.model.PageBean;
import com.zhigu.model.dto.MsgBean;

/**
 * 商品评论
 * 
 * @author zhouqibing 2014年11月7日上午9:37:05
 */
public interface IGoodsEvaluateService {
	/**
	 * 保存商品评论：查询订单详情，根据isEvaluate判断是否已评过，并判断是否是当前用户
	 * 
	 * @param orderDetailId
	 *            订单详情id
	 * @param score
	 *            分数
	 * @param content
	 *            内容，最大200字
	 * @return
	 */
	MsgBean saveGoodsEvaluate(Integer orderDetailId, Integer score, String content);

	/**
	 * 查询商品评论
	 * 
	 * @param page
	 * @param goodsId
	 * @param userId
	 * @param minScore
	 * @param maxScore
	 * @return
	 */
	List<GoodsEvaluate> queryGoodsEvaluatesByPage(PageBean<GoodsEvaluate> page, Integer goodsId, Integer commentType);

	/**
	 * 评论统计
	 * 
	 * @param goodsId
	 *            商品id
	 * @return
	 */
	Map<String, Integer> countCommentsByScore(int goodsId);

	/**
	 * 商家回复
	 * 
	 * @param reply
	 *            回复类容 (最多200个字符)
	 * @param id
	 *            评论的id
	 * @return
	 */
	int addMerchantReply(String reply, Long id);

	/**
	 * 根据评论id 查询评论
	 * 
	 * @param id
	 * @return
	 */
	GoodsEvaluate queryGoodsEvaluatesById(Long id);
}

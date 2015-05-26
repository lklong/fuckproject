package com.zhigu.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.zhigu.model.GoodsEvaluate;
import com.zhigu.model.PageBean;

public interface GoodsEvaluateMapper {
	int deleteByPrimaryKey(Long id);

	int insertSelective(GoodsEvaluate record);

	GoodsEvaluate selectByPrimaryKey(Long id);

	/**
	 * 获取商品的评论列表
	 * 
	 * @param page
	 *            分页
	 * @param goodsId
	 *            商品ID
	 * @param score
	 *            评论的类型（此处指：好评（1），中评（2），差评（3））
	 * @return
	 */
	List<GoodsEvaluate> queryGoodsEvaluatesByPage(@Param("page") PageBean<GoodsEvaluate> page, @Param("goodsId") Integer goodsId, @Param("type") Integer type);

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
	 *            回复类容
	 * @param id
	 *            评论的id
	 * @return
	 */
	int addMerchantReply(@Param("reply") String reply, @Param("id") Long id);
}
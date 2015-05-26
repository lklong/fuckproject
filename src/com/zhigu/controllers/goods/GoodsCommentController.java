/**
 * @ClassName: GoodsCommentController.java
 * @Author: liukailong
 * @Description: 
 * @Date: 2015年5月12日
 * 
 */
package com.zhigu.controllers.goods;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.SessionUser;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.enumconst.CommentType;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.common.utils.DateUtil;
import com.zhigu.model.Goods;
import com.zhigu.model.GoodsEvaluate;
import com.zhigu.model.PageBean;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.goods.IGoodsEvaluateService;
import com.zhigu.service.goods.IGoodsService;
import com.zhigu.service.store.IStoreService;

/**
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/goods")
public class GoodsCommentController {
	@Autowired
	private IGoodsService goodsService;
	@Autowired
	private IStoreService storeService;
	@Autowired
	private IGoodsEvaluateService goodsEvaluateService;

	/**
	 * 加载评论列表
	 * 
	 * @param page
	 *            分页
	 * @param goodsId
	 *            商品ID
	 * @param score
	 *            评分
	 * @param mv
	 * @return
	 */
	@RequestMapping("/ajax/comments")
	public String queryComments(PageBean<GoodsEvaluate> page, @RequestParam(defaultValue = "all") String commentType, Integer goodsId, ModelMap model) {

		Integer type = 0;
		// 评论等级检查
		if (commentType.equals(CommentType.All.getType())) {
			type = CommentType.All.getNum();
		} else if (commentType.equals(CommentType.Medium.getType())) {
			type = CommentType.Medium.getNum();
		} else if (commentType.equals(CommentType.Good.getType())) {
			type = CommentType.Good.getNum();
		} else if (commentType.equals(CommentType.Bad.getType())) {
			type = CommentType.Bad.getNum();
		}

		// 评论集合
		page.setPageSize(5);
		List<GoodsEvaluate> list = goodsEvaluateService.queryGoodsEvaluatesByPage(page, goodsId, type);
		page.setDatas(list);

		// 用户
		SessionUser user = SessionHelper.getSessionUser();
		Goods goods = goodsService.queryGoods(goodsId);
		int canReply = 0;

		// 判断此商品书否属于当前用户
		if (user != null && goods != null) {
			if (user.getStoreId() == goods.getStoreId()) {
				canReply = 1;
			}
		}

		// 评论统计
		Map<String, Integer> commentCountMap = goodsEvaluateService.countCommentsByScore(goodsId);

		model.addAttribute("commentCountMap", commentCountMap);
		model.addAttribute("page", page);
		model.addAttribute("goodsId", goodsId);
		model.addAttribute("type", commentType);
		model.addAttribute("canReply", canReply);

		return "goods/goods/comments";
	}

	/**
	 * 商家回复处理
	 * 
	 * @param reply
	 * @param id
	 * @return
	 */
	@RequestMapping("/ajax/comment/reply")
	@ResponseBody
	public MsgBean addMerchantReply(String reply, long id) {

		int num = goodsEvaluateService.addMerchantReply(reply, id);
		if (num < 1) {
			return new MsgBean(Code.FAIL, "回复失败，请稍后重试", MsgLevel.ERROR);
		}
		MsgBean msgBean = new MsgBean(Code.SUCCESS, "", MsgLevel.NORMAL);
		GoodsEvaluate evaluate = goodsEvaluateService.queryGoodsEvaluatesById(id);
		String replyTime = DateUtil.format(evaluate.getReplyTime(), "yyyy-MM-dd HH:mm:ss");
		msgBean.setData(replyTime);
		return msgBean;
	}

	/**
	 * 添加评论
	 * 
	 * @param orderDetailId
	 *            商品详情ID
	 * @param score
	 *            评分
	 * @param content
	 *            评价内容
	 * @return
	 */
	@RequestMapping(value = "/ajax/post/comment", method = RequestMethod.POST)
	@ResponseBody
	public MsgBean addEvaluate(Integer orderDetailId, Integer score, String content) {
		return goodsEvaluateService.saveGoodsEvaluate(orderDetailId, score, content);
	}

}

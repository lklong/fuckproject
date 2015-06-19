package com.zhigu.controllers.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.model.GoodsComplaint;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.goods.IGoodsComplaintService;
import com.zhigu.service.goods.IGoodsEvaluateService;

/**
 * 商品投诉
 * 
 * @author zhouqibing 2014年11月6日下午2:43:55
 */
@Controller("userGoodsController")
@RequestMapping("/user/goods")
public class GoodsController {

	@Autowired
	private IGoodsComplaintService goodsComplaintService;
	@Autowired
	private IGoodsEvaluateService goodsEvaluateService;

	/**
	 * 保存商品投诉
	 * 
	 * @param gc
	 * @return
	 */
	@RequestMapping("/complaint")
	@ResponseBody
	public MsgBean complaint(GoodsComplaint gc) {
		gc.setUserId(SessionHelper.getSessionUser().getUserId());
		gc.setStatus(1);
		int result = goodsComplaintService.saveGoodsComplaint(gc);
		if (result == 1)
			return new MsgBean(Code.FAIL, "你已提交过该商品的投诉信息", MsgLevel.WARNING);
		if (result == 2)
			return new MsgBean(Code.FAIL, "你未购买过该商品，不能提交投诉", MsgLevel.WARNING);

		return new MsgBean(Code.SUCCESS, "投诉信息已提交", MsgLevel.NORMAL);
	}

}

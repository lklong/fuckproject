package com.zhigu.controllers.mobile.user;

import java.math.BigDecimal;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.SequenceConstant;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.common.utils.Sequence;
import com.zhigu.common.utils.VerifyUtil;
import com.zhigu.model.RechargeRecord;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.user.IAccountService;

/**
 * 用户充值
 * 
 * @author HeSiMin
 * @date 2014年10月13日
 *
 */
@Controller
@RequestMapping("/mobile/user/recharge")
public class MobileRechargeController {
	@Autowired
	private IAccountService accountService;

	/**
	 * 生成充值记录
	 * 
	 * @param payType
	 * @param money
	 * @return
	 */
	@RequestMapping("/create")
	@ResponseBody
	public MsgBean create(int payType, String money) {
		MsgBean msg = new MsgBean();
		if (!VerifyUtil.isMoney(money)) {
			msg.setMsgBean(Code.FAIL, "充值金额填写错误！", MsgLevel.ERROR);
			return msg;
		}
		// 保存充值记录
		RechargeRecord rechargeRecord = new RechargeRecord();
		rechargeRecord.setRechargeMoney(new BigDecimal(money));
		rechargeRecord.setUserId(SessionHelper.getSessionUser().getUserID());
		rechargeRecord.setRechargeTime(new Date());
		rechargeRecord.setOperator(SessionHelper.getSessionUser().getUserID());
		rechargeRecord.setType(payType);
		rechargeRecord.setPaymentNo(Sequence.generateSeq(SequenceConstant.FLOW));
		accountService.saveRechargeRecord(rechargeRecord);
		msg.setData(rechargeRecord);
		msg.setMsgBean(Code.SUCCESS, "充值订单已生成！", MsgLevel.NORMAL);
		return msg;
	}
}

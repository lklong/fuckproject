package com.zhigu.service.user.impl;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.constant.CRSAuditStatus;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.enumconst.AuthStatus;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.mapper.RealUserAuthMapper;
import com.zhigu.mapper.UserMapper;
import com.zhigu.model.RealUserAuth;
import com.zhigu.model.UserInfo;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.user.IRealUserAuthService;

@Service
public class RealUserAuthServiceImpl implements IRealUserAuthService {

	@Autowired
	private RealUserAuthMapper realUserAuthMapper;

	@Autowired
	private UserMapper userMapper;

	@Override
	public RealUserAuth queryRealUserAuth(int userID) {
		return realUserAuthMapper.queryRealUserAuthByUserID(userID);
	}

	@Override
	public MsgBean saveRealUserAuth(RealUserAuth realUserAuth) {

		int adminID = SessionHelper.getSessionAdmin().getId();
		Date now = new Date();
		String msg = "";

		UserInfo user = userMapper.queryUserInfoById(realUserAuth.getUserId());

		if (user != null) {
			RealUserAuth newRealUserAuth = new RealUserAuth();
			newRealUserAuth.setUserId(user.getUserID());
			newRealUserAuth.setRealName(realUserAuth.getRealName());
			newRealUserAuth.setIdCard(realUserAuth.getIdCard());
			newRealUserAuth.setCardValidity(realUserAuth.getPerpetualFlag() ? null : realUserAuth.getCardValidity());
			newRealUserAuth.setPerpetualFlag(realUserAuth.getPerpetualFlag());
			newRealUserAuth.setCardFrontImg(realUserAuth.getCardFrontImg());
			newRealUserAuth.setAddAdminId(adminID);
			newRealUserAuth.setAddTime(now);
			newRealUserAuth.setStatus(CRSAuditStatus.STATUS_PENDING_REVIEW);

			if (user.getRealUserAuthFlg() == CRSAuditStatus.STATUS_NOPASS) {
				realUserAuthMapper.updateRealUserAuth(newRealUserAuth);
				msg = "修改成功！";
			} else {
				RealUserAuth ra = realUserAuthMapper.queryRealUserAuthByIdcard(newRealUserAuth.getIdCard().trim());
				if (ra != null && ra.getStatus() == AuthStatus.PASS.getValue()) {
					return new MsgBean(Code.FAIL, "该身份证已用于其他账户认证！", MsgLevel.ERROR);
				}
				realUserAuthMapper.saveRealUserAuth(newRealUserAuth);
				msg = "保存成功！";
			}
			userMapper.updateUserInfoRealUserFlg(user.getUserID(), CRSAuditStatus.STATUS_PENDING_REVIEW);

			return new MsgBean(Code.SUCCESS, msg, MsgLevel.NORMAL);
		} else {
			return new MsgBean(Code.FAIL, "系统出错了！", MsgLevel.ERROR);
		}

	}

	@Override
	public RealUserAuth queryRealUserAuthByIdcard(String idcard) {
		return realUserAuthMapper.queryRealUserAuthByIdcard(idcard);
	}

	@Override
	public MsgBean updateRealUserAuthStatus(Integer userID, Integer status, String rejectReason) {
		if (status == CRSAuditStatus.STATUS_NOPASS && rejectReason.length() == 0) {
			return new MsgBean(Code.FAIL, "请输入审核不通过的原因！", MsgLevel.WARNING);
		}

		int adminID = SessionHelper.getSessionAdmin().getId();
		Date now = new Date();
		UserInfo user = userMapper.queryUserInfoById(userID);

		int row = realUserAuthMapper.updateRealUserAuthStatus(status, adminID, now, rejectReason, user.getUserID());

		if (row != 1) {
			return new MsgBean(Code.FAIL, "审核成功！", MsgLevel.ERROR);
		}

		userMapper.updateUserInfoRealUserFlg(user.getUserID(), status);

		return new MsgBean(Code.SUCCESS, "审核成功！", MsgLevel.NORMAL);
	}

}

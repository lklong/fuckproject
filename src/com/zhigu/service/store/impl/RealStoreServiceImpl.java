package com.zhigu.service.store.impl;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.constant.CRSAuditStatus;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.mapper.RealStoreAuthMapper;
import com.zhigu.mapper.StoreMapper;
import com.zhigu.model.RealStoreAuth;
import com.zhigu.model.Store;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.store.IRealStoreAuthService;

/**
 * 实地认证业务逻辑实现类
 * 
 * @author Y.Z.X
 * @since 2015-06-04
 */
@Service
public class RealStoreServiceImpl implements IRealStoreAuthService {

	@Autowired
	private RealStoreAuthMapper realStoreAuthDao;

	@Autowired
	private StoreMapper storeDao;

	@Override
	public RealStoreAuth queryRealStoreAuthByStoreID(int storeID) {
		return realStoreAuthDao.queryRealStoreAuthByStoreID(storeID);
	}

	@Override
	public RealStoreAuth queryRealStoreAuthByUserID(int userID) {
		return realStoreAuthDao.queryRealStoreAuthByUserID(userID);
	}

	@Override
	public MsgBean saveRealStoreAuth(RealStoreAuth realStoreAuth, int storeID) {

		int userID = SessionHelper.getSessionAdmin().getId();
		Store store = storeDao.queryStoreByID(storeID);

		if (store != null) {
			RealStoreAuth newRealStoreAuth = new RealStoreAuth();
			newRealStoreAuth.setStoreID(store.getID());
			newRealStoreAuth.setRealStoreName(realStoreAuth.getRealStoreName());
			newRealStoreAuth.setMaster(realStoreAuth.getMaster());
			newRealStoreAuth.setPhone(realStoreAuth.getPhone());
			newRealStoreAuth.setRealStoreAddress(realStoreAuth.getRealStoreAddress());
			newRealStoreAuth.setStatus(CRSAuditStatus.STATUS_PENDING_REVIEW);
			newRealStoreAuth.setImage1(realStoreAuth.getImage1());
			newRealStoreAuth.setImage2(realStoreAuth.getImage2());
			newRealStoreAuth.setImage3(realStoreAuth.getImage3());
			newRealStoreAuth.setSalesman(userID);
			newRealStoreAuth.setApplyTime(new Date());

			if (store.getRealStoreAuth() == CRSAuditStatus.STATUS_NOPASS) {
				realStoreAuthDao.updateRealStoreAuth(newRealStoreAuth, store.getID());

				storeDao.updateRealStoreAuthState(CRSAuditStatus.STATUS_PENDING_REVIEW, store.getID());

				return new MsgBean(Code.SUCCESS, "修改成功！", MsgLevel.NORMAL);

			} else {

				realStoreAuthDao.addRealStoreAuth(newRealStoreAuth);

				storeDao.updateRealStoreAuthState(CRSAuditStatus.STATUS_PENDING_REVIEW, store.getID());

				return new MsgBean(Code.SUCCESS, "保存成功！", MsgLevel.NORMAL);
			}
		} else {
			return new MsgBean(Code.FAIL, "保存失败！", MsgLevel.ERROR);
		}
	}

	@Override
	public MsgBean updateRealStoreAuthStatus(String rejectReason, Integer status, Integer storeID) {

		if (status == CRSAuditStatus.STATUS_NOPASS && rejectReason.length() == 0) {
			return new MsgBean(Code.FAIL, "请输入审核不通过的原因！", MsgLevel.WARNING);
		}

		int userID = SessionHelper.getSessionAdmin().getId();

		Store store = storeDao.queryStoreByID(storeID);

		RealStoreAuth realStoreAuth = realStoreAuthDao.queryRealStoreAuthByStoreID(storeID);

		realStoreAuth.setStatus(status);
		realStoreAuth.setApproveUser(userID);
		realStoreAuth.setRejectReason(rejectReason);
		realStoreAuth.setAuthTime(new Date());

		int count = realStoreAuthDao.updateRealStoreAuth(realStoreAuth, store.getID());
		if (count != 1) {
			return new MsgBean(Code.FAIL, "审核出错，请重试！", MsgLevel.ERROR);
		}
		storeDao.updateRealStoreAuthState(status, store.getID());
		return new MsgBean(Code.SUCCESS, "审核成功！", MsgLevel.NORMAL);
	}

}

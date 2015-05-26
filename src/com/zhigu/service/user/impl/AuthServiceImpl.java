package com.zhigu.service.user.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhigu.common.constant.Flg;
import com.zhigu.common.constant.enumconst.AuthStatus;
import com.zhigu.mapper.CompanyAuthMapper;
import com.zhigu.mapper.RealStoreAuthMapper;
import com.zhigu.mapper.StoreMapper;
import com.zhigu.model.CompanyAuth;
import com.zhigu.model.PageBean;
import com.zhigu.model.RealStoreAuth;
import com.zhigu.model.Store;
import com.zhigu.service.user.IAuthService;

@Service
public class AuthServiceImpl implements IAuthService {
	@Autowired
	private CompanyAuthMapper companyAuthDao;
	@Autowired
	private RealStoreAuthMapper realStoreAuthDao;
	@Autowired
	private StoreMapper storeDao;

	@Override
	public List<CompanyAuth> queryCompanyAuthByPage(PageBean page) {
		return companyAuthDao.queryCompanyAuthByPage(page);
	}

	@Override
	public CompanyAuth queryCompanyAuthByUserID(int userID) {
		return companyAuthDao.queryCompanyAuthByUserID(userID);
	}

	@Override
	public void updateCompanyAuthByUserID(CompanyAuth companyAuth) {
		CompanyAuth companyAuthOld = companyAuthDao.queryCompanyAuthByUserID(companyAuth.getUserID());
		companyAuthOld.setApproveState(companyAuth.getApproveState());
		companyAuthOld.setApproveUser(companyAuth.getApproveUser());
		companyAuthOld.setRejectReason(companyAuth.getRejectReason());
		companyAuthOld.setAuthTime(companyAuth.getAuthTime());
		// companyAuthDao.updateCompanyAuth(companyAuthOld);
		// 修改店铺上的认证信息
		if (companyAuth.getApproveState() == AuthStatus.PASS.getValue()) {
			Store store = storeDao.queryStoreByUserID(companyAuth.getUserID());
			store.setCompanyAuth(Flg.ON);
			storeDao.updateStore(store);
		}
	}

	@Override
	public RealStoreAuth queryRealStoreAuthByUserID(int userID) {
		return realStoreAuthDao.queryRealStoreAuthByUserID(userID);
	}

	@Override
	public void updateRealStoreAuthByUserID(RealStoreAuth realStoreAuth) {
		RealStoreAuth realStoreAuthOld = realStoreAuthDao.queryRealStoreAuthByUserID(realStoreAuth.getUserID());
		realStoreAuthOld.setApproveState(realStoreAuth.getApproveState());
		realStoreAuthOld.setApproveUser(realStoreAuth.getApproveUser());
		realStoreAuthOld.setRejectReason(realStoreAuth.getRejectReason());
		// realStoreAuthDao.updateRealStoreAuth(realStoreAuthOld);
		// 修改店铺上的认证信息
		if (realStoreAuth.getApproveState() == AuthStatus.PASS.getValue()) {
			Store store = storeDao.queryStoreByUserID(realStoreAuth.getUserID());
			store.setRealStoreAuth(Flg.ON);
			storeDao.updateStore(store);
		}
	}

}

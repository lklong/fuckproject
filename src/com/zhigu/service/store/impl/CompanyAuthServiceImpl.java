package com.zhigu.service.store.impl;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.constant.CRSAuditStatus;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.mapper.CompanyAuthMapper;
import com.zhigu.mapper.StoreMapper;
import com.zhigu.model.CompanyAuth;
import com.zhigu.model.Store;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.store.ICompanyAuthService;

/**
 * 企业认证业务逻辑实现类
 * 
 * @author Y.Z.X
 * @since 2015-06-04
 */
@Service
public class CompanyAuthServiceImpl implements ICompanyAuthService {

	@Autowired
	private CompanyAuthMapper companyAuthMapper;

	@Autowired
	private StoreMapper storeMapper;

	@Override
	public CompanyAuth queryCompanyAuthByStoreID(int storeID) {
		return companyAuthMapper.queryCompanyAuthByStoreID(storeID);
	}

	@Override
	public CompanyAuth queryCompanyAuthByUserID(int userID) {
		return companyAuthMapper.queryCompanyAuthByUserID(userID);
	}

	@Override
	public MsgBean saveCompanyAuth(CompanyAuth companyAuth, int storeID) {

		int userID = SessionHelper.getSessionAdmin().getId();
		Store store = storeMapper.queryStoreByID(storeID);

		if (store != null) {
			CompanyAuth newCompanyAuth = new CompanyAuth();
			newCompanyAuth.setStoreID(store.getID());
			newCompanyAuth.setSalesman(userID);
			newCompanyAuth.setCompanyName(companyAuth.getCompanyName());
			newCompanyAuth.setCompanyType(companyAuth.getCompanyType());
			newCompanyAuth.setRegNumber(companyAuth.getRegNumber());
			newCompanyAuth.setCorporation(companyAuth.getCorporation());
			newCompanyAuth.setBusinessTerm(companyAuth.getBusinessTerm());
			newCompanyAuth.setCapital(companyAuth.getCapital());
			newCompanyAuth.setBusinessScope(companyAuth.getBusinessScope());
			newCompanyAuth.setRegProvince(companyAuth.getRegProvince());
			newCompanyAuth.setRegCity(companyAuth.getRegCity());
			newCompanyAuth.setRegDistrict(companyAuth.getRegDistrict());
			newCompanyAuth.setRegStreet(companyAuth.getRegStreet());
			newCompanyAuth.setCompanyProvince(companyAuth.getCompanyProvince());
			newCompanyAuth.setCompanyCity(companyAuth.getCompanyCity());
			newCompanyAuth.setCompanyDistrict(companyAuth.getCompanyDistrict());
			newCompanyAuth.setCompanyStreet(companyAuth.getCompanyStreet());
			newCompanyAuth.setApplyTime(new Date());
			newCompanyAuth.setStatus(CRSAuditStatus.STATUS_PENDING_REVIEW);
			newCompanyAuth.setImage(companyAuth.getImage());

			if (store.getCompanyAuth() == CRSAuditStatus.STATUS_NOPASS) {
				companyAuthMapper.updateCompanyAuth(newCompanyAuth, store.getID());

				storeMapper.updateCompanyAuthState(CRSAuditStatus.STATUS_PENDING_REVIEW, store.getID());

				return new MsgBean(Code.SUCCESS, "修改成功！", MsgLevel.NORMAL);

			} else {

				companyAuthMapper.addCompanyAuth(newCompanyAuth);

				storeMapper.updateCompanyAuthState(CRSAuditStatus.STATUS_PENDING_REVIEW, store.getID());

				return new MsgBean(Code.SUCCESS, "保存成功！", MsgLevel.NORMAL);
			}

		} else {
			return new MsgBean(Code.FAIL, "保存失败！", MsgLevel.ERROR);
		}
	}

	@Override
	public MsgBean updateCompanyAuthStatus(String rejectReason, Integer status, Integer storeID) {

		if (status == CRSAuditStatus.STATUS_NOPASS && rejectReason.length() == 0) {
			return new MsgBean(Code.FAIL, "请输入审核不通过的原因！", MsgLevel.WARNING);
		}

		int userID = SessionHelper.getSessionAdmin().getId();

		Store store = storeMapper.queryStoreByID(storeID);

		CompanyAuth companyAuth = companyAuthMapper.queryCompanyAuthByStoreID(storeID);

		companyAuth.setStatus(status);
		companyAuth.setApproveUser(userID);
		companyAuth.setAuthTime(new Date());
		companyAuth.setRejectReason(rejectReason);

		int count = companyAuthMapper.updateCompanyAuth(companyAuth, store.getID());
		if (count != 1) {
			return new MsgBean(Code.FAIL, "审核出错，请重试！", MsgLevel.ERROR);
		}
		storeMapper.updateCompanyAuthState(status, store.getID());

		return new MsgBean(Code.SUCCESS, "审核成功！", MsgLevel.NORMAL);
	}

}

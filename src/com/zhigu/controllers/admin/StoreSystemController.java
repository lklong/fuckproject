package com.zhigu.controllers.admin;

import java.io.IOException;
import java.text.ParseException;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zhigu.common.constant.BusinessArea;
import com.zhigu.common.constant.enumconst.StoreApproveState;
import com.zhigu.model.CompanyAuth;
import com.zhigu.model.PageBean;
import com.zhigu.model.RealStoreAuth;
import com.zhigu.model.Store;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.admin.IAdminService;
import com.zhigu.service.store.ICompanyAuthService;
import com.zhigu.service.store.IRealStoreAuthService;
import com.zhigu.service.store.IStoreService;

/**
 * 店铺管理
 * 
 * @author Y.Z.X
 * @since 2015-04-16
 */
@Controller("storeSystemController")
@RequestMapping("/admin/store")
public class StoreSystemController {

	@Autowired
	private IStoreService storeService;

	@Autowired
	public IAdminService adminService;

	@Autowired
	public IRealStoreAuthService realStoreAuthService;

	@Autowired
	public ICompanyAuthService companyAuthService;

	/**
	 * 店铺列表
	 * 
	 * @return
	 */
	@RequestMapping("/index")
	public ModelAndView index(PageBean<Store> page, Store store, String startDate, String endDate, ModelAndView mav) {
		page.setPageNo(page.getPageNo());

		page.setDatas(storeService.queryStoreByPage(page, store, startDate, endDate));

		mav.addObject("businessArea", BusinessArea.values());
		mav.addObject("storeApproveState", StoreApproveState.values());
		mav.addObject("page", page);
		mav.addObject("store", store);
		mav.addObject("startDate", startDate);
		mav.addObject("endDate", endDate);
		mav.setViewName("admin/store/index");
		return mav;
	}

	/**
	 * 店铺审核
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping("/updateStroeAuditStatus")
	@ResponseBody
	public MsgBean updateStroeAuditStatus(Integer id, Integer status) {
		return storeService.updateApproveState(StoreApproveState.OPEN.getValue(), id);
	}

	/**
	 * 跳转到企业认证页面
	 * 
	 * @param mav
	 * @param storeID
	 *            店铺ID
	 * @return
	 */
	@RequestMapping("/company/inner_info")
	public ModelAndView realUserAuthInfo(ModelAndView mav, int storeID) {

		mav.addObject("companyAuth", companyAuthService.queryCompanyAuthByStoreID(storeID));
		mav.addObject("storeID", storeID);

		mav.setViewName("admin/store/inner_storeCompanyAuthInfo");
		return mav;
	}

	/**
	 * 保存企业认证
	 * 
	 * @param mav
	 * @return
	 * @throws ParseException
	 * @throws IOException
	 */
	@RequestMapping("/saveCompanyAuth")
	@ResponseBody
	public MsgBean saveCompanyAuth(CompanyAuth companyAuth, String dateStr, int storeID) throws ParseException {
		if (StringUtils.isNotBlank(dateStr))
			companyAuth.setBusinessTerm(DateUtils.parseDate(dateStr, "yyyy-MM-dd"));
		return companyAuthService.saveCompanyAuth(companyAuth, storeID);
	}

	/**
	 * 跳转到实体认证信息页面
	 *
	 * @param mv
	 * @param userID
	 * @return
	 */
	@RequestMapping("/realStore/inner_info")
	public ModelAndView realStoreAuthInfo(ModelAndView mav, int storeID) {

		mav.addObject("realStoreAuth", realStoreAuthService.queryRealStoreAuthByStoreID(storeID));
		mav.addObject("storeID", storeID);

		mav.setViewName("admin/store/inner_storeRealStoreAuthInfo");
		return mav;
	}

	/**
	 * 保存实体认证信息
	 * 
	 * @param realStoreAuth
	 *            界面录入的信息
	 * @param storeID
	 *            店铺ID
	 * @return
	 */
	@RequestMapping("/seveRealStoreAuth")
	@ResponseBody
	public MsgBean seveRealStoreAuthInfo(RealStoreAuth realStoreAuth, int storeID) {
		return realStoreAuthService.saveRealStoreAuth(realStoreAuth, storeID);
	}

	/**
	 * 跳转到审核企业认证信息页面
	 * 
	 * @param storeID
	 * @return
	 */
	@RequestMapping("/company/skipCompanyAuthStatus")
	public ModelAndView skipCompanyAuthStatus(int storeID) {
		ModelAndView mav = new ModelAndView();
		CompanyAuth companyAuth = companyAuthService.queryCompanyAuthByStoreID(storeID);

		mav.addObject("companyAuth", companyAuth);

		if (companyAuth.getSalesman() != 0) {
			mav.addObject("salesman", adminService.queryAdminById(companyAuth.getSalesman()));
		}

		mav.addObject("storeID", storeID);

		mav.setViewName("admin/store/companyAuthStatus");
		return mav;
	}

	/**
	 * 更新企业认证信息状态
	 * 
	 * @param rejectReason
	 *            不通过的原因
	 * @param status
	 *            0:不通过 1:通过
	 * @return
	 */
	@RequestMapping("/updateCompanyAuthStatus")
	@ResponseBody
	public MsgBean updateCompanyAuthStatus(String rejectReason, Integer status, Integer storeID) {
		return companyAuthService.updateCompanyAuthStatus(rejectReason, status, storeID);
	}

	/**
	 * 跳转到审核实体认证信息页面
	 * 
	 * @param storeID
	 * @return
	 */
	@RequestMapping("/realStore/skipRealStoreAuthStatus")
	public ModelAndView skipRealStoreAuthStatus(int storeID) {
		ModelAndView mav = new ModelAndView();
		RealStoreAuth realStoreAuth = realStoreAuthService.queryRealStoreAuthByStoreID(storeID);

		mav.addObject("realStoreAuth", realStoreAuth);

		if (realStoreAuth.getSalesman() != 0) {
			mav.addObject("salesman", adminService.queryAdminById(realStoreAuth.getSalesman()));
		}

		mav.addObject("storeID", storeID);

		mav.setViewName("admin/store/realStoreAuthStatus");
		return mav;
	}

	/**
	 * 更新实体认证信息状态
	 * 
	 * @param rejectReason
	 *            不通过的原因
	 * @param status
	 *            0:不通过 1:通过
	 * @return
	 */
	@RequestMapping("/updateRealStoreAuthStatus")
	@ResponseBody
	public MsgBean updateRealStoreAuthStatus(String rejectReason, Integer status, Integer storeID) {
		return realStoreAuthService.updateRealStoreAuthStatus(rejectReason, status, storeID);
	}

	/**
	 * 查看店铺详情
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping("/showInfo")
	public ModelAndView showInfo(int id) {
		ModelAndView mav = new ModelAndView();

		Store store = storeService.getByID(id);

		mav.addObject("store", store);

		CompanyAuth companyAuth = companyAuthService.queryCompanyAuthByStoreID(store.getID());
		mav.addObject("companyAuth", companyAuth);
		if (companyAuth != null) {
			if (companyAuth.getSalesman() != 0)
				mav.addObject("caSaleSman", adminService.queryAdminById(companyAuth.getSalesman())); // 业务员

			if (companyAuth.getApproveUser() != 0)
				mav.addObject("caApproveUser", adminService.queryAdminById(companyAuth.getApproveUser())); // 审核者
		}

		RealStoreAuth realStoreAuth = realStoreAuthService.queryRealStoreAuthByStoreID(store.getID());
		mav.addObject("realStoreAuth", realStoreAuth);
		if (realStoreAuth != null) {
			if (realStoreAuth.getSalesman() != 0)
				mav.addObject("rsSaleSman", adminService.queryAdminById(realStoreAuth.getSalesman())); // 业务员

			if (realStoreAuth.getApproveUser() != 0)
				mav.addObject("rsApproveUser", adminService.queryAdminById(realStoreAuth.getApproveUser())); // 审核者
		}
		mav.setViewName("admin/store/info");

		return mav;
	}
}

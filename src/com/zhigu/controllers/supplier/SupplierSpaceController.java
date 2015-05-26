package com.zhigu.controllers.supplier;

import java.util.List;

import net.sf.json.JSONObject;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.common.constant.enumconst.UserFileType;
import com.zhigu.common.utils.ServiceMsg;
import com.zhigu.dto.TreeBean;
import com.zhigu.model.PageBean;
import com.zhigu.model.UserFile;
import com.zhigu.model.UserFolder;
import com.zhigu.model.UserInfo;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.user.IUserSpaceService;

/**
 * 图片空间
 * 
 * @author HeSiMin
 * @date 2014年9月25日
 *
 */
@Controller
@RequestMapping("/supplier/space")
public class SupplierSpaceController {
	private Logger logger = LogManager.getLogger(SupplierSpaceController.class);
	@Autowired
	private IUserSpaceService userSpaceService;

	// @RequestMapping("/show")
	// public ModelAndView show(ModelAndView mv, PageBean<UserFile> page,
	// Integer folderID) {
	// mv.setViewName("supplier/userspace/space");
	// // 文件夹数据
	// int userID = SessionHelper.getSessionUser().getUserID();
	// List<UserFolder> folders = userSpaceService.queryFolderByUserID(userID);
	// mv.addObject("userFolders", folders);
	// if (folders != null && !folders.isEmpty()) {
	// // 没有传文件夹ID取默认文件夹
	// if (folderID == null) {
	// for (UserFolder uf : folders) {
	// if (uf.getIsDefault() == Flg.ON) {
	// folderID = uf.getFolderID();
	// break;
	// }
	// }
	// }
	// mv.addObject("curFolderID", folderID);
	// // 文件数据
	// page.addParas("userID", userID);
	// page.addParas("folderID", folderID);
	// page.addParas("type", UserFileType.IMAGE.getValue());
	// page.setPageSize(10);
	// userSpaceService.queryFileByPage(page);
	// }
	// mv.addObject("page", page);
	// return mv;
	// }

	/**
	 * 用户文件夹树形结构
	 * 
	 * @return (zTree数据)
	 */
	@RequestMapping("/folderTree")
	@ResponseBody
	public TreeBean[] folderTree() {
		// 文件夹数据
		int userID = SessionHelper.getSessionUser().getUserID();
		List<UserFolder> folders = userSpaceService.queryFolderByUserID(userID);
		TreeBean[] ts = new TreeBean[folders.size()];
		for (int i = 0; i < folders.size(); i++) {
			UserFolder temp = folders.get(i);
			ts[i] = new TreeBean(temp.getFolderID(), 0, temp.getFolderName());
		}
		return ts;
	}

	/**
	 * 用户空间
	 * 
	 * @return
	 */
	@RequestMapping("/space")
	public ModelAndView space(ModelAndView mv, PageBean<UserFile> page, Integer folderID) {
		mv.setViewName("supplier/userspace/space");
		UserInfo userInfo = userSpaceService.queryUserSpaceSize(SessionHelper.getSessionUser().getUserID());
		mv.addObject("userInfo", userInfo);
		return mv;
	}

	/**
	 * 文件夹文件
	 * 
	 * @return
	 */
	@RequestMapping("/folderFile")
	public ModelAndView folderFile(ModelAndView mv, PageBean<UserFile> page, Integer folderID) {
		mv.setViewName("supplier/userspace/folderFile");
		// 文件夹数据
		int userID = SessionHelper.getSessionUser().getUserID();
		// 文件数据
		page.addParas("userID", userID);
		page.addParas("folderID", folderID);
		page.addParas("type", UserFileType.IMAGE.getValue());
		page.setPageSize(14);
		userSpaceService.queryFileByPage(page);
		mv.addObject("page", page);
		return mv;
	}

	/**
	 * 文件夹文件(小型)
	 * 
	 * @return
	 */
	@RequestMapping("/folderFileMini")
	public ModelAndView folderFileMini(ModelAndView mv, PageBean<UserFile> page, Integer folderID) {
		mv.setViewName("supplier/userspace/folderFile-mini");
		// 文件夹数据
		int userID = SessionHelper.getSessionUser().getUserID();
		// 文件数据
		page.addParas("userID", userID);
		page.addParas("folderID", folderID);
		page.addParas("type", UserFileType.IMAGE.getValue());
		page.setPageSize(10);
		userSpaceService.queryFileByPage(page);
		mv.addObject("page", page);
		return mv;
	}

	/**
	 * 修改文件夹名
	 * 
	 * @param folderID
	 * @param folderName
	 * @return
	 */
	@RequestMapping("/updateFolderName")
	@ResponseBody
	public MsgBean updateFolderName(int folderID, String folderName) {
		UserFolder folder = new UserFolder();
		folder.setUserID(SessionHelper.getSessionUser().getUserID());
		folder.setFolderID(folderID);
		folder.setFolderName(folderName);
		userSpaceService.updateFolderName(folder);
		return new MsgBean(Code.SUCCESS, "修改成功", MsgLevel.NORMAL);
	}

	/**
	 * 用户删除文件
	 * 
	 * @param fileID
	 * @return
	 */
	@RequestMapping("/deleteUserFile")
	@ResponseBody
	public JSONObject deleteUserFile(Integer[] fileID) {
		if (fileID != null) {
			for (int id : fileID) {
				userSpaceService.deleteUserFile(SessionHelper.getSessionUser().getUserID(), id);
			}
		}
		return getMsgJSONObject();
	}

	private JSONObject getMsgJSONObject() {
		JSONObject json = new JSONObject();
		int error = 0;
		String msg = "操作成功！";
		if (!ServiceMsg.isSuccess()) {
			error = 1;
			msg = ServiceMsg.getMsg();
		}
		json.put("error", error);
		json.put("msg", msg);
		return json;
	}

}

package com.zhigu.service.user.impl;

import java.io.File;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.common.utils.ClassLoaderUtil;
import com.zhigu.common.utils.ServiceMsg;
import com.zhigu.mapper.UserSpaceMapper;
import com.zhigu.model.PageBean;
import com.zhigu.model.UserFile;
import com.zhigu.model.UserFolder;
import com.zhigu.model.UserInfo;
import com.zhigu.service.user.IUserSpaceService;

@Service
public class UserSpaceServiceImpl implements IUserSpaceService {
	@Autowired
	private UserSpaceMapper userSpaceDao;

	@Override
	public int saveFolder(UserFolder folder) {
		return userSpaceDao.saveFolder(folder);
	}

	@Override
	public int updateFolderName(UserFolder folder) {
		String folderName = folder.getFolderName();
		if (folderName.length() > 10) {
			ServiceMsg.addMsg(1, "文件名不能超过10字！", MsgLevel.ERROR);
			return 0;
		}
		UserFolder userFolder = userSpaceDao.queryFolderByUserFolderID(folder.getUserID(), folder.getFolderID());
		int code = 0;
		if (userFolder != null) {
			userFolder.setFolderName(folder.getFolderName());
			code = userSpaceDao.updateFolder(folder);
		} else {
			code = userSpaceDao.saveFolder(folder);
		}
		return code;
	}

	@Override
	public int saveFile(UserFile file) {
		UserInfo userInfo = userSpaceDao.queryUserSpaceSize(file.getUserID());
		if (userInfo.getUserSpaceSize() < userInfo.getUserSpaceUseSize() + file.getSize()) {
			ServiceMsg.addMsg(1, "用户空间不足，不能上传文件！", MsgLevel.ERROR);
			return 0;
		}
		UserFolder folder = userSpaceDao.queryFolderByUserFolderID(file.getUserID(), file.getFolderID());
		if (folder == null) {
			folder = userSpaceDao.queryCreateUserDefaultFolder(file.getUserID());
		}
		file.setFolderID(folder.getFolderID());
		// 更新用户空间已使用大小
		long userSpaceUseSize = userInfo.getUserSpaceUseSize() + file.getSize();
		userSpaceDao.updateUserSpaceUseSize(file.getUserID(), userSpaceUseSize);
		return userSpaceDao.saveFile(file);
	}

	@Override
	public List<UserFolder> queryFolderByUserID(int userID) {
		return userSpaceDao.queryFolderByUserID(userID);
	}

	@Override
	public List<UserFile> queryFileByFolderID(int folderID) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("folderID", folderID);
		return userSpaceDao.queryFileByFolderID(map);
	}

	@Override
	public List<UserFile> queryFileByPage(PageBean<UserFile> page) {
		return userSpaceDao.queryFileByPage(page);
	}

	@Override
	public UserInfo queryUserSpaceSize(int userID) {
		return userSpaceDao.queryUserSpaceSize(userID);
	}

	@Override
	public int deleteUserFile(int userID, int fileID) {
		UserFile userFile = userSpaceDao.queryFileByFileID(fileID);
		if (userFile.getUserID() != userID)
			return 0;
		try {
			URL url = ClassLoaderUtil.getExtendResource("../" + userFile.getFilePath());
			new File(url.getFile()).delete();
		} catch (MalformedURLException e) {
			e.printStackTrace();
		}
		return userSpaceDao.deleteUserFileByID(fileID);
	}

}

package com.zhigu.service.user;

import java.util.List;

import com.zhigu.model.PageBean;
import com.zhigu.model.UserFile;
import com.zhigu.model.UserFolder;
import com.zhigu.model.UserInfo;

public interface IUserSpaceService {
	/**
	 * 添加用户文件夹数据
	 * 
	 * @param folder
	 * @return
	 */
	public int saveFolder(UserFolder folder);

	/**
	 * 更新用户文件夹名，不存在原文件夹则新建
	 * 
	 * @param folder
	 * @return
	 */
	public int updateFolderName(UserFolder folder);

	/**
	 * 添加用户文件数据，未设置文件夹ID时保存到默认文件夹
	 * 
	 * @param file
	 * @return
	 */
	public int saveFile(UserFile file);

	/**
	 * 查询用户文件夹
	 * 
	 * @param userID
	 * @return
	 */
	public List<UserFolder> queryFolderByUserID(int userID);

	/**
	 * 查询文件夹的文件
	 * 
	 * @param folderID
	 * @return
	 */
	public List<UserFile> queryFileByFolderID(int folderID);

	/**
	 * 查询文件夹的文件
	 * 
	 * @param map
	 * @return
	 */
	public List<UserFile> queryFileByPage(PageBean<UserFile> page);

	/**
	 * 查询用户空间大小（总大小、已用大小）
	 * 
	 * @param userID
	 * @return
	 */
	public UserInfo queryUserSpaceSize(int userID);

	/**
	 * 删除用户文件
	 * 
	 * @param userID
	 * @param fileID
	 * @return
	 */
	public int deleteUserFile(int userID, int fileID);
}

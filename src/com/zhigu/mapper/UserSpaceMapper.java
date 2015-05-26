package com.zhigu.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.zhigu.model.PageBean;
import com.zhigu.model.UserFile;
import com.zhigu.model.UserFolder;
import com.zhigu.model.UserInfo;

public interface UserSpaceMapper {
	/**
	 * 添加用户文件夹数据
	 * 
	 * @param folder
	 * @return
	 */
	public int saveFolder(UserFolder folder);

	/**
	 * 更新用户文件夹
	 * 
	 * @param folder
	 * @return
	 */
	public int updateFolder(UserFolder folder);

	/**
	 * 添加用户文件数据
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
	 * 根据文件夹ID取文件夹数据
	 * 
	 * @param folderID
	 * @return
	 */
	public UserFolder queryFolderByFolderID(int folderID);

	/**
	 * 取得用户文件夹
	 * 
	 * @param userID
	 * @param folderID
	 * @return
	 */
	public UserFolder queryFolderByUserFolderID(@Param("userID") int userID, @Param("folderID") int folderID);

	/**
	 * 取得用户默认文件夹（没有时自动创建）
	 * 
	 * @param userID
	 * @return
	 */
	public UserFolder queryCreateUserDefaultFolder(int userID);

	/**
	 * 根据文件ID取文件数据
	 * 
	 * @param fileID
	 * @return
	 */
	public UserFile queryFileByFileID(int fileID);

	/**
	 * 查询文件夹的文件
	 * 
	 * @param map
	 * @return
	 */
	public List<UserFile> queryFileByFolderID(Map<String, Object> map);

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
	 * 修改用户空间已用大小
	 * 
	 * @param userID
	 * @param userSpaceUseSize
	 * @return
	 */
	public int updateUserSpaceUseSize(@Param("userID") int userID, @Param("userSpaceUseSize") long userSpaceUseSize);

	/**
	 * 删除用户文件
	 * 
	 * @param fileID
	 * @return
	 */
	public int deleteUserFileByID(int fileID);
}

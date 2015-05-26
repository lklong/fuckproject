package com.zhigu.common.utils;

import java.io.File;
import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

import com.zhigu.common.SessionHelper;

public class UploadFileUtil {
	/** 上传保存路径 */
	private static final String UPLOAD_FOLDER = "uploadimg/";

	/**
	 * 拷贝用户上传临时图片<br>
	 * (保存到uploadimg/用户id/fileName)
	 * 
	 * @param sourcePath
	 *            相对路径
	 * @param fileName
	 *            保存为文件名
	 * @return
	 * @throws IOException
	 */
	public static String copyTempImg(String sourcePath, String fileName) throws IOException {
		if (StringUtil.isEmpty(sourcePath) || StringUtil.isEmpty(fileName)) {
			return null;
		}
		String basePath = ZhiguConfig.getSaveFileRoot();
		File sourceFile = new File(basePath + sourcePath);
		String userID = null;
		if (SessionHelper.getSessionUser() != null) {
			userID = "user" + String.valueOf(SessionHelper.getSessionUser().getUserID());
		} else if (SessionHelper.getSessionAdmin() != null) {
			userID = "admin" + String.valueOf(SessionHelper.getSessionAdmin().getId());
		}
		String targetPath = UPLOAD_FOLDER + userID + "/" + fileName + FileUtil.getFileExtensionName(sourceFile).toLowerCase();
		if (sourcePath.equals(targetPath)) {
			return sourcePath;
		}
		if (sourceFile.exists()) {
			File targetFile = new File(basePath, targetPath);
			FileUtil.fileCopy(sourceFile, targetFile);
			return targetPath;
		}
		return null;
	}

	/**
	 * 拷贝用户上传临时图片<br>
	 * (保存到uploadimg/fileName)
	 * 
	 * @param sourcePath
	 *            相对路径
	 * @param fileName
	 *            保存为文件名
	 * @return
	 * @throws IOException
	 */
	public static String copyTempImg2(String sourcePath, String fileName) throws IOException {
		if (StringUtil.isEmpty(sourcePath) || StringUtil.isEmpty(fileName)) {
			return null;
		}
		String basePath = ZhiguConfig.getSaveFileRoot();
		File sourceFile = new File(basePath + sourcePath);
		String targetPath = UPLOAD_FOLDER + fileName + FileUtil.getFileExtensionName(sourceFile).toLowerCase();
		if (sourcePath.equals(targetPath)) {
			return sourcePath;
		}
		if (sourceFile.exists()) {
			File targetFile = new File(basePath, targetPath);
			FileUtil.fileCopy(sourceFile, targetFile);
			return targetPath;
		}
		return null;
	}

	/**
	 * 保存文件
	 * 
	 * @param upfile
	 * @param relativeDir
	 *            相对目录
	 * @param fileName
	 *            文件名 （自动追加从MultipartFile中获取的文件后缀）
	 * @return 保存文件的相对路径
	 * @throws IOException
	 * @throws IllegalStateException
	 */
	public static String saveFile(MultipartFile upfile, String relativeDir, String fileName) throws IllegalStateException, IOException {
		String ex = FileUtil.getFileExtensionName(upfile.getOriginalFilename()).toLowerCase();
		// 添加默认后缀
		ex = ".".equals(ex) ? ".jpg" : ex;
		if (!fileName.toLowerCase().endsWith(ex)) {
			fileName += ex;
		}
		File targetFile = new File(ZhiguConfig.getSaveFileRoot() + relativeDir, fileName);
		if (!targetFile.getParentFile().exists()) {
			targetFile.getParentFile().mkdirs();
		}
		upfile.transferTo(targetFile);
		String targetFilePath = targetFile.getPath();
		return targetFilePath.substring(ZhiguConfig.getSaveFileRoot().length()).replaceAll("\\\\", "/");
	}
}

package com.zhigu.common.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import org.apache.log4j.Logger;

/**
 * 压缩下载文件
 * 
 * @author HeSiMin
 * @date 2014年8月5日
 *
 */
public class ZipFileDownload {
	private static final String DOWNLOAD_TEMP_FOLDER = "downloadTemp";
	private static Logger logger = Logger.getLogger(ZipFileDownload.class);

	/**
	 * 压缩文件或者目录
	 * 
	 * @param baseDirName
	 *            压缩的根目录
	 * @param fileName
	 *            根目录下待压缩的文件或文件夹名， 星号*表示压缩根目录下的全部文件。
	 * @param targetFileName
	 *            目标ZIP文件
	 */
	public static void fileToZip(String baseDirName, String targetFileName, String... fileNames) {
		// // zip文件的相对路径
		// String relativePath = DOWNLOAD_TEMP_FOLDER + "/" +
		// DateUtil.format(DateUtil.format2) + UUID.randomUUID().toString() +
		// ".zip";
		// // 压缩文件临时存放位置(目标ZIP文件)
		// String targetFileName = baseDirName + relativePath;
		// 检测根目录是否存在
		if (baseDirName == null) {
			logger.info("压缩失败，根目录不存在：" + baseDirName);
			return;
		}
		File baseDir = new File(baseDirName);
		if (!baseDir.exists()) {
			logger.info("压缩失败，根目录不存在：" + baseDirName);
			return;
		}
		String baseDirPath = baseDir.getAbsolutePath();
		// 目标文件
		File targetFile = new File(targetFileName);
		if (targetFile.getParentFile().exists()) {
			targetFile.getParentFile().mkdirs();
		}
		try {
			targetFile.createNewFile();
			// 创建一个zip输出流来压缩数据并写入到zip文件
			ZipOutputStream out = new ZipOutputStream(new FileOutputStream(targetFile));
			for (String fileName : fileNames) {
				File file = new File(baseDir, fileName);
				if (file.isFile()) {
					ZipFileDownload.fileToZip(baseDirPath, file, out);
				}
			}
			out.close();
			logger.info("压缩文件成功，目标文件名：" + targetFileName);
		} catch (IOException e) {
			logger.info("压缩失败：" + e);
			e.printStackTrace();
		}
	}

	/**
	 * 将文件压缩到ZIP输出流
	 */
	private static void fileToZip(String baseDirPath, File file, ZipOutputStream out) {
		FileInputStream in = null;
		ZipEntry entry = null;
		// 创建复制缓冲区
		byte[] buffer = new byte[4096];
		int bytes_read;
		if (file.isFile()) {
			try {
				// 创建一个文件输入流
				in = new FileInputStream(file);
				// 做一个ZipEntry
				entry = new ZipEntry(getEntryName(baseDirPath, file));
				// 存储项信息到压缩文件
				out.putNextEntry(entry);
				// 复制字节到压缩文件
				while ((bytes_read = in.read(buffer)) != -1) {
					out.write(buffer, 0, bytes_read);
				}
				out.closeEntry();
				in.close();
				logger.info("添加文件" + file.getAbsolutePath() + "被到ZIP文件中！");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 获取待压缩文件在ZIP文件中entry的名字。即相对于跟目录的相对路径名
	 * 
	 * @param baseDirPath
	 * @param file
	 * @return
	 */
	private static String getEntryName(String baseDirPath, File file) {
		if (!baseDirPath.endsWith(File.separator)) {
			baseDirPath += File.separator;
		}
		String filePath = file.getAbsolutePath();
		// 对于目录，必须在entry名字后面加上"/"，表示它将以目录项存储。
		if (file.isDirectory()) {
			filePath += "/";
		}
		int index = filePath.indexOf(baseDirPath);
		return filePath.substring(index + baseDirPath.length());
	}
}

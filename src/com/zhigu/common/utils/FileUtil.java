package com.zhigu.common.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.nio.channels.FileChannel;
import java.util.Arrays;
import java.util.Collection;
import java.util.Iterator;

import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSON;
import com.zhigu.common.SessionHelper;
import com.zhigu.common.constant.enumconst.UserFileType;

import eu.medsea.mimeutil.MimeType;
import eu.medsea.mimeutil.MimeUtil;

/**
 * 文件工具类
 * 
 * @author zhouqibing
 * @time 2014年7月16日 上午8:26:54
 */
public class FileUtil {

	static {
		// 注册
		MimeUtil.registerMimeDetector("eu.medsea.mimeutil.detector.MagicMimeMimeDetector");
	}
	private static final String[] IMG_FORMAT = new String[] { "jpg", "gif", "bmp", "png" };
	private static final FileType[] ftypes = { new FileType(UserFileType.IMAGE.getValue(), new String[] { ".jpg", ".jpeg", ".bmp", ".png" }, 1024 * 500, ""),
			new FileType(UserFileType.RAR.getValue(), new String[] { ".zip", ".rar" }, 1024 * 1024 * 50, "") };

	/**
	 * 文件MIME类型检查
	 * 
	 * @param f
	 * @return
	 */
	public static boolean checkFileMime(File f) {

		return false;
	}

	/**
	 * 获取文件的Mime类型
	 * 
	 * @param f
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static String getFileMime(File f) {
		check(f);
		Collection<MimeType> collectins = MimeUtil.getMimeTypes(f);
		if (collectins != null) {
			Iterator<MimeType> iter = collectins.iterator();
			while (iter.hasNext()) {
				return iter.next().toString();// 返回第一个类型
			}
		}
		return "";
	}

	/**
	 * 取得文件的扩展名
	 * 
	 * @param f
	 * @return
	 */
	public static String getFileExtensionName(File f) {
		check(f);
		// MimeUtil.getExtension方法获取扩展名的方法是从文件名中的第一个.开始到结束都为扩展名
		String ext = MimeUtil.getExtension(f);
		if (ext.indexOf(".") > -1)// 不是最终的扩展名，则再处理
			return ext.substring(ext.lastIndexOf(".") + 1);
		return "." + ext;
	}

	/**
	 * 取得文件的扩展名(带“.”)
	 * 
	 * @param f
	 * @return
	 */
	public static String getFileExtensionName(String f) {
		// MimeUtil.getExtension方法获取扩展名的方法是从文件名中的第一个.开始到结束都为扩展名
		String ext = MimeUtil.getExtension(f);
		if (ext.indexOf(".") > -1)// 不是最终的扩展名，则再处理
			return "." + ext.substring(ext.lastIndexOf(".") + 1);
		return "." + ext;
	}

	/**
	 * 取得文件的扩展名(不带“.”)
	 * 
	 * @param f
	 * @return
	 */
	public static String getFileExtensionNameNotDot(String f) {
		String ext = MimeUtil.getExtension(f);
		if (ext.indexOf(".") > -1)// 不是最终的扩展名，则再处理
			return ext.substring(ext.lastIndexOf(".") + 1);
		return ext;
	}

	/**
	 * 检查文件是否是一下图片格式： "jpg", "gif", "bmp", "png"
	 * 
	 * @param name
	 * @return
	 */
	public static boolean checkImgType(String name) {
		if (StringUtil.isEmpty(name)) {
			return false;
		}
		String ext = "";
		if (name.indexOf(".") > -1) {
			ext = name.substring(name.lastIndexOf(".") + 1);
		}
		for (String cname : IMG_FORMAT) {
			if (cname.equals(ext)) {
				return true;
			}
		}
		return false;
	}

	/**
	 * 文件验证
	 * 
	 * @param f
	 */
	private static void check(File f) {
		if (f == null || !f.exists() || !f.isFile())
			throw new IllegalArgumentException("未找到指定文件！");
	}

	/**
	 * 项目根路径<br>
	 * 文件上传保存的路径使用：ZhiguConfig.getSaveFileRoot()
	 * 
	 * @deprecated
	 * @return
	 */
	public static String getBasePath() {
		return SessionHelper.getRequest().getSession().getServletContext().getRealPath("/");
	}

	/**
	 * 文件拷贝（目标目录不存在则创建）
	 * 
	 * @param sourceFile
	 * @param targetFile
	 * @throws IOException
	 */
	public static void fileCopy(File sourceFile, File targetFile) throws IOException {
		if (sourceFile.getAbsolutePath().equals(targetFile.getAbsolutePath()))
			return;
		FileInputStream fi = null;
		FileOutputStream fo = null;
		FileChannel in = null;
		FileChannel out = null;
		// 1.先创建文件夹
		if (!targetFile.getParentFile().exists()) {
			targetFile.getParentFile().mkdirs();
		}
		try {

			// 2.在创建文件
			targetFile.createNewFile();

			fi = new FileInputStream(sourceFile);
			fo = new FileOutputStream(targetFile);
			in = fi.getChannel();// 得到对应的文件通道
			out = fo.getChannel();// 得到对应的文件通道
			in.transferTo(0, in.size(), out);// 连接两个通道，并且从in通道读取，然后写入out通道
		} finally {
			try {
				if (fi != null) {
					fi.close();
				}
				if (in != null) {
					in.close();
				}
				if (fo != null) {
					fo.close();
				}
				if (out != null) {
					out.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 取得文件类型
	 * 
	 * @param ftype
	 * @return
	 */
	public static FileType getFileType(Integer ftype) {
		for (FileType ft : ftypes) {
			if (ft.getFtype().equals(ftype))
				return ft;
		}
		return null;
	}

	/**
	 * 验证文件
	 * 
	 * @param ftype
	 * @param file
	 * @return 0：验证通过<br>
	 *         1：参数传递错误<br>
	 *         2：未定义的文件类型<br>
	 *         3：上传文件超过规定大小<br>
	 *         4：不支持的文件扩展<br>
	 */
	public static String verifyFile(Integer ftype, File file) {
		if (ftype == null || file == null || !file.isFile())
			return "参数传递错误！";
		FileType ft = getFileType(ftype);

		if (ft == null)
			return "未定义的文件类型！";

		String fext = getFileExtensionName(file).toLowerCase();
		if (Arrays.binarySearch(ft.getFexts(), fext) < 0)
			return "不支持的文件扩展！";

		long fsize = file.length();
		if (fsize > ft.getMaxSize())
			return "上传文件超过规定大小！";

		return "";
	}

	/**
	 * 验证文件
	 * 
	 * @param ftype
	 * @param file
	 * @return 0：验证通过<br>
	 *         1：参数传递错误<br>
	 *         2：未定义的文件类型<br>
	 *         3：上传文件超过规定大小<br>
	 *         4：不支持的文件扩展<br>
	 */
	public static String verifyFile(Integer ftype, MultipartFile file) {
		if (ftype == null || file == null)
			return "参数传递错误！";

		FileType ft = getFileType(ftype);
		if (ft == null)
			return "未定义的文件类型！";

		String fext = getFileExtensionName(file.getOriginalFilename()).toLowerCase();
		if (!Arrays.asList(ft.getFexts()).contains(fext))
			return "只能上传以下文件类型：" + JSON.toJSONString(ft.getFexts());
		// if(Arrays.binarySearch(ft.getFexts(), fext) < 0)

		long fsize = file.getSize();
		if (fsize > ft.getMaxSize())
			return "上传文件不能超过大小:" + scale(ft.getMaxSize());

		return "";
	}

	private static String scale(long size) {
		long kb = size / 1024;
		if (kb < 1024)
			return kb + "KB";
		long mb = kb / 1024;
		if (mb < 1024)
			return mb + "MB";
		return (mb / 1024) + "GB";
	}

	/**
	 * 获取资源文件URL
	 * 
	 * @param relativePath
	 *            项目下相对路径
	 * @return
	 * @throws MalformedURLException
	 */
	public static URL getPropertyURL(String relativePath) throws MalformedURLException {
		return ClassLoaderUtil.getExtendResource("../../" + relativePath);
	};
}

class FileType {

	private Integer ftype;// 文件类型
	private String[] fexts;// 支持的文件扩展后缀
	private long maxSize;// 文件最大大小
	private String saveFolder;

	public FileType(Integer ftype, String[] fexts, long maxSize, String saveFolder) {
		this.ftype = ftype;
		this.fexts = fexts;
		this.maxSize = maxSize;
		this.saveFolder = saveFolder;
	}

	/**
	 * 验证文件
	 * 
	 * @param file
	 * @return
	 */
	public boolean verfityExt(File file) {
		if (file == null || !file.isFile())
			return false;
		// 文件后缀
		String fext = FileUtil.getFileExtensionName(file).toLowerCase();
		for (String ext : getFexts()) {
			if (ext.toLowerCase().equals(fext))
				return true;
		}
		return false;
	}

	/**
	 * 验证文件
	 * 
	 * @param File
	 * @return
	 */
	public boolean verfityExt(String fname) {
		if (StringUtil.isEmpty(fname))
			return false;
		// 文件后缀
		String fext = fname.toLowerCase();
		for (String ext : getFexts()) {
			if (ext.toLowerCase().equals(fext))
				return true;
		}
		return false;
	}

	/**
	 * 验证文件
	 * 
	 * @param file
	 * @return
	 */
	public boolean verfitySize(File file) {
		if (file == null || !file.isFile())
			return false;
		// 文件后缀
		long fsize = file.getTotalSpace();
		return fsize > getMaxSize();
	}

	public Integer getFtype() {
		return ftype;
	}

	public void setFtype(Integer ftype) {
		this.ftype = ftype;
	}

	public String[] getFexts() {
		return fexts;
	}

	public void setFexts(String[] fexts) {
		this.fexts = fexts;
	}

	public long getMaxSize() {
		return maxSize;
	}

	public void setMaxSize(long maxSize) {
		this.maxSize = maxSize;
	}

	public String getSaveFolder() {
		return saveFolder;
	}

	public void setSaveFolder(String saveFolder) {
		this.saveFolder = saveFolder;
	}
}
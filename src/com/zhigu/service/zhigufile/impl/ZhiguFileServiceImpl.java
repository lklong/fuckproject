/**
 * @ClassName: ZhiguFileServiceImpl.java
 * @Author: liukailong
 * @Description: 
 * @Date: 2015年4月28日
 * 
 */
package com.zhigu.service.zhigufile.impl;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSON;
import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageDecoder;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.common.utils.DateUtil;
import com.zhigu.common.utils.ImageUtil;
import com.zhigu.common.utils.ZhiguConfig;
import com.zhigu.mapper.ZhiguFileMapper;
import com.zhigu.model.ZhiguFile;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.zhigufile.ZhiguFileService;

/**
 * @author Administrator
 *
 */
@Service
public class ZhiguFileServiceImpl implements ZhiguFileService {

	@Autowired
	private ZhiguFileMapper zhiguFileDao;

	private static final String UPLOAD_SAVE_BASE_REAL_PATH = ZhiguConfig.getSaveFileRoot() + "upload/";

	private String processFile(MultipartFile upfile, File des) throws IOException {
		if (!des.getParentFile().exists()) {
			des.getParentFile().mkdirs();
		}
		upfile.transferTo(des);
		return des.getPath().substring(ZhiguConfig.getSaveFileRoot().length()).replaceAll("\\\\", "/");
	}

	@Override
	public MsgBean saveImage(MultipartFile file, String[] specs, String specType, Integer minWidth, Integer maxWidth, String fileNamePrefix) throws IOException {
		JPEGImageDecoder decoder = JPEGCodec.createJPEGDecoder(file.getInputStream());
		BufferedImage img = decoder.decodeAsBufferedImage();
		// BufferedImage img = ImageIO.read(file.getInputStream());
		// ========check start=============
		int width = img.getWidth();
		int height = img.getHeight();
		if (specs != null && specs.length > 0) {
			for (String s : specs) {
				String[] w_h = s.split("x");
				if (width < Integer.parseInt(w_h[0]) || height < Integer.parseInt(w_h[1])) {
					return new MsgBean(Code.FAIL, "图片规格必须大于等于：" + s, MsgLevel.ERROR);
				}
				if (w_h[0].equals(w_h[1]) && height != width) {
					return new MsgBean(Code.FAIL, "图片规格必须为正方形", MsgLevel.ERROR);
				}
			}
		}
		if (minWidth != null && width < minWidth) {
			return new MsgBean(Code.FAIL, "图片宽度不能小于 " + minWidth + " px", MsgLevel.ERROR);
		}
		// 图片大小的验证
		FileLimit imageLimit = FileLimit.IMAGE;
		if (file.getSize() > imageLimit.getSizeValue()) {
			return new MsgBean(Code.FAIL, "图片大小不能超过：" + imageLimit.getSizeName(), MsgLevel.ERROR);
		}
		// 图片类型的验证
		if (!imageLimit.getSuffix().contains(FilenameUtils.getExtension(file.getOriginalFilename()).toLowerCase())) {
			return new MsgBean(Code.FAIL, "请上传一下格式的图片：" + JSON.toJSONString(imageLimit.getSuffix()), MsgLevel.ERROR);
		}
		// ========check end=============

		ZhiguFile zhiguFile = new ZhiguFile();
		// 保存原图
		File desFile = generatDesFile(file, fileNamePrefix);
		String uri = null;
		if (maxWidth != null && width > maxWidth) {
			// 进行图片最大宽度限制
			ImageUtil.ImageScale(img, desFile.getPath(), maxWidth, height);
			uri = desFile.getPath().substring(ZhiguConfig.getSaveFileRoot().length()).replaceAll("\\\\", "/");
		} else {
			uri = processFile(file, desFile);
		}

		zhiguFile.setSize(file.getSize());
		zhiguFile.setUri(uri);
		zhiguFile.setRealPath(desFile.getPath());
		zhiguFile.setFileType(true);
		zhiguFile.setSpecs(Arrays.toString(specs));

		// 存入数据库
		zhiguFileDao.insert(zhiguFile);

		// ===========其他规格处理 start==================
		if (specType.equals("1")) {
			if (specs != null) {
				// 保存其他规格图片，不存数据库
				for (String spec : specs) {
					// 按照规格处理处理图片
					String[] arr_spec = spec.split("x");
					int nWidth = Integer.valueOf(arr_spec[0]);
					int nHeight = Integer.valueOf(arr_spec[1]);

					if (nWidth > width) {
						nWidth = width;
					}
					if (nHeight > height) {
						nHeight = height;
					}
					ImageUtil.ImageScale(img, desFile.getPath() + "_" + spec + ".jpg", nWidth, nHeight);
				}
			}
		} else {
			// 其他处理 TODO
		}
		// ===========其他规格处理 end==================

		MsgBean msg = new MsgBean(Code.SUCCESS, "图片保存成功", MsgLevel.NORMAL);
		return msg.setData(zhiguFile);
	}

	/**
	 * 生成保存的目标文件
	 * 
	 * @param file
	 * @param fileNamePrefix
	 * @return
	 */
	private File generatDesFile(MultipartFile file, String fileNamePrefix) {
		String suffix = FilenameUtils.getExtension(file.getOriginalFilename());
		String uid = UUID.randomUUID().toString().replaceAll("-", "");
		if (org.apache.commons.lang3.StringUtils.isBlank(fileNamePrefix)) {
			return new File(UPLOAD_SAVE_BASE_REAL_PATH + DateUtil.format(new Date(), "yyyyMM") + "/" + uid + "." + suffix.toLowerCase());
		} else {
			return new File(UPLOAD_SAVE_BASE_REAL_PATH + DateUtil.format(new Date(), "yyyyMM") + "/" + fileNamePrefix + uid + "." + suffix.toLowerCase());
		}
	}

	/**
	 * 保存数据包
	 * 
	 * @param file
	 * @return
	 * @throws IOException
	 */
	public MsgBean saveData(MultipartFile file) throws IOException {
		// 大小的验证
		FileLimit rarLimit = FileLimit.FILE;
		if (file.getSize() > rarLimit.getSizeValue()) {
			return new MsgBean(Code.FAIL, "数据包大小不能超过：" + rarLimit.getSizeName(), MsgLevel.ERROR);
		}
		// 类型的验证
		if (!rarLimit.getSuffix().contains(FilenameUtils.getExtension(file.getOriginalFilename()).toLowerCase())) {
			return new MsgBean(Code.FAIL, "请上传一下格式的数据包：" + JSON.toJSONString(rarLimit.getSuffix()), MsgLevel.ERROR);
		}

		// =========================
		ZhiguFile zhiguFile = new ZhiguFile();

		// 保存数据文件
		File desFile = generatDesFile(file, "data_");
		String uri = processFile(file, desFile);

		zhiguFile.setSize(file.getSize());
		zhiguFile.setUri(uri);
		zhiguFile.setRealPath(desFile.getPath());
		zhiguFile.setFileType(false);

		// 存入数据库
		zhiguFileDao.insert(zhiguFile);

		MsgBean msg = new MsgBean(Code.SUCCESS, "数据包保存成功", MsgLevel.NORMAL);
		return msg.setData(zhiguFile);
	}
}

enum FileLimit {
	IMAGE("1M", Arrays.asList("jpg", "jpeg", "png", "bmp"), 1024 * 1024), FILE("50M", Arrays.asList("zip", "rar"), 50 * 1204 * 1024);
	private String sizeName;
	private List<String> suffix;
	private long sizeValue;

	private FileLimit(String sizeName, List<String> suffix, long sizeValue) {
		this.sizeName = sizeName;
		this.suffix = suffix;
		this.sizeValue = sizeValue;
	}

	public String getSizeName() {
		return sizeName;
	}

	public void setSizeName(String sizeName) {
		this.sizeName = sizeName;
	}

	public List<String> getSuffix() {
		return suffix;
	}

	public void setSuffix(List<String> suffix) {
		this.suffix = suffix;
	}

	public long getSizeValue() {
		return sizeValue;
	}

	public void setSizeValue(long sizeValue) {
		this.sizeValue = sizeValue;
	}

}

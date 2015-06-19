/**
 * @ClassName: ZhiguFileServiceImpl.java
 * @Author: liukailong
 * @Description: 
 * @Date: 2015年4月28日
 * 
 */
package com.zhigu.service.zhigufile.impl;

import java.awt.image.renderable.ParameterBlock;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.media.jai.JAI;
import javax.media.jai.PlanarImage;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSON;
import com.alibaba.simpleimage.ImageRender;
import com.alibaba.simpleimage.SimpleImageException;
import com.alibaba.simpleimage.render.ReadRender;
import com.alibaba.simpleimage.render.ScaleParameter;
import com.alibaba.simpleimage.render.ScaleRender;
import com.alibaba.simpleimage.render.WriteRender;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.enumconst.FileLimit;
import com.zhigu.common.constant.enumconst.ImageSource;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.common.utils.ByteArraySeekableStreamWrap;
import com.zhigu.common.utils.DateUtil;
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

	private static final Logger LOGGER = Logger.getLogger(ZhiguFileServiceImpl.class);

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

	private void processImage(MultipartFile file, File out, Integer width, Integer height) {

		ScaleParameter scaleParam = new ScaleParameter(width, height); // 将图像缩略到1024x1024以内，不足1024x1024则不做任何处理
		// WriteParameter writeParam = new WriteParameter(); // 输出参数，默认输出格式为JPEG
		InputStream inStream = null;
		FileOutputStream outStream = null;
		ImageRender wr = null;
		try {
			inStream = file.getInputStream();
			outStream = new FileOutputStream(out);
			ImageRender rr = new ReadRender(inStream);
			ImageRender sr = new ScaleRender(rr, scaleParam);
			wr = new WriteRender(sr, outStream);

			wr.render(); // 触发图像处理
		} catch (Exception e) {
			LOGGER.error("图片处理出错1：" + e.getMessage());
		} finally {
			IOUtils.closeQuietly(inStream); // 图片文件输入输出流必须记得关闭
			IOUtils.closeQuietly(outStream);
			if (wr != null) {
				try {
					wr.dispose(); // 释放simpleImage的内部资源
				} catch (SimpleImageException ignore) {
					LOGGER.error("图片处理出错2：" + ignore.getMessage());
				}
			}
		}
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
		File desFile = null;
		String fileName = "";
		File dir = new File(UPLOAD_SAVE_BASE_REAL_PATH + DateUtil.format(new Date(), "yyyyMM"));
		if (!dir.exists()) {
			dir.mkdirs();
		}
		if (org.apache.commons.lang3.StringUtils.isBlank(fileNamePrefix)) {
			fileName = uid + "." + suffix.toLowerCase();
		} else {
			fileName = fileNamePrefix + uid + "." + suffix.toLowerCase();
		}

		desFile = new File(dir, fileName);
		try {
			desFile.createNewFile();
		} catch (IOException e) {
			LOGGER.error(e.getLocalizedMessage());
		}
		return desFile;
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

	/**
	 * 根据规则验证图片:宽,高,大,小等
	 * 
	 * @param img
	 * @return
	 */
	private MsgBean checkImage(int width, int height, long size, String suffix, ImageSource source) {

		List<String> specs = null;
		long allowSize = 0l;

		int maxWidth = 0;
		int maxHeight = 0;
		int minWidth = 0;
		int minHeight = 0;

		// TODO 自由的验证 (待补充，不同来源的图片，进行不同的验证)
		if (source.getType() == ImageSource.Store_Logo.getType()) {
			allowSize = ImageSource.Store_Logo.getSize();
			specs = ImageSource.Store_Logo.getSpecs();
			if (width != height) {
				return new MsgBean(Code.FAIL, "店铺LOGO图建议宽高：80x80的正方形", MsgLevel.ERROR);
			}
		} else if (source.getType() == ImageSource.Store_Back.getType()) {
			allowSize = ImageSource.Store_Back.getSize();
			specs = ImageSource.Store_Back.getSpecs();
			// 规格验证
			String[] spec = specs.get(0).split("x");
			minWidth = Integer.valueOf(spec[2]);
			maxHeight = Integer.valueOf(spec[1]);
			if (width < minWidth || height > maxHeight) {
				return new MsgBean(Code.FAIL, "店铺背景图建议宽高：1920x150(宽不能低于1920，高不能超过150)", MsgLevel.ERROR);
			}

		} else if (source.getType() == ImageSource.Goods_Description.getType()) {
			allowSize = ImageSource.Goods_Description.getSize();
		} else if (source.getType() == ImageSource.Goods_Main.getType()) {
			allowSize = source.getSize();
			specs = ImageSource.Goods_Main.getSpecs();
			// 规格验证
			String[] spec = specs.get(0).split("x");
			minWidth = minHeight = Integer.valueOf(spec[1]);
			if (width != height) {
				return new MsgBean(Code.FAIL, "商品主图必须是正方形", MsgLevel.ERROR);
			}
			if (width < minWidth) {
				return new MsgBean(Code.FAIL, "商品主图最小规格必须：430x430px,最大规格建议：1290x1290px", MsgLevel.ERROR);
			}

		} else if (source.getType() == ImageSource.User_Card.getType()) {
			allowSize = source.getSize();
		} else if (source.getType() == ImageSource.User_Head.getType()) {

		} else if (source.getType() == ImageSource.User_Certificate.getType()) {
			allowSize = source.getSize();
		}

		// TODO 公共的验证 (可扩展)
		// 1.图片格式验证
		FileLimit rarLimit = FileLimit.IMAGE;
		if (!rarLimit.getSuffix().contains(suffix)) {
			return new MsgBean(Code.FAIL, "请上传以下格式的图片：" + JSON.toJSONString(rarLimit.getSuffix()), MsgLevel.ERROR);
		}
		// 2.验证文件大小
		if (size > allowSize) {
			return new MsgBean(Code.FAIL, "图片大小不能超过：" + allowSize / 1024 / 1024.0 + "M", MsgLevel.ERROR);
		}

		return new MsgBean(Code.SUCCESS, "", MsgLevel.NORMAL);

	}

	/**
	 * 获取图片处理规则
	 * 
	 * @param type
	 * @return
	 */
	private ImageSource getImageSourceByType(Integer type) {
		if (type == ImageSource.Store_Logo.getType()) {
			return ImageSource.Store_Logo;
		} else if (type == ImageSource.Store_Back.getType()) {
			return ImageSource.Store_Back;
		} else if (type == ImageSource.Goods_Description.getType()) {
			return ImageSource.Goods_Description;
		} else if (type == ImageSource.Goods_Main.getType()) {
			return ImageSource.Goods_Main;
		} else if (type == ImageSource.User_Head.getType()) {
			return ImageSource.User_Head;
		} else if (type == ImageSource.User_Card.getType()) {
			return ImageSource.User_Card;
		} else if (type == ImageSource.User_Certificate.getType()) {
			return ImageSource.User_Certificate;
		}
		return null;
	}

	/**
	 * 保存图片
	 * 
	 * @param file
	 * @param fileNamePrefix
	 * @param source
	 * @return
	 */
	private ZhiguFile saveOriginImage(MultipartFile file, String fileNamePrefix, ImageSource source) {
		ZhiguFile zhiguFile = null;
		try {
			zhiguFile = new ZhiguFile();
			File _file = generatDesFile(file, fileNamePrefix);
			if (!_file.getParentFile().exists()) {
				_file.getParentFile().mkdirs();
			}
			InputStream is = file.getInputStream();
			FileUtils.copyInputStreamToFile(is, _file);

			String uri = _file.getPath().substring(ZhiguConfig.getSaveFileRoot().length()).replaceAll("\\\\", "/");

			zhiguFile.setSize(file.getSize());
			zhiguFile.setUri(uri);
			zhiguFile.setRealPath(_file.getPath());
			zhiguFile.setFileType(true);
			List<String> specs = source.getSpecs();
			specs = specs.subList(1, specs.size());
			String _specs = "";
			for (String spec : specs) {
				_specs += spec + ",";
			}
			zhiguFile.setSpecs(_specs);
			// 存入数据库
			zhiguFileDao.insert(zhiguFile);

		} catch (Exception e) {
			LOGGER.error("文件读取失败：" + e.getMessage());
		}
		return zhiguFile;
	}

	/**
	 * 图片处理业务
	 * 
	 * @param file
	 * @param type
	 * @param fileNamePrefix
	 * @return
	 * @throws IOException
	 */
	public MsgBean saveImage(MultipartFile file, Integer type) throws IOException {

		ImageSource source = getImageSourceByType(type);

		String fileNamePrefix = source.name().toLowerCase() + "_";

		// 读取数据
		PlanarImage img = readImage(file);

		// 验证数据
		int width = img.getWidth();
		int height = img.getHeight();
		long size = file.getSize();
		String suffix = FilenameUtils.getExtension(file.getOriginalFilename()).toLowerCase();
		MsgBean msgBean = checkImage(width, height, size, suffix, source);
		if (msgBean.getCode() == Code.FAIL) {
			return msgBean;
		}

		// 保存原图
		ZhiguFile zhiguFile = saveOriginImage(file, fileNamePrefix, source);
		if (zhiguFile == null) {
			msgBean.setCode(Code.FAIL);
			msgBean.setLevel(MsgLevel.ERROR.getValue());
			msgBean.setMsg("图片保存失败");
			return msgBean;
		}

		// 保存其他规格图片，不存数据库
		List<String> specs = source.getSpecs();
		if (CollectionUtils.isNotEmpty(specs) && specs.size() > 1) {
			specs = specs.subList(1, specs.size());
			for (int i = 0; i < specs.size(); i++) {
				String spec = specs.get(i);
				if (StringUtils.isBlank(spec)) {
					continue;
				}
				// 按照规格处理处理图片
				String[] arr_spec = spec.split("x");
				int nWidth = Integer.valueOf(arr_spec[0]);
				int nHeight = Integer.valueOf(arr_spec[1]);

				if (nWidth == 0 || nWidth > width) {
					nWidth = width;
				}
				if (nHeight == 0 || nHeight > height) {
					nHeight = height;
				}
				File desFile = new File(zhiguFile.getRealPath() + "_" + spec + ".jpg");
				if (i == 0) {
					desFile = new File(zhiguFile.getRealPath());
				}
				processImage(file, desFile, nWidth, nHeight);

			}

		}

		MsgBean msg = new MsgBean(Code.SUCCESS, "图片保存成功", MsgLevel.NORMAL);
		return msg.setData(zhiguFile);
	}

	/**
	 * 将文件读取到图片流中
	 * 
	 * @param file
	 * @return
	 */
	private PlanarImage readImage(MultipartFile file) {
		PlanarImage img = null;
		try {

			InputStream inStream = file.getInputStream();
			ByteArraySeekableStreamWrap wrap = ByteArraySeekableStreamWrap.wrapInputStream(inStream);
			ParameterBlock pb = new ParameterBlock();
			pb.add(wrap);
			img = JAI.create("Stream", pb);

		} catch (IOException e) {
			LOGGER.error("文件读取失败：" + e.getMessage());
		}
		return img;

	}

}
package com.zhigu.controllers.common;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.lang3.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.common.utils.DateUtil;
import com.zhigu.common.utils.ImageUtil;
import com.zhigu.common.utils.UploadFileUtil;
import com.zhigu.common.utils.ZhiguConfig;
import com.zhigu.controllers.test.UeditorImage;
import com.zhigu.model.ZhiguFile;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.user.IUserService;
import com.zhigu.service.zhigufile.ZhiguFileService;

/**
 * 上传处理
 * 
 * @ClassName: UploadController
 * @Description: 处理所有上传功能(所有url都必须以upload开头，包括文件保存路径)，
 *               ImageIO.read不能处理CMYK的图片，使用JPEGCodec
 *               .createJPEGDecoder，图片应该是RGB，CMYK的处理后会有点色变
 * @author hesimin
 * @date 2015年4月27日 下午4:45:20
 *
 */
@Controller
@RequestMapping("/upload")
public class UploadController {

	/** 文件保存路径 */
	private static final String UPLOAD = "upload";

	/** 文件上传业务处理 */
	@Autowired
	private ZhiguFileService zhiguFileService;

	/** 头像处理 */
	@Autowired
	private IUserService userService;

	// 缓存文件头信息-文件头信息
	public static final HashMap<String, String> mFileTypes = new HashMap<String, String>();
	static {
		// images
		mFileTypes.put("FFD8FF", "jpg");
		mFileTypes.put("89504E47", "png");
		mFileTypes.put("424D", "bmp");
		// mFileTypes.put("47494638", "gif");
		// mFileTypes.put("49492A00", "tif");

		mFileTypes.put("52617221", "rar");
		mFileTypes.put("504B0304", "zip");
		// mFileTypes.put("41433130", "dwg"); // CAD
		// mFileTypes.put("38425053", "psd");
		// mFileTypes.put("7B5C727466", "rtf"); // 日记本
		// mFileTypes.put("3C3F786D6C", "xml");
		// mFileTypes.put("68746D6C3E", "html");
		// mFileTypes.put("44656C69766572792D646174653A", "eml"); // 邮件
		// mFileTypes.put("D0CF11E0", "doc");
		// mFileTypes.put("5374616E64617264204A", "mdb");
		// mFileTypes.put("252150532D41646F6265", "ps");
		// mFileTypes.put("255044462D312E", "pdf");
		// mFileTypes.put("504B0304", "docx");
		// mFileTypes.put("57415645", "wav");
		// mFileTypes.put("41564920", "avi");
		// mFileTypes.put("2E524D46", "rm");
		// mFileTypes.put("000001BA", "mpg");
		// mFileTypes.put("000001B3", "mpg");
		// mFileTypes.put("6D6F6F76", "mov");
		// mFileTypes.put("3026B2758E66CF11", "asf");
		// mFileTypes.put("4D546864", "mid");
		// mFileTypes.put("1F8B08", "gz");
	}

	/**
	 * 上传图片
	 * 
	 * @param file
	 *            图片文件,保存到zhiguConfig.save_file_root+年+月
	 * @param spec
	 *            非必须 最多3个，生成小图的规格："320x320"
	 * @param specType
	 *            非必须 规格类型：1-根据规格生成小图（默认）
	 * @return msgBean.data :
	 *         ZhiguFile，有规格的在url后加规格获取。eg:123.jpg--->123.jpg_320x320.jpg
	 */
	@RequestMapping(value = "/img", method = RequestMethod.POST)
	@ResponseBody
	public MsgBean img(MultipartFile file, @RequestParam(required = false) String[] specs, @RequestParam(required = false, defaultValue = "1") String specType) {
		try {
			// return zhiguFileService.saveImage(file, null, "1", 975,
			// "goods_d");
			return zhiguFileService.saveImage(file, specs, "1", null, 975, null);
		} catch (IOException e) {
			return new MsgBean(Code.FAIL, "图片保存失败，请重试", MsgLevel.ERROR);
		}
	}

	/**
	 * 上传图片
	 * 
	 * @param file
	 *            图片文件,保存到zhiguConfig.save_file_root+年+月
	 * @param spec
	 *            非必须 最多3个，生成小图的规格："320x320"
	 * @param specType
	 *            非必须 规格类型：1-根据规格生成小图（默认）
	 * @return msgBean.data :
	 *         ZhiguFile，有规格的在url后加规格获取。eg:123.jpg--->123.jpg_320x320.jpg
	 */
	@RequestMapping(value = "/img/goods/main", method = RequestMethod.POST)
	@ResponseBody
	public MsgBean goodsMain(MultipartFile file) {
		String[] specs = new String[] { "285x285", "160x160" };
		try {
			return zhiguFileService.saveImage(file, specs, "1", 430, 430 * 3, "goodsm_");
		} catch (IOException e) {
			return new MsgBean(Code.FAIL, "图片保存失败，请重试", MsgLevel.ERROR);
		}
	}

	/**
	 * 数据包上传
	 * 
	 * @param file
	 * @return
	 */
	@RequestMapping(value = "/data", method = RequestMethod.POST)
	@ResponseBody
	public MsgBean data(MultipartFile file) {
		try {
			return zhiguFileService.saveData(file);
		} catch (IOException e) {
			return new MsgBean(Code.FAIL, "数据包保存失败，请重试", MsgLevel.ERROR);
		}
	}

	/**
	 * 暂时未用
	 * 
	 * @param file
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/img/goods/detail", method = RequestMethod.POST)
	@ResponseBody
	public UeditorImage goodsDetail(MultipartFile upfile) throws IOException {
		// 富文本框上传图片
		UeditorImage ueditorImage = new UeditorImage();
		try {

			MsgBean msgBean = zhiguFileService.saveImage(upfile, null, "1", null, 975, "goodsd_");

			if (msgBean.getCode() == Code.SUCCESS) {

				ueditorImage.setState("SUCCESS");
				ueditorImage.setUrl(ZhiguConfig.getHost() + ((ZhiguFile) msgBean.getData()).getUri());
				ueditorImage.setOriginal(upfile.getOriginalFilename());
				ueditorImage.setTitle(upfile.getName());

			} else {

				ueditorImage.setState("error");

			}

		} catch (IOException e) {
			// return new MsgBean(Code.FAIL, "图片保存失败，请重试", MsgLevel.ERROR);
			ueditorImage.setState("error");
		}

		return ueditorImage;
	}

	/**
	 * 头像上传
	 * 
	 * @return
	 * @throws IOException
	 * @throws IllegalStateException
	 */
	@RequestMapping("/avatar")
	@ResponseBody
	public MsgBean avatar(@RequestParam(value = "__avatar1", required = false) MultipartFile file) throws IllegalStateException, IOException {

		int userId = SessionHelper.getSessionUser().getUserID();
		String dir = UPLOAD + "/" + DateUtil.format(new Date(), "yyyyMM") + "/";
		String savePath = UploadFileUtil.saveFile(file, dir, "avatar_" + UUID.randomUUID());
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("success", true);
		map.put("sourceUrl", "");
		map.put("avatarUrls", savePath);
		userService.updateAvatar(savePath, userId);
		return new MsgBean(Code.SUCCESS, "success", MsgLevel.NORMAL).setData(map);
	}

	@RequestMapping(value = "/img/userCard", method = RequestMethod.POST)
	@ResponseBody
	public MsgBean imgUserCard(@RequestParam("file") MultipartFile file) {
		try {
			return zhiguFileService.saveImage(file, null, "1", null, 800, "cd_");
		} catch (IOException e) {
			return new MsgBean(Code.FAIL, "图片保存失败，请重试", MsgLevel.ERROR);
		}
	}

	/**
	 * 上传认证图片\身份证，添加水印（该方法将被修改，新的代码禁止使用）
	 * 
	 * @param file
	 * @param imgPreviewID
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/uploadImageFile", method = RequestMethod.POST)
	public void uploadLogoFile(@RequestParam("preImageFile") MultipartFile logoFile, String callBackFun, HttpServletResponse response) throws IOException {
		JSONObject json = new JSONObject();
		try {
			MsgBean msg = zhiguFileService.saveImage(logoFile, null, "1", null, 800, null);
			ZhiguFile zf = (ZhiguFile) msg.getData();
			// 画水印
			try {

				ImageUtil.pressText(zf.getRealPath(), "www.zhiguw.com");
			} catch (IOException e) {

			}

			json.put("code", Code.SUCCESS);
			json.put("url", zf.getUri());
		} catch (IOException e) {
			json.put("code", Code.FAIL);
			json.put("msg", "图片保存失败，请重试");
		}

		PrintWriter writer = response.getWriter();
		writer.print("<script type='text/javascript'>window.parent." + callBackFun + "(" + json + ");</script>");
	}

	/**
	 * 将要读取文件头信息的文件的byte数组转换成string类型表示
	 *
	 * @param src
	 *            要读取文件头信息的文件的byte数组
	 * @return 文件头信息
	 */
	private static String bytesToHexString(byte[] src) {
		StringBuilder builder = new StringBuilder();
		if (src == null || src.length <= 0) {
			return null;
		}
		String hv;

		for (int i = 0; i < src.length; i++) {
			// 以十六进制（基数 16）无符号整数形式返回一个整数参数的字符串表示形式，并转换为大写
			hv = Integer.toHexString(src[i] & 0xFF).toUpperCase();
			if (hv.length() < 2) {
				builder.append(0);
			}
			builder.append(hv);
		}
		return builder.toString();
	}

	@RequestMapping("/dealOldPicture94478361")
	@ResponseBody
	public List dealOldPicture(String key) {
		if (!key.equals("keyhesrt"))
			return null;
		File f = new File(ZhiguConfig.getSaveFileRoot() + UPLOAD);
		List<String> fail = new ArrayList<String>();
		handImg(f, fail);
		return fail;
	}

	public void handImg(File f, List<String> fail) {

		if (f.isDirectory()) {
			File[] f2 = f.listFiles();
			if (f2.length > 0) {
				for (File temp : f2) {
					this.handImg(temp, fail);
				}
			}
		} else {
			try {
				if (f.lastModified() > DateUtils.parseDate("2015-05-22 13:10", "yyyy-MM-dd HH:mm").getTime()) {
					return;
				}
			} catch (ParseException e) {
			}
			String name = f.getName();
			String fullPath = f.getPath();
			if (name.contains("160x160")) {
				String oName = fullPath.substring(0, fullPath.indexOf("_160x160"));
				f.delete();
				ImageUtil.ImageScale(oName, fullPath, 160, 160);
				// BufferedImage srcImg = ImageIO.read(oImg);
				// ImgUtil.createThumb(srcImg, oName + "_285x285.jpg", 285,
				// 285);
				// fail.add(fullPath);
			} else if (name.contains("285x285")) {
				String oName = fullPath.substring(0, fullPath.indexOf("_285x285"));
				f.delete();
				ImageUtil.ImageScale(oName, fullPath, 285, 285);
			}
		}
	}

}

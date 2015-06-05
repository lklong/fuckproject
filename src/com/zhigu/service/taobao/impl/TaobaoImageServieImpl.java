/**
 * 
 */
package com.zhigu.service.taobao.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;

import com.taobao.api.ApiException;
import com.taobao.api.DefaultTaobaoClient;
import com.taobao.api.FileItem;
import com.taobao.api.TaobaoClient;
import com.taobao.api.domain.ItemImg;
import com.taobao.api.domain.Picture;
import com.taobao.api.domain.PictureCategory;
import com.taobao.api.domain.UserInfo;
import com.taobao.api.request.ItemImgUploadRequest;
import com.taobao.api.request.PictureCategoryGetRequest;
import com.taobao.api.request.PictureGetRequest;
import com.taobao.api.request.PictureUploadRequest;
import com.taobao.api.request.PictureUserinfoGetRequest;
import com.taobao.api.response.ItemImgUploadResponse;
import com.taobao.api.response.PictureCategoryGetResponse;
import com.taobao.api.response.PictureGetResponse;
import com.taobao.api.response.PictureUploadResponse;
import com.taobao.api.response.PictureUserinfoGetResponse;
import com.zhigu.common.taobao.TaobaoConfig;
import com.zhigu.common.utils.ZhiguConfig;
import com.zhigu.common.utils.taobao.FileUtil;
import com.zhigu.service.taobao.ITaobaoImageService;

/**
 * 淘宝商品图片，用户图片空间业务处理
 * 
 * @author Administrator
 *
 */

@Service
public class TaobaoImageServieImpl implements ITaobaoImageService {

	private static final Logger LOGGER = Logger.getLogger(TaobaoImageServieImpl.class);

	private static final TaobaoClient client = new DefaultTaobaoClient(TaobaoConfig.API_URL, TaobaoConfig.APP_KEY, TaobaoConfig.APP_SECRET);

	private static final String HTTP = "http";

	/**
	 * 获取用户的图片空间信息
	 * 
	 * @param access_token
	 * @return
	 */
	public UserInfo getUserInfo(String access_token) {

		PictureUserinfoGetRequest req = new PictureUserinfoGetRequest();

		try {

			PictureUserinfoGetResponse response = client.execute(req, access_token);

			return response.getUserInfo();

		} catch (ApiException e) {

			LOGGER.error(e.getMessage());
		}

		return null;

	}

	/**
	 * 获取用户图片分类
	 * 
	 * @param access_token
	 * @return
	 * 
	 */

	public List<PictureCategory> getPictureCategories(String access_token) {

		PictureCategoryGetRequest req = new PictureCategoryGetRequest();

		try {
			PictureCategoryGetResponse response = client.execute(req, access_token);

			return response.getPictureCategories();

		} catch (ApiException e) {

			LOGGER.error(e.getMessage());

		}

		return null;

	}

	/**
	 * 获取用户指定目录下的图片
	 * 
	 * @param access_token
	 * @param picCatId
	 * @return
	 */
	public List<Picture> getPicturesByDirId(String access_token, Long picCatId) {

		PictureGetRequest req = new PictureGetRequest();

		if (picCatId == null) {

			picCatId = 0L;
		}

		req.setPictureCategoryId(picCatId);

		req.setDeleted("0");

		req.setOrderBy("time:desc");

		req.setPageNo(1L);

		req.setPageSize(40L);

		req.setClientType("client:computer");

		try {

			PictureGetResponse response = client.execute(req, access_token);

			return response.getPictures();

		} catch (ApiException e) {

			LOGGER.error(e.getMessage());

		}

		return null;
	}

	public List<ItemImg> uploadItemImg(String access_token, Long numId, String majorUrls) {

		List<ItemImg> itemImgs = new ArrayList<ItemImg>();

		ItemImgUploadRequest req = new ItemImgUploadRequest();

		req.setNumIid(numId);

		String[] urls = majorUrls.split(",");

		String url = "";

		for (int i = 1; i < urls.length; i++) {

			try {

				req.setPosition(Long.valueOf(i));

				url = urls[i].trim();

				if (!url.contains(HTTP)) {

					url = ZhiguConfig.getHost() + url;

				}

				String name = url.substring(url.lastIndexOf("/"));

				byte[] bytes = FileUtil.downloadToByteArray(url);

				FileItem fItem = new FileItem(name, bytes);

				req.setImage(fItem);

				ItemImgUploadResponse response = client.execute(req, access_token);

				itemImgs.add(response.getItemImg());

			} catch (Exception e) {

				LOGGER.error("商品主图上传失败：图片地址为：" + url + "," + e.getMessage());
			}
		}

		return itemImgs;
	}

	public List<Picture> uploadToImageSpace(String access_token, String image_urls) {

		String[] urls = image_urls.split(",");

		List<Picture> pics = new ArrayList<Picture>();

		for (int i = 0; i < urls.length; i++) {

			String url = urls[i];

			pics.add(uploadPicture(url, access_token));

		}

		return pics;

	}

	public String proccessDesc(String desc, String access_token) {

		Document doc = Jsoup.parse(desc, "UTF-8");

		Elements elements = doc.select("img[src]");

		if (elements != null && elements.size() > 0) {

			for (Element img : elements) {

				String src = img.attr("src");

				Picture pic = uploadPicture(src, access_token);

				if (pic != null) {

					img.attr("src", pic.getPicturePath());
				}

			}
		}

		return desc;
	}

	/**
	 * 上传图片
	 * 
	 * @param url
	 * @param access_token
	 * @return
	 */
	private Picture uploadPicture(String url, String access_token) {

		try {

			PictureUploadRequest req = new PictureUploadRequest();

			url = url.trim();

			String name = url.substring(url.lastIndexOf("/"));

			if (!url.contains(HTTP)) {

				url = ZhiguConfig.getHost() + url;

			}

			byte[] bytes = FileUtil.downloadToByteArray(url);

			FileItem fItem = new FileItem(name, bytes);

			req.setImg(fItem);

			req.setPictureCategoryId(0L);

			req.setImageInputTitle(name);

			req.setClientType("client:computer");

			PictureUploadResponse response = client.execute(req, access_token);

			Picture pic = response.getPicture();

			return pic;

		} catch (Exception e) {

			LOGGER.error("商品描述图片处理错误：图片地址是" + url + "," + e.getMessage());

		}

		return null;

	}

}

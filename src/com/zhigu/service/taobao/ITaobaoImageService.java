/**
 * 
 */
package com.zhigu.service.taobao;

import java.io.IOException;
import java.util.List;

import com.taobao.api.ApiException;
import com.taobao.api.domain.ItemImg;
import com.taobao.api.domain.Picture;
import com.taobao.api.domain.PictureCategory;
import com.taobao.api.domain.UserInfo;

/**
 * @author Administrator
 *
 */
public interface ITaobaoImageService {

	/**
	 * 获取用户的图片空间信息
	 * 
	 * @param access_token
	 * @return
	 */
	public UserInfo getUserInfo(String access_token);

	/**
	 * 获取用户图片分类
	 * 
	 * @param access_token
	 * @return
	 * 
	 */

	public List<PictureCategory> getPictureCategories(String access_token);

	/**
	 * 获取用户指定目录下的图片
	 * 
	 * @param access_token
	 * @param picCatId
	 * @return
	 */
	public List<Picture> getPicturesByDirId(String access_token, Long picCatId);

	/**
	 * 图片一键搬家功能
	 * 
	 * @param access_token
	 * @param image_url
	 * @return
	 */
	public List<Picture> uploadToImageSpace(String access_token, String image_urls);

	/**
	 * 商品主图上传
	 * 
	 * @return
	 */
	public List<ItemImg> uploadItemImg(String access_token, Long numId, String majorUrls);

	/**
	 * 商品属性图片处理
	 * 
	 * @param desc
	 * @param access_token
	 * @return
	 * @throws IOException
	 * @throws ApiException
	 */
	public String proccessDesc(String desc, String access_token);

}

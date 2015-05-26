package com.zhigu.service.alibaba.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeoutException;

import org.springframework.stereotype.Service;

import com.alibaba.openapi.client.Request;
import com.zhigu.common.alibaba.AlibabaUtil;
import com.zhigu.service.alibaba.AliPhotoAlbumService;

/**
 * 图片相册
 * 
 * @author Administrator
 *
 */
@Service
public class AliPhotoAlbumServiceImpl implements AliPhotoAlbumService {

	/**
	 * 本接口实现根据相册id获取相册信息
	 * 
	 * @param albumId
	 * @param accessToken
	 * @return
	 * @throws InterruptedException
	 * @throws ExecutionException
	 * @throws TimeoutException
	 */
	@Override
	public Object getPhotoAlbumByAlbumId(Long albumId, String accessToken) throws InterruptedException, ExecutionException, TimeoutException {

		Request apiRequest = new Request(NAME_SPACE, "ibank.album.get", VERSION);

		apiRequest.setParam("albumId", albumId);

		Object object = AlibabaUtil.callAPI(accessToken, apiRequest, Object.class, true, true);

		return object;
	}

	/**
	 * 本接口实现根据上传图片
	 * 
	 * @param albumId
	 * @param accessToken
	 * @return
	 * @throws InterruptedException
	 * @throws ExecutionException
	 * @throws TimeoutException
	 */
	@SuppressWarnings("unchecked")
	@Override
	public String uploadPhoto(Long albumId, String fileName, byte[] bytes, String accessToken) throws InterruptedException, ExecutionException, TimeoutException {

		Request apiRequest = new Request(NAME_SPACE, "ibank.image.upload", VERSION);

		apiRequest.setParam("albumId", albumId);

		apiRequest.setParam("name", fileName);

		apiRequest.setParam("imageBytes", bytes);

		Map<String, Object> object = AlibabaUtil.callAPI(accessToken, apiRequest, Map.class, true, true);

		String url = img_host + (String) AlibabaUtil.getReturnFromMap(object).get(0).get("url");

		return url;
	}

	/**
	 * 本接口实现创建相册功能
	 * 
	 * @param albumId
	 * @param accessToken
	 * @return
	 * @throws InterruptedException
	 * @throws ExecutionException
	 * @throws TimeoutException
	 */
	@SuppressWarnings("unchecked")
	@Override
	public Long createPhotoAlbum(String name, String accessToken) throws InterruptedException, ExecutionException, TimeoutException {

		Request apiRequest = new Request(NAME_SPACE, "ibank.album.create", VERSION);

		apiRequest.setParam("name", name);

		// 相册访问权限。取值范围:0-不公开；1-公开；2-密码访问。只有开通旺铺的会员可以设置相册访问权限为“1-公开”和“2-密码访问”，未开通旺铺的会员相册访问权限限制为“0-不公开”。

		apiRequest.setParam("authority", 1);

		Map<String, Object> object = AlibabaUtil.callAPI(accessToken, apiRequest, Map.class, true, true);

		Map<String, Object> result = (Map<String, Object>) object.get("result");

		List<Map<String, Integer>> toReturn = (ArrayList<Map<String, Integer>>) result.get("toReturn");

		return Long.valueOf(toReturn.get(0).get("albumId").toString());

	}

	/**
	 * 本接口实现获取当前用户相册列表
	 * 
	 * @param albumId
	 * @param accessToken
	 * @return
	 * @throws InterruptedException
	 * @throws ExecutionException
	 * @throws TimeoutException
	 */
	@Override
	public Object getPhotoAlbumList(Long albumType, String accessToken) throws InterruptedException, ExecutionException, TimeoutException {

		Request apiRequest = new Request(NAME_SPACE, "ibank.album.list", VERSION);

		// CUSTOM-自定义相册；MY-我的相册；
		apiRequest.setParam("albumType", albumType);

		Object object = AlibabaUtil.callAPI(accessToken, apiRequest, Object.class, true, true);

		return object;
	}

	/**
	 * 本接口实现获取当前用户相册内图片列表
	 * 
	 * @param albumId
	 * @param accessToken
	 * @return
	 * @throws InterruptedException
	 * @throws ExecutionException
	 * @throws TimeoutException
	 */
	@Override
	public Object getPhotoList(Long albumId, String accessToken) throws InterruptedException, ExecutionException, TimeoutException {

		Request apiRequest = new Request(NAME_SPACE, "ibank.image.list", VERSION);

		apiRequest.setParam("albumId", albumId);

		Object object = AlibabaUtil.callAPI(accessToken, apiRequest, Object.class, true, true);

		return object;
	}

	/**
	 * 本接口实现获取当前用户的图片信息
	 * 
	 * @param albumId
	 * @param accessToken
	 * @return
	 * @throws InterruptedException
	 * @throws ExecutionException
	 * @throws TimeoutException
	 */
	@Override
	public Object getImage(Long imageId, String accessToken) throws InterruptedException, ExecutionException, TimeoutException {

		Request apiRequest = new Request(NAME_SPACE, "ibank.image.get", VERSION);

		apiRequest.setParam("imageId", imageId);

		Object object = AlibabaUtil.callAPI(accessToken, apiRequest, Object.class, true, true);

		return object;
	}

	/**
	 * 本接口实现获取当前用户信息，包括可用空间和总空间等
	 * 
	 * @param albumId
	 * @param accessToken
	 * @return
	 * @throws InterruptedException
	 * @throws ExecutionException
	 * @throws TimeoutException
	 */
	@Override
	public Object getPhotoAlbum(String accessToken) throws InterruptedException, ExecutionException, TimeoutException {

		Request apiRequest = new Request(NAME_SPACE, "ibank.profile.get", VERSION);

		Object object = AlibabaUtil.callAPI(accessToken, apiRequest, Object.class, true, true);

		return object;
	}

}

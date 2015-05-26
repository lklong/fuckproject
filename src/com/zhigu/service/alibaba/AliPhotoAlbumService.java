package com.zhigu.service.alibaba;

import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeoutException;

import com.zhigu.common.alibaba.AlibabaConfig;

/**
 * 图片相册
 * 
 * @author Administrator
 *
 */
public interface AliPhotoAlbumService extends AlibabaConfig {

	Object getPhotoAlbum(String accessToken) throws InterruptedException, ExecutionException, TimeoutException;

	Object getImage(Long imageId, String accessToken) throws InterruptedException, ExecutionException, TimeoutException;

	Object getPhotoList(Long albumId, String accessToken) throws InterruptedException, ExecutionException, TimeoutException;

	Object getPhotoAlbumList(Long albumType, String accessToken) throws InterruptedException, ExecutionException, TimeoutException;

	Long createPhotoAlbum(String name, String accessToken) throws InterruptedException, ExecutionException, TimeoutException;

	String uploadPhoto(Long albumId, String fileName, byte[] bytes, String accessToken) throws InterruptedException, ExecutionException, TimeoutException;

	Object getPhotoAlbumByAlbumId(Long albumId, String accessToken) throws InterruptedException, ExecutionException, TimeoutException;

}

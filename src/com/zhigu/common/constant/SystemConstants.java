package com.zhigu.common.constant;

/**
 * 
 * 
 * SystemConstants
 * 
 * Michael
 * 
 * 2014年07月16日
 * 
 * @version 1.0.0
 *
 */
public interface SystemConstants {

	public static final String RANDOM_KEY = "iL9J_l?265scopxx";

	/**
	 * 分页默认每页记录数
	 * 
	 */
	public static int PAGINATION_PAGE_SIZE = 20;
	/**
	 * 分页最大每页记录数
	 * 
	 */
	public static final int PAGINATION_PAGE_MAX_SIZE = 50;
	/**
	 * 默认的头像
	 */
	public static String DEFAULT_AVATAR = "/img/navigator_middle.jpg";

	/**
	 * 图片水印文字
	 */
	public static final String WATERMARK_TEXT = "http://www.zhiguw.com";
	/**
	 * 乐观锁，数据更新错误消息
	 */
	public static final String DB_UPDATE_FAILED_MSG = "This record update failed!";
}

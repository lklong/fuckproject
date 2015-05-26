package com.zhigu.common.exception;

/**
 * 业务异常
 * 
 * @author HeSiMin
 * @date 2014年11月23日
 *
 */
public class ServiceException extends RuntimeException {

	private static final long serialVersionUID = 5804020344997540110L;

	public ServiceException(Exception e) {
		super(e);
	}

	public ServiceException(String message) {
		super(message);
	}

	public ServiceException(String message, Exception e) {
		super(message, e);
	}

}

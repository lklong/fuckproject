package com.zhigu.common.exception;

/**
 * 用户输入异常
 * 
 * @author HeSiMin
 * @date 2014年12月18日
 *
 */
public class InputException extends Exception {

	public InputException() {
		super();
	}

	public InputException(String msg) {
		super(msg);
	}

	public InputException(String msg, Throwable cause) {
		super(msg, cause);
	}

	public InputException(Throwable cause) {
		super(cause);
	}

}

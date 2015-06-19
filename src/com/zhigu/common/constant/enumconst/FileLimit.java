package com.zhigu.common.constant.enumconst;

import java.util.Arrays;
import java.util.List;

public enum FileLimit {
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

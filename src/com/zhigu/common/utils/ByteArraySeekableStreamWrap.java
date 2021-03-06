/**
 * @ClassName: d.java
 * @Author: liukailong
 * @Description: 
 * @Date: 2015年6月4日
 * 
 */
package com.zhigu.common.utils;

/*
 * Copyright 1999-2101 Alibaba Group.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import java.io.IOException;
import java.io.InputStream;

import org.apache.commons.io.IOUtils;

import com.sun.media.jai.codec.ByteArraySeekableStream;

public class ByteArraySeekableStreamWrap extends ByteArraySeekableStream {

	public static ByteArraySeekableStreamWrap wrapInputStream(InputStream is) throws IOException {
		byte[] data = IOUtils.toByteArray(is);
		ByteArraySeekableStreamWrap stream = new ByteArraySeekableStreamWrap(data);

		return stream;
	}

	public ByteArraySeekableStreamWrap(byte[] src, int offset, int length) throws IOException {
		super(src, offset, length);
	}

	public ByteArraySeekableStreamWrap(byte[] src) throws IOException {
		super(src);
	}

}

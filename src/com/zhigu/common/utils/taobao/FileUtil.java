/**
 * 
 */
package com.zhigu.common.utils.taobao;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.junit.Test;

/**
 * @author Administrator
 *
 */
public class FileUtil {

	/**
	 * 下载网络图片到本地
	 * 
	 * @param netPath
	 * @param locaPath
	 * @throws IOException
	 */
	public void downloadToLocation(String netPath, String locaPath) throws IOException {

		String fileName = netPath.substring(netPath.lastIndexOf("/"), netPath.length());

		locaPath = (new StringBuilder(String.valueOf(locaPath))).append(fileName).toString();

		File file = new File(locaPath);

		FileUtils.copyURLToFile(new URL(netPath), file);

	}

	/**
	 * 将网络图片解析为流
	 * 
	 * @param netPath
	 * @return
	 * @throws MalformedURLException
	 * @throws IOException
	 */
	public static byte[] downloadToByteArray(String netPath) throws MalformedURLException, IOException {

		java.io.InputStream in = (new URL(netPath)).openStream();

		byte imagebyte[] = IOUtils.toByteArray(in);

		IOUtils.closeQuietly(in);

		return imagebyte;
	}

	/**
	 * 测试
	 * 
	 * @throws IOException
	 */
	@Test
	public void testdownloadToLocation() throws IOException {

		String netPath = "http://c.hiphotos.baidu.com/image/pic/item/5fdf8db1cb13495453bb9e33554e9258d1094a3b.jpg";

		String locaPath = "F:/image";

		downloadToLocation(netPath, locaPath);

	}

}

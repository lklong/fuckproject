/**
 * 
 */
package com.zhigu.common.utils.taobao;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

/**
 * @author Administrator
 * 
 * @description 该类用于从html字符串中提取链接
 *
 */
public class HtmlUtil {

	/**
	 * 从描述中提取图片的src属性
	 * 
	 * @param desc
	 * @return
	 */
	@Deprecated
	public static List<String> getImageSrcFromTag(String desc) {

		String regexImage = "<img.+?src=\"(.+?)\".+?/?>";

		String imageTag = "";

		String imageSrc = "";

		List<String> images = new ArrayList<String>();

		Pattern p = Pattern.compile(regexImage, Pattern.CASE_INSENSITIVE);

		Matcher m = p.matcher(desc);

		while (m.find()) {

			imageTag = m.group();

			imageSrc = m.group(1);

			images.add(imageSrc);

		}

		return images;

	}

	/**
	 * 从描述中提取图片的src属性
	 * 
	 * @param desc
	 * @return
	 */
	public static List<String> getAttrValueFromHtml(String desc, String tagName, String attrName) {

		// 用于存放图片地址集合
		List<String> images = new ArrayList<String>();

		Document document = Jsoup.parse(desc);

		Elements elements = document.getElementsByTag(tagName);

		for (Element element : elements) {

			String imgSrc = element.attr(attrName);

			images.add(imgSrc);

		}

		return images;

	}

}

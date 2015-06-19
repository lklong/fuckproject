/**
 * @ClassName: GeoIPUtils.java
 * @Author: liukailong
 * @Description: 
 * @Date: 2015年6月9日
 * 
 */
package com.zhigu.common.utils.geoip;

import java.io.IOException;
import java.io.InputStream;
import java.net.InetAddress;

import org.apache.log4j.Logger;

import com.maxmind.geoip2.DatabaseReader;
import com.maxmind.geoip2.model.CityResponse;
import com.maxmind.geoip2.record.City;
import com.maxmind.geoip2.record.Country;
import com.maxmind.geoip2.record.Subdivision;
import com.zhigu.common.utils.ClassLoaderUtil;

/**
 * @author Administrator 文件调用方式
 */
public class GeoIPUtils {

	private static final Logger LOGGER = Logger.getLogger(GeoIPUtils.class);

	private static DatabaseReader reader = null;

	static {
		// File database = new File("GeoLite2-City.mmdb");

		try {
			InputStream in = ClassLoaderUtil.getStream("GeoLite2-City.mmdb");

			// reader = new DatabaseReader.Builder(database).build();

			reader = new DatabaseReader.Builder(in).build();

		} catch (IOException e) {

			LOGGER.error("初始化GEOIP数据库失败：" + e.getMessage());

		}

	}

	public static GeoVO getAddressByIP(String ip) {

		GeoVO geoVO = new GeoVO();
		try {

			InetAddress ipAddress = InetAddress.getByName(ip);
			if (ipAddress == null) {
				geoVO.setCountry("中国");
				geoVO.setCity("成都市");
				geoVO.setProvince("四川省");
				return geoVO;
			}

			CityResponse response = reader.city(ipAddress);

			Country country = response.getCountry();
			geoVO.setCountry(country.getNames().get("zh-CN"));

			Subdivision province = response.getMostSpecificSubdivision();
			geoVO.setProvince(province.getNames().get("zh-CN"));

			City city = response.getCity();
			geoVO.setCity(city.getNames().get("zh-CN") + "市");

		} catch (Exception e) {

			LOGGER.error("获取地址失败：", e);

			geoVO.setCountry("中国");
			geoVO.setCity("成都市");
			geoVO.setProvince("四川省");

		}

		return geoVO;

	}
}

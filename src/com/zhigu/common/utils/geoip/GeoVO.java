package com.zhigu.common.utils.geoip;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang3.builder.ReflectionToStringBuilder;

public class GeoVO {

	private String country;

	private String city;

	private String province;

	private String district;

	private String cityCode;

	private String provinceCode;

	private String districtCode;

	public String getCityCode() {
		return cityCode;
	}

	public void setCityCode(String cityCode) {
		this.cityCode = StringUtils.isNotBlank(cityCode) ? cityCode.trim() : null;
	}

	public String getProvinceCode() {
		return provinceCode;
	}

	public void setProvinceCode(String provinceCode) {
		this.provinceCode = StringUtils.isNotBlank(provinceCode) ? provinceCode.trim() : null;
	}

	public String getDistrictCode() {
		return districtCode;
	}

	public void setDistrictCode(String districtCode) {
		this.districtCode = StringUtils.isNotBlank(districtCode) ? districtCode.trim() : null;
	}

	public String getDistrict() {
		return district;
	}

	public void setDistrict(String district) {
		this.district = StringUtils.isNotBlank(district) ? district.trim() : null;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = StringUtils.isNotBlank(country) ? country.trim() : null;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = StringUtils.isNotBlank(city) ? city.trim() : null;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = StringUtils.isNotBlank(province) ? province.trim() : null;
	}

	@Override
	public String toString() {
		return ReflectionToStringBuilder.toString(this);
	}

}

package com.zhigu.mapper;

import org.apache.ibatis.annotations.Param;

import com.zhigu.model.PhoneSend;

public interface PhoneSendMapper {
	int deleteByPrimaryKey(Long id);

	int insert(PhoneSend record);

	int insertSelective(PhoneSend record);

	PhoneSend selectByPrimaryKey(Long id);

	int updateByPrimaryKeySelective(PhoneSend record);

	int updateByPrimaryKey(PhoneSend record);

	/**
	 * 
	 * @param phone
	 * @param ip
	 * @param addStartDate
	 *            '2015-05-26'
	 * @return
	 */
	int countPhoneSend(@Param("phone") String phone, @Param("ip") String ip, @Param("addStartDate") String addStartDate);

	PhoneSend selectByPhoneAndType(@Param("phone") String phone, @Param("type") int type);
}
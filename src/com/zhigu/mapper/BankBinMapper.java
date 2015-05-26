package com.zhigu.mapper;

import com.zhigu.model.BankBin;

public interface BankBinMapper {
	int deleteByPrimaryKey(Integer id);

	int insert(BankBin record);

	int insertSelective(BankBin record);

	BankBin selectByPrimaryKey(Integer id);

	int updateByPrimaryKeySelective(BankBin record);

	int updateByPrimaryKey(BankBin record);

	BankBin selectByBin(String bin);
}
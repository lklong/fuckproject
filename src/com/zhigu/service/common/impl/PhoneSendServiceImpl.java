package com.zhigu.service.common.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhigu.mapper.PhoneSendMapper;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.common.IPhoneSendService;

@Service
public class PhoneSendServiceImpl implements IPhoneSendService {
	@Autowired
	private PhoneSendMapper phoneSendMapper;

	@Override
	public MsgBean send(String phone, int type) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MsgBean verify(String phone, int type, String captcha) {
		// TODO Auto-generated method stub
		return null;
	}

}

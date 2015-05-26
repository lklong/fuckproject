package com.zhigu.service.message.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhigu.mapper.MessageSendMapper;
import com.zhigu.model.Message;
import com.zhigu.service.message.IMessageSendService;

@Service("messageSendServiceImpl")
public class MessageSendServiceImpl implements IMessageSendService {
	@Autowired
	private MessageSendMapper messageSendDao;

	@Override
	public List<Message> queryUnSendMessage() {
		List<Message> messageList = messageSendDao.queryUnSendMessage();
		return messageList;
	}

	@Override
	public int updateToSending(List<Message> messgaeList) {
		return messageSendDao.updateToSending(messgaeList);
	}

	@Override
	public List<Message> querySendingMessage(int userId) {
		return messageSendDao.querySendingMessage(userId);
	}

	@Override
	public int sendMessage(Message message) {
		return messageSendDao.sendMessage(message);
	}

}

package com.zhigu.mapper;

import java.util.List;

import com.zhigu.model.Message;

public interface MessageSendMapper {

	List<Message> queryUnSendMessage();

	int updateToSending(List<Message> messgaeList);

	List<Message> querySendingMessage(int userId);

	int sendMessage(Message message);

}

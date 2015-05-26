package com.zhigu.service.message;

import java.util.List;

import com.zhigu.model.Message;

public interface IMessageSendService {

	/* 查询未发送的信息 */
	List<Message> queryUnSendMessage();

	/* 查询指定用户发送中的信息 */
	List<Message> querySendingMessage(int userId);

	/* 修改已发的信息为发送中 */
	int updateToSending(List<Message> messgaeList);

	/* 发送一个消息 */
	int sendMessage(Message message);

}

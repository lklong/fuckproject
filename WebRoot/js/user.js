if (typeof zhigu == "undefined" || !zhigu) {
	var zhigu = {};
}
zhigu.request = {};
//  服务器请求--》用户消息操作
zhigu.request.usermessage = function(opcode,paramObj,callFunction){// 操作码、参数对象、回调函数
	ajaxSubmit("/message/user/message",{"opcode":opcode,"paramJson":zhigu.encodeBase64(zhigu.objToJson(paramObj))},function(msgBean){
		if(typeof callFunction =='function'){
			callFunction(msgBean);
		}
	});
}
//$(function(){
//	zhigu.request.usermessage("m00003",{"content":"消息发送测试","receiveUserId":2999},function(msgBean){
//		alert(msgBean.msg);
//	});
//})
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>推广</title>
<style type="text/css">
</style>
</head>
<body>

<div class="rightContainer">
    	<!--// 标题 //-->
        <h3 class="rc_title">
        	推广链接<a href="user/home">我的主页</a>
        </h3>
        <!--// 内容框 //-->
		<div class="rc_body">
        	<!--// tab切换条 //-->
            <div id="userCommTab" class="userCommTab">
            	<ul>
                	<li><a href="javascript:void(0);" class="uctSelected">推广链接</a></li>
                </ul>
            </div>
            <div id="userContents" class="userContents">
            	<!--// 内容1 //-->
            	<div class="body_center2">
		<div class="f16 fwbold mt30">1.您可以复制下面的链接发与好友，邀请他们加入智谷同城货源网！</div>
		<div style="padding:20px 0 0 0px ;font-size: 14px;">推广链接地址：<span style="color:red">${recommendUrl }</span></div>
		<div class="mt20">将推广链接分享到：
			<div class="bdsharebuttonbox"><a href="#" class="bds_more" data-cmd="more"></a><a title="分享到QQ好友" href="#" class="bds_sqq" data-cmd="sqq"></a><a title="分享到微信" href="#" class="bds_weixin" data-cmd="weixin"></a><a title="分享到新浪微博" href="#" class="bds_tsina" data-cmd="tsina"></a><a title="分享到腾讯微博" href="#" class="bds_tqq" data-cmd="tqq"></a><a title="分享到人人网" href="#" class="bds_renren" data-cmd="renren"></a><a title="分享到QQ空间" href="#" class="bds_qzone" data-cmd="qzone"></a></div>
		</div>
<!-- 		<form id="saveUserRecommend"> -->
<!-- 			<div class="f16 fwbold mt30">2.您也可以主动推荐好友加入智谷同城货源网，只需要填写以下信息即可！</div> -->
<!-- 			<div class="mt10"> -->
<!-- 				<div class="f14">填写被推荐人：</div> -->
<!-- 				<table id="userRecommend"> -->
<!-- 					<tr><td class="urdtd">姓名</td><td><input class="uinput" name="recommendName" maxlength="8"/> </td></tr> -->
<!-- 					<tr><td class="urdtd">手机</td><td><input class="uinput" name="recommendPhone" maxlength="11"/> </td></tr> -->
<!-- 					<tr><td colspan="2"><input class="duihuanbtn" style="margin-left:165px;" type="button" value="提交" onclick="saveUserRecommend();"/> </td></tr> -->
<!-- 				</table> -->
<!-- 			</div> -->
<!-- 		</form> -->
<!-- 		<div class="mt30"> -->
<!-- 			<div class="f16 fwbold">填写的被推荐人（有效期15天）：</div> -->
<!-- 			<table id="userWriteRecommend" style="width: 100%;border: 1px solid #DEDEDE ; text-align: center;" > -->
<!-- 				<thead><tr class="recomdhead" ><th>姓名</th><th>手机</th><th>添加时间</th><th>是否注册</th><th>删除</th></tr></thead> -->
<!-- 				<tbody id="tip_no_data1"> -->
<!-- 				<tr ><td colspan="3">暂无数据！</td></tr> -->
<!-- 				</tbody> -->
<!-- 			</table> -->
<!-- 		</div> -->
<!-- 		<div class="mt30"> -->
<!-- 			<div class="f16 fwbold">已注册的被推荐人：</div> -->
<!-- 			<table id="recommended" style=" text-align: center;" > -->
<!-- 				<thead><tr class="recomdhead"><th>账户号</th><th>手机</th><th>邮箱</th></tr></thead> -->
<!-- 				<tbody id="tip_no_data2"><tr ><td colspan="3">暂无数据！</td></tr></tbody> -->
<!-- 			</table> -->
<!-- 		</div> -->
	</div>
     </div>
            <br style="clear:both;" />
        </div>
    </div>
<div class="clear"></div>
<script type="text/javascript">
if (typeof zhigu == "undefined" || !zhigu) {
    var zhigu = {};
}
$(function(){
	ajaxSubmit("/user/recommended",{},function(data){
		var html="";
		for(var i=0;i<data.length;i++){
			var userInfo = data[i];
			html+="<tr algin='center'>";
			html+="<td>"+userInfo.userName+"</td>";
			html+="<td>"+(userInfo.phone==null?"无":userInfo.phone)+"</td>";
			html+="<td>"+(userInfo.email==null?"无":userInfo.email)+"</td>";
			html+="</tr>";
		}
		$("#tip_no_data2").html(html);
	},"json");
	loadUserWriteRecommend();
});
// 加载填写过的推荐
function loadUserWriteRecommend(){
	ajaxSubmit("/user/queryUserWriteRecommend",{},function(data){
		var html="";
		for(var i=0;i<data.length;i++){
			var userRecommend = data[i];
			html+="<tr>";
			html+="<td>"+userRecommend.recommendName+"</td>";
			html+="<td>"+userRecommend.recommendPhone+"</td>";
			html+="<td>"+new Date(userRecommend.addTime).format('yyyy-MM-dd')+"</td>";
			html+="<td>"+(userRecommend.isRegister==1?"已注册":("未注册 <input type='button' onclick='zhigu.sendRecommendSMS("+userRecommend.recommendPhone+",this)' value='发送推荐短信'>"))+"</td>";
			html+="<td><input type='button' onclick='zhigu.deleteUserWriteRecommend("+userRecommend.id+")' value='删除'></td>";
			html+="</tr>";
		}
		$("#tip_no_data1").html(html);
	},"json");
}
zhigu.sendRecommendSMS = function(phone,obj){
	ajaxSubmit("/user/sendRecommendSMS",{"phone":phone},function(result){
		if(result.code==1){
			$(obj).val("已发送");
			$(obj).prop("disabled",true);
		}else{
			dialog(result.msg);
		}
	})
}
zhigu.deleteUserWriteRecommend = function(id){
	ajaxSubmit("/user/deleteUserWriteRecommend",{"id":id},function(msgBean){
		dialog(msgBean.msg,function(){
			if(msgBean.code==zhigu.code.success){
				loadUserWriteRecommend();
			}
		});
	})
}
function saveUserRecommend(){
	var flg = true;
	$("#saveUserRecommend input").each(function(){
		if(!$(this).val())flg=false;
	});
	if(!flg){
		dialog("请填写完整信息！");
		return;
	}
	ajaxSubmit("/user/saveUserRecommend",$("#saveUserRecommend").serialize(),function(data){
		dialog(data.msg);
		if(data.code==1){
			$("#saveUserRecommend")[0].reset();
			loadUserWriteRecommend();
		}
	})
}
window._bd_share_config={
		"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdMiniList":false,"bdPic":"","bdStyle":"0","bdSize":"16",
							bdText:"【智谷同城货源网】最专业，最方便，最快捷的同城货源平台",bdDesc:"【智谷同城货源网】最专业，最方便，最快捷的同城货源平台",bdUrl:"${recommendUrl }",bdPic:"/img/logo2.png"
		},
		"share":{}
		};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];
</script>
</body>
</html>
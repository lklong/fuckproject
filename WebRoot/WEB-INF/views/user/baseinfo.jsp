<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>基本信息</title>
<script type="text/javascript" src="js/pca.js"></script>
</head>
<body>
<div class="rightContainer">
		<!--// 标题 //-->
		<h3 class="rc_title">
			基本资料<a href="user/home">我的主页</a>
		</h3>
		<!--// 内容框 //-->
		<div class="rc_body">
			<!--// tab切换条 //-->
			<div id="userCommTab" class="userCommTab">
				<ul>
					<li><a href="javascript:void(0);" class="uctSelected">基本资料</a></li>
				</ul>
			</div>
			<div id="userContents" class="userContents">
				<!--// 内容1 //-->
				<div class="body_center2">
			<div class="jbzl">
				<div class="jbzltouxiang">
					<img src="${info.avatar}" id="avatarpic" style="width: 120px;height: 120px;"/>
					<div><a href="javascript:void(0)" onclick="avatar()">编辑头像</a></div> 
				</div>
				<div class="jbzlbox">
					<div class="jbzlr">
						<span class="gantanhao ml10 mr10"></span>用户名可用于登录同城货源网，只能修改一次。
					</div>
					<div class="jbzlformbox mt20">
						<form action="user/info/modify" id="infoForm" method="post">
							<div class="jbzil1">
								<p class="zititle">用户名：</p>
								<c:choose>
									<c:when test="${info.usernameModify == 0}">
										<input type="text" name="username" value="${auth.username }" maxlength="25" class="dpname"/>
									</c:when>
									<c:otherwise>
										${auth.username }
									</c:otherwise>
								</c:choose>
								
							</div>
							<div class="jbzil1">
								<p class="zititle">性别：</p>
								<span class="fl"><input checked="checked" type="radio" name="gender" value="1"/>&nbsp;男</span> <span class="fl ml20"><input <c:if test="${info.gender == 2 }">checked="checked"</c:if> type="radio" name="gender" value="2"/>&nbsp;女</span>
								
							</div>
							<div class="jbzil1">
								<p class="zititle">所在地区：</p>
								<select name="province" id="province" style="width: 130px;" class="dpname">
								</select>
								<select name="city" id="city" style="width: 130px;" class="dpname">
								</select>
								<select name="district" id="district" style="width: 130px;" class="dpname">
								</select>
								
							</div>
							<div class="jbzil1">
								<p class="zititle">街道：</p>
								<input name="street" id="street" maxlength="200" value="${info.street }" style="width: 320px;" class="dpname"/>
								
							</div>
							<div class="jbzil1">
								<p class="zititle">邮编：</p>
								<input type="text" name="postCode" value="${info.postCode }" class="dpname"/>
								
							</div>
							<div class="jbzil1">
								<p class="zititle">固定电话：</p>
								<input type="text" id="tel" name="tel" value="${info.tel }" placeholder="格式：区号-座机号"  class="dpname"/>
							</div>
							<div class="jbzil1">
								<p class="zititle">QQ号码：</p>
								<input type="text" name="QQ" value="${info.QQ }"  class="dpname"/>
								
							</div>
							<div class="jbzil1">
								<p class="zititle">阿里旺旺：</p>
								<input type="text" name="aliWangWang" value="${info.aliWangWang }" class="dpname"/>
								
							</div>
							<input class="baocun mt10 submit cp" type="button" value="保存" id="saveBaseInfo"/>
						</form>
					</div>
				</div>
			</div>
		</div>
				
	 </div>
			<br style="clear:both;" />
		</div>
	</div>




		<div class="clear"></div>
		<div id="avatarDiv" style="display: none;">
			<iframe src="js/3rdparty/avatar/header.jsp" id="headFram" style="border: 1px;" scrolling="no" width="650" height="450"></iframe>
		</div>
	<script type="text/javascript">
		$().ready(function() {
			//初始化
			var pca = new PCAS("province", "city", "district","${info.province}","${info.city}","${info.district}");
			$("#infoForm").validate({
				rules:{
					district:{required:function(){
						return !isEmpty($("#street").val());
					}},
					street:{maxlength:255},
					postCode:{postCode:true},
					tel:{tel:true},
					QQ:{number:true,maxlength:11},
					aliWangWang:{maxlength:32}
					
				},
				submitHandler:function(form){
					ajaxSubmit($(form).attr("action"), $(form).serialize(), function(data){
						dialog(data.msg);
					},"json");
				}
			});
			$("#saveBaseInfo").click(function(){
				ajaxSubmit("/user/info/modify",$("#infoForm").serialize(),function(data){
					dialog(data.msg,function(){
						if(data.code==zhigu.code.success){
							f5();
						}
					})
				});
			});
		});
		//头像
		var avatarDialogId;
		function avatar(){
			//zhigu.dialog($("#avatarDiv").html(), null, 700, 530, "头像上传",false);
			//alertDialog($("#avatarDiv").html(),null,null,700,580,'头像上传');
			avatarDialogId = $.layer({
				   type: 1,   //0-4的选择,
				    title: "上传头像",
				    closeBtn: [0, true],
				    area: ['650px', '490px'],
				    page: {
				        html:$("#avatarDiv").html()
				    }
				});
		}
		//重置头像
		function reAvatar(url){
			$("#avatarpic").attr("src","" + url + "?r=" + Math.random());
			setTimeout(function () { 
				layer.close(avatarDialogId);
			}, 1000);
		}
	</script>
</body>
</html>
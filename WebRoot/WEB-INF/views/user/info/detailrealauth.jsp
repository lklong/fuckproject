<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/jcDate.css"
	media="all" />

<script type="text/javascript" src="js/ajaxfileupload.js"></script>

<title>实名认证</title>
</head>
<body >

<div class="rightContainer">
    	<!--// 标题 //-->
        <h3 class="rc_title">
        	认证审核<a href="user/home">我的主页</a>
        </h3>
        <!--// 内容框 //-->
		<div class="rc_body">
        	<!--// tab切换条 //-->
            <div id="userCommTab" class="userCommTab">
            	<ul>
                	<li><a href="javascript:void(0);" class="uctSelected">认证审核</a></li>
                </ul>
            </div>
            <div id="userContents" class="userContents">
            	<!--// 内容1 //-->
            	



	<input type="hidden" id="approveState" value="${approveState}">
	<div class="body_center2">
		<form method="post" action="user/addrealauth" id="authForm" enctype="multipart/form-data">
			<div class="shimingform mt20">
				<c:if test="${realUserAuth.approveState==1}">
					<div class="shimingbox">
						<strong class="red"  style="position:relative;left:80px;">* 信息正在审核中 *</strong>
					</div>
				</c:if>
				<c:if test="${realUserAuth.approveState==2}">
					<div class="shimingbox">
						<strong class="red"  style="position:relative;left:80px;">* 已通过审核 *</strong>
					</div>
				</c:if>
				<div class="shimingbox">
					<p class="smtitle">账户名:</p>
					<p class="smneirong">${userAuth.username}</p>
					<div class="clear"></div>
				</div>
				
				
				<div class="shimingbox">
					<p class="smtitle"><span class="smxing">*</span>真实姓名:</p>
					<p class="smneirong">${realUserAuth.realName}</p>
					<div class="clear"></div>
				</div>
				
					<div class="shimingbox">
					<p class="smtitle"><span class="smxing">*</span>身份证号码:</p>
					<p class="smneirong">	${realUserAuth.idCard}</p>
					<div class="clear"></div>
				</div>
				
				<div class="shimingbox">
					<p class="smtitle"><span class="smxing">*</span>身份证到期时间:</p>
					<p class="smneirong"><c:if test="${!empty  realUserAuth.cardValidity}">
							${realUserAuth.cardValidity}
					</c:if>
					<c:if test="${realUserAuth.perpetual==1}">
							长期
					</c:if></p>
					<div class="clear"></div>
				</div>
				
				
				
				
				<div class="shimingbox" id="shimingbox1">
					<p class="smtitle">
						<span class="smxing">*</span>身份证正面：
					</p>
					<div class="sfzbox fl" id="bimg1"  style="margin-top: 17px;" >
						<img height="165px;" width="244px;" id="IDCard2" src="${realUserAuth.cardFrontImg}">
					</div>
					<div class="shili fl" style="margin-top: 17px;">
						示例：<span class="shili1"></span>
					</div>
					<div class="clear"></div>
				</div>
				<div class="shimingbox disnone" id="shimingbox2">
					<p class="smtitle">
						<span class="smxing">*</span>身份证反面：
					</p>
					<div class="sfzbox fl" id="bimg2" >
						<img height="165px;" width="244px;" id="IDCard2" src="${realUserAuth.cardBackImg}">
					</div>
					<div class="shili fl">
						示例：<span class="shili2"></span>
					</div>
					<div class="clear"></div>
				</div>
				
				<div class="shimingbox disnone">
					<p class="smtitle"><span class="smxing">*</span>支付宝账号:</p>
					<p class="smneirong">	${realUserAuth.alipay}</p>
					<div class="clear"></div>
				</div>
				
				
				

			</div>
		</form>
	</div>
            	
     </div>
            <br style="clear:both;" />
        </div>
    </div>



	<div class="clear"></div>
</body>
</html>
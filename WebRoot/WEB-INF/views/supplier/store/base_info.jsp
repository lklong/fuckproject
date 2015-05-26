<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>店铺基本信息</title>
<script type="text/javascript" src="js/pca.js"></script>
</head>

<body>
<div class="rightContainer">
    	<!--// 标题 //-->
        <h3 class="rc_title">
        	店铺基本信息<a href="user/home">我的主页</a>
        </h3>
        <!--// 内容框 //-->
		<div class="rc_body">
        	<!--// tab切换条 //-->
            <div id="userCommTab" class="userCommTab">
            	<ul>
                	<li><a href="javascript:void(0);" class="uctSelected">店铺基本信息</a></li>
                </ul>
            </div>
            <div id="userContents" class="userContents">
            	<!--// 内容1 //-->
            	<div class="body_center2" style="height: 770px;" id="alldd">
				<div class="user_info">
					<p>
						<span class="red">*</span><span>网站直达域名：</span>
					<span class="red">http://${store.domain}.zhiguw.com</span>
					</p>
					<p>
						<span class="red">*</span><span>商铺名称：</span>
						 <span class="font_color">${store.storeName}</span>
					</p>
					<p>
						<span class="red">*</span> <span>经营地址：</span>
						<span class="font_color">${store.province}－${store.city}－${store.district}</span>
					</p>
						<p>
							<span class="red">*</span><span>具体地址：</span>
							<span class="font_color">${store.street}</span>
						</p>
					<p>
						<span class="red">*</span><span>所在商圈：</span>
						<c:forEach var="t" items="${businessArea }">
						<c:if test="${t.value==store.businessArea}">
							<span class="font_color" >${t.name}</span>
							</c:if>
						</c:forEach>
					</p>
					<p>
						<span class="red">*</span><span>联系人姓名：</span>
						<span class="font_color">${store.contactName }</span>
					</p>
					<p>
						<span class="red">*</span><span>手机号码：</span>
						<span class="font_color">${store.phone }</span>
					</p>
					<p>
					<span>&nbsp;</span>
						<span>联系QQ：</span><span class="font_color">${store.QQ }</span>
					</p>
					<p>
					<span>&nbsp;</span>
						<span>联系旺旺：</span><span class="font_color">${store.aliWangWang }</span>
					</p>
				</div>
				<div class="btn_edit">
				<a href="/supplier/store/updateBaseInfo">修改</a>
				</div>
		</div>
     </div>
            <br style="clear:both;" />
        </div>
    </div>
			<div class="clear"></div> 
</body>
</html>

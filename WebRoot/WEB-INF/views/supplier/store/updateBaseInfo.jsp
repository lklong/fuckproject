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
			<form method="post"  id="infoForm">
				<div class="gongyingreg_txt">
					<p>
						<span class="red">*</span> <span>网站直达域名：</span>
					</p>
					<div class="yuming">
						<span class="fl">http://</span> <input class="dpname" type="text" name="domain"
							id="domain" value="${store.domain}" placeholder="填写网站域名"  <c:if test="${store.domainModify==0 }"> readonly="readonly"</c:if>/>
						.zhiguw.com <label class="error ">${msg_domain}</label><span class="f12 c999 ml20">可修改${store.domainModify }次</span>
					</div>
				</div>
				<div class="gongyingreg_txt">
					<p>
						<span class="red">*</span> <span>商铺名称：</span>
					</p>
					<input class="dpname" type="text" name="storeName"
						id="storeName" value="${store.storeName}"
						placeholder="不能超过18个字符" <c:if test="${store.storeNameModify==0 }"> readonly="readonly"</c:if> /><label class="error ">${msg_storeName}</label><span class="f12 c999 ml20">可修改${store.storeNameModify }次</span>
				</div>

				<div class="gongyingreg_txt">
					<p>
						<span class="red">*</span> <span>经营地址：</span>
					</p>
					<select name="province" id="province" value="${store.province}"
						style="width: 130px;">
					</select> <select name="city" id="city" value="${store.city}"
						style="width: 130px;">
					</select> <select name="district" id="district" value="${store.district}"
						style="width: 130px;">
					</select> <label class="error">${msg_district}</label>
				</div>
				<div class="gongyingreg_txt">
					<div class="dizhitxt1">
						<p class="dizhititle">
							<span class="red">*</span> 具体地址：
						</p>
						<textarea class="fl mr10" name="street" id="street" style="width: 350px;margin: 0px 0px 15px 0px;">${store.street}</textarea>
						<label class="error">${msg_street}</label>
					</div>
				</div>
				<div class="clear"></div> 
				<div class="gongyingreg_txt" style="left: -15px;float: left;">
					<p>
						<span class="red">*</span> <span>所在商圈：</span>
					</p>
					<select name="businessArea" id="businessArea">
						<c:forEach var="t" items="${businessArea }">
							<option value="${t.value}" <c:if test="${t.value==store.businessArea}">selected="selected"</c:if>>${t.name}</option>
						</c:forEach>
					</select><label class="error ">${msg_businessArea}</label>
				</div>
				<div class="clear"></div> 
				<div class="gongyingreg_txt">
					<p>
						<span class="red">*</span> <span>联系人姓名：</span>
					</p>
					<input type="text" name="contactName" value="${store.contactName }"
						id="contactName" class="dpname" /><label class="error ">${msg_contactName}</label>
				</div>
				<div class="gongyingreg_txt">
					<p>
						<span class="red">*</span> <span>手机号码：</span>
					</p>
					<input type="text" class="dpname" name="phone" value="${store.phone }" id="phone" /><label
						class="error ">${msg_phone}</label>
				</div>
				<div class="gongyingreg_txt">
					<p>
						<span>联系QQ：</span>
					</p>
					<input type="text" class="dpname" name="QQ" value="${store.QQ }" id="QQ" /><label
						class="error ">${msg_QQ}</label>
				</div>
				<div class="gongyingreg_txt">
					<p>
						<span>联系旺旺：</span>
					</p>
					<input type="text" class="dpname" name="aliWangWang" value="${store.aliWangWang }"
						id="aliWangWang" /> <label class="error ">${msg_aliwangwang}</label>
				</div>
				<div class="gongyingreg_txt"><p>&nbsp;</p>
				<input type="hidden" name="domainModify" value="${store.domainModify}" />
				<input type="hidden" name="storeNameModify" value="${store.storeNameModify}" />
				<input type="hidden" name="applyTyle" value="${store.applyType}" />
				<button class="btn2" onclick="if(confirm('确认修改？')){$('#infoForm').submit();}" type="button">保存修改</button>
				</div>
			</form>
		</div>
     </div>
            <br style="clear:both;" />
        </div>
    </div>
			<div class="clear"></div> 
<script type="text/javascript">
		$().ready(
				function() {
					var msg = "${msg}";
		    		if(msg != "")
		    			dialog(msg);
		    		
					$("#infoForm").validate({
						rules : {
							domain : {
								strNumMix : true,
								required : true,
								minlength : 4,
								maxlength : 16
							},
							district : {
								required : true
							},
							street : {
								required : true,
								address : true,
								minlength : 2,
								maxlength : 30
							},
							businessArea : {
								required : true
							},
							storeName : {
								required : true,
								minlength : 3,
								maxlength : 18
							},
							contactName : {
								required : true,
								minlength : 2,
								maxlength : 8
							},
							phone : {
								mobilePhone : true,
								required : true
							}
						},
						submitHandler:function(){
							var params = zhigu.cmn.formToObj("#infoForm");
							$.post("/supplier/store/updateBaseInfo",params,function(msgBean){
								if(msgBean.code == zhigu.code.success){
									layer.msg(msgBean.msg,2,function(){
										window.location.href="/supplier/store/baseInfoInit";
									});
								}else{
									layer.alert(msgBean.msg);
								}
							})
						}
					})
					new PCAS("province", "city", "district",
							"${store.province}", "${store.city}",
							"${store.district}");
				});
	</script>
</body>
</html>

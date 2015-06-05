<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>编辑店铺基本信息</title>
<link rel="stylesheet" type="text/css" href="js/validate/validate.css" />
<script type="text/javascript" src="js/pca.js"></script>
<script type="text/javascript" src="js/validate/jquery.validate.js"></script>
<script type="text/javascript" src="js/validate/message_cn.js"></script>
<script type="text/javascript" src="js/validate/additional-methods.js"></script>

<script type="text/javascript" src="js/3rdparty/layer1.9/layer.js"></script>
</head>
<body>
<div class="rightContainer fr">
  <h4 class="ddtitle">编辑店铺基本信息</h4>
  <form method="post"  id="infoForm">
    <table cellpadding="0" cellspacing="0" class="user-form-table">
      <tr>
        <td style="width:15%">网站直达域名：</td>
        <td style="width:85%">http://
          <input class="input-txt" type="text" name="domain" id="domain" value="${store.domain}" placeholder="填写网站域名"  <c:if test="${store.domainModify==0 }"> readonly="readonly"</c:if>/>
          .zhiguw.com
          <label class="error ">${msg_domain}</label>
          <span class="color-red">可修改${store.domainModify }次</span></td>
      </tr>
      <tr>
        <td>商铺名称：</td>
        <td><input class="input-txt" type="text" name="storeName" id="storeName" value="${store.storeName}" placeholder="不能超过18个字符" <c:if test="${store.storeNameModify==0 }"> readonly="readonly"</c:if> />
          <label class="color-red">${msg_storeName}</label>
          <span class="color-red">可修改${store.storeNameModify }次</span></td>
      </tr>
      <tr>
        <td>经营地址：</td>
        <td><select name="province" id="province" value="${store.province}" class="select-txt">
          </select>
          <select name="city" id="city" value="${store.city}" class="select-txt">
          </select>
          <select name="district" id="district" value="${store.district}" class="select-txt">
          </select>
          <label class="color-red">${msg_district}</label></td>
      </tr>
      <tr>
        <td>具体地址：</td>
        <td><textarea class="" name="street" id="street">${store.street}</textarea>
          <label class="color-red">${msg_street}</label></td>
      </tr>
      <tr>
        <td>所在商圈：</td>
        <td><select name="businessArea" id="businessArea" class="select-txt">
            <c:forEach var="t" items="${businessArea }">
              <option value="${t.value}" <c:if test="${t.value==store.businessArea}">selected="selected"</c:if>>${t.name}</option>
            </c:forEach>
          </select>
          <label class="color-red">${msg_businessArea}</label></td>
      </tr>
      <tr>
        <td>联系人姓名：</td>
        <td><input type="text" name="contactName" value="${store.contactName }" id="contactName" class="input-txt" />
          <label class="color-red">${msg_contactName}</label></td>
      </tr>
      <tr>
        <td>手机号码：</td>
        <td><input type="text" class="input-txt" name="phone" value="${store.phone }" id="phone" />
          <label class="color-red">${msg_phone}</label></td>
      </tr>
      <tr>
        <td>联系QQ：</td>
        <td><input type="text" class="input-txt" name="QQ" value="${store.QQ }" id="QQ" />
          <label class="color-red">${msg_QQ}</label></td>
      </tr>
      <tr>
        <td>联系旺旺：</td>
        <td><input type="text" class="input-txt" name="aliWangWang" value="${store.aliWangWang }" id="aliWangWang" />
          <label class="color-red">${msg_aliwangwang}</label></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td><input type="hidden" name="domainModify" value="${store.domainModify}" />
          <input type="hidden" name="storeNameModify" value="${store.storeNameModify}" />
          <input type="hidden" name="applyTyle" value="${store.applyType}" />
          <button class="input-button" style="border:none;" onclick="if(confirm('确认修改？')){$('#infoForm').submit();}">保存修改</button></td>
      </tr>
    </table>
  </form>
</div>
<script type="text/javascript">
		$().ready(
				function() {
					var msg = "${msg}";
		    		if(msg != "")
		    			layer.alert(msg);
		    		
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
									layer.msg(msgBean.msg,function(){
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

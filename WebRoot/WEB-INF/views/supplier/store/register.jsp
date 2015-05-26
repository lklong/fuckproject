<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/plugins/validateform.css" type="text/css"  />
<title>供应商注册</title>

<script type="text/javascript" src="js/pca.js"></script>
</head>
<body>

<!--** 注册板块 **-->
<!--** Step.1 填写信息 **-->
<form action="/supplier/store/register" method="post"  id="storeRegisterForm">
<div class="userRegPanel">
	<div class="urpInside">
    	<div class="urpTopBox"></div>
        <div class="urpMiddleBox">
        	<div class="busyTrip">
            	<div><strong>开店申请</strong></div>
              <div class="tripHr"><font color="787878">申请智谷同城货源网店铺，流程如下：</font></div>
                	<div class="tripDiv">
                	<table width="35%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td rowspan="2"><span class="frspan"></span></td>
                        <td><font color="#F86666" style="font-size:16px"><strong>选择要成为的商家</strong></font></td>
                      </tr>
                    </table>
                    <table width="40%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td rowspan="2"><span class="sespan"></span></td>
                        <td><font color="#F86666" style="font-size:16px"><strong>需要把智谷同城需要填写的资料填写完整</strong></font></td>
                      </tr>
                    </table>
                    <table width="25%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td rowspan="2"><span class="thspan"></span></td>
                        <td><font color="#F86666" style="font-size:16px"><strong>提交申请 </strong></font></td>
                      </tr>
                      <tr>
                        <td><font color="787878" style="font-size:14px">后请等客服联系你</font></td>
                      </tr>
                    </table>
               		</div>
            </div>
            <!--** 商家类型选择条 **-->
            <input type="hidden" name="supplierType" value="2" id="supplierType"/>
            <div class="busyModel">
            	<div class="modelInside" id="chooseStoreTypeDiv">
                	<div class="model_2" value="2">申请供应商家</div>
<!--                     <div class="model_1" value="3">注册店铺装修商家</div> -->
<!--                     <div class="model_1" value="4">注册摄影商家</div> -->
                </div>
            </div>
            
            <div class="busyInfoBox">
            	<div class="bibTxt"><font color="#ff3300" style="font-size:12px">* </font>网站直达域名</div>
                <div class="bibinput">
                http:// <input type="text" style="width:140px;" class="busyInput" value="${store.domain}" required="true" placeholder="填写网站域名" name="domain" id="domain" maxlength="16"/> .zhiguw.com
                </div>
                <div class="bibAlert"><c:if test="${not empty msg_domain}"><p class="failMsg"><em></em>${msg_domain}</p></c:if></div>
            </div>
            
        <div class="busyInfoBox">
            	<div class="bibTxt"><font color="#ff3300" style="font-size:12px">* </font>商铺名称</div>
                <div class="bibinput"><input type="text" required="true" dataType class="busyInput" name="storeName" id="storeName" value="${store.storeName}" maxlength="18" placeholder="可修改3次，不能超过18个字符" /></div>
                <div class="bibAlert"><c:if test="${not empty msg_storeName}"><p class="failMsg"><em></em>${msg_storeName}</p></c:if></div>
            </div>
            
        <div class="busyInfoBox">
            	<div class="bibTxt"><font color="#ff3300" style="font-size:12px">* </font>经营地址</div>
                <div class="bibinput">
                	<select name="province" id="province" value="${store.province}" class="w80"> </select> 
                	<select name="city" id="city" value="${store.city}" class="w80"> </select>
                	 <select name="district" id="district" value="${store.district}" class="w80"></select>	
                </div>
                <div class="bibAlert"><c:if test="${not empty msg_district}"><p class="failMsg"><em></em>${msg_district}</p></c:if></div>
            </div>
            
        <div class="busyInfoBox">
            	<div class="bibTxt"><font color="#ff3300" style="font-size:12px">* </font>具体地址</div>
                <div class="bibinput"><input type="text" class="busyInput" placeholder="不超过100个字符" name="street" id="street" value="${store.street}" /></div>
                <div class="bibAlert"><c:if test="${not empty msg_street}"><p class="failMsg"><em></em>${msg_street}</p></c:if></div>
            </div>
            
        <div class="busyInfoBox">
            	<div class="bibTxt"><font color="#ff3300" style="font-size:12px">* </font>所在商圈</div>
                <div class="bibinput">
					<select name="businessArea" id="businessArea" style="width:140px">
						<c:forEach var="t" items="${businessArea }">
							<option value="${t.value}" <c:if test="${t.value==store.businessArea}">selected="selected"</c:if>>${t.name}</option>
						</c:forEach>
					</select>
				</div>
                <div class="bibAlert"><c:if test="${not empty msg_businessArea}"><p class="failMsg"><em></em>${msg_businessArea}</p></c:if></div>
            </div>
            
        <div class="busyInfoBox">
            	<div class="bibTxt"><font color="#ff3300" style="font-size:12px">* </font>联系人姓名</div>
                <div class="bibinput"><input type="text" class="busyInput" name="contactName" placeholder="不超过8个字符" value="${store.contactName }" id="contactName" maxlength="8"/></div>
                <div class="bibAlert"><c:if test="${not empty msg_contactName}"><p class="failMsg"><em></em>${msg_contactName}</p></c:if></div>
            </div>
            
        <div class="busyInfoBox">
            	<div class="bibTxt"><font color="#ff3300" style="font-size:12px">* </font>手机号码</div>
                <div class="bibinput"><input type="text" class="busyInput" placeholder="请填写11位手机号" name="phone" value="${store.phone }" id="phone" /></div>
                <div class="bibAlert"><c:if test="${not empty msg_phone}"><p class="failMsg"><em></em>${msg_phone}</p></c:if></div>
            </div>
            
        <div class="busyInfoBox">
            	<div class="bibTxt"><font color="#ff3300" style="font-size:12px" >* </font>联系QQ</div>
                <div class="bibinput"><input type="text" class="busyInput" name="QQ" value="${store.QQ }" id="QQ" /></div>
                <div class="bibAlert"><c:if test="${not empty msg_QQ}"><p class="failMsg"><em></em>${msg_QQ}</p></c:if></div>
            </div>
            
        <div class="busyInfoBox">
            	<div class="bibTxt">　联系旺旺</div>
                <div class="bibinput"><input type="text" class="busyInput" name="aliWangWang"   minlength="2" datatype="s5-10" errormsg="昵称至少5个字符,最多16个字符！" value="${store.aliWangWang }" id="aliWangWang" /></div>
                <div class="bibAlert"></div>
            </div>
        
        <div class="busyInfoBox">
            	<div class="bibTxt"></div>
                <div class="bibinput"></div>
                <div class="bibAlert"><input type="checkbox" checked="checked"  id="readagree" name="readagree" /><a href="help/agreement"> 我同意《智谷同城货源网用户服务协议》</a></div>
            </div>
            
            <div class="urpMiddleDiv mt30">
            	<br /><br /><br />
            	<input type="submit" class="urpSubMit" value="开店申请" title="开店申请" onclick="return storeRegisterSub();"/>
                <br /><br /><br />
                <br /><br /><br />
            </div>
        </div>
        <div class="urpFootBox"></div>
    </div>
</div>
</form>

<!-- <script type="text/javascript" src="js/plugins/Validform_v5.3.2.js"></script> -->	
<!-- <script type="text/javascript" src="js/validate/jquery.validate.js"></script> -->
<script src="js/validate/message_cn.js" type="text/javascript"></script>
<script type="text/javascript" src="js/validate/additional-methods.js"></script>
<script type="text/javascript">

$(function() {
	$("#chooseStoreTypeDiv div").click(function(){
		var ol = $(this).parent().find(".model_2");
		ol.removeClass("model_2");
		ol.addClass("model_1");
		$(this).removeClass("model_1");
		$(this).addClass("model_2");
		$("#supplierType").val($(this).attr("value"));
	});
	
	// $("#infoForm").validate();
	$("#storeRegisterForm").validate({
		rules : {
			domain : { strNumMix : true, required : true, minlength : 4, maxlength : 16 },
			district : { required : true },
			street : { required : true, address : true, minlength : 2, maxlength : 30 },
			businessArea : { required : true },
			storeName : { required : true, minlength : 3, maxlength : 18 },
			contactName : { required : true, minlength : 2, maxlength : 8 },
			QQ : {number:true,required : true},
			phone : { mobilePhone : true, required : true }
		},
		submitHandler:function(){
			var params = zhigu.cmn.formToObj("#storeRegisterForm");
			ajaxSubmit("/supplier/store/register",params,function(msgBean){
				if(msgBean.code==zhigu.code.success){
					layer.msg(msgBean.msg,2,f5);
				}else{
					layer.alert(msgBean.msg);
				}
			})
			return false;
		}
	});
	
 if("${store.province}"==""){
		new PCAS("province", "city", "district",
				"四川省", "成都市","");
	}else{
		new PCAS("province", "city", "district",
				"${store.province}", "${store.city}",
				"${store.district}");
	}
});
function storeRegisterSub(){
	if ($("#readagree").prop("checked")!=true ) {
		dialog("请同意并阅读《智谷同城货源网用户服务协议》");
		return false;
	} 
}
</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="${applicationScope.basePath}" />

<title>供应商店铺列表</title>
<link href="js/3rdparty/easyui/themes/bootstrap/easyui.css" rel="stylesheet" type="text/css">
<link href="css/default/jcDate.css" rel="stylesheet" type="text/css" media="all" />
<script src="js/admin/admin.js" type="text/javascript"></script>
<link href="js/3rdparty/zTree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css" media="all" />
<script type="text/javascript" language="javascript" src="js/3rdparty/zTree/js/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" language="javascript" src="js/3rdparty/easyui/jquery.easyui.min.js_bak"></script>
	<script type="text/javascript" src="js/jQuery-jcDate.js"></script>
<script type="text/javascript" src="../js/admin/store.js"></script>
<script type="text/javascript" src="../js/pca.js"></script>

<script type="text/javascript" src="js/jquery-form.js"></script>


</head>

<body>
	<!-- //功能条// -->
	<form method="post" id="storeForm" action="admin/store/index" class="fl">
		<div class="sysContBar">
			<div class="sysCBBox">
				<div>店铺名称：</div>
				<div>
					<input name="storeName" value="${store.storeName }" class="sysCommonInput" type="text" />
				</div>
				<div>联系人电话：</div>
				<div>
					<input name="phone" value="${store.phone }" class="sysCommonInput" type="text" />
				</div>
				
				<div>申请时间：</div>
				<div>
					<input class="jcDate sysCommonInput" type="text" id="date1" name="startDate" readonly="readonly" value="${startDate }"  />
				</div>
				<div>-</div>
				<div>
					<input class="jcDate sysCommonInput" type="text" id="date2" name="endDate" readonly="readonly" value="${endDate }" />
				</div>
				<div>所在商圈：</div>
				<div>
					<select id="businessArea" name="businessArea" style="font-family: '微软雅黑';font-size: 11px;" >
                           <option value="" >---请选择---</option>
                           <c:forEach items="${businessArea }" var="area">
                           		<option value="${area.value }" <c:if test="${store.businessArea==area.value}">selected="selected"</c:if> >${area.name }</option>
                           </c:forEach>
	                  </select>
				</div>
				<div>店铺状态：</div>
				<div>
					 <select id="approveState" name="approveState" style="font-family: '微软雅黑';font-size: 11px; height: 22px;width: 110px;" >
                           <option value="" >---请选择---</option>
                           <c:forEach items="${storeApproveState}" var="state">
                           		<option value="${state.value }" <c:if test="${store.approveState==state.value}">selected="selected"</c:if>>${state.name }</option>
                           </c:forEach>
                  	</select>
				</div>
			</div>
			<div class="sysCBBox">
				<input class="sysSubmit" type="submit" value="查找" /> <input type="hidden" name="order" id="mcorder"> <input type="hidden" name="status" id="mcstatus" value="${mc.status }">
			</div>
		</div>
	</form>

	<table class="sysCommonTable _memTable" cellspacing="0" cellpadding="0">
		<thead>
			<tr>
				<th>&nbsp;</th>
				<th>店铺名称</th>
				<th>网站域名</th>
				<th>所在商圈</th>
				<th>联系人姓名</th>
				<th>联系人电话</th>
				<th>申请时间</th>
				<th>供应商类型</th>
				<th>认证</th>
				<th>开启申请</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.datas }" var="s">
				<tr>
					<td><input type="checkbox"  class="_cbox" value="${s.ID }" mname="${s.storeName }" /></td>
					<td>${s.storeName }</td>
					<td>${s.domain }</td>
					<td>
						<c:if test="${s.businessArea == 1}">国际商贸城商圈</c:if>
						<c:if test="${s.businessArea == 2}">荷花池商圈</c:if>
						<c:if test="${s.businessArea == 3}">青龙市场</c:if>
						<c:if test="${s.businessArea == 4}">金花镇工业区</c:if>
					</td>
					<td>${s.contactName }</td>
					<td>${s.phone }</td>
					<td><fmt:formatDate value="${s.applyTime }" pattern="yyyy-MM-dd"/></td>
					<td>
						<c:if test="${s.supplierType==1}">网商(普通用户)</c:if>
						<c:if test="${s.supplierType==2}">供应商</c:if>
						<c:if test="${s.supplierType==3}">装修服务商</c:if>
						<c:if test="${s.supplierType==4}">摄影服务商</c:if>
					</td>
					<td>
<%-- 						<c:if test="${s.integrityAuth==0 }"> <a href="javascript:void(0);" class="sysButonA2" onclick="andIntegrityAuth(${s.ID})" ><em></em>诚信认证</a> </c:if> --%>
<%-- 						<c:if test="${s.integrityAuth==1 }"> <a href="javascript:void(0);" class="sysButonA1" onclick="realUserAuthInfo(${s.ID})" ><em></em>诚信认证</a> </c:if> --%>
						<c:if test="${s.companyAuth==0 }"> <a href="javascript:void(0);" class="sysButonA2"  onclick="storeCompanyAuthInfo(${s.ID})"  ><em></em>企业认证未保存</a> </c:if>
						<c:if test="${s.companyAuth==1 }"> <a href="javascript:void(0);" class="sysButonA1"  ><em></em>企业认证已通过</a> </c:if>
						<c:if test="${s.companyAuth==2 }"> <a href="javascript:void(0);" class="sysButonA2" onclick="storeCompanyAuthInfo(${s.ID})" ><em></em>企业认证未通过</a> </c:if>
						<c:if test="${s.companyAuth==3 }"> <a href="admin/store/company/skipCompanyAuthStatus?storeID=${s.ID }" class="sysButonA2" ><em></em>企业认证待认证</a> </c:if>
						 <c:if test="${s.realStoreAuth==0 }"><a href="javascript:void(0);" class="sysButonA2"  onclick="realStoreAuth(${s.ID})">  <em></em>实体认证未保存</a> </c:if>
						 <c:if test="${s.realStoreAuth==1 }"><a href="javascript:void(0);" class="sysButonA1">  <em></em>实体认证已通过</a> </c:if>
						 <c:if test="${s.realStoreAuth==2 }"><a href="javascript:void(0);" class="sysButonA2"  onclick="realStoreAuth(${s.ID})">  <em></em>实体认证未通过</a> </c:if>
						 <c:if test="${s.realStoreAuth==3 }"><a href="admin/store/realStore/skipRealStoreAuthStatus?storeID=${s.ID }" class="sysButonA2" >  <em></em>实体认证待认证</a> </c:if>
					</td>
					<td>
						<c:if test="${s.approveState == 1}"><a href="javascript:void(0);" onclick="updateApproveState(${s.ID})" class="sysButonA2"><em></em>开启</a></c:if>
<%-- 						<c:if test="${s.approveState == 1}"><a href="javascript:void(0);" onclick="updateApproveState(${s.ID},3)" class="sysButonA2"><em></em>审核未通过</a></c:if> --%>
						<c:if test="${s.approveState == 4}">已开启店铺</c:if>
						&nbsp;
					</td>
					<td>
						<a href="admin/store/showInfo?id=${s.ID }" class="sysButonA1"><em></em>查看详情</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<!--// 分页 //-->
	<div class="dataPager">
		<div class="ddpage">
			<jsp:include page="../../include/page.jsp">
				<jsp:param name="request" value="form" />
				<jsp:param name="requestForm" value="storeForm" />
			</jsp:include>
		</div>
	</div>

	<form action="admin/store/detail" id="storeDetailForm" method="post">
		<input type="hidden" name="storeID" id="storeID">
	</form>
	<div id="authInfoDiv" style="display: none;">认证信息加载中...</div>
	<div id="baseDataDiv" style="display: none;">
		
	</div>
	<!--------------------------------------------------footer---------------------------------------------------------->
	
	<script type="text/javascript">
$("input.jcDate").jcDate({
	IcoClass : "jcDateIco",
	Event : "click",
	Speed : 100,
	Left : 0,
	Top : 28,
	format : "-",
	Timeout : 100
});
$(function(){
	$("#realUserStatus").val("${mc.realUserStatus}");
	$("#companyStatus").val("${mc.companyStatus}");
	$("#realStoreStatus").val("${mc.realStoreStatus}");
	//排序
	var order = "${mc.order}";
	var isUp = order % 2 == 0 ? false : true;
	$("#sortType span").removeClass("hongs");
	$("#sortType span").removeClass("hongx");
	$("#sortType span").each(function(index){
		if(index + 1 == order){
			$(this).removeClass("huis");
			$(this).removeClass("huixia");
			$(this).addClass(isUp ? "hongs" : "hongx");
		}
		$(this).click(function(){
			$("#mcorder").val(index + 1);
			$("#memberForm").submit();
		});
	});
})

function normallist(){
	$("#mcstatus").val(0);
	$("#memberForm").submit();
}
function freezelist(){
	$("#mcstatus").val(9);
	$("#memberForm").submit();
}
/**
 * 店铺审核 
 * @param id
 */
function updateApproveState(id){
	parent.layer.confirm("确定此次操作吗？",function(){ 
         $.post("<%=basePath%>admin/store/updateStroeAuditStatus?id="+id, function(msgBean){
       	  if(msgBean.code==zhigu.code.success){
       			parent.layer.alert("操作成功！",1);
					setTimeout("changePage()", 1000);
       	  }else{
       		  parent.layer.alert(msgBean.msg,0);  
       	  }
	});
    },'用户状态提示');
}
function changePage(){
	parent.layer.closeAll();
	window.location = "<%=basePath%>admin/store/index";	
}
</script>
</body>
</html>

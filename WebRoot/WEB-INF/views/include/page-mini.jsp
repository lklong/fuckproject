<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript">
var page_go = function(index){
	var requestType = "<%=request.getParameter("request")%>"; //value==> url、form、ajax、function
	var requestForm = "<%=request.getParameter("requestForm")%>"; // fromID
	var requestUrl  = "<%=request.getParameter("requestUrl")%>";
	var functionName = "<%=request.getParameter("functionName")%>";// 函数，该方法第一个参数必须是pageNo ，方法必须放在zhigu变量中     eg:zhigu.xxx(pageNo) --->值应该为：xxx
	if( requestType=='null')requestType = '';
	if( requestForm=='null')requestForm = '';
	if( requestUrl=='null')requestUrl = '';
	if( functionName=='null')functionName = '';
	zhigu.log("分页：",requestType,requestForm,requestUrl,functionName);
	switch (requestType) {
		case 'url':
			_urlSubmit(index,requestUrl);
			break;
		case 'form':
			_formSubmit(index,requestForm);
			break;
		case 'ajax':
			_ajaxSubmit(index,requestForm,requestUrl,functionName);
			break;
		case 'function':
			callFunctionName(functionName,index);
			break;
	}
}
function callFunctionName(funName,pageNo){
		var index_zhigu = funName.indexOf('zhigu.');
		if(index_zhigu==0){
			zhigu[funName.substr(6)](pageNo); // 方法必须放在zhigu变量中
		}else{
			eval(funName+"("+pageNo+")");
		}
}
//重新加载当前页
function reloadCurrentPage(){
	page_go("${page.pageNo}");
}
function setPageNo(requestForm,index){
	var $pageInput = $("#"+requestForm+" #pageNo");
	if($pageInput){
		$pageInput.val(index);
	}else{
		$("#"+requestForm).append("<input type='hidden' name='pageNo' value='"+index+"' id='pageNo'>");	
	}
}
function setCurrentPageNo(requestForm){
	setPageNo(requestForm,"${page.pageNo}");
}
function setFirstPageNo(requestForm){
	setPageNo(requestForm,1);
}
function _formSubmit(index,requestForm){
	//setPageNo(requestForm,index);
	//$("#"+requestForm).prop("method","post");
	//$("#"+requestForm).submit();
	window.location.href = zhigu.cmn.formToUrl("#"+requestForm)+"&pageNo="+index;
}
function _urlSubmit(index,requestUrl){
	$("#_pageNo").val(index);
	$("#_pageForm").prop("action",requestUrl);
	//$("#_pageForm").submit();
	window.location.href = zhigu.cmn.formToUrl("#_pageForm");
}
function _ajaxSubmit(index,requestForm,requestUrl,functionName){
	if(functionName){
		callFunctionName(functionName,index);
		return false;
	}
	var action = '';
	var data = {};
	//ajax form提交
	if(requestForm){
		action = $("#"+requestForm).attr("action");
		data = zhigu.cmn.formToObj("#"+requestForm);
	}else if(requestUrl){
		//$("#_pageNo").val(index);
		var indexof = requestUrl.indexOf('?');
		if(indexof < 0){
			action = requestUrl;
		}else{
			action = requestUrl.substring(0,indexof);
			data = zhigu.cmn.urlParamsToObj(requestUrl.substring(indexof + 1));
		}
	}
	data.pageNo = index;
	zhigu.log("page params-->",data);
	$.ajax({
		url : action,
		type : "post",
		data : data,
		cache : false,
		success : function(data) {
			if(typeof(zhigu.pageAjaxSuccess) == 'function')
				zhigu.pageAjaxSuccess(data);
		}
	});
}

</script>
<form id="_pageForm" action="" method="post">
	<input type="hidden" name="pageNo" id="_pageNo">

	<div style="line-height: 35px;">
		<c:set var="custom_size"  value="<%=request.getParameter(\"size\")%>"/>
		<c:set var="size"  value="3"/>
		<c:set var="begin" value="1" />
		<c:set var="end"   value="1" />
		<c:if test="${custom_size != null && custom_size != '' }">
			<c:set var="size"  value="${custom_size }"/>
		</c:if>
		
		<c:choose>
			<c:when test="${page.pageNo <= size}">
				<c:set var="begin" value="1" />
				<c:set var="end"   value="${2*size+1 }" />
			</c:when>
			<c:when test="${page.pageNo + size > page.totalPage }">
				<c:set var="begin" value="${page.totalPage - 2*size}" />
				<c:set var="end"   value="${page.totalPage }" />
			</c:when>
			<c:otherwise>
				<c:set var="begin" value="${page.pageNo - size }" />
				<c:set var="end"   value="${page.pageNo + size}" />
			</c:otherwise>
		</c:choose>
		
		<c:if test="${begin < 1 }">
			<c:set var="begin" value="1" />
		</c:if>
		<c:if test="${end > page.totalPage }">
			<c:set var="end"   value="${page.totalPage }" />
		</c:if>
		
		${page.pageNo }/${page.totalPage }页 <a href="javascript:page_go(${(page.pageNo - 1) < 1 ? 1 : (page.pageNo - 1) });" class="prev" style="width: 50px;">上一页</a>
		<a href="javascript:page_go(${(page.pageNo + 1) > page.totalPage ? page.totalPage :  (page.pageNo + 1)});" class="next" style="width: 50px;">下一页</a>
	</div>
</form>

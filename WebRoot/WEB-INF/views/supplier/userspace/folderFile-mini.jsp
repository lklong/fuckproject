<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="fileUL" style="height: 240px;">
	<ul class="tupiankj ml10 f14">
		<c:forEach items="${page.datas }" var="userFile">
			<li>
				<div>
					<img src="${userFile.image100}" height="100" width="100"/>
					<input value="${userFile.filePath}" type="hidden"/>
				</div>
			</li>
		</c:forEach>
	</ul>
</div>
<div class="ddpage fr mr20" style="bottom:5px;">
	<jsp:include page="../../include/page.jsp">
		<jsp:param name="request" value="ajax"/>
		<jsp:param name="requestForm" value="folderFile_mini"/>
	</jsp:include>
</div>
<form action="supplier/space/folderFileMini" id="folderFile_mini">
	<input type="hidden" name="folderID" id="folderID_mini"/>
</form >
<script type="text/javascript">
if (typeof zhigu == "undefined" || !zhigu) {
    var zhigu = {};
}
zhigu.pageAjaxSuccess = function(data){
	$("#com_shangchuanbox").html(data);
}
$(function(){
	$("#folderID_mini").val(zTree.getSelectedNodes()[0].id);
	$("#fileUL img").on("click", function() {
		zhigu.goods.appendToUpimgul($(this).prop("src"), $(this).parent().find("input").val());
	});
})
</script>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="${applicationScope.basePath}" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>店铺公告</title>
<link rel="stylesheet" type="text/css" href="/js/3rdparty/webuploader/webuploader.css" />
<script type="text/javascript" src="/js/3rdparty/webuploader/webuploader.js"></script>
</head>

<body>
	<div class="rightContainer">
		<!--// 标题 //-->
		<h3 class="rc_title">
			店铺公告<a href="user/home">我的主页</a>
		</h3>
		<!--// 内容框 //-->
		<div class="rc_body">
			<!--// tab切换条 //-->
			<div id="userCommTab" class="userCommTab">
				<ul>
					<li><a href="javascript:void(0);" class="uctSelected">店铺公告</a></li>
				</ul>
			</div>
			<div id="userContents" class="userContents">
				<!--// 内容1 //-->
				<div class="body_center2" id="alldd">
					<div style="width: 80px;height: 30px;" class="baochun"><a href="/supplier/storeNotice/addStoreNoticePage?storeID=${storeID }" >添加</a></div>
					<table class="ddtableth c999">
						<thead>
							<tr>
								<th>&nbsp;</th>
								<th  width="200">发布时间</th>
								<th>公告内容</th>
								<th width="100">操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${storeNotice }" var="s">
								<tr >
									<td><input type="checkbox"  class="_cbox" value="${s.ID }" /></td>
									<td><fmt:formatDate value="${s.createTime }" pattern="yyyy-MM-dd HH:mm"/></td>
									<td>因公告内容含代码，请在店铺首页下的商家公告栏查看效果！</td>
									<td><a href="javascript:delStoreNotice(${s.ID });" id="delStoreNotice">&nbsp;&nbsp;删除</a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<br style="clear: both;" />
		</div>
	</div>
	<div class="clear"></div>
<script type="text/javascript">
	function delStoreNotice(id){
		parent.layer.confirm("确定此次操作吗？",function(){ 
	         $.post("/supplier/storeNotice/delStoreNotice?id="+id,function(msgBean){
	       	  if(msgBean.code==zhigu.code.success){
	       			layer.msg("操作成功！",1);
					setTimeout("changePage()", 1000);
	       	  }else{
	       		  layer.alert(msgBean.msg,0);  
	       	  }
		});
	    },'用户状态提示');
	}
	function changePage(){
		parent.layer.closeAll();
		window.location = "/supplier/storeNotice/storeNoticeList";	
	}
</script>
</body>
</html>

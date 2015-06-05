<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<title>店铺公告</title>
<link rel="stylesheet" href="/js/3rdparty/webuploader/webuploader.css">
<script type="text/javascript" src="/js/3rdparty/webuploader/webuploader.js"></script>
<script type="text/javascript" src="/js/3rdparty/layer1.9/layer.js"></script>
</head>
<body>
<div class="rightContainer fr">
  <h4 class="ddtitle">店铺公告<a href="/supplier/storeNotice/addStoreNoticePage?storeID=${storeID }" class="default-a">添加</a></h4>
  <table cellpadding="0" cellspacing="0" class="user-list-table txt-center">
    <thead>
      <tr>
        <th>&nbsp;</th>
        <th>发布时间</th>
        <th>公告内容</th>
        <th>操作</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach items="${storeNotice }" var="s">
        <tr >
          <td><input type="checkbox"  class="_cbox" value="${s.ID }" /></td>
          <td><fmt:formatDate value="${s.createTime }" pattern="yyyy-MM-dd HH:mm"/></td>
          <td>因公告内容含代码，请在店铺首页下的商家公告栏查看效果！</td>
          <td><a href="javascript:delStoreNotice(${s.ID });" id="delStoreNotice" class="default-a">删除</a></td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
</div>
<script type="text/javascript">
	function delStoreNotice(id){
		layer.confirm("确定要删除这条公告吗？",function(){ 
	         $.post("/supplier/storeNotice/delStoreNotice?id="+id,function(msgBean){
	       	  if(msgBean.code==zhigu.code.success){
	       			layer.alert("操作成功！",function(){changePage()});
	       	  }else{
	       		  layer.alert(msgBean.msg);  
	       	  }
		});
	    },'用户状态提示');
	}
	function changePage(){
		window.location = "/supplier/storeNotice/storeNoticeList";	
	}
</script>
</body>
</html>

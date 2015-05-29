<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="${applicationScope.basePath}"/>

<title>栏目首页</title>
<link rel="stylesheet" type="text/css" href="css/basic.css" />
<link rel="stylesheet" type="text/css" href="css/index.css" />
<script src="js/jquery.min.js" type="text/javascript"></script>
<script src="js/main.js" type="text/javascript"></script>
<script src="js/global.js" type="text/javascript"></script>
<script type="text/javascript" src="js/ad/adlog.js"></script> 
</head>

<body>
    <!--// 右侧容器 //-->
    <div class="rightContainer">
    	<!--// 标题 //-->
        <h3 class="rc_title">广告购买记录<a href="#">我的主页</a></h3>
        <!--// 内容框 //-->
		<div class="rc_body">
        
                    <div class="uccb_content">
                    <input value="${userID}" name="userID" id="userID" type="hidden">
                        <table cellpadding="0" cellspacing="0">
                           <thead> <tr><th>序号</th><th>下单时间</th><th>广告标题</th><th>价格</th><th>状态</th><th>审核</th><th>操作</th></tr></thead>
                                    <tbody>
                                   </tbody>       
                            </table>
                    </div>
                    <div class="pager" id="paginationContainer"></div>
                  </div>

          
			<br style="clear:both;" />
 
</div>
<script type="text/javascript">

</script>
</body>
</html>

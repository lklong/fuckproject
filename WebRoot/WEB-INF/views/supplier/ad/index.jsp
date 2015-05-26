<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>智谷首页</title>
<link rel="stylesheet" type="text/css" href="css/basic.css" />
<link rel="stylesheet" type="text/css" href="css/index.css" />
<script src="js/jquery.min.js" type="text/javascript"></script>
<script src="js/main.js" type="text/javascript"></script>
<script src="js/global.js" type="text/javascript"></script>
<script type="text/javascript" src="js/ad/ad.js"></script>
</head>
<body>
    <!--// 右侧容器 //-->
    <div class="rightContainer">
    	<!--// 标题 //-->
        <h3 class="rc_title">智谷首页广告<a href="#">我的主页</a></h3>
        <!--// 内容框 //-->
		<div class="rc_body">
        	<!--// tab切换条 //-->
            <div id="userCommTab" class="userCommTab">
            	<ul>

                </ul>
            </div>
            <!--// 对应内容框 //-->
			<div id="userContents" class="userContents">
                  <div class="userCommContentBox disnone" id="userCommContentBox1">
                    <div class="uccb_content"></div>
                    <img style="margin-left: 15px;"  alt="" src="">
                        <table cellpadding="0" cellspacing="0">
                            <thead><tr><th>栏目名称<th>时间</th><th>单价（元/天）</th><th>价格</th><th>订购天数</th><th>订购操作</th></tr></thead><tbody></tbody></table></div>
                            <div class="pager" id="paginationContainer1"></div></div>
                            
                           
                            
       <!--// 内容2 //-->
			<br style="clear:both;" />
        </div>
</div>
<script src="js/3rdparty/layer/layer.min.js" type="text/javascript"></script>
</body>
</html>

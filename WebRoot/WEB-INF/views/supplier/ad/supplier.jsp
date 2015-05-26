<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>供应商家右侧</title>
<link rel="stylesheet" type="text/css" href="css/basic.css" />
<link rel="stylesheet" type="text/css" href="css/index.css" />
<script src="js/jquery.min.js" type="text/javascript"></script>
<script src="js/main.js" type="text/javascript"></script>
<script type="text/javascript" src="js/ad/ad.js"></script>
</head>

<body>
    <!--// 右侧容器 //-->
    <div class="rightContainer">
    	<!--// 标题 //-->
        <h3 class="rc_title">供应商家右侧广告<a href="#">我的主页</a></h3>
        <!--// 内容框 //-->
		<div class="rc_body">
        	<!--// tab切换条 //-->
            <div id="userCommTab" class="userCommTab">
            	<ul>
                	<li><a href="javascript:void(0);" class="uctSelected" group="9">智谷鞋库</a></li>
                    <li><a href="javascript:void(0);" group="10">智谷服饰</a></li>
                    <li><a href="javascript:void(0);" group="11">智谷美妆</a></li>
                    <li><a href="javascript:void(0);" group="12">智谷美食</a></li>
                </ul>
            </div>
            <!--// 对应内容框 //-->
			<div id="userContents" class="userContents">
            	<!--// 内容1 //-->
    
                           <div class="userCommContentBox disnone" id="userCommContentBox9">
                    <div class="uccb_intro">
                        <p><strong>位置说明</strong>：<font color="#ff4400"><strong>智谷鞋库</strong></font>所属二级栏目下，相对应的<font color="#ff4400"><strong>供应商家</strong></font>栏目页右侧，广告位置有4个，依次往下排，价格参加下表。</p>
                        <p><strong>推广效果</strong>：<img src="img/star2.png" /><img src="img/star2.png" /><img src="img/star2.png" /><img src="img/star2.png" /><img src="img/star2.png" /></p>
                        <p class="disnone"><strong>订购价格</strong>：<font color="#ff4400"><strong>200</strong></font>元/7天</p>
                        <p><strong>订购须知</strong>：对智谷同城货源网的所有会员，先到先得。</p>
                    </div>
                    <div class="uccb_content">
                        <table cellpadding="0" cellspacing="0">
                        <thead><tr><th>栏目名称<th>时间</th><th>单价（元/天）</th><th>价格</th><th>订购天数</th><th>订购操作</th></tr></thead>
                            <tbody></tbody>
                        </table>
                    </div>
                      <div class="pager" id="paginationContainer9"></div>
                  </div>
   
                <!--// 内容2 //-->
         
            <div class="userCommContentBox disnone" id="userCommContentBox10">
                    <div class="uccb_intro">
                        <p><strong>位置说明</strong>：<font color="#ff4400"><strong>智谷服饰</strong></font>所属二级栏目下，相对应的<font color="#ff4400"><strong>供应商家</strong></font>栏目页右侧，广告位置有4个，依次往下排，价格参加下表。</p>
                        <p><strong>推广效果</strong>：<img src="img/star2.png" /><img src="img/star2.png" /><img src="img/star2.png" /><img src="img/star2.png" /><img src="img/star2.png" /></p>
                        <p class="disnone"><strong>订购价格</strong>：<font color="#ff4400"><strong>200</strong></font>元/7天</p>
                        <p><strong>订购须知</strong>：对智谷同城货源网的所有会员，先到先得。</p>
                    </div>
                    <div class="uccb_content">
                        <table cellpadding="0" cellspacing="0">
                           <thead><tr><th>栏目名称<th>时间</th><th>单价（元/天）</th><th>价格</th><th>订购天数</th><th>订购操作</th></tr></thead>
                            <tbody></tbody>
                        </table>
                    </div>
                      <div class="pager" id="paginationContainer10"></div>
                  </div>
    
                <!--// 内容3 //-->

            <div class="userCommContentBox disnone" id="userCommContentBox11">
                    <div class="uccb_intro">
                        <p><strong>位置说明</strong>：<font color="#ff4400"><strong>智谷美妆</strong></font>所属二级栏目下，相对应的<font color="#ff4400"><strong>供应商家</strong></font>栏目页右侧，广告位置有4个，依次往下排，价格参加下表。</p>
                        <p><strong>推广效果</strong>：<img src="img/star2.png" /><img src="img/star2.png" /><img src="img/star2.png" /><img src="img/star2.png" /><img src="img/star2.png" /></p>
                        <p class="disnone"><strong>订购价格</strong>：<font color="#ff4400"><strong>200</strong></font>元/7天</p>
                        <p><strong>订购须知</strong>：对智谷同城货源网的所有会员，先到先得。</p>
                    </div>
                    <div class="uccb_content">
                        <table cellpadding="0" cellspacing="0">
                          <thead><tr><th>栏目名称<th>时间</th><th>单价（元/天）</th><th>价格</th><th>订购天数</th><th>订购操作</th></tr></thead>
                            <tbody></tbody>
                        </table>
                    </div>
                      <div class="pager" id="paginationContainer11"></div>
                  </div>

                <!--// 内容4 //-->
            <div class="userCommContentBox disnone" id="userCommContentBox12">
                    <div class="uccb_intro">
                        <p><strong>位置说明</strong>：<font color="#ff4400"><strong>智谷美食</strong></font>所属二级栏目下，相对应的<font color="#ff4400"><strong>供应商家</strong></font>栏目页右侧，广告位置有4个，依次往下排，价格参加下表。</p>
                        <p><strong>推广效果</strong>：<img src="img/star2.png" /><img src="img/star2.png" /><img src="img/star2.png" /><img src="img/star2.png" /><img src="img/star2.png" /></p>
                        <p class="disnone"><strong>订购价格</strong>：<font color="#ff4400"><strong>200</strong></font>元/7天</p>
                        <p><strong>订购须知</strong>：对智谷同城货源网的所有会员，先到先得。</p>
                    </div>
                    <div class="uccb_content">
                        <table cellpadding="0" cellspacing="0">
                        <thead><tr><th>栏目名称<th>时间</th><th>单价（元/天）</th><th>价格</th><th>订购天数</th><th>订购操作</th></tr></thead>
                            <tbody></tbody>
                        </table>
                    </div>
                      <div class="pager" id="paginationContainer12"></div>
                  </div>
            </div>
			<br style="clear:both;" />
        </div>
    </div>
</div>

</body>
</html>

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

<script type="text/javascript" src="js/ad/ad.js"></script>
</head>

<body>
    <!--// 右侧容器 //-->
    <div class="rightContainer">
    	<!--// 标题 //-->
        <h3 class="rc_title">栏目首页广告<a href="#">我的主页</a></h3>
        <!--// 内容框 //-->
		<div class="rc_body">
        	<!--// tab切换条 //-->
            <div id="userCommTab" class="userCommTab">
            	<ul>
                	<li><a href="javascript:void(0);" class="uctSelected" group="5">鞋库首页</a></li>
                    <li><a href="javascript:void(0);" group="6">服饰首页</a></li>
                    <li><a href="javascript:void(0);" group="7">美妆首页</a></li>
                    <li><a href="javascript:void(0);" group="8">美食首页</a></li>
                </ul>
            </div>
            <!--// 对应内容框 //-->
			<div id="userContents" class="userContents">
            	<!--// 内容1 //-->
            	<span>
                  <div class="userCommContentBox disnone" id="userCommContentBox5">
                    <div class="uccb_intro">
                        <p><strong>位置说明</strong>：智谷鞋库，智谷服饰，智谷美妆，智谷美食所属二级栏目下，相对应的供应商家栏目页右侧，广告位置有4个，依次往下排，价格参加下表。</p>
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
                    <div class="pager" id="paginationContainer5"></div>
                  </div>

                <!--// 内容2 //-->
                <div class="userCommContentBox disnone" id="userCommContentBox6"> <div class="uccb_intro">
                        <p><strong>位置说明</strong>：智谷鞋库，智谷服饰，智谷美妆，智谷美食所属二级栏目下，相对应的供应商家栏目页右侧，广告位置有4个，依次往下排，价格参加下表。</p>
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
                            <div class="pager" id="paginationContainer6"></div>
                            </div>
         
                <!--// 内容3 //-->
              <div class="userCommContentBox disnone" id="userCommContentBox7"> <div class="uccb_intro">
                        <p><strong>位置说明</strong>：智谷鞋库，智谷服饰，智谷美妆，智谷美食所属二级栏目下，相对应的供应商家栏目页右侧，广告位置有4个，依次往下排，价格参加下表。</p>
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
                            <div class="pager" id="paginationContainer7"></div>
                            </div>
                   
                <!--// 内容4 //-->
        <div class="userCommContentBox disnone" id="userCommContentBox8"> <div class="uccb_intro">
                        <p><strong>位置说明</strong>：智谷鞋库，智谷服饰，智谷美妆，智谷美食所属二级栏目下，相对应的供应商家栏目页右侧，广告位置有4个，依次往下排，价格参加下表。</p>
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
                            <div class="pager" id="paginationContainer8"></div>
                   
                            
            </div>
			<br style="clear:both;" />
        </div>
    </div>
</div>

</body>
</html>

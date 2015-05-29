<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html >
<head>
<base href="${applicationScope.basePath}" />
<title>首页</title>
</head>
<body>
	<h3 class="sysIndH3">用户统计</h3>
	<table cellpadding="0" cellspacing="0" class="sysCommonTable">
		<tr>
			<th>会员总数</th>
			<th>充值用户</th>
			<th>今日新增</th>
			<th>今日登录</th>
		</tr>
		<tr>
			<td>${statMember.sum }</td>
			<td>${statMember.rechargeSum }</td>
			<td>${statMember.todayRegSum }</td>
			<td>${statMember.todayLoginSum }</td>
		</tr>
	</table>
	<div class="sysLine"></div>
	<h3 class="sysIndH3">商品数据统计</h3>
	<table cellpadding="0" cellspacing="0" class="sysCommonTable">
		<tr>
			<th>商品发布总数</th>
			<th>今日发布数</th>
			<th>商品上架总数</th>
			<th>今日上架数</th>
			<th>商品下架总数</th>
			<th>今日下架数</th>
			<th>商品上传数据包总数</th>
			<th>商品图片下载总数</th>
		</tr>
		<tr>
			<td>${statCommodity.sum }</td>
			<td>${statCommodity.todayAdd }</td>
			<td>${statCommodity.upSum }</td>
			<td>${statCommodity.todayUpSum }</td>
			<td>${statCommodity.downSum }</td>
			<td>${statCommodity.todayDownSum }</td>
			<td>${statCommodity.fileSum }</td>
			<td>${statCommodity.downLoadSum }</td>
		</tr>
	</table>
	<div class="sysLine"></div>
	<h3 class="sysIndH3">充值数据统计</h3>
	<table cellpadding="0" cellspacing="0" class="sysCommonTable">
		<tr>
			<th>今日充值总额</th>
			<th>全部充值总额</th>
		</tr>
		<tr>
			<td>${statRecharge.todaySumMoney }</td>
			<td>${statRecharge.sumMoney }</td>
		</tr>
	</table>
	<div class="sysLine"></div>
	<h3 class="sysIndH3">订单数据统计</h3>
	<table cellpadding="0" cellspacing="0" class="sysCommonTable">
		<tr>
			<th>所有订单共</th>
			<th>价格总额</th>
			<th>今日订单共计</th>
			<th>价格总额</th>
		</tr>
		<tr>
			<td>${statOrder.sum }</td>
			<td>${statOrder.sumMoney }</td>
			<td>${statOrder.todaySum }</td>
			<td>${statOrder.todaySumMoney }</td>
		</tr>
	</table>
	<div class="sysLine"></div>
<!-- 	<h3 class="sysIndH3">广告数据统计</h3> -->
<!-- 	<table cellpadding="0" cellspacing="0" class="sysCommonTable"> -->
<!-- 		<tr> -->
<!-- 			<th>今日广告共计</th> -->
<!-- 			<th>价格总额</th> -->
<!-- 			<th>所有广告共计</th> -->
<!-- 			<th>所有广告共计</th> -->
<!-- 		</tr> -->
<!-- 		<tr> -->
<!-- 			<td>0</td> -->
<!-- 			<td>0</td> -->
<!-- 			<td>0</td> -->
<!-- 			<td>0</td> -->
<!-- 		</tr> -->
<!-- 	</table> -->
</body>
</html>
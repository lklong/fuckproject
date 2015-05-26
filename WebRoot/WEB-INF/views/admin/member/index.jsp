<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="${applicationScope.basePath}" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>供应商会员列表</title>
<link href="js/3rdparty/easyui/themes/bootstrap/easyui.css" rel="stylesheet" type="text/css">
<link href="css/jcDate.css" rel="stylesheet" type="text/css" media="all" />
<script src="js/admin/admin.js" type="text/javascript"></script>
<link href="js/3rdparty/zTree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css" media="all" />
<script type="text/javascript" language="javascript" src="js/3rdparty/zTree/js/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" src="js/admin/member.js"></script>
</head>

<body>
	<!-- //功能条// -->
	<form method="post" id="memberForm" action="admin/member/index" class="fl">
		<div class="sysContBar">
			<div class="sysCBBox">
				<div>会员名</div>
				<div>
					<input name="username" value="${mc.username }" class="sysCommonInput" type="text" />
				</div>
				<div>电话</div>
				<div>
					<input name="phone" value="${mc.phone }" class="sysCommonInput" type="text" />
				</div>
				<div>邮箱</div>
				<div>
					<input name="email" value="${mc.email }" class="sysCommonInput" type="text" />
				</div>
				<div>店铺名</div>
				<div>
					<input name="storeName" value="${mc.storeName }" class="sysCommonInput" type="text" />
				</div>
				<div>注册时间</div>
				<div>
					<input class="jcDate sysCommonInput" type="text" id="date1" name="startDate" readonly="readonly" value="<fmt:formatDate value="${mc.startDate }" pattern="yyyy-MM-dd"/>" />
				</div>
				<div>-</div>
				<div>
					<input class="jcDate sysCommonInput" type="text" id="date2" name="endDate" readonly="readonly" value="<fmt:formatDate value="${mc.endDate }" pattern="yyyy-MM-dd"/>" />
				</div>
			</div>
			<div class="sysCBBox">
				<div>
					<select class="sysComSelect" name="isPhoneBound" id="isPhoneBound">
						<option value="">手机绑定</option>
						<option value="1">是</option>
						<option value="0">否</option>
					</select>
				</div>
				<div>
					<select class="sysComSelect" name="isEmailBound" id="isMailBound">
						<option value="">邮箱绑定</option>
						<option value="1">是</option>
						<option value="0">否</option>
					</select>
				</div>
				<div>
					<select class="sysComSelect" name="realUserStatus" id="realUserStatus">
						<option value="">实名认证</option>
						<option value="1">待审核</option>
						<option value="2">已认证</option>
						<option value="0">全部</option>
					</select>
				</div>
<!-- 				<div> -->
<!-- 					<select class="sysComSelect" name="companyStatus" id="companyStatus"> -->
<!-- 						<option value="">企业认证</option> -->
<!-- 						<option value="1">待审核</option> -->
<!-- 						<option value="0">全部</option> -->
<!-- 					</select> -->
<!-- 				</div> -->
<!-- 				<div> -->
<!-- 					<select class="sysComSelect" name="realStoreStatus" id="realStoreStatus"> -->
<!-- 						<option value="">实体认证</option> -->
<!-- 						<option value="1">待审核</option> -->
<!-- 						<option value="0">全部</option> -->
<!-- 					</select> -->
<!-- 				</div> -->
			</div>
			<div class="sysCBBox">
				<input class="sysSubmit" type="button" value="查找" onclick="zhigu.search();"/> 
				<input type="hidden" name="order" id="mcorder"> <input type="hidden" name="status" id="mcstatus" value="${mc.status }">
			</div>
		</div>
	</form>

	<div class="tableActBar" id="sortType">
		<div>
			<strong>排序方式</strong>
		</div>
		<div>
			<em class="t_em">注册时间：</em><span id="order1" class="hyglboticon huis"></span><span class="hyglboticon huixia"></span>
		</div>
		<div>
			<em class="t_em">登陆次数：</em><span class="hyglboticon huis"></span><span class="hyglboticon huixia"></span>
		</div>
		<div>
			<em class="t_em">已买商品数：</em><span class="hyglboticon huis"></span><span class="hyglboticon huixia"></span>
		</div>
		<div>
			<em class="t_em">下载商品数：</em><span class="hyglboticon huis"></span><span class="hyglboticon huixia"></span>
		</div>
		<div>
			<em class="t_em">账户金额：</em><span class="hyglboticon huis"></span><span class="hyglboticon huixia"></span>
		</div>
	</div>
	<div class="tableActBar">
		<div>
			<a href="javascript:void(0)" onclick="batchAllot()" class="sysButonA2"><em></em>批量分配</a>
		</div>
		<div>
			<c:choose>
				<c:when test="${mc.status == 0 }">
					<a href="javascript:void(0)" onclick="batchFreeze()" class="sysButonA4"><em></em>批量禁用</a>
				</c:when>
				<c:when test="${mc.status == 9 }">
					<a href="javascript:void(0)" onclick="batchUsing()" class="sysButonA3"><em></em>批量启用</a>
				</c:when>
			</c:choose>
		</div>
		<div>
			<!-- <a href="javascript:void(0)">批量发送消息</a> -->
		</div>
	</div>

	<table class="sysCommonTable _memTable" cellspacing="0" cellpadding="0">
		<thead>
			<tr>
				<th><input onclick="allSelect(this)" type="checkbox" id="selectall" /></th>
				<th>会员ID</th>
				<th>会员名</th>
				<th>真实姓名</th>
				<th>电话</th>
				<th>邮箱</th>
				<th>账户金额</th>
				<th>已买商品数</th>
				<th>下载商品数</th>
				<th>发布商品数</th>
				<th>已卖商品数</th>
				<th>上传数据包数</th>
				<th>最后登录</th>
				<th>操作</th>
				<th>认证审核</th>
				<th>公司员工</th>
				<th>推荐的用户</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.datas }" var="m">
				<tr>
					<td><input type="checkbox" allot="${m.IsAllot }" class="_cbox" value="${m.UserID }" mname="${m.Username }" /></td>
					<td>${m.UserID }</td>
					<td>${m.Username }</td>
					<td>${m.RealName }</td>
					<td>${m.Phone }<c:if test="${empty m.Phone }">-</c:if></td>
					<td>${m.Email }<c:if test="${empty m.Email }">-</c:if></td>
					<td class="hygltablewy" <c:if test="${m.accountMoney > 0 }">style="color: red"</c:if>>￥<fmt:formatNumber value="${m.accountMoney }" pattern="#0.00" /></td>
					<td>${m.BuyCount }</td>
					<td>${m.DownLoadCount }</td>
					<td>${m.PubCount }</td>
					<td>${m.PubCount }</td>
					<td>${m.PubCount }</td>
					<td><fmt:formatDate value="${m.LatestLoginTime }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td>
							 <a href="javascript:void(0);" class="sysButonA5" onclick="detail(${m.UserID })"><em></em>详情</a> <c:choose>
							<c:when test="${m.Status == 0 }">
								<a href="javascript:void(0);" class="sysButonA4" onclick="freeze(${m.UserID },'${m.Username }')"><em></em>禁用</a>
							</c:when>
							<c:when test="${m.Status == 9 }">
								<a href="javascript:void(0);" class="sysButonA2" onclick="using(${m.UserID },'${m.Username }')"><em></em>启用</a>
							</c:when>
						</c:choose>
					</td>
					<td>
						<c:if test="${m.realUserStatus==1 }">
                        	<a href="javascript:void(0);" class="sysButonA3" onclick="realUserAuthInfo(${m.UserID})" ><em></em>实名认证</a>
                        </c:if>
                    	<c:if test="${m.realUserStatus==3 }">
                        	<a href="javascript:void(0);" class="sysButonA3" onclick="realUserAuthInfo(${m.UserID})" ><em></em>认证未通过</a>
                        </c:if>
                        <c:if test="${m.realUserStatus==2 }">
                        	<a href="javascript:void(0);" class="sysButonA3"><em></em>已实名</a>
                        </c:if>
<%-- 						 <c:if test="${m.CompanyStatus==1 }"> --%>
<%-- 							<a href="javascript:void(0);" class="sysButonA1" onclick="companyAuthInfo(${m.UserID})"><em></em>企业认证</a> --%>
<%-- 						</c:if> <c:if test="${m.RealStoreStatus==1 }"> --%>
<%-- 							<a href="javascript:void(0);" class="sysButonA1" onclick="realStoreAuthInfo(${m.UserID})"><em></em>实体认证</a> --%>
<%-- 						</c:if> --%>
					</td>
					<td>
						<a href="javascript:void(0);" onclick="updateIsInnerEmployee(${m.UserID},0,this)" class="sysButonA1" <c:if test="${m.IsInnerEmployee==0 }">style="display: none;"</c:if>><em></em>取消</a>
						<a href="javascript:void(0);" onclick="updateIsInnerEmployee(${m.UserID},1,this)" class="sysButonA2" <c:if test="${m.IsInnerEmployee==1 }">style="display: none;"</c:if>><em></em>标记</a>
					</td>
					<td>
						<a href="javascript:void(0);" onclick="lookRecommend('${m.UserID}','${m.Username }')" class="sysButonA1"><em></em>查看</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<!--// 分页 //-->
	<div class="dataPager">
		<div class="ddpage">
			<jsp:include page="../../include/page.jsp">
				<jsp:param name="request" value="function" />
				<jsp:param name="functionName" value="zhigu.search" />
			</jsp:include>
		</div>
	</div>

	<form action="admin/member/detail" id="memberDetailForm" method="post">
		<input type="hidden" name="memberID" id="memberID">
	</form>
	<div id="authInfoDiv" style="display: none;">认证信息加载中...</div>
	<div id="recommendUserDiv" style="display: none;">
		<p style="text-align: left; font-size: 14px; font-weight: bold; line-height: 40px; border-bottom: 1px dotted #dedede; text-indent: 15px;">
			<font color="#ff0000"><span id="lookRecommendUser"></span></font>推荐的用户：
		</p>
		<div class="ztree" id="recommendUserTree" style="padding: 10px;">加载用户文件夹...</div>
	</div>
	<!--------------------------------------------------footer---------------------------------------------------------->
	<script type="text/javascript" language="javascript" src="js/3rdparty/easyui/jquery.easyui.min.js_bak"></script>
	<script type="text/javascript" src="js/jQuery-jcDate.js"></script>
	<script type="text/javascript">
var zTreesetting={
		async:{
			enable: true,
			url:"/admin/member/queryMemberByRecommendUser",
			autoParam: ["id=userId"]
		},
		callback:{
			onClick:function(event, treeId, treeNode){
// 				$("#curFolderID").val(treeNode.id);
// 				loadFolderFile();
			}
		},
		view:{showIcon: false,selectedMulti:false}
	}
zhigu.search = function(pageNo){
	window.location.href = zhigu.cmn.formToUrl("#memberForm")+(pageNo?'&pageNo='+pageNo:'');
}
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
	$("#isMailBound").val("${mc.isEmailBound}");
	$("#isPhoneBound").val("${mc.isPhoneBound}");
	$("#isAllot").val("${mc.isAllot}");
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
			//$("#memberForm").submit();
			zhigu.search();
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
</script>
</body>
</html>

<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html >
<html >
<head>
<base href="${applicationScope.basePath}" />

</head>
<body>
	<!-- //功能条// -->
	<div class="sysContBar">
		<a href="/admin/adminuser/addAndUpate" class="sysButonA2"><em></em>新增管理员</a>
	</div>
	<table cellpadding="0" cellspacing="0" class="sysCommonTable _memTable">
		<tr>
			<th>管理员账号</th>
			<th>真实姓名</th>
			<th>创建时间</th>
			<th>上次登录</th>
			<th>登录次数</th>
			<th>级别权限</th>
			<th>状态</th>
			<th>操作</th>
		</tr>
		<c:forEach items="${page.datas }" var="u">
			<tr>
				<td>${u.name }</td>
				<td>${u.realName }</td>
				<td><fmt:formatDate value="${u.createTime }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
				<td><fmt:formatDate value="${u.latestLoginTime }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
				<td>${u.loginCount }</td>
				<td>${u.roleName }</td>
				<td>${u.status == 0 ? '正常':'禁用'}</td>
				<td><a href="/admin/adminuser/addAndUpate?id=${u.id }" class="sysButonA1"><em></em>编辑</a> <c:choose>
						<c:when test="${u.status == 0 }">
							<a href="javascript:void(0);" class="sysButonA4" onclick="changeStatus(${u.id },1)"><em></em>禁用</a>
						</c:when>
						<c:when test="${u.status == 1 }">
							<a href="javascript:void(0);" class="sysButonA2" onclick="changeStatus(${u.id },0)"><em></em>启用</a>
						</c:when>
					</c:choose></td>
			</tr>
		</c:forEach>
	</table>
	<div class="dataPager">
		<div class="ddpage">
			<jsp:include page="../../include/page.jsp">
				<jsp:param name="request" value="url" />
				<jsp:param name="requestUrl" value="admin/adminuser/index" />
			</jsp:include>
		</div>
	</div>

	<script type="text/javascript">

//更新用户状态事件
//<zy> 改_3
//2015-03-13 10:25
function changeStatus(id, status){
	$.layer({
	    shade: [0.5, '#000'],
	    area: ['auto','auto'],
	    dialog: {
	        msg: '确认更新此用户的状态吗？',
	        btns: 2,                    
	        type: 4,
	        btn: ['确定','取消'],
	        yes: function(){
	            _status();
	        }
	    }
	});
	
	//更新函数
	function _status(){
		$.post("/admin/adminuser/changeStatus", "id=" + id + "&status=" + status, function(msgBean){
			if(msgBean.code==zhigu.code.success){
				layer.msg(msgBean.msg, 1, f5);
			}else{
				layer.alert(msgBean.msg);
			}
		},"json");
	};
}
</script>
</body>
</html>
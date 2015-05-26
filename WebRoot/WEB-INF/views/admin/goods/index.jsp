<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>商品列表</title>
<script src="js/admin.js" type="text/javascript"></script>
<script src="/js/3rdparty/layer/extend/layer.ext.js" type="text/javascript"></script>
</head>
<body>
<!-- //功能条// -->
<div class="sysContBar">
	<form action="admin/goods/index" id="searh_form" method="post">
	<div class="sysCBBox">
		<div>商品名：</div>
		<div><input name="goodsName" value="${gc.goodsName }" class="sysCommonInput" type="text" /></div>
		<div>商品类别：</div>
		<div><select name="categoryId" class="sysComSelect">
			<option value="">-全部-</option>
			<c:forEach items="${categoryTypes }" var="c">
				<option value="${c.value }" <c:if test="${c.value==gc.categoryId }">selected="selected"</c:if>>${c.name }</option>
			</c:forEach>
		</select></div>
		<div><input class="sysSubmit" value="查找" type="submit"/></div>
	</div>
	<div class="sysCBBox">
		<div>共有 <span class="c">${page.totalRow }</span>个商品</div>
	</div>
	</form>
</div>

<div class="tableActBar">
	<div><input type="checkbox" onclick="selectAll();" id="selectAll"/><label for="selectAll"> 全选</label></div>
	<div>
		<a href="javascript:void(0);" onclick="batchSoldout();" class="sysButonA4"><em></em>批量下架</a>
		<c:if test="${status==0}">
			<a href="javascript:void(0)" onclick="auditPassBatch();" class="sysButonA3"><em></em>批量通过审核</a>
		</c:if>
	</div>
</div>
<table class="sysCommonTable" cellspacing="0" cellpadding="0">
	<thead>
		<tr>
			<th>&nbsp;ID</th>
			<th>商品标题</th>
			<th>价格</th>
			<th>上传时间</th>
			<th>商品分类</th>
			<th>商品图片</th>
			<th>商品描述</th>
			<th>操作</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.datas}" var="goods" >
			<tr>
				<td><input type="checkbox" name="checkedGoods" value="${goods.id}"/>${goods.id}</td>
				<td title="${goods.name }"><a href="goods/detail?goodsId=${goods.id}" target="_blank">${goods.name }</a></td>
				<td>￥${goods.minPrice }-￥${goods.maxPrice }</td>
				<td><fmt:formatDate value="${goods.time }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
				<td>-</td>
				<td>
						<c:if test="${!empty goods.image300}"><img src="${goods.image300}" width="70" height="70" /></c:if> 
				</td>
				<td class="">
					<a class="sysButonA1" href="javascript:void(0);" onclick="introduceShow(${goods.id});"><em></em>点击查看</a>
				</td>
				<td>
					<c:if test="${goods.status==1 }">
						<a class="sysButonA4" href="javascript:void(0);" onclick="soldout(${goods.id});"><em></em>下架</a>
					</c:if>
					<c:if test="${goods.status==2 }">
						已下架
					</c:if>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<div class="dataPager">
	<div class="ddpage">
		<jsp:include page="../../include/page.jsp">
			<jsp:param name="request" value="form"/>
			<jsp:param name="requestForm" value="searh_form"/>
		</jsp:include>
	</div>
</div>

	<div class="disnone">
		<div id="introduce" title="商品描述"></div>
	</div>
	<div id="rejectReasonDiv" class="disnone">
		审核未通过原因：
		<div><textarea id="rejectReason" cols="40" rows="5"></textarea></div>
		<div><button onclick="auditFail();">确定</button><button onclick="$('#rejectReasonDiv').dialog('close')">取消</button></div>
		<input type="hidden" id="fail_goodsID"/>
	</div>

<script type="text/javascript">
$(function(){
	$("#status").val("${status}");
});

//查看商品描述事件
//<zy> 改_3
//2015-3-13 14:44
function introduceShow(cid){
	ajaxSubmit("goods/ajaxQueryGoods",{"goodsId":cid},function(data){
		$.layer({
		 	type : 1,
		    shade: [0.5, '#000'],
		    area: ['900px','600px'],
		    title : '查看商品描述',
		    page: {
		    	html : data.description
		    }
		});
	},"json");
}

function auditPass(goodsID){
	var cids = [];
	cids.push(goodsID);
	confirmDialog("确认该商品通过审核？",function(){
		ajaxSubmit("admin/goods/auditPass",{'goodsID':cids},function(data){
			if(data.error==0){
				reloadCurrentPage();
			}
		},"json");
	});
}
function auditPassBatch(){
	var cids = [];
	$("input[name='checkedGoods']:checked	").each(function(){
		cids.push($(this).val());
	});
	if(cids.length==0){
		dialog("未选择商品！");
		return;
	}
	confirmDialog("确认选中商品通过审核？",function(){
		ajaxSubmit("admin/goods/auditPass",{'goodsID':cids},function(data){
			if(data.error==0){
				reloadCurrentPage();
			}
		},"json");
	});
}
function auditFail(){
	var rejectReason = $("#rejectReason").val();
	if(rejectReason.length<1||rejectReason.length>200){
		alert("请正确审核不通过原因（不能超过200字）！");
		return;
	}
	ajaxSubmit("admin/goods/auditFail",{"goodsID":$("#fail_goodsID").val(),"rejectReason":rejectReason},function(data){
		if(data.error==0){
			reloadCurrentPage();
		}
	});
}
function batchSoldout(){
	$("#reasonDiv").dialog({
		title:"原因",
		resizable:true,
		buttons: [{
					text: "　确定　",
					handler: function () {
						var reason = $("#reason").val();
						if(reason.length<1||reason.length>200){
							alert("请正确下架原因（不能超过200字）！");
							return;
						}
						confirmDialog("确认下架选中的商品？",function(){
							$("input[name='checkedGoods']:checked").each(function(){
								ajaxSubmit("admin/goods/soldout",{"goodsID":$(this).val(),"soldOutReason":reason},function(msgBean){
									if(msgBean.code == zhigu.code.success){
										layer.msg(msgBean.msg, 1, f5);
									}else{
										layer.alert(msgBean.msg);
									}
								},'json',false);
							});;
							reloadCurrentPage();
						});
					}
					},{
					text: "　取消　",
					 handler: function () {
						 $("#reasonDiv").dialog("close");
					}
		 }]
	});
	//$("#reasonDiv").dialog("open");
}

//下架事件
//<zy> 改_2
//2015-3-13 13:52
function soldout(goodsID){
	
	layer.prompt({title: '请填写下架原因',type: 3}, function(val){
		_xiaJia(val);
	});
	
	//下架函数
	function _xiaJia(val)
	{
		//检查输入信息
		if(val.length <= 0 || val.length > 200){
			//如果信息错误放弃
			layer.alert('请填写下架原因（字数不能为空，且不超过200字）！', 5);
		}
		else
		{
			//否则执行
			layer.confirm('确认下架此商品？', function(){
				ajaxSubmit("admin/goods/soldout",{"goodsID":goodsID,"soldOutReason":val},function(msgBean){
					if(msgBean.code == zhigu.code.success){
						layer.msg(msgBean.msg, 1, f5);
					}else{
						layer.alert(msgBean.msg);
					}
				},"json");
			}, function(){});
		}
	}
}

//
function markReview(cid,obj){
	ajaxSubmit("admin/goods/markReview",{"goodsID":cid},function(data){
		if(data.error==0){
			$(obj).replaceWith("<button class='yfenpeibut'>已阅</button>");
		}
	},"json");
}
function selectAll(obj){
	if($("#selectAll").is(":checked")){
		$("input[name='checkedGoods']").prop("checked",true);
	}else{
		$("input[name='checkedGoods']").prop("checked",false);
	}
}
</script>
</body>
</html>

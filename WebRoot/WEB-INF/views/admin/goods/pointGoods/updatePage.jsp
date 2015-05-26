<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改积分商品</title>
</head>
<body>
	<script type="text/javascript" src="js/ajaxfileupload.js"></script>
	<h3>积分商品修改页面</h3>
	
	<form onsubmit="return zhigu.pointGoods.updateFormCheck();" action="admin/goods/pointGoodsUpdate" method="post" enctype="application/x-www-form-urlencoded">
	<table class="sysCommonTable" cellspacing="0" cellpadding="0">
		<input type="hidden" name="id" value="${ pointExchangeGoods.id }" />
		<input type="hidden" name="version" value="${ pointExchangeGoods.version }"  />  
		<tr>
			<th width="10%">当前图片</th>
			<td><img id="picture_show" src="${pointExchangeGoods.picture}" height="70" width="70"  /></td>
		</tr>
		<tr>
			<th width="10%"></th>
			<td >
				<input type="hidden" name="picture" id="picture" value="${ pointExchangeGoods.picture }"/>
				<input type="button" value="上传主图" onclick="zhigu.pointGoods.pointGoodsImgUpload()" />
			</td>
		</tr>
		<tr>
			<th width="10%">积分商品名</th>
			<td><input class="sysCommonInput" type="text"  name="name" id="name" value="${pointExchangeGoods.name}"/></td>
		</tr>
		<tr>
			<th width="10%">价值</th>
			<td><input class="sysCommonInput" type="text" name="money" id="money" value="${pointExchangeGoods.money}" /></td>
		</tr>
		<tr>
			<th width="10%">积分类型</th>
			<td>
				<select name="pointType">
					<c:forEach items="${pointTypes }" var="pointType">
						<option value="${pointType.value }" <c:if test="${pointType.value==pointExchangeGoods.pointType }">selected="selected"</c:if>>${pointType.name }</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<th width="10%">所需积分</th>
			<td><input class="sysCommonInput" type="text" name="needPoint" id="needPoint" value="${pointExchangeGoods.needPoint}" /></td>
		</tr>
		<tr>
			<th width="10%">库存</th>
			<td><input class="sysCommonInput" type="text" name="repertory"  id="repertory" value="${pointExchangeGoods.repertory}" /></td>
		</tr>
		<tr>
			<th width="10%">详情</th>
			<td>
			    <div class="jibenform">
		 		<div class="title" style="clear:both;height:30px;">
			 	</div>
			 	<div class="tupianright fl" style="border:none;">
			 		<jsp:include page="../../../ueditor/index.jsp">
			 			<jsp:param name="desc" value="${pointExchangeGoods.details}" />
			 		</jsp:include>
			 	</div>
		 	  </div>
             
          <div class="clear"></div>
			</td>
		</tr>
		<tr>
			<td colspan="2">
			<input type="hidden" name="details"/>
				<input type="submit" class="sysSubmit" value="确定"  />
			</td>
		</tr>
	</table>
	</form>
</div>
</div>
<script charset="utf-8" src="js/3rdparty/kindeditor/kindeditor.js"></script>
<script charset="utf-8" src="js/3rdparty/kindeditor/lang/zh_CN.js"></script>
	<script src="js/admin/admin.js" type="text/javascript"></script>
	<jsp:include page="../../../include/adminupfile.jsp"></jsp:include>
	<script type="text/javascript">
	//文本编辑器
/* 	var editor;
	KindEditor.ready(function(K) {
		editor = K.create('textarea[name="details"]', {
			width : '975px',
			uploadJson : 'admin/file/uploadImage.ajax?ftype=1',
			allowFileManager : false,
			items : [ 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline', 'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
					'insertunorderedlist', '|', 'emoticons', 'image','multiimage','|','preview'],
			afterBlur : function() {
				this.sync();
			}
		});
	}); */
		var xiaoshuReg = /^\d+|\d+.\d{1,2}$/;
		var zhengshuReg = /^\d+$/;
		
		if( !zhigu.pointGoods ){
			zhigu.pointGoods = {};
		}
		
		zhigu.pointGoods.updateFormCheck = function (){
			var content = UE.getEditor('editor').getPlainTxt();
			var reg = /\s/g;
	    	_content = str.replace(reg,'');
			if(_content!="" || _content.length!=0){
				$("input[name='details']").val(content);
		   }
			var name = $("#name");
			var money = $("#money");
			var needPoint = $("#needPoint");
			var repertory = $("#repertory");
			var picture = $("#picture");
			if( name.val() == null  ){
				dialog( "物品名不能为空！" );
				return false;
			}
			if( !xiaoshuReg.test(money.val()) ){
				dialog( "请输入正确的价格！(正整数或小数)" );
				return false;
			}
			if( !zhengshuReg.test(needPoint.val()) ){
				dialog( "请输入正确的积分！(正整数)" );
				return false;
			}
			if( !zhengshuReg.test(repertory.val()) ){
				dialog( "请输入正确的库存！(正整数)" );
				return false;
			}
			return true;
		}
		zhigu.pointGoods.pointGoodsImgUpload = function(){
			popUpfile(1,function(data){
				$("#picture").val(data.url);
				$("#picture_show").prop("src","/"+data.url);
			});	
		}
	</script>
</body>
</html>
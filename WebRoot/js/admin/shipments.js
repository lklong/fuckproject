
var fahuoInfoLayer = null;	//div编辑框对象

//单条订单发货
function shipments(cbox,orderId){
	var html = "<div style='height:20px;'></div><span style='color:red;margin:0 20px'>物流号填写后不可修改，请认真填写！</span><br><br>";
	html += "<table class='sysCommonTable' cellspacing='0' cellpadding='0' border='0' style='width:900px;margin:0 20px'>";
	html += "<tr><th>订单号</th><th>收货人</th><th>电话</th><th>地址</th><th>配送方式</th><th>快递号</th></tr>";
	html += "<tr>";
	html += "<td>" + $("#" + cbox).attr("ono") + "</td>"
	html += "<td>" + $("#" + cbox).attr("cg") + "</td>"
	html += "<td>" + $("#" + cbox).attr("phone") + "</td>"
	html += "<td title='" + $("#" + cbox).attr("ad") + "'>" + $("#" + cbox).attr("ad") + "</td>"
	html += "<td>" + $("#" + cbox).attr("log") + "</td>"
	html += "<td><input id='expressNo' class='_logno' oid='" + $("#" + cbox).val() + "' type='text'></td>"
	html += "</tr>";
	html += "</table>";
	html += "<div style='height:20px;'></div>";
	html += "<div style='height:60px;background-color:#f0f0f0;padding-top:20px;'><div style='margin:0 auto; width:180px;'><a  href='javascript:void(0);' onclick='sendOrderGood("+orderId+");' class='sysButonA3'><em></em>&nbsp;&nbsp;&nbsp;确认&nbsp;&nbsp;&nbsp;</a><a id='cancelClose' href='javascript:void(0)' class='sysButonA2'><em></em>&nbsp;&nbsp;&nbsp;取消&nbsp;&nbsp;&nbsp;</a></div></div>";
	fahuoInfoLayer = $.layer({
	 	type : 1,
	    shade: [0.5, '#000'],
	    area: ['auto','auto'],
	    title : '发货确认',
	    page: {
	    	html : html
	    }
	});
}
function sendOrderGood(orderId){
	var expressNo = $("#expressNo").val();
	var sub = function(){
		ajaxSubmit("/admin/order/sendOrderGood", {'orderId':orderId,'expressNo':expressNo}, function(msgBean){
			if(msgBean.code==zhigu.code.success){
				layer.msg(msgBean.msg, 1, reloadCurrentPage);
			}else{
				layer.alert(msgBean.msg);
			}
		}, "json");
	}
	if(expressNo){
		sub();
	}else{
		layer.confirm("未填写物流号仍然继续？", sub);
	}
}
//绑定取消按钮
$('#cancelClose').live('click', function(){
	closeFahuoInfoLayer();
});
//绑定确定按钮
$('#saveCreate').live('click', function(){
	confirmOrdersSends();
});

//关闭管理员信息弹出框
function closeFahuoInfoLayer()
{
	if(fahuoInfoLayer != null)
	{
		layer.close(fahuoInfoLayer);
	}
}

//复选框全选
function allSelect(obj){
	$("._cbox").attr("checked",$(obj).attr("checked") == "checked");
}

//批量发货操作
//<zy> 改_3
//2015-3-13 16:04
function batchShipments(){
	var size = $("._memOrderList input:checkbox[checked][status='2']").size();
	if(size == 0){
		layer.msg('请选择需要发货的订单！', 1, 3);
		//return;
	}
	var html = "<div style='height:20px;'></div><span style='color:red;margin:0 20px'>物流号填写后不可修改，请认真填写！</span><br><br>";
	html += "<table class='sysCommonTable' cellspacing='0' cellpadding='0' border='0' style='width:900px;margin:0 20px'>";
	html += "<tr><th>订单号</th><th>收货人</th><th>电话</th><th>地址</th><th>物流</th><th>物流号</th></tr>";
	$("._memOrderList input:checkbox[checked][status='2']").each(function(){
		html += "<tr>";
		html += "<td>" + $(this).attr("ono") + "</td>"
		html += "<td>" + $(this).attr("cg") + "</td>"
		html += "<td>" + $(this).attr("phone") + "</td>"
		html += "<td title='" + $(this).attr("ad") + "'>" + $(this).attr("ad") + "</td>"
		html += "<td>" + $(this).attr("log") + "</td>"
		html += "<td><input class='_logno' oid='" + $(this).val() + "' type='text'></td>"
		html += "</tr>";
	});
	html += "</table>";
	html += "<div style='height:20px;'></div>";
	html += "<div style='height:60px;background-color:#f0f0f0;padding-top:20px;'><div style='margin:0 auto; width:180px;'><a id='saveCreate' href='javascript:void(0)' class='sysButonA3'><em></em>&nbsp;&nbsp;&nbsp;确认&nbsp;&nbsp;&nbsp;</a><a id='cancelClose' href='javascript:void(0)' class='sysButonA2'><em></em>&nbsp;&nbsp;&nbsp;取消&nbsp;&nbsp;&nbsp;</a></div></div>";
	
	//弹出发货框
	$.layer({
	 	type : 1,
	    shade: [0.5, '#000'],
	    area: ['auto','auto'],
	    title : '发货确认',
	    page: {
	    	html : html
	    }
	});
}

//确认发货操作
function confirmOrdersSends(){
	var kv = "";
	var notLogisticsFlag = false;
	$("._logno").each(function(index){
		if($(this).val() == ""){
			notLogisticsFlag = true;
		}
		if(index != 0){
			kv += "&";
		}
		kv += "kv=" + ( $(this).attr("oid") + "|" +$(this).val() );
	});
	var sub = function(){
		ajaxSubmit("/admin/order/shipments", kv, function(msgBean){
			if(msgBean.code==zhigu.code.success){
				layer.msg(msgBean.msg, 1, reloadCurrentPage);
			}else{
				layer.alert(msgBean.msg);
			}
		}, "json");
	}
	if(notLogisticsFlag){
		layer.confirm("未填写物流号仍然继续？", sub);
	}else{
		sub();
	}
}
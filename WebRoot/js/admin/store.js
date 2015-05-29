/******* 店铺管理页面所需js   *******/
/******* y.z.x建  			 *******/
/******* 2015-04-16	 *******/

$(function(){
	if("${companyAuth.approveState!=null&&(companyAuth.approveState==1||companyAuth.approveState==2)}"=="true"){
		$("#alldd input,#alldd select,#alldd textarea").attr("disabled","disabled");
	}
})
function callbackImagePre(json){
	$("#preImage").attr("src","/"+json.url);
	$("#image").val(json.url);
}

/**
 * 如果选择“长期”则 隐藏营业期限
 */
function hideBusinessTerm(){
	if($("#perpetual").is(":checked")){
		$("#businessTerm").val('');
		$("#businessTerm").hide();
	}else{
		$("#businessTerm").show();
	}
}

/**
 * 企业认证
 * storeID	  店铺ID
 */
function storeCompanyAuthInfo(storeID){
	ajaxSubmit("admin/store/company/inner_info",{'storeID':storeID},function(data){
		$("#authInfoDiv").html(data);
		$.layer({
		    type : 1,
		    title : '企业认证',
		    area : ['620px','auto'],
		    page : {dom : '#authInfoDiv'}
		   
		});
	},"text");
}
/**
 * 点击“长期”按钮 隐藏时间选项控件
 */
function hideBusinessTerm(){
	if($("#perpetual").is(":checked")){
		$("#businessTerm").val('');
		$("#businessTerm").hide();
	}else{
		$("#businessTerm").show();
	}
}
/**
 * 保存企业信息
 */
function saveCompanyAuth(){
	if($("#companyName").val() == ""){
		$(".msg_companyName").html("请输入企业名称！");
		return;
	}else{
		$(".msg_companyName").html("");
	}
	if($("#companyType").val() == ""){
		$(".msg_companyType").html("请选择企业类型！");
		return;
	}else{
		$(".msg_companyType").html("");
	}
	if($("#regNumber").val() == ""){
		$(".msg_regNumber").html("请输入工商注册号！");
		return;
	}else{
		$(".msg_regNumber").html("");
	}
	if($("#corporation").val() == ""){
		$(".msg_corporation").html("请输入企业法人(个体工商户)！");
		return;
	}else{
		$(".msg_corporation").html("");
	}
	if($("#businessTerm").val() == "" && !($("#perpetual").attr("checked") ==="checked")  ){
		$(".msg_businessTerm").html("请选择营业期限！");
		return;
	}else{
		$(".msg_businessTerm").html("");
	}
	if($("#capital").val() == ""){
		$(".msg_capital").html("请输入注册资金！");
		return;
	}else{
		$(".msg_capital").html("");
	}
	if($("#businessScope").val() == ""){
		$(".msg_businessScope").html("请输入营业范围！");
		return;
	}else{
		$(".msg_businessScope").html("");
	}
	if($("#regStreet").val() == ""){
		$(".msg_regAddress").html("请输入注册地址！");
		return;
	}else{
		$(".msg_regAddress").html("");
	}
	if($("#companyStreet").val() == ""){
		$(".msg_companyAddress").html("请输入经营地址！");
		return;
	}else{
		$(".msg_companyAddress").html("");
	}
	if($("#preImage").attr("src") == ""){
		$(".msg_image").html("请上传营业执照！");
		return;
	}else{
		$(".msg_image").html("");
	}
	$("#companyAuthForm").ajaxSubmit({
			type: 'post',
			dataType:'json',
			success:function (msgBean) {
				if(msgBean.code==zhigu.code.success){
					layer.msg(msgBean.msg, 1, reloadCurrentPage);
					setTimeout("changePage()", 1000);
				}else{
					layer.msg(msgBean.msg, 1, 3);
					setTimeout("changePage()", 1000);
				}
			}
	});
}
/**
 * 更新企业认证状态
 * @param status
 */
function companyAuthStatus(status){
	var status = $("#status").val(status);
	$("#companyAuthStatusForm").ajaxSubmit({
			type: 'post',
			dataType:'json',
			success:function (msgBean) {
				if(msgBean.code==zhigu.code.success){
					layer.msg(msgBean.msg);
					setTimeout("changePage()", 1000);
				}else{
					if(msgBean.level == 2){
						layer.alert(msgBean.msg);
						return;
					}
					setTimeout("changePage()", 1000);
				}
			}
	});
}
/**
 * 更新实体认证状态
 * @param status
 */
function realStoreAuthStatus(status){
	var status = $("#status").val(status);
	$("#realStoreAuthStatusForm").ajaxSubmit({
			type: 'post',
			dataType:'json',
			success:function (msgBean) {
				if(msgBean.code==zhigu.code.success){
					layer.msg(msgBean.msg);
					setTimeout("changePage()", 1000);
				}else{
					if(msgBean.level == 2){
						layer.alert(msgBean.msg);
						return;
					}
					setTimeout("changePage()", 1000);
				}
			}
	});
}

/**
 * 创建实体认证窗口
 * @param storeID 店铺 ID
 */
function realStoreAuth(storeID){
	ajaxSubmit("admin/store/realStore/inner_info",{'storeID':storeID},function(data){
		$("#authInfoDiv").html(data);
		$.layer({
		    type : 1,
		    title : '实体认证',
		    area : ['620px','auto'],
		    page : {dom : '#authInfoDiv'}
		});
	},"text");
}
/**
 * 保存实体认证信息
 */
function saveRealStoreAuth(){
	if($("#realStoreName").val() == ""){
		$(".msg_realStoreName").html("请输入店铺名称！");
		return;
	}else{
		$(".msg_realStoreName").html("");
	}
	if($("#master").val() == ""){
		$(".msg_master").html("请输入经营人姓名！");
		return;
	}else{
		$(".msg_master").html("");
	}
	if($("#phone").val() == ""){
		$(".msg_phone").html("请输入电话号码！");
		return;
	}else{
		var tel = /^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$/; 
		if(tel.test($("#phone").val())){
			$(".msg_phone").html("请输入正确的电话号码！");
			return;
		}else{
			$(".msg_phone").html("");
		}
		$(".msg_phone").html("");
	}
	if($("#realStoreAddress").val() == ""){
		$(".msg_realStoreAddress").html("请输入实体店铺地址！");
		return;
	}else{
		$(".msg_realStoreAddress").html("");
	}
	if($("#preImage1").attr("src") == "" || $("#preImage2").attr("src") == ""|| $("#preImage3").attr("src") == ""){
		$(".msg_image").html("请上传至少一张实体店图片！");
		return;
	}else{
		$(".msg_image").html("");
	}
	$("#realStoreAuthForm").ajaxSubmit({
		type: 'post',
		dataType:'json',
		success:function (msgBean) {
			if(msgBean.code==zhigu.code.success){
				 layer.msg(msgBean.msg, 1, reloadCurrentPage);
				setTimeout("changePage()", 1000);
			}else{
				layer.alert(msgBean.msg, 1, 3);
				setTimeout("changePage()", 1000);
			}
		}
	});
}

function changePage(){
	window.location = "admin/store/index";	
}
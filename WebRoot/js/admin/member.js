/******* 会员管理页面所需js   *******/
/******* <zy> 建  			 *******/
/******* 2015-02-05 09:30	 *******/

/* 标记为公司员工
 * userID 			-ID
 * isInnerEmployee	-0,1
 * obj  			-触发对象
 */
function updateIsInnerEmployee(userID,isInnerEmployee,obj){
	var msg = "";
	if(isInnerEmployee==1){
		msg='<p style="text-align:center;">确认将此会员标记为公司员工？</p>';
	}
	else
	{
		msg = '<p style="text-align:center;">确认取消公司员工标记？</p>';
	}
	//弹出对话框
	$.layer({
	    shade: [0.5],
	    shade: [0.5, '#000'],
	    title: '标记会员',
	    dialog: {
	        msg: msg,
	        btns: 2,                    
	        type: 4,
	        btn: ['确认','取消'],
	        yes: function(){
	        	_biaoji();
	        }
	    }
	});
	//标记函数
	function _biaoji(){
		ajaxSubmit("admin/member/updateIsInnerEmployee",{"userID":userID,"isInnerEmployee":isInnerEmployee},function(msgBean){
			if(msgBean.code == zhigu.code.success){
				layer.msg(msgBean.msg, 1, f5);
			}else{
				layer.alert(msgBean.msg);
			}
		},"json");
	};
}

/* 禁用会员帐号
 * member 			-会员id
 * username			-会员名
 */
function freeze(member,username){
	var msg = '<p style="text-align:center;">确定禁用帐号：<font color="#ff3300"><strong>'+ username + '</strong></font><p>';
	//弹出对话框
	$.layer({
	    shade: [0.5, '#000'],
	    title: '禁用帐号',
	    dialog: {
	        msg: msg,
	        btns: 2,                    
	        type: 4,
	        btn: ['确认','取消'],
	        yes: function(){
	        	_jinyong();
	        }
	    }
	});
	//禁用函数
	function _jinyong(){
		ajaxSubmit("admin/member/freeze", "mems="+member, function(msgBean){
			if(msgBean.code == zhigu.code.success){
				layer.msg(msgBean.msg, 1, f5);
			}else{
				layer.alert(msgBean.msg);
			}
		},"json");
	};
}

/* 分配会员
 * member 			-会员id
 * username			-会员名
 */
//单个会员分配方法
function allot(member,username){
	popAllot("mems=" + member, username);
}
//分配方法
function popAllot(mids,username){
	var fenPenLayer = null;		//弹出层对象
	var headMsg = "<div style='height:20px;'></div><div style='font-size:14px;font-weight:bold;line-height:40px;margin:0 20px'>你即将把<font color='#ff3300'><strong>" + username + "</strong></font> 分配到：</div>";
	var html = function(){
		var temp = '';
		ajaxSubmit("admin/adminuser/ajaxList", "", function(data){
			temp += "<ul class='fenpeifl fenpei'>";
			for(var i = 0 ; i < data.length ; i++){
				temp += "<li><input type='radio' name='userID' value='" + data[i].userID + "' class='ver_ali mr5'/>" + data[i].username + " ｜ " + data[i].realName + "</li>";
			}
			temp += "</ul><div style='height:20px;'></div>";
			temp += "<div style='height:60px;background-color:#f0f0f0;padding-top:20px;'><div style='margin:0 auto; width:180px;'><a id='saveCreate' href='javascript:void(0)' class='sysButonA3'><em></em>&nbsp;&nbsp;&nbsp;确认&nbsp;&nbsp;&nbsp;</a><a id='cancelClose' href='javascript:void(0)' class='sysButonA2'><em></em>&nbsp;&nbsp;&nbsp;取消&nbsp;&nbsp;&nbsp;</a></div></div>";
		},"",false);
		return headMsg+temp;
	}();
	//弹出分配列表框
	fenPenLayer = $.layer({
	 	type : 1,
	    shade: [0.5, '#000'],
	    area: ['auto','auto'],
	    title : '会员分配',
	    page: {
	    	html : html
	    }
	});
	//绑定取消按钮
	$('#cancelClose').on('click', function(){
		closeFenPeiLayer();
	});
	//绑定确定按钮
	$('#saveCreate').on('click', function(){
		_fenpei();
	});
	//关闭分配列表框
	function closeFenPeiLayer()
	{
		if(fenPenLayer != null)
		{
			layer.close(fenPenLayer);
		}
	}
	//分配函数
	function _fenpei(){
		var staffID = $(".fenpeifl input[type='radio']:checked").val();
		if(staffID == undefined){
			layer.msg('请指定分配员工!', 2, 3);
		}else{
			ajaxSubmit("admin/member/allot", "staffID=" + staffID + "&"+mids, function(msgBean){
				if(msgBean.code == zhigu.code.success){
					layer.msg(msgBean.msg, 1, f5);
				}else{
					layer.alert(msgBean.msg);
				}
			},"json");
		}
	};
}

/* 查看推荐的用户
 * userID 			-会员id
 * userName			-会员名
 */
function lookRecommend(userID,userName){
	var zTree;
	$("#lookRecommendUser").html(userName);
	zTree = $.fn.zTree.init($("#recommendUserTree"), zTreesetting, {'id':userID,'name':userName,'pid':0,'isParent':true});
	$("#userWriteRecommend").html("<input type='button' onclick='zhigu.queryUserWriteRecommend("+userID+")' value='此会员填写的推荐人'/>");
	//弹出分配列表框
	fenPenLayer = $.layer({
	 	type : 1,
	    shade: [0.5, '#000'],
	    area: ['700','600'],
	    title : '查看推荐的用户',
	    page: {
	    	dom : '#recommendUserDiv'
	    }
	});
}

/* 批量禁用
 * userID 			-会员id
 * userName			-会员名
 */
function batchFreeze(){
	var size = $("._memTable input:checkbox[checked]").size();
	if(size == 0){
		layer.msg('请选择需要禁用的用户！', 2, 5);
		return;
	}
	var mids = "";
	$("._memTable input:checkbox[checked]").each(function(index){
		if(index != 0){
			mids += "&";
		}
		mids += ("mems=" + $(this).val());
	});
	//确认是否禁用
	$.layer({
	    shade: [0.5, '#000'],
	    title: '批量会员禁用',
	    dialog: {
	        msg: '确定禁用已选择的会员帐号！',
	        btns: 2,                    
	        type: 4,
	        btn: ['确认','取消'],
	        yes: function(){
	        	_jinyong();
	        }
	    }
	});
	//禁用函数
	function _jinyong(){
		ajaxSubmit("admin/member/freeze", mids, function(msgBean){
			if(msgBean.code == zhigu.code.success){
				layer.msg(msgBean.msg, 1, f5);
			}else{
				layer.alert(msgBean.msg);
			}
		},"json");
	}
}
//获取用户填写推荐人的初始数据
zhigu.queryUserWriteRecommend = function(userID){
	ajaxSubmit("/admin/member/queryUserWriteRecommend?userID="+userID,{},function(data){
		$("#userWriteRecommend").html(data);
	},"text");
}

/* 批量分配
 */
function batchAllot(){
	var size = $("._memTable input:checkbox[checked]").size();
	if(size == 0){
		layer.msg('请选择需要分配的会员!', 2, 5);
		return;
	}
	var mnames = "";
	var mids = "";
	$("._memTable input:checkbox[checked]").each(function(index){
		if(index != 0){
			mnames += "、";
			mids += "&";
		}
		mnames += $(this).attr("mname");
		mids += ("mems=" + $(this).val());
	});
	popAllot(mids,mnames);
}

/* 启用事件
 * member		会员ID
 * username		会员名
 */
function using(member,username){
	var html = '<p style="text-align:center;">确定启用帐号：<font color="#ff3300"><strong>' + username +'</strong></font><p>';
	//弹出对话框
	$.layer({
	    shade: [0.5, '#000'],
	    title: '启用帐号',
	    dialog: {
	        msg: html,
	        btns: 2,                    
	        type: 4,
	        btn: ['确认','取消'],
	        yes: function(){
	        	_qiyong();
	        }
	    }
	});
	//启用函数
	function _qiyong(){
		ajaxSubmit("admin/member/using", "mems="+member, function(msgBean){
			if(msgBean.code == zhigu.code.success){
				layer.msg(msgBean.msg, 1, f5);
			}else{
				layer.alert(msgBean.msg);
			}
		},"json");
	};
}

/* 批量启用
 */
function batchUsing(){
	var size = $("._memTable input:checkbox[checked]").size();
	if(size == 0){
		layer.msg("请选择需要启用的会员", 2, 5);
		return;
	}
	var mids = "";
	$("._memTable input:checkbox[checked]").each(function(index){
		if(index != 0){
			mids += "&";
		}
		mids += ("mems=" + $(this).val());
	});
	//启用弹出框
	$.layer({
	    shade: [0.5, '#000'],
	    title: '批量启用',
	    dialog: {
	        msg: '确定启用已选择的会员帐号！',
	        btns: 2,                    
	        type: 4,
	        btn: ['确认','取消'],
	        yes: function(){
	        	_qiyong();
	        }
	    }
	});
	//启用
	function _qiyong()
	{
		ajaxSubmit("admin/member/using", mids, function(data){
			if(msgBean.code == zhigu.code.success){
				layer.msg(msgBean.msg, 1, f5);
			}else{
				layer.alert(msgBean.msg);
			}
		},"json");
	}
}

/* 实名认证
 * userID	会员ID
 */
function realUserAuthInfo(userID){
	ajaxSubmit("admin/auth/realUser/inner_info",{'userID':userID},function(data){
		$("#authInfoDiv").html(data);
		$.layer({
		    type : 1,
		    title : '实名认证',
		    area : ['620px','auto'],
		    page : {dom : '#authInfoDiv'}
		});
	},"text");
}

/* 个人通过审核
 */
function realUserAuthPass(userID){
	ajaxSubmit("admin/auth/realUser/pass",{'userID':userID},function(msgBean){
		if(msgBean.code == zhigu.code.success){
			layer.msg(msgBean.msg, 1, f5);
		}else{
			layer.alert(msgBean.msg);
		}
	});
}

/* 实名认证未审核
 */
function realUserAuthFail(userID){
	var rejectReason = $("#rejectReason").val();
	if(rejectReason.length>0){
		ajaxSubmit("admin/auth/realUser/fail",{"userID":userID,"rejectReason":rejectReason},function(msgBean){
			if(msgBean.code == zhigu.code.success){
				layer.msg(msgBean.msg, 1, f5);
			}else{
				layer.alert(msgBean.msg);
			}
		});
	}else{
		layer.msg('请填写不能通过的原因。', 1, 3);
	}
}

/* 查看会员详细
 * member	会员ID
 */
function detail(member){
	$("#memberID").val(member);
	$("#memberDetailForm").submit();
}

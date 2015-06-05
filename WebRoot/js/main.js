// JavaScript Document
$(document).ready(function() {
	
	//收藏分享效果
	$("#floatShow").bind("mouseover", function() {
		$('#onlineService').animate({
			width : 'show',
			opacity : 'show'
		}, 'normal', function() {
			$('#onlineService').show();
		});
		$('#floatShow').attr('style', 'display:none');
		$('#floatHide').attr('style', 'display:block');
		return false;
	});

	$("#floatHide").bind("click", function() {
		$('#onlineService').animate({
			width : 'hide',
			opacity : 'hide'
		}, 'normal', function() {
			$('#onlineService').hide();
		});
		$('#floatShow').attr('style', 'display:block');
		$('#floatHide').attr('style', 'display:none');
	});

	$(document).bind("click", function(event) {
		if ($(event.target).isChildOf("#online_qq_layer") == false) {
			$('#onlineService').animate({
				width : 'hide',
				opacity : 'hide'
			}, 'normal', function() {
				$('#onlineService').hide();
			});
			$('#floatShow').attr('style', 'display:block');
			$('#floatHide').attr('style', 'display:none');
		}
	});

	$.fn.isChildAndSelfOf = function(b) {
		return (this.closest(b).length > 0);
	};
	$.fn.isChildOf = function(b) {
		return (this.parents(b).length > 0);
	};
	
	$(".fenxianddd").hover(function() {
		$(this).find(".span2fxnr").show();
	}, function() {
		$(".span2fxnr").hide();
	}
	);

	//分享
	$(".gaiullistulafr ul").each(function() {
		$(this).hover(function() {
			$(this).find(".ddtext").show();
		},

		function() {
			$(this).find(".ddtext").hide()
		})
	});
	$("#gaiullistulaid li").each(function(index) {
		$(this).click(function() {
			$(".selected").removeClass("selected");
			$(this).addClass("selected");

			$(".gaiullistulafr").hide();
			$("#gaiullistulafrid" + (index + 1)).show();

		});

	});

	$(".sbww").hover(function() {
		$(this).find(".dianpusousou").show();
	}, function() {
		$(this).find(".dianpusousou").hide();

	});

	$(".shuxin div").each(function(index, element) {
		$(".shuxin div").hover(function() {
			$(this).find(".shuximovernr").show();
		}, function() {
			$(this).find(".shuximovernr").hide();

		});

	});

	//JavaScript Document

	//切换已选择的商家类型的背景
	$(".modelInside").find("div").click(function(e) {
		$(".modelInside").find("div").removeClass("model_2").addClass("model_1");
		$(this).addClass("model_2");
	});

	$("#navul > li").not(".navhome").hover(function() {
		$(this).addClass("navmoon");
	}, function() {
		$(this).removeClass("navmoon");
	});

	//注册切换输入框的背景
	//页面重新渲染时清空输入框值
	$("#userRegInput").val("");
	$("#urpRegPassWord").val("");
	$("#urpRegPassWordre").val("");
	$("#urpYanZhengCode").val("");
	$("#urpRegMoble").val("");
	$("#userRegInput").focus(function() {
		$("#userRegInput").removeClass("userRegInput_1");
		$("#userRegInput").addClass("userRegInput_2");
	});
	$("#urpRegPassWord").focus(function() {
		$("#urpRegPassWord").removeClass("urpRegPassWord_1");
		$("#urpRegPassWord").addClass("urpRegPassWord_2");
	});
	$("#urpYanZhengCode").focus(function() {
		$("#urpYanZhengCode").removeClass("urpYanZhengCode_1");
		$("#urpYanZhengCode").addClass("urpYanZhengCode_2");
	});
	$("#reurpRegPassWord").focus(function() {
		$("#reurpRegPassWord").removeClass("urpRegPassWord_10");
		$("#reurpRegPassWord").addClass("urpRegPassWord_2");
	});
	$("#recommendPhone").focus(function() {
		$("#recommendPhone").removeClass("urpRegPassWord_11");
		$("#recommendPhone").addClass("urpRegPassWord_12");
	});


	//显示女鞋，男鞋下拉菜单
	$("#subUlLi").hover(function() {
		$(this).find(".subListLi").show();
	}, function() {
		$(this).find(".subListLi").hide();
	});
	//关闭商家店铺消息显示条
	$("#closeTZ").click(function() {
		$(this).parent(".tongZhi").hide()
	});
});
//显示分享按钮
function showFenXiangBox(tag) {
	$(tag).children("ul").show();
}
//隐藏分享按钮
function hideFenXiangBox(tag) {
	$(tag).find("fengXiangButtonDiv").hide();
}
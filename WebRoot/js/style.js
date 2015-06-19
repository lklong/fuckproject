/* 页面通用JS效果 */
/* 搜索项选择-start */
$(function(){
	$('.search-selector').hover(
	function(){
			$('#search-selector-list').show();
			$('#search-selector-list').find('li').click(
			function(){
					$('#search-selector-cur').html($(this).html());
					$('#search-selector-list').hide();
				});
		},
	function(){
			$('#search-selector-list').hide();
		});
	$('.search-input').on('blur',function(){
		var temp = $(this).val();
		temp = $.trim(temp);
		if(temp.length == 0 || temp == '输入商品名或货号')
		{
			$(this).removeClass('ts-high');
			$(this).val('输入商品名或货号');
		}
	});
	$('.search-input').on('click',function(){
		$(this).addClass('ts-high');
		var temp = $(this).val();
		temp = $.trim(temp);
		if(temp.length == 0 || temp == '输入商品名或货号')
		{
			$(this).val('');
		}
	});
	/* 搜索项选择-end */
	
/**************************定位开始********************************************/

	
	/* 城市选择 */
	initArea();
	function initArea(){
		
		// 初始值
		province = $("input[name='province']").val();
		city = $("input[name='city']").val();
		district = $("input[name='district']").val();
		
		var _geo = {
			province:province,
			city:city,
			district:district,
			provinceCode:"",
			cityCode:"",
			districtCode:"",
			changeAddr:false,
		};
		
		$.get("/ajax/addr",_geo,function(data){
			if(data.code === 1){
				var geo = data.data;
				var province = $.trim(geo.province);
				var city = $.trim(geo.city);
				
				var area = {
						province:province,
						city:city,
						district:"",
						provinceCode:"",
						cityCode:"",
						districtCode:"",
						changeAddr:false,
				}
				
				goCity(area);
			}
		});
	}
	
	// 位置选项卡事件
	$("ul.pos-tab li").live('click',function(){
		var len = $(this).index();
		$(this).addClass("curr").siblings().removeClass("curr");
		
		// 区域节点信息
		var $div_province = $("#JS-pos-province");
		var $div_city = $("#JS-pos-city");
		var $div_area = $("#JS-pos-area");
		
		// 切换
		switch (len) {
		case 0:
			$div_province.show().nextAll().hide();
			break;
		case 1:
			$div_province.hide();
			$div_city.show().nextAll().hide();
			break;
		case 2:
			$div_province.hide();
			$div_city.hide();
			$div_area.show().nextAll().hide();
			break;
		default:
			break;
		}
		
	});
	
	// 位置信息的hover事件
	$('.pos-select-list').hover(
			function(){
				// 追加新的数据
				var len = $("#JS-pos-head ul li").length;
				if(len === 0){
					$("ul.pos-content").empty();
					$("#JS-pos-head ul").append('<li class="curr">'+$("#JS-span-province").text()+'</li>');
					var lis = ajaxAppendAreaData("true",0);
					$("#JS-pos-province ul").append(lis).parent().show();
				}
				$("#JS-pos-div").show();
			},
			function(){
				$("#JS-pos-div").hide();
			}
	);
	// 省,市,区点击事件
	$("ul.pos-content li").live('click',function(){
		
		// 当前元素节点信息
		var $this = $(this);
		var $ul = $this.parent();
		var $ul_div = $ul.parent();
		var div_id = $ul_div.attr("id");
		$this.addClass("checked_area").siblings().removeClass("checked_area");
		
		// 参数信息
		var name = $this.text();
		var isparent = $this.data("isparent");
		var id = $this.data("id");
		
		// 区域节点信息
		var $div_province = $("#JS-pos-province");
		var $div_city = $("#JS-pos-city");
		var $div_area = $("#JS-pos-area");
		
		
		// 业务操作
		// 自己隐藏,后面节点数据清空
		$ul_div.hide().nextAll().children("ul").empty();
		// 获取新的数据
		var lis = ajaxAppendAreaData(isparent,id);
		
		// 选项卡节点长度
		var tab_len = $(".pos-tab li").length;
		switch(div_id)
		{
			case "JS-pos-province":
				if(tab_len === 1){
					$("#JS-pos-head ul li").eq(0).text(name).removeClass("curr");
					$("#JS-pos-head ul").append('<li class="curr">请选择</li>');
				}else{
					$("#JS-pos-head ul li").eq(0).text(name).next().text("请选择").addClass("curr").siblings().removeClass("curr");
					if(tab_len===3){
						$("#JS-pos-head ul li").eq(-1).remove();
					}
				}
				$div_city.show().children("ul").append(lis);
				break;
			case "JS-pos-city":
				if(tab_len === 2){
					$("#JS-pos-head ul li").eq(1).text(name).removeClass("curr").after('<li class="curr">请选择</li>');
				}else{
					$("#JS-pos-head ul li").eq(1).text(name).next().text("请选择").addClass("curr").siblings().removeClass("curr");
				}
				$div_area.show().children("ul").append(lis);
				break;
			case "JS-pos-area":
				$("#JS-pos-head ul li").eq(2).text(name).addClass("curr").siblings().removeClass("curr");
				$ul_div.show();
				$("#JS-pos-div").hide();
				
				// 地区参数组装
			    var li = $(".checked_area");
				var $tab_li = $(".pos-tab li");
				
				var	province=$tab_li.eq(0).text();
				var city = $tab_li.eq(1).text();
				var	district=$tab_li.eq(2).text();
				var	provinceCode=$(".checked_area").eq(0).data("id");
				var	cityCode=$(".checked_area").eq(1).data("id");
				var	districtCode=$(".checked_area").eq(2).data("id");
				
				var area = {
						province:province,
						city:city,
						district:district,
						provinceCode:provinceCode,
						cityCode:cityCode,
						districtCode:districtCode,
						changeAddr:true,	
				}
				
				goCity(area);
				break;
			default:
				break;
		}
		
	});
	
	// 区域form表单处理
	function areaForm(area){
		
		$("input[name='province']").val(area.province);
		$("input[name='city']").val(area.city);
		$("input[name='district']").val(area.district);
		$("input[name='provinceCode']").val(area.provinceCode);
		$("input[name='cityCode']").val(area.cityCode);
		$("input[name='districtCode']").val(area.districtCode);
		
		url = location.href;
		
		$("#area_form").attr("action",url).submit();
	}
	
	
	// 去选中的城市
	function goCity(area){
		
			// 声明默认地址信息
			var _area = {
					province:"四川省",
					city:"成都市",
					district:"金牛区",
					provinceCode:"510000",
					cityCode:"510100",
					districtCode:"510106",
					changeAddr:true,
			}
			
			if($.trim(area.city).indexOf("成都")==-1){
				
				$("#JS-span-province").text(area.province);
				$("#JS-span-city").text(area.city);
				if(area.district){
					$("#JS-span-area").text(area.district);
				}
				
/*				layer.msg('该地区火热正在招商中，敬请关注....', {
				    icon: -1,
				    time: 4000, 
				    shade: [0.2],
				    shadeClose: true
				},function(){
					$("#JS-span-province").text(_area.province);
					$("#JS-span-city").text(_area.city);
					$("#JS-span-area").text(_area.district);
					areaForm(_area);
				});*/
				
				layer.open({
					title:'提示',
					shade : [0.3 , '#000'],
				    area : ['auto','auto'],
				    content : '该地区正在火热招商中，敬请关注....',
				    btn : ['到成都总站'], 
				    yes : function(index){
				    	$("#JS-span-province").text(_area.province);
						$("#JS-span-city").text(_area.city);
						$("#JS-span-area").text(_area.district);
						areaForm(_area);
				    },
				    closeBtn: false
				});
			}else{
				$("#JS-span-province").text(area.province);
				$("#JS-span-city").text(area.city);
				if(area.district){
					$("#JS-span-area").text(area.district);
				}
				if(area.changeAddr){
					areaForm(area);
				}
			}
	}
	
	
	/**
	 *  追加新的地区数据
	 */
	function ajaxAppendAreaData(isParent,id){
		$.ajaxSetup({
	        async: false,
	    });
		var lis = ""
		if($.trim(isParent) === "true"){
			$.post("/ajax/area/"+id,function(data){
				for(var i=0;i<data.length;i++){
					var n = data[i];
					lis += "<li data-id="+n.id+" data-isparent="+n.isParent+">"+n.name+"</li>";		
				};
			});
		}
		return lis;
	}
/**************************定位结束********************************************/	
	
	/* 下拉导航 */
	$('#menu_ul').find('li').hover(
		function(){
			$(this).find('div').show();
		},
		function(){
			$(this).find('div').hide();
	});
	
	/* 显示侧边栏 */
	slideBar();
	
	/* 回到顶部 */
	$("#goto-top").click(function() {
		$('body,html').animate({
			scrollTop : 0
		}, 500);
		return false;
	});
	
	/* 窗口改变时设定边栏高度 */
	$(window).resize(function(){slideBar();});
});

/* 侧边栏 包括购物车，收藏，个人中心等 */
function slideBar(){
	var w_h = $(window).height();    //获取当前窗口高度
	var w_w = $(window).width();     //获取当前窗口宽度
	if($('#slide-bar').length>0){    //如果slide-bar存在
		$('#slide-bar').css({'height':w_h});
		$('#slide-bar').show();
		$('#slide-bar').animate({right:0});
		$('#slide-bar').find('li').hover(
				function(){
					$(this).find('.kefu-qq').hide().fadeIn('fast');
					$(this).find('span').hide().fadeIn('fast');
				},
				function(){
					$(this).find('.kefu-qq').hide().fadeOut('fast');
					$(this).find('span').hide().fadeOut('fast');
				});
	}
}
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
	/* 城市选择 */
	$('.pos-select-list').hover(
		function(){
			$(this).find('ul').show();
			$(this).find('li').click(
			function(){
					$('#pos-span').html($(this).html());
					$('#pos-ul').hide();
				});
		},
		function(){
			$(this).find('ul').hide();
	});
	
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
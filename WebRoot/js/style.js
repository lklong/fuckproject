/* 页面通用JS效果 */
/* 搜索项选择-start */
$(function(){
	$('.search-selector').hover(
	function(){
			$('#search-selector-list').show();
			$(this).find('li').click(
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
			$(this).find('div').fadeIn('fast');
		},
		function(){
			$(this).find('div').fadeOut('fast');
	});	
});
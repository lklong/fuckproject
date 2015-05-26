function nipicIndexSearch (){
	
	$("#searchsort").show().stop(true,false).animate({"width" : "66px"},200);
	$(".searchsortlist").hide();
	
	$("#keyword").focus(function(){
		$(this).css("outline","none");
		$("#searchsort").show().stop(true,false).animate({"width" : "66px"},200);
		$(".searchsortlist").hide();
	}).bind("focusout blur mouseout",function(){
		$(".searchsortlist").hide();
		$(".selectedsort").show();
	});


	$("#searchsort").hover(function(){
		$(this).css("overflow","visible");
		 var offsetTop =  $(this).offset({"top":"59","right":"0"}).top;
		 // 设置到下拉框中
		  $(".searchsortlist").offset(offsetTop).show();

	},function(){
		$(this).css("overflow","hidden");
		$(".searchsortlist").hide();	
	});

	$(".searchItem").hover(function(){
		$(this).css({"background-color":"#bb1a02","color":"#fff"}).siblings().css({"background-color":"#fff","color":"#333"})
	});

}
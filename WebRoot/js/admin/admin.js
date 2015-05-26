// JavaScript Document
$(function(){
	 
	$("#sujuid li").each(function() {
		$( this).click(function(){
			$( ".secltedtj").removeClass("secltedtj")
			$(this).addClass("secltedtj");
			$("#sujuid li").find("img").attr("src","images/heisgx.jpg")
			$(this).find("img").attr("src","images/baisgx.jpg");
           }
		);
        
    });
	
	$(".fenpeikk").each(function(index){
		$(this).addClass("fenpeikk"+index);
		});
	$(".fenpeibut").each(function(index){
		$(this).click(function(){
			$(".fenpeikk").hide();
			$(".fenpeikk"+index).show()
			
			});
		
		});
});



$(function(){
	getAdColumn();
	//用户中心tab切换方法
	$("#userCommTab ul").delegate("li a","click",function() {
		$("#userCommTab a").removeClass("uctSelected");
		$(this).addClass("uctSelected");
		// 加载数据
		adColumnId = $(this).attr("adColumnId");
		$(".userCommContentBox").addClass("disnone");
		$("#userCommContentBox"+adColumnId).removeClass("disnone");
		getPageDatas(1);
	});		
})
function getAdColumn(){
        $.getJSON("Admanage/user/seeAdColumn",function(data){
        	 var html="";
        	 var html1=""
        	for(var i=0;i<data.adColumn.length;i++){
        	  if(i==0){
        			html+="<li ><a href=\"javascript:void(0);\" class=\"uctSelected\" adColumnId="+data.adColumn[i].adcolumnid+">"+data.adColumn[i].adcolumnname+"</a></li>"
        	  }
        	  else{
        			html+="<li ><a href=\"javascript:void(0);\" class=\"\"   adColumnId="+data.adColumn[i].adcolumnid+">"+data.adColumn[i].adcolumnname+"</a></li>"
        	  }
                html1+="<div class=\"userCommContentBox disnone\" id=\"userCommContentBox"+data.adColumn[i].adcolumnid+"\">"
                    +"<div class=\"uccb_intro\">"
                    +" <p><strong>位置说明</strong>：<font color='#ff4400'><strong>"+data.adColumn[i].adcolumnname+"</strong></font>导航下，依次往下排，价格不一</p>"
                    +" <p><strong>推广效果</strong>：<img src='img/star2.png' /><img src='img/star2.png' /><img src='img/star2.png' /><img src='img/star2.png' /><img src='img/star2.png' /></p>"
                    +" <p class='disnone'><strong>订购价格</strong>：<font color='#ff4400'><strong>200</strong></font>元/7天</p>"
                    +"<p><strong>订购须知</strong>：对智谷同城货源网的所有会员，先到先得。</p></div><div class='uccb_content'>"
                    +" <table cellpadding=\"0\" cellspacing=\"0\">"
                    +"  <thead><tr><th>时间</th><th>单价（元/天）</th><th>价格</th><th>订购天数</th><th>订购操作</th><th>预览</th></tr></thead><tbody></tbody></table></div>"
                    +"  <div class=\"pager\" id=\"paginationContainer"+data.adColumn[i].adcolumnid+"\"></div></div>"

        	}
        	$("#userCommTab ul").html(html);
        	$("#userContents").html(html1)
    	
    		$("#userCommTab").find("a")[0].click();
        })
}
var adColumnId;
function getPageDatas(pageNo){
	var url="Admanage/user/index";
	var val={
			pageNo:pageNo,
			adColumnId:adColumnId
	}
	$.post(url,val,function(pageBean){
		var html=""
		for(var i=0;i<pageBean.datas.length;i++){
		
			var data = pageBean.datas[i];
			if(data.price!=0 ){
			html+="<tr>"   
				
                        +"<td>"+new Date(data.startDate).format('yyyy-MM-dd')+"  至  "+new Date(data.endDate).format('yyyy-MM-dd')+"</td>"
                        +"<td>"+data.price+"</td>"
                       if(data.startDate>new Date()){
                    	  html+="<td><font color=\"#ff4400\"><strong>"+(data.price*(Math.ceil((data.endDate-data.startDate)/1000/60/60/24+1)))+"</strong></font></td>"
                    	  +"<td>"+ Math.ceil((data.endDate-data.startDate)/1000/60/60/24+1)+"</td>"
                       }else{
                    	   html+="<td><font color=\"#ff4400\"><strong>"+(data.price*((Math.ceil((data.endDate-new Date())/1000/60/60/24+1))))+"</strong></font></td>"
                    	   +"<td>"+ Math.ceil((data.endDate-new Date())/1000/60/60/24+1)+"</td>"
                       }
		/*	if(data.status==1){
				html+="<td><button id='addinfo'  style=\"margin-left: -12px;color:gray; width: 80px; height: 29px\" >已订购</button></td>"
			}else{
				html+="<td><a id='addinfo' onclick='addInfo("+data.id+")' href='javascript:void(0);'   class=\"btnStyle_1\">订购</a></td>"
			}*/
			html+="<td><a id='addinfo'  href=\"supplier/ad/uploadAdInfo?adid="+data.id+"\"   class=\"btnStyle_1\">订购</a></td>"
				    +"<td><a onclick='shouImg()' id='seeimg' href='javascript:void(0);'>位置预览</a></td>"
			       +"<td><div id='"+data.id+"' style='display: none;'><img id='img'  src="+data.showPositionImg+"></td></div>"
				    +"</tr>asdasd"	  
		}
		}
		$("table tbody").html(html);
		zhigu.cmn.setPage(pageBean,getPageDatas,'paginationContainer'+adColumnId);
	   
	});
};
function shouImg(){
	   var src=$("#img").attr("src");
		  parent.$.layer({
				type : 2,
				title : false,
				fadeIn: 300,
				iframe : {
					src : src
		},
		area : [ "90%", "90%" ],
		success : function() {
		}
	});  	
}

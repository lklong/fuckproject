<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>企业认证</title>
<script src="js/jquery.min.js" type="text/javascript"></script>
<script src="js/main.js" type="text/javascript"></script>
<script type="text/javascript" src="js/pca.js"></script>
<style type="text/css">
.file-box {
	overflow:hidden;
	position:relative;
	height: 30px;
	width:120px;
	background:#FF0080;
	left:180px;
	text-align: center;
}

.file-box input {
cursor:pointer;
z-index:100;
margin-top:-15px;
margin-right:-25px;
opacity:0;
filter:alpha(opacity=0);
font-size:100px;
position:absolute;
top:0;
right:0;
}
</style>
<script type="text/javascript">

$(function(){

})
</script>


</head>
<body>
<div class="rightContainer" id="${status}">
    	<!--// 标题 //-->
        <h3 class="rc_title">广告信息上传<a href="user/home">我的主页</a></h3>
        <!--// 内容框 //-->
		<div class="rc_body">
        	<!--// tab切换条 //-->
            <div id="userCommTab" class="userCommTab">
            	<ul>
                	<li><a href="javascript:void(0);" class="uctSelected">广告信息上传</a></li>
                </ul>
            </div>
            
            <div id="userContents" class="userContents">
            	<!--// 内容1 //-->
            	<div class="userCommContentBox">
            	<h2 id="reminder" style="margin-left: 20px"> <span id="spMsg" style="color: #FF3333">${msg}</span></h2>
            	<br>
            	<h3 id="reminder" style="margin-left: 20px">带   <span style="color: #FF3333">*</span>   号的为必填项</h3>
		<ul class=" mt30 ml30 c666 f14 dpallzl">
		<li><input id="id" name="id" value="${adid}" type="hidden"/></li>
		<li><input id="adId" name="adId" value="${adorder.adId}" type="hidden"/></li>
		    <li> <span class="fl w120 tr"><span style="color: #FF3333">*</span>&nbsp;发布人姓名:</span><input class="dpname fl" name="contactName" id="contactName" value=""/><span class="red" style="margin-left: 5px;"></span></li>
		    <li><span class="fl w120 tr"><span style="color: #FF3333">*</span>&nbsp;联系方式:</span><input class="dpname fl" name="contactPhone" id="contactPhone" value=""/><span class="red" style="margin-left: 5px;"></span></li>
			<li><span class="fl w120 tr"><span style="color: #FF3333">*</span>&nbsp;广告标题:</span><input class="dpname fl" name="adTitle" id="adTitle" value=""/><span class="red" style="margin-left: 5px;"></span></li>
		    <li><span class="fl w120 tr"><span style="color: #FF3333">*</span>&nbsp;广告路径:</span><input class="dpname fl" name="adLink" id="adLink" value=""/><span class="red" style="margin-left: 5px;"></span></li>
			<li><span class="fl w120 tr">广告备注:</span><textarea rows="10" cols="90" style="margin-left: 10px;" name="comment" id="comment">${adorder.comment}</textarea><span class="red"></span>
			<div class="add_pic clearfix" style="margin-top: 130px">
									<span class="fl" id="contentCue" style="display: none;color: red;">内容不能空</span>
									<span class="text_xz" id="outNumSpan" style="display: none;">超出<em
										class="" id="outNum">400</em>字</span>
									<span class="text_xz" id="keyNumSpan">还能输入<em class=""
										id="keyNum">400</em>字</span>
								</div></li>
			<li><span class="fl w120 tr">*</span><p class="red"> 扫描件或数码件，图片必须清晰。格式：jpg、gif、bmp、png</p></li>
			<li><span class="fl w120 tr"><span style="color: #FF3333">*</span>&nbsp;广告图片:<br/><br/></span>&nbsp;<img id="adimg1" width="160px" height="160px" src=""/><span class="red" style="margin-left: 5px;"></span></li>
		</ul>
		<input type="hidden"  name="adImg" id="adImg" value=""/><span></span>
		<form enctype="multipart/form-data" action="/Admanage/FileUpload/uploadImageFile" method="post" id="uploadImageFileForm"  target="imgUpload_hidden_frame">
				<div  class="file-box" style="height: 20px;">上传广告图片 <input type="file"  name="preImageFile"  id="preImageFile" onchange="uploadImageFileForm.submit();" /></div>
			<input name="callBackFun"  id="callBackFun" type="hidden" value="callbackImagePre"/>
		</form>
               	<div style="left:30px;position:relative;left:180px;top:10px;">
              <div id="submit1" value="${message}">
	                <ul>
                    <li class="baochun"  style="background-color: #A0A3A8;display: none;">已提交，待审查</li>
                    <li class="baochun"  style="background-color: #A0A3A8;display: none;">审查通过,已付款</li>
                     <li class="baochun"  style="background-color: #A0A3A8;display: none;">未通过</li>
                     <li class="baochun"  style="background-color: #A0A3A8;display: none;">订单错误</li>
                         <li class="baochun"  style="background-color: #A0A3A8;display: none;">审查通过,未付款</li>
					 <li class="baochun" id="sumbit">提交</li>
				
				</ul>
					
			<div style="margin-top: 30px;margin-left: 750px">
				<a href="javascript:history.back(-1)" >返回上一页</a></div>
</div>
	</div>
 </div>
    </div>
   </div>
        <br style="clear:both;" />
        </div>
<div class="clear"></div>
	<iframe name="imgUpload_hidden_frame" id="imgUpload_hidden_frame" style="display: none"></iframe>
<script type="text/javascript">
    $(function(){
    	$("#contactPhone").blur(function(){
    		var phone=$("#contactPhone").val();
    		var reg=/^(\d{11})|^((\d{7,8})|(\d{4}|\d{3})-(\d{7,8})|(\d{4}|\d{3})-(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1})|(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1}))$/
    		if(phone.length==0){
    			$("#contactPhone").next().html("请输入联系方式");	
    		}
    		else{
    		if(!reg.test(phone)){
    			$("#contactPhone").next().html("请输入正确的电话号码");	
    		}else{
    			$("#contactPhone").next().html("");	
    		}}
    	})
    	$("#contactName").blur(function(){
    		var phone=$("#contactName").val();
    		var reg=/^(?![0-9_])(?!.*_$)[a-zA-Z0-9_\u4e00-\u9fa5]{2,19}$/
    		if(phone.length==0){
    			$("#contactName").next().html("请填写姓名");	
    		}
    		else{
    			if(!reg.test(phone)){
    				$("#contactName").next().html("填写正确的姓名");	
    			}else{
    			$("#contactName").next().html("");	}
    		}
    	})
    	$("#comment").keyup(function() {
    		var num = $(this).val().length;
    		var sum = 400;
    		$("#comment").next().html("")
    		if (num > 400) {
    			$("#keyNumSpan").hide();
    			$("#outNum").text(num - sum);
    			$("#outNum").css("color", "red");
    			$("#outNumSpan").show();
    			return;
    		} else {
    			$("#keyNum").text(sum - num);
    			$("#outNumSpan").hide();
    			$("#keyNumSpan").show();
    		}
    	});
        function checkTitle(){
	    	   $("#adTitle").blur(function(){
	    		   var title=$("#adTitle").val();
	    		   if(title.length<=0){
	    			   $("#adTitle").next().html("请填写广告标题")
	    		   }
	    		   else if(title.length>100){    		
	       			$("#adTitle").next().html("标题字数不能超过100")
	       		}else{
	       			$("#adTitle").next().html("")
	       		}   
	    	   }) ;
	    	}
	       function checkurl(){
	    	   $("#adLink").blur(function(){
	    		   var url=$("#adLink").val()
	    		   if(url.length<=0){
	    			   $("#adLink").next().html("请填写广告路径")
	    		   }
	    		   else if(url.length>200){
	       			$("#adLink").next().html("路径长度不能超过200个")
	       		}else{
	       			$("#adLink").next().html("")
	       		}          
	    	   })
	    	}
	       checkTitle();
	       checkurl()
    })
    
    
    
	$(function(){
		if($("#id").val()==""||$("#id").val()==null){
			$("#id").attr("value",0);
		}
			$("#sumbit").click(function(){
				var val={
						adImg:$("#adImg").val(),
						adTitle:$("#adTitle").val(),
						adLink:$("#adLink").val(),
						//adId:$("#adId").val(),
						comment:$("#comment").val(),
						adId:$("#id").val(),
		        		contactName:$("#contactName").val(),
		        		contactPhone:$("#contactPhone").val()
		        		}	        		
			  $.post("Admanage/user/saveAdInfo",val,function(msgBean){
				  $("input").next().html("");
				  
				  if(msgBean.code ==zhigu.code.success){
						 window.location.href="supplier/ad/adpay?id="+msgBean.data;
			 			 }
				    else{
				    	dialog(msgBean.msg);
					 } 
	          })
			})
			
		if($(".rightContainer").attr("id")=="see"){
			$("input").attr("disabled",true);
			$("textarea").attr("disabled",true);
			$(".add_pic.clearfix").hide();
			$.post("Admanage/user/paysuccess?id=${id}",function(data){
				$("#submit1 ul li").hide();
				if(data.adorder==null){
	        	
	        	dialog("不存在的订单或已被删除");
	        	$("#submit1 ul li:eq(3)").show();
	        	return;
	        }
				$("#adTitle").val(data.adorder.adTitle);
				$("#adLink").val(data.adorder.adLink);
				$("#comment").val(data.adorder.comment);
				$("#adimg1").attr("src",data.adorder.adImg)
			    $("#contactName").val(data.adorder.contactName);
				$("#contactPhone").val(data.adorder.contactPhone);
				if(data.adorder.auditStatus==0){
					$("#submit1 ul li:eq(0)").show();
				}
				if(data.adorder.auditStatus==1&&data.adorder.paymentStatus==1){
					$("#submit1 ul li:eq(1)").show();
				}
				if(data.adorder.auditStatus==2){
					$("#submit1 ul li:eq(2)").show();
					$("#reminder").append("<h2 style='color: #FF3333'>审核失败："+data.adorder.returnMsg+"</h2>")
				}if(data.adorder.auditStatus==1&&data.adorder.paymentStatus==0){
					$("#submit1 ul li:eq(4)").show();
				}
	          })
		}
		
		
		// 图片上传预览
		$("#uploadBusinessImage").click(function(){
			$("#preImageFile").click();
			$("#callBackFun").val("callbackImagePre");
		});	
		
		//点击订购  显示给用户的信息
		$.post("Admanage/user/addInfo?id=${adid}",function(msgBean){
			  $("#spMsg").html(msgBean.msg);	
			  })
		})
	function callbackImagePre(json){
		$("#adimg1").attr("src",json.url);
		$("#adImg").val(json.url);

	}

</script>
</body>
</html>

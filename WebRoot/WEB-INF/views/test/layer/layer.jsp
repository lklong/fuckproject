<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	$(function(){
	/* 	$.layer({
		    type : 3,
		    time : 200s,
		    close:function(index){
		    	  var index = LAYER.getIndex(this);
		    	  LAYER.close(index);
		    }
		});
		
		$("#layer_btn").click(function(){
			  var index = LAYER.getIndex(this);
	    	  LAYER.close(index);
		}); */
	/* 	$.layer({
		    type : 1,
		    title : ['',false],
		    closeBtn : ['',false],
		    border : ['','','',false],
		    area : ['455px','371px'],
		    page : {dom : '#layer_btn'}
		});
		
		$('#layer_btn').live('click',function(){
		    var index = LAYER.getIndex(this); 
		    LAYER.close(index);
		}); */
		/* 
		$.layer({
		    type : 3,
		    time : 2,
		    shade : ['','','',false],
		    border : [0,'','','',false],
		    loading : {type : 3}
		});    */
	layer({
		    type : 1,
		    title : ['',false],
		    offset:['150px' , ''],
		    border : ['','','',false],
		    area : ['503px','395px'],
		    success : function(layer){
		    	alert(235);
		    }
		});
		/* $('#taobao').on('click',function(){
		    var index = LAYER.getIndex(this); 
		    LAYER.close(index);
		}); */
	})
</script>
</head>
<body>
	<input type="button" value="layer" id="taobao"/>
</body>
</html>
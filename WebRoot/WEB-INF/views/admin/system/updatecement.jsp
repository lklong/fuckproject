<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>资讯列表</title>
     <script src="js/admin/admin.js" type="text/javascript"></script>
    <script src="js/jquery.min.js" type="text/javascript"></script>
       <script charset="utf-8" src="js/3rdparty/kindeditor/kindeditor.js"></script>
<script charset="utf-8" src="js/3rdparty/kindeditor/lang/zh_CN.js"></script>
    <script src="js/global.js" type="text/javascript"></script>
</head>
<body>
<!-- //功能条// -->
<div class="sysContBar">
	<form action="admin/goods/index" id="searh_form" method="post">
	<div class="sysCBBox">
		<div></div>
	</div>
	
	</form>
</div>

<div id="adminUserDlg"  modal="true" closed="true" class=""   >
 <div class="contentbox">
 <!-- <div style="margin-left: 198px; width: 100%; float: left;">
  <form enctype="multipart/form-data" action="/admin/system/uploadImageFile" method="post" id="uploadImageFileForm"  target="imgUpload_hidden_frame">	
				<a class=btn_addPic style="text-decoration:none;margin-left: 6px;">
				<SPAN><EM>+</EM>图片上传</SPAN>
				<input class="filePrew" type="file"  name="preImageFile"  id="preImageFile" onchange="uploadImageFileForm.submit();" />
				<input name="callBackFun"  id="callBackFun" type="hidden" value="callbackImagePre"/></a>
		     	 </form>
 </div> -->
 <%-- <br/> <br/> <br/>
  <div style="float: left;">
  <c:if test="${cementContent.cementimg==null }">
    <img style="margin-left: 204px;" id="adimg1" width="300px" height="155px" src="img/002.png"/>   
  </c:if>
     <c:if test="${cementContent.cementimg!=null }">
    <img style="margin-left: 204px;" id="adimg1" width="300px" height="155px" src="${cementContent.cementimg}"/>   
  </c:if>   	
  </div>    --%>     
  <form method="post"  id="sellFrom" name="sellFrom" role="form">
    <input type="hidden"  name="cementImg" id="cementimg" value=""/>
    <input type="hidden"  name="id" id="id" value="${cementContent.id }"/>
	   <table    style="width:100%; line-height: 10px; text-align: 5px;">
           <tr >
               <td  width="200px;">标题:</td>
               <td><input type="text" id="title" name="title" value="${cementContent.title }" style="width: 300px; height: 30px;"/>
               </td>
               
           </tr>
           <tr >
               <td  width="200px;">排序:</td>
               <td><input type="text" id="sort"  name="sort" value="${cementContent.sort}" style="width: 300px; height: 30px;"/>
               </td>
               
           </tr>
           <tr>
               <td>内容:</td>
               <td>
                 <div class="jibenform">
		 		<div class="title" style="clear:both;height:30px;">
			 	</div>
			 	<div class="tupianright fl" style="border:none;">
			 		<jsp:include page="../../ueditor/index.jsp">
			 			<jsp:param name="desc" value="${cementContent.content}" />
			 		</jsp:include>
			 	</div>
				 </div>
				 <div class="clear"></div>
               </td>
           </tr>
          
           <tr>
               <td>栏目:</td>
               <td>
                   <select id="cementid" name="cementId" style="width: 200px; height: 30px;">
                   	<option value="0">请选择</option>
                   	<c:forEach items="${cements }" var="item">
                   		<option value="${item.id }"  ${item.id==cementContent.cementId ?"selected='selected'" :"" } >${item.name }</option>	 
                   	</c:forEach>
                   </select>
               </td>
           </tr>
             
	 </table>
	 </form>     
	 <div style="margin-left: 198px;">
	 	<br />
		 <a class="sysButonA4" href="javascript:void(0);" onclick="update();"><em></em>保存信息</a>
		 <a class="sysButonA4" href="javascript:void(0);" onclick="backwardList();"><em></em>返回</a>
	</div>
</div>

	</div>
	<script type="text/javascript">
	function callbackImagePre(json){	
		$("#adimg1").attr("src","/"+json.url);
		var showadimg=	$("#cementimg").val(json.url);
	}
    $("#uploadBusinessImage").click(function(){
		$("#preImageFile").click();
		$("#callBackFun").val("callbackImagePre");
	});	 
	
      function  update(){
    	  var title=$("#title").val();
    	  if(title=="" && title.length==0){
    		  alert("标题不能为空11！");
    		  return;
    	  }
    	  
    	  var content =  UE.getEditor('editor').getPlainTxt();
    	  var reg = /\s/g;
    	  _content = content.replace(reg,'');
		  if(_content=="" && _content.length==0){
				 alert("请输入文章内容，不能空!");
				 return;
			 }

			 var cementid=$("#cementid").val();
			 if(cementid==0){
				 alert("请选择文章所属栏目!");
				 return;
			 }
    	  var sellForm = $("#sellFrom").serialize();
    	 sellForm.content = content;
          $.post("/admin/system/coment/addAndUpdate",sellForm,function(msgBean){
		 		if(msgBean.code ==zhigu.code.success){
		 			layer.msg(msgBean.msg,2,backwardList);
		 		}else{
		 			layer.alert(msgBean.msg);
				 }
		   }); 
          } 
       function backwardList(){
    	   window.location ="/admin/system/CementContentsList";
       }
</script>
<iframe name="imgUpload_hidden_frame" id="imgUpload_hidden_frame" style="display: none"></iframe>
</body>

</html>

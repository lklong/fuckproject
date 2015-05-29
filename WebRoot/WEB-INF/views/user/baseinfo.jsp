<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>基本信息</title>
<link rel="stylesheet" type="text/css" href="js/validate/validate.css" />
<script type="text/javascript" src="js/pca.js"></script>
<script type="text/javascript" src="js/3rdparty/layer/layer.min.js"></script>
<script type="text/javascript" src="js/validate/jquery.validate.js"></script>
<script type="text/javascript" src="js/validate/message_cn.js"></script>
<script type="text/javascript" src="js/validate/additional-methods.js"></script>
</head>
<body>
<div class="rightContainer fr">
  <h4 class="ddtitle">基本资料</h4>
  <!--// 内容框 //-->
  <div class="rc_body">
    <div id="userContents" class="userContents">
      <div class="user-photo fl">
        <div><img src="${info.avatar}" id="avatarpic" style="width: 120px;height: 120px;"/></div>
        <p><a href="javascript:void(0)" onclick="avatar()" class="edit-user-photo">编辑头像</a></p>
      </div>
      <div class="user-info fr">
        <div class="msg-alert"><span class="gantanhao"></span>用户名可用于登录同城货源网，只能修改一次。 </div>
        <div>
          <form action="user/info/modify" id="infoForm" method="post">
            <table cellpadding="0" cellspacing="0" class="user-form-table">
              <tr>
                <td>用户名：</td>
                <td><c:choose>
                    <c:when test="${info.usernameModify == 0}">
                      <input type="text" name="username" value="${auth.username }" maxlength="25" class="input-txt"/>
                    </c:when>
                    <c:otherwise> ${auth.username } </c:otherwise>
                  </c:choose></td>
              </tr>
              <tr>
                <td>性别：</td>
                <td><input id="nan" checked="checked" type="radio" name="gender" value="1"/>
                  <label for="nan">男</label>
                  <input id="nv" <c:if test="${info.gender == 2 }">checked="checked"</c:if> type="radio" name="gender" value="2"/>
                  <label for="nv">女</label></td>
              </tr>
              <tr>
                <td>所在地区：</td>
                <td><select name="province" id="province" class="select-txt">
                  </select>
                  <select name="city" id="city" class="select-txt">
                  </select>
                  <select name="district" id="district" class="select-txt">
                  </select></td>
              </tr>
              <tr>
                <td>街道：</td>
                <td><input name="street" id="street" maxlength="200" value="${info.street }" class="input-txt"/></td>
              </tr>
              <tr>
                <td>邮编：</td>
                <td><input type="text" name="postCode" value="${info.postCode }" class="input-txt"/></td>
              </tr>
              <tr>
                <td>固定电话：</td>
                <td><input type="text" id="tel" name="tel" value="${info.tel }" placeholder="格式：区号-座机号"  class="input-txt"/></td>
              </tr>
              <tr>
                <td>QQ号码：</td>
                <td><input type="text" name="QQ" value="${info.QQ }"  class="input-txt"/></td>
              </tr>
              <tr>
                <td>阿里旺旺：</td>
                <td><input type="text" name="aliWangWang" value="${info.aliWangWang }" class="input-txt"/></td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><input class="input-button" type="button" value="保存" id="saveBaseInfo"/></td>
              </tr>
            </table>
          </form>
        </div>
      </div>
    </div>
    <br style="clear:both;" />
  </div>
</div>
<div id="avatarDiv" style="display: none;">
  <iframe src="js/3rdparty/avatar/header.jsp" id="headFram" style="border: 1px;" scrolling="no" width="650" height="450"></iframe>
</div>
<script type="text/javascript">
		$().ready(function() {
			//初始化
			var pca = new PCAS("province", "city", "district","${info.province}","${info.city}","${info.district}");
			$("#infoForm").validate({
				rules:{
					district:{required:function(){
						return !isEmpty($("#street").val());
					}},
					street:{maxlength:255},
					postCode:{postCode:true},
					tel:{tel:true},
					QQ:{number:true,maxlength:11},
					aliWangWang:{maxlength:32}
					
				},
				submitHandler:function(form){
					ajaxSubmit($(form).attr("action"), $(form).serialize(), function(data){
						layer.alert(data.msg);
					},"json");
				}
			});
			$("#saveBaseInfo").click(function(){
				ajaxSubmit("/user/info/modify",$("#infoForm").serialize(),function(data){
					$.layer({
					    shade: [0],
					    area: ['auto','auto'],
					    dialog: {
					    	msg: data.msg,
					    	btns: 1,
					    	type: 0,
					    	btn: ['确定'],
					    	yes: function(){
					    		f5();
					        }
					    }
					});
				});
			});
		});
		//头像
		var avatarDialogId;
		function avatar(){
			//zhigu.dialog($("#avatarDiv").html(), null, 700, 530, "头像上传",false);
			//alertDialog($("#avatarDiv").html(),null,null,700,580,'头像上传');
			avatarDialogId = $.layer({
				   type: 1,   //0-4的选择,
				    title: "上传头像",
				    closeBtn: [0, true],
				    area: ['650px', '490px'],
				    page: {
				        html:$("#avatarDiv").html()
				    }
				});
		}
		//重置头像
		function reAvatar(url){
			$("#avatarpic").attr("src","" + url + "?r=" + Math.random());
			setTimeout(function () { 
				layer.close(avatarDialogId);
			}, 1000);
		}
	</script>
</body>
</html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="js/pca.js"></script>
<script type="text/javascript" src="js/3rdparty/layer1.9/layer.js"></script>
<title>收货地址</title>
</head>
<body>
<div class="rightContainer fr">
  <h4 class="ddtitle"><span class="">收货地址</span>&nbsp;&nbsp;&nbsp;<a class="default-a" href="javascript:void(0);" onclick="window.location.href='/user/address/set';"> + 添加收货地址</a></h4>
  <!--// 内容框 //-->
  <div class="">
    <div id="userContents" class="userContents"> 
      <!--// 内容1 //-->
      <div class="dengjibox">
        <div class="dizhibox2">
          <table cellpadding="0" cellspacing="0" class="user-list-table txt-center">
            <tr>
              <th>收货人</th>
              <th>所在地区</th>
              <th>具体收货地址</th>
              <th>邮编</th>
              <th>电话/手机</th>
              <th>是否默认</th>
              <th style="border-right:none;">操作</th>
            </tr>
            <c:forEach var="ad" items="${list}">
              <tr>
                <td>${ad.name}</td>
                <td>${ad.province}${ad.city}${ad.district}</td>
                <td align="left">${ad.street}</td>
                <td>${ad.postcode}</td>
                <td><c:choose>
                    <c:when test="${ad.phone!='' && ad.phone!=null}"> ${ad.phone} </c:when>
                    <c:otherwise> ${ad.tel} </c:otherwise>
                  </c:choose></td>
                <td>
                  <c:if test="${ad.defaultFlag == false }"> <a href="javascript:void(0)" onclick="setDefault(${ad.id})" >设为默认</a> </c:if>
                  <c:if test="${ad.defaultFlag == true }"><span class="color-red fwb">默认地址</span></c:if>
                  </td>
                <td><a href="/user/address/set?addressId=${ad.id}" class="edit-user-photo">修改</a>
                <a class="edit-user-photo" onclick="del(${ad.id})" href="javascript:;">删除</a></td>
              </tr>
            </c:forEach>
          </table>
          <div class="msg-alert"><span class="gantanhao"></span>最多保存10个有效地址</div>
        </div>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">
$().ready(function(){
	var pro = "${ad.province}";
	var city = "${ad.city}";
	if(pro == "")
		pro = "四川省";
	if(city == "")
		city = "成都市";
	new PCAS("province", "city", "district",pro,city,"${ad.district}");
})
//设置默认
function setDefault(addressId){
	ajaxSubmit("user/address/default", "addressId=" + addressId, function(msgBean){
		if(msgBean.code == zhigu.code.success){
			layer.msg(msgBean.msg, 1, f5);
		}else{
			layer.alert(msgBean.msg);
		}
	},"json");
}
//删除收货地址
function del(addressId){
	layer.confirm('确认要删除收货地址？', {
	    btn: ['确定','取消']
	}, function(){
		_del();
	}, function(){
	    
	});
	
	function _del(){
		ajaxSubmit("user/address/del", "addressId=" + addressId, function(msgBean){
			if(msgBean.code == zhigu.code.success){
				layer.alert(msgBean.msg,f5);
			}else{
				layer.alert(msgBean.msg);
			}
		},"json");
	}
}
</script>
</body>
</html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>店铺基本信息</title>
<script type="text/javascript" src="js/pca.js"></script>
</head>
<body>
<div class="rightContainer fr">
  <h4 class="ddtitle">店铺基本信息</h4>
  <table cellpadding="0" cellspacing="0" class="user-form-table">
    <tr>
      <td style="width:20%">网站直达域名：</td>
      <td style="width:80%">http://${store.domain}.zhiguw.com</td>
    </tr>
    <tr>
      <td>商铺名称：</td>
      <td>${store.storeName}</td>
    </tr>
    <tr>
      <td>经营地址：</td>
      <td>${store.province}－${store.city}－${store.district}</td>
    </tr>
    <tr>
      <td>具体地址：</td>
      <td>${store.street}</td>
    </tr>
    <tr>
      <td>所在商圈：</td>
      <td><c:forEach var="t" items="${businessArea }">
          <c:if test="${t.value==store.businessArea}"> <span class="color-red" >${t.name}</span> </c:if>
        </c:forEach></td>
    </tr>
    <tr>
      <td>联系人姓名：</td>
      <td>${store.contactName }</td>
    </tr>
    <tr>
      <td>手机号码：</td>
      <td>${store.phone }</td>
    </tr>
    <tr>
      <td>联系QQ：</td>
      <td>${store.QQ }</td>
    </tr>
    <tr>
      <td>联系旺旺：</td>
      <td>${store.aliWangWang }</td>
    </tr>
    <tr>
      <td><a href="/supplier/store/updateBaseInfo" class="default-a">修改</a></td>
      <td>&nbsp;</td>
    </tr>
  </table>
</div>
</body>
</html>
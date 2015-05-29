<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<link href="css/default/jcDate.css" rel="stylesheet">
<script type="text/javascript" src="js/jQuery-jcDate.js"></script>
<script type="text/javascript" src="js/validate/jquery.validate.js"></script>
<script type="text/javascript" src="js/validate/message_cn.js"></script>
<script type="text/javascript" src="js/validate/additional-methods.js"></script>
<title>数据下载历史</title>
</head>
<body>
<div class="rightContainer fr">
  <h4 class="ddtitle">下载的商品</h4>
  <div class="rc_body">
    <div id="userContents" class="userContents"> 
      <!--// 内容1 //-->
      <div class="body_center2" id="alldd"> 
        <!-----------------------------------------------搜索---------------------------------------------------->
        <div class="fun-bar">
          <form action="user/downloadHistory/goods" method="post" id="searchHistory">
            <div class="dingdanxinxi">
              <div class="dingdanhao fl">
                <p class="fl">商品名称：</p>
                <input class="input-txt" type="text" id="goodsName" name="goodsName" value="${goodsName }"/>
              </div>
              <div class="dingdanhao fl">
                <p class="fl">店铺名：</p>
                <input class="input-txt" type="text" id="storeName" name="storeName" value="${storeName}"/>
              </div>
            </div>
          </form>
        </div>
        <div class="fun-bar">
          <div class="dingdanxinxi">
            <div class="dingdanhao">
              <p class="fl">下载时间：</p>
              <input class="jcDate fl input-txt" type="text" id="date1" name="startDate" value="${startDate }"/>
              <p class="fl">到</p>
              <input class="jcDate fl input-txt" type="text" id="date2" name="endDate" value="${endDate }"/>
              <p class="fl">
                <input type="submit" value="搜索" class="input-button" />
              </p>
            </div>
          </div>
        </div>
        <!-----------------------------------------------订单状态---------------------------------------------------->
        <div class="fun-bar"> 
          <!-----------------------------------------------订单操作---------------------------------------------------->
          <div class="sjcaozuo mt10">
            <input class="fl ml10 mr5" type="checkbox" id="selectall" onclick="selectAll($(this));"/>
            <label
					class="fl mr10" for="selectall">全选</label>
            <span
					class="fl c999 mr10">|</span> <a class="piliangaa fl c999 mr10"
					href="javascript:void(0)" onclick="formSub.click();">批量删除</a>
            <div class="clear"></div>
          </div>
        </div>
        <!-----------------------------------------------table标题---------------------------------------------------->
        <table cellpadding="0" cellspacing="0" class="user-list-table">
          <tr>
            <th>商品信息</th>
            <th>价格</th>
            <th>店铺名称</th>
            <th>下载时间</th>
            <th>操作</th>
          </tr>
        </table>
        <!-----------------------------------------------单个商品---------------------------------------------------->
        <form action="user/downloadHistory/deleteDownloadHistory" method="post" id="delForm">
          <c:forEach var="his" items="${downloadHistorys}">
            <table class="ddtable0 lh20">
              <tr class="ddcenter">
                <td width="400"><div class="imgbefore fl mt40">
                    <input type="checkbox" class="mr10 ml20" id="IDs" name="IDs" value="${his.ID }"/>
                  </div>
                  <div class="ddcenterimg fl ml10 mt10 mb10"> <a target="_blank" href="goods/detail?goodsId=${his.goodsID}"><img src="${his.imagePath }"  title="${his.goodsName }"/></a> </div>
                  <div class="ddimgmiaoshu fl ml10 mt10 lh20"> <a target="_blank" href="goods/detail?goodsId=${his.goodsID}">${his.goodsName}
                    <c:if test="${his.status==2 }"><span class="red">（商品已下架）</span></c:if>
                    </a> </div>
                  <div class="clear"></div></td>
                <td width="100" class="tc fwbold c999">${his.minPrice}-${his.maxPrice}</td>
                <td width="150" class="tc"><div> <a href="store/index?storeId=${his.storeID}">${his.storeName}</a> </div>
                  <div class="mt10">
                    <c:if test="${!empty his.QQ }"><a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=${his.QQ }&site=qq&menu=yes"><img border="0" src="http://wpa.qq.com/pa?p=2:${his.QQ}:52" alt="点这里给我发消息" /></a></c:if>
                    <c:if test="${!empty his.aliWangWang }"><a target="_blank" href="http://amos.im.alisoft.com/msg.aw?v=2&uid=${his.aliWangWang}&site=cntaobao&s=2&charset=utf-8" ><img border="0" src="http://amos.im.alisoft.com/online.aw?v=2&uid=${his.aliWangWang }&site=cntaobao&s=2&charset=utf-8" alt="点击这里给我发消息" /></a></c:if>
                  </div></td>
                <td width="150" class="tc c666"><fmt:formatDate value="${his.downloadTime }" pattern=" yyyy-MM-dd HH:mm:ss" /></td>
                <td width="200" class="caozuol tc c999"><a
						href="user/downloadHistory/deleteDownloadHistory?IDs=${his.ID}">删除</a></td>
              </tr>
            </table>
          </c:forEach>
          <input type="submit" id="formSub" style="display:none"/>
        </form>
        <div class="sjcaozuo mt10">
          <input class="fl ml10 mr5" type="checkbox" id="selectall2"  onclick="selectAll($(this));"/>
          <label
				class="fl mr10" for="selectall2" >全选</label>
          <span
				class="fl c999 mr10">|</span> <a class="piliangaa fl c999 mr10"
				onclick="formSub.click();" id="delete">批量删除</a>
          <div class="clear"></div>
        </div>
      </div>
    </div>
    <br style="clear:both;" />
  </div>
</div>
<div class="ddpage fr mr20">
  <jsp:include page="../include/page.jsp">
  <jsp:param value="form" name="request"/>
  <jsp:param value="searchHistory" name="requestForm"/>
  </jsp:include>
</div>
<div class="clear"></div>
<script type="text/javascript">
			// checkbox全选
			function selectAll(obj){
				if(obj.is(":checked")){
					$("input:checkbox").attr("checked", true); 
				}else{
					$("input:checkbox").attr("checked", false); 
				}
			}
		$(function() {
			$("#searchHistory").validate({
				rules:{
					goodsName:{
						maxlength:20
					},
					storeName:{
						maxlength:20
					}
				}
			});
			
			$("#delForm").submit(function(){
				if($("#delForm input:checked").length==0){
					dialog("请选择要删除的记录！");
					return false;
				}
				return true;
			});
			
			$("input.jcDate").jcDate({
				IcoClass : "jcDateIco",
				Event : "click",
				Speed : 100,
				Left : 0,
				Top : 28,
				format : "-",
				Timeout : 100
			});
		});
	</script> 
<script>
	$(".jinsan li").corner("3px");
</script>
</body>
</html>
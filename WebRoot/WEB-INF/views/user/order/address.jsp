<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript" src="js/pca.js" ></script>
<h4 class="ddtitle">
<span class="">收货信息</span>
<a class="default-a fr" href="javascript:void(0)" onclick="newAddress()"> + 添加新地址 </a>
<a class="default-a fr" href="javascript:void(0)" onclick="toggle(this)"  data="0">显示全部收货地址</a>
</h4>
<c:set var="disItem" value="" />
<c:set var="selectedItem" value="morendizhi" />
<c:forEach items="${addresses }" var="ad" varStatus="adStatus">
  <table cellpadding="0" cellspacing="0" class="user-form-table ${disItem} ${selectedItem}" addressID="${ad.ID}" onclick="adCheck(this,${ad.ID})">
    <tr>
      <td style="width:10%"><span class="morenicon"></span>${ad.name }</td>
      <td style="width:20%"><span class="morenicon" id="morenicon2"></span>${ad.phone }</td>
      <td style="width:40%"><span class="morenicon" id="morenicon3"></span> <span>${ad.province }</span> <span>${ad.city }</span> <span>${ad.district }</span> <span>${ad.street }</span> </td>
      <td style="width:30%">
      <c:choose>
      <c:when test="${ad.isDefault == 1 }">
      	<span>默认地址</span>
      	<span><a class="default-a" href="javascript:void(0);" onclick="modify(${ad.ID})">修改 </a></span>
      </c:when>
      <c:otherwise>
        <div class="dizhixiugai2">
		<a class="default-a" href="javascript:void(0);" onclick="setDefault(${ad.ID})">设置为默认地址</a>
		<a class="default-a" href="javascript:void(0);" onclick="modify(${ad.ID})">修改</a>
		<a class="default-a" href="javascript:void(0);" onclick="del(${ad.ID})">删除</a> </div>
      </c:otherwise>
      </c:choose>
      </td>
    </tr>
  </table>
  <c:if test="${adStatus.count == 1 }">
    <c:set var="selectedItem" value="" />
  </c:if>
  <c:if test="${adStatus.count >= 2 }">
    <c:set var="disItem" value="ad_dis_item disnone" />
  </c:if>
  <input type="hidden" id="addressLabel${ad.ID }" value="${ad.province } ${ad.city } ${ad.district } ${ad.street }">
  <input type="hidden" id="consigneeLabel${ad.ID }" value="${ad.name } ${ad.phone }">
</c:forEach>
<script type="text/javascript">
if (typeof zhigu == "undefined" || !zhigu) {
    var zhigu = {};
}
	//添加收获地址
	function newAddress(){
		ajaxSubmit("user/address/dialog", {}, function(data){
			$.layer({
			    type: 1,
			    shade: [0.5,'#000'],
			    area: ['auto', 'auto'],
			    title: '添加收货地址',
			    page: {html : data}
			});
		}, "text");
	}
	//设置默认
	function setDefault(addressID){
		ajaxSubmit("user/address/default", "addressID=" + addressID, function(msgBean){
			if(msgBean.code == zhigu.code.success){
				layer.msg(msgBean.msg, 1, f5);
			}else{
				layer.alert(msgBean.msg);
			}
		},"json");
	}
	//删除收货地址
	function del(addressID){
		$.layer({
		    shade: [0.5,'#000'],
		    area: ['auto','auto'],
		    dialog: {
		        msg: '确认要删除收货地址？',
		        btns: 2,                    
		        type: 4,
		        btn: ['确定','取消'],
		        yes: function(){
		        	_del();
		        }
		    }
		});
		function _del(){
			ajaxSubmit("user/address/del", "addressID=" + addressID, function(msgBean){
				if(msgBean.code == zhigu.code.success){
					layer.msg(msgBean.msg, 1, f5);
				}else{
					layer.alert(msgBean.msg);
				}
			},"json");
		}
	}
	//显示、隐藏
	function toggle(obj){
		var tg = $(obj).attr("data");
		if(tg == 0){//展开
			$(obj).attr("data","1");
			$(obj).html("隐藏");
			$(".ad_dis_item").removeClass("disnone");
		}else{
			$(obj).attr("data","0");
			$(obj).html("显示全部收货地址");
			$(".ad_dis_item").addClass("disnone");
		}
	}
	//修改地址
	function modify(addressID){
		ajaxSubmit("user/address/dialog", "addressID=" + addressID, function(data){
			$.layer({
			    type: 1,
			    shade: [0.5,'#000'],
			    area: ['auto', 'auto'],
			    title: '修改收货地址',
			    page: {html : data}
			});
		}, "text")
	}
	//选择收货地址
	function adCheck(obj){
		if(obj == null || obj == "undefined")
			return;
		$(".address").removeClass("morendizhi");
		$(obj).addClass("morendizhi");

		var id = $(obj).attr("addressID");
		$("#addressLabel").html($("#addressLabel" + id).val());
		$("#consigneeLabel").html($("#consigneeLabel" + id).val());
		$("#addressID").val(id);
		
		countMoney();
	}
	$().ready(function(){
		adCheck($(".morendizhi"));
	});
</script>
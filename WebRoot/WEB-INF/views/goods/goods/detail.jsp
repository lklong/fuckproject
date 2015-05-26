<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品详情</title>
<link href="js/3rdparty/easyui/themes/bootstrap/easyui.css" rel="stylesheet" type="text/css" >
<link href="js/3rdparty/raty-2.7.0/jquery.raty.css" rel="stylesheet" type="text/css" >
<link href="css/jinhuoche.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/mz-packed.js"></script>
<script src="/js/jquery.lazyload.js"></script>
<script type="text/javascript">

	$(function(){
		$("img.lazy","#description").lazyload({
			placeholder:"/img/show/loading.gif",
			effect : "fadeIn",
			threshold : 200,
		});

	});

</script>
<style type="text/css">
#description img{
max-width: 975px;
}

/* 鼠标点击后的样式 */
#J_isku ul li .spanStyle{
  padding: 2px 5px; 
  color: #E71706;
  border: 2px solid #E71706;
  background: #FFF;
  cursor:pointer
}

</style>
</head>
<body style="background-color:#ffffff !important;">
<jsp:include page="../../store/shoe/header.jsp"/>
<div class="goodsDetailsBody">
	<div class="goodsBodyInside">
    	<div class="detailsLeft">
        	<div class="goodsImgTxtBox">
            	<div class="gitbLeft">
                	<div class="gitbImgBox">
                		<span>
                		<a href="${goods.images[0].image }" class="MagicZoom image_replace_a" id="MagicZoom" rel="zoom-width:430px; zoom-height:430px">
       						<img src="${goods.images[0].image}" class="image_replace_img" style="max-height: 430px; max-width: 430px; width: 430px;"  /><!--style="max-height:398px;max-width:398px;"  -->
       					</a>
       					</span>
                	</div>
                    <ul class="gitbThumbImgList">
                    	<c:forEach items="${goods.images }" var="item" end="4">
	                    	<li>
	       						<a href="${item.image }" rel="MagicZoom" rev="${item.image300 }">
	       							<img src="${item.image300}_160x160.jpg" width="58" height="58" />
	       						</a>
	       					</li>
                    	</c:forEach>
                    </ul>
                </div>
                <div class="gitbRight">
                	<h3>${goods.name }</h3>
                    <div class="priceDiv">
                    	<div class="priceTxt">价格</div>
                        <div class="priceNum"><span class="ff3300">￥<font size="+2"><strong>${goods.minPrice } ~ ${goods.maxPrice }</strong></font></span></div>
                        <div class="priceAlert">零售价在此基础上加价！</div>
                    </div>
                     <div id="J_isku"  class="tb-key tb-key-sku ">
    <!-- sku组合 -->                 
    <div class="tb-skin">
    		  <c:forEach items="${skuMap}" var="sku">
 				<dl class="J_Prop J_TMySizeProp tb-size tb-prop tb-clearfix J_Prop_measurement">
					<dt class="tb-property-type dt-sku-prop-name">${sku.key}</dt>
					<dd>
						<ul class="J_TSaleProp tb-clearfix">
						<c:forEach items="${sku.value}" var="item">
							<li><span class="sku_a" data-idstr="${item.propertyId}:${item.propertyValueId}">${item.propertyValueName}</span></li>
						</c:forEach>
						</ul>
					</dd>
				</dl>
			</c:forEach>
				
				<dl class="tb-amount tb-clearfix">
					<dt class="tb-property-type">数量</dt>
						<dd>
							<span class="tb-stock" id="J_Stock">
								 <a href="javascript:void(0)" hidefocus class="tb-reduce J_Reduce tb-iconfont">－</a>
								 <input id="J_IptAmount" type="text" class="tb-text" value="1"  maxlength="8" title="请输入购买量"/>
								 <a href="javascript:void(0)" hidefocus class="tb-increase J_Increase tb-iconfont">＋</a>件
						 </span>
							<lable><input id="sku_id" name="sku_id" type="hidden"/>(库存<span id="J_SpanStock"  class="tb-count">${goods.aux.amount}</span>件)</lable>
					    </dd>
				</dl>
						<dl id="J_DlChoice" class="tb-choice tb-clearfix">
					<dt>请选择：</dt>
					<dd>
					<em>"尺码"</em><em>"颜色分类"</em></dd>
					</dl>
  		</div>   
  
                    <div class="gitbButns">
                    	<c:choose>
                    		<c:when test="${goods.status == 1}">
			                    <!-- <a href="javascript:void(0)" onclick="openOrderDialog()"><img src="img/jinhuo_btn.jpg" /></a> -->
			                      <a href="javascript:void(0)" id="addCartNew"><img src="img/jinhuo_btn.jpg" /></a>
				                <a onclick="downloadDatas(${goods.id});" id="downloadDatas" target="_blank"><img src="img/xiazai_btn.jpg" /></a>
<!-- 				                <a href="#"><img src="img/fabutaobao.jpg" /></a> -->
				             <a href="/user/tb/auth?goodsId=${goods.id}"><img src="img/fabutaobao.jpg" /></a>
				                <%-- <a href="/alibaba/auth?goodsId=${goods.id}"> 发布到阿里</a> --%>

                    		</c:when>
                    		<c:otherwise>
                    			<h1>该商品已经下架！</h1>
                    		</c:otherwise>
                    	</c:choose> 
                    </div>
                    <div class="gitnInfo">本产品采购属于商业贸易行为，不适用《新消法》"七天无理由退货"</div>
                    <div class="addMarkFav">
                    	<%-- <div id="bdshare" class="bdsharebuttonbox" data="{'url':'goods/detail?goodsId=${goods.id}'}" data-tag="share_${goods.id }" style="float:left;">
							<a href="javascript:void(0);" class="bds_more"  data-cmd="more"  style="margin: 0px;">分享到</a>
						</div>
						
						<div class="prbValue addMarkGoods ml10" id="fav">
							<img src="img/icon_2.gif" />
		                	<a href="javascript:void(0)"  onclick="favoGoods(${goods.id});">收藏商品</a>	
		                </div> --%>
		                
					  <table>
					    <tr><td style="padding-right: 0px;width:55px">
					          	<div data-bd-bind="1425354311818" id="bdshare" class="bdsharebuttonbox bdshare-button-style0-16" data="{'url':'goods/detail?goodsId=4985'}" data-tag="share_4985" style="float:left;">
								<a href="javascript:void(0);" class="bds_more" data-cmd="more" style="margin: 0px;">分享到</a></div>
							</td>
					      <td style="width: 0px; padding-right: 0px;"><img src="img/icon_2.gif"></td>
					      <td style="padding-left: 1px;"><a style="" href="javascript:void(0)" onclick="favoGoods(${goods.id});">收藏商品</a></td>
					    </tr>
					  </table>
                    </div>
                </div>
            </div>
            <!--** 切换条 **-->
        	<div class="infoSelectBar">
            	<ul class="infoSelectList">
                	<!-- <li onclick="selTab(this,'baseInfo')" class="infoSelectedLi">商品详情</li>
                	<li onclick="selTab(this,'downDataList')">下载详情</li> -->
                    <!--<li onclick="selTab(this,'downDataList'),loadDownloadHistory()">下载详情</li>-->
                  <!--   <li onclick="selTab(this,'pingLunBox'),loadEavaluate()">商品评论</li> -->
                     <li class="infoSelectedLi" data-container="baseInfo">商品详情</li>
                  <!-- 	<li class="baseInfo infoSelectedLi" data-path="/goods/ajax/comments" data-container="pingLunBox">商品详情</li> -->
                  	<li class="download remote" data-path="/goods/ajax/downloads" data-container="downDataList">下载详情</li>
                    <li class="comment remote" data-path="/goods/ajax/comments" data-container="pingLunBox">商品评论</li>
					<!--<li style="cursor: pointer;" onclick="selTab(this,'tousuFankui')">投诉反馈</li>-->
                </ul>
                <div class="infoSelectBg"></div>
            </div>
            <!--** 基本信息表格 **-->
        	<div class="selTab baseInfo">
        		<c:forEach items="${goods.properties }" var="p">
        			<c:if test="${!p.sku }">
		            	<div>${p.propertyName }：${p.propertyValueName }</div>
        			</c:if>
        		</c:forEach>
                <br style="clear:both" />
                <div class="mt10" id="description">
                	${goods.description }
                </div>
            </div>
            <!--** 下载列表 **-->
        	<div class="selTab downDataList disnone"></div>
            <!--** 评论列表 **-->
        	<div class="selTab pingLunBox"></div>
            <!--** 反馈列表 **-->
<!--         	<div class="selTab tousuFankui disnone"> -->
<!--             	<div>温馨提示：对本商品的投诉反馈，将以匿名方式记录，不会透露您的信息予第三方。</div> -->
<!--                 <div>请选择下列投诉类型：</div> -->
<!--                 <div class="toushuDiv"> -->
<!--                 	<ul class="toushuUL"> -->
<%--                 		<c:forEach items="${complaintType }" var="c" varStatus="vs"> --%>
<%-- 	                    	<li onclick="setType(this,${c.id})">${c.name }</li> --%>
<%--                 		</c:forEach> --%>
<!--                     </ul> -->
<!--                 </div> -->
<!--                	<div>您还能输入<span id="inputLength" style="color: red;">500</span>字</div> -->
<!--                 <form action="" id="complaintForm"> -->
<!--                 	<input name="type" id="complaintType" type="hidden"> -->
<%--                 	<input name="goodsId" value="${goods.id }" type="hidden"> --%>
<!-- 	                <div><textarea name="content" id="complaintContent" onkeyup="checkLen(this)" maxlength="500" class="submitTextArea"></textarea></div> -->
<!-- 	                <div><input type="button" onclick="submitComplaint()" class="tijiaoPingLun" value="提交投诉/反馈" /></div> -->
<!--                 </form> -->
<!--         	</div> -->
        </div>
    </div>
    <!--** 商家动态 **-->
        <div class="detailsRight">
        	<div class="shopActive">
            	<h3 class="shopHead">商家动态</h3>
            	<c:forEach items="${page.datas }" var = "notice">
            	 	<div>${notice.content }</div>
            	</c:forEach>
            </div>
            <div class="shopActive">
            	<h3 class="shopHead">橱窗推荐</h3>
                <ul class="chuchuang">
                	<c:forEach items="${sellGoods }" var="g">
	        			<li>
	        				<a href="goods/detail?goodsId=${g.id }" target="_blank"><img src="${g.image300 }_160x160.jpg" height="158" width="158" /></a>
	                    	<p><a href="goods/detail?goodsId=${g.id }" target="_blank">${g.name }</a></p>
	                        <p><font color="#ff4400">￥${g.minPrice }</font></p>
	                    </li>
                	</c:forEach>
                </ul>
            </div>
            <div class="shopActive">
            	<h3 class="shopHead">热门下载</h3>
                <ul class="chuchuang">
                	<c:forEach items="${download }" var="g">
	        			<li>
	        				<a href="goods/detail?goodsId=${g.id }" target="_blank"><img src="${g.image300 }" height="158" width="158" /></a>
	                    	<p><a href="goods/detail?goodsId=${g.id }" target="_blank">${g.name }</a></p>
	                        <p><font color="#ff4400">￥${g.minPrice }</font></p>
	                    </li>
                	</c:forEach>
                </ul>
            </div>
        </div>

	</div>
</div>

<div id="url_copy_div"  title="图片外链" modal="true" closed="true" class="easyui-dialog"  style="padding: 20px;width: 770px;height: 550px;">
	<p>以下为商品详情代码</p><br/>
	<input onclick="$('#url_copy').select();" value="点此全选以下内容" type="button"><input onclick="copy_clip();" value="点此复制以下内容" type="button"><br/><br/>
	<textarea style="height: 400px;width: 700px;" id="url_copy">没有数据！</textarea>
</div>
<form action="user/order/confirm" method="post" id="confirmForm"></form>

<script type="text/javascript">

$(function(){
	
	// sku组合的点击事件
	$(".sku_a").click(function(){
		
		// 共同操作
		
		// 数量，库存复原
		$("#J_IptAmount").val(1);
		$("#J_SpanStock").text("${goods.aux.amount}");
		
		// 去除同辈元素的遮罩
		var $par = $(this).parents("dl").siblings();
		// debugger;
		$(".disabled-div",$par).remove();
		
		// - ,+ dom节点复原
		$("#J_Stock a").attr("style","");
		if(!$(".tb-increase").hasClass("J_Increase")){
			$(".tb-increase").addClass("J_Increase");
		}
		if(!$(".tb-reduce").hasClass("J_Reduce")){
			$(".tb-reduce").addClass("J_Reduce");
		}
		
		// 1. 控制样式（按行控制）
		var $sku = $(this);
		var $sku_tr = $sku.parents("ul");
		if($sku.hasClass("spanStyle")){
			$sku.removeClass("spanStyle");
			var len = $(".spanStyle").length;
			if(len > 0){
				skuStr = $(".spanStyle").attr("data-idstr");
				skuAjax(skuStr);
			}
			return;
		}else{
			$(".sku_a",$sku_tr).each(function(i,n){$(n).removeClass("spanStyle");});
			$sku.addClass("spanStyle");
			
			//  查询参数
			var skuStr = $sku.attr("data-idstr");
			// 请求后台
			skuAjax(skuStr);
		}
	});
	
   /*
	* sku ajax请求
	* skuStr 查询的销售属性
	*/
	function skuAjax(skuStr){
		
			// 1. 统计当前商品的销售属性的个数
			var sale_prop_len = $(".J_Prop").length;
			
			// 2. 统计当前商品用户已 选择的销售属性个数
			var selected_span_len = $(".spanStyle").length;
			
			// 判断结果
			var bool = sale_prop_len === selected_span_len;
		   
			var goodsId = ${goods.id};
			var json = {
					goodsId:goodsId,
					skuStr:skuStr,
			};
		
			// 3. ajax加载后台数据，修改dom节点
			$.get("/ajax/goods/sku",json,function(data){
				if(data.status){
					var _sku = null;
					// sku库存为0的商品sku数组
					var sku_amount_0 = new Array();

					var skus = data.data;
					var len = skus.length;
					
					for(var i = 0 ; i<len ; i++){
						//debugger;
						var sku = skus[i];
						var propStr = sku.propertyStr;
						var amount = parseInt(sku.amount);
						
						// 4. 提取sku库存为0的sku数组
						if(amount === 0){
							sku_amount_0.push(sku);
						}
					}
				
					// 5. 提取当前商品的sku
					if(bool){
						var idStr_arr = new Array();
						if(selected_span_len>1){
							var $other_selected_span = $(".spanStyle");
							for(var i = 0 ;i<selected_span_len ;i++ ){
								var other_idStr = $($other_selected_span[i]).attr("data-idstr");
								if(other_idStr != skuStr){
									idStr_arr.push(other_idStr);
								}
							}
						}
						// TODO 多于2个销售属性的商品处理
						var _skuStr = idStr_arr[0];
						
						for(var i = 0 ; i<len ; i++){
							var sku = skus[i];
							var propStr = sku.propertyStr;
							if(propStr.indexOf(skuStr)!=-1&&propStr.indexOf(_skuStr)!=-1){
								_sku = sku;
							}
						}
					}
					
					// 6. 处理库存为0商品
					for(var i = 0;i<sku_amount_0.length;i++){
						var sku = sku_amount_0[i];
						var propStr = sku.propertyStr;
						var _propStr = propStr.replace(",","").replace(skuStr,"");
						
						$(".sku_a").each(function(i,n){
							if($(n).attr("data-idstr") === _propStr){
								//debugger;
								$(n).parent("li").append("<div class='disabled-div' title='此组合库存数量为0，不可添加到购物车'></div>");
							}
						});
						
					}
					
					// 7. 当前页面已选择的sku
					if(_sku!=null){
						$("#J_SpanStock").text(_sku.amount);
						$("#sku_id").val(_sku.id);
					}
				
				}else{
					dialog(data.msg);
				}
			});// ajax end;
	}
	
	// - 事件
	$(".J_Reduce").click(function(){
		var cur_num =  parseInt($("#J_IptAmount").val());
		if(cur_num <= 1 ){
			$(".J_Reduce").removeClass("J_Reduce").attr("style","background:red;cursor:not-allowed");
		}else{
			$("#J_IptAmount").val(cur_num-1);
		}
		$(this).next().next().addClass("J_Increase").attr("style","");
	});
	
	
	// + 事件
	$(".J_Increase").click(function(){
		var cur_num =  parseInt($("#J_IptAmount").val());
		var amount = parseInt($("#J_SpanStock").text());
		if(cur_num === amount||amount === 0 ){
			$(".J_Increase").removeClass("J_Increase").attr("style","background:red;cursor:not-allowed");
		}else{
			$("#J_IptAmount").val(cur_num+1);
		}
		$(this).prev().prev().addClass("J_Reduce").attr("style","");
	});
	
	// 手动输入
	$("#J_IptAmount").on('input',function(e){
		 var cur_num =  parseInt($("#J_IptAmount").val());
		 var amount = parseInt($("#J_SpanStock").text());
		 if(amount === 1||cur_num > amount){
			 this.value = amount;
		 }
		 if(cur_num < 1){
			 this.value = 1;
		 }
	  });
	
	
	// 加入购物车
	$("#addCartNew").click(function(){
		var sale_prop_len = $(".J_Prop").length;
		var selected_span_len = $(".spanStyle").length;
		// 判断结果
		var bool = sale_prop_len === selected_span_len;
		if(!bool){
			 var tips = "";
			 var prop_names = $(".dt-sku-prop-name");
			 var len = prop_names.length;
			 for(var i = 0; i < len; i++){
				 if(i+1 == len){
					 tips += $(prop_names[i]).text();
				 }else{
					 tips += $(prop_names[i]).text()+"和"
				 }
			 }
			 
			dialog("请选择"+tips+"的正确组合");
			return;
		}
		
		// 参数，ajax 请求
		var skuId = $("#sku_id").val();
		var quantity = $("#J_IptAmount").val();
		var json = {skuId:skuId,quantity:quantity};
		var url = "/user/cart/add";
		ajaxSubmit(url, json, function(msgBean){
			if(msgBean.code==zhigu.code.success){
				$.layer({
				    shade: [0],
				    area: ['350px','200px'],
				    dialog: {
				        msg: msgBean.msg,
				        btns: 2,                    
				        type: -1,
				        btn: [' 去购物车 ',' 继续购物 '],
				        yes: function(){
				        	window.location.href = '/user/cart';
				        }, no: function(index){
				        	zhigu.refreshCartNum();
				            layer.closeAll();
				        }
				    }
				});
			}else{
				//layer.alert(msgBean.msg+html, 8);
				layer.alert(msgBean.msg, 8);
			}
		});
		
	});
	
	
	// 详情,评论,下载
	$(".infoSelectList li").click(function(){
		var that = $(this);
		$(".selTab").hide();
		that.addClass("infoSelectedLi").siblings().removeClass("infoSelectedLi");
		var container = that.data("container");
		if(that.hasClass("remote")){
			var path = that.data("path");
			$("."+container).load(path,{goodsId:"${goods.id}"});
		}
		$("."+container).show();
	});

	// 评论分类加载
	$(".changeDiv ul li").on('click',function(){
		var that = $(this);
		var type = that.data("type");
		$(".pingLunBox").load("/goods/ajax/comments",{type:type},function(){
			that.addClass("pingLunSelected").siblings().removeClass("pingLunSelected");
		});			
	});

	$(".gitbThumbImgList li a img").mouseover(function(){
		var img_300 = $(this).attr("src");
		var img =  img_300.replace("_160x160.jpg","");
		$(".image_replace_a").attr("href",img);
		$(".image_replace_img").attr("src",img);
		$(".MagicZoomBigImageCont").children().children().attr("src",img);		
	});
	
	// 购物车添加数量限制补丁
	$(".quantity").change(function(){
		var amount = $(this).attr("amount")*1;
		var value = $(this).val()*1;
		if(amount<value){
			$(this).val(amount);
		}
		
	});
	
	// 分享补丁
	$(".bds_more,popup_more").click(function(){
		$(".bdshare_popup_box").hide();
	});

});

if (typeof zhigu == "undefined" || !zhigu) {
    var zhigu = {};
}

function sub(target){
	$("#" + target).val(parseInt($("#" + target).val(), 10) > 0 ? (parseInt($("#" + target).val(), 10) - 1) : 0);
	count();
}
function add(target,max){
	var quantity = parseInt($("#" + target).val(), 10);
	if(quantity >= max)
		return;
	$("#" + target).val(quantity + 1);
	count();
}
function count(){
	var totalQuantity = 0;
	var totalMoney = 0;
	$(".quantity").each(function(){
		var quantity = parseInt($(this).val(),10);
		totalMoney += parseFloat(quantity * $(this).attr("unit"));
		totalQuantity += quantity;
	});
	$("#totalQuantity").html(totalQuantity);
	$("#totalMoney").html(totalMoney.toFixed(2));
}

function _submit(){
	var totalQuantity = $("#totalMoney").html();
	if(parseInt(totalQuantity,10) <= 0){
		dialog("请选择需要购买的商品！",null,null,null,false);
		return false;
	}
	ajaxSubmit($("#cartAdd").attr("action"), $("#cartAdd").serialize(), function(data){
		if(data.flag == 0){
			var para = "";
			var items = data.items.split(',');
			for(var i = 0 ; i < items.length ; i++){
				para += "<input type='hidden' name='customValue' value='" + items[i] + "'>"
			}
			$("#confirmForm").append(para);
			$("#confirmForm").submit();
		}else{
			dialog(data.msg,function(){
				closeOrderDialog();
			});
		}
	});
}


var successType = 1;
function loadDownloadHistory(){
	var html = $(".downDataList").html();
	if(html != "")
		return ;
	
	ajaxSubmit("goods/downloadHistory", {goodsId:"${goods.id}"}, function(data){
		successType = 1;
		zhigu.pageAjaxSuccess(data);
	},"text");
}
zhigu.pageAjaxSuccess = function(data){
	if(successType == 1)
		$(".downDataList").html(data);
	if(successType == 2){
		$("#evaluateList").html(data);
		initScore();		
	}
}
function downloadDatas(goodsID){
	var downloadPath = $("#downloadDatas").prop("href");
	if(!downloadPath){
		$.ajax({
			url:"/goods/user/downloadDatas",
			data:{"goodsID":goodsID},
			dataType:"json",
			async:false,
			success:function(msgBean){
				if(msgBean.code == zhigu.code.success){
					$("#downloadDatas").prop("href","http://www.zhiguw.com"+/^\//.test(json.datasPath)?json.datasPath:("/"+msgBean.data));
					return;
				}else{
					layer.alert(msgBean.msg);
				}
			},
			error:function(){
				//dialog("下载失败！");
				return false;
			}
		});
	}
}
function setType(obj,id){
	$(".toushuUL li").removeClass("toushuSelected");
	$(obj).addClass("toushuSelected");
	$("#complaintType").val(id);
}
function submitComplaint(){
	var type = $("#complaintType").val();
	var content = $("#complaintContent").val();
	if(type == ""){
		dialog("请选择投诉类型");
		return;
	}
	if(content == ""){
		dialog("请填写投诉内容");
		return;
	}
	ajaxSubmit("user/goods/complaint", $("#complaintForm").serialize(), function(msgBean){
		if(msgBean.code == zhigu.code.success){
			layer.msg(msgBean.msg, 1, f5);
			$("#complaintContent").val("");
		}else{
			layer.alert(msgBean.msg);
		}
	});
}
function copy_clip() {
	var txt = $("#url_copy") .html();
    if (window.clipboardData) {
            window.clipboardData.clearData();
            window.clipboardData.setData("Text", txt);
    } else if (navigator.userAgent.indexOf("Opera") != -1) {
            window.location = txt;
    } else if (window.netscape) {
            try {
                    netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
            } catch (e) {
                    alert("您的firefox安全限制限制对剪贴板操作，请手动复制一下代码！");
                    return false;
            }
            var clip = Components.classes["@mozilla.org/widget/clipboard;1"].createInstance(Components.interfaces.nsIClipboard);
            if (!clip)
                    return;
            var trans = Components.classes["@mozilla.org/widget/transferable;1"].createInstance(Components.interfaces.nsITransferable);
            if (!trans)
                    return;
            trans.addDataFlavor('text/unicode');
            var str = new Object();
            var len = new Object();
            var str = Components.classes["@mozilla.org/supports-string;1"].createInstance(Components.interfaces.nsISupportsString);
            var copytext = txt;
            str.data = copytext;
            trans.setTransferData("text/unicode", str, copytext.length * 2);
            var clipid = Components.interfaces.nsIClipboard;
            if (!clip)
                    return false;
            clip.setData(trans, null, clipid.kGlobalClipboard);
    }
}
function initScore(){
	$('.data-score').raty({
		readOnly: true,
		score: function() {
		    return $(this).attr('data-score');
		}
	});
}
function changeLevel(obj){
	$(".changeDiv li").removeClass("pingLunSelected");
	$(obj).addClass("pingLunSelected");
}


function checkLen(obj) {
	var maxChars = 500;
	if ($(obj).val().length > maxChars)
		$(obj).val($(obj).val().substr(0,maxChars));
	var curr = maxChars - $(obj).val().length;  
	$("#inputLength").html(curr); 
} 
</script>
<script>window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"智谷同城货源网-${goods.name }","bdMini":"1","bdMiniList":false,"bdPic":"","bdStyle":"0","bdSize":"16"},"share":{}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];</script>
</body>
</html>
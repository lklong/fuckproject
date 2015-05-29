<%@page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html><head>
<title>淘宝产品发布平台</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="css/taobao/common.css" rel="stylesheet" type="text/css">
<link href="css/taobao/prompt.css" rel="stylesheet" media="all">
<link rel="stylesheet" type="text/css" href="css/taobao/fabutaobao.css">
<link rel="stylesheet" href="css/taobao/default.css">
<script type="text/javascript" src="/js/3rdparty/jquery1.9.1.js"></script>
<script type="text/javascript" src="/js/taobao/taobao.js"></script>
<script type="text/javascript" src="js/3rdparty/layer/layer.min.js"></script>
<style type="text/css">
	input{
	border: medium none;
	}
</style>
<script type="text/javascript">

var host = '${host}';
var hmelists = new Array("","","","","");
//数据返显
$(function(){
	
	$('.search').hide();
	var converts = $.parseJSON('${converts}');
	for(var i=0;i<converts.length;i++){
		
		var isMulti = converts[i].isMulti;
		var isSaleProp = converts[i].isSaleProp;
		var isEnumProp = converts[i].isEnumProp;
		var isColorProp = converts[i].isColorProp;
		
		// 下拉处理
		if(isEnumProp&&!isMulti){
			$(".feature_"+converts[i].propId).val(converts[i].propId+":"+converts[i].valueId);
		}else if(isMulti||isColorProp){// 多选处理
			$(".feature_"+converts[i].valueId).attr("checked",true);
		}else{// 输入处理
			$(".feature_"+converts[i].propId).val(converts[i].valueName);
		}
	}
	
	$(".imgsel").click(function() {
		var vstr = this.innerHTML;
		var vstr = $(this).find('img').attr('src');
		istr=vstr;
		var hmevalue = true;
		for(var i = 0;i<hmelists.length;i++){
			if(hmelists[i]==""){
				document.getElementById("hme"+i).innerHTML = "<img src=\""+vstr+"\" />";
				hmelists[i]=istr;
				hmevalue = false;
				break;
			}
		}
		getimgsvalue();
		if(hmevalue){
			layer.msg("商品首图只能选择5张，不能再选择了！");
		}
	});
	
	$(".yjbj").click(function(){
		var params = $("#desc_images").val();
		params=params.substring(1,params.lastIndexOf("]"));
		var other = $("#key").val();
 		$.post("/taobao/ajax/image/move",{descImages:params,access:other},function(data){
 			console.log(data.data);
		}) 
	});
	
	$(".hmeimg").click(function() {
		var idv = this.lang;
		document.getElementById("hme"+idv).innerHTML = "";
		hmelists[idv]="";
		getimgsvalue();
	});
	
	$("#title").on('keyup focusout',function(){
		var titlevalue = this.value;
		var tlen = this.value.getBytesLength();
		var lostlen = 60-tlen;
		if(lostlen>=0){
			lostlen = "还能输入<strong>"+Math.ceil(lostlen/2)+"</strong>个字！";
		}else{
			this.value = titlevalue.substr(0,titlevalue.length-1)
			lostlen = "<font color=\"red\">已超出<strong>"+(lostlen*-1)+"</strong>个字！</font>";
		}
		$("#TitleLen").html(lostlen);
	});
	
	$("#edit_attr").click(function(){
		$("li").each(function(){
			if($(this).attr('hidden_attr')==1){
				$(this).toggle();
			}
		})
	});

	$("#edit_color_size").click(function(){
		$("li").each(function(){
			if($(this).attr('hidden_attr')==2){
				$(this).toggle();
			}
		})
	});
	
	// 发布到淘宝
	$('.taobaocsv').click(function() {
		
		var that = $(this);
		var index = layer.msg('正在发布中...', {icon: 16});
		
		var url = host+"/taobao/ajax/item/save";
		var form = $("#taobaocsv").serialize();
		// 描述
	    desc = UE.getEditor('editor').getPlainTxt();
		var param = $.param({desc:desc})+"&"+form;
        $.post(url,param,function(data){
        	layer.close(index);
        	if(data.status){
        		layer.msg(data.msg,2,function(){
        			window.location.href= "http://www.zhiguw.com"
        		});
        	}else{
        		layer.msg(data.msg,1);
        	}
        });
	});
	
	$('#freight_payer').on('change click',function() {
		var v = $(this).find('option:selected').val();
		if(v == 'seller'){
			$('#postage_id').css({'display':'none'});
		}else{
			$('#postage_id').css({'display':''});
		}
	});

	function getimgsvalue(){
		var imgsvalue = "";
		for(var i = 0;i<hmelists.length;i++){
			if(hmelists[i]!=""){
				imgsvalue += hmelists[i]+",";
			}
		}
		document.forms["taobaocsv"].images.value = imgsvalue;
		return(imgsvalue);
	}
});

</script>

</head>
	<body>
		<div id="publishbox">
			<h1><span>淘宝产品发布平台</span>
				
				<em>淘宝帐号：<span>${user.nick }</span>
				<a href="/goods/detail?goodsId=${goods.id}">退出</a>
				<a href="/user/tb/auth/change?goodsId=${goods.id}">切换淘宝帐号</a>
				<a href="http://www.zhiguw.com">返回首页</a>
				</em>
			</h1>
			<form method="post" name="taobaocsv" id="taobaocsv" action="/taobao/ajax/item/save">
			<input name="goodsId"  value="${goods.id}" type="hidden">
			<input name="num"  value="${goods.aux.amount}" type="hidden">
			<input name="seller_id" value="63572" type="hidden">
            <input name="images" id="images" type="hidden">
            	<ul id="shoesform">
					<li hidden_attr="1">
						<label>产品类型：</label>
							<span>${catRef.thirdCatName}</span>
							<input name="cid" type="hidden" value="${catRef.thirdCatID }"/>
					</li>
                 </ul>
				<div id="proimg">
						<label>商品首图：</label>
						<div id="imglist">
						
							<ul class="selectimg">
								<c:forEach  items="${goods.images}"  var="image">
	                               <li class="imgsel">
	                               	<table cellpadding="0" cellspacing="0"><tbody><tr><td><img src="${image_server}${image.image}"></td></tr></tbody></table>
	                               </li>
							  	</c:forEach>
							</ul>
							
							<div id="sinotes">请点击上面列表中的图片，选择产品首图！（如果选错了，可以点击下面的列表图片，取消选择，再重选！）</div>
							
							<ul style="height:auto;" class="selectimg">
							<c:forEach begin="0" end="4" var="i">
								<li lang="${i}" class="hmeimg"><table cellspacing="0" cellpadding="0"><tbody><tr><td id="hme${i}"></td></tr></tbody></table></li>
							</c:forEach>
							</ul>
							
						</div>
				</div>
				<ul id="shoesform">
					<li>
						<label></label>
						<code>默认数据仅供参考，建议仔细核对相关属性，谨慎选择以防止属性错误导致被淘宝处罚！</code>
					</li>
					
                    <!-- 属性 -->
                    <c:forEach items="${props }"  var="prop">
                    
                    <c:choose>
                    	
                    	<c:when test="${prop.isEnumProp}">
                    		<c:choose>
                    			<c:when test="${!prop.multi}">
	                    				 <li hidden_attr="1"  class="remo">
						                    	<label>${prop.name }：</label>
						                    	    <select class="stdprop pinpai feature_${prop.pid}" name="props" >   
						  								<c:forEach items="${prop .propValues}"  var="propValue">                               
						                    		   			<option isparent="" value="${prop.pid }:${propValue.vid}" selected="selected"> ${propValue.name } </option>
						                    		   </c:forEach>
						                    		  <!--  <option value=""  class="pinpai_selfdefine">自定义</option> -->
						                    		   <option value="">请选择</option>
						                    	</select>
						                    	<span></span>
	                       				</li>
	                       		</c:when>
	                       		<c:when test="${!prop.isColorProp&&!prop.isSaleProp&&prop.multi}">
	                       					<li hidden_attr="1" class="remo">
												<label>${prop.name}：</label>
					                    		<ul>
					                    		<c:forEach items="${prop.propValues}"  var="propValue">         
					                    		     <li>
						                    			<input type="checkbox" class="feature_${propValue.vid}" value="${prop.pid }:${propValue.vid}" name="props">
						                    			<label>${propValue.name}</label>
					                    		   </li>
					                    		   </c:forEach>
					                    		</ul>
				                    		</li>
	                       		</c:when>
	                       	 </c:choose>
	                     </c:when >
	                       	 <c:otherwise>
	                       	 	<li hidden_attr="1" class="remo">
	                       	 		<label>${prop.name } :&nbsp;&nbsp;</label>
	                       	 		<input type="hidden" name="inputPids"  value="${prop.pid }"/>
	                       	 		<input class="feature_${prop.pid}" type="text" name="inputStr"  value=""/>
	                       	 	</li>
	                       	 </c:otherwise>
                        </c:choose>
                       </c:forEach>
                        
                        
                      <li hidden_attr="1">
                      	<label>商品价格：</label><input name="price"  value='<fmt:formatNumber value="${goods.maxPrice*1.2}" pattern="#.##"></fmt:formatNumber>' type="text"> 
                      	<em style="font-size:12px;font-style:normal;">默认在批发价的基础上加价20%</em>
						</li> 
						<li hidden_attr="1">
							<label>商家编码：</label>
							<input name="outerId" maxlength="40" value="${goods.name}&amp;${goods.id}" />
							<em style="font-size:12px;font-style:normal;">建议别修改此项，商家编码已加入干扰码，防止淘宝识别成同款。</em>
						</li>
					<li hidden_attr="1">
						<label>上架时间：</label>
						<ul>
							<li><input name="approveStatus" value="onsale" checked="checked" type="radio">立刻上架</li>
							<li><input name="approveStatus" value="schdule" type="radio">定时上架：
							<input id="datetimepicker" type="text" name="upDate">
							<select name="upHour"></select>时
							<select name="upMinute"></select>分 
							<link rel="stylesheet" type="text/css" href="/js/3rdparty/datetimepicker/jquery.datetimepicker.css"/ >
							<script type="text/javascript" src="/js/3rdparty/datetimepicker/jquery.datetimepicker.js"></script>
							<script type="text/javascript">
							 $(function(){
								 var d = new Date();
	                             var minute = d.getMinutes();
	                             var hours = d.getHours();
	                             var time = d.getTime();
	                             var nd = new Date(time+(15*24*60*60*1000));
								 $('#datetimepicker').datetimepicker({
									 	format: 'Y-m-d',
								        lang: 'zh',
								        datepicker: true,
								        timepicker: false,
								        hourStep: 1,
								        inputMask: true,
								        startDate:new Date(),
								        minDate:new Date(),
								        maxDate:nd,
								        closeOnDateSelect: true,
								       
								 });
								 
								    var h_options = "";
	                            	for(var i = 0;i<24;i++){
	                            		h_options += "<option value="+i+">"+i+"</option>";
	                            	}
	                            	$("select[name='upHour']").append(h_options).val(hours);
	                            	
	                            	var m_options = "";
	                            	for(var i = 0;i<60;i+=5){
	                            		m_options += "<option value="+i+">"+i+"</option>";
	                            	}
	                            	
	                            	$("select[name='upMinute']").append(m_options).val(minute-minute%5+5);
								 
							 })

                            </script>
							</li>
							<li><input name="approveStatus" value="instock" type="radio">放入仓库中</li>
						</ul>
					</li>
					<li>
						<label>宝贝名称：</label>
						<input name="title" size="80" maxlength="60" id="title" style="width:575px;" type="text" value="${goods.name }">
						<em id="TitleLen">可以输入30个字！</em>
					</li>
										<li>
						<label>运费承担：</label>
						<select name="freightPayer" id="freight_payer">
							<option value="buyer" selected="selected">买家承担</option>
							<option value="seller">卖家包邮</option>
						</select>
						<select name="postageId" id="postage_id">	
                            <option selected="selected" value="">-- 请选择运费模版：--</option>
                            						<c:forEach items="${deTemplates }" var="template">
                            							<option value="${template.templateId }">${template.name }</option>
                            							</c:forEach>
                            						</select>
						<a href="javascript:void(0)" rel="delivery" class="cache refresh_get" title="更新模板,会重新加载整个页面">刷新模板</a>  
					</li>
                    
                        
                    <!-- 颜色 -->
                    <c:forEach items="${props }"  var="prop">
                              <c:if test="${prop.isColorProp&&prop.isSaleProp }">                                                
		       				 	<li hidden_attr="2">
		                            <label>${prop.name }：</label>
		                            
		                            <ul>
		                              <c:forEach items="${prop .propValues}"  var="propValue">       
		                                 <li>
		                                    <input name="props" onclick="changeColorProp(this)" class="feature_${propValue.vid} colorProp" value="${prop.pid }:${propValue.vid}" type="checkbox">
		                                    <label><input name="${prop.pid }:${propValue.vid}_value" value="${propValue.name }" title="填写颜色别名" type="text"></label>
		                                </li>
		                                </c:forEach>
		                            </ul>
		                    </li>
                    	 </c:if>
                    </c:forEach>
                    <!-- 尺码 /身高-->
                    <c:forEach items="${props }"  var="prop">
                         <c:if test="${prop.isSaleProp &&!prop.isColorProp}">
                            <li hidden_attr="2">
	                          <label>${prop.name}：</label>
	                          
	                          <ul>
                              <c:forEach items="${prop .propValues}"  var="propValue">    
                                 <li>
                                    <input class="feature_${propValue.vid} saleProps" onclick="changeSaleProp(this)" name="props" value="${prop.pid }:${propValue.vid}" type="checkbox">
                                    <label><input name="${prop.pid }:${propValue.vid}_value" value="${propValue.name }" title="填写别名" type="text" /></label>
                                </li>
                               </c:forEach>
                              </ul>
                                                              
                        	</li>
                          </c:if>
                  </c:forEach>  
                    
                    <li>
                    	<div>
                    		<table id="sku_table">
                    		<thead>
                    			<tr class="thead">
                    				<td>颜色</td>
                    				<td>尺码/身高</td>
                    				<td>数量</td>
                    				<td>价格</td>
                    			</tr>
                    		</thead>
                    		<tbody>
                     			<c:forEach items="${skus}" var="sku" varStatus="index">
                    				<c:set value="${index.index}" var="total"/>
	                    			<tr class="${sku.propIdStr}">
	                    				<td>
	                    					<c:forEach items="${sku.models }" var="model">
	                    					<c:if test="${model.isSaleProp&&model.isColorProp }">
	                    						<span data="feature_${model.valueId}">${model.valueName }</span>
	                    					</c:if>
	                    					</c:forEach>
	                    				</td>
	                    				<td>
	                    				<c:forEach items="${sku.models }" var="model"  >
	                    					<c:if test="${model.isSaleProp&&!model.isColorProp }">
	                    						${model.valueName}
	                    					</c:if>
	                    				</c:forEach>
	                    				</td>
	                    				<td>
	                    					<input type="hidden"  class='input_class' name="skus[${index.index}].propIdStr" value="${sku.propIdStr}"/>
	                    					<input type="text"  class='input_class' name="skus[${index.index}].quality" value="${sku.quality}"/>
	                    				</td>
	                    				<td>
	                    					<input type="text" class='input_class' name="skus[${index.index}].price" value="${sku.price}"/>
	                    				</td>
	                    			</tr>
	                    		
                    			</c:forEach> 
                    		</tbody>
                    		</table>
                    		<input type="hidden" id="total" value="${total}"/>
                    	</div>
                    	
                    </li>      
                    <script type="text/javascript">
                    
                    // 单元格去重复，合并
                    	$(function(){
                    		var list = new Array();
                    		
                    		$(".saleProps").each(function(i,n){
                    			if(n.checked){
                    				list.push(n.value);
                    			}
                    		});
                    		var len = list.length;
                    		// sku 遍历处理
                    		var j;
                    		
                    		var list = $("#sku_table tbody tr td span");
                    		for(var i=0; i<list.length; i++){
                    			
                    			console.log(i);
                    			var td_span = $(list[i]);
                    			var class_name = td_span.attr("data");
                    			
                    			j=i+1;
                    			for(j;j<list.length;j++){
                    				
		                    		var td_span_next = $(list[j]);
		                    		var class_name_next = td_span_next.attr("data");
		                    		
		                    		if(class_name===class_name_next){
	                    				td_span_next.parent().remove();
	                    				td_span.parent().attr("rowspan",len);
		                    			
		                    		}else{
		                    			break;
		                    		}
		                    		
                    			}
		                    		i = j-1;
	                    			
                    		}
                    		
                    	})
                    	
                    </script>                       	
					<li>
						<label>宝贝文字描述：</label>
						<div id="bbmsinfo" style="float:left;width:800px;">
							<div id="bbmsform">
							<jsp:include page="../ueditor/index_taobao.jsp">
					 			<jsp:param name="desc" value="${goods.description }" />
					 		</jsp:include>
							</div>
						</div>
					</li>
					
					<li>
						<label></label>
						<div><span style="color:#3e3e3e;">您的当前淘宝图片空间总容量：
						<strong style="color: #f00">${userInfo.availableSpace}</strong>
						剩余：<strong style="color: #f00">${userInfo.remainingSpace}</strong></span></div>
					</li>
					<li>
						<label>店铺分类：</label>
						<dl class="seller_cat">
									<c:forEach items="${ shopCatsMap}"  var="catsMap">
                                           <dt><input disabled="disabled" name="seller_cids[]" value="${catsMap.key.cid }" type="checkbox"><span>${catsMap.key.name }</span></dt>
                                           <c:forEach items="${catsMap.value }" var="cat">     
                                                 <dd><input name="sellerCids" value="${cat.cid }" type="checkbox"><span>${cat.name }</span></dd>
                                          </c:forEach>
								</c:forEach>
                                <!--     <a href="javascript:void(0)" rel="delshopcache" class=" refresh_get" style="float:right" title="更新分类,会重新加载整个页面">刷新分类</a> -->                  
						</dl>
					</li>
					<li>
						<label></label>
						<input id="csvbutton" class="taobaocsv" value="确认发布到淘宝" type="button">
						<span style="color:#747474;float:left;padding-top:10px;padding-left:10px;">默认数据并不一定绝对正确，请尽量仔细检查核对！</span>
					</li>
				</ul>
			</form>
		</div>
	<div id="bottom"> 
	  <div id="bottom_box">
	<div style="float:right;bottom:0px;font-size:10px;color:#FFF">178</div>
  </div>
</div>

</body>
</html>
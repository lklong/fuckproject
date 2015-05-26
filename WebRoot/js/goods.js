/*此js文件，发布商品用*/
if (typeof zhigu == "undefined" || !zhigu) {
	var zhigu = {};
}
zhigu.goods = {};

zhigu.goods.defaultImageAmount = 1;
zhigu.goods.appendToUpimgul = function(showsrc,savesrc){
	var imgsize = $(".upimg").size();
	if(imgsize >= zhigu.goods.defaultImageAmount){
		dialog("上传图片数量已达上限！");
		return false;
	}
	$(".prebakimg").hide();
	var li  = "<li id='" + Math.random() + "' onmouseover='zhigu.goods.mouseover(this)' onmouseout='zhigu.goods.mouseout(this)'>";
		li += 	"<div class='imgbox' id='imgbox1'>";
		li +=		"<img class='upimg' imgId='0' src='" + showsrc.uri + "' savesrc='" + savesrc.uri + "' width='102px' height='102px'/>";
		li +=	"</div>";
		li +=	"<div class='fabubgtian disnone'><span class='ml5 cp' onclick='zhigu.goods.mleft(this)'>左移</span><span class='ml10 cp' onclick='zhigu.goods.mright(this)'>右移</span> <span class='ml10 cp' onclick='zhigu.goods.delimg(this)' >×</span></div>";
		li += "</li>";
	$("#upimgul").append(li);
}
zhigu.goods.priceInputCheck = function(obj){
	zhigu.cmn.restrictInputMoney(obj);
}
zhigu.goods.priceOnblur = function(obj){
	if(zhigu.goods.skuColumnLabel.length == 1){
		skuArr[$(obj).attr("colorIndex")].price = $(obj).val();
	}else{
		skuArr[$(obj).attr("colorIndex")].rele[$(obj).attr("sizeIndex")].price = $(obj).val();
	}
}
zhigu.goods.amountOnblur = function(obj){
	$(obj).val($(obj).val().replace(/\D/g,''));
	var value= $(obj).val();
	if(!value){
		value = 0;
	}
	if(zhigu.goods.skuColumnLabel.length == 1){
		skuArr[$(obj).attr("colorIndex")].amount = parseInt(value);
	}else{
		skuArr[$(obj).attr("colorIndex")].rele[$(obj).attr("sizeIndex")].amount = parseInt(value);
	}
	zhigu.goods.statAmount();
	//$("#sumAmount").html(statAmount());
}
zhigu.goods.mouseover = function(obj){
	$(obj).find(".fabubgtian").removeClass("disnone");
}
zhigu.goods.mouseout = function(obj){
	$(obj).find(".fabubgtian").addClass("disnone");
}
// 图片左移
zhigu.goods.mleft = function(obj){
	var curr = $(obj).parent().parent();//当前li
	var lis = $("#upimgul").children();
	var cindex = 0;
	var licount = lis.size();
	for(var i = 0 ; i < licount ;i++){
		if(curr.attr("id") == $(lis[i]).attr("id"))
			cindex = i;
	}
	if(cindex == 0)
		return;
	
	for(var i = 0 ; i < licount ;i++){
		document.getElementById("upimgul").removeChild(lis[i]);
	}
	for(var i = 0 ; i < licount ;i++){
		if(i == cindex - 1)
			document.getElementById("upimgul").appendChild(lis[cindex]);
		else if(i == cindex)
			document.getElementById("upimgul").appendChild(lis[cindex - 1]);
		else 
			document.getElementById("upimgul").appendChild(lis[i]);
	}
}
//图片右移
zhigu.goods.mright = function(obj){
	var curr = $(obj).parent().parent();//当前li
	var lis = $("#upimgul").children();
	var cindex = 0;
	var licount = lis.size();
	for(var i = 0 ; i < licount ;i++){
		if(curr.attr("id") == $(lis[i]).attr("id"))
			cindex = i;
	}
	if(cindex == licount - 1)
		return;
	//删除所有子元素
	for(var i = 0 ; i < licount ;i++){
		document.getElementById("upimgul").removeChild(lis[i]);
	}
	for(var i = 0 ; i < licount ;i++){
		if(i == cindex)
			document.getElementById("upimgul").appendChild(lis[cindex + 1]);
		else if(i == cindex + 1)
			document.getElementById("upimgul").appendChild(lis[cindex]);
		else 
			document.getElementById("upimgul").appendChild(lis[i]);
			
	}
}
// 删除图片
zhigu.goods.delimg = function(obj){
	$(obj).parent().parent().remove();
	if($(".upimg").size() == 0)
		$(".prebakimg").show();
}
//检查商品名长度
zhigu.goods.checkTitleLen = function(obj) {  
	var maxChars = 30;
	if ($(obj).val().length > maxChars)  $(obj).val($(obj).val().substr(0,maxChars));
	var curr = maxChars - $(obj).val().length;  
	$("#titleCount").html(curr); 
}
// 加载类目
zhigu.goods.loadCategory = function(obj,index){
	var category = $(obj).val();
	$(obj).nextAll("select").remove();
	// 清除旧数据
	$("#attributes_sku").html("<p class='title fl'>商品属性：</p><h1 class='red'>* 请先选择商品类别</h1>");
	try{
		skuArr = [];
		zhigu.goods.showArr();
	}catch(e){};
	
	if(!category){
		return;
	}
	var isparent = $(obj).find("option:selected").attr("isparent");
	if(isparent == "true"){
		ajaxSubmit("category/getCategory", {catagoryId:category}, function(data){
			var html = " <select onchange='zhigu.goods.loadCategory(this);' style='width: 120px;'><option value=''>请选择</option>";
			for(var i = 0 ; i < data.length ;i++){
				html += "<option isparent='" + data[i].isParent + "' value='" + data[i].id + "'>" + data[i].name + "</option>";
			}
			html+="</select>";
			$(obj).parent().append(html);
		}, "json");
	}else{
		// 子叶类目加载商品属性
		ajaxSubmit("/category/loadProperty", {"categoryId":category}, function(data){
			$("#attributes_sku").html(data);
		},"text");
	}
}
var skuArr = [];
zhigu.goods.loadPropertyInit = function(){
	zhigu.goods.skuColumnLabel = new Array();
	zhigu.goods.skuArr =[];
	
	$(".skudiv").each(function(index){
		// sku列标题
		zhigu.goods.skuColumnLabel[index] = $(this).attr("label");
	});
	
	//初始化js对象
	if(zhigu.goods.skuColumnLabel.length == 1){
		$(".skudiv0").find("input:checkbox").each(function(){
			skuArr.push({pid:$(this).attr('pid'),pname:$(this).attr('pname'),vid:$(this).attr('vid'),vname:$(this).attr('vname'),usename:$(this).attr('vname'),amount:0,price:0,isshow:0,rele:[]});
		});	
	}else if(zhigu.goods.skuColumnLabel.length == 2){//最多为2个销售属性
		$(".skudiv0").find("input:checkbox").each(function(){
			var ckArr = [];
			$(".skudiv1").find("input:checkbox").each(function(level){
				ckArr.push({pid:$(this).attr('pid'),pname:$(this).attr('pname'),vid:$(this).attr('vid'),vname:$(this).attr('vname'),usename:$(this).attr('vname'),amount:0,price:0,isshow:0,rele:[]});
			});
			skuArr.push({pid:$(this).attr('pid'),pname:$(this).attr('pname'),vid:$(this).attr('vid'),vname:$(this).attr('vname'),usename:$(this).attr('vname'),amount:0,price:0,isshow:0,rele:ckArr});
		});	
	}
	//点击事件
	$(".skudiv").each(function(index){
		$(this).find("input:checkbox").click(function(){
			if($(this).attr("checked") == "checked"){//show
				$(this).parent().addClass("edit");
				zhigu.goods.setShow(index,$(this).attr("vid"),1);
			}else{
				zhigu.goods.setShow(index,$(this).attr("vid"),0);
				$(this).parent().removeClass("edit");
			}
			zhigu.goods.showArr();
		});
	});
}
zhigu.goods.setShow = function(index,value,op){
	for(var i = 0; i < skuArr.length; i++){
		if(index == 0){
			if(value == skuArr[i].vid){
				skuArr[i].isshow = op;
			}
		}else{
			for(var j = 0; j < skuArr[i].rele.length; j++){
				if(value == skuArr[i].rele[j].vid){
					skuArr[i].rele[j].isshow = op;
				}
			}
		}
	}
}
// 显示sku表格
zhigu.goods.showArr = function() {
	var html = "";
	var tr_s = "<tr>";
	var tr_e = "</tr>";
	var td_1 = "";
	var td_2 = "";
	var td_3 = "";
	var td_4 = "";
	var td_5 = "";

	for (var i = 0; i < skuArr.length; i++) {
		if (skuArr[i].isshow == 1) {
			var rowspan = 0;
			var tr = "";
			if(zhigu.goods.skuColumnLabel.length==2){
					// 两个销售属性
				for (var j = 0; j < skuArr[i].rele.length; j++) {
					if (skuArr[i].rele[j].isshow == 1) {
						td_2 = "<td>" + skuArr[i].rele[j].usename + "</td>";
						var tprice = skuArr[i].rele[j].price>0?skuArr[i].rele[j].price:"";
						td_3 = "<td><input name='price' value='" + tprice + "' colorIndex='" + i + "' sizeIndex='" + j
								+ "' onkeyup='zhigu.goods.priceInputCheck(this);' onafterpaste='zhigu.goods.priceInputCheck(this);' maxlength='11' onblur='zhigu.goods.priceOnblur(this);'/></td>";
						var tamount = skuArr[i].rele[j].amount>0?skuArr[i].rele[j].amount:"";
						td_4 = "<td><input name='amount' value='" + tamount + "' colorIndex='" + i + "' sizeIndex='" + j
								+ "' onkeyup=\"this.value=this.value.replace(/\\D/g,'')\" onafterpaste=\"this.value=this.value.replace(/\\D/g,'')\" maxlength='6' onblur='zhigu.goods.amountOnblur(this);'/></td>";
						td_5 = "<td style='position:relative;'><a cindex='" + i + "' size='" + skuArr[i].rele[j].usename + "' sindex='" + j
								+ "' href='javascript:void(0)' onclick='batchset(this)' class='piliansezhijia'>批量设置</a></td>";
						if (rowspan == 0) {
							tr += td_2 + td_3 + td_4 + td_5 + tr_e;
						} else {
							tr += tr_s + td_2 + td_3 + td_4 + td_5 + tr_e;
						}
						rowspan++;
					}
				}
				// sku第一列
				if (rowspan > 0) {
					td_1 = "<td rowspan='"+rowspan+"'>" + skuArr[i].usename + "</td>";
					html += tr_s + td_1 + tr;
				}
			}else if(zhigu.goods.skuColumnLabel.length==1){
				// 只有一个销售属性
				var tprice = skuArr[i].price>0?skuArr[i].price:"";
				html += tr_s+"<td>" + skuArr[i].usename + "</td>"+"<td><input name='price' value='" + tprice + "' colorIndex='" + i 
				+ "' onkeyup='zhigu.goods.priceInputCheck(this);' onafterpaste='zhigu.goods.priceInputCheck(this);' maxlength='11' onblur='zhigu.goods.priceOnblur(this);'/></td>";
				var tamount = skuArr[i].amount>0?skuArr[i].amount:"";
				html +=  "<td><input name='amount' value='" + tamount + "' colorIndex='" + i 
				+ "' onkeyup=\"this.value=this.value.replace(/\\D/g,'')\" onafterpaste=\"this.value=this.value.replace(/\\D/g,'')\" maxlength='6' onblur='zhigu.goods.amountOnblur(this);'/></td>" +tr_e;
			}
		}
	}
	// 构建sku 的 table
	var table = "<table><thead><tr class='st2title'>";
	for(var i=0;i<zhigu.goods.skuColumnLabel.length;i++){
		table += "<th width='200'>"+zhigu.goods.skuColumnLabel[i]+"</th>";
	}
	if(html==""){//规格信息不完整
		html = "<tr><td colspan='"+(zhigu.goods.skuColumnLabel.length+3)+"'><h3 class='red'>请选择商品规格组成完整的商品规格信息！</h3></td></tr>";
	}
	table += "<th width='200'>价格<strong>*</strong></th><th width='200'>数量<strong>*</strong></th>"+(zhigu.goods.skuColumnLabel.length==1?"":"<th width='200'>操作</th>")+"</tr></thead><tbody >"
				+ html +"</tbody></table>";
	$("#scletabletbody").html(table);
	zhigu.goods.statAmount();
}
//商品总数统计
zhigu.goods.statAmount = function() {
	var sumAmount = 0;
	for (var i = 0; i < skuArr.length; i++) {
		if (skuArr[i].isshow == 1) {
			if(zhigu.goods.skuColumnLabel.length==2){
				for (var j = 0; j < skuArr[i].rele.length; j++) {
					if (skuArr[i].rele[j].isshow == 1) {
						sumAmount += skuArr[i].rele[j].amount;
					}
				}
			}else if(zhigu.goods.skuColumnLabel.length==1){
				sumAmount += skuArr[i].amount;
			}
		}
	}
	$("#sumAmount").html(sumAmount);
}
//加载商品数据
zhigu.goods.editLoadGoods = function(goodsId) {
	ajaxSubmit("goods/ajaxQueryGoods", {"goodsId" : goodsId}, function(msgBean) {
		var data = msgBean.data;
		//属性选中设置
		var properties = data.properties;
		for (var i = 0; i < properties.length; i++) {
			var p = properties[i];
			$("#attributes select[pid='" + p.propertyId + "']").val(p.propertyValueId);
			$("#attributes .only_input").val(p.propertyValueName);
			$("#attributes :checkbox[pid='" + p.propertyId + "'][vid='" + p.propertyValueId + "']").attr("checked", "checked");
		}
		//设置规格选择
		$(".skudiv0").find("input:checkbox").each(function(cindex) {
			var ckArr = [];
			$(".skudiv1").find("input:checkbox").each(function(sindex) {
				for (var i = 0; i < properties.length; i++) {
					var p = properties[i];
					if (p.sku && $(this).attr("vid") == p.propertyValueId) {
						$(this).attr("checked", "checked");
						skuArr[cindex].rele[sindex].usename = p.propertyValueName;
						$(this).parent().find(".yansetext").val(p.propertyValueName);
						$(this).parent().addClass("edit");

						//var sku = data.skus;
						for (var sk = 0; sk < data.skus.length; sk++) {
							var k = data.skus[sk];
							var skustr = skuArr[cindex].pid + ":" + skuArr[cindex].vid + "," + skuArr[cindex].rele[sindex].pid + ":" + skuArr[cindex].rele[sindex].vid;
							if (skustr == k.propertyStr) {
								//skuArr[cindex].rele[sindex].size = data[i].sizeSpecValueName;
								skuArr[cindex].rele[sindex].amount = k.amount;
								skuArr[cindex].rele[sindex].price = k.price;
								skuArr[cindex].rele[sindex].isshow = 1;
								skuArr[cindex].isshow = 1;
								for (var o = 0; o < skuArr.length; o++) {
									skuArr[o].rele[sindex].isshow = 1;
								}
							}
						}
					}
				}
			});
			//skuArr.push({pid:$(this).attr('pid'),pname:$(this).attr('pname'),vid:$(this).attr('vid'),vname:$(this).attr('vname'),usename:$(this).attr('vname'),amount:0,price:0,isshow:0,rele:ckArr});
			for (var i = 0; i < properties.length; i++) {
				var p = properties[i];
				if (p.sku && $(this).attr("vid") == p.propertyValueId) {
					$(this).attr("checked", "checked");
					skuArr[cindex].usename = p.propertyValueName;
					$(this).parent().find(".yansetext").val(p.propertyValueName);
					$(this).parent().addClass("edit");
					
					if(zhigu.goods.skuColumnLabel.length==1){
						for (var sk = 0; sk < data.skus.length; sk++) {
							var k = data.skus[sk];
							var skustr = skuArr[cindex].pid + ":" + skuArr[cindex].vid;
							if (skustr == k.propertyStr) {
								skuArr[cindex].amount = k.amount;
								skuArr[cindex].price = k.price;
								skuArr[cindex].isshow = 1;
							}
						}
					}
				}
			}
		});
		zhigu.goods.showArr();
		zhigu.goods.statAmount();
	}, "json");
}
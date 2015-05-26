$(function(){
	
	//数据返显
	function initShowData(){
		var converts = $.parseJSON('${converts}');
		for(var i=0;i<converts.length;i++){
			
			var isMulti = converts[i].isMulti;
			var isSaleProp = converts[i].isSaleProp;
			var isEnumProp = converts[i].isEnumProp;
			var isColorProp = converts[i].isColorProp;
			
			console.log(isColorProp);
			
			// 下拉处理
			if(isEnumProp&&!isMulti){
				$(".feature_"+converts[i].propId).val(converts[i].propId+":"+converts[i].valueId);
			}else if(isMulti||isColorProp){// 多选处理
				$(".feature_"+converts[i].valueId).attr("checked",true);
			}
		}
	}

	// 上架时间初始化datetimepicker日期控件初始化
	function initItemUpTime(){
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
	}
	
	 // 单元格去重复，合并
	function initSkuTable(){
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
	}
	
	initShowData();
	initItemUpTime();

})
$(function(){
	
	/*
	 * 
	 * 在需要的地方加入以下节点，引入area.js,调用init(area)即可area格式如下：_area的json格式
		<div>
			<select id="sel_province"></select>
			<select id="sel_city"><option>请选择</option></select>
			<select id="sel_district"><option>请选择</option></select>
		</div>
	 */
	
	
	var _area = {
		provinceId:"510000",
		cityId:"510100",
		districtId:"510106"
	};
	
	// 页面初始化
	init(_area);
	
	function init(area){
		if(area.cityId){
			// 初始化默认数据
			selectDefaultArea(area);
		}else{
			// 初始化省数据
			initProvince();
		}
	}
	
	function initProvince(){
		var $sel_province = $("#sel_province");
		var options = ajaxGetArea(0);
		$sel_province.empty().append("<option>请选择</option>").append(options);
	}
	
	// select的chang事件
	$("select").live("change",function(){
		
		// 当前dom的节点信息
		var sel_id = this.id;
		var parentId = this.value;

		// 区域dom节点
		var $province = $("#sel_province"); 
		var $city = $("#sel_city"); 
		var $district = $("#sel_district"); 
		
		// 追加的数据
		var options = "";
		if(sel_id !== "sel_distict"){
			var options = ajaxGetArea(parentId);
		}
		
		// 业务
		switch (sel_id) {
		case "sel_province":
			
			// 清空
			$city.empty().append("<option>请选择</option>");
			$district.empty().append("<option>请选择</option>");
			
			// 加数据
			$city.append(options);
			break;
		case "sel_city":
			
			// 清空
			$district.empty().append("<option>请选择</option>");
			
			// 加数据
			$district.append(options);
			break;
		case "sel_distict":
			
			break;
		default:
			break;
		}
	});
	
	// 默认选中事件
	function selectDefaultArea(area){
		// 填充数据
		ajaxGetDefaultArea(area);
	}
	
	// 获取后台数据,组装成option
	function ajaxGetArea(parentId){
		$.ajaxSetup({
	        async: false,
	    });
		var options = ""
		$.get("/area/"+parentId,function(msgBean){
			if(msgBean.code === 1){
				var areas = msgBean.data;
				for(var i = 0;i<areas.length;i++){
					options += "<option value="+areas[i].id+">"+areas[i].name+"</option>"
				}
			}
		})
		return options;
	}
	
	// 初始化默认区域数据
	function ajaxGetDefaultArea(area){
		$.get("/area/default",area,function(msgBean){
			if(msgBean.code === 1){
				var map = msgBean.data;
				
				var provinces = map[area.provinceId];
				var cities = map[area.cityId];
				var districts = map[area.districtId];
				
				var p_opts = combinAreaData(provinces,area.provinceId);
				var c_opts = combinAreaData(cities,area.cityId);
				var d_opts = combinAreaData(districts,area.districtId);
				
				// 区域dom节点
				var $province = $("#sel_province"); 
				var $city = $("#sel_city"); 
				var $district = $("#sel_district");
				
				// 填充数据
				$province.empty().append(p_opts);
				$city.empty().append(c_opts);
				$district.empty().append(d_opts);
			}
		});
	}
	
	// 组合options,选中默认项
	function combinAreaData(areas,areaId){
		var options = "<option>请选择</option>";
		for(var i = 0;i<areas.length;i++){
			if(areas[i].id === areaId){
				options += "<option selected value="+areas[i].id+">"+areas[i].name+"</option>"
			}else{
				options += "<option value="+areas[i].id+">"+areas[i].name+"</option>"
			}
		}
		return options;
	}
})
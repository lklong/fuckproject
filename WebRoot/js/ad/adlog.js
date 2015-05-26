$(function() {
	//用户中心tab切换方法
	getPageDatas(1);

})
var group;
function getPageDatas(pageNo) {
	var url = "Admanage/user/adlog";
	var val = {
		pageNo : pageNo
	}
	$.post(url, val, function(pageBean) {
		var html = "";
		for (var i = 0; i < pageBean.datas.length; i++) {
			var data = pageBean.datas[i];
			html += "<tr>" + "<td>" + (new Number(i) + 1) + "</td>" + "<td>" + new Date(data.orderDate).format('yyyy-MM-dd') + "</td>"
					+ "<td  width=\"13%\" align=\"center\" style=\"max-width: 150px;word-break:break-all;\" title='" + data.adTitle
					+ "'><div style=\"white-space: nowrap;overflow:hidden;text-overflow:ellipsis;height:20px;word-break:break-all;max-width: 180px;\">" + data.adTitle + "</div></td>"
			if (data.discountprice == null || data.discountprice == 0) {
				html += "<td>" + data.theoryPrice + "</td>"
			} else {
				html += "<td>" + data.actualPayMoeny + "</td>"
			}
			if (Math.ceil((data.endDate - new Date()) / 1000 / 60 / 60 / 24) < 0 && data.paymentStatus == 0) {
				html += "<td><a href=\"javajavascript:void(0);\"  >已过期</a></td>"
			} else if ((data.status == 1 && data.paymentStatus == 0)) {
				html += "<td><a href=\"javajavascript:void(0);\"  >不可订购</a></td>"
			} else if (data.paymentStatus == 0) {
				html += "<td><a href=\"supplier/ad/adpay?id=" + data.id + "\" >购买</a></td>"
			} else if (data.paymentStatus == 1) {
				html += "<td><a href=\"javajavascript:void(0);\"  >已付款</a></td>"
			}
			if (data.auditStatus == 0) {
				html += "<td><a href=\"javajavascript:void(0);\"  >审核中</a></td>"
			}else if (data.auditStatus == 1) {
				html += "<td><a href=\"javajavascript:void(0);\"  >通过</a></td>"
			}else if (data.auditStatus == 2) {
				html += "<td><a href=\"javajavascript:void(0);\"  >不通过</a></td>"
			}
			html += "<td><a href=\"supplier/ad/seeAdInfo?id=" + data.id + "\"  >查看</a></td>" + "</tr>"
		}
		$("table tbody").html(html);
		zhigu.cmn.setPage(pageBean, getPageDatas, 'paginationContainer');
	});

};

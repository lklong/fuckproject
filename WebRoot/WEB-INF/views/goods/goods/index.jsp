<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="${applicationScope.basePath}" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>全部货源</title>
<style type="text/css">
.selected_red {
	color: red !important;
}
</style>
</head>
<body>
	<div class="mainbody">
		<div class="mt10 ">
			<div class="f14 fwryh cb5b5b5 dituabiao fl">
				<img src="img/ditubiao.png" class="ver_ali mr10" />
				首页> 全部货源 > <a href="goods/list?categoryId=${paramCategory.id }">${paramCategory.name }</a>
			</div>
		</div>
		<div class="clear"></div>
		<div class="souyoufeileitop">
			<div class="fwryh souyoufeileinrdi">
				所有分类：共<span class="cf86666">${page.totalRow } </span>件宝贝
			</div>
			<div class="leimu">
				<div class="leimuTitle">
					<img src="img/leimutubiao.png" class="mr5" />类目
				</div>
				<div id="categoryDiv">
					<c:forEach items="${childCategories }" var="c">
						<a href="javascript:void(0)" cid="${c.id }"
							onclick="categorySel(this)">${c.name }</a>
					</c:forEach>
				</div>
				<br style="clear: both;" />
			</div>

			<div class="leimu">
				<div class="leimuTitle">
					<img src="img/leimutubiao.png" class="mr5" />属性
				</div>
				<div class="shuxin">
					<c:forEach items="${properties }" var="pd">
						<c:if test="${pd.search }">
							<div>
								<a href="javascript:void(0)">${pd.name }</a>
								<ul class="disnone shuximovernr">
									<li onclick="propertySel(this)" pid="${pd.id }" key="0">不限</li>
									<c:forEach items="${pd.values }" var="pv">
										<li onclick="propertySel(this)" pid="${pd.id }"
											key="${pd.id }:${pv.id}">${pv.name }</li>
									</c:forEach>
								</ul>
							</div>
						</c:if>
					</c:forEach>
				</div>
				<br style="clear: both;" />
			</div>
			<ul class="sectednr" id="showProperties">
			</ul>
		</div>
		<div class="xuanzhepaixu mt20 f12">
			<div class="bsbSortDiv" style="width: 50px">
				<div>排序</div>
			</div>
			<div class="bsbSortDiv">
				<div>最新</div>
				<div>
					<span class="sortUp_1" onclick="sort(this,9)"></span> <span
						class="sortDown_2" onclick="sort(this,10)"></span>
				</div>
			</div>
			<div class="bsbSortDiv">
				<div>价格</div>
				<div>
					<span class="sortUp_1" onclick="sort(this,7)"></span> <span
						class="sortDown_1" onclick="sort(this,8)"></span>
				</div>
			</div>
			<div class="bsbSortDiv">
				<div>人气</div>
				<div>
					<span class="sortUp_1" onclick="sort(this,3)"></span> <span
						class="sortDown_1" onclick="sort(this,4)"></span>
				</div>
			</div>
			<div class="bsbSortDiv">
				<div>收藏</div>
				<div>
					<span class="sortUp_1" onclick="sort(this,11)"></span> <span
						class="sortDown_1" onclick="sort(this,12)"></span>
				</div>
			</div>
		</div>


		<div class="shopGoodsListBox" id="goodsList">
			<jsp:include page="items.jsp" />
		</div>
</div>
		<form action="goods/ajaxShoe" id="shoeForm" method="post">
			<input name="categoryId" id="categoryId" type="hidden" value="${categoryId }"> 
			<input name="sort" id="sort" type="hidden" value="10">
			<input name="goodsName" id="goodsName" type="hidden" value="">
			<input name=pageNo id="pageNo" type="hidden" value="1">
		</form>

		<script type="text/javascript">
if (typeof zhigu == "undefined" || !zhigu) {
    var zhigu = {};
}
$(document).ready(function() {
	// 瀑布流分页加载数据 START
	zhigu.high = 0;//初始化滚动条总长
	zhigu.top = 0;//初始化滚动条的当前位置
	
	$(window).scroll(function() {//定义滚动条位置改变时触发的事件。
		zhigu.high = $(document).height();//得到滚动条总长，赋给high变量
		zhigu.top = $(this).scrollTop();//得到滚动条当前值，赋给top变量
	});
	zhigu.addPageData = function() {
		if (zhigu.top > zhigu.high -1600 && zhigu.high>0){
			if(zhigu.pageNo==zhigu.totalPage){// 最后一页防止重复加载
				clearInterval(addDataInterval);
				zhigu.log("已加载到最后一页：totalPage = "+zhigu.totalPage);
				return;
			}
			var cpageNo = parseInt($("#pageNo").val()) + 1;//页码+1
			zhigu.log("加载数据：pageNo = "+cpageNo);
			$("#pageNo").val(cpageNo);
			ajaxSubmit("goods/ajaxShoe", $("#shoeForm").serialize(), function(data) { 
				$("#goodsList").append(data);
			}, "text");
			zhigu.high = 0;//恢复滚动条总长，因为scroll事件一触发，又会得到新值，不恢复的话可能会造成判断错误而再次加载
			zhigu.top = 0;//原因同上。
		}
	}
	var addDataInterval = setInterval("zhigu.addPageData()",1000);
	// 瀑布流分页加载数据 END
});

//setInterval(function(){console.log(1);}, 2000);//每隔2秒钟调用一次函数来判断当前滚动条位置。
// $(window).scroll(function() {
// 	var scrollTop = $(this).scrollTop();
// 	var scrollHeight = $(document).height();
// 	var windowHeight = $(this).height();
// 	if ((scrollTop + windowHeight) == scrollHeight - 500) {
// 		var cpageNo = $("#pageNo").val() + 1;//页码+1
// 		zhigu.log(cpageNo);
// 		$("#pageNo").val(cpageNo);
// 		ajaxSubmit("goods/ajaxShoe", $("#shoeForm").serialize(), function(data) {
// 			zhigu.pageAjaxSuccess(data);
// 		}, "text");
// 	}
// });
function closeSel(obj) {
	$(obj).parent().remove();
	search();
}
//选择类别
function categorySel(obj) {
	$("#categoryDiv a").removeClass("selected_red");
	$(obj).addClass("selected_red");
	search();
}
//选择属性
function propertySel(obj) {
	$(obj).parent().hide();

	var pid = $(obj).attr("pid");
	var key = $(obj).attr("key");
	var text = $(obj).text();

	if (key == 0) {//删除选择
		$("#" + pid).remove();
	} else {
		var div = "<div key='" + key + "' class='cha' onclick='closeSel(this)' style='cursor: pointer;'>×</div> " + text;
		var selected = $("#showProperties [id='" + pid + "']").size();
		if (selected > 0) {
			$("#" + pid).html(div);
		} else {
			var li = "<li id='" + pid + "'>" + div + "</li>";
			$("#showProperties").append(li);
		}
	}
	//选择查询
	search();
}

function search() {
	//类目设置
	var categoryId = $("#categoryDiv .selected_red").attr("cid");
	if (categoryId != undefined)
		$("#categoryId").val(categoryId);

	if ($("#showSearch").html() == "商品") {
		$("#goodsName").val($("#inputName").val());
	}
	//属性
	$("#shoeForm input[name='property']").remove();
	$(".cha").each(function() {
		$("#shoeForm").append("<input name='property' type='hidden' value='" + $(this).attr("key") + "'/>");
	});
	$("#pageNo").val(1);//页码重置为1
	ajaxSubmit("goods/ajaxShoe", $("#shoeForm").serialize(), function(data) {
		zhigu.pageAjaxSuccess(data);
	}, "text");
}
zhigu.pageAjaxSuccess = function(data) {
	$("#goodsList").html("");
	$("#goodsList").append(data);
}
function sort(obj, sort) {
	$(".xuanzhepaixu span").each(function() {
		var cla = $(this).attr("class");
		if (cla.indexOf("sortUp") != -1) {
			$(this).attr("class", "sortUp_1");
		}
		if (cla.indexOf("sortDown") != -1) {
			$(this).attr("class", "sortDown_1");
		}
	});
	if ($(obj).attr("class").indexOf("sortUp") != -1) {
		$(obj).attr("class", "sortUp_2");
	}
	if ($(obj).attr("class").indexOf("sortDown") != -1) {
		$(obj).attr("class", "sortDown_2");
	}
	$("#sort").val(sort);
	search();
}

//分享代码
var shareid = "fenxiang";
var shareURL = "";
var shareTitle = "";
var shareContent = "";
(function() {
	var a = {
		url : function() {
			return encodeURIComponent(shareURL)
		},
		title : function() {
			return encodeURIComponent(shareTitle)
		},
		content : function(d) {
			if (shareContent) {
				return encodeURIComponent(shareContent)
			}
			return encodeURIComponent(shareTitle)
		},
		setid : function() {
			if (typeof (shareid) == "undefined") {
				return null
			} else {
				return shareid
			}
		},
		kaixin : function() {
			window.open("http://www.kaixin001.com/repaste/share.php?rtitle=" + this.title() + "&rurl=" + this.url() + "&rcontent=" + this.content(this.setid()))
		},
		renren : function() {
			window.open("http://share.renren.com/share/buttonshare.do?link=" + this.url() + "&title=" + this.title())
		},
		sinaminiblog : function() {
			window.open("http://v.t.sina.com.cn/share/share.php?url=" + this.url() + "&title=" + this.title() + "&content=utf-8&source=&sourceUrl=&pic=")
		},
		baidusoucang : function() {
			window.open("http://cang.baidu.com/do/add?it=" + this.title() + "&iu=" + this.url() + "&dc=" + this.content(this.setid()) + "&fr=ien#nw=1")
		},
		taojianghu : function() {
			window.open("http://share.jianghu.taobao.com/share/addShare.htm?title=" + this.title() + "&url=" + this.url() + "&content=" + this.content(this.setid()))
		},
		wangyi : function() {
			window.open("http://t.163.com/article/user/checkLogin.do?source=%E7%BD%91%E6%98%93%E6%96%B0%E9%97%BB%20%20%20&link=" + this.url() + "&info=" + this.content(this.setid()))
		},
		qqzone : function() {
			window.open('http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url=' + this.url() + '&title=' + this.title())
		},
		pengyou : function() {
			window.open('http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?to=pengyou&url=' + this.url() + '&title=' + this.title())
		},
		douban : function() {
			window.open("http://www.douban.com/recommend/?url=" + this.url() + "&title=" + this.title() + "&v=1")
		},
		qqweibo : function() {
			var _t = encodeURI(shareTitle);
			var _url = encodeURI(shareURL);
			var _appkey = encodeURI("appkey");
			var _u = 'http://v.t.qq.com/share/share.php?title=' + _t + '&url=' + _url + '&appkey=' + _appkey;
			window.open(_u);
		}
	};
	window.share = a
})();
//jiathis分享
var jiathis_config = {};
$(function() {
	// 分享
	$(".goodsListBoxes").each(function() {
		$(this).mouseenter(function() {
			var share = $(this).find(".fengXiangButtonDiv");
			jiathis_config = {
				url : "http://www.zhiguw.com/" + share.attr("shareurl"),
				title : share.attr("sharetitle"),
				summary : share.attr("sharetitle"),
			}
		});
	});
	$(".renren").click(function() {
		setShare(this);
		share.renren();
	});
	$(".xinlang").click(function() {
		setShare(this);
		share.sinaminiblog();
	});
	$(".douban").click(function() {
		setShare(this);
		share.douban();
	});
	$(".kaixin").click(function() {
		setShare(this);
		share.kaixin();
	});
	$(".taojianghu").click(function() {
		setShare(this);
		share.taojianghu();
	});
	$(".wangyi").click(function() {
		setShare(this);
		share.wangyi();
	});
	$(".qqzone").click(function() {
		setShare(this);
		share.qqzone();
	});
	$(".baidusoucang").click(function() {
		setShare(this);
		share.baidusoucang();
	});
	$(".tengxunweibo").click(function() {
		setShare(this);
		share.qqweibo();
	});
	$(".qqpengyou").click(function() {
		setShare(this);
		share.pengyou();
	});
});
function setShare(obj) {
	shareURL = "http://www.zhiguw.com/" + $(obj).parent().parent().parent().attr("shareurl");
	shareTitle = "【智谷同城货源网】" + $(obj).parent().parent().parent().attr("sharetitle");
}
//下载数据包
function downloadDatas(goodsID, obj) {
	var downloadPath = $(obj).prop("href");
	if (downloadPath == null || downloadPath == "") {
		$.ajax({
			url : "/goods/user/downloadDatas",
			data : {
				"goodsID" : goodsID
			},
			dataType : "json",
			async : false,
			success:function(msgBean){
				if(msgBean.code == zhigu.code.success){
					$(obj).prop("href", "http://www.zhiguw.com/" + msgBean.data);
					return;
				}else{
					layer.alert(msgBean.msg);
				}
			},
			error : function() {
				//dialog("下载失败！");
				return false;
			}
		});
	}
}
</script>
<script type="text/javascript"
	src="http://v3.jiathis.com/code/jia.js?uid=1" charset="utf-8"></script>
</body>
</html>
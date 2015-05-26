<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>充值</title>
<link href="css/chongzhi.css" rel="stylesheet" type="text/css" />
<link href="css/zuce.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div class="rightContainer">
    	<!--// 标题 //-->
        <h3 class="rc_title">
        	网上充值<a href="user/home">我的主页</a>
        </h3>
        <!--// 内容框 //-->
		<div class="rc_body">
        	<!--// tab切换条 //-->
            <div id="userCommTab" class="userCommTab">
            	<ul>
                	<li><a href="javascript:void(0);" class="uctSelected">网上充值</a></li>
                </ul>
            </div>
            <div id="userContents" class="userContents">
            	<!--// 内容1 //-->
		<div class="body_center2">
			<div class="zhifubaobox">

				<c:choose>
					<c:when test="${hasPaypasswd }">
						<div class="zhifubaoform">
							<div class="xianXiaTitle">在线充值</div>
							<div class="zfbBox">
            	<form action="/user/recharge/pay" id="rechargeForm" method="post"  target="_blank">
								<h2 class="ml50" >
									您正在为智谷同城货源网账户<font color="#ff3300"><strong>
											${auth.username } </strong></font>充值
								</h2>
								<div class="formdiv2 mt5 ml50">
									支付金额：<input type="text" id="money" name="money" onkeyup="zhigu.cmn.restrictInputMoney(this);" />
								</div>
								<div class="ml50">
									<span class="red ml10" id="e_msg"
										style="color: #ff3300; padding: 5px;"></span>
								</div>
								<div class="formdiv1 mt20 mb20 ml50"
									style="color: #666; font-size: 14px;">
									充值类型：<input type="radio" name="rechargeType" value="1"
										checked="checked" /><img class="ml20" src="img/zhifubao.jpg" />
								</div>
								<div class="ml50">
									<input class="zhifusub mt10 mb10" type="button"
										onclick="rechargeForm()" value="充值" />
								</div>
						</form>
							</div>
<!-- 							<div > -->
<!-- 								<div class="xianXiaTitle">线下转账</div> -->
<!-- 								<div class="xianXiaTxt"> -->
<!-- 									线下转账后请一定与我们财务核算清算中心联系，电话/传真<font color="#ff3300">“028-65336799 -->
<!-- 										”</font>财务企业QQ：<a target="_blank" -->
<!-- 										href="http://wpa.qq.com/msgrd?v=3&uin=2880623698&site=qq&menu=yes"><img -->
<!-- 										src="http://www.sunkf.net/codes/one/images/q_1.gif" border="0" -->
<!-- 										alt="点击咨询" title="点击咨询" style="margin-bottom: -5px"></a> -->
<!-- 								</div> -->
<!-- 								<table class="bankTable"> -->
<!-- 									<tr> -->
<!-- 										<th>银行</th> -->
<!-- 										<th>帐号</th> -->
<!-- 										<th>上传凭证</th> -->
<!-- 									</tr> -->
<!-- 									<tr> -->
<!-- 										<td id="gsBankName">中国工商银行</td> -->
<!-- 										<td><strong id="gsBankNum">6222 0244 0206 1545 -->
<!-- 												053</strong></td> -->
<!-- 										<td><input id="gsBank" type="file" name="file" -->
<!-- 											onchange="changeUpFile( this )" /></td> -->
<!-- 									</tr> -->
<!-- 									<tr> -->
<!-- 										<td id="jsBankName">中国建设银行</td> -->
<!-- 										<td><strong id="jsBankNum">6217 0038 1003 2231 -->
<!-- 												097</strong></td> -->
<!-- 										<td><input id="jsBank" type="file" name="file" -->
<!-- 											onchange="changeUpFile(this )" /></td> -->
<!-- 									</tr> -->
<!-- 									<tr> -->
<!-- 										<td id="jtBankName">交通银行</td> -->
<!-- 										<td><strong id="jtBankNum">6222 6205 3000 2653 -->
<!-- 												129</strong></td> -->
<!-- 										<td><input id="jtBank" type="file" name="file" -->
<!-- 											onchange="changeUpFile(this)" /></td> -->
<!-- 									</tr> -->
<!-- 									<tr> -->
<!-- 										<td id="zgBankName">中国银行</td> -->
<!-- 										<td><strong id="zgBankNum">6217 8831 0000 0252 -->
<!-- 												290</strong></td> -->
<!-- 										<td><input id="zgBank" type="file" name="file" -->
<!-- 											onchange="changeUpFile(this)" /></td> -->
<!-- 									</tr> -->
<!-- 									<tr> -->
<!-- 										<td id="zxBankName">中信银行</td> -->
<!-- 										<td><strong id="zxBankNum">6217 7110 0055 3261</strong></td> -->
<!-- 										<td><input id="zxBank" type="file" name="file" -->
<!-- 											onchange="changeUpFile(this)" /></td> -->
<!-- 									</tr> -->
<!-- 									<tr> -->
<!-- 										<td colspan="3"><h3> -->
<!-- 												开户名：<font color="#ff3300">潘玉强</font> -->
<!-- 											</h3></td> -->
<!-- 									</tr> -->
<!-- 								</table> -->
<!-- 								<div class="xianXiaTitle">凭证明细</div> -->
<!-- 								<table class="bankTable" id="tuTable"> -->
<!-- 									<tr> -->
<!-- 										<th>时间</th> -->
<!-- 										<th>凭证图</th> -->
<!-- 									</tr> -->
<%-- 									<c:forEach items="${ offlinetransferaccountsList}" --%>
<%-- 										var="offlinetransferaccounts"> --%>
<!-- 										<tr> -->
<%-- 											<td>${offlinetransferaccounts.createDateFormat }</td> --%>
<!-- 											<td><img class="pzImg" -->
<%-- 												realFileName="${ offlinetransferaccounts.realFileName }" --%>
<%-- 												src="${ offlinetransferaccounts.filePath}" --%>
<!-- 												style="max-width: 150px;" /></td> -->
<!-- 										</tr> -->
<%-- 									</c:forEach> --%>
	
<!-- 								</table> -->
<!-- 							</div> -->
						</div>
					</c:when>
					<c:otherwise>
						<div class="chongzhi1">
							<div class="chongzhitop">为保障您账户资金安全，请先做以下设置：</div>
							<div class="chongzhibot">
								<img class="fl" src="img/suo.jpg" />
								<p class="czbot1">
									- 您尚未设置支付密码，请先设置：<a href="user/security/paymentpwd">支付密码 >></a>
								</p>
								<p class="czbot2">支付密码：使用账户余额、资金提现、确认收货时使用</p>
							</div>
						</div>
					</c:otherwise>
				</c:choose>

				<br style="clear: both;" />
			</div>
		</div>
     </div>
            <br style="clear:both;" />
        </div>
    </div>
<script type="text/javascript">
		function rechargeForm() {
			var money = $("#money").val();
			if(zhigu.cmn.moneyReg(money)){
				$("#rechargeForm").submit();
				layer.alert("<a href='/user/acc/rechargelist'>去查看充值信息 >></a>",-1,function(){
					window.location.href = "/user/acc/rechargelist";
				});
			}else{
				$("#e_msg").html("请填写正确的充值金额！");
			}
		}
		function changeUpFile(me) {
			me = $(me);
			var fileName = getFileRealName(me.val());

			if (!checkFileExtName(fileName)) {
				return;
			}

			var myName = $(".pzImg");
			for (var i = 0; i < myName.length; i++) {
				var c = myName[i];
				c = $(c);
				if (getFileRealName(fileName) == getFileRealName(c
						.attr("realFileName"))) {
					rt = false;
					alert("重名");
					return;
				}

			}

			var meId = me.attr("id");
			var bankNum = $("#" + meId + "Num").html();
			var bankName = $("#" + meId + "Name").html();
			var tuTable = $("#tuTable");

			$.ajaxFileUpload({

						url : "/user/Offlinetransferaccounts/offlinePay",
						fileElementId : meId + "",
						dataType : "json",
						data : "bankNum=" + bankNum + "&bankName=" + bankName,
						success : function(data) {
							tuTable
									.append('<tr><td >'
											+ data.data.createDateFormat
											+ '</td><td><img class="pzImg" realFileName="'+ data.data.realFileName +'" id="test11" src="'+ data.data.filePath +'" style="max-width: 150px;"/></td></tr>');
						}
					});

		}

		function getFileRealName(filePath) {

			var fileName = filePath.substring(filePath.lastIndexOf("\\") + 1,
					filePath.length);
			return fileName;
		}

		function checkFileExtName(value) {
			var rt = false;
			var extReg = /.jpg$|.png|.gif$/;

			if (value == null) {
				alert("请选择上传文件");
			}
			rt = extReg.test(value);
			if (!rt) {
				alert("只能上传jpg,png,gif图片");
			}

			return rt;
		}

		

	</script>

</body>
</html>
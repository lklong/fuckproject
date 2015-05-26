<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="${applicationScope.basePath}" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>绑定银行卡</title>
</head>
<body>
	<div class="body_center2 fl p10 ml10">
		<div class="chongzhititle">
			<h4>绑定银行卡</h4>
		</div>

		<div class="shezhimima2">
			<div class="shemiform">
			<div style="margin-bottom: 10px;"><span id="tip_msg" ></span></div>
				<table>
					<c:if test="${not empty account.bankNo }">
						<tr>
							<td>原银行卡主：</td>
							<td>${account.bankCardMaster }</td>
						</tr>
						<tr>
							<td>原银行卡号：</td>
							<td>${account.bankNo }</td>
						</tr>
						<tr><td colspan="2">-----------------------------------------------------</td></tr>
					</c:if>
					<tr>
						<td>手机号码：</td>
						<td>${auth.phone }</td>
					</tr>
					<tr>
						<td>验证码：</td>
						<td><input id="captcha" class="shoujitxt fl" type="text" autocomplete="off" maxlength="6"/> <input class="shoujibut fl" style="cursor: pointer;"
							onclick="sendCaptcha(this)" type="button" value="发送验证码" /></td>
					</tr>
					<tr><td colspan="2"><font color="red"> * 持卡人和银行卡必须正确，否则申请提现时不能成功。</font></td></tr>
					<tr>
						<td>持卡人：</td>
						<td><input class="shoujitxt fl" type="text" id="bankCardMaster" maxlength="20"/></td>
					</tr>
					<tr>
						<td>银行卡号：</td>
						<td><input class="shoujitxt fl" type="text" id="bankNo" maxlength="19"/></td>
					</tr>
					<tr>
						<td>所属银行：</td>
						<td width="700px;">
							<ul>
								<li>
									<span><input type="radio" value="工商银行" name="bankName" >中国工商银行</span>
									<span><input type="radio" value="农业银行" name="bankName" >中国农业银行</span>
									<span><input type="radio" value="招商银行" name="bankName" >招商银行</span>
									<span><input type="radio" value="建设银行" name="bankName" >中国建设银行</span>
									<span><input type="radio" value="中国银行" name="bankName" >中国银行</span>
									<span><input type="radio" value="邮政储蓄银行" name="bankName" >中国邮政储蓄银行</span>
								</li>
								<li>
							<span><input type="radio" value="浦发银行" name="bankName" >浦发银行</span>
							<span><input type="radio" value="广发银行" name="bankName" >广发银行</span>
							<span><input type="radio" value="民生银行" name="bankName" >中国民生银行</span>
							<span><input type="radio" value="平安银行" name="bankName" >平安银行</span>
							<span><input type="radio" value="光大银行" name="bankName" >中国光大银行</span>
							<span><input type="radio" value="兴业银行" name="bankName" >兴业银行</span>
							</li>
							<li>
							<span><input type="radio" value="中信银行" name="bankName" >中信银行</span>
							<span><input type="radio" value="交通银行" name="bankName" >交通银行</span>
							<span><input type="radio" value="上海银行" name="bankName" >上海银行</span>
							<span><input type="radio" value="渤海银行" name="bankName" >渤海银行</span>
							<span><input type="radio" value="南昌银行" name="bankName" >南昌银行</span>
							<span><input type="radio" value="上海农商银行" name="bankName" >上海农商银行</span>
							</li>
							<li>
							<span><input type="radio" value="广东南粤银行" name="bankName" >广东南粤银行</span>
							<span><input type="radio" value="山东省农村信用社" name="bankName" >山东省农村信用社</span>
							<span><input type="radio" value="包商银行" name="bankName" >包商银行</span>
							<span><input type="radio" value="宁波银行" name="bankName" >宁波银行</span>
							<span><input type="radio" value="华润银行" name="bankName" >华润银行</span>
							<span><input type="radio" value="华夏银行" name="bankName" >华夏银行</span>
							</li>
							<li>
							<span><input type="radio" value="北京银行" name="bankName" >北京银行</span>
							<span><input type="radio" value="江苏银行" name="bankName" >江苏银行</span>
							<span><input type="radio" value="东亚银行" name="bankName" >东亚银行</span>
							<span><input type="radio" value="南京银行" name="bankName" >南京银行</span>
							<span><input type="radio" value="鄂尔多斯银行" name="bankName" >鄂尔多斯银行</span>
							<span><input type="radio" value="晋中银行" name="bankName" >晋中银行</span>
							</li>
							<li>
							<span><input type="radio" value="杭州银行" name="bankName" >杭州银行</span>
							<span><input type="radio" value="顺德农商银行" name="bankName" >顺德农商银行</span>
							<span><input type="radio" value="齐鲁银行" name="bankName" >齐鲁银行</span>
							<span><input type="radio" value="深圳农村商业银行" name="bankName" >深圳农村商业银行</span>
							<span><input type="radio" value="哈尔滨银行" name="bankName" >哈尔滨银行</span>
							<span><input type="radio" value="南阳村镇银行" name="bankName" >南阳村镇银行</span>
							</li>
							<li>
							<span><input type="radio" value="福建农村信用社农商银行" name="bankName" >福建农村信用社农商银行</span>
							<span><input type="radio" value="九江银行" name="bankName" >九江银行</span>
							<span><input type="radio" value="浦江泰隆银行" name="bankName" >浦江泰隆银行</span>
							<span><input type="radio" value="成都银行" name="bankName" >成都银行</span>
							<span><input type="radio" value="龙江银行" name="bankName" >龙江银行</span>
							<span><input type="radio" value="青岛银行" name="bankName" >青岛银行</span>
							</li>
							<li>
							<span><input type="radio" value="常熟农商银行" name="bankName" >常熟农商银行</span>
							<span><input type="radio" value="西安银行" name="bankName" >西安银行</span>
							<span><input type="radio" value="东莞银行" name="bankName" >东莞银行</span>
							<span><input type="radio" value="贵阳银行" name="bankName" >贵阳银行</span>
							<span><input type="radio" value="新疆农村信用社" name="bankName" >新疆农村信用社</span>
							<span><input type="radio" value="攀枝花市商业银行" name="bankName" >攀枝花市商业银行</span>
							</li>
							<li>
							<span><input type="radio" value="兰州银行" name="bankName" >兰州银行</span>
							<span><input type="radio" value="吉林银行" name="bankName" >吉林银行</span>
							</li>
							</ul>
						</td>
					</tr>
					<tr>
						<td></td>
						<td><input class="shemenext cp mt10" type="button" value="设置" onclick="save();" /></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<div class="clear"></div>
	<script type="text/javascript">
	function sendCaptcha(obj){
		$.post("/captcha/phone", {'t':6}, function(msgBean){
			if(msgBean.code==zhigu.code.success){
				$("#tip_msg").html(msgBean.msg);
				send_captcha_waiting(obj);		
			}else{
				layer.alert(msgBean.msg);
			}
		});
	}
	function save(){
		var params = {};
		params.captcha =$("#captcha").val();
		params.bankNo = $("#bankNo").val();
		params.bankCardMaster = $("#bankCardMaster").val();
		params.bankName = $('input[name="bankName"]:checked').val();
		if(!params.captcha||params.captcha.length!=6){
			layer.alert("验证码错误！");
			return false;
		}
		if(!params.bankCardMaster){
			layer.alert("请填写持卡人姓名！");
			return false;
		}
		if(!bankNoCheck(params.bankNo)){
			layer.alert("银行卡号错误！");
			return false;
		}
		if(!params.bankName){
			layer.alert("请选择所属银行！");
			return false;
		}
		$.post("/user/security/bank",params,function(msgBean){
			if(msgBean.code == zhigu.code.success){
				layer.msg(msgBean.msg,2,function(){
					window.location.href = "/user/security/center";
				});
			}else{
				layer.alert(msgBean.msg);
			}
		},"json");
	}
	function bankNoCheck(bankno){
		var len =bankno.length; 
		if (len > 19|| len< 16 ) {
			//$("#banknoInfo").html("银行卡号长度必须在16到19之间");
			return false;
		}
		var num = /^\d*$/;  //全数字
		if (!num.exec(bankno)) {
			//$("#banknoInfo").html("银行卡号必须全为数字");
			return false;
		}
		//开头6位
		var strBin="10,18,30,35,37,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,58,60,62,65,68,69,84,87,88,94,95,98,99";    
		if (strBin.indexOf(bankno.substring(0, 2))== -1) {
			//$("#banknoInfo").html("银行卡号开头6位不符合规范");
			return false;
		}
        var lastNum=bankno.substr(bankno.length-1,1);//取出最后一位（与luhm进行比较）
    
        var first15Num=bankno.substr(0,bankno.length-1);//前15或18位
        var newArr=new Array();
        for(var i=first15Num.length-1;i>-1;i--){    //前15或18位倒序存进数组
            newArr.push(first15Num.substr(i,1));
        }
        var arrJiShu=new Array();  //奇数位*2的积 <9
        var arrJiShu2=new Array(); //奇数位*2的积 >9
        
        var arrOuShu=new Array();  //偶数位数组
        for(var j=0;j<newArr.length;j++){
            if((j+1)%2==1){//奇数位
                if(parseInt(newArr[j])*2<9)
                arrJiShu.push(parseInt(newArr[j])*2);
                else
                arrJiShu2.push(parseInt(newArr[j])*2);
            }
            else //偶数位
            arrOuShu.push(newArr[j]);
        }
        
        var jishu_child1=new Array();//奇数位*2 >9 的分割之后的数组个位数
        var jishu_child2=new Array();//奇数位*2 >9 的分割之后的数组十位数
        for(var h=0;h<arrJiShu2.length;h++){
            jishu_child1.push(parseInt(arrJiShu2[h])%10);
            jishu_child2.push(parseInt(arrJiShu2[h])/10);
        }        
        
        var sumJiShu=0; //奇数位*2 < 9 的数组之和
        var sumOuShu=0; //偶数位数组之和
        var sumJiShuChild1=0; //奇数位*2 >9 的分割之后的数组个位数之和
        var sumJiShuChild2=0; //奇数位*2 >9 的分割之后的数组十位数之和
        var sumTotal=0;
        for(var m=0;m<arrJiShu.length;m++){
            sumJiShu=sumJiShu+parseInt(arrJiShu[m]);
        }
        
        for(var n=0;n<arrOuShu.length;n++){
            sumOuShu=sumOuShu+parseInt(arrOuShu[n]);
        }
        
        for(var p=0;p<jishu_child1.length;p++){
            sumJiShuChild1=sumJiShuChild1+parseInt(jishu_child1[p]);
            sumJiShuChild2=sumJiShuChild2+parseInt(jishu_child2[p]);
        }      
        //计算总和
        sumTotal=parseInt(sumJiShu)+parseInt(sumOuShu)+parseInt(sumJiShuChild1)+parseInt(sumJiShuChild2);
        
        //计算Luhm值
        var k= parseInt(sumTotal)%10==0?10:parseInt(sumTotal)%10;        
        var luhm= 10-k;
        
        if(lastNum==luhm){
        //$("#banknoInfo").html("Luhm验证通过");
        return true;
        }
        else{
        //$("#banknoInfo").html("银行卡号必须符合Luhm校验");
        return false;
        }        
    }
	</script>
</body>
</html>
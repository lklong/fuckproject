<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>绑定银行卡</title>
<script type="text/javascript" src="js/3rdparty/layer/layer.min.js"></script>
</head>
<body>
<div class="rightContainer fr">
  <h4 class="ddtitle">绑定银行卡</h4>
  <table cellpadding="0" cellspacing="0" class="user-form-table">
    <tr>
      <td>&nbsp;</td>
      <td><span id="tip_msg" ></span></td>
    </tr>
    <c:if test="${not empty account.bankNo }">
      <tr>
        <td>原银行卡主：</td>
        <td>${account.bankCardMaster }</td>
      </tr>
      <tr>
        <td>原银行卡号：</td>
        <td>${account.bankNo }</td>
      </tr>
    </c:if>
    <tr>
      <td>手机号码：</td>
      <td>${auth.phone }</td>
    </tr>
    <tr>
      <td>验证码：</td>
      <td><input id="captcha" class="input-txt" type="text" autocomplete="off" maxlength="6"/>
        <input class="input-button ml20" 
							onclick="sendCaptcha(this)" type="button" value="发送验证码" /></td>
    </tr>
    <tr>
      <td colspan="2"><font color="red"> * 持卡人和银行卡必须正确，否则申请提现时不能成功。</font></td>
    </tr>
    <tr>
      <td>持卡人：</td>
      <td><input class="input-txt" type="text" id="bankCardMaster" maxlength="20"/></td>
    </tr>
    <tr>
      <td>银行卡号：</td>
      <td><input class="input-txt" type="text" id="bankNo" maxlength="19"/></td>
    </tr>
    <tr>
      <td>所属银行：</td>
      <td><div id="commbank_list" class="bank-list show-bank-mask-wrap">
          <p><label for="bank_net_1071" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="icbc" value="中国工商银行" name="bankName" id="bank_net_1071">
            <span title="工商银行" class="bank-logo bank-icbc"><span class="bank-logo-name">工商银行</span></span><span class="bank-ico-selected"></span></label>
          <label for="bank_net_1005" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="abc" value="中国农业银行" name="bankName" id="bank_net_1005">
            <span title="农业银行" class="bank-logo bank-abc"><span class="bank-logo-name">农业银行</span></span><span class="bank-ico-selected"></span></label>
          <label for="bank_net_1001" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="cmb" value="招商银行" name="bankName" id="bank_net_1001">
            <span title="招商银行" class="bank-logo bank-cmb"><span class="bank-logo-name">招商银行</span></span><span class="bank-ico-selected"></span></label>
          <label for="bank_net_1003" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="ccb" value="中国建设银行" name="bankName" id="bank_net_1003">
            <span title="建设银行" class="bank-logo bank-ccb"><span class="bank-logo-name">建设银行</span></span><span class="bank-ico-selected"></span></label>
          </p>
          <p><label for="bank_net_1026" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="boc" value="中国银行" name="bankName" id="bank_net_1026">
            <span title="中国银行" class="bank-logo bank-boc"><span class="bank-logo-name">中国银行</span></span><span class="bank-ico-selected"></span></label>
          <label for="bank_net_1066" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="post" value="中国邮政储蓄银行" name="bankName" id="bank_net_1066">
            <span title="邮政储蓄" class="bank-logo bank-post"><span class="bank-logo-name">邮政储蓄</span></span><span class="bank-ico-selected"></span></label>
          <label for="bank_net_1110" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="spdb" value="浦发银行" name="bankName" id="bank_net_1110">
            <span title="浦发银行" class="bank-logo bank-spdb"><span class="bank-logo-name">浦发银行</span></span><span class="bank-ico-selected"></span></label>
          <label for="bank_net_1051" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="gdb" value="广发银行" name="bankName" id="bank_net_1051">
            <span title="广发银行" class="bank-logo bank-gdb"><span class="bank-logo-name">广发银行</span></span><span class="bank-ico-selected"></span></label>
          </p>
          <p><label for="bank_net_1041" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="cmbc" value="民生银行" name="bankName" id="bank_net_1041">
            <span title="民生银行" class="bank-logo bank-cmbc"><span class="bank-logo-name">民生银行</span></span><span class="bank-ico-selected"></span></label>
          <label for="bank_net_1010" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="pingan" value="平安银行" name="bankName" id="bank_net_1010">
            <span title="平安银行" class="bank-logo bank-pingan"><span class="bank-logo-name">平安银行</span></span><span class="bank-ico-selected"></span></label>
          <label for="bank_net_1078" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="cebb" value="光大银行" name="bankName" id="bank_net_1078">
            <span title="光大银行" class="bank-logo bank-cebb"><span class="bank-logo-name">光大银行</span></span><span class="bank-ico-selected"></span></label>
          <label for="bank_net_1009" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="cib" value="兴业银行" name="bankName" id="bank_net_1009">
            <span title="兴业银行" class="bank-logo bank-cib"><span class="bank-logo-name">兴业银行</span></span><span class="bank-ico-selected"></span></label>
          </p>
          <p><label for="bank_net_1021" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="ecitic" value="中信银行" name="bankName" id="bank_net_1021">
            <span title="中信银行" class="bank-logo bank-ecitic"><span class="bank-logo-name">中信银行</span></span><span class="bank-ico-selected"></span></label>
          <label for="bank_net_1072" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="boco" value="交通银行" name="bankName" id="bank_net_1072">
            <span title="交通银行" class="bank-logo bank-boco"><span class="bank-logo-name">交通银行</span></span><span class="bank-ico-selected"></span></label>
          <label for="bank_net_2147" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="bosh_df" value="上海银行" name="bankName" id="bank_net_2147">
            <span title="上海银行" class="bank-logo bank-bosh"><span class="bank-logo-name">上海银行</span></span><span class="bank-ico-selected"></span></label>
          <label for="bank_net_2102" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="cbhb" value="渤海银行" name="bankName" id="bank_net_2102">
            <span title="渤海银行" class="bank-logo bank-cbhb"><span class="bank-logo-name">渤海银行</span></span><span class="bank-ico-selected"></span></label>
          </p>
          <p><label for="bank_net_2176" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="nccb_df" value="南昌银行" name="bankName" id="bank_net_2176">
            <span title="南昌银行" class="bank-logo bank-nccb"><span class="bank-logo-name">南昌银行</span></span><span class="bank-ico-selected"></span></label>
          <label for="bank_net_1113" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="srcb" value="上海农商" name="bankName" id="bank_net_1113">
            <span title="上海农商" class="bank-logo bank-srcb"><span class="bank-logo-name">上海农商</span></span><span class="bank-ico-selected"></span></label>
          <label for="bank_net_2118" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="zjcb" value="南粤银行" name="bankName" id="bank_net_2118">
            <span title="南粤银行" class="bank-logo bank-zjcb"><span class="bank-logo-name">南粤银行</span></span><span class="bank-ico-selected"></span></label>
          <label for="bank_net_2167" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="sdrcu_df" value="山东农信" name="bankName" id="bank_net_2167">
            <span title="山东农信" class="bank-logo bank-sdrcu"><span class="bank-logo-name">山东农信</span></span><span class="bank-ico-selected"></span></label>
          </p>
          <p><label for="bank_net_2113" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="bsb" value="包商银行" name="bankName" id="bank_net_2113">
            <span title="包商银行" class="bank-logo bank-bsb"><span class="bank-logo-name">包商银行</span></span><span class="bank-ico-selected"></span></label>
          <label for="bank_net_1112" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="nbcb" value="宁波银行" name="bankName" id="bank_net_1112">
            <span title="宁波银行" class="bank-logo bank-nbcb"><span class="bank-logo-name">宁波银行</span></span><span class="bank-ico-selected"></span></label>
          <label for="bank_net_2127" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="crb" value="华润银行" name="bankName" id="bank_net_2127">
            <span title="华润银行" class="bank-logo bank-crb"><span class="bank-logo-name">华润银行</span></span><span class="bank-ico-selected"></span></label>
          <label for="bank_net_2018" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="hxb_df" value="华夏银行" name="bankName" id="bank_net_2018">
            <span title="华夏银行" class="bank-logo bank-hxb"><span class="bank-logo-name">华夏银行</span></span><span class="bank-ico-selected"></span></label>
          </p>
          <p><label for="bank_net_1032" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="bob" value="北京银行" name="bankName" id="bank_net_1032">
            <span title="北京银行" class="bank-logo bank-bob"><span class="bank-logo-name">北京银行</span></span><span class="bank-ico-selected"></span></label>
          <label for="bank_net_2156" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="jsb_df" value="江苏银行" name="bankName" id="bank_net_2156">
            <span title="江苏银行" class="bank-logo bank-jsb"><span class="bank-logo-name">江苏银行</span></span><span class="bank-ico-selected"></span></label>
          <label for="bank_net_1076" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="hkbea" value="东亚银行" name="bankName" id="bank_net_1076">
            <span title="东亚银行" class="bank-logo bank-hkbea"><span class="bank-logo-name">东亚银行</span></span><span class="bank-ico-selected"></span></label>
          <label for="bank_net_1054" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="njcb" value="南京银行="bankName" id="bank_net_1054">
            <span title="南京银行" class="bank-logo bank-njcb"><span class="bank-logo-name">南京银行</span></span><span class="bank-ico-selected"></span></label>
          </p>
          <p><label for="bank_net_2158" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="ordos_df" value="鄂尔多斯" name="bankName" id="bank_net_2158">
            <span title="鄂尔多斯" class="bank-logo bank-ordos"><span class="bank-logo-name">鄂尔多斯</span></span><span class="bank-ico-selected"></span></label>
          <label for="bank_net_2168" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="jzb_df" value="晋中银行" name="bankName" id="bank_net_2168">
            <span title="晋中银行" class="bank-logo bank-jzb"><span class="bank-logo-name">晋中银行</span></span><span class="bank-ico-selected"></span></label>
          <label for="bank_net_3012" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="hzb" value="杭州银行" name="bankName" id="bank_net_3012">
            <span title="杭州银行" class="bank-logo bank-hzb"><span class="bank-logo-name">杭州银行</span></span><span class="bank-ico-selected"></span></label>
          <label for="bank_net_2133" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="sdebank" value="顺德农商" name="bankName" id="bank_net_2133">
            <span title="顺德农商" class="bank-logo bank-sdebank"><span class="bank-logo-name">顺德农商</span></span><span class="bank-ico-selected"></span></label>
          </p>
          <p><label for="bank_net_2134" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="qlb" value="齐鲁银行" name="bankName" id="bank_net_2134">
            <span title="齐鲁银行" class="bank-logo bank-qlb"><span class="bank-logo-name">齐鲁银行</span></span><span class="bank-ico-selected"></span></label>
          <label for="bank_net_2144" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="sznsh" value="深圳农商" name="bankName" id="bank_net_2144">
            <span title="深圳农商" class="bank-logo bank-sznsh"><span class="bank-logo-name">深圳农商</span></span><span class="bank-ico-selected"></span></label>
          <label for="bank_net_2123" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="hrbcb" value="哈尔滨银行" name="bankName" id="bank_net_2123">
            <span title="哈尔滨银行" class="bank-logo bank-hrbcb"><span class="bank-logo-name">哈尔滨银行</span></span><span class="bank-ico-selected"></span></label>
          <label for="bank_net_2140" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="nycbank" value="南阳村镇" name="bankName" id="bank_net_2140">
            <span title="南阳村镇" class="bank-logo bank-nycbank"><span class="bank-logo-name">南阳村镇</span></span><span class="bank-ico-selected"></span></label>
          </p>
          <p><label for="bank_net_2174" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="fjnx_df" value="福建农信" name="bankName" id="bank_net_2174">
            <span title="福建农信" class="bank-logo bank-fjnx"><span class="bank-logo-name">福建农信</span></span><span class="bank-ico-selected"></span></label>
          <label for="bank_net_2141" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="jjccb" value="九江银行" name="bankName" id="bank_net_2141">
            <span title="九江银行" class="bank-logo bank-jjccb"><span class="bank-logo-name">九江银行</span></span><span class="bank-ico-selected"></span></label>
          <label for="bank_net_2149" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="zjtlcb" value="泰隆银行" name="bankName" id="bank_net_2149">
            <span title="泰隆银行" class="bank-logo bank-zjtlcb"><span class="bank-logo-name">泰隆银行</span></span><span class="bank-ico-selected"></span></label>
          <label for="bank_net_2146" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="bocd" value="成都银行" name="bankName" id="bank_net_2146">
            <span title="成都银行" class="bank-logo bank-bocd"><span class="bank-logo-name">成都银行</span></span><span class="bank-ico-selected"></span></label>
          </p>
          <p><label for="bank_net_2151" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="ljbank_df" value="龙江银行" name="bankName" id="bank_net_2151">
            <span title="龙江银行" class="bank-logo bank-ljbank"><span class="bank-logo-name">龙江银行</span></span><span class="bank-ico-selected"></span></label>
          <label for="bank_net_2152" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="qbccb_df" value="青岛银行" name="bankName" id="bank_net_2152">
            <span title="青岛银行" class="bank-logo bank-qbccb"><span class="bank-logo-name">青岛银行</span></span><span class="bank-ico-selected"></span></label>
          <label for="bank_net_2159" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="csrcb" value="常熟农商" name="bankName" id="bank_net_2159">
            <span title="常熟农商" class="bank-logo bank-csrcb"><span class="bank-logo-name">常熟农商</span></span><span class="bank-ico-selected"></span></label>
          <label for="bank_net_2162" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="xacb" value="西安银行" name="bankName" id="bank_net_2162">
            <span title="西安银行" class="bank-logo bank-xacb"><span class="bank-logo-name">西安银行</span></span><span class="bank-ico-selected"></span></label>
          </p>
          <p><label for="bank_net_2172" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="dongguan_df" value="2172" name="bankName" id="bank_net_2172">
            <span title="东莞银行" class="bank-logo bank-dongguan"><span class="bank-logo-name">东莞银行</span></span><span class="bank-ico-selected"></span></label>
          <label for="bank_net_2175" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="gyccb_df" value="贵阳银行" name="bankName" id="bank_net_2175">
            <span title="贵阳银行" class="bank-logo bank-gyccb"><span class="bank-logo-name">贵阳银行</span></span><span class="bank-ico-selected"></span></label>
          <label for="bank_net_2155" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="xjrccb_df" value="新疆农村信用社" name="bankName" id="bank_net_2155">
            <span title="新疆农信" class="bank-logo bank-xjrccb"><span class="bank-logo-name">新疆农信</span></span><span class="bank-ico-selected"></span></label>
          <label for="bank_net_2171" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="pzhccb_df" value="攀枝花市商业银行" name="bankName" id="bank_net_2171">
            <span title="攀枝花商业银行" class="bank-logo bank-pzhccb"><span class="bank-logo-name">攀枝花商业银行</span></span><span class="bank-ico-selected"></span></label>
          </p>
          <label for="bank_net_2161" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="lzbank_df" value="兰州银行" name="bankName" id="bank_net_2161">
            <span title="兰州银行" class="bank-logo bank-lzbank"><span class="bank-logo-name">兰州银行</span></span><span class="bank-ico-selected"></span></label>
          <label for="bank_net_2170" class="bank-logo-wrap js-bank">
            <input type="radio" abbr="jlbank_df" value="吉林银行" name="bankName" id="bank_net_2170">
            <span title="吉林银行" class="bank-logo bank-jlbank"><span class="bank-logo-name">吉林银行</span></span><span class="bank-ico-selected"></span></label>
        </div></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td><input class="input-button" type="button" value="设置" onclick="save();" /></td>
    </tr>
  </table>
</div>
<script type="text/javascript">
	function sendCaptcha(obj){
		$.post("/user/security/bank/phone/send", {}, function(msgBean){
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
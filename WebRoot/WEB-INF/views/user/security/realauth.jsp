<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>实名认证</title>
</head>
<body>
<div class="rightContainer">
    	<!--// 标题 //-->
        <h3 class="rc_title">
        	安全设置<a href="user/home">我的主页</a>
        </h3>
        <!--// 内容框 //-->
		<div class="rc_body">
        	<!--// tab切换条 //-->
            <div id="userCommTab" class="userCommTab">
            	<ul>
                	<li><a href="javascript:void(0);" class="uctSelected">安全设置</a></li>
                </ul>
            </div>
            <div id="userContents" class="userContents">
            	<!--// 内容1 //-->
            	<div class="body_center2">
        	<div class="chongzhititle">
                <h4>个人/个体户认证</h4>
            </div>
            <div class="shimingform mt20">
            	<form method="post" action="#">
                	<div class="shimingbox">
                    	<p class="smtitle">账户名:</p>
                        <p class="smneirong">yl_34168189</p>
                        <div class="clear"></div>
                    </div>
                    <div class="shimingbox">
                    	<p class="smtitle">店铺名称：</p>
                        <p class="smneirong">哈哈哈哈哈啊</p>
                        <div class="clear"></div>
                    </div>
                    <div class="shimingbox">
                    	<p class="smtitle"><span class="smxing">*</span>真实姓名：</p>
                        <input class="smtext fl" type="text" placeholder="请输入真实姓名" />
                        <span class="shiminghelp fl">真实姓名只能含汉字、字母、符号中的空格与点，且长度在2～30个汉字之间</span>
                        <div class="clear"></div>
                    </div>
                    <div class="shimingbox">
                    	<p class="smtitle"><span class="smxing">*</span>身份证号码：</p>
                        <input class="smtext fl" type="text" placeholder="请输入你的身份证号码" />
                        <span class="shiminghelp fl">请填写正确的身份证号码</span>
                        <div class="clear"></div>
                    </div>
                    <div class="shimingbox">
                    	<p class="smtitle"><span class="smxing">*</span>身份证到期时间：</p>
                        <input class="smtext fl" type="text" placeholder="请选择日期" onfocus="HS_setDate(this)" />
                        <span class="shiminghelp fl">请输入正确的身份证号码</span>
                        <input class="changqi fl" type="checkbox" />长期
                        <div class="clear"></div>
                    </div>
                    <div class="shimingbox" id="shimingbox1">
                    	<p class="smtitle"><span class="smxing">*</span>身份证正面：</p>
                        <div class="sfzbox fl">
                        	<span class="sfzscbg"></span>   <!--图片正在上传背景-->
                            <p class="shangchuanbg"></p>	<!--图片正在上传文字-->
                            <p class="shangchuantxt">正在上传图像...</p>			
                            <a href="#">上传新图片<input type="file"  /></a>
                        </div>
                        <div class="shili fl">
                        	示例：<span class="shili1"></span>
                        </div>
                        <div class="clear"></div>
                    </div>
                    <div class="shimingbox" id="shimingbox2">
                    	<p class="smtitle"><span class="smxing">*</span>身份证反面：</p>
                        <div class="sfzbox fl">
                        	<span class="sfzscbg"></span>   <!--图片正在上传背景-->
                            <p class="shangchuanbg"></p>	<!--图片正在上传文字-->
                            <p class="shangchuantxt">正在上传图像...</p>			
                            <a href="#">上传新图片<input type="file"  /></a>
                        </div>
                        <div class="shili fl">
                        	示例：<span class="shili2"></span>
                        </div>
                        <div class="clear"></div>
                    </div>
                    <div class="shimingbox">
                    	<p class="smtitle"><span class="smxing">*</span>支付宝账号：</p>
                        <input class="smtext fl" type="text" placeholder="请填写准确的支付宝帐号" />
                        <span class="shiminghelp fl">请填写支付宝账号||请填写正确的支付宝账号</span>
                        <div class="clear"></div>
                    </div>
                    <input type="submit" value="下一步" class="shimingsub" />
                </form>
            </div>
        </div>
     </div>
            <br style="clear:both;" />
        </div>
    </div>
 <div class="clear"></div>   
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>收货地址</title>
</head>
<body>
<div class="body_center2 fl p10 ml10">
   	<div class="chongzhititle">
           <h4>收货地址</h4>
       </div>
       <div class="dizhibox">
       	<div class="dizhitxt0">
           	<h4 class="dizhih4">新增收货地址</h4>
               <p class="dizhip"><span class="dizhispan"></span>电话号码、手机号选填一项，其余均为必填项。</p>
               <div class="clear"></div>
           </div>
           <form method="post" action="#">
               <div class="dizhitxt">
                   <p class="dizhititle">
                       <span class="dizhixing">*</span>
                       收货人姓名：
                   </p>
                   <input type="text" class="mr10" />
                   <span class="dizhihelp">请输入联系人姓名</span>
                   <div class="clear"></div>
               </div>
               <div class="dizhitxt">
                   <p class="dizhititle">
                       <span class="dizhixing">*</span>
                       所在地区：
                   </p>
                   <select>
                       <option>请选择...</option>
                       <option>北京</option>
                       <option>上海</option>
                       <option>四川</option>
                   </select>
                   <select>
                       <option>请选择...</option>
                       <option>成都</option>
                       <option>绵阳</option>
                   </select>
                   <select class="mr10">
                       <option>请选择...</option>
                       <option>金牛区</option>
                       <option>青羊区</option>
                   </select>                    
                   <span class="dizhihelp">请选择退货区域</span>
                   <div class="clear"></div>
               </div>
               <div class="dizhitxt1">
                   <p class="dizhititle">
                       <span class="dizhixing">*</span>
                       具体收货地址：
                   </p>
                   <textarea class="fl mr10"></textarea>
                   <span class="dizhihelp">请输入具体退货地址</span>
                   <span class="dizhihelp1">不需要重复填写省/市/区</span>
                   <div class="clear"></div>
               </div>
               <div class="dizhitxt">
                   <p class="dizhititle">
                       <span class="dizhixing">*</span>
                       邮政编码：
                   </p>
                   <input type="text" class="mr10"/>
                   <span class="dizhihelp">邮政编码错误</span>
                   <span class="dizhihelp1">大陆以外地区可不填写</span>
                   <div class="clear"></div>
               </div>
               <div class="dizhitxt">
                   <p class="dizhititle">
                       手机号码：
                   </p>
                   <input type="text"/>
                   <div class="clear"></div>
               </div>
               <div class="dizhitxt">
                   <p class="dizhititle">
                       电话号码：
                   </p>
                   <input class="text1" type="text" /><span>-</span>
                   <input class="text2" type="text" /><span>-</span>
                   <input class="text3 mr10" type="text" />
                   <span class="dizhihelp1">手机号码和座机号码必须选填一项</span>
                   <div class="clear"></div>
               </div>
               <div class="dizhitxt">
                   <p class="dizhititle">
                       设为默认：
                   </p>
                   <input type="checkbox" class="mr10" /><strong>设置为默认收货地址</strong>
                   <div class="clear"></div>
               </div>
               <input class="dizhisub" type="submit" value="保存" />
       	</form>
       </div>
       <div class="dizhibox2 mt20 pt20">
       	<h4 class="mb10">已保存的收货地址：</h4>
           <table>
           	<tr>
               	<th>收货人</th>
                   <th>所在地区</th>
                   <th>具体收货地址</th>
                   <th>邮编</th>
                   <th>电话/手机</th>
                   <th></th>
                   <th>操作</th>
               </tr>
               <tr>
               	<td>xxx</td>
                   <td>中国 四川省 成都 金牛区</td>
                   <td>人民北路</td>
                   <td>610000</td>
                   <td>123456789101</td>
                   <td>默认地址</td>
                   <td><a href="#">修改</a><a href="#">删除</a></td>
               </tr>
           </table>
           <p>最多保存10个有效地址</p>
       </div>
   </div>
   <div class="clear"></div>
</body>
</html>
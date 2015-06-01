<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>淘宝产品发布-没店铺</title>
<script type="text/javascript" src="js/3rdparty/layer/layer.min.js"></script>

</head>
<body>
<div>
<style type="text/css">
	.immedite{
    font-size: 15px;
    font-weight: bold;
	}
</style>
<script type="text/javascript">
$.layer({
	shade : [0.5 , '#000' , true],
    area : ['auto','auto'],
    dialog : {
    	msg : '您的淘宝账号尚未开启店铺,<a href="http://www.zhiguw.com" class="immedite" style="color:red;">回到智谷首页</a>',
        btns : 2, 
        type : 4,
        btn : ['返回智谷首页', '去申请店铺'],
        yes : function(index){window.location.href="http://www.zhiguw.com" },
	    no : function(index){window.location.href="http://www.taobao.com" },
    },
	close : function(index){window.location.href="http://www.zhiguw.com"},
});
</script>
</div>
</body>
</html>
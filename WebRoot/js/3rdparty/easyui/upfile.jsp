<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<link rel="stylesheet" type="text/css" href="js/3rdparty/easyui/themes/bootstrap/easyui.css">
<link rel="stylesheet" type="text/css" href="js/3rdparty/easyui/themes/icon.css">
<script type="text/javascript" src="/js/3rdparty/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="/js/3rdparty/easyui/jquery-1.9.1.js"></script>
</head>
<body>
<div style="display: none;">
<div id="dlg" class="easyui-dialog" title="Basic Dialog" data-options="iconCls:'icon-save'" style="width:400px;height:200px;padding:10px">
	The dialog content.
</div>
</div>

<script type="text/javascript">
function upfile(){
	$('#dlg').dialog('open');
}
</script>
</body>
</html>
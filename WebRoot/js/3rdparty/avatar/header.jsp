<%
  response.setHeader("Pragma", "no-cache");
  response.setHeader("Cache-Control", "no-cache");
  response.setDateHeader("Expires", 0);
  String path = request.getContextPath();
%>
<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<script type="text/javascript" src="scripts/swfobject.js"></script>
<script type="text/javascript" src="scripts/fullAvatarEditor.js"></script>
<title></title>
<style type="text/css" media="screen">
html, body { height:100%; background-color: #ffffff;}
#flashContent { width:100%; height:100%; }
</style>

</head>
<body>
	<div>
		<p id="swfContainer">
			  本组件需要安装Flash Player后才可使用，请从<a href="http://www.adobe.com/go/getflashplayer">这里</a>下载安装。
		</p>
	</div>
	<script type="text/javascript">
            swfobject.addDomLoadEvent(function () {
                var swf = new fullAvatarEditor("swfContainer", {
					    id: 'swf',
						upload_url:"/upload/avatar",
						width:500,
						src_upload:0,
						avatar_sizes:"120*120",
						avatar_sizes_desc:"120*120像素"
						
					}, function (msg) {
						switch(msg.code){
							case 5 :
								if(msg.type == 1){
									window.parent.reAvatar(msg.content.data.avatarUrls);	
								}
							break;
						}
					}
				);
            });
			var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
			document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F5f036dd99455cb8adc9de73e2f052f72' type='text/javascript'%3E%3C/script%3E"));
        </script>
</body>
</html>
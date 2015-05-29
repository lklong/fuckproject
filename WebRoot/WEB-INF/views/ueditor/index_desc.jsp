<%@ page language="java" pageEncoding="UTF-8"%>
<!-- 加载编辑器的容器 -->
<script id="editor" name="content" type="text/plain" style="width:895px;height:400px;">
           <%=request.getParameter("desc")==null?"":request.getParameter("desc") %>
</script>
<!-- 配置文件 -->
<script type="text/javascript" src="/js/3rdparty/ueditor/ueditor.config.js"></script>
<!-- 编辑器源码文件 -->
<script type="text/javascript" src="/js/3rdparty/ueditor/ueditor.all.js"></script>
<!-- 实例化编辑器 -->
<script type="text/javascript">
var ue = UE.getEditor('editor');
	ue.ready(function(){
		this.execCommand( 'imagefloat', 'center' );
	});
	this.setContent('内容');
      /*   UE.Editor.prototype._bkGetActionUrl = UE.Editor.prototype.getActionUrl;
        UE.Editor.prototype.getActionUrl = function(action) {
            if (action == 'uploadimage' || action == 'uploadscrawl' || action == 'uploadimage') {
                return '/img/goods/detail';
            } else if (action == 'uploadvideo') {
                return 'http://a.b.com/video.php';
            } else {
                return this._bkGetActionUrl.call(this, action);
            }
        } */
</script>
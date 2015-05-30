<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


     <!-- 加载编辑器的容器 -->
    <script id="editor" name="content" type="text/plain" style="width:780px;height:400px;">
           <%=request.getParameter("desc")==null?"":request.getParameter("desc") %>
    </script>
    <!-- 配置文件 -->
    <script type="text/javascript" src="/js/3rdparty/ueditor/ueditor.desc.config.js"></script>
    <!-- 编辑器源码文件 -->
    <script type="text/javascript" src="/js/3rdparty/ueditor/ueditor.all.js"></script>
    <!-- 实例化编辑器 -->
    <script type="text/javascript">
        var ue = UE.getEditor('editor');
        ue.addListener('afterinserthtml', function (html) {
            //操作, 查找  img,a    ,将之删除操作
            html=html.replace(/<img[^>]*>/i,'');
            html=html.replace(/<a[^>]*>/i,'');
            html=html.replace(/<\/a>/i,'');
            // 更新编辑器内容, 把html 写进去, 替换原来的
            ue.execCommand( 'justify', 'center' );
        });
    </script>  


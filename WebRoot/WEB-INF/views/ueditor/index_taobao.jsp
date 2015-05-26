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
    </script>  


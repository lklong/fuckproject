<%@ page language="java" pageEncoding="utf-8"%>
<!doctype html>
<html>
<head>
<title>发送邮件</title>
<link href="/css/default/user.css" rel="stylesheet"/>
</head>
<body>
<!--** Step.2 身份验证 **-->
<div class="userRegPanel disnonex">
  <div class="urpInside">
    <div class="urpMiddleBox">
      <div class="urpTopTip">
        <div id="step1">
          <h1>密码找回-第二步</h1>
        </div>
      </div>
      <div class="urpMiddleDiv">
        <div class="urpAlert" style="width:410px;">
          <p class="okMsg"><em></em><font size="3" color="#000000">邮件已发送，请注意查收！</font></p>
        </div>
        <br />
        <div class="urpAlert"> 你绑定的邮箱：<span class="cf86666">${hideUsername }</span> </div>
        <br />
        <br />
        <br />
        <div class="noEmail"> </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>
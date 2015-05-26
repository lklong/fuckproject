<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><base href="${applicationScope.basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>安全设置</title>
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
            	
              <div class="dengjibox pt10">
            	<ul>
                	<li>	
                    	<span class="icon" id="icon1"></span>
                        <p class="txtshuoming">
                        	<span>安全性高的密码可以使账号更安全。建议您设置包含数字和字母、长度6位以上的密码，并定期更换。</span><br />
                            <span>密码强度:<strong class="ce81268">强</strong></span>
                        </p>
                        <a href="/user/security/updateLoginpwd">
                        	<c:choose>
                        		<c:when test="${empty auth.password}">
                        			<input type="button" value="设置" />
                        		</c:when>
                        		<c:otherwise>
                        			修改
                        		</c:otherwise>
                        	</c:choose>
	                        
                        </a>
                        
                    </li>
                    <li>	
                    	<span class="icon" id="icon2"></span>
                        <p class="txtshuoming">
                        	<span>绑定手机后，您可以免费享受智谷同城货源网的短信提示服务，同时可用于找回账户登录密码和支付密码。</span><br />
                        	<c:if test="${not empty auth.phone }">  
                            <span>已绑定手机：<strong class="ce81268">${auth.phone }</strong></span>  
                            </c:if>  
                            <c:if test="${empty auth.phone }">  
                            <span><strong class="ce81268" style="color:red">未绑定</strong></span>  
                            </c:if>  
                        </p>
	                        <a href="user/security/phone">
		                        <c:choose>
        		                	<c:when test="${empty auth.phone }">
			    	                    <input type="button" value="设置" />
                    		    	</c:when>
                        			<c:otherwise>
		                        		修改
                        			</c:otherwise>
                        		</c:choose>
		                    </a>
                    </li>
                    <li>	
                    	<span class="icon" id="icon3"></span>
                        <p class="txtshuoming">
                        	<span>绑定邮箱后，您可以免费享受同城货源网的邮件提示服务，同时可用于找回账户登录密码和支付密码。</span><br/>
	                       	<c:if test="${not empty auth.email }">
	                           <span>已绑定邮箱：<strong class="ce81268">${auth.email }</strong></span>
	                        </c:if>
	                        <c:if test="${empty auth.email }">
	                           <span><strong class="ce81268" style="color:red">未设置</strong></span>
	                        </c:if>
                        </p>
                        <a href="user/security/email">
                        	<c:choose>
       		                	<c:when test="${empty auth.email }">
		    	                    <input type="button" value="设置" />
                   		    	</c:when>
                       			<c:otherwise>
	                        		修改
                       			</c:otherwise>
                       		</c:choose>
                        </a>
                    </li>
                    <li>	
                    	<span class="icon" id="icon5"></span>
                        <p class="txtshuoming">
                        	<span>余额付款、确认收货、账户充值提现时使用。用于保障账户资金安全。</span><br/>
                        	<c:if test="${not empty account.payPasswd }">
	                           <span><strong class="ce81268">已设置</strong></span>
	                        </c:if>
	                        <c:if test="${empty account.payPasswd }">
	                           <span><strong class="ce81268" style="color:red">未设置</strong></span>
	                        </c:if>
                        </p>
                        <a href="user/security/paymentpwd"><c:choose>
  		                	<c:when test="${empty account.payPasswd }">
 	                    		<input type="button" value="设置" />
              		    	</c:when>
                  			<c:otherwise>
                    			修改
                  			</c:otherwise>
                  		</c:choose></a>
                    </li>
                    <li>	
                    	<span class="icon" id="icon6"></span>
                        <p class="txtshuoming">
                        <span>账户提现申请账户转入银行卡，余额提现。</span><br/>
	                       	<c:if test="${not empty account.bankNo }">
	                           <span>已绑定银行卡：<strong class="ce81268">${account.bankNo }</strong></span>
	                        </c:if>
	                        <c:if test="${empty account.bankNo }">
	                           <span><strong class="ce81268" style="color:red">未绑定</strong></span>
	                        </c:if>
                        </p>
                        <a href="user/security/bank"><c:choose>
  		                	<c:when test="${empty account.bankNo }">
 	                    		<input type="button" value="设置" />
              		    	</c:when>
                  			<c:otherwise>
                    			修改
                  			</c:otherwise>
                  		</c:choose>
                       	</a>
                    </li>
                </ul>
            </div>
                
     </div>
            <br style="clear:both;" />
        </div>
    </div>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!--// 通用底部 //-->
<div class="com_page_foot">
	<div class="inner">
		<div class="up_foot_inner">
			<div class="kefu_number">
				<p>
					客服电话：<font color="ff4362">028-65336799</font>
				</p>
				<p>投诉电话：17761200164</p>
			</div>
			<div class="qrcode_img">
				<img src="img/foot_qrcode.gif" /> <br />
				<br />智谷微信公众号
			</div>
			<div class="help_list">
				<ul>
					<li>
						<h3><a href="javascript:void(0);">新手指南</a></h3>
					</li>
				<!-- 	<li><a href="/help/cemment?id=32" target="_blank">会员注册</a></li>
					<li><a href="/help/cemment?id=33" target="_blank">供应商注册</a></li>
					<li><a href="/help/cemment?id=34" target="_blank">账号密码</a></li>
					<li><a href="/help/cemment?id=35" target="_blank">买家入门</a></li>
					<li><a href="/help/cemment?id=36" target="_blank">卖家入门</a></li>-->
					<li><a >会员注册</a></li> 
					<li><a >供应商注册</a></li>
					<li><a >账号密码</a></li>
					<li><a >买家入门</a></li>
					<li><a >卖家入门</a></li>
				</ul>
				<ul>
					<li>
						<h3><a href="javascript:void(0);">配送与支付</a></h3>
					</li>
				<!-- 	<li><a href="/help/cemment?id=37" target="_blank">代发方式</a></li>
					<li><a href="/help/cemment?id=38" target="_blank">支付方式</a></li>
					<li><a href="/help/cemment?id=39" target="_blank">联系客服</a></li>
					<li><a href="/help/cemment?id=40" target="_blank">充值付款</a></li> -->
					<li><a >代发方式</a></li>
					<li><a >支付方式</a></li>
					<li><a >联系客服</a></li>
					<li><a >充值付款</a></li>
				</ul>
				<ul>
					<li>
						<h3><a href="javascript:void(0);">关于我们</a></h3>
					</li>
					<li><a href="/help/cemment?id=41" target="_blank">公司简介</a></li>
					<li><a href="/help/cemment?id=42" target="_blank">联系我们</a></li>
					<li><a href="/help/cemment?id=43" target="_blank">团队招聘</a></li>
				</ul>
			</div>
			<div class="qqkefu_list">
				<!-- <a href="#" target="_blank"><img src="img/qq_img_1.jpg" /></a> <a href="#" target="_blank"><img src="img/qq_img_2.jpg" /></a> -->
				 <a href="#" target="_blank"><img src="img/qq_img_3.jpg" /></a>
			</div>
		</div>
		<div class="friend_links">
			<div class="copyright_box" style="padding-top: 20px;">
				Copyright © 2014 www.zhiguw.com Inc. All rights reserved.网站备案号：蜀ICP备05028911号-5
				<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1253159395'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s95.cnzz.com/z_stat.php%3Fid%3D1253159395%26show%3Dpic1' type='text/javascript'%3E%3C/script%3E"));</script>
			</div>
			<div style="padding: 3px 10px;">
				<a href='http://www.scgswljg.gov.cn/iciaicweb/dzbscheck.do?method=change&id=51010920150213060224' target="_blank"><img alt='网络经济主体信息' border='0' DRAGOVER='true' src='/img/icon/gongshang.png' /></a>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
		function b(){
			var h = $(window).height();
			var t = $(document).scrollTop();
			$('#gotop').css({'top':$(document).scrollTop()+h-200});
		}
		$(document).ready(function(e) {
			b();
			$('#gotop').click(function(){
				$("html,body").animate({ scrollTop: 0 },300);
			})
			$('#code').hover(function(){
					$(this).attr('id','code_hover');
					$('#code_img').show();
				},function(){
					$(this).attr('id','code');
					$('#code_img').hide();
			})
			
		});
		$(window).scroll(function(e){
			b();		
		});
	</script>
<script type="text/javascript" language="javascript" src="/js/foregroundDialog.js?v=20150307"></script>
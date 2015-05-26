if (typeof zhigu == "undefined" || !zhigu) {
	var zhigu = {};
}
zhigu.dialog = function(content,okFuncation,title){
	alertDialog(content,okFuncation,null,null,null,title);
	//_dialog(content,okFuncation,title);
}
zhigu.confirmDialog = function(options){
	var defaults = {
			"title":"确认框",
			"content":"",
			"okFunction":null,
			"cancelFunction":null,
			"width":300,
			"height":200
	};
	var params = $.extend({}, defaults, options || {}); 
	confirmDialog(params.content,params.okFunction,params.cancelFunction,null,params.width,params.height,params.title);
}
// 旧的dialog
function dialog(content, closeFun, width, heigth, title,showBut){
	zhigu.dialog(content,closeFun,null,null,title);
}

//全局遮罩对象
var maskLayer = (function(){
		
		this.display = false;
		
		//获取当前文档高宽
		var d_w = function(){ return $(document).width() };
		var d_h = function(){ return $(document).height() };
		
		//遮罩层
		var maskObj = $('<div></div>');
		maskObj.addClass('maskBox');
		maskObj.css({'width':d_w(),'height':d_h()});
		maskObj.css({'z-index':99990});
		
		//向body添加遮罩
		function createMask()
		{
			maskObj.appendTo('body');
			this.display = true;
		}
		
		//删除遮罩
		function destroyMask()
		{
			maskObj.remove();
		}
		
		//返回公共方法
		return {
				create : function(){ createMask(); },
				destroy : function(){ destroyMask(); }
			}
		
	})();

//全局confirmDialog框对象
var dialogLayer = dialogLayer || {};
(function(exports){
		
		//获取当前文档高宽
		var d_w = function(){ return $(document).width() };
		var d_h = function(){ return $(document).height() };

		//获取当前文档滚动距顶部高度
		var s_h = function(){ return $(document).scrollTop() };
		//获取当前窗口高度
		var w_h = function(){ return $(window).height() };
		
		exports.width = 320;
		exports.height = 220;
		exports.z_index = 99993;
		exports.content = '<p style="text-align:center">暂无显示！</p>';
		exports.title = '温馨提示：';
		exports.dispaly = false;
		
		//外框
		var parentBox = $('<div></div>');
		parentBox.addClass('parentBox');
		parentBox.css({'z-index':exports.z_index});
		
		//标题
		var titleBar = $('<div></div>');
		titleBar.addClass('boxTitle');
		
		//关闭按钮
		var closeBtn = $('<div></div>');
		closeBtn.addClass('winCloseBtn');
		
		//中间内容容器
		var contentBox = $('<div></div>');
		contentBox.addClass('contentBox');
		
		//按钮盒子
		var buttonBox = $('<div></div>');
		buttonBox.addClass('buttonBox');
		
		//确定按钮
		var doneBtn = $('<a href="javascript:void(0)">确定</a>');
		doneBtn.addClass('doneBtn');
		
		//取消按钮
		var cancelBtn = $('<a href="javascript:void(0)">取消</a>');
		cancelBtn.addClass('cancelBtn');
		
		//创建外框
		function createParentBox(_w,_h)
		{
			//设置高宽
			if(_w != null && _h == null)
			{
				dialogLayer.width  = _w;
			}
			else if(_h != null && _w == null)
			{
				dialogLayer.height = _h;
			}
			else if(_w != null && _h != null)
			{
				exports.width  = _w;
				exports.height = _h;
			};
			parentBox.css({'height':exports.height, 'width':exports.width});
			
			//设置位置
			//定位
			var pos_l = d_w() / 2 - exports.width / 2;
			var pos_t = s_h() + w_h() / 2 - exports.height / 2;
			parentBox.css({'left':pos_l,'top':pos_t});
			
			parentBox.appendTo('body');
			return parentBox;
		}
		
		//创建标题
		function createTitleBar(_title)
		{
			if(_title != null)
			{
				dialogLayer.title = _title;
			}
			titleBar.text(exports.title);
			parentBox.append(titleBar);
			return titleBar;
		}
		
		//创建关闭按钮
		function createCloseBtn(_close)
		{
			titleBar.append(closeBtn);
			if(typeof _close == 'function')
			{
				closeBtn.bind('click',function(){
						_close();
						parentBox.remove();
						maskLayer.destroy();
					});
			}
			else
			{
				closeBtn.bind('click',function(){
						parentBox.remove();
						maskLayer.destroy();
					});
			}
			return closeBtn;
		}
		
		//创建中间内容容器
		function createContent(_html,_w,_h)
		{
			if(_h != null && _w == null)
			{
				exports.height = _h;
				contentBox.css({'height':exports.height - 38 - 20 - 40 - 15 - 10 - 20 - 1});
			}
			else if(_w != null && _h == null)
			{
				exports.width = _w;
				contentBox.css({'width':exports.width - 40});
			}
			else if(_h != null && _w != null)
			{
				exports.height = _h;
				exports.width = _w;
			}
			contentBox.css({'height':exports.height - 38 - 20 - 40 - 15 - 10 - 20 - 1, 'width':exports.width - 40});
			
			if(_html != null)
			{
				exports.content = _html;
			};
			contentBox.html(exports.content);
			
			parentBox.append(contentBox);
		}
		
		//创建按钮盒子
		function createBtnBox()
		{
			parentBox.append(buttonBox);
		}
		
		//创建确定按钮
		function createDoneBtn(_function)
		{
			doneBtn.css({'margin-left':exports.width/2-106});
			buttonBox.append(doneBtn);
			if(typeof _function == 'function')
			{
				doneBtn.bind('click',function(){
						if(_function()==0)
						{
							parentBox.remove();
							maskLayer.destroy();
						}
						else
						{
							_function();
							parentBox.remove();
							maskLayer.destroy();
						}
					});
			}
			else
			{
				doneBtn.bind('click',function(){
						parentBox.remove();
						maskLayer.destroy();
					});
			}
		}
		
		//创建取消按钮
		function createCancelBtn(_cancel)
		{
			buttonBox.append(cancelBtn);
			if(typeof _cancel == 'function')
			{
				cancelBtn.bind('click',function(){
						_cancel();
					});
			}
			else
			{
				cancelBtn.bind('click',function(){
						parentBox.remove();
						maskLayer.destroy();
					});
			}
		}
		
		//销毁已建立的对话框；
		exports.destroy = function(){
				parentBox.remove();
			};
		
		//创建对话框
		exports.create = function createDialog(_html,_function,_cancel,_close,_width,_height,_title)
		{
			createParentBox(_width,_height);
			createTitleBar(_title);
			createCloseBtn(_close);
			createContent(_html,_width,_height);
			createBtnBox();
			createDoneBtn(_function);
			createCancelBtn(_cancel)
			
			exports.dispaly = true;
			return exports
		};
})(dialogLayer);

//全局alertDialog框对象
var alertLayer = alertLayer || {};
(function(exports){
		
		//获取当前文档高宽
		var d_w = function(){ return $(document).width() };
		var d_h = function(){ return $(document).height() };

		//获取当前文档滚动距顶部高度
		var s_h = function(){ return $(document).scrollTop() };
		//获取当前窗口高度
		var w_h = function(){ return $(window).height() };
		
		exports.width = 320;
		exports.height = 220;
		exports.z_index = 99997;
		exports.content = '<p style="text-align:center">暂无显示！</p>';
		exports.title = '温馨提示：';
		exports.dispaly = false;
		
		//外框
		var parentBox = $('<div></div>');
		parentBox.addClass('parentBox');
		parentBox.css({'z-index':exports.z_index});
		
		//标题
		var titleBar = $('<div></div>');
		titleBar.addClass('boxTitle');
		
		//关闭按钮
		var closeBtn = $('<div></div>');
		closeBtn.addClass('winCloseBtn');
		
		//中间内容容器
		var contentBox = $('<div></div>');
		contentBox.addClass('contentBox');
		
		//按钮盒子
		var buttonBox = $('<div></div>');
		buttonBox.addClass('buttonBox');
		
		//确定按钮
		var doneBtn = $('<a href="javascript:void(0)">关闭</a>');
		doneBtn.addClass('quitBtn');
		
		//创建外框
		function createParentBox(_w,_h)
		{
			//设置高宽
			if(_w != null && _h == null)
			{
				exports.width  = _w;
			}
			else if(_h != null && _w == null)
			{
				exports.height = _h;
			}
			else if(_w != null && _h != null)
			{
				exports.width  = _w;
				exports.height = _h;
			};
			parentBox.css({'height':exports.height, 'width':exports.width});
			
			//设置位置
			//定位
			var pos_l = d_w() / 2 - exports.width / 2;
			var pos_t = s_h() + w_h() / 2 - exports.height / 2;
			parentBox.css({'left':pos_l,'top':pos_t});
			
			parentBox.appendTo('body');
			return parentBox;
		}
		
		//创建标题
		function createTitleBar(_title)
		{
			if(_title != null)
			{
				dialogLayer.title = _title;
			}
			titleBar.text(exports.title);
			parentBox.append(titleBar);
			return titleBar;
		}
		
		//创建关闭按钮
		function createCloseBtn(_close)
		{
			titleBar.append(closeBtn);
			if(typeof _close == 'function')
			{
				closeBtn.bind('click',function(){
						_close();
						parentBox.remove();
						maskLayer.destroy();
					});
			}
			else
			{
				closeBtn.bind('click',function(){
						parentBox.remove();
						maskLayer.destroy();
					});
			}
			return closeBtn;
		}
		
		//创建中间内容容器
		function createContent(_html,_w,_h)
		{
			if(_h != null && _w == null)
			{
				exports.height = _h;
				contentBox.css({'height':exports.height - 38 - 20 - 40 - 15 - 10 - 20 - 1});
			}
			else if(_w != null && _h == null)
			{
				exports.width = _w;
				contentBox.css({'width':exports.width - 40});
			}
			else if(_h != null && _w != null)
			{
				exports.height = _h;
				exports.width = _w;
			}
			contentBox.css({'height':exports.height - 38 - 20 - 40 - 15 - 10 - 20 - 1, 'width':exports.width - 40});
			
			if(_html != null)
			{
				exports.content = '<p style="text-align:center;font-size:12px;color:#000000;">' + _html + '</p>';
			};
			contentBox.html(exports.content);
			
			parentBox.append(contentBox);
		}
		
		//创建按钮盒子
		function createBtnBox()
		{
			parentBox.append(buttonBox);
		}
		
		//创建关闭按钮
		function createDoneBtn(_function)
		{
			doneBtn.css({'margin-left':exports.width/2-50});
			buttonBox.append(doneBtn);
			if(typeof _function == 'function')
			{
				doneBtn.click(function(){
					parentBox.remove();
					maskLayer.destroy();
					_function();
					});
			}
			else
			{
				doneBtn.click(function(){
						parentBox.remove();
						maskLayer.destroy();
					});
			}
		}

		//销毁已建立的对话框；
		exports.destroy = function(){
				parentBox.remove();
			};
		
		//创建对话框
		exports.create = function createDialog(_html,_function,_close,_width,_height,_title)
		{
			createParentBox(_width,_height);
			createTitleBar(_title);
			createCloseBtn(_function);
			createContent(_html,_width,_height);
			createBtnBox();
			createDoneBtn(_function);
			
			exports.dispaly = true;
			return exports
		};
})(alertLayer);

//对已有的html内容创建一个弹出框
var divDialog = {
	
		display : false,
		title : '温馨提示',
		parentBox : null,
		titleBar : null,
		closeBtn : null,
		btnBox : null,
		doneBtn : null,
		cancelBtn : null,
		width : 320,
		height : 220,
		z_index : 99991,
		
		//浏览器可视区域的高宽;
		//对于每次创建时的重新获取(共享)
		d_h	: function(){ var d_h = $(document).height(); return d_h },
		d_w	: function(){ var d_w = $(document).width();  return d_w },
		s_h	: function(){ var s_h = $(document).scrollTop(); return s_h },
		w_h	: function(){ var w_h = $(window).height(); return w_h },
		
		//获取内容div
		setObj : function(_ID,_w,_h){
				var parentBox = $('#'+_ID);
				parentBox.addClass('parentBox');
				parentBox.css({'z-index':divDialog.z_index});
				divDialog.parentBox = parentBox;
				
				//设置高宽
				if(_w != null && _h == null)
				{
					divDialog.width  = _w;
				}
				else if(_h != null && _w == null)
				{
					divDialog.height = _h;
				}
				else if(_w != null && _h != null)
				{
					divDialog.width  = _w;
					divDialog.height = _h;
				};
				divDialog.parentBox.css({'height':divDialog.height, 'width':divDialog.width});
				
				//设置位置
				//定位
				var pos_l = divDialog.d_w() / 2 - divDialog.width / 2;
				var pos_t = divDialog.s_h() + divDialog.w_h() / 2 - divDialog.height / 2;
				divDialog.parentBox.css({'left':pos_l, 'top':pos_t});
				
				divDialog.parentBox.show();
				divDialog.display = true;
				return divDialog.parentBox;
			},
			
		//添加标题
		addTitle : function(_he){
				var boxTitle = $('<div></div>');
				boxTitle.addClass('boxTitle');
				
				//设置标题
				if(_he != null)
				{	
					divDialog.title = _he;
				}
				boxTitle.html(divDialog.title);	
				divDialog.titleBar = boxTitle;
			},
		
		//添加关闭按钮
		addCloseBtn	: function(_function){
				var winCloseBtn = $('<div title="关闭"></div>');
				winCloseBtn.addClass('winCloseBtn');
				
				if(typeof _function == 'function')
				{
					winCloseBtn.bind('click',function(){
							_function();
							divDialog.deleteDom();
							maskLayer.destroy();
						});
				}
				else
				{
					winCloseBtn.bind('click',function(){
							divDialog.deleteDom();
							maskLayer.destroy();
						});
				}
				
				divDialog.closeBtn = winCloseBtn;
			},
			
		//添加按钮盒子
		addBtnBox : function(){
				var buttonBox = $('<div></div>');
				buttonBox.addClass('buttonBox');					
				divDialog.btnBox = buttonBox;
			},
			
		//添加确定按钮
		addDoneBtn : function(_function){
				var doneBtn = $('<a href="javascript:void(0)">确定</a>');
				doneBtn.addClass('doneBtn');
				doneBtn.css({'margin-left':divDialog.width/2-106});
				
				if(typeof _function == 'function')
				{
					doneBtn.bind('click',function(){
							_function();
							divDialog.deleteDom();
							maskLayer.destroy();
						});
				}
				else
				{
					doneBtn.bind('click',function(){
							divDialog.deleteDom();
							maskLayer.destroy();
						});
				}
				
				divDialog.doneBtn = doneBtn;
			},
		
		//添加取消按钮
		addCancelBtn : function(_function){
				var cancelBtn = $('<a href="javascript:void(0)">取消</a>');
				cancelBtn.addClass('cancelBtn');
				
				if(typeof _function == 'function')
				{
					cancelBtn.bind('click',function(){
							_function();
							divDialog.deleteDom();
							maskLayer.destroy();
						});
				}
				else
				{
					cancelBtn.bind('click',function(){
							divDialog.deleteDom();
							maskLayer.destroy();
						});
				}
				
				divDialog.cancelBtn = cancelBtn;
			},
			
		//删除整个对话框组件，包含遮罩层
		deleteDom : function(){
				divDialog.parentBox.hide();
			},
			
		//构建对话框
		buildDialog : function(_ID,_function,_cancel,_close,_width,_height,_he){
				if(!divDialog.display)
				{
					//获取外框
					divDialog.setObj(_ID,_width,_height);
					
					//加标题
					divDialog.addTitle(_he);
					divDialog.parentBox.prepend(divDialog.titleBar);
					
					//加关闭按钮
					divDialog.addCloseBtn(_close);
					divDialog.titleBar.append(divDialog.closeBtn);
					
					//加按钮盒子
					divDialog.addBtnBox();
					divDialog.parentBox.append(divDialog.btnBox);
					
					//加确定按钮
					divDialog.addDoneBtn(_function);
					divDialog.btnBox.append(divDialog.doneBtn);
					
					//加取消按钮
					divDialog.addCancelBtn(_cancel);
					divDialog.btnBox.append(divDialog.cancelBtn);
				}
				else
				{
					divDialog.parentBox.show();
				}
			}
	};

//获取div内容弹出对话框
function divDialogEx(_ID,_function,_cancel,_close,_width,_height,_he)
{
	if(!maskLayer.display)
	{
		maskLayer.create();
	}
	
	if(divDialog.display)
	{
		divDialog.buildDialog(_ID,_function,_cancel,_close,_width,_height,_he);
	}
	else
	{
		divDialog.buildDialog(_ID,_function,_cancel,_close,_width,_height,_he);
	}
}

//confirmDialog对话框调用入口
function confirmDialog(_html,_function,_cancel,_close,_width,_height,_title)
{
	if(!maskLayer.display)
	{
		maskLayer.create();
	}
	
	if(dialogLayer.dispaly)
	{
		dialogLayer.destroy();
		dialogLayer.create(_html,_function,_cancel,_close,_width,_height,_title);
	}
	else
	{
		dialogLayer.create(_html,_function,_cancel,_close,_width,_height,_title);
	}
}

//alertDialog对话框调用入口
function alertDialog(_html,_function,_close,_width,_height,_title)
{
	if(!maskLayer.display)
	{
		maskLayer.create();
	}
	
	if(alertLayer.dispaly)
	{
		if(dialogLayer.dispaly)
		{
			dialogLayer.destroy();
		}
		alertLayer.destroy();
		alertLayer.create(_html,_function,_close,_width,_height,_title);
	}
	else
	{
		alertLayer.create(_html,_function,_close,_width,_height,_title);
	}
}
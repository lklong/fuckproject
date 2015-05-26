//http://www.cnblogs.com/hejunrex/archive/2011/11/17/2252193.html
jQuery.extend(jQuery.validator.messages, {
	required : "此选项不能为空",
	remote : "请修正该字段",
	email : "请输入正确格式的电子邮件",
	url : "请输入合法的网址",
	date : "请输入合法的日期",
	dateISO : "请输入合法的日期 (ISO).",
	number : "请输入合法的数字",
	digits : "只能输入整数",
	creditcard : "请输入合法的信用卡号",
	equalTo : "请再次输入相同的值",
	accept : "请输入拥有合法后缀名的字符串",
	postCode : "请输入正确邮政编码",
	strNumMix : "只能输入字母、数字或字母与数字的组合",
	tel : "请输入正确的电话号码，如：028-12345678",
	mobilePhone : "请输入正确的手机号码",
	password : "密码为6-16个字符，必须包含数字、字母",
	address : "请输入正确的地址",
	IDCardNum : "请输入有效的身份证号码",
	dateLine : "请输入正确的日期，如：2014-10-10",

	maxlength : jQuery.validator.format("最多只能输入 {0} 个字"),
	minlength : jQuery.validator.format("至少输入 {0} 个字"),
	rangelength : jQuery.validator.format("请输入 {0} - {1} 个字"),
	range : jQuery.validator.format("请输入一个介于 {0} 和 {1} 之间的值"),
	max : jQuery.validator.format("请输入一个最大为{0} 的值"),
	min : jQuery.validator.format("请输入一个最小为{0} 的值")
});
// 邮政编码验证   
jQuery.validator.addMethod("postCode", function(value, element) {
	var tel = /^[0-9]{6}$/;
	return this.optional(element) || (tel.test(value));
});
// 数字，字母，数字和字母组合
jQuery.validator.addMethod("strNumMix", function(value, element) {
	var tel = /^[0-9A-Za-z]+$/;
	return this.optional(element) || (tel.test(value));
});
// 座机电话
jQuery.validator.addMethod("tel", function(value, element) {
	var tel = /^1[3|4|5|7|8]{1,1}[0-9]{9}$|^(0[1-9]{3}-(\d{6}))$|^(0[1-9]{2}-(\d{7}))$/;
	return this.optional(element) || (tel.test(value));
});
// 密码
jQuery.validator.addMethod("password", function(value, element) {
	var tel = /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$/;
	return this.optional(element) || (tel.test(value));
});
// 日期格式 横线分隔符
jQuery.validator.addMethod("dateLine", function(value, element) {
	var date = /^((?:19|20)\d\d)-(0?[1-9]|1[012])-(0?[1-9]|[12][0-9]|3[01])$/;
	return this.optional(element) || (date.test(value));
});
// 手机号码
jQuery.validator.addMethod("mobilePhone", function(value, element) {
	var tel = /^1[3|4|5|7|8]{1,1}[0-9]{9}$/;
	return this.optional(element) || (tel.test(value));
});
// 输入地址检查(不能为纯数字、字母)
jQuery.validator.addMethod("address", function(value, element) {
	// /^[\u4E00-\u9FA5]+$/
	var tel = /^[a-zA-Z0-9]+$/;
	return this.optional(element) || (!tel.test(value));
});
// 身份证验证
jQuery.validator.addMethod("IDCardNum", function(value, element) {
	var userCode = "";
	if (value.length == 15) {
		userCode = /^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$/;
	} else {
		userCode = /^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/;
	}
	return this.optional(element) || (userCode.test(value));
});
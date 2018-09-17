function usernameFocus() {
	//console.log("asdas");

	document.getElementById("unhint").innerText = '账号由字母，数字，_组成，首字符必须是字母';
}

function usernameBlur() {
	//console.log("asfasdg");
	document.getElementById("unhint").innerText = "";
}
window.onload = function() {
	var password = document.getElementById("password");
	password.onfocus = function() {
		document.getElementById("pwd").innerText = '密码由字母,数字,_组成 ,且必须包含字母';
	}
	password.onblur = function() {
		document.getElementById("pwd").innerText = "";
	}
	var password1 = document.getElementById('password1');

	password1.onfocus = function() {
		document.getElementById('pwhint1').innerText = '此密码必须与上方输入密码相同'
	}

	password1.onblur = function() {
		document.getElementById('pwhint1').innerText = ''
	}

	var email = document.getElementById('email');

	email.onfocus = function() {

		document.getElementById('emailhint').innerText = 'email由英文和数字组成，首字符为英文'
	}

	email.onblur = function() {
		document.getElementById('emailhint').innerText = ''
	}
	
	var phone = document.getElementById('phone');

	phone.onfocus = function() {

		document.getElementById('phonehint').innerText = '填写11位数字的手机号码'
	}

	phone.onblur = function() {
		document.getElementById('phonehint').innerText = ''
	}
	
	var realname = document.getElementById('realname');

	realname.onfocus = function() {

		document.getElementById('realnamehint').innerText = '请输入真实姓名'
	}

	realname.onblur = function() {
		document.getElementById('realnamehint').innerText = ''
	}
	
	var card = document.getElementById('card');

	card.onfocus = function() {

		document.getElementById('cardhint').innerText = '请输入有效的18位证件号码'
	}

	card.onblur = function() {
		document.getElementById('cardhint').innerText = ''
	}
	
	var addr = document.getElementById('addr');

	addr.onfocus = function() {

		document.getElementById('addrhint').innerText = '请输入有效地址'
	}

	addr.onblur = function() {
		document.getElementById('addrhint').innerText = ''
	}
}

function login(){
	var uname = document.getElementById('uname').value;
	reg = /^[a-zA-Z][a-zA-Z0-9]{5,15}$/;
	if(reg.test(uname) == false) {
		document.getElementById('unhint').innerText = '账号必须是英文和数字，首字母必须是英文,长度6-16'
		return false;
	}

	var password = document.getElementById('password').value;
	reg2 = /^[a-zA-Z0-9+\-*\/]{6,16}$/;
	if(reg2.test(password) == false) {
		document.getElementById('pwd').innerText = '密码必须是英文数字、字母、下划线、+-*/组成，长度6-16';
		return false;
	}
	reg = /[a-zA-Z]/;
	if(reg.test(password) == false) {
		document.getElementById('pwd').innerText = '密码必须包含英文';
		return false;
	}

	var pwd1 = document.getElementById("password").value;
	var pwd2 = document.getElementById("password1").value;

	if(pwd1 == pwd2) {
		document.getElementById("pwhint1").innerText = "密码相同";
		document.getElementById("submit").disabled = false;
	} else {
		document.getElementById("pwhint1").innerText = "密码不同";
		document.getElementById("submit").disabled = false;
	}

	var email = document.getElementById('email').value;
	reg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
	if(reg.test(email) == false) {
		document.getElementById('emailhint').innerText = '请输入有效的邮箱！'
		return false;
	}
	var phone = document.getElementById('phone').value;
	reg = /^1([358][0-9]|4[579]|66|7[0135678]|9[89])[0-9]{8}$/;
	if(reg.test(email) == false) {
		document.getElementById('phonehint').innerText = '请输入有效的手机号！'
		return false;
	}

}
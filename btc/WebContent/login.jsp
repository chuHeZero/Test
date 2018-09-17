<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%   
    String path = request.getContextPath();   
    String basePath = request.getScheme()+"://" +request.getServerName()+":" +request.getServerPort()+path+"/" ;   
%> 
<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>用户登录</title>
		<link rel="stylesheet" href="css/login.css" />
		<script type="text/javascript" src="js/jquery-2.2.4.min.js"></script>
		
		<script>
			
			function usernameFocus(){
				//alert("获取焦点");
				//console.log("获取焦点");
				document.getElementById("unhint").innerText="账号由字母,数字,_组成, 首字符必须是字母";
			}
			
			function usernameBlur(){
				//console.log("失去焦点");
				document.getElementById("unhint").innerText="";
			}
			
			function usernameChange(){
				console.log("内容改变")
			}
			
			//
			/* 
			 * 1. 将JS写在HTML标签后,
			 * 2. 将获取对象的操作, 写在window.onload事件中
			 */
			
			window.onload = function(){
				var password = document.getElementById("password"); 
			
				/*
				 * JS 为元素绑定事件
				 */
				password.onfocus = function(){
					document.getElementById("pwdhint").innerText="密码由字母,数字,_组成, 必须包含字母";
				}; 
				
				password.onblur = function(){
					document.getElementById("pwdhint").innerText="";
				}
				
				
			};
			
			function refreshCode(){
				// 修改图片的属性
				$("#codeimg").removeAttr("src");
				$("#codeimg").attr("src","UserController/getCode.action?t=" + new Date().getTime());
			}
			
		</script>
	</head>
	<body>
		<div class="topbg">
			<div class="top">
				<img src="img/xlogo.png" />
				<h1>欢迎登录</h1>
				<div class="login">
					没有账号?
					<a href="register.jsp">请注册></a>
				</div>
				<div class="clear">
					
				</div>
			</div>
		</div>
		<div class="centerbg">
			<div class="center">
				<form action="UserController/login.action" method="post">
					<h1>用户登录</h1>
					<div>
						<label>账号</label><input type="text" name="uname" placeholder="请输入一个账号" 
							onfocus="usernameFocus()" 
							onblur="usernameBlur()" 
							onchange="usernameChange()" 
							/>
					</div>
					<div id="unhint" class="hint"></div>
					<div>
						<label>密码</label><input type="password" name="password" id="password" />
					</div>
					<div id="pwdhint" class="hint"></div>
					<div class="code">
						<label>验证码</label><input type="test" name="code" id="code" />
						<img id="codeimg" src="UserController/getCode.action"/>
						<a href="javascript:void(0)" onclick="refreshCode()">点击刷新</a>
					</div>
					<div id="pwdhint" class="hint"></div>
					<div class="error">${error }</div>
					
					<div><input type="submit" value="登录" /></div>
					<div class="regother">
						<div class="rege">
							
							<a href="#"><i></i>企业用户登录</a>					
						</div>
						<div class="regg">
							
							<a href="#"><i></i>国际站登录</a>
						</div>
						<div class="clear"></div>
					</div>
				</form>
			</div>
		</div>
		<div class="bottom">
			<div class="about">
				<a href="#">关于我们</a>
				<span>|</span>
				<a href="#">关于我们</a>
				<span>|</span>
				<a href="#">关于我们</a>
				<span>|</span>
				<a href="#">关于我们</a>
				<span>|</span>
				<a href="#">关于我们</a>
				<span>|</span>
				<a href="#">关于我们</a>
				<span>|</span>
				<a href="#">关于我们</a>
				<span>|</span>
				<a href="#">关于我们</a>
				
			</div>
			<div class="copyright">Copyright©2004-2018  京东JD.com 版权所有</div>
		</div>
		
	</body>
</html>

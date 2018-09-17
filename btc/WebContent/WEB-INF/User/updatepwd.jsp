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
		<title>管理密码</title>
		<link rel="stylesheet" type="text/css" href="css/JDnav.css" />
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
			
		</script>
	</head>
	<body>
	<div class="top">
			<img src="img/xlogo.png" />
			<a href="index.jsp" style="color:red;font-size: 20px;line-height: 50px;">回到首页</a>
		<div class="clear"></div>
		</div>
	<div class="center">
			<form action="UserController/newpwd.action" method="post">
				<h1>修改密码</h1>
				<div>
					<label>账号</label><input type="text" id="uname" name="uname" onfocus=this.blur()  onblur="usernameBlur()" value="${sessionScope.user.uname }" />
				</div>
				<div id="unhint" class="hint"></div>
				<div>
					<label>密码</label><input type="password" name="password" id="password"  />
				</div>
				<div id="pwdhint" class="hint"></div>
				<div>
					<label>重复密码</label><input type="password" name="password1" id="password1" />
				</div>
				<div id="pwhint1" class="hint"></div>
				<div><input type="submit" value="修改" onclick="return login()" /></div>
				<div id="unhint" class="hint"></div>
				<div class="error">${error }</div>

			</form>
			</div>
	</body>
</html>

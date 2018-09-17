<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%   
    String path = request.getContextPath();   
    String basePath = request.getScheme()+"://" +request.getServerName()+":" +request.getServerPort()+path+"/" ;   
    //System.out.println("path="+path);
    //System.out.println("basePath="+basePath);
%>  
<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>" > 
		<meta charset="UTF-8">
		<title>个人注册</title>
		<link rel="stylesheet" type="text/css" href="css/JDnav.css" />
		<script src="js/register.js" type="text/javascript"  charset="UTF-8"></script>
	</head>

	<body>

		<div class="top">
			<img src="img/xlogo.png" />
			<h1>欢迎注册</h1>
			<div class="login">
				已有账号
				<a href="login.jsp">请登录></a>
			</div>

			<div class="clear">

			</div>
		</div>

		<div class="center">
			<form action="UserController/register.action" method="post">
				<h1>用户注册</h1>
				<div>
					<label>账号</label><input type="text" id="uname" name="uname" placeholder="请输入一个账号" onfocus="usernameFocus()" onblur="usernameBlur()" />
				</div>
				<div id="unhint" class="hint"></div>
				<div>
					<label>密码</label><input type="password" name="password" id="password" />
				</div>
				<div id="pwd" class="hint"></div>
				<div>
					<label>重复密码</label><input type="password" name="password1" id="password1" />
				</div>
				<div id="pwhint1" class="hint"></div>
				<div>
					<label>邮箱</label><input type="email" name="uemail" id="email" />
				</div>
				<div id="emailhint" class="hint"></div>
				<div>
					<label>手机号</label><input type="phone" name="uphone" id="phone" />
				</div>
				<div id="phonehint" class="hint"></div>
				<div>
					<label>真实姓名</label><input type="realname" name="urealname" id="realname" />
				</div>
				<div id="realnamehint" class="hint"></div>
				<div>
					<label>身份证号</label><input type="card" name="ucard" id="card" />
				</div>
				<div id="cardhint" class="hint"></div>
				<div>
					<label>地址</label><input type="addr" name="uaddr" id="addr" />
				</div>
				<div id="addrhint" class="hint"></div>
				<div><input type="submit" value="注册" onclick="return login()" /></div>
				<div id="unhint" class="hint"></div>
				<div class="error">${error }</div>
				<div>
					<div class="qy">
						<span class="qy1"></span>
						<a href="https://reg.jd.com/b/regPage?source=buser">企业用户注册</a>
					</div>
					<div class="gj">
						<span class="gj1"></span>
						<a href="https://reg.joybuy.com/reg/person.html">国际站注册</a>
					</div>

			</form>
			</div>
		</div>
		<div class="button">
			<div>
				<a href="#">关于我们</a>
				<span>|</span>
				<a href="#">联系我们</a>
				<span>|</span>
				
				<a href="#">人才招聘</a>
				<span>|</span>
				<a href="#">商家入驻</a>
				<span>|</span>
				<a href="#">广告服务</a>
				<span>|</span>
				<a href="#">手机京东</a>
				<span>|</span>
				<a href="#">友情链接</a>
				<span>|</span>
				<a href="#">销售联盟</a>
				<span>|</span>
				<a href="#">京东社区</a>
				<span>|</span>
				<a href="#">京东公益</a>
				<span>|</span>
				<a href="#">English Site</a>

			</div>
			<div>Copyright©2004-2018 京东JD.com 版权所有
			</div>
		</div>

	</body>

</html>
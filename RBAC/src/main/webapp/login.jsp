<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	//System.out.println("path="+path);
	//System.out.println("basePath="+basePath);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>客户管理系统</title>
<link href="css/style_log.css" rel="stylesheet" type="text/css">
</head>
<body class="login" mycollectionplug="bind">
	<div class="login_m">
		<div class="login_logo">
			<img src="img/logo.png" width="196" height="46">
		</div>
		<div class="login_boder">

			<div class="login_padding" id="login_model">
				<form action="Staff/login.action" method="post">
				<h2>用户名</h2>
				<label> <input type="text" id="username" name="sname"
					class="txt_input txt_input2"
					onfocus="if (value ==&#39;Your name&#39;){value =&#39;&#39;}"
					onblur="if (value ==&#39;&#39;){value=&#39;Your name&#39;}"
					value="Your name">
				</label>
				<h2>密码</h2>
				<label> <input type="password" name="spassword"
					id="userpwd" class="txt_input"
					onfocus="if (value ==&#39;******&#39;){value =&#39;&#39;}"
					onblur="if (value ==&#39;&#39;){value=&#39;******&#39;}"
					value="******">
				</label>
				<p class="err">:${error }</p>
				<p class="forgot">
					<a id="iforget" href="javascript:void(0);">忘记密码?</a>
				</p>
				<div class="rem_sub">
					<div class="rem_sub_l">
						<input type="checkbox" name="checkbox" id="save_me"> <label
							for="checkbox">记住我</label>
					</div>
					<label> <input type="submit" class="sub_button"
						name="button" id="button" value="登录" style="opacity: 0.7;">
					</label>
				</div>
				</form>
			</div>

			<!--login_padding  Sign up end-->
		</div>
		<!--login_boder end-->
	</div>
	<!--login_m end-->
	<br>
	<br>
	<p align="center">
		More Templates <a href="http://www.cssmoban.com/" target="_blank"
			title="模板之家">纸飞机设计</a> - Collect from <a
			href="http://www.cssmoban.com/" title="网页模板" target="_blank"></a>
	</p>

</body>
</html>
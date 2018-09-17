<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%   
    String path = request.getContextPath();   
    String basePath = request.getScheme()+"://" +request.getServerName()+":" +request.getServerPort()+path+"/" ;   
    //System.out.println("path="+path);
    //System.out.println("basePath="+basePath);
%>  
<html>
<head>
<base href="<%=basePath%>" > 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>管理员登录</title>
<link rel="stylesheet" type="text/css" href="css/maglogin.css" />
<link rel="stylesheet" type="text/css" href="css/magbody.css"/> 
</head>
<body>
<div class="container">
	<section id="content">
		<form action="ManagerController/login.action" method="post">
			<h1>管理员登录</h1>
			<div>
				<input type="text" placeholder="账号 " required="" id="username" name="mname" />
			</div>
			<div>
				<input type="password" placeholder="密码" required="" id="password" name="mpassword" />
			</div>
			 <div class="">
				<span class="help-block u-errormessage" id="js-server-helpinfo">${error }</span>	
			</div> 
			<div>
				<!-- <input type="submit" value="Login" /> -->
				<input type="submit" value="登录" class="btn btn-primary" id="js-btn-login"/>
				<a href="#">忘记密码?</a>
				<!-- <a href="#">Register</a> -->
			</div>
		</form><!-- form -->
		 <div class="button">
			<span class="help-block u-errormessage" id="js-server-helpinfo"></span>
			<a href="#">进入商城</a>	
		</div> <!-- button -->
	</section><!-- content -->
</div>
<!-- container -->


<br><br><br><br>
<div style="text-align:center;">
</div>
</body>
</html>
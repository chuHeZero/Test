<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%   
    String path = request.getContextPath();   
    String basePath = request.getScheme()+"://" +request.getServerName()+":" +request.getServerPort()+path+"/" ;   
    //System.out.println("path="+path);
    //System.out.println("basePath="+basePath);
%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>" > 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="secondary-masthead">
	
		<ul class="nav nav-pills pull-right">
			<li>
				<a href="javascript:void(0)"><i class="icon-globe"></i> View Website</a>
			</li>
			<li class="dropdown">
				<a class="dropdown-toggle" data-toggle="dropdown" href="javascript:void(0)"><i class="icon-user"></i>${sessionScope.mgr.mname }<b class="caret"></b>
				</a>
				<ul class="dropdown-menu">
					<li><a href="javascript:void(0)">Your Profile</a></li>
					<li class="active"><a href="javascript:void(0)">Account Settings</a></li>
					<li class="divider"></li>
					<li><a href="ManagerController/logout.action">退出</a></li>
				</ul>
			</li>
		</ul>

		<ul class="breadcrumb">
			<li>
				<a href="javascrpit:void(0)">Admin</a> <span class="divider">/</span>
			</li>
			<li class="active">Dashboard</li>
		</ul>
		
	</div>
</body>
</html>
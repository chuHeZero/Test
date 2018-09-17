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
	<div class="main-left-col">
		
			<h1><i class="icon-shopping-cart icon-large"></i> Adminize</h1>
			
			<ul class="side-nav">

				<li class="active">
					<a href="ManagerController/index.action"><i class="icon-home"></i>首页</a>
				</li>
				<li class="dropdown">
					<a class="dropdown-toggle" data-toggle="collapse" data-target="#website-dropdown" ><i class="icon-sitemap"></i> 分类管理 <b class="caret"></b></a>
					<ul id="website-dropdown" class="collapse">
						<li><a href="Manager/fstypeall.action">产品分类管理</a></li>
					</ul>
				</li>
				<li class="dropdown">
					<a class="dropdown-toggle" data-toggle="collapse" data-target="#store-dropdown" ><i class="icon-shopping-cart"></i> 商品管理 <b class="caret"></b></a>
					<ul id="store-dropdown" class="collapse">
						<li><a href="Manager/productmgr.action">显示商品</a></li>
						<li><a href="Manager/Aaddproduct.action">添加商品</a></li>
						<li><a href="Manager/productmgr.action">修改商品</a></li>
						<li><a href="Manager/productmgr.action">下架商品</a></li>
					</ul>
				</li>
				<li class="dropdown">
					<a class="dropdown-toggle" data-toggle="collapse" data-target="#members-dropdown"><i class="icon-group"></i> 用户管理 <b class="caret"></b></a>
					<ul id="members-dropdown" class="collapse">
						<li><a href="User/selectAll.action">显示用户</a></li>
						<li><a href="User/selectAll.action">查询用户</a></li>
						<li><a href="User/selectAll.action">修改用户</a></li>
						<li><a href="User/selectAll.action">禁封用户</a></li>
					</ul>
				</li>
				<li class="dropdown">
					<a class="dropdown-toggle" data-toggle="collapse" data-target="#reports-dropdown"><i class="icon-signal"></i> 订单管理 <b class="caret"></b></a>
					<ul id="reports-dropdown" class="collapse">
						<li><a href="ManagerController/ordermgr.action">显示订单</a></li>
					</ul>
				</li>
				
				<li class="dropdown">
					<a class="dropdown-toggle" data-toggle="collapse" data-target="#settings-dropdown"><i class="icon-cogs"></i> 管理员 <b class="caret"></b></a>
					<ul id="settings-dropdown" class="collapse">
						<li><a href="ManagerController/mgrpwd.action">管理员密码</a></li>
						<li><a href="ManagerController/logout.action">退出</a></li>
					</ul>
				</li>
				<li><a><i class="icon-bullhorn"></i> Alerts <span class="badge badge-warning">2</span></a></li>
				<li class="dropdown">
					<a class="dropdown-toggle" data-toggle="collapse" data-target="#help-dropdown"><i class="icon-info-sign"></i> Help <b class="caret"></b></a>
					<ul id="help-dropdown" class="collapse">
						<li><a href="javascript:void(0)">FAQ</a></li>
						<li class="active"><a href="javascript:void(0)">User Guide</a></li>
						<li><a href="javascript:void(0)">Support</a></li>
					</ul>
				</li>
			</ul>
		
		</div> <!-- end main-left-col -->
</body>
</html>
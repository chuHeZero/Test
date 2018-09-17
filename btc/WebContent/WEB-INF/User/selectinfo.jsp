<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>用户信息</title>
		<link rel="stylesheet" type="text/css" href="css/JDnav.css" />
		
</head>
<body>
		<div class="top">
			<img src="img/xlogo.png" />
			<a href="index.jsp" style="color:red;font-size: 20px;line-height: 50px;">回到首页</a>
			<div class="clear">
		</div>
		</div>
	<div class="center">
			<form action="UserController/selectinfo.action" method="post">
				<h1>个人中心</h1>
				<div>
					<label>账号</label><input type="text" id="uname" name="uname" onfocus=this.blur()  onblur="usernameBlur()" value="${sessionScope.user.uname }" />
				</div>
				<div id="unhint" class="hint"></div>
				<div>
					<label>邮箱</label><input type="email" name="uemail" id="uemail" value="${sessionScope.user.uemail }" />
				</div>
				<div id="emailhint" class="hint"></div>
				<div>
					<label>手机号</label><input type="text" name="uphone" id="uphone" value="${sessionScope.user.uphone }" />
				</div>
				<div id="phonehint" class="hint"></div>
				<div>
					<label>真实姓名</label><input type="text" name="urealname" id="urealname" value="${sessionScope.user.urealname }" />
				</div>
				<div id="realnamehint" class="hint"></div>
				<div>
					<label>身份证号</label><input type="text" name="ucard" id="ucard" value="${sessionScope.user.ucard }" />
				</div>
				<div id="cardhint" class="hint"></div>
				<div>
					<label>地址</label><input type="text" name="uaddr" id="uaddr" value="${sessionScope.user.uaddr }" />
				</div>
				<div id="addrhint" class="hint"></div>
				<div>
					<label>账户余额</label><input type="text"  readonly="readonly" id="umoney" value="${sessionScope.user.umoney}" />
				</div>
				<div id="addrhint" class="hint"></div>
				<div>
					<c:if test="${sessionScope.user.ustatus==0}">
						<label>状态</label><input type="text" readonly="readonly" id="ustatus" value="正常" />
					</c:if>
					<c:if test="${sessionScope.user.ustatus!=0}">
						<label>状态</label><input type="text"  readonly="readonly" id="ustatus" value="异常" />
					</c:if>
				</div>
				<div id="addrhint" class="hint"></div>
				<div>
					<label>注册时间</label><input type="text" readonly="readonly" id="uregdate" value="<fmt:formatDate value='${sessionScope.user.uregdate}'  pattern='yyyy年MM月dd日  HH:mm:ss'/>"/>
				</div>
				<div id="addrhint" class="hint"></div>
				<div><input type="submit" value="修改" onclick="return login()" /></div>
				<div id="unhint" class="hint"></div>
				<div class="error">${error }</div>

			</form>
			</div>
</body>
</html>
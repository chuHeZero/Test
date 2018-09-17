<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

    <title>商品分类管理</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    
    <!-- Le styles -->
    <link href="http://fonts.googleapis.com/css?family=Oxygen|Marck+Script" rel="stylesheet" type="text/css">
    <link href="assets/css/bootstrap.css" rel="stylesheet">
    <link href="assets/css/font-awesome.css" rel="stylesheet">
    <link href="assets/css/admin.css" rel="stylesheet">
    
    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
	    <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

</head>    
<body>

<div class="container">
		
	<div class="row">
		
		<div class="span2">
		<jsp:include page="menu.jsp"></jsp:include>
	
	</div> <!-- end span2 -->
	
	<div class="span10">
	
	<jsp:include page="top.jsp"></jsp:include>
	
	<div class="main-area dashboard">
	
			<div class="alert alert-info">
				<a class="close" data-dismiss="alert" href="#">x</a>
				<h4 class="alert-heading">Information</h4>
				The listing template can be used to list content that requires editing, such as pages, product catalogue, settings and members.
			</div>
			
			<div class="row">
			
				<div class="span10">
				
					<div class="slate">
					
						<input type="text" class="input-large" placeholder="请输入分类名称" id="tname">
						
						<button type="submit" class="btn btn-primary" onclick="getftype(1)">查询</button>
						<a class="btn btn-info" href="Manager/sfadd.action">添加产品分类</a>
					</div>
				  
				</div>
			
			</div>
			
			<div class="row">
			
				<div class="span10">
				
					<div class="slate">
					
						<table class="orders-table table">
						<thead>
							<tr>
								<th>分类列表</th>
								<th class="actions">操作</th>
							</tr>
						</thead>
						<tbody id="fstypeall">
							
						</tbody>
						</table>

					</div>
				
				</div>
				
			
				<div class="span5">
				
					<div class="pagination pull-left">
						<ul id="page">
							
						</ul>
					</div>
				
				</div>
				
				<div class="span5 listing-buttons pull-right">
				
					<button class="btn btn-info" onclick="getftype(1)">回到首页</button>
				</div>
				
			</div>
			
		<div class="row">
		
			<div class="span10 footer">
			
				<p>&copy; Website Name 2018</p>
			
			</div>
		
		</div>
		
	</div>
	
	</div> <!-- end span10 -->
		
	</div> <!-- end row -->
		
</div> <!-- end container -->

<!-- Le javascript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="assets/js/jquery.min.js"></script>
<script src="assets/js/bootstrap.js"></script>

<!--异步请求  -->

	<script type="text/javascript">
	
		getftype(1);
		
		function getftype(curpage){
			
			var tname = $("#tname").val();
		
			
			
			$.ajax({
				url : "Manager/ftype.action",
				type : "post",
				data : {"tname": tname,"curpage": curpage},
				dataType : "JSON",
				success : function(data){
					
					//显示数据
					var html = "";
					$.each(data.list,function(index,item){
						html+=
						"<tr>"+
						"<td>序号:"+item.tid+"<a href=\"javascrpit:void(0)\">分类名称:"+item.tname+"</a> <span class=\"label label-info\">父类"+item.ptid+"</span>"+
						"</td>"+
						"<td class=\"actions\">"+
							"<a class=\"btn btn-small btn-primary\" href=\"Manager/updatetype.action?tid="+item.tid+"&tname="+item.tname+"&ptid="+item.ptid+"\">修改</a>"+
							
							"<a class=\"btn btn-small btn-danger\" data-toggle=\"modal\" href=\"Manager/fsremove.action?tid="+item.tid+"\">删除</a>"+
					"</tr>";
					});
					$("#fstypeall").html(html);
					
					var pageHtml = "";
					if(data.curpage > 1){
					pageHtml+="<li><a href=\"javascrpit:void(0)\" onclick=\"getftype("+(data.curpage-1)+")\">Prev</a></li>";
					}else{
						pageHtml+="<li class=\"active\"><a href=\"javascrpit:void(0)\">Prev</a></li>";
					}
					
					for(var i=1;i<=data.pagecount;i++){
						
						if(data.curpage !=i){
							pageHtml+="<li><a href=\"javascrpit:void(0)\" onclick=\"getftype("+i+")\">"+i+"</a></li>";
						}else{
							pageHtml+="<li class=\"active\"><a href=\"javascrpit:void(0)\" >"+i+"</a></li>";
						}
						
					}
				
					if(data.curpage == data.pagecount){
						pageHtml+="<li class=\"active\"><a href=\"javascrpit:void(0)\">Next</a></li>";
					}else{
						pageHtml+="<li><a href=\"javascrpit:void(0)\" onclick=\"getftype("+(data.curpage+1)+")\">Next</a></li>";
					}
				
					$("#page").html(pageHtml);
					
				}
			});
		}

	</script>
</body>
</html>
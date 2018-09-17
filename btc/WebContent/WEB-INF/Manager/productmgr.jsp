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

    <title>商品管理</title>
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
					
							<input type="text" class="input-large" placeholder="请输入产品名" id="pname">
							<select class="span2" id="pftype">
								
							</select>
							<select class="span2" id="pstype">
								
							</select>
							
							<button type="submit" class="btn btn-primary" onclick="getproduct(1)">查询</button>
						
					</div>
				
				</div>
			
			</div>
			
			<div class="row">
			
				<div class="span10">
				
					<div class="slate">
					
						<table class="orders-table table">
						<thead>
							<tr>
								<th>产品列表</th>
								<th class="actions">操作</th>
							</tr>
						</thead>
						<tbody id="productall">
							
						</tbody>
						</table>

					</div>
				
				</div>
				
				<div class="modal hide fade" id="removeItem">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">×</button>
						<h3>Remove Item</h3>
					</div>
					<div class="modal-body">
						<p>你确定要下架此产品?</p>
					</div>
					<div class="modal-footer">
						<a href="#" class="btn" data-dismiss="modal">关闭</a>
						<a href="Manager/remove.action?pid= " class="btn btn-danger">下架</a>
					</div>
				</div>
			
				<div class="span5">
				
					<div class="pagination pull-left">
						<ul id="page">
							
						</ul>
					</div>
				
				</div>
				
				<div class="span5 listing-buttons pull-right">
				
					<button class="btn btn-info" onclick="getproduct(1)">回到首页</button>
				
				
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
	
		getproduct(1);
		getftype();
		getstype();
		function getproduct(curpage){
			var pname = $("#pname").val();
			var pftype = $("#pftype").val();
			var pstype = $("#pstype").val();
			
			
			$.ajax({
				url : "Manager/selectAll.action",
				type : "post",
				data : {"pname": pname,"pftype": pftype,"pstype": pstype, "curpage": curpage},
				dataType : "JSON",
				success : function(data){
					
					//显示数据
					var html = "";
					$.each(data.list,function(index,item){
						html+=
						"<tr>"+
						"<td>序号:"+item.pid+"<a href=\"javascrpit:void(0)\">产品名称:"+item.pname+"</a> <span class=\"label label-info\">￥"+item.pprice+"</span><br /><span class=\"meta\">产品介绍:"+item.pdept+"</span>"+
						"<br /><span class=\"meta\">产品销量:"+item.psales+"</span>";
						html+="</td>"+
						"<td class=\"actions\">"+
						"<a class=\"btn btn-small btn-primary\" href=\"javascrpit:void(0)\">库存:"+item.pcount+ "</a>"+
							"<a class=\"btn btn-small btn-primary\" href=\"Manager/updateinfo.action?pid="+item.pid+"&pname="+item.pname+"&pdept="+item.pdept+"&pprice="+item.pprice+"&pcount="+item.pcount+"&pftype="+item.pftype+"&pstype="+item.pstype+"&ppic="+item.ppic+"&pstatus="+item.pstatus+"\">修改</a>";
							if(item.pstatus==0){
								html+=	"<a class=\"btn btn-small btn-primary\"href=\"javascrpit:void(0)\">状态:在售</a>";
							}else{
								html+= "<a class=\"btn btn-small btn-primary\" href=\"javascrpit:void(0)\">状态:下架</a>";
							}
							if(item.pstatus==0){
								html+="<a class=\"btn btn-small btn-danger\" data-toggle=\"modal\" href=\"Manager/removepc.action?pid="+item.pid+"&pstatus="+1+"\">下架</a>";
							}else{
								html+="<a class=\"btn btn-small btn-danger\" data-toggle=\"modal\" href=\"Manager/removepc.action?pid="+item.pid+"&pstatus="+0+"\">开售</a>";
							}
							
						html+="</td>"+
					"</tr>";
					});
					$("#productall").html(html);
					
					var pageHtml = "";
					if(data.curpage > 1){
					pageHtml+="<li><a href=\"javascrpit:void(0)\" onclick=\"getproduct("+(data.curpage-1)+")\">Prev</a></li>";
					}else{
						pageHtml+="<li class=\"active\"><a href=\"javascrpit:void(0)\">Prev</a></li>";
					}
					
					for(var i=1;i<=data.pagecount;i++){
						
						if(data.curpage !=i){
							pageHtml+="<li><a href=\"javascrpit:void(0)\" onclick=\"getproduct("+i+")\">"+i+"</a></li>";
						}else{
							pageHtml+="<li class=\"active\"><a href=\"javascrpit:void(0)\" >"+i+"</a></li>";
						}
						
					}
				
					if(data.curpage == data.pagecount){
						pageHtml+="<li class=\"active\"><a href=\"javascrpit:void(0)\">Next</a></li>";
					}else{
						pageHtml+="<li><a href=\"javascrpit:void(0)\" onclick=\"getproduct("+(data.curpage+1)+")\">Next</a></li>";
					}
				
					$("#page").html(pageHtml);
					
				}
			});
		}
		
		function getftype(){
		$.ajax({
			url:"getFType.action",
			type:"post",
			data:{},
			dataType:"JSON",
			success:function(data){
				
				var html ="\<option value=\"0\"> - 大分类 - </option>";
				$.each(data,function(index,item){
					
					html +="<option value="+item.tid+">"+item.tname+"</option>";
					
				})
				
				$("#pftype").html(html);
			}
			
		});
		}
		function getstype(){
			$.ajax({
				url:"getSType.action",
				type:"post",
				data:{},
				dataType:"JSON",
				success:function(data){
					
					var html ="\<option value=\"0\"> - 小分类 - </option>";
					$.each(data,function(index,item){
						
						html +="<option value="+item.tid+">"+item.tname+"</option>";
						
					})
					
					$("#pstype").html(html);
				}
				
			});
		}
		
		$("#pftype").change(function(){
				
			var tid = $("#pftype").val();
			$.ajax({
				url:"getSTypeP.action",
				type:"post",
				data:{"tid":tid},
				dataType:"JSON",
				success:function(data){
						var html = "";
						$.each(data ,function(index,item){
							html+="<option value=\""+item.tid+"\"> "+item.tname+" </option>";
						});
						$("#pstype").html(html);
					
				}
			});
			
			
		});
		

	</script>
</body>
</html>
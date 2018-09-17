<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<title>修改商品</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">

<!-- Le styles -->
<link href="http://fonts.googleapis.com/css?family=Oxygen|Marck+Script"
	rel="stylesheet" type="text/css">
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

			</div>
			<!-- end span2 -->

			<div class="span10">

				<jsp:include page="top.jsp"></jsp:include>

				<div class="main-area dashboard">

					<div class="alert alert-info">
						<a class="close" data-dismiss="alert" href="#">x</a>
						<h4 class="alert-heading">Information</h4>
						This template shows how forms can be laid out for editing content.
					</div>

					<div class="span5">

						<div class="slate">

							<div class="page-header">
								<h2>修改商品</h2>
							</div>

							<form class="form-horizontal" action="Manager/updateproduct.action?pid=${param.pid }" method="post" enctype="multipart/form-data">
								<fieldset>
									<div class="control-group">
										<label class="control-label" for="input01" >商品ID</label>
										<div class="controls">
											<input type="text" class="input-xlarge" id="input01" name="pid" onfocus=this.blur() value="${param.pid }" />
										</div>
									</div>
									<div class="control-group">
										<label class="control-label" for="input01" >商品名</label>
										<div class="controls">
											<input type="text" class="input-xlarge" id="input01" name="pname" value="${param.pname }" />
										</div>
									</div>
									<div class="control-group">
										<label class="control-label" for="textarea">产品描述</label>
										<div class="controls">
											<textarea class="input-xlarge" id="textarea" rows="3" name="pdept">${param.pdept }</textarea>
										</div>
									</div>
										<div class="control-group">
										<label class="control-label" for="input01">单价</label>
										<div class="controls">
											<input type="text" class="input-xlarge" id="input01" name="pprice" value="${param.pprice }" />
										</div>
									</div>
										<div class="control-group">
										<label class="control-label" for="input01">库存</label>
										<div class="controls"> 
											<input type="text" class="input-xlarge" id="input01" name="pcount" value="${param.pcount }" />
										</div>
									</div>
									<div class="control-group">
										<label class="control-label" for="select01">大分类</label>
										<div class="controls">
											<select id="pftype" name="pftype" value="${param.pftype }" >
												
											</select>
										</div>
									</div>
									<div class="control-group">
										<label class="control-label" for="select01">小分类</label>
										<div class="controls">
											<select id="pstype" name="pstype" value="${param.pstype }">
											</select>
										</div>
									</div>
									<div class="control-group">
										<label class="control-label" for="fileInput">图片</label>
										<div class="controls">
											<input class="input-file" id="fileInput" type="file" name="pic"/>
										</div>
									</div>
									<input type="submit" value="修改" class="btn btn-info"/>
									
								</fieldset>
							</form>

						</div>

					</div>


				</div>

				<div class="row">

					<div class="span10 footer">

						<p>&copy; Website Name 2018</p>

					</div>

				</div>

			</div>

		</div>
		<!-- end span10 -->

	</div>
	<!-- end row -->

	</div>
	<!-- end container -->

	<!-- Le javascript
================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/js/bootstrap.js"></script>
	<script type="text/javascript">
	
	
	getftype();
	getstype();
	
	function getftype(){
		$.ajax({
			url:"getFType.action",
			type:"post",
			data:{},
			dataType:"JSON",
			success:function(data){
				
				var html ="<option value=\"0\"> - 大分类 - </option>";
				$.each(data,function(index,item){
					
					html +="<option value=\""+item.tid+"\">"+item.tname+"</option>";
					
				});
				
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
						
						html +="<option value=\""+item.tid+"\">"+item.tname+"</option>";
						
					});
					
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
							html+="<option value=\""+item.tid+"\">"+item.tname+" </option>";
						});
						$("#pstype").html(html);
					
				}
			});
			
			
		});


</script>

</body>
</html>
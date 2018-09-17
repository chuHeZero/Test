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
<title>订单页面</title>
<link href="http://fonts.googleapis.com/css?family=Oxygen|Marck+Script" rel="stylesheet" type="text/css">
<link href="assets/css/bootstrap.css" rel="stylesheet">
<link href="assets/css/font-awesome.css" rel="stylesheet">
<link href="assets/css/admin.css" rel="stylesheet">

<link rel="stylesheet" type="text/css" href="css/jdphone.css" />
<link rel="stylesheet" type="text/css" href="css/header.css"/>
<link rel="stylesheet" type="text/css" href="css/shopping.css"/>
<link rel="stylesheet" type="text/css" href="css/footer.css"/>
<link href="css/style.css" rel="stylesheet"/>

<link rel="stylesheet" type="text/css" href="css/footer.css"/>
<link rel="stylesheet" type="text/css" href="css/6.23.css" />
<link rel="stylesheet" type="text/css" href="css/reset.css">
<link rel="stylesheet" type="text/css" href="css/carts.css">
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
						The listing template can be used to list content that requires
						editing, such as pages, product catalogue, settings and members.
					</div>

					<div class="row">

						<div class="span10">

							<div class="slate">

								<input type="text" class="input-large" placeholder="请输入收货人姓名" id="oname"> 

								<button type="submit" class="btn btn-primary" onclick="getAll(1)">查询</button>
								<a class="btn btn-primary" href="ManagerController/ordermgr.action">显示订单</a></li>

							</div>

						</div>

					</div>

					<div class="row">

						<div class="span10">

							<div class="slate">

								<table class="orders-table table">
									<thead>
										<tr>
											<th>订单列表</th>
											<th class="actions">操作</th>
										</tr>
									</thead>
									<tbody class="user">

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
								<a href="#" class="btn" data-dismiss="modal">关闭</a> <a
									href="Manager/remove.action?pid= " class="btn btn-danger">下架</a>
							</div>
						</div>

						<div class="span5">

							<div class="pagination pull-left">
								<ul id="page">

								</ul>
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
<script type="text/javascript" src="js/jquery-2.2.4.min.js"></script>
<script src="assets/js/bootstrap.js"></script>
<script type="text/javascript" >
	$(function(){
		getAll();
	});
	function getAll(){
		var oname = $("#oname").val();
		var html="";
		$.ajax({
			url : "ManagerController/aorder.action",
			type : "post",
			data : {"oname":oname},
			dataType : "json",
			success : function(data) {
				$.each(data,function(index, item) {
					
					var str1=order1(item);
					var str2="<div class=\"cartMain_hd\">"
		         			  +"<ul class=\"order_lists cartTop\">"
		         			  +"<li class=\"list_chk\">"
		         			 +"</li>"
							+"<li class=\"list_con\">商品信息</li>"
		         			+"<li class=\"list_price\" style=\"margin-left: -30px;\">数量</li>"
		         			+"<li class=\"list_amount\">收货人</li>"
		         			+"<li class=\"list_sum\" style=\"margin-left: 20px;\">总金额</li>"
		         			+" </ul>"
		         			+"	</div>";
		         	var str3=order2(item);
		         	html+=str1+str2+str3;
					
				});
				$(".user").html(html);
			}
		});
	};
	function order1(item){
		   str1="<div class=\"cartMain_hd\" >"
			   +"<ul class=\"order_lists cartTop\" >"
	           +" <li class=\"list_con\" style=\"margin-left: -120px;\">"
	           +"订单日期<span style=\"margin-left: 20px;\">"+item.odate+"</span>"
	           +"</li>"
	           +" <li class=\"list_con\" style=\"margin-left: -120px;\">"
	           +"订单号<span style=\"margin-left: 20px;\">"+item.onum+"</span>"
	           +"</li>"
	           +"订单总金额:<span style=\"margin-left: 20px; color: red; font-size: 18px;\">￥"+item.oprice.toFixed(2)+"元</span>"
	           +"</li>"
	           +"</ul>"
	           +"</div>";
	         return str1;
	};
	function order2(item1){
		var str3="";
		var onum=item1.onum;
		$.ajax({
			url : "ManagerController/mgrorinfo.action",
			async: false,
			type : "post",
			data : {"onum":onum},
			dataType : "json",
			success : function(data) {
				$.each(data,function(index, item) {
					var sum=parseFloat(item.pprice)*parseInt(item.pcount);
					str3+=" <div class=\"cartBox\">"
				      +"  <div class=\"order_content\" >"
				      +"  <ul class=\"order_lists\">"
				      +"    <li class=\"list_chk\">"
				      +"    </li>"
				      +"    <li class=\"list_con\">"
				      +"  <div class=\"list_img\"><a href=\"javascript:;\"><img src=\"upload/"+item.product.ppic+"\" /></a></div>"
				      +"  <div class=\"list_text\"><a href=\"javascript:;\">"+item.product.pname+"&nbsp;&nbsp;&nbsp;"+item.product.pdept+"</a></div>"
				      +" </li>"
				      +" <li class=\"list_price\">"
				      +" <p class=\"price\">"+item.pcount+"</p>"
				      +"     </li>"
				      +" <li class=\"list_price\">"
				      +" <p class=\"price\">"+item1.oname+"</p>"
				      +" </li>"
				      +" <li class=\"list_sum\">"
				      +" <p class=\"sum_price\">"+sum.toFixed(2)+"</p>"
				      +" </li>" 
				      +" </li>"
				      +" </ul>"
				      +" </div>"
				      +"</div>";
				})
				
			}
		});
		return str3;
	};
	
	
	
</script>
</body>
</html>
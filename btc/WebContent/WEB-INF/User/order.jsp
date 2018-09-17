<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%   
    String path = request.getContextPath();   
    String basePath = request.getScheme()+"://" +request.getServerName()+":" +request.getServerPort()+path+"/" ;   
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>" >
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单详情</title>


<link rel="stylesheet" type="text/css" href="css/jdphone.css" />
<link rel="stylesheet" type="text/css" href="css/header.css"/>
<link href="css/style.css" rel="stylesheet"/>

<link rel="stylesheet" type="text/css" href="css/6.23.css" />
<link rel="stylesheet" type="text/css" href="css/reset.css">
<link rel="stylesheet" type="text/css" href="css/carts1.css">
<script type="text/javascript" src="js/jquery-2.2.4.min.js"></script>

<script type="text/javascript" >
	$(function(){
		getAll();
	});
	function getAll(){
		$.ajax({
			url : "UserController/worder.action",
			type : "post",
			data : {},
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
		         			+"<li class=\"list_op\">操作</li>"
		         			+" </ul>"
		         			+"	</div>";
		         	var str3=order2(item);
					$(".user").append(str1+str2+str3);
				});
			}
		});
	};
	function order1(item){
		   str1="<div class=\"cartMain_hd\" >"
			   +"<ul class=\"order_lists cartTop\" >"
	           +" <li class=\"list_con\" style=\"margin-left: -120px;\">"
	           +"订单日期:<span style=\"margin-left: 20px;\">"+item.odate+"</span>"
	           +"</li>"
	           +" <li class=\"list_con\" style=\"margin-left: -120px;\">"
	           +"订单号:<span style=\"margin-left: 20px;\">"+item.onum+"</span>"
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
			url : "UserController/orinfo.action",
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
				      +" <p class=\"sum_price\">￥"+sum.toFixed(2)+"</p>"
				      +" </li>"
				      +"<li>"
				      +" <p class=\"del\"><a href=\"javascript:;\" class=\"delBtn\" style=\"margin-top: 50px; font-size: 16px;\">评价</a></p>"
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

</head>
	<body>
		<div class="box">
			<div class="header">
				<div class="header1">
					<div class="dd1">
						<div class="dd11"><span class="dd111"></span><a href="index.jsp">京东首页 </a><span class="dd112"></span><a>北京 </a></div>
						<div class="dd12">
						<c:if test="${sessionScope.user !=null }">
							<a href="">你好，${sessionScope.user.uname }</a>
							<a href="UserController/logout.action">退出</a>
					</c:if>
					<c:if test="${sessionScope.user ==null }">
					</c:if>	
							<span>|</span>
							<a href="UserController/ddxq.action">我的订单</a><span>|</span>
							<a href="cart.jsp">我的购物车</a><span>|</span>
							<a href="#">京东会员</a><span>|</span>
							<a href="#">企业采购</a><span>|</span>
							<a href="#">客户服务</a><span>|</span>
							<a href="#">网站导航</a><span>|</span>
							<a href="#">手机京东</a>
						</div>
					</div>
				<div class="clear"></div>
				</div>
				<div class="header2">
					<div class="ssk">
						<div class="ssk1" id="type">
						</div>
							<div class="ssk2">
								<form action="search.action" method="get">
									<input type="text" name="key" /><input type="submit" value="搜索" name="key1" />
								</form>
								<div class="ssk4">
									<a href="#">手机京东自营</a><span>|</span>
									<a href="#">华为手机</a><span>|</span>
									<a href="#">苹果</a><span>|</span>
									<a href="#">小米</a><span>|</span>
									<a href="#">华为</a><span>|</span>
									<a href="#">vivo</a><span>|</span>
									<a href="#">oppo</a><span>|</span>
									<a href="#">老人手机</a><span>|</span>
									<a href="#">小米8</a><span>|</span>
									<a href="#">三星</a><span>|</span>
									<a href="#">小米手机</a><span>|</span>
									<a href="#">魅族</a><span>|</span>
									<a href="#">小米6</a>
								</div>
							</div>
					</div><span class="noclear"></span>
				</div>
				<div class="clear"></div>
			</div>
				<div class="header3">
					<div class="header3-cont">
						<ul>
							<li class="l1">我的订单</li>
						</ul>
						<div class="clear"></div>
					</div>
				
	
	
	
	<div class="user" >
       
</div>

	 <div id="bottom">
		    <div id="GLOBAL_FOOTER">
		      <div id="footer">
		        <div class="links"> <a rel="nofollow" target="_blank" href="//www.jd.com/intro/about.aspx">关于我们</a>|<a rel="nofollow" target="_blank" href="//www.jd.com/contact/">联系我们</a>|<a rel="nofollow" target="_blank" href="//www.jd.com/contact/joinin.aspx">商家入驻</a>|<a rel="nofollow" target="_blank" href="//jzt.jd.com">营销中心</a>|<a rel="nofollow" target="_blank" href="//app.jd.com/">手机京东</a>|<a target="_blank" href="//club.jd.com/links.aspx">友情链接</a>|<a target="_blank" href="//media.jd.com/">销售联盟</a>|<a href="//club.jd.com/" target="_blank">京东社区</a>|<a href="//gongyi.jd.com" target="_blank">京东公益</a>|<a href="//en.jd.com/" target="_blank">English Site</a>|<a href="//en.jd.com/help/question-58.html" target="_blank">Contact Us</a> </div>
		        <div class="copyright"> 北京市公安局朝阳分局备案编号110105014669&nbsp;&nbsp;|&nbsp;&nbsp;京ICP证070359号&nbsp;&nbsp;|&nbsp;&nbsp;<a target="_blank" href="//img14.360buyimg.com/da/jfs/t256/349/769670066/270505/3b03e0bb/53f16c24N7c04d9e9.jpg">互联网药品信息服务资格证编号(京)-经营性-2014-0008</a>&nbsp;&nbsp;|&nbsp;&nbsp;新出发京零&nbsp;字第大120007号<br>
		          <a rel="nofollow" href="//misc.360buyimg.com/skin/df/i/com/f_music.jpg" target="_blank">音像制品经营许可证苏宿批005号</a>&nbsp;&nbsp;|&nbsp;&nbsp;出版物经营许可证编号新出发(苏)批字第N-012号&nbsp;&nbsp;|&nbsp;&nbsp;互联网出版许可证编号新出网证(京)字150号<br>
		          <a href="//misc.360buyimg.com/wz/wlwhjyxkz.jpg" target="_blank">网络文化经营许可证京网文[2014]2148-348号</a>&nbsp;&nbsp;违法和不良信息举报电话：4006561155&nbsp;&nbsp;Copyright&nbsp;©&nbsp;2004-2016&nbsp;&nbsp;京东JD.com&nbsp;版权所有<br>
		          京东旗下网站：<a href="https://www.jdpay.com/" target="_blank">京东钱包</a> </div>
		      </div>
		    </div>
		  </div>

		
</body>
</html>
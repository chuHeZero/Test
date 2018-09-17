<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>我的购物车</title>
<link rel="stylesheet" type="text/css" href="css/productinfo.css" />
<link rel="stylesheet" type="text/css" href="css/jdphone.css" />
<link rel="stylesheet" type="text/css" href="css/header.css" />
<link rel="stylesheet" type="text/css" href="css/shopping.css" />
<link rel="stylesheet" type="text/css" href="css/footer.css" />
<link href="css/style.css" rel="stylesheet" />
<script type="text/javascript" src="js/jquery-2.2.4.min.js"></script>
<script type="text/javascript" src="js/jquery.cookie.js"></script>
<script type="text/javascript">
	
	$(function(){
		//页面加载完后加载cookie
		getcartcount();
		//绑定全选按钮的事件
		$(".checkall").click(function(){
			var checked = $(this).prop("checked");
			if(checked){
				//全选
				$("input[type='checkbox']").prop("checked",true);
				
			}else{
				//取消全选
				$("input[type='checkbox']").prop("checked",false);
			}
		});
		
		$("input[type='checkbox']").click(function(){
			countandprice();
		});
		
		//绑定减号
		$(".sub").click(function(){
			
			var count = $(this).siblings("input").val();
			if(count>1){
			$(this).siblings("input").val(count-1);
			}
			
			//重新计算小计
			//获取价格
			var price = $(this).parents(".thing").find(".down1").find(".jg").find("input").val();
			count = $(this).siblings("input").val();
			var sumprice = price*count;
			$(this).parents(".thing").find(".down1").find(".xj").text("￥"+sumprice.toFixed(2)+"元");
			//复选框被选中
			$(this).parents(".thing").find("input[type='checkbox']").prop("checked",true);
			countandprice();
		});
		//绑定加号
		$(".add").click(function(){
			var pid = $(this).parents(".thing").find("input[type='checkbox']").val();
			var count = $(this).siblings("input").val();
			var input = $(this).siblings("input");
			$.ajax({
				url:"productcount.action",
				type:"post",
				data:{"pid": pid},
				dataType:"JSON",
				success : function(data){
					
					if(count < data.pcount){
						input.val(parseInt(count)+1);
						var price = input.parents(".thing").find(".down1").find(".jg").find("input").val();
						var sumprice =parseInt(price)*(parseInt(count)+1);
						input.parents(".thing").find(".down1").find(".xj").text("￥"+sumprice.toFixed(2)+"元");
						input.parents(".thing").find("input[type='checkbox']").prop("checked",true);
						
						countandprice();
					}
					
				}
			});
		});
		
	});
	function countandprice(){
		var items=$(".thing");
		var sumcount = 0;
		var sumprice = 0;
		
		items.each(function(){
			var checked = $(this).find("input[type='checkbox']").prop("checked");
			
			if(checked){
				price = $(this).find("input[type='hidden']").val();
				count = $(this).find("input[type='text']").val();
				
				sumcount += parseInt(count);
				sumprice += parseFloat(price)*parseInt(count);
			}
		});
		$(".allt .sf").text(sumcount);
		$(".allt .ss").text("￥"+sumprice.toFixed(2)+"元");
	}
	
	function getcartcount(){
		//先去cookie中取存有count的cookie
		var ckicart = $.cookie("cart");
		var cart;
		if(ckicart==undefined){
			
		}else{
			cart = JSON.parse(ckicart);
			var html="";
			//遍历数组来获取每个商品的详细信息
			for(var i=0; i<cart.length; i++){
				var pid = cart[i].pid;
				var count = cart[i].count;
				//ajax获取商品详情
				$.ajax({
					url:"productcount.action",
					async:false,//异步还是同步
					type:"post",
					data:{"pid":pid},
					dataType:"JSON",
					success : function(data){
						//获取到详细信息
						
						html+=
						"<div class=\"thing\">"+
						"<ul class=\"down1\">"+
							"<li class=\"l1\"><input type=\"checkbox\" value=\""+data.pid+"\" /></li>"+
							"<li class=\"l2\"><img src=\"upload/"+data.ppic+"\" /></li>"+
							"<li class=\"l3\">"+
								"<p>"+data.pname+"&nbsp;&nbsp;&nbsp;&nbsp;"+data.pdept+"</p>"+
							"</li>"+
							"<li class=\"jg\">"+
							"<input type=\"hidden\" value=\""+data.pprice+"\" />"+
							"</li>"+
							"<li class=\"l5\">￥"+data.pprice.toFixed(2)+"元</li>"+
							"<li class=\"l6\">"+
							"<a href=\"javascrpit:void(0)\" class=\"sub\">-</a>"+
								"<input type=\"text\" id=\"sl\" class=\"n2\" value=\""+count+"\" />"+
							"<a href=\"javascrpit:void(0)\" class=\"add\">+</a>"+	
							"</li>"+
							"<li class=\"xj\">￥"+(data.pprice*count).toFixed(2)+"元</li>"+
							"<li class=\"l8\">"+
								"<a href=\"javascript:void(0)\" onclick=\"rem("+data.pid+")\" >删除</a>"+
							"</li>"+
						"</ul>"+
					"</div>";
					
					}
				});
			}
			$(".shoppingcart").html(html);
		}
	} 
	
	function addorder(){
		del();
		//动态生成表单
		var form = $("<form action=\"UserController/suborder.action\" method=\"post\" id='jd'></form>");
		 //获取商品信息
		var items=$(".thing");
		
		var index=0;
		items.each(function(){
			var checked =  $(this).find("input[type='checkbox']").prop("checked");
			
			if(checked){
				//获取商品ID
				pid = $(this).find("input[type='checkbox']").val();
				//获取购买数量
				count = $(this).find("input[type='text']").val();
				
				form.append("<input type=\"text\" value=\""+pid+"\" name=\"list["+index+"].pid\"/>");
				form.append("<input type=\"text\" value=\""+count+"\" name=\"list["+index+"].pcount\"/>");
				
				index ++;
			}
		}); 
		
		$(".cl").append(form);
		//$(document.body).append(form);
		
		form.submit();
		//提交表单
	}
	
		
		//批量删除
		function del(){
			$.cookie("cart", "", {expires: -1});
			var checkeds=$(".thing");
			checkeds.each(function(){
			var checked=$(this).find("input[type='checkbox']").prop("checked")
			if(!checked){
			// 取到商品ID
			var pid = $(this).find("input[type='checkbox']").val();
			// 取到购买数量
			var count=$(this).find(".n2").val();
			// 先取cookie
			var ckicart = $.cookie("cart");
			var cart;
			// 判断Cookie中是否有数据
			if (ckicart == undefined){
			// 当没有购物车信息时, 创建一个数组保存购物信息
			cart = new Array();
			} else {
			// 当已有购物信息时, 获取已有的信息, 生成数组
			cart = JSON.parse(ckicart);
			}
			// 创建一个对象
			var product = new Object();
			product.pid = pid;
			product.count = count;
			cart.push(product);
			// 转成JSON字符串  {gid : 值, count : 值}  GSON
			var str = JSON.stringify(cart);
			// 保存到cookie中, cookie只能保存字符串,有效期7天
			$.cookie("cart", str,{expires:7});
			}
			});
			window.location.reload();
	};
	//删除指定
	function rem(pid){
		//先取cookie
		var ckicart = $.cookie("cart");
		var cart;
		if(ckicart != undefined){
		//有购物信息就把数据获取到生成数组
		cart = JSON.parse(ckicart);
		//遍历这个数组
		for(var i=0;i<cart.length;i++){
		if (pid == cart[i].id){
		//从cart里面删除第i个元素，删除1个
		cart.splice(i,1);
		break;
		}
		}
		// 把CART存回cookie，转成JSON的字符串，用js提供的方法
		var str = JSON.stringify(cart);
		//保存到cookie中，cookie只能保存字符串,加上的大括号是cookie的参数
		$.cookie("cart",str);//有效期7天  ,{expires:7}
		getcartcount();
		}
		}
	
			$(function(){
				$(".n2").change(function() {

					var count = $(this).val();
					var input = $(this);
					var pid = $(this).parents(".thing").find(".down1").find(".l1").find("input").val();
					if (isNaN(count)) {
						count = 0;
					}
					$.ajax({
						url : "productcount.action",
						type : "post",
						data : {"pid" : pid},
						dataType : "JSON",
						success : function(data) {
							
							if(count==""){
								count=0;
							}
							if (count > data.pcount) {
								input.val(data.pcount);
								var price = input.parents(".thing").find(".down1").find(".jg").find("input").val();
								  var sumPrice=data.pcount*pprice;
									input.parents(".thing").find(".down1").find(".xj").text(parseFloat(sumPrice).toFixed(2)+"元");
							    	input.parents(".thing").find("input[type='checkbox']").prop("checked",true);
							}
							if (count<1&&data.pcount>0) {
								
								input.val(1);
								var price = input.parents(".thing").find(".down1").find(".jg").find("input").val();
								  var sumPrice=1*price;
								input.parents(".thing").find(".down1").find(".xj").text(parseFloat(sumPrice).toFixed(2)+"元");
							      input.parents(".thing").find("input[type='checkbox']").prop("checked",true);
							} else if (data.pcount == 0) {
								input.val(0);
								
							}else{
								var price = input.parents(".thing").find(".down1").find(".jg").find("input").val();
								
								  var sumPrice=count*price;
								  
								input.parents(".thing").find(".down1").find(".xj").text(parseFloat(sumPrice).toFixed(2)+"元");
								
							     input.parents(".thing").find("input[type='checkbox']").prop("checked",true);
							}
							
							countandprice();
						}
					});
				});
				});
</script>
</head>
<body>
	<div class="box">
		<div class="header">
			<div class="header1">
				<div class="dd1">
					<div class="dd11">
						<span class="dd111"></span><a href="index.jsp">京东首页 </a><span
							class="dd112"></span><a>北京 </a>
					</div>
					<div class="dd12">
						<c:if test="${sessionScope.user !=null }">
							<a href="">你好，${sessionScope.user.uname }</a>
							<a href="UserController/logout.action">退出</a>
						</c:if>
						<c:if test="${sessionScope.user ==null }">
								<a href="login.jsp">你好，请登录</a>
								<a href="register.jsp">免费注册</a>
						</c:if>
						<span>|</span> 
						<a href="UserController/ddxq.action">我的订单</a><span>|</span>
						<a href="cart.jsp">我的购物车</a><span>|</span>
						<a href="javascript:void(0)">京东会员</a><span>|</span> 
						<a href="javascript:void(0)">企业采购</a><span>|</span>
						<a href="javascript:void(0)">客户服务</a><span>|</span> 
						<a href="javascript:void(0)">网站导航</a><span>|</span>
						<a href="javascript:void(0)">手机京东</a>
					</div>
				</div>
				<div class="clear"></div>
			</div>
			<div class="header2">
				<div class="ssk">
					<div class="ssk1" id="type"></div>
					<div class="ssk2">
						<form action="search.action" method="get">
							<input type="text" name="key" /><input type="submit" value="搜索" name="key1" />
						</form>
						<div class="ssk4">
							<a href="#">手机京东自营</a><span>|</span> <a href="#">华为手机</a><span>|</span>
							<a href="#">苹果</a><span>|</span> <a href="#">小米</a><span>|</span>
							<a href="#">华为</a><span>|</span> <a href="#">vivo</a><span>|</span>
							<a href="#">oppo</a><span>|</span> <a href="#">老人手机</a><span>|</span>
							<a href="#">小米8</a><span>|</span> <a href="#">三星</a><span>|</span>
							<a href="#">小米手机</a><span>|</span> <a href="#">魅族</a><span>|</span>
							<a href="#">小米6</a>
						</div>
					</div>
				</div>
				<span class="noclear"></span>
			</div>
			<div class="clear"></div>
		</div>
		<div class="header3">
			<div class="header3-cont">
				<ul>
					<li class="l1">全部分类</li>
				</ul>
				<div class="clear"></div>
			</div>
		</div>
	</div>
	<!--导航横线-->
	<div class="line"></div>
	<!-- 购物车 -->
	<div class="cont-shopping">
		<div class="all">
			<input type="checkbox" name="" class="checkall" value="" /> <span
				class="s1">全选</span> <span class="s2">商品信息</span> <span class="s4">单价(元)</span>
			<span class="s5">数量</span> <span class="s6">小计</span> <span
				class="s7">操作</span>
		</div>
		<div class="shoppingcart"></div>
		<div class="allt">
			<input type="checkbox" name="" class="checkall" value="" />
			 <span class="s1">全选</span>
			 <button class="s2" onclick="del()" style="font-size: 16px;color: #666;" >批量删除</button>
			 <span class="s3">已选中商品</span>
			<span class="sf">0</span> <span class="s5">件</span> <span class="s6">总价(元)：</span>
			<span class="ss">￥0.00元</span> <a href="javascript:void(0)"
				class="s8" onclick="addorder()">结算</a>
		</div>
		<div class="cl"></div>
	</div>


	<div id="bottom">
		<div id="GLOBAL_FOOTER">
			<div id="footer">
				<div class="links">
					<a rel="nofollow" target="_blank"
						href="//www.jd.com/intro/about.aspx">关于我们</a>|<a rel="nofollow"
						target="_blank" href="//www.jd.com/contact/">联系我们</a>|<a
						rel="nofollow" target="_blank"
						href="//www.jd.com/contact/joinin.aspx">商家入驻</a>|<a rel="nofollow"
						target="_blank" href="//jzt.jd.com">营销中心</a>|<a rel="nofollow"
						target="_blank" href="//app.jd.com/">手机京东</a>|<a target="_blank"
						href="//club.jd.com/links.aspx">友情链接</a>|<a target="_blank"
						href="//media.jd.com/">销售联盟</a>|<a href="//club.jd.com/"
						target="_blank">京东社区</a>|<a href="//gongyi.jd.com" target="_blank">京东公益</a>|<a
						href="//en.jd.com/" target="_blank">English Site</a>|<a
						href="//en.jd.com/help/question-58.html" target="_blank">Contact
						Us</a>
				</div>
				<div class="copyright">
					北京市公安局朝阳分局备案编号110105014669&nbsp;&nbsp;|&nbsp;&nbsp;京ICP证070359号&nbsp;&nbsp;|&nbsp;&nbsp;<a
						target="_blank"
						href="//img14.360buyimg.com/da/jfs/t256/349/769670066/270505/3b03e0bb/53f16c24N7c04d9e9.jpg">互联网药品信息服务资格证编号(京)-经营性-2014-0008</a>&nbsp;&nbsp;|&nbsp;&nbsp;新出发京零&nbsp;字第大120007号<br>
					<a rel="nofollow"
						href="//misc.360buyimg.com/skin/df/i/com/f_music.jpg"
						target="_blank">音像制品经营许可证苏宿批005号</a>&nbsp;&nbsp;|&nbsp;&nbsp;出版物经营许可证编号新出发(苏)批字第N-012号&nbsp;&nbsp;|&nbsp;&nbsp;互联网出版许可证编号新出网证(京)字150号<br>
					<a href="//misc.360buyimg.com/wz/wlwhjyxkz.jpg" target="_blank">网络文化经营许可证京网文[2014]2148-348号</a>&nbsp;&nbsp;违法和不良信息举报电话：4006561155&nbsp;&nbsp;Copyright&nbsp;©&nbsp;2004-2016&nbsp;&nbsp;京东JD.com&nbsp;版权所有<br>
					京东旗下网站：<a href="https://www.jdpay.com/" target="_blank">京东钱包</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
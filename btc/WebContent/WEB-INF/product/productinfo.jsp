<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<title>产品详情</title>
<link rel="stylesheet" type="text/css" href="css/productinfo.css"/>
<link rel="stylesheet" type="text/css" href="css/jdphone.css" />
<script type="text/javascript" src="js/jquery-2.2.4.min.js"></script>
<script type="text/javascript" src="js/jquery.cookie.js"></script>
<script type="text/javascript">
	
	$(function(){
		getcartcount();
	});
	
	function add(){
		
		
		var count = parseInt($("input[name='bycount']").val());
		$.ajax({
			url:"productcount.action",
			type:"post",
			data:{"pid":${param.pid }},
			dataType:"JSON",
			success : function(data){
				if(count<data.pcount){
					$("input[name='bycount']").val(count+1);
				}
			}
		});
		
	}
	
	function sub(){
		var count = parseInt($("input[name='bycount']").val());
		if(count>1){
			$("input[name='bycount']").val(count-1);
		}
	}
	
	function countchange(){
		var count = parseInt($("input[name='bycount']").val());
		
		if(isNaN(count)){
			count = 0;
		}
		$.ajax({
			url:"productcount.action",
			type:"post",
			data:{"pid": ${param.pid }},
			dataType:"JSON",
			success : function(data){
				
				if(count > data.pcount){
					$("input[name='bycount']").val(data.pcount);
				}
				if(count<1&&data.pcount>0){
					$("input[name='bycount']").val(1);
				}else if(data.pcount==0){
					$("input[name='bycount']").val(0);
				}
			}
		});
	}
	
	function putcart(){
		//商品id
		var pid = ${param.pid};
		//数量
		var count = $("input[name='bycount']").val();
		
		//先取cookie
		var ckicart = $.cookie("cart");
		var cart;
		if(ckicart==undefined){
			//当购物车信息为空时，创建一个购物车数组保存信息
			 cart = new Array();
		}else{
			cart = JSON.parse(ckicart);
			
		}
		//如果数组中已有，查找到数据
		
		var exist = false;
		$.each(cart,function(index,item){
			if(item.pid == pid){
				item.count = parseInt(item.count) + parseInt(count);
				
				exist = true;
			}
		});
		
		//创建一个对象
		if(exist==false){
			var product = new Object();
			product.pid= pid;
			product.count= count;
			
			cart.push(product);
		}
		
		
		var str = JSON.stringify(cart);
		
		//保存到cookie中      $.cookie("");去取指定名字的cookie的值      只能保存字符串
		$.cookie("cart",str,{expires:7});//有效期为七天
		
		window.location.href="cart.jsp";
	}

	function getcartcount(){
		//先去cookie中取存有count的cookie
		var ckicart = $.cookie("cart");
		var cart;
		if(ckicart==undefined){
			//当购物车信息为空时，创建一个购物车数组保存信息
			$("#cartnb").text(0);
		}else{
			cart = JSON.parse(ckicart);
			
			var sum = 0;
			for(var i=0; i<cart.length; i++){
				sum += parseInt(cart[i].count);
			}
			$("#cartnb").text(sum);
		}
	}
	
	$(function(){
		$(".op span").attr("href", "javascript:void(0)");
		
		$(".op span").click(function(){
			$(this).siblings().removeClass("redborder");
			$(this).toggleClass("redborder");
		});
	}); 


</script>	
</head>
<body>
	<div class="dd">
			<div class="dd1">
				<div class="dd11"><span class="dd111"></span>京东首页<span class="dd112"></span>北京</div>
				<div class="dd12" style="margin-top: 5px;">
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
					<a href="#">京东会员</a><span>|</span>
					<a href="#">企业采购</a><span>|</span>
					<a href="#">客户服务</a><span>|</span>
					<a href="#">网站导航</a><span>|</span>
					<a href="#">手机京东</a>
				</div>
			</div>
		</div><span class="noclear"></span>
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
			<div class="ssk3">
				<a href="cart.jsp">我的购物车</a>
				<span class="car"></span>
				<span class="qp" id="cartnb">0</span>
			</div>
		</div><span class="noclear"></span>
	<table>
			<tr>
				<td><img class="zhutu" src="upload/${param.ppic }"></td>
				<td><h1 class="a">${param.pname }</h1>
					<p class="b">${param.pdept }</p>
					<p class="c">&nbsp;&nbsp;&nbsp;价&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;格<span>&nbsp;&nbsp;<span class="j">¥</span>${param.pprice }.00元</span><br/><br/>
						      &nbsp;&nbsp;&nbsp;促&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;销&nbsp;&nbsp;
						<span class="A">赠送积分</span> 购买即赠商城积分，积分可抵现~
					</p>
					<p class="d"><span>库存</span>${param.pcount }<span class="f">|</span><span>销量</span>${param.psales }</p>
					<p class="e">商品编码<span>${param.pid }</span></p>
					
					 <div class="op">
					 	 选择颜色
						 <span><a href="javascript:void(0)">幻影紫</a></span>
					  	 <span ><a href="javascript:void(0)">幻影蓝</a></span>
					   	 <span><a href="javascript:void(0)">幻夜黑</a></span>
					     <span><a href="javascript:void(0)">幻夜黑</a></span> 
					     <span><a href="javascript:void(0)">海鸥灰</a></span><br/><br/><br/>
					</div>
					<div class="op">
						选择版本  
						 <span ><a href="javascript:void(0)">全网通 6GB+64GB</a></span>
						 <span><a href="javascript:void(0)">全网通 6GB+128GB</a></span> <br/><br/><br/>
					</div>
					<div class="op">
						选择套餐 
						  <span><a href="javascript:void(0)">官方标配</a></span> 
						  <span><a href="javascript:void(0)">套餐一</a></span> 
						  <span><a href="javascript:void(0)">套餐二</a></span><br/><br/><br/>
					</div>
					<div class="op">
						保障服务  
						<span><a href="javascript:void(0)">可选保障服务</a></span><br/><br/><br/><br/>
					</div>
					
					<div class="by">
					<c:if test="${param.pcount>0 }">
					<input type="text" class="bycount" name="bycount" value="1" onchange="countchange()" />
					</c:if>
					<c:if test="${param.pcount==0 }">
					<input type="text" class="bycount" name="bycount" value="0" onchange="countchange()" />
					</c:if>
					<button class="zeng" onclick="add()">+</button>
					<button class="jian" onclick="sub()">-</button>
					</div>
					<c:if test="${param.pcount==0 }">
					<button  class="shopping1" >到货通知</button>
					</c:if>
					<c:if test="${param.pcount>0 }">
					<button class="shopping" onclick="putcart()">加入购物车</button>
					</c:if>
					</td>
				</tr>
			
			</table>

		  <div id="bottom">
		    <div class="slogen"> </div>
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
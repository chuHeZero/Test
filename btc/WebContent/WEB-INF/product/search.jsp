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
<title>产品分类</title>
<link rel="stylesheet" type="text/css" href="css/jdphone.css" />
<link href="css/style.css" rel="stylesheet"/>
<script type="text/javascript" src="js/jquery-2.2.4.min.js"></script>
<script type="text/javascript" src="js/jquery.cookie.js"></script>
<script type="text/javascript">
		
		
		

	var pname="${param.pname}";
	
	$(function(){
		
		getproduct(1,0,0);	
		getFType();
		getSType(null);
		getcartcount();
	});
	
	function getSType(ptid){
		$.ajax({
			url : "getSType.action",
			type:"post",
			data:{"ptid":ptid},
			dataType:"JSON",
			success : function(data) {
				
				var html= "";
				$.each(data,function(index,item){
					
					html+="<div class=\"ftypeitem\"><a href=\"javascrpit:void(0)\"onclick=\"getproduct(1,0,"+item.tid+");\">"+item.tname+"</a></div>";
				});
				$("#stype").html(html);
			}
			
		});
		getproduct(1,ptid,0);
	}
	
	function getFType(){
		$.ajax({
			url : "getFType.action",
			type:"post",
			data:{},
			dataType:"JSON",
			success : function(data) {
				
				var html= "";
				$.each(data,function(index,item){
					
					html+="<div class=\"ftypeitem\"><a href=\"javascrpit:void(0)\" onclick=\"getSType("+item.tid+")\">"+item.tname+"</a></div>";
				});
				$("#ftype").html(html);
			}
			
		});
	}
	
	
	function getproduct(curpage,pftype,pstype){
		//var pname = $("#pname").val();
		//var pftype = $("#pftype").val();
		//var pstype = $("#pstype").val();
		
		
		$.ajax({
			url : "selectAll.action",
			type : "post",
			data : {"pname": pname,"pftype":pftype,"pstype":pstype,"pagerows":8, "curpage": curpage},
			dataType : "JSON",
			success : function(data){
				
				//显示数据
				var html = "";
				$.each(data.list,function(index,item){
					html+=
				"<div class=\"sj1\">"+
						"<img class=\"sj11\" src=\"upload/"+item.ppic+"\" />"+
						
						"<a class=\"sj13\" href=\"productinfo.action?pid="+item.pid+"&pname="+item.pname+"&pdept="+item.pdept+"&pprice="+item.pprice+"&pcount="+item.pcount+"&pftype="+item.pftype+"&pstype="+item.pstype+"&ppic="+item.ppic+"&pstatus="+item.pstatus+"&psales="+item.psales+"\">"+item.pname+item.pdept+"</a>"+
	
						"<div class=\"sj14\">"+
						"<div class=\"sj12\">￥"+item.pprice+"元&nbsp;&nbsp;&nbsp;&nbsp;库存:"+item.pcount+"件</div>"+
						"<a href=\"productinfo.action\" style=\"color: blue;\">"+item.psales+"</a>条评价</div>"+
				"</div>";
				});
				html+="<div class=\"clear\"></div>";
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
	
	
</script>
</head>
<body>
	<div class="dd">
			<div class="dd1">
				<div class="dd11"><span class="dd111"></span><a href="index.jsp">京东首页</a><span class="dd112"></span>北京</div>
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
					<a href="javascript:void(0)">京东会员</a><span>|</span>
					<a href="javascript:void(0)">企业采购</a><span>|</span>
					<a href="javascript:void(0)">客户服务</a><span>|</span>
					<a href="javascript:void(0)">网站导航</a><span>|</span>
					<a href="javascript:void(0)">手机京东</a>
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
					<a href="javascript:void(0)">手机京东自营</a><span>|</span>
					<a href="javascript:void(0)">华为手机</a><span>|</span>
					<a href="javascript:void(0)">苹果</a><span>|</span>
					<a href="javascript:void(0)">小米</a><span>|</span>
					<a href="javascript:void(0)">华为</a><span>|</span>
					<a href="javascript:void(0)">vivo</a><span>|</span>
					<a href="javascript:void(0)">oppo</a><span>|</span>
					<a href="javascript:void(0)">老人手机</a><span>|</span>
					<a href="javascript:void(0)">小米8</a><span>|</span>
					<a href="javascript:void(0)">三星</a><span>|</span>
					<a href="javascript:void(0)">小米手机</a><span>|</span>
					<a href="javascript:void(0)">魅族</a><span>|</span>
					<a href="javascript:void(0)">小米6</a>
				</div>
			</div>
			<div class="ssk3">
				<a href="cart.jsp">我的购物车</a>
				<span class="car"></span>
				<span class="qp" id="cartnb">0</span>
			</div>
		</div><span class="noclear"></span>
		<div class="cd">
			<ul>
				<li>
					<a href="search.action" name='cd1'>全部商品分类</a>
					<div class="kk">
						<div class="kkk">
							<ul>
								<a href="javascript:void(0)">家用电器</a>
							</ul>
						</div>
						<div class="kkk">
							<ul>
								<a href="javascript:void(0)">手机/运营商/数码</a>
							</ul>
						</div>
						<div class="kkk">
							<ul>
								<a href="javascript:void(0)">电脑/办公</a>
							</ul>
						</div>
						<div class="kkk">
							<ul>
								<a href="javascript:void(0)">家居/家具/家装/厨具</a>
							</ul>
						</div>
						<div class="kkk">
							<ul>
								<a href="javascript:void(0)">男装/女装/童装/内衣</a>
							</ul>
						</div>
						<div class="kkk">
							<ul>
								<a href="javascript:void(0)">美妆/个护清洁/宠物</a>
							</ul>
						</div>
						<div class="kkk">
							<ul>
								<a href="javascript:void(0)">女鞋/箱包/钟表/珠宝</a>
							</ul>
						</div>
					</div>

				</li>
				<li>
					<a href="javascript:void(0)" name='cd3'>京东服饰</a>
				</li>
				<li>
					<a href="javascript:void(0)" name='cd3'>美妆馆</a>
				</li>
				<li>
					<a href="javascript:void(0)" name='cd3'>企业采购</a>
				</li>
				<li>
					<a href="javascript:void(0)" name='cd3'>超市生鲜</a>
				</li>
				<li>
					<a href="javascript:void(0)" name='cd3'>全球购闪购</a>
				</li>
				<li>
					<a href="javascript:void(0)" name='cd3'>拍卖金融</a>
				</li>
			</ul>
		</div>
		<div class="hx"></div>
		<div class="tb">
			<div class="tb1">
				<div class="tb11">大分类</div>
				<div class="tb12" id="ftype">
					
				</div>
			</div>
			<div class="tb1">
				<div class="tb11">小分类</div>
				<div class="tb12" id="stype">
				
				</div>
			</div>
			<div class="tb2">
				<div class="tb21"><span>机身内存：</span></div>
				<div class="tb22">
					<a href="javascript:void(0)">8GB以下</a>
					<a href="javascript:void(0)">8GB</a>
					<a href="javascript:void(0)">16GB</a>
					<a href="javascript:void(0)">32GB</a>
					<a href="javascript:void(0)">64GB</a>
					<a href="javascript:void(0)">128GB</a>
					<a href="javascript:void(0)">256</a>
					<a href="javascript:void(0)">512GB</a>
					<a href="javascript:void(0)">支持内存卡</a>
				</div>
			</div>
			<div class="tb2">
				<div class="tb21"><span>cpu核数：</span></div>
				<div class="tb22">
					<a href="javascript:void(0)">八核</a>
					<a href="javascript:void(0)">四核</a>
					<a href="javascript:void(0)">十核</a>
					<a href="javascript:void(0)">单核</a>
					<a href="javascript:void(0)">双核</a>
					<a href="javascript:void(0)">功能机</a>
					<a href="javascript:void(0)">双四核</a>
					<a href="javascript:void(0)">其他</a>
				</div>
			</div>
			<div class="tb2">
				<div class="tb21"><span>运行内存：</span></div>
				<div class="tb22">
					<a href="javascript:void(0)">2GB以下</a>
					<a href="javascript:void(0)">2GB</a>
					<a href="javascript:void(0)">4GB</a>
					<a href="javascript:void(0)">6GB</a>
					<a href="javascript:void(0)">8GB</a>
				</div>
			</div>
			<div class="tb3">
				<div class="tb31"><span>高级选项：</span></div>
				<div class="tb32">
					<a href="javascript:void(0)">网络</a>
					<a href="javascript:void(0)">分辨率</a>
					<a href="javascript:void(0)">屏幕尺寸</a>
					<a href="javascript:void(0)">系统</a>
					<a href="javascript:void(0)">电池容量</a>
				</div>
			</div>
		</div>
		<div class="sj" id="productall">
			
		</div>
		<div class="sj" id="page">
			
		</div>
		
		
		  <div id="bottom">
		    <div class="slogen"> </div>
		    <div id="GLOBAL_FOOTER">
		      <div id="footer">
		        <div class="links"> <a rel="nofollow" target="_blank">关于我们</a>|<a rel="nofollow" target="_blank" >联系我们</a>|<a rel="nofollow" target="_blank" href="//www.jd.com/contact/joinin.aspx">商家入驻</a>|<a rel="nofollow" target="_blank">营销中心</a>|<a rel="nofollow" target="_blank" >手机京东</a>|<a target="_blank" >友情链接</a>|<a target="_blank" >销售联盟</a>|<a  target="_blank">京东社区</a>|<a  target="_blank">京东公益</a>|<a  target="_blank">English Site</a>|<a  target="_blank">Contact Us</a> </div>
		        <div class="copyright"> 北京市公安局朝阳分局备案编号110105014669&nbsp;&nbsp;|&nbsp;&nbsp;京ICP证070359号&nbsp;&nbsp;|&nbsp;&nbsp;<a target="_blank" href="//img14.360buyimg.com/da/jfs/t256/349/769670066/270505/3b03e0bb/53f16c24N7c04d9e9.jpg">互联网药品信息服务资格证编号(京)-经营性-2014-0008</a>&nbsp;&nbsp;|&nbsp;&nbsp;新出发京零&nbsp;字第大120007号<br>
		          <a rel="nofollow"  target="_blank">音像制品经营许可证苏宿批005号</a>&nbsp;&nbsp;|&nbsp;&nbsp;出版物经营许可证编号新出发(苏)批字第N-012号&nbsp;&nbsp;|&nbsp;&nbsp;互联网出版许可证编号新出网证(京)字150号<br>
		          <a  target="_blank">网络文化经营许可证京网文[2014]2148-348号</a>&nbsp;&nbsp;违法和不良信息举报电话：4006561155&nbsp;&nbsp;Copyright&nbsp;©&nbsp;2004-2016&nbsp;&nbsp;京东JD.com&nbsp;版权所有<br>
		          京东旗下网站：<a target="_blank">京东钱包</a> </div>
		      </div>
		    </div>
		  </div>
</body>
</html>
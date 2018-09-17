<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%   
    String path = request.getContextPath();   
    String basePath = request.getScheme()+"://" +request.getServerName()+":" +request.getServerPort()+path+"/" ;   
    //System.out.println("path="+path);
    //System.out.println("basePath="+basePath);
%>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

	<head>
		<base href="<%=basePath%>" >
		<meta charset="utf-8" />
		<title>京东首页</title>
		<link rel="stylesheet" href="bootstrap-3.3.7-dist/css/bootstrap.css" />
		<link rel="stylesheet" type="text/css" href="css/JDnav.css" />
		<script type="text/javascript" src="js/jquery-2.2.4.min.js"></script>
		<script type="text/javascript" src="bootstrap-3.3.7-dist/js/bootstrap.js"></script>
		<script type="text/javascript" src="js/JDnav.js" ></script> 
		<script type="text/javascript" src="js/jquery.cookie.js"></script>
	</head>

	<body>
		<div class="navbg">
			<div class="nav">
				<div class="navleft">
					<a class="glyphicon glyphicon-map-marker" href="#">配送至:北京</a>
					<div class="citylist">
						<a>北京</a>
						<a>上海</a>
						<a>广东</a>
						<a>浙江</a>
						<a>江苏</a>
						<a>山东</a>
						<a>湖南</a>
						<a>湖北</a>
						<a>河南</a>
						<a>河北</a>
					</div>
				</div>
				<div class="navright">
					<c:if test="${sessionScope.user !=null }">
						<a href="javascript:void(0)">你好，${sessionScope.user.uname }</a>
						<a href="UserController/logout.action">退出</a>
					</c:if>
					<c:if test="${sessionScope.user ==null }">
						<a href="login.jsp">你好，请登录</a>
						<a href="register.jsp">免费注册</a>
					</c:if>	
					<span>|</span>
					<div class="wjd">
						<a href="javascript:void(0)"  class="glyphicon glyphicon-user" >我的京东</a>
						<div class="citylist">
							<a href="UserController/center.action">修改个人信息</a>
							<a href="UserController/updatepwd.action">修改密码</a>
							<a href="UserController/updatemoney.action">账户充值</a>
						</div>
					</div>
					<span>|</span>
					<a href="UserController/ddxq.action">我的订单</a>
					<span>|</span>
					<a href="javascript:void(0)">京东会员</a>
					<span>|</span>
					<a href="javascript:void(0)">企业采购</a>
					<span>|</span>
					<a href="javascript:void(0)">客户服务</a>
					<span>|</span>
					<a href="javascript:void(0)">网站导航</a>
					<span>|</span>
					<a href="javascript:void(0)">手机京东</a>
				</div>
				<div class="clear"></div>
			</div>
		</div>
		<div class="search">
			<a href="javascript:void(0)" class="logo"></a>
			<div class="searchachar">
				<div class="searchbar">
					<div class="searchinput">
					<form action="search.action" method="post">
						<input type="text" name="pname" />
						<span class="glyphicon glyphicon-camera"> </span>
						<button type="submit" class="glyphicon glyphicon-search" ></button>
					</form>
					</div>
					<div class="cart">
						<a href="cart.jsp" class="glyphicon glyphicon-shopping-cart">我的购物车</a>
						<span id="cartnb">0</span>
					</div>
				</div>
				<div class="cp">
					<a href="javascript:void(0)">Apple产品</a>
					<a href="javascript:void(0)">Find X</a>
					<a href="javascript:void(0)">智能手表</a>
					<a href="javascript:void(0)">笔记本</a>
					<a href="javascript:void(0)">买1送1</a>
					<a href="javascript:void(0)">世界杯大牌</a>
					<a href="javascript:void(0)">乐器</a>
					<a href="javascript:void(0)">坚果手机</a>
					<a href="javascript:void(0)">家具狂欢</a>
				</div>
				<div class="ms">
					<a id="msa" href="javascript:void(0)">秒杀</a>
					<a id="msa" href="javascript:void(0)">优惠券</a>
					<a id="msa" href="javascript:void(0)">PLUS会员</a>
					<a id="msa" href="javascript:void(0)">闪购</a>
					<a id="msa" href="javascript:void(0)">拍卖</a>
					<a id="msa" href="javascript:void(0)">京东服饰</a>
					<a id="msa" href="javascript:void(0)">京东超市</a>
					<a id="msa" href="javascript:void(0)">生鲜</a>
					<a id="msa" href="javascript:void(0)">全球购</a>
					<a id="msa" href="javascript:void(0)">京东金融</a>
				</div>
			</div>
		</div>
		<div class="clear">
			
		</div>
		<div class="type">
			<div class="productlist">
			<ul>
				<li><a href="#">家用电器</a><ul><li>电视</li><li>空调</li><li>洗衣机</li></ul></li>
				<li><a href="#">手机 </a>/<a href="#">运营商</a>/<a href="#">数码</a><ul><li>电视</li><li>可同</li><li>洗衣机</li></ul></li>
				<li><a href="#">电脑</a>/<a href="#">办公</a></li>
				<li><a href="#">家居</a>/<a href="#">家具</a>/<a href="#">家装</a>/<a href="#">厨具</a><ul><li>电视</li><li>可同</li><li>洗衣机</li></ul></li>
				<li><a href="#">男装</a>/<a href="#">女装</a>/<a href="#">童装</a>/<a href="#">内衣</a><a href="#"></a><ul><li>电视</li><li>可同</li><li>洗衣机</li></ul></li>
				<li><a href="#">美妆 </a>/<a href="#">个护清洁</a>/<a href="#">宠物</a><ul><li>电视</li><li>可同</li><li>洗衣机</li></ul></li>
				<li><a href="#">女鞋</a>/<a href="#">箱包</a>/<a href="#">钟表</a>/<a href="#">厨具</a><ul><li>珠宝</li><li>可同</li><li>洗衣机</li></ul><a href="#"></a></li>
				<li><a href="#">手机 </a>/<a href="#">运营商</a>/<a href="#">数码</a><ul><li>电视</li><li>可同</li><li>洗衣机</li></ul></li>
				<li><a href="#">手机 </a>/<a href="#">运营商</a>/<a href="#">数码</a><ul><li>电视</li><li>可同</li><li>洗衣机</li></ul></li>
				<li><a href="#">手机 </a>/<a href="#">运营商</a>/<a href="#">数码</a><ul><li>电视</li><li>可同</li><li>洗衣机</li></ul></li>
				<li><a href="#">手机 </a>/<a href="#">运营商</a>/<a href="#">数码</a><ul><li>电视</li><li>可同</li><li>洗衣机</li></ul></li>
				<li><a href="#">手机 </a>/<a href="#">运营商</a>/<a href="#">数码</a><ul><li>电视</li><li>可同</li><li>洗衣机</li></ul></li>
				<li><a href="#">手机 </a>/<a href="#">运营商</a>/<a href="#">数码</a><ul><li>电视</li><li>可同</li><li>洗衣机</li></ul></li>
				<li><a href="#">手机 </a>/<a href="#">运营商</a>/<a href="#">数码</a><ul><li>电视</li><li>可同</li><li>洗衣机</li></ul></li>
				<li><a href="#">手机 </a>/<a href="#">运营商</a>/<a href="#">数码</a><ul><li>电视</li><li>可同</li><li>洗衣机</li></ul></li>
				<li><a href="#">手机 </a>/<a href="#">运营商</a>/<a href="#">数码</a><ul><li>电视</li><li>可同</li><li>洗衣机</li></ul></li>
				<li><a href="#">手机 </a>/<a href="#">运营商</a>/<a href="#">数码</a><ul><li>电视</li><li>可同</li><li>洗衣机</li></ul></li>
			</ul>
			</div>
			<div class="imglist">
				<img src="img/1.jpg"/>
				<img src="img/2.jpg"/>
				<img src="img/3.jpg"/>
				<img src="img/4.jpg"/>
				<button onclick="listimg()" id="btnleft" class="glyphicon glyphicon-chevron-left"></button>
				<button onclick="nextimg()" id="btnright" class="glyphicon glyphicon-chevron-right"></button>
			
			<div class="imgpoint">
				<i onmouseover="showimgbyindex(1)"></i>
				<i onmouseover="showimgbyindex(2)"></i>
				<i onmouseover="showimgbyindex(3)"></i>
				<i onmouseover="showimgbyindex(4)"></i>
			</div>			
			</div>
			<div class="imgad">
				<img src="img/ad1.jpg" />
				<img src="img/ad2.jpg" />
				<img src="img/ad3.jpg" />
			</div>
			<div class="info">
				<div class="user">
					<div class="imgtx">
						<img src="img/tx.jpg"/>
					</div>
					<div class="dlu">
						<h5> Hi, <a href="#">${sessionScope.user.uname }</a> </h5>
						<c:if test="${sessionScope.user !=null }">
					<a href="UserController/center.action">你好，${sessionScope.user.uname }</a>
					<a href="UserController/logout.action">退出</a>
				</c:if>
				
				<c:if test="${sessionScope.user ==null }">
					<h5>欢迎来到京东! </h5>
					<a href="login.jsp">登录</a>
					<a href="register.jsp">免费注册</a>
				</c:if>	
					</div>
					<div class="fli">
						<a class="xrfl" href="//xinren.jd.com/?channel=99" target="_blank" clstag="h|keycount|head|login_02">新人福利</a>
						<a class="userplus" href="//plus.jd.com/index?flow_system=appicon&amp;flow_entrance=appicon3&amp;flow_channel=pc" target="_blank" >PLUS会员</a>
					</div>
				</div>
				<div class="news">
					<a href="#">促销</a>
					<span>|</span>
						<a href="#">公告</a>
						<a id="gd" href="#">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;更多</a>
					</div>
					<div class="nr">
						<ul class="news_list">
							<li class="news_item">
								<a href="//www.jd.com/news.aspx?id=37090" target="_blank">京东PLUS会员权益更新及会费...</a>
							</li>
							<li class="news_item">
								<a href="//www.jd.com/news.aspx?id=36374" target="_blank">京东启用全新客服电话“950618”</a>
							</li>
							<li class="news_item">
								<a href="//www.jd.com/news.aspx?id=36083" target="_blank">关于召回普利司通（天津）轮...</a>
							</li>
							<li class="news_item">
								<a href="//www.jd.com/news.aspx?id=35887" target="_blank">京东物流推出配送员统一外呼...</a>
							</li>
						</ul>
					</div>
					<div class="buhui">
						<img src="img/buhuizuo.png" />
					</div>
				</div>
		</div>
		<div class="clear"></div>
			<div class="msjs">
				<div class="dr">
					<div class="ds">
						<a href="//miaosha.jd.com" target="_blank">
							<div class="jdms">京东秒杀</div>
							<div class="flde">FLASH DEALS</div>
							<i class="sda"></i>
							<div class="time">本场距离结束还剩</div>
							<!--<div class="jsq">
								<img src="img/jsq.png" />
							</div>-->
						</a>
					</div>
				<div class="sk_bd">
					<div class="sk_bdimg">
						<img src="img/QQ截图20180629214703.png"/>
						<img src="img/QQ截图20180629214534.png"/>
						<img src="img/QQ截图20180629214550.png"/>
						<img src="img/QQ截图20180629214611.png"/>
						<img src="img/QQ截图20180629214645.png"/>
						<img src="img/QQ截图20180629214703.png"/>
						<img src="img/QQ截图20180629214534.png"/>
					</div>
					<div onclick="skbdlastImg()" class="glyphicon glyphicon-chevron-left" id="sk_bdleft"></div>
					<div onclick="skbdnextImg()" class="glyphicon glyphicon-chevron-right" id="sk_bdright"></div>
				</div>
				<div class="sk_chn">
					<div class="chnimg">
						<img src="img/211.jpg"/>
						<img src="img/222.jpg"/>
						<img src="img/211.jpg"/>
					</div>
					<div class="point">
						<div></div>
						<div></div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="servicebg">
			<div class="service">
				<div class="service_inner">
					<img src="img/dia.png"/>
				</div>
			</div>
		</div>
		<div class="helpbg">
			<div class="help">
				<div class="help_inner">
					<div class="help_list">
						<h5>购物指南</h5>
						<ul>
							<li><a href="#" id="red">购物流程</a></li>
							<li><a href="#" id="red">会员介绍</a></li>
							<li><a href="#" id="red">生活旅行</a></li>
							<li><a href="#" id="red">常见问题</a></li>
							<li><a href="#" id="red">大家电</a></li>
							<li><a href="#" id="red">联系客服</a></li>
						</ul>
					</div>
					<div class="help_list">
						<h5>配送方式</h5>
						<ul>
							<li><a href="#" id="red">上门自提</a></li>
							<li><a href="#" id="red">211限时达</a></li>
							<li><a href="#" id="red">配送服务查询</a></li>
							<li><a href="#" id="red">配送费收取标准</a></li>
							<li><a href="#" id="red">海外配送</a></li>
						</ul>
					</div>
					<div class="help_list">
						<h5>支付方式</h5>
						<ul>
							<li><a href="#" id="red">货到付款</a></li>
							<li><a href="#" id="red">在线支付</a></li>
							<li><a href="#" id="red">分期付款</a></li>
							<li><a href="#" id="red">邮局汇款</a></li>
							<li><a href="#" id="red">公司转账</a></li>
						</ul>
					</div>
					<div class="help_list">
						<h5>售后服务</h5>
						<ul>
							<li><a href="#" id="red">售后政策</a></li>
							<li><a href="#" id="red">价格保护</a></li>
							<li><a href="#" id="red">退款说明</a></li>
							<li><a href="#" id="red">返修/退换货</a></li>
							<li><a href="#" id="red">取消订单</a></li>
						</ul>
					</div>
					<div class="help_list">
						<h5>特色服务</h5>
						<ul>
							<li><a href="#" id="red">夺宝岛</a></li>
							<li><a href="#" id="red">DIY装机</a></li>
							<li><a href="#" id="red">延保服务</a></li>
							<li><a href="#" id="red">京东E卡</a></li>
							<li><a href="#" id="red">京东通信</a></li>
							<li><a href="#" id="red">京东JD+</a></li>
						</ul>
					</div>
					<div class="help_cover">
						<h5>京东自营覆盖区县</h5>
						<div class="con">
							京东已向全国2661个区县提供自营配送服务，支持货到付款、POS机刷卡和售后上门服务。
						</div>
						<a href="#" id="red">查看详情></a>
					</div>
				</div>
			</div>
		</div>
		<div class="linkbg">
			<div class="link">
				<div class="link_inner">
					<a href="#" id="red">关于我们</a>
					<span>|</span>
					<a href="#" id="red">联系我们</a>
					<span>|</span>
					<a href="#" id="red">联系客服</a>
					<span>|</span>
					<a href="#" id="red">合作招商</a>
					<span>|</span>
					<a href="#" id="red">商家帮助</a>
					<span>|</span>
					<a href="#" id="red">营销中心</a>
					<span>|</span>
					<a href="#" id="red">手机京东</a>
					<span>|</span>
					<a href="#" id="red">友情链接</a>
					<span>|</span>
					<a href="#" id="red">销售联盟</a>
					<span>|</span>
					<a href="#" id="red">京东社区</a>
					<span>|</span>
					<a href="#" id="red">风险监测</a>
						<span>|</span>
					<a href="#" id="red">隐私政策</a>
					<span>|</span>
					<a href="#" id="red">京东公益</a>
					<span>|</span>
					<a href="#" id="red">English Site</a>
					<span>|</span>
					<a href="#" id="red">Media IR</a>
				</div>
			</div>
		</div>
		<div class="copyrightbg">
			<div class="copyright">
				<div class="copyright_inner">
					<img src="img/QQ截图20180630130310.png"/>
				</div>
			</div>
		</div>
	    <div class="interval">
			<span class="interval1"></span>
			<span class="interval2"></span>
			<span class="interval3"></span>
		</div>
	</body>

</html>
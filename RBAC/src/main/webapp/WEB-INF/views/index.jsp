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
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<title>客户及销售管理系统</title>
<link rel="stylesheet" href="layui/css/layui.css">
<link rel="stylesheet" href="css/style.css">
<script src="layui/layui.js"></script>
<script type="text/javascript" src="js/jquery-2.2.4.min.js"></script>
<script type="text/javascript">
	//JavaScript代码区域

	$(function() {
		//创建webscoket
		var url = 'ws://' + window.location.host + "/RBAC/msgScoket.action";
		var socket = new WebSocket(url);
		
		socket.onmessage = function(msg){
			//当用户接收到消息时，可以根据消息的内容，修改气泡
			var message = JSON.parse(msg.data);
			
			var count = parseInt($(".msg-count").text());
			
			count++;
			
			$(".msg-count").text(count);
			alert(message.msg);
		}
		
		$.ajax({
			url : "view/getmenu.action",
			type : "post",
			data : {},
			dataType : "JSON",
			success : function(menus) {
				$.each(menus, function(index, menu) {

					if (menu.pmid == 0) {
						//构造一级菜单
						var p = $(".menu_parent").clone();

						//防止叠加生成
						p.removeClass("menu_parent");
						p.find("i").addClass(menu.menuimg);
						p.find(".menuname").text(menu.mname);

						//二级菜单项
						$.each(menus, function(index, child) {

							if (child.pmid == menu.mid) {

								var c = $(".menu_child").clone();

								//防止叠加生成
								c.removeClass("menu_child");

								c.find(".menuname").text(child.mname);
								c.find("i").addClass(child.menuimg);
								c.find("a").attr("onclick",
										"updateview('" + child.murl + "')");

								p.find(".layui-nav-child").append(c);
							}
						});

						$(".menu_context").append(p);
					}
				});

				layui.use('element', function() {
					var element = layui.element;

				});
			}
		});
	});

	function updateview(viewurl) {

		$.ajax({
			url : viewurl,
			type : "post",
			dataType : "HTML",
			success : function(h) {
				$("#jsp_context").html(h)
			}

		});
	}
	
	function myinfo() {
		$.ajax({
			url : 'view/Myinfo.action',
			type : "post",
			dataType : "HTML",
			success : function(h) {
				$("#jsp_context").html(h)
			}

		});
	}
	
	function updatepwd() {
		$.ajax({
			url : 'view/updatepwd.action',
			type : "post",
			dataType : "HTML",
			success : function(h) {
				$("#jsp_context").html(h)
			}

		});
	}
	
	function messinfo() {
		$.ajax({
			url : 'view/getMessInfo.action',
			type : "post",
			dataType : "HTML",
			success : function(h) {
				$("#jsp_context").html(h)
			}

		});
	}
	
	/* layui.use('layer', function(){ //独立版的layer无需执行这一句
		 var $ = layui.jquery, layer = layui.layer; //独立版的layer无需执行这一句
		  
		  //触发事件
		  var active = {
		   offset: function(othis){
		      var type = othis.data('type')
		      ,text = othis.text();
		      
		      layer.open({
		        type: 2
		        ,offset: type //具体配置参考：http://www.layui.com/doc/modules/layer.html#offset
		        ,id: 'layerDemo'+type //防止重复弹出
		        ,content: '<div style="padding: 20px 100px;">'+ text +'</div>'
		        ,btn: '关闭全部'
		        ,btnAlign: 'c' //按钮居中
		        ,shade: 0 //不显示遮罩
		        ,yes: function(){
		          layer.closeAll();
		        }
		      });
		    }
		  };
		  
		  $('.msglist').onclick(function(){
		    var othis = $(this), method = othis.data('method');
		    active[method] ? active[method].call(this, othis) : '';
		  });
		  
		}); */
	
</script>
</head>
<body class="layui-layout-body">
	<div class="layui-layout layui-layout-admin">
		<div class="layui-header">
			<div class="layui-logo">客户及销售管理系统</div>
			<!-- 头部区域（可配合layui已有的水平导航） -->
			<ul class="layui-nav layui-layout-left">
			 <li class="layui-nav-item ">
			 	<a href="view/index.action" class="layui-icon layui-icon-home" style="font-size: 15px; color: #E8E8E8;">首页</a>
			 </li>
			 <!-- <li class="layui-nav-item layui-nav-itemed">
				<a href="javascript:;">
			    	<i class="layui-icon layui-icon-component" style="font-size: 15px; color: #E8E8E8;">产品管理</i>
				</a>
			 </li> -->
			<!-- <li class="layui-nav-item layui-nav-itemed">
				<a href="javascript:;">
					<i class="layui-icon layui-icon-user" style="font-size: 15px; color: #E8E8E8;">客户管理</i>
				</a>
			</li> -->
			</ul>
			<ul class="layui-nav layui-layout-right">
				<li class="layui-nav-item"><a href="javascript:;"> <img
						src="img/acc.JPG" class="layui-nav-img">
						${sessionScope.staff.sname }
				</a>
					<dl class="layui-nav-child">
						<dd>
							<a href="javascript:;" onclick="myinfo();">个人资料</a>
						</dd>
						<dd>
							<a href="javascript:;" onclick="updatepwd();"> <i class="layui-icon layui-icon-set"
								style="font-size: 15px; color: #ghostwhite;"></i>安全设置
							</a>
						</dd>
					</dl></li>
					<li class="layui-nav-item"><a href="javascript:;" data-method="offset" data-type="rb" class="msglist">消息<span class="layui-badge msg-count">0</span></a></li>
				<li class="layui-nav-item"><a href="view/logout.action">退出系统</a></li>
			</ul>
		</div>

		<div class="layui-side layui-bg-black">
			<div class="layui-side-scroll">
				<!-- 左侧导航区域（可配合layui已有的垂直导航） -->
				<ul class="layui-nav layui-nav-tree menu_context" lay-filter="test">

				</ul>
			</div>
		</div>

		<div class="layui-body">
			<!-- 内容主体区域 -->
			<div id="jsp_context" style="padding: 15px;">

				<!-- 引入Echarts.js -->
				<script type="text/javascript" src="js/echarts.js"></script>

				<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
				<div id="main" style="width: 1300px; height: 400px;"></div>
				<div id="yeji" style="width: 1300px; height: 400px;"></div>
				<script type="text/javascript">
				
					// 基于准备好的dom，初始化echarts实例
					var myChart = echarts.init(document.getElementById('main'));

					$.ajax({
						url : "Product/getSalesCount.action",
						type : "post",
						dataType : "JSON",
						success : function(data) {

							var pnames = new Array();
							var counts = new Array();

							$.each(data, function(index, item) {
								pnames.push(item.pname);
								counts.push(item.amcount);
							});

							// 指定图表的配置项和数据
							var option = {
								title : {
									text : '产品销量'
								},
								grid : {
									top : 50,
									x : 45,
									x2 : 30,
									y2 : 80,
								},
								tooltip : {},
								legend : {
									data : [ '销量' ]
								},
								xAxis : {
									data : pnames,
									axisLabel : {
										interval : 0,//横轴信息全部显示
										rotate : -30,//-30度角倾斜显示  
									},
								},
								yAxis : {},
								series : [ {
									name : '销量',
									type : 'bar',
									data : counts
								} ]
							};

							// 使用刚指定的配置项和数据显示图表。
							myChart.setOption(option);
						}
					});
					// 基于准备好的dom，初始化echarts实例
					var myCharta = echarts.init(document.getElementById('yeji'));

					$.ajax({
						url : "Staff/getStaffCount.action",
						type : "post",
						dataType : "JSON",
						success : function(data) {

							var snames = new Array();
							var counts = new Array();

							$.each(data, function(index, item) {
								snames.push(item.sname);
								counts.push(item.amcount);
							});

							// 指定图表的配置项和数据
							var option = {
								title : {
									text : '员工业绩'
								},
								grid : {
									top : 50,
									x : 45,
									x2 : 30,
									y2 : 80,
								},
								tooltip : {},
								legend : {
									data : [ '销量' ]
								},
								xAxis : {
									data : snames,
									axisLabel : {
										interval : 0,//横轴信息全部显示
										rotate : -30,//-30度角倾斜显示  
									},
								},
								yAxis : {},
								series : [ {
									name : '销量',
									type : 'bar',
									data : counts
								} ]
							};

							// 使用刚指定的配置项和数据显示图表。
							myCharta.setOption(option);
						}
					});
				</script>
			</div>
		</div>

		<div class="layui-footer">
			<!-- 底部固定区域 -->
			<h3>山东青岛燕德宝4S店</h3><h4>© 2016 - 2017 ADMIN - MATERIAL DESIGN.Version: 1.0.5</h4>
		</div>
	</div>


	<!-- 一级菜单样式 -->
	<li class="layui-nav-item  menu_parent"><a class=""
		href="javascript:;"> <i class="layui-icon"
			style="font-size: 20px; color: #E8E8E8;"></i> <span class="menuname"></span>
	</a>
		<dl class="layui-nav-child">

		</dl></li>

	<!-- 二级菜单样式 -->
	<dd class="menu_child">
		<a href="javascript:;" class="child_action"> <i class="layui-icon"
			style="font-size: 15px; color: #E8E8E8;"></i> <span class="menuname"></span>
		</a>
	</dd>

</body>
</html>
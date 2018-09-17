<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<title>Insert title here</title>
<link rel="stylesheet" href="layui/css/layui.css">
<script src="layui/layui.js"></script>
<script type="text/javascript" src="js/jquery-2.2.4.min.js"></script>
<script type="text/javascript">

	$(function(){
		//JavaScript代码区域
		
		//Demo
		layui.use('form', function() {
			var form = layui.form;
			//监听提交
			form.on('submit(formDemo)', function(data) {
				
				 $.ajax({
				    	url:"Customer/addVisit.action",
				    	data:data.field,
				    	type:"post",
				    	dataType:"json",
				    	success:function(resbody){
				    		//layer.msg(resbody.msg);
				    		if(data.code == -1){
				    			layer.msg(data.msg);
				    		}else{
				    			layer.msg("添加成功");
				    			$("#myForm").submit();
								var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
								setTimeout(function () {
								  parent.layer.close(index); // 关闭layer
								},1500);
				    		}
				    	}
				    });
				 return false;
				
			});
			
		});
		
		layui.use(['laydate' ],
				function() {
					var  laydate = layui.laydate;

					//日期
					laydate.render({
						elem : '#date'
					});
					laydate.render({
						elem : '#date1'
					});

				});
		
		getvisitstate();
		getstaff();
	});
	
		//回访状态
		function getvisitstate(){
			var vid = ${param.vid}
			$.ajax({
				url:"view/getvisitstate.action",
				async: false,
				type:"post",
				data:{},
				dataType:"JSON",
				success:function(data){
					
					var html ="";
					$.each(data,function(index,item){
						if (vid == item.vid) {
						html +="<option value="+item.vid+" selected>"+item.vname+"</option>";
							
						} else {
							
						html +="<option value="+item.vid+">"+item.vname+"</option>";
						}
					})
					$(".getvisitstate").html(html);
				}
				
			});
			}
		//所属员工
		function getstaff(){
			var sid = ${param.sid}
			$.ajax({
				url:"view/getstaff.action",
				async: false,
				type:"post",
				data:{},
				dataType:"JSON",
				success:function(data){
					
					var html ="";
					$.each(data,function(index,item){
						if (sid == item.sid) {
						html +="<option value="+item.sid+" selected>"+item.sname+"</option>";
							
						} else {
							
						html +="<option value="+item.sid+">"+item.sname+"</option>";
						}
					})
					$(".getstaff").html(html);
				}
				
			});
			}
</script>
</head>
<body>
	<form class="layui-form" action="Staff/updateStaff.action" method="post">
		<div class="layui-form-item">
			<label class="layui-form-label">客户ID</label>
			<div class="layui-input-block">
				<input type="text" name="cid" required lay-verify="required"
					value="${param.cid }" readonly="readonly"  autocomplete="off" class="layui-input" style="width: 190px" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">客户姓名</label>
			<div class="layui-input-block">
				<input type="text" name="cname" required lay-verify="required"
					value="${param.cname }"   autocomplete="off" class="layui-input" style="width: 190px" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">回访状态</label>
			<div class="layui-input-block" style="width: 190px">
				<select class="getvisitstate" name="vid" lay-verify="required" style="width: 190px">
					
				</select>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">所属员工</label>
			<div class="layui-input-block" style="width: 190px">
				<select class="getstaff" name="sid" lay-verify="required" style="width: 190px">
					
				</select>
			</div>
		</div>
		<div class="layui-form-item layui-form-text">
	    <label class="layui-form-label">备注</label>
	    <div class="layui-input-block">
	      <textarea name="cremarks" class="layui-textarea" rows="5" cols="10"></textarea>
	    </div>
	  </div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn" id="myForm" lay-submit lay-filter="formDemo">立即提交</button>
				<button type="reset" class="layui-btn layui-btn-primary">重置</button>
			</div>
		</div>
	</form>

</body>
</html>



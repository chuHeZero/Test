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
				    	url:"Staff/updateStaff.action",
				    	data:data.field,
				    	type:"post",
				    	dataType:"json",
				    	success:function(resbody){
				    		//layer.msg(resbody.msg);
				    		if(resbody.code>0){
				    			layer.msg("修改成功");
				    			$("#myForm").submit();
								var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
								setTimeout(function () {
								  parent.layer.close(index); // 关闭layer
								},1500);
				    		}else{
				    			layer.msg("修改失败");
				    		}
				    	}
				    });
				 return false;
				
			});
			form.on('select(cate)', function(data){
			
		  	if(data.value==1){
		  		$("#getstaffByRoleid").html("<option value=\"0\">请选择</option>");
		  		layui.use('form', function(){
		  		  var form = layui.form;
		  		   form.render();
		  		});
		  	}else{
			  $.ajax({
	                type: 'POST',
	                url: 'view/getByroleid.action',
	                data: {roleid:data.value},
	                dataType:  'json',
	                success: function(data){
	                $("#getstaffByRoleid").html("");
	                  $.each(data, function(key, val) {
                		  var option1 = $("<option>").val(val.roleid).text(val.sname);
                            $("#getstaffByRoleid").append(option1);
                            form.render('select');
     
                       }); 
	              $("#getstaffByRoleid").get(0).selectedIndex=0;
	                }
			   }); 
		  	}
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
		
		getrole();
		getstaffBysleader();
	});
	
	//职位
	function getrole(){
		var rid = ${param.roleid};
		$.ajax({
			url:"view/getrole.action",
			async: false,
			type:"post",
			data:{},
			dataType:"JSON",
			success:function(data){
				
				var html ="";
				$.each(data,function(index,item){
					if (rid == item.rid) {
					html +="<option value="+item.rid+" selected>"+item.rname+"</option>";
						
					} else {
						
					html +="<option value="+item.rid+">"+item.rname+"</option>";
					}
				})
				$(".getrole").html(html);
			}
			
		});
		}
		//领导
		 function getstaffBysleader(){
			 var sleader = ${param.sid_leader};
			$.ajax({
				url:"view/getstaffBysleader.action",
				async: false,
				type:"post",
				data:{"sid_leader" : sleader },
				dataType:"JSON",
				success:function(data){
					
					var html ="";
					$.each(data,function(index,item){
						
						if (sleader == item.sid) {
							
							html +="<option value="+item.sid+" selected>"+item.sname+"</option>";
								
							} else if(item.sid==0){
								html +="<option value=\"0\">请选择</option>";
							}else {
								
								html +="<option value="+item.sid+">"+item.sname+"</option>";
							}
						
						
					});
					$("#getstaffByRoleid").html(html);
				}
			});
		} 
	
</script>
</head>
<body>
	<form class="layui-form" action="Staff/updateStaff.action" method="post">
		<div class="layui-form-item">
			<label class="layui-form-label">用户ID</label>
			<div class="layui-input-block">
				<input type="text" name="sid" required lay-verify="required"
					value="${param.sid }" readonly="readonly"  autocomplete="off" class="layui-input" style="width: 400px;" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">用户名</label>
			<div class="layui-input-block">
				<input type="text" name="sname" required lay-verify="required"
					value=" ${param.sname }" readonly="readonly"  autocomplete="off" class="layui-input" style="width: 400px;" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">性别</label>
			<div class="layui-input-block">
				<c:if test="${param.ssex == '男' }">
					<input type="radio" name="ssex" value="男" title="男" checked />
					<input type="radio" name="ssex" value="女" title="女" />
				</c:if>
				<c:if test="${param.ssex == '女' }">
					<input type="radio" name="ssex" value="男" title="男" />
					<input type="radio" name="ssex" value="女" title="女" checked />
				</c:if>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">出生年月</label>
			<div class="layui-input-inline" style="width: 400px;">
				<input type="text" name="birthday" id="date" lay-verify="date"
					 autocomplete="off" class="layui-input" value="${param.sbirthday }">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">电话</label>
			<div class="layui-input-block" style="width: 400px;">
				<input type="text" name="sphone" required lay-verify="required"
					 autocomplete="off" class="layui-input" style="width: 400px;" value="${param.sphone }"/>
			</div>
		</div>
		 <div class="layui-form-item">
			<label class="layui-form-label">密码框</label>
			<div class="layui-input-inline" style="width: 400px;">
				<input type="password" name="spassword" required
					 placeholder="请输入密码" autocomplete="off"
					class="layui-input">
			</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label">职位</label>
			<div class="layui-input-block" style="width: 400px;">
				<select class="getrole" name="roleid" lay-verify="required" id="cate" lay-filter="cate" style="width: 190px">
					
				</select>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">领导</label>
			<div class="layui-input-block" style="width: 400px;">
				<select id="getstaffByRoleid" name="sid_leader" lay-verify="required" style="width: 190px">
				
				</select>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">状态</label>
			<div class="layui-input-block" style="width: 400px;">
				<select name="sstate" lay-verify="required" style="width: 190px">
					<option value="${param.sstate }"></option>
					<option value="正式">正式</option>
					<option value="实习生">实习生</option>
					<option value="临时">临时</option>
				</select>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">休假天数</label>
			<div class="layui-input-block">
				<input type="text" name="stime" required lay-verify="required"
				 autocomplete="off" class="layui-input" style="width: 400px;" value="${param.stime }" />
			</div>
			<div class="layui-form-mid layui-word-aux" style="margin-left: 110px;">休假天数以天为单位!!!</div>
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



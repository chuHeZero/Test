<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<form class="layui-form">
		<div class="layui-form-item">
			<label class="layui-form-label">员工ID</label>
			<div class="layui-input-block">
				<input type="text" name="sid" required lay-verify="required"
					value="${sessionScope.staff.sid }" readonly="readonly"  autocomplete="off" class="layui-input" style="width: 190px" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">员工姓名</label>
			<div class="layui-input-block">
				<input type="text" name="sname" required lay-verify="required"
					value=" ${sessionScope.staff.sname }"  autocomplete="off" class="layui-input" style="width: 190px" />
			</div>
		</div>
		 <div class="layui-form-item">
			<label class="layui-form-label">旧密码框</label>
			<div class="layui-input-inline">
				<input type="password" name="spwd" required
					lay-verify="required" placeholder="请输入旧密码" autocomplete="off"
					class="layui-input">
			</div>
		</div>
		 <div class="layui-form-item">
			<label class="layui-form-label">新密码框</label>
			<div class="layui-input-inline">
				<input type="password" name="pwd1" required
					lay-verify="required" placeholder="请输入新密码" autocomplete="off"
					class="layui-input">
			</div>
		</div>
		 <div class="layui-form-item">
			<label class="layui-form-label">重复密码</label>
			<div class="layui-input-inline">
				<input type="password" name="pwd2" required
					lay-verify="required" placeholder="请输入重复密码" autocomplete="off"
					class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
			${error }
				<button class="layui-btn" id="myForm" lay-submit lay-filter="formDemo">立即提交</button>
				<button type="reset" class="layui-btn layui-btn-primary">重置</button>
			</div>
		</div>
	</form>
<script>

	layui.use('laydate', function(){
	  var laydate = layui.laydate;
	  //执行一个laydate实例
	  laydate.render({
	    elem: '#test1' //指定元素
	  });
	});

	layui.use(['form'], function(){//更新渲染
	    var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功
	    form.render();	    
	});
	
	
	layui.use('form', function(){
	  var form = layui.form;
	   
	  form.on('select(changeLeader)', function(data){
		  console.log(data.elem); //得到select原始DOM对象
		  console.log(data.value); //得到被选中的值
		  console.log(data.othis); //得到美化后的DOM对象
		  
		  $("#leaderName").val($(data.elem).find("option[value='"+data.value+"']").text());
	  }); 
	  
	  //监听提交
	  form.on('submit(formDemo)', function(data){
		  
	    $.ajax({
	    	url:"view/Pwd.action",
	    	data:data.field,
	    	type:"post",
	    	dataType:"json",
	    	success:function(data){
	    		//layer.msg(resbody.msg);
	    		if(data.code == -1){
	    			layer.msg(data.msg);
	    		}else if(data.code == -2){
	    			layer.msg(data.msg);
	    		}else{
	    			layer.msg("修改成功");
	    			window.location.href="login.jsp";
	    		}
	    	}
	    });
	    
	    return false;
	    
	  });
	});

</script>
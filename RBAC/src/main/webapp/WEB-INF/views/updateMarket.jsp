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
		    	url:"Market/updateMarket.action",
		    	data:data.field,
		    	type:"post",
		    	dataType:"json",
		    	success:function(resbody){
		    		//layer.msg(resbody.msg);
		    		if(resbody>0){
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
		  
		});
		
</script>
</head>
<body>
	<form class="layui-form"  method="post">
		<div class="layui-form-item">
			<label class="layui-form-label">订单ID</label>
			<div class="layui-input-block">
				<input type="text" name="mid" required lay-verify="required"
					value="${param.mid }" readonly="readonly"  autocomplete="off" class="layui-input" style="width: 400px;" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">客户姓名</label>
			<div class="layui-input-block">
				<input type="text"  required lay-verify="required"
					value="${param.cname }"  readonly="readonly"  autocomplete="off" class="layui-input" style="width: 400px;" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">员工姓名</label>
			<div class="layui-input-block">
				<input type="text"  required lay-verify="required"
					value="${param.sname }"  readonly="readonly"  autocomplete="off" class="layui-input" style="width: 400px;" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">产品名称</label>
			<div class="layui-input-block">
				<input type="text"  required lay-verify="required"
					value="${param.pname }"  readonly="readonly"  autocomplete="off" class="layui-input" style="width: 400px;"/>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">销售数量</label>
			<div class="layui-input-block">
				<input type="text" required lay-verify="required"
					value="${param.mcount }"  readonly="readonly"  autocomplete="off" class="layui-input" style="width: 400px;"/>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">成交总价格</label>
			<div class="layui-input-block">
				<input type="text"  required lay-verify="required"
					value="${param.mprice }"  readonly="readonly"  autocomplete="off" class="layui-input" style="width: 400px;" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">交易时间</label>
			<div class="layui-input-block">
				<input type="text"  required lay-verify="required"
					value="${param.mtime }"  readonly="readonly"  autocomplete="off" class="layui-input" style="width: 400px;" />
			</div>
		</div>
		<div class="layui-form-item layui-form-text">
	    <label class="layui-form-label">备注</label>
	    <div class="layui-input-block" style="width: 400px;">
	      <textarea name="mremarks" class="layui-textarea" rows="5" cols="10" style="width: 400px;">${param.mremarks }</textarea>
	    </div>
	  </div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn" id="myForm" lay-submit lay-filter="formDemo" style="width: 280px;">立即提交</button>
				<button type="reset" class="layui-btn layui-btn-primary" style="width: 107px;">重置</button>
			</div>
		</div>
	</form>

</body>
</html>



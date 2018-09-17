<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<title>Insert title here</title>
<link rel="stylesheet" href="layui/css/layui.css">
<script src="layui/layui.js"></script>
<script type="text/javascript" src="js/jquery-2.2.4.min.js"></script>
<script>

	layui.use('laydate', function(){
	  var laydate = layui.laydate;
	  getrole();
	  //执行一个laydate实例
	  laydate.render({
	    elem: '#test1' //指定元素
	  });
	});

	layui.use(['form'], function(){//更新渲染
	    var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功
	    form.render();	    
	});
	
	getrole();
	
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
	    	url:"Product/updateProduct.action",
	    	data:data.field,
	    	type:"post",
	    	dataType:"json",
	    	success:function(resbody){
	    		//layer.msg(resbody.msg);
	    		if(resbody==-100){
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
	
	//产品分类
	function getrole(){
		var tid=${param.ptype};
		$.ajax({
			url:"view/gettype.action",
			async: false,
			type:"post",
			data:{},
			dataType:"JSON",
			success:function(data){
				
				var html ="";
				$.each(data,function(index,item){
					
					if(tid == item.tid){
						html +="<option value="+item.tid+" selected>"+item.tname+"</option>";
					}else{
						html +="<option value="+item.tid+">"+item.tname+"</option>";
					}
				})
				$(".getrole").html(html);
			}
		});
		}
</script>
</head>
<body>
		<form class="layui-form" action="Staff/updateStaff.action" method="post">
		<div class="layui-form-item">
			<label class="layui-form-label">产品ID</label>
			<div class="layui-input-block">
				<input type="text" name="pid" required lay-verify="required"
					value="${param.pid }" readonly="readonly"  autocomplete="off" class="layui-input" style="width: 400px;" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">产品名</label>
			<div class="layui-input-block">
				<input type="text" name="pname" required lay-verify="required"
					value="${param.pname }"  autocomplete="off" class="layui-input" style="width: 400px;" />
			</div>
		</div>
	
		<div class="layui-form-item">
			<label class="layui-form-label">市场价格</label>
			<div class="layui-input-block">
				<input type="text" name="pprice" required lay-verify="required"
					 autocomplete="off" class="layui-input" style="width: 400px;" value="${param.pprice }"/>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">最低价格</label>
			<div class="layui-input-block">
				<input type="text" name="pprice_min" required lay-verify="required"
					 autocomplete="off" class="layui-input" style="width: 400px;" value="${param.pprice_min }"/>
			</div>
		</div>
		 <div class="layui-form-item">
			<label class="layui-form-label">库存</label>
			<div class="layui-input-inline" style="width: 400px;">
				<input type="text" name="pcount" required
					lay-verify="required" value="${param.pcount }" autocomplete="off"
					class="layui-input">
			</div>
		</div>
		
		<div class="layui-form-item">
		    <label class="layui-form-label">产品分类</label>
		    <div class="layui-input-block" style="width:400px;">
		      <select class="getrole" name="ptype" required id="role" id="cate" lay-filter="cate" >
		    
		      </select>
		    </div>
		  </div>
	 <div class="layui-form-item layui-form-text">
	    <label class="layui-form-label">产品介绍</label>
	    <div class="layui-input-block" style="width: 400px;">
	      <textarea name="pdept" class="layui-textarea" rows="5" cols="10">${param.pdept }</textarea>
	    </div>
	  </div>
		
   <!--  <div class="layui-form-item">
		    <label class="layui-form-label">产品图片</label>
		    <div class="layui-input-inline">
		      <input type="text" id="spassword" name="pimg" required lay-verify="required" placeholder="请输入产品图片" autocomplete="off" class="layui-input cage">
		    </div>
		  </div> -->
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn" id="myForm" lay-submit lay-filter="formDemo">立即提交</button>
				<button type="reset" class="layui-btn layui-btn-primary">重置</button>
			</div>
		</div>
	</form>
		
</body>
</html>
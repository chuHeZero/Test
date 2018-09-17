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
	    	url:"Visit/updatevisit.action",
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
	
	//产品分类
	function getrole(){
		var vdecpt=${param.vdecpt};
		$.ajax({
			url:"Visit/getvisitstate.action",
			async: false,
			type:"post",
			data:{},
			dataType:"JSON",
			success:function(data){
				
				var html ="";
				$.each(data,function(index,item){
					
					if(vdecpt == item.vid){
						html +="<option value="+item.vid+" selected>"+item.vname+"</option>";
					}else{
						html +="<option value="+item.vid+">"+item.vname+"</option>";
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
			<label class="layui-form-label">回访ID</label>
			<div class="layui-input-block">
				<input type="text" name="id" required lay-verify="required"
					value="${param.id }" readonly="readonly"  autocomplete="off" class="layui-input" style="width: 190px" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">客户姓名</label>
			<div class="layui-input-block">
				<input type="text"  required lay-verify="required"
					value="${param.cname }" readonly="readonly"  autocomplete="off" class="layui-input" style="width: 190px" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">所属员工</label>
			<div class="layui-input-block">
				<input type="text"  required lay-verify="required"
					value="${param.sname }" readonly="readonly" autocomplete="off" class="layui-input" style="width: 190px" />
			</div>
		</div>
		<div class="layui-form-item">
		    <label class="layui-form-label">回访状态</label>
		    <div class="layui-input-block" style="width:190px">
		      <select class="getrole" name="vdecpt" required id="role"  lay-filter="cate" >
		    
		      </select>
		    </div>
		  </div>
	 <div class="layui-form-item layui-form-text">
	    <label class="layui-form-label">备注</label>
	    <div class="layui-input-block">
	      <textarea name="vremarks" class="layui-textarea" rows="5" cols="10">${param.vremarks }</textarea>
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
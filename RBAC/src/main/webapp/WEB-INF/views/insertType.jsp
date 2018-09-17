<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<form class="layui-form" style="margin-top:60px;margin-left:120px;">
  <div class="layui-form-item">
    <label class="layui-form-label ">分类名</label>
    <div class="layui-input-inline">
      <input type="text" id="sname" name="tname" required lay-verify="required" placeholder="请输入姓名" autocomplete="off" class="layui-input cname">
    </div>
  </div>
  <div class="layui-form-item">
    <div class="layui-input-block">
      <button class="layui-btn" lay-submit="" lay-filter="formDemo">立即添加</button>
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
	    	url:"Type/insertType.action",
	    	data:data.field,
	    	type:"post",
	    	dataType:"json",
	    	success:function(resbody){
	    		//layer.msg(resbody.msg);
	    		if(resbody>0){
	    			layer.msg("添加成功");
	    			//window.location.href="view/type.action";
	    			var viewurl = "access/view/insertType.action";
	    			updateview(viewurl)
	    		}else{
	    			layer.msg("添加失败");
	    		}
	    		
	    	}
	    });
	    
	    return false;
	    
	  });
	
	});
</script>
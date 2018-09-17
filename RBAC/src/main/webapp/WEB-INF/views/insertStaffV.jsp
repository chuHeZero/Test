<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<form class="layui-form" style="margin-top:60px;margin-left:120px;">
  <div class="layui-form-item">
    <label class="layui-form-label ">员工姓名</label>
    <div class="layui-input-inline">
      <input type="text" id="sname" name="sname" required lay-verify="required" placeholder="请输入姓名" autocomplete="off" class="layui-input cname">
    </div>
  </div>
   <div class="layui-form-item">
    <label class="layui-form-label">密码</label>
    <div class="layui-input-inline">
      <input type="password" id="spassword" name="spassword" required lay-verify="required" placeholder="密码" autocomplete="off" class="layui-input cage">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">性别</label>
    <div class="layui-input-block">
      <input type="radio" name="ssex" value="男" title="男" checked />
	  <input type="radio" name="ssex" value="女" title="女"  />
    </div>
  </div>
   <div class="layui-form-item">
    <label class="layui-form-label">生日</label>
    <div class="layui-input-block">
      <input type="text" class="layui-input" name="birthday" required lay-verify="required" id="test1" style="width:190px">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">手机号</label>
    <div class="layui-input-inline">
      <input type="text" id="sphone" name="sphone" required lay-verify="required" placeholder="手机号" autocomplete="off" class="layui-input cphone">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">职位</label>
    <div class="layui-input-block" style="width:190px">
      <select class="getrole" name="roleid" required id="role" id="cate" lay-filter="cate" >
    
      </select>
    </div>
  </div>
   <div class="layui-form-item">
    <label class="layui-form-label">所属领导</label>
    <div class="layui-input-block" style="width:190px">
      <select id="getstaffByRoleid" name="sid_leader" required id="sid_leader" lay-filter="changeLeader" >
      </select>
    </div>
  </div>
  <div class="layui-form-item">
		<label class="layui-form-label">状态</label>
		<div class="layui-input-block" style="width: 190px">
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
				 autocomplete="off" class="layui-input" style="width: 190px" value="0" />
			</div>
			<div class="layui-form-mid layui-word-aux" style="margin-left: 110px;">休假天数以天为单位!!!</div>
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
	    	url:"Staff/addStaff.action",
	    	data:data.field,
	    	type:"post",
	    	dataType:"json",
	    	success:function(resbody){
	    		if(resbody==-100){
	    			layer.msg("添加成功");
	    			var viewurl = "access/view/insertStaffV.action";
	    			updateview(viewurl)
	    		}else{
	    			layer.msg("添加失败");
	    		}
	    		
	    	}
	    });
	    
	    return false;
	    
	  });
	  form.on('select(cate)', function(data){
		  	if(data.value==1){
		  		$("#getstaffByRoleid").html("");
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
	
	//职位
	function getrole(){
		$.ajax({
			url:"view/getrole.action",
			async: false,
			type:"post",
			data:{},
			dataType:"JSON",
			success:function(data){
				
				var html ="";
				$.each(data,function(index,item){
					
					html +="<option value="+item.rid+">"+item.rname+"</option>";
				})
				$(".getrole").html(html);
				
			}
		});
		}
</script>
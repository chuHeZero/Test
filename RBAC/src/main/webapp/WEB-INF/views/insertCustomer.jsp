<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<form class="layui-form" action="Staff/updateStaff.action" method="post">
		
		<div class="layui-form-item">
			<label class="layui-form-label">客户姓名</label>
			<div class="layui-input-block">
				<input type="text" name="cname" required lay-verify="required"
					   autocomplete="off" class="layui-input" style="width: 500px" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">性别</label>
			<div class="layui-input-block">
					<input type="radio" name="csex" value="男" title="男" checked />
					<input type="radio" name="csex" value="女" title="女" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">年龄</label>
			<div class="layui-input-block">
				<input type="text" name="cage" required lay-verify="required"
					 autocomplete="off" class="layui-input" style="width: 500px" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">电话</label>
			<div class="layui-input-block">
				<input type="text" name="cphone" required lay-verify="required"
					 autocomplete="off" class="layui-input" style="width: 500px" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">意向类别</label>
			<div class="layui-input-block" style="width: 500px">
				<select class="getrole" name="tid" lay-verify="required" id="cate" lay-filter="cate" style="width: 500px">
					
				</select>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">意向产品</label>
			<div class="layui-input-block" style="width: 500px">
				<select id="getstaffByRoleid" name="pid" lay-verify="required" style="width: 500px">
				
				</select>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">意向</label>
			<div class="layui-input-block" style="width: 500px">
				<select class="getintentionstate" name="iid" lay-verify="required" style="width: 500px">
					
				</select>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">回访状态</label>
			<div class="layui-input-block" style="width: 500px">
				<select class="getvisitstate" name="vid" lay-verify="required" style="width: 500px">
					
				</select>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">所属员工</label>
			<div class="layui-input-block" style="width: 500px">
				<select class="getstaff" name="sid" lay-verify="required" style="width: 500px">
					
				</select>
			</div>
		</div>
		<div class="layui-form-item layui-form-text">
	    <label class="layui-form-label">备注</label>
	    <div class="layui-input-block">
	      <textarea name="cremarks" class="layui-textarea" rows="5" cols="10" style="width:500px; height:70px;"></textarea>
	    </div>
	  </div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn" id="myForm" lay-submit lay-filter="formDemo" style="width: 380px;">立即提交</button>
				<button type="reset" class="layui-btn layui-btn-primary" style="width: 107px;">重置</button>
			</div>
		</div>
	</form>
<script>

	layui.use('laydate', function(){
	  var laydate = layui.laydate;
	  getrole();
	  getstaffBysleader();
	  getintentionstate();
	  getvisitstate();
	  getstaff();
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
	getstaffBysleader();
	getintentionstate();
	getvisitstate();
	getstaff();
	
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
	    	url:"Customer/addCustomer.action",
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
	    			layer.msg("添加成功");
	    			var viewurl = "access/view/insertCustomer.action";
	    			updateview(viewurl)
	    		}
	    		
	    	}
	    });
	    return false;
	  });
	  form.on('select(cate)', function(data){
			
		  $.ajax({
                type: 'POST',
                url: 'view/getAllproduct.action',
                data: {ptype:data.value},
                dataType:  'json',
                success: function(data){
                $("#getstaffByRoleid").html("");
                  $.each(data, function(key, val) {
            		  var option1 = $("<option>").val(val.pid).text(val.pname);
                        $("#getstaffByRoleid").append(option1);
                        form.render('select');
 
                   }); 
              $("#getstaffByRoleid").get(0).selectedIndex=0;
                }
		   }); 
	  	
		});
	});
	
	//意向类别
	function getrole(){
		$.ajax({
			url:"view/gettype.action",
			async: false,
			type:"post",
			data:{},
			dataType:"JSON",
			success:function(data){
				
				var html ="";
				$.each(data,function(index,item){
					
					html +="<option value="+item.tid+">"+item.tname+"</option>";
					
				})
				$(".getrole").html(html);
			}
			
		});
		}
		//意向产品
		 function getstaffBysleader(){
			$.ajax({
				url:"Product/getProduct.action",
				async: false,
				type:"post",
				data:{},
				dataType:"JSON",
				success:function(data){
					
					var html ="";
					$.each(data,function(index,item){
						
								html +="<option value="+item.pid+">"+item.pname+"</option>";
							
						
					});
					$("#getstaffByRoleid").html(html);
				}
			});
		} 
		//意向状态
			function getintentionstate(){
				$.ajax({
					url:"view/gettent.action",
					async: false,
					type:"post",
					data:{},
					dataType:"JSON",
					success:function(data){
						
						var html ="";
						$.each(data,function(index,item){
							
							html +="<option value="+item.iid+">"+item.iname+"</option>";
							
						})
						$(".getintentionstate").html(html);
					}
					
				});
				}
		//回访状态
		function getvisitstate(){
			$.ajax({
				url:"view/getvisitstate.action",
				async: false,
				type:"post",
				data:{},
				dataType:"JSON",
				success:function(data){
					
					var html ="";
					$.each(data,function(index,item){
						
							
						html +="<option value="+item.vid+">"+item.vname+"</option>";
						
					})
					$(".getvisitstate").html(html);
				}
				
			});
			}
		//所属员工
		function getstaff(){
			$.ajax({
				url:"view/getstaff.action",
				async: false,
				type:"post",
				data:{},
				dataType:"JSON",
				success:function(data){
					
					var html ="";
					$.each(data,function(index,item){
						
							
						html +="<option value="+item.sid+">"+item.sname+"</option>";
					
					})
					$(".getstaff").html(html);
				}
				
			});
			}
</script>
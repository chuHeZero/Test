<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<form class="layui-form" method="post">
		<div class="layui-form-item">
	    <label class="layui-form-label">客户姓名</label>
	    <div class="layui-input-block" style="width:500px">
	      <select class="getCustomer" name="cid" required id="role" id="cate" lay-filter="cate" >
	    
	      </select>
	    </div>
	  </div>
		<div class="layui-form-item">
	    <label class="layui-form-label">员工姓名</label>
	    <div class="layui-input-block" style="width:500px">
	      <select class="getstaff" name="sid" required id="role" id="cate" lay-filter="cate" >
	    
	      </select>
	    </div>
	  </div>
		<div class="layui-form-item">
	    <label class="layui-form-label">购买产品</label>
	    <div class="layui-input-block" style="width:500px">
	      <select class="getrole" name="pid" required   lay-filter="cate" >
	    
	      </select>
	    </div>
	  </div>
		<div class="layui-form-item">
			<label class="layui-form-label">销售数量</label>
			<div class="layui-input-block">
				<input type="text" required lay-verify="required"
				 autocomplete="off" name="mcount" id="mcount" class="layui-input" placeholder="销售数量应小于等于库存数" style="width: 500px"/>
			</div>
			
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">成交单价</label>
			<div class="layui-input-block">
				<input type="text"  required lay-verify="required"
					 autocomplete="off"  id="price" class="layui-input" style="width: 500px" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">成交总价格</label>
			<div class="layui-input-block">
				<input type="text"  required lay-verify="required"
					 autocomplete="off" id="mprice" name="mprice"   class="layui-input" style="width: 500px" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">交易时间</label>
			<div class="layui-input-block">
				<input type="text"   
					 autocomplete="off" placeholder="成交时间以系统生成为准!!!"  readonly="readonly" class="layui-input" style="width: 500px" />
			</div>
		</div>
		<div class="layui-form-item layui-form-text">
	    <label class="layui-form-label">备注</label>
	    <div class="layui-input-block">
	      <textarea name="mremarks" class="layui-textarea" rows="5" cols="10" style="width:500px; height:70px;">${param.mremarks }</textarea>
	    </div>
	  </div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn" id="myForm" lay-submit lay-filter="formDemo">立即提交</button>
				<button type="reset" class="layui-btn layui-btn-primary">重置</button>
			</div>
		</div>
	</form>
<script>

	layui.use('laydate', function(){
	  var laydate = layui.laydate;
	  getsome();
	
	  //执行一个laydate实例
	  laydate.render({
	    elem: '#test1' //指定元素
	  });
	});
	
	layui.use(['form'], function(){//更新渲染
	    var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功
	    form.render();	    
	});
	
	getsome();
	var counts = 0;
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
	    	url:"Market/insertMarket.action",
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
	    			var viewurl = "access/view/insertMarket.action";
	    			updateview(viewurl)
	    		}
	    		
	    	}
	    });
	    
	    return false;
	    
	  });
	  
	  form.on('select(cate)', function(data){
			  $.ajax({
	                type: 'POST',
	                async: false,
	                url:"view/getproductByPid.action",
	                data: {pid:data.value},
	                dataType:  'json',
	                success: function(data){
	                	 $("#count").html("");
		                  $.each(data, function(key, val) {
	            		  var option1 = $("<span>").text(val.pcount);
	            		  counts = val.pcount;
	                        $("#count").append(option1);
	                        
	 
	                   }); 
	                }
			   }); 
			});
	  
	});
	 
	$(function(){
		$("#mcount").change(function(){
			var count = $(this).val();
			if(count>=counts){
				$(this).val(counts);
			}
			if(count<1){
				$(this).val(1);
			}
			
		});
		
		$("#price").change(function(){
			var price = $(this).val();
			$("#mprice").val( parseInt(price)*parseInt($("#mcount").val()));
			
		});
		
		
	});
		//产品
			function getsome(){
				$.ajax({
					url:"Product/getProduct.action",
					async: false,
					type:"post",
					data:{},
					dataType:"JSON",
					success:function(data){
						
						var html ="";
						$.each(data,function(index,item){
							
							html +="<option value=\""+item.pid+"\">"+item.pname+"</option>";
							
						})
						$(".getrole").html(html);
						
					}
				});
				
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
				
				$.ajax({
					url:"view/getCustomer.action",
					async: false,
					type:"post",
					data:{},
					dataType:"JSON",
					success:function(data){
						
						var html ="";
						$.each(data,function(index,item){
							
								
							html +="<option value="+item.cid+">"+item.cname+"</option>";
						
						})
						$(".getCustomer").html(html);
					}
					
				});
				
				}
		
		
</script>
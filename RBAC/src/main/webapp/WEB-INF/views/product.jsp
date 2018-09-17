<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%   
    String path = request.getContextPath();   
    String basePath = request.getScheme()+"://" +request.getServerName()+":" +request.getServerPort()+path+"/" ;   
    //System.out.println("path="+path);
    //System.out.println("basePath="+basePath);
%>
<div class="layui-row" id="popSearchRoleTest">
	<div class="layui-col-md11">
		<form class="layui-form">
			<div class="layui-form-item">
				<label class="layui-form-label" style="width: 50px;">产品名</label>
				<div class="layui-input-inline">
					<input type="text" name="pname" 
						placeholder="请输入产品名" autocomplete="off" class="layui-input">
				</div>
				   <label class="layui-form-label" style="width: 60px;">产品分类</label>
				   <div class="layui-input-inline" style="width:190px;">
				      <select class="getrole" name="ptype" required id="role" id="cate" lay-filter="cate" >
				    
				      </select>
				   </div>
				   <div class="layui-inline">
					<label class="layui-form-label" style="width: 40px;">范围</label>
					<div class="layui-input-inline" style="width: 100px;">
						<input type="text" name="pprice_min" placeholder="￥"
							autocomplete="off" class="layui-input">
					</div>
					<div class="layui-form-mid">-</div>
					<div class="layui-input-inline" style="width: 100px;">
						<input type="text" name="pprice" placeholder="￥"
							autocomplete="off" class="layui-input">
					</div>
				</div>
					<button class="layui-btn" lay-submit="" lay-filter="formDemo">立即查询</button>
					<button type="reset" class="layui-btn layui-btn-primary">重置</button>
			</div>
				
		</form>
	</div>
</div>
<table class="layui-table" id="test" lay-filter="demo"></table>
<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="LookPic">查看图片</a>
  <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="detail">图片管理</a>
  <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
  <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script>
	$(function(){
		getrole();
	});

layui.use(['laydate', 'laypage', 'layer', 'table', 'carousel','form', 'upload', 'element'], function(){
	  var laydate = layui.laydate //日期
	  ,laypage = layui.laypage //分页
	  layer = layui.layer //弹层
	  ,table = layui.table //表格
	  ,carousel = layui.carousel //轮播
	  ,upload = layui.upload //上传
	  ,form = layui.form
	  ,element = layui.element; //元素操作
	  form.render();
	  
	  
	  //监听Tab切换
	  element.on('tab(demo)', function(data){
	    layer.msg('切换了：'+ this.innerHTML);
	    console.log(data);
	  });
	  
	  //执行一个 table 实例
	  var  tableIns=
	  table.render({
	    elem: '#test'
	    ,height: 460
	    ,url: 'Product/selectProduct.action' //数据接口
	    ,page: true //开启分页
	    ,id:'tab'
	    ,cols: [[ //表头
	      {field: 'pid', title: 'ID', width:80, sort: true, fixed: 'left'}
	      ,{field: 'pname', title: '产品名', width:120}
	      ,{field: 'pdept', title: '产品简介', width:390}
	      ,{field: 'pprice', title: '市场价格', width: 100}
	      ,{field: 'pprice_min', title: '最低价格', width: 100}
	      ,{field: 'pcount', title: '库存', width: 80}
	      ,{field: 'tname', title: '产品分类', width: 120}
	      ,{fixed: 'right', title: '操作', width: 280, align:'center', toolbar: '#barDemo'}
	    ]]
	  });
	  
	  form.on('submit(formDemo)', function(data){
		  tableIns.reload({
			  where: data.field 
			  ,page: {
			    curr: 1 //重新从第 1 页开始
			  }
			});
		  return false;
	  }); 

	  
	  //监听工具条
	  table.on('tool(demo)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
	    var data = obj.data //获得当前行数据
	    ,layEvent = obj.event; //获得 lay-event 对应的值
	    if(layEvent === 'detail'){
	    	var rid=${sessionScope.staff.roleid};
	    	if(rid==1){
	    	layer.open({
		   		  type: 2,
		   		  area: ['1100px', '680px'],
		   		  content: 'view/getPic.action?pid='+data.pid+'&pname='+data.pname, //这里content是一个普通的String
		   		  end : function(){
	    			table.reload("tab",{
	    				
	    			});
	    		}
	    	});
	    	}
	    }else if(layEvent === 'LookPic'){
	        $.getJSON('view/ManyPic.action?pid='+data.pid, function(json){
	  	      layer.photos({
	  	    	  photos: json
	  	    	  ,anim: 5 //0-6的选择，指定弹出图片动画类型，默认随机（请注意，3.0之前的版本用shift参数）
	  	    	}); 
	  	     });  

	    }else if(layEvent === 'del'){
	      layer.confirm('真的删除行么', function(index){
    	  var rid=${sessionScope.staff.roleid};
	    	if(rid==1){  
	        obj.del(); //删除对应行（tr）的DOM结构
	        layer.close(index);
	        //向服务端发送删除指令
	        var pid=data.pid;
	        $.ajax({
	        	url:"Product/deleteProduct.action",
	        	data:{"pid" : pid},
	        	type:"post",
	        	dataType:"json",
	        	success : function(resbody){
	        		//layer.msg(resbody.msg);
		    		if(data.code == -1){
		    			layer.msg(data.msg);
		    		}else if(data.code == -2){
		    			layer.msg(data.msg);
		    		}else{
		    			layer.msg("删除成功");
		    			var mylay = parent.layer.getFrameIndex(window.name);
						parent.layer.close(mylay);
		    		}
		    		
	        	}
	        	
	        });
	    	}
	      });
	    } else if(layEvent === 'edit'){
	    	var rid=${sessionScope.staff.roleid};
	    	if(rid==1){
	    	layer.open({
		   		  type: 2,
		   		  area: ['600px', '600px'],
		   		  content: 'view/updateProduct.action?pid='+data.pid+'&pname='+data.pname+'&pdept='+data.pdept+'&pprice='+data.pprice+'&pprice_min='+data.pprice_min+'&pcount='+data.pcount+'&pimg='+data.pimg+'&ptype='+data.ptype, //这里content是一个普通的String
		   		  end : function(){
	    			table.reload("tab",{
	    				
	    			});
	    		}
	    	});
	    	}
	    }
	  });
	  
	 
	});
	
		//产品分类
		function getrole(){
			$.ajax({
				url:"view/gettype.action",
				async: false,
				type:"post",
				data:{},
				dataType:"JSON",
				success:function(data){
					
					var html ="<option value=\"0\">请选择</option>";
					$.each(data,function(index,item){
							html +="<option value="+item.tid+">"+item.tname+"</option>";
					})
					$(".getrole").html(html);
				}
			});
			}
	
</script>
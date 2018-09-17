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
				<label class="layui-form-label">产品名</label>
				 <div class="layui-input-inline" style="width:190px;">
				      <select class="getproduct" name="pid" required id="role" id="cate" lay-filter="cate" >
				    
				      </select>
				   </div>
				   <label class="layui-form-label" style="width: 60px;">员工姓名</label>
				   <div class="layui-input-inline" style="width:190px;">
				      <select class="getstaff" name="sid" required id="role" id="cate" lay-filter="cate" >
				    
				      </select>
				   </div>
					<button class="layui-btn" lay-submit="" lay-filter="formDemo">立即查询</button>
					<button type="reset" class="layui-btn layui-btn-primary">重置</button>
			</div>
				
		</form>
	</div>
</div>  
<table class="layui-table" id="test" lay-filter="demo"></table>
<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
  <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script>

	$(function(){
		getstaff();
		getProduct();
	});

layui.use(['laydate', 'laypage', 'layer', 'table', 'carousel','form', 'upload', 'element'], function(){
	  var laydate = layui.laydate //日期
	  ,laypage = layui.laypage //分页
	  layer = layui.layer //弹层
	  ,table = layui.table //表格
	  ,carousel = layui.carousel //轮播
	  ,form = layui.form
	  ,upload = layui.upload //上传
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
	    ,height: 480
	    ,url: 'Market/selectMarket.action' //数据接口
	    ,page: true //开启分页
	    ,id:'tab'
	    ,cols: [[ //表头
	      {field: 'mid', title: '订单ID', width:80, sort: true, fixed: 'left'}
	      ,{field: 'cname', title: '客户姓名', width:100}
	      ,{field: 'sname', title: '员工名', width:80}
	      ,{field: 'pname', title: '销售产品', width:120} 
	      ,{field: 'mcount', title: '销售数量', width: 100}
	      ,{field: 'mprice', title: '成交价格', width: 120}
	      ,{field: 'mtime', title: '交易时间 ', width: 150}
	      ,{field: 'mremarks', title: '备注 ', width: 400}
	      ,{fixed: 'right', title: '操作', width: 165, align:'center', toolbar: '#barDemo'}
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
	      layer.msg('查看操作');
	    } else if(layEvent === 'del'){
	      layer.confirm('真的删除行么', function(index){
    		var rid=${sessionScope.staff.roleid};
	    	if(rid==3){
	        obj.del(); //删除对应行（tr）的DOM结构
	        layer.close(index);
	        //向服务端发送删除指令
	        var mid=data.mid;
	        $.ajax({
	        	url:"Market/deleteMarket.action",
	        	data:{"mid" : mid},
	        	type:"post",
	        	dataType:"json",
	        	success : function(resbody){
	        		if(resbody>0){
		    			layer.msg("删除成功");
		    		}else{
		    			layer.msg("删除失败");
		    		}
		    		var mylay = parent.layer.getFrameIndex(window.name);
					parent.layer.close(mylay);
	        	}
	        	
	        });
	    	}
	      });
	    } else if(layEvent === 'edit'){
	    	var rid=${sessionScope.staff.roleid};
	    	if(rid==3){
	    	layer.open({
		   		  type: 2,
		   		  area: ['600px', '600px'],
		   		  content: 'view/updateMarket.action?mid='+data.mid+'&cname='+data.cname+'&sname='+data.sname+'&mcount='+data.mcount+'&mprice='+data.mprice+'&mtime='+data.mtime+'&mremarks='+data.mremarks+'&pname='+data.pname, //这里content是一个普通的String
		   		  end : function(){
	    			table.reload("tab",{
	    				
	    			});
	    		}
	    	});
	    	}
	    }
	  });
	  
	 
	});
	
	
		//意向产品
		function getProduct(){
			$.ajax({
				url:"Product/getProduct.action",
				async: false,
				type:"post",
				data:{},
				dataType:"JSON",
				success:function(data){
					
					var html ="<option value=\"0\">请选择</option>";
					$.each(data,function(index,item){
						html +="<option value="+item.pid+">"+item.pname+"</option>";
					});
					$(".getproduct").html(html);
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
					
					var html ="<option value=\"0\">请选择</option>";
					$.each(data,function(index,item){
						html +="<option value="+item.sid+">"+item.sname+"</option>";
					})
					$(".getstaff").html(html);
				}
				
			});
			}
	
</script>
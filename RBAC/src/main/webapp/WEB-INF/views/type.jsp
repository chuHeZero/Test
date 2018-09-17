<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%   
    String path = request.getContextPath();   
    String basePath = request.getScheme()+"://" +request.getServerName()+":" +request.getServerPort()+path+"/" ;   
    //System.out.println("path="+path);
    //System.out.println("basePath="+basePath);
%>  
<table class="layui-table" id="test" lay-filter="demo"></table>
<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
  <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script>
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
	  table.render({
	    elem: '#test'
	    ,height: 460
	    ,url: 'Type/selectType.action' //数据接口
	    ,page: true //开启分页
	    ,id:'tab'
	    ,cols: [[ //表头
	      {field: 'tid', title: 'ID', width:80, sort: true, fixed: 'left'}
	      ,{field: 'tname', title: '类别名', width:1200}
	      ,{fixed: 'right', title: '操作', width: 165, align:'center', toolbar: '#barDemo'}
	    ]]
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
	    	if(rid==1){ 
	        obj.del(); //删除对应行（tr）的DOM结构
	        layer.close(index);
	        //向服务端发送删除指令
	        var tid=data.tid;
	        $.ajax({
	        	url:"Type/deleteType.action",
	        	data:{"tid" : tid},
	        	type:"post",
	        	dataType:"json",
	        	success : function(resbody){
	        		if(resbody>0){
	        			layer.msg("删除成功");
	        		}else{
	        			layer.msg("未知错误，删除失败");
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
		   		  content: 'view/updateType.action?tid='+data.tid+'&tname='+data.tname, //这里content是一个普通的String
		   		  end : function(){
	    			table.reload("tab",{
	    				
	    			});
	    		}
	    	});
	    	}
	    }
	  });
	  
	 
	});
</script>
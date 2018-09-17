<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%   
    String path = request.getContextPath();   
    String basePath = request.getScheme()+"://" +request.getServerName()+":" +request.getServerPort()+path+"/" ;   
%>   

<div class="layui-row" id="popSearchRoleTest">
	<div class="layui-col-md11">
		<form class="layui-form">
			<div class="layui-form-item">
				<label class="layui-form-label">员工姓名</label>
				<div class="layui-input-inline">
					<input type="text" name="sname" lay-verify="required"
						placeholder="请输入员工姓名" autocomplete="off" class="layui-input">
				</div>
				<div class="layui-input-inle">
					<button class="layui-btn" onclick="return selectsomestaff()" lay-submit="" lay-filter="demo1">立即查询</button>
					<button type="reset" class="layui-btn layui-btn-primary">重置</button>
				</div>
			</div>
		</form>
	</div>
</div>


<table class="layui-table" id="test" lay-filter="demo"></table>

<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
  <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>

<script >

selectsomestaff();
function selectsomestaff(){

	layui.use(['laydate', 'laypage', 'layer','form', 'table', 'carousel', 'upload', 'element'], function(){
	  var laydate = layui.laydate //日期
	  ,laypage = layui.laypage //分页
	  layer = layui.layer //弹层
	  ,table = layui.table //表格
	  ,carousel = layui.carousel //轮播
	  ,upload = layui.upload //上传
	  ,element = layui.element //元素操作
	  ,form = layui.form;
	  form.render();
	  
	  
	  var sname = $("input[name='sname']").val();

	  //执行一个 table 实例
	  table.render({
		    elem: '#test'
		    ,url: 'Staff/selectStaff.action' //数据接口
		    ,page: true //开启分页
			,where:{"sname":sname}
		    ,id: "tab"
		    	,cols: [[ //表头
		  	      {field: 'sid', title: 'ID', width:80, sort: true, fixed: 'left'}
		  	      ,{field: 'sname', title: '用户名', width:80}
		  	      ,{field: 'ssex', title: '性别', width:80}
		  	      ,{field: 'sbirthday', title: '出生年月', width:140} 
		  	      ,{field: 'sphone', title: '电话', width: 170}
		  	      ,{field: 'rname', title: '职位', width: 80}
		  	      ,{field: 'sleader', title: '领导', width: 80}
		  	      ,{field: 'sstate', title: '状态', width: 80}
		  	      ,{field: 'stime', title: '休假天数', width: 100}
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
    	  var rid=${sessionScope.staff.roleid};//获取session中身份id
	    	var rid1=data.roleid;//获取当前行的身份id
	    	if(rid==1){
	    		if(rid1!=rid){
	    	  //删除对应行（tr）的DOM结构
	        layer.close(index);
	        obj.del(); //向服务端发送删除指令
	       
	    			  var sid=data.sid;
	    		        $.ajax({
	    		        	url:"Staff/deleteStaff.action",
	    		        	data:{"sid" : sid},
	    		        	type:"post",
	    		        	dataType:"json",
	    		        	success : function(resbody){
	    		        		layer.msg(resbody.msg);
	    		        	}
	    		        	
	    		        });
	    		}
	    	}
	      
	      });
	    } else if(layEvent === 'edit'){
	    	var rid=${sessionScope.staff.roleid};
	    	var rid1=data.roleid;
	    	if(rid==1){
	    		if(rid1!=rid){
	    			layer.open({
	   	    		 type: 2,
	   		   		  title : "修改员工信息",
	   		   		  area: ['600px', '600px'],
	   		    	  content: 'view/updateStaff.action?sid='+data.sid+'&sname='+data.sname+'&ssex='+data.ssex+'&sbirthday='+data.sbirthday+'&sphone='+data.sphone+'&sid_leader='+data.sid_leader+'&roleid='+data.roleid+'&sstate='+data.sstate+'&stime='+data.stime, //这里content是一个普通的String
	   	    		  end: function () {
	   	    	        	
	   	    	        	table.reload("tab" ,{
	   	    	        	});
	   	    	          },
	   		    	}); 
	    		}
	    	}
	    	 
	    }
	  });
	  
	  //分页
	  laypage.render({
	    elem: 'pageDemo' //分页容器的id
	    ,count: 100 //总页数
	    ,skin: '#1E9FFF' //自定义选中色值
	    //,skip: true //开启跳页
	    ,jump: function(obj, first){
	      if(!first){
	        layer.msg('第'+ obj.curr +'页');
	      }
	    }
	  });
	  
	
	  
	});
	
	return false;
}


</script>

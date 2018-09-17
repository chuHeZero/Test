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
	    ,height: 480
	    ,url: 'Visit/rt.action?cid='+${param.cid} //数据接口
	    //,page: true //开启分页
	    ,cols: [[ //表头
	      {field: 'id', title: '回访ID', width:80, sort: true, fixed: 'left'}
	      ,{field: 'cname', title: '客户姓名', width:120}
	      ,{field: 'sname', title: '所属员工', width:120}
	      ,{field: 'vtime', title: '回访时间', width:140} 
	      ,{field: 'vname', title: '回访状态', width: 100}
	      ,{field: 'vremarks', title: '备注', width: 740}
	    ]]
	  });

	});
	

</script>
</head>
<body>
<table class="layui-table" id="test" lay-filter="demo"></table>
</body>
</html>
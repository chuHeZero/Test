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
<style type="text/css">
.img-parent{
	float: left;
	position : relative;
}
.img-parent .img-delete{
	background-color: #00000051;
	cursor:pointer;
	position: absolute;
	top: 0px;
	left: 0px;
	width: 1024px;
	height: 768px;
	line-height: 768px;
	text-align: center;
	color: #FFF;
	display: none;
}
.img-parent .layui-upload-img {
	width: 1024px;
	height: 768px;
	margin: 0 10px 10px 0;
}
.img-parent:hover .img-delete{
	display: block;
}
</style>
<script src="layui/layui.js"></script>
<script type="text/javascript" src="js/jquery-2.2.4.min.js"></script>

</head>
<body>
	<form class="layui-form" style="margin-top: 60px; margin-left: 120px;">
		<div class="layui-form-item">
			<label class="layui-form-label">产品图片ID</label>
			<div class="layui-input-inline">
				<input type="text" name="pid" required lay-verify="required"
					value="${param.pid }" readonly="readonly" autocomplete="off"
					class="layui-input" style="width: 190px" />
			</div>
			<label class="layui-form-label">产品名</label>
			<div class="layui-input-inline">
				<input type="text"  required lay-verify="required"
					value="${param.pname }" readonly="readonly" autocomplete="off"
					class="layui-input" style="width: 190px" />
			</div>
		</div>
		<div class="layui-form-item layui-form-text" >
			<label class="layui-form-label">上传产品图</label>
			<div class="layui-upload-drag" id="test10" style="width: 440px;">
				<i class="layui-icon"></i>
				<p>点击上传，或将文件拖拽到此处</p>
			</div>
			<blockquote class="layui-elem-quote layui-quote-nm"
				style="margin-top: 10px; margin-left:-100px; display: table;">
				产品图片：
				<div class="layui-upload-list" id="demo2"></div>
			</blockquote>
		</div>

		<div class="layui-form-item">
			<div class="layui-input-block" style="margin-left:-100px; width: 1024px;">
				<button class="layui-btn" lay-submit="" lay-filter="formDemo" style="width: 1024px;" id="myForm" >立即修改</button>
			</div>
		</div>
	</form>
	
<script type="text/javascript">
	

layui.use('laydate', function(){
	  var laydate = layui.laydate;
	  getPic();
	  //执行一个laydate实例
	  laydate.render({
	    elem: '#test1' //指定元素
	  });
	});

	layui.use(['form','upload'], function(){//更新渲染
	    var form = layui.form //只有执行了这一步，部分表单元素才会自动修饰成功
	    ,upload=layui.upload;
	    form.render();	
	    
	  //拖拽上传
		  upload.render({
		    elem: '#test10',
		    url: 'Product/uploadPic.action',
		    multiple:true,
		    before: function(obj){
		    	layer.load(); //上传loading
		    },
		    allDone : function(obj){
		    	layer.closeAll('loading'); //关闭loading
		    	layer.msg("上传完成");
		    },
		    done : function(res){   //每个文件提交都会触发
		      console.log(res)
		      
		      var imgDiv = $("<div class=\"img-parent\">" +
						"	<img src=\"" + res.data.purl + "\" class=\"layui-upload-img\">" +
						"	<div class=\"img-delete\">点击删除</div>"+
						"</div>");
				
				
				$("#demo2").append(imgDiv);
				
				imgDiv.click(function(){
					$(this).remove();
				});
		    },
		    error : function(index,upload){ 
		  		layer.msg("上传失败");
		  	}
		  });
	});
	
	getPic();
	
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
		  
		  var pid = data.field.pid;
		  
		  var pics = new Array();
		  
		  //选择所有图片
		  $(".layui-upload-img").each(function(){
			  pics.push($(this).attr("src"));
		  });
		  
		  
	    $.ajax({
	    	url:"Product/updatePic.action",
	    	type:"post",
	    	data:{"pid":pid,"pics":pics},
	    	traditional : true,
	    	dataType:"json",
	    	success:function(data){
	    		//layer.msg(resbody.msg);
	    		if(data.code == -1){
	    			layer.msg(data.msg);
	    		}else if(data.code == -2){
	    			layer.msg(data.msg);
	    		}else{
	    			layer.msg("修改成功");
	    			$("#myForm").submit();
					var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
					setTimeout(function () {
					  parent.layer.close(index); // 关闭layer
					},1500);
	    		}
	    		
	    	}
	    });
	    return false;
	  });
	  
	});
	
	//产品图片
	function getPic(){
		var pid=${param.pid};
		$.ajax({
			url:"view/AllPic.action",
			async: false,
			type:"post",
			data:{"pid":pid},
			dataType:"JSON",
			success:function(data){
				
				var imgDiv ="";
				$.each(data,function(index,item){
						
					imgDiv +="<div class=\"img-parent\">" +
					"	<img src=\"" + item.purl + "\" class=\"layui-upload-img\">" +
					"	<div class=\"img-delete\">点击删除</div>"+
					"</div>";
					
				})
				$(".layui-upload-list").html(imgDiv);
				
				$(".img-parent").click(function(){
					$(this).remove();
				});
			}
		});
		}
	
</script>	
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<style>
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
	width: 92px;
	height: 92px;
	line-height: 90px;
	text-align: center;
	color: #FFF;
	display: none;
}
.img-parent .layui-upload-img {
	width: 92px;
	height: 92px;
	margin: 0 10px 10px 0;
}
.img-parent:hover .img-delete{
	display: block;
}
</style>
<form class="layui-form" style="margin-top:60px;margin-left:120px;">
  <div class="layui-form-item">
    <label class="layui-form-label ">产品名</label>
    <div class="layui-input-inline" style="width:500px;">
      <input type="text" id="sname" name="pname" required lay-verify="required" placeholder="请输入产品名" autocomplete="off" class="layui-input cname">
    </div>
  </div>
  
  <div class="layui-form-item">
    <label class="layui-form-label">市场价格</label>
    <div class="layui-input-inline" style="width:500px;">
      <input type="text" id="spassword" name="pprice" required lay-verify="required" placeholder="请输入市场价格" autocomplete="off" class="layui-input cage">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">最低价格</label>
    <div class="layui-input-inline" style="width:500px;">
      <input type="text" id="spassword" name="pprice_min" required lay-verify="required" placeholder="请输入最低价格" autocomplete="off" class="layui-input cage">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">库存</label>
    <div class="layui-input-inline" style="width:500px;">
      <input type="text" id="sphone" name="pcount" required lay-verify="required" placeholder="请输入库存" autocomplete="off" class="layui-input cphone">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">产品分类</label>
    <div class="layui-input-block" style="width:500px;">
      <select class="getrole" name="ptype" required id="role" id="cate" lay-filter="cate" >
    
      </select>
    </div>
  </div>

  <div class="layui-form-item layui-form-text">
    <label class="layui-form-label">产品介绍</label>
    <div class="layui-input-block">
      <textarea placeholder="请输入产品介绍" name="pdept" class="layui-textarea" style="width:500px; height:70px;"></textarea>
    </div>
  </div>
  <div class="layui-form-item layui-form-text">
    <label class="layui-form-label">产品图片</label>
    <div class="layui-upload-drag" id="test10" style="width:440px;">
	  <i class="layui-icon"></i>
	  <p>点击上传，或将文件拖拽到此处</p>
	</div>
 	 <blockquote class="layui-elem-quote layui-quote-nm" style="margin-top: 10px; width:470px; margin-left:110px; display: table;">
    	预览图：
   		 <div class="layui-upload-list" id="demo2"></div>
 	</blockquote>
  </div>
 	
  <div class="layui-form-item">
    <div class="layui-input-block">
      <button class="layui-btn" lay-submit="" lay-filter="formDemo" style="width:503px;">立即添加</button>
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
		  
		  var pname = data.field.pname;
		  var ptype = data.field.ptype;
		  var pprice = data.field.pprice;
		  var pprice_min = data.field.pprice_min;
		  var pcount = data.field.pcount;
		  var pdept = data.field.pdept;
		  
		  var pics = new Array();
		  
		  //选择所有图片
		  $(".layui-upload-img").each(function(){
			  pics.push($(this).attr("src"));
		  });
		  
		  
	    $.ajax({
	    	url:"Product/addProduct.action",
	    	type:"post",
	    	data:{"pname":pname,"ptype":ptype,"pprice":pprice,"pprice_min":pprice_min,"pcount":pcount,"pdept":pdept,"pics":pics},
	    	traditional : true,
	    	dataType:"json",
	    	success:function(data){
	    		//layer.msg(resbody.msg);
	    		if(data.code == -1){
	    			layer.msg(data.msg);
	    		}else if(data.code == -2){
	    			layer.msg(data.msg);
	    		}else{
	    			layer.msg("添加成功");
	    			var viewurl = "access/view/insertProduct.action";
	    			updateview(viewurl)
	    		}
	    		
	    	}
	    });
	    return false;
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
				
				var html ="";
				$.each(data,function(index,item){
					
					html +="<option value="+item.tid+">"+item.tname+"</option>";
				})
				$(".getrole").html(html);
				
			}
		});
		}
	
</script>
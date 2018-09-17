<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	//System.out.println("path="+path);
	//System.out.println("basePath="+basePath);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="layui/css/layui.css">
<script src="layui/layui.js"></script>
<script type="text/javascript" src="js/jquery-2.2.4.min.js"></script>
<script type="text/javascript">

	$(function(){
		//JavaScript代码区域
		
		//Demo
		layui.use('form', function() {
			var form = layui.form;
			//监听提交
			form.on('submit(formDemo)', function(data) {
				
				 $.ajax({
				    	url:"Customer/updateCustomer.action",
				    	data:data.field,
				    	type:"post",
				    	dataType:"json",
				    	success:function(resbody){
				    		//layer.msg(resbody.msg);
				    		if(resbody==-100){
				    			layer.msg("修改成功");
				    			$("#myForm").submit();
								var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
								setTimeout(function () {
								  parent.layer.close(index); // 关闭layer
								},1500);
				    		}else{
				    			layer.msg("修改失败");
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
		
		layui.use(['laydate' ],
				function() {
					var  laydate = layui.laydate;

					//日期
					laydate.render({
						elem : '#date'
					});
					laydate.render({
						elem : '#date1'
					});

				});
		
		getrole();
		getstaffBysleader();
		getintentionstate();
		getvisitstate();
		getstaff();
	});
	
	//意向类别
	function getrole(){
		var tid = ${param.tid}
		$.ajax({
			url:"view/gettype.action",
			async: false,
			type:"post",
			data:{},
			dataType:"JSON",
			success:function(data){
				
				var html ="";
				$.each(data,function(index,item){
					if (tid == item.tid) {
					html +="<option value="+item.tid+" selected>"+item.tname+"</option>";
						
					} else {
						
					html +="<option value="+item.tid+">"+item.tname+"</option>";
					}
				})
				$(".getrole").html(html);
			}
			
		});
		}
		//意向产品
		 function getstaffBysleader(){
			 var pid = ${param.pid};
			$.ajax({
				url:"view/getproductByPid.action",
				async: false,
				type:"post",
				data:{"pid" : pid },
				dataType:"JSON",
				success:function(data){
					
					var html ="";
					$.each(data,function(index,item){
						
						if (pid == item.pid) {
							
							html +="<option value="+item.pid+" selected>"+item.pname+"</option>";
								
							}else {
								
								html +="<option value="+item.pid+">"+item.pname+"</option>";
							}
						
						
					});
					$("#getstaffByRoleid").html(html);
				}
			});
		} 
		//意向状态
			function getintentionstate(){
				var iid = ${param.iid}
				$.ajax({
					url:"view/gettent.action",
					async: false,
					type:"post",
					data:{},
					dataType:"JSON",
					success:function(data){
						
						var html ="";
						$.each(data,function(index,item){
							if (iid == item.iid) {
							html +="<option value="+item.iid+" selected>"+item.iname+"</option>";
								
							} else {
								
							html +="<option value="+item.iid+">"+item.iname+"</option>";
							}
						})
						$(".getintentionstate").html(html);
					}
					
				});
				}
		//回访状态
		function getvisitstate(){
			var vid = ${param.vid}
			$.ajax({
				url:"view/getvisitstate.action",
				async: false,
				type:"post",
				data:{},
				dataType:"JSON",
				success:function(data){
					
					var html ="";
					$.each(data,function(index,item){
						if (vid == item.vid) {
						html +="<option value="+item.vid+" selected>"+item.vname+"</option>";
							
						} else {
							
						html +="<option value="+item.vid+">"+item.vname+"</option>";
						}
					})
					$(".getvisitstate").html(html);
				}
				
			});
			}
		//所属员工
		function getstaff(){
			var sid = ${param.sid}
			$.ajax({
				url:"view/getstaff.action",
				async: false,
				type:"post",
				data:{},
				dataType:"JSON",
				success:function(data){
					
					var html ="";
					$.each(data,function(index,item){
						if (sid == item.sid) {
						html +="<option value="+item.sid+" selected>"+item.sname+"</option>";
							
						} else {
							
						html +="<option value="+item.sid+">"+item.sname+"</option>";
						}
					})
					$(".getstaff").html(html);
				}
				
			});
			}
</script>
</head>
<body>
	<form class="layui-form" action="Staff/updateStaff.action" method="post">
		<div class="layui-form-item">
			<label class="layui-form-label">客户ID</label>
			<div class="layui-input-block">
				<input type="text" name="cid" required lay-verify="required"
					value="${param.cid }" readonly="readonly"  autocomplete="off" class="layui-input" style="width: 400px;" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">客户姓名</label>
			<div class="layui-input-block">
				<input type="text" name="cname" required lay-verify="required"
					value="${param.cname }"   autocomplete="off" class="layui-input" style="width: 400px;" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">性别</label>
			<div class="layui-input-block">
				<c:if test="${param.csex == '男' }">
					<input type="radio" name="csex" value="男" title="男" checked />
					<input type="radio" name="csex" value="女" title="女" />
				</c:if>
				<c:if test="${param.csex == '女' }">
					<input type="radio" name="csex" value="男" title="男" />
					<input type="radio" name="csex" value="女" title="女" checked />
				</c:if>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">年龄</label>
			<div class="layui-input-block">
				<input type="text" name="cage" required lay-verify="required"
					 autocomplete="off" class="layui-input" style="width: 400px;" value="${param.cage }"/>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">电话</label>
			<div class="layui-input-block">
				<input type="text" name="cphone" required lay-verify="required"
					 autocomplete="off" class="layui-input" style="width: 400px;" value="${param.cphone }"/>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">意向类别</label>
			<div class="layui-input-block" style="width: 400px;">
				<select class="getrole" name="tid" lay-verify="required" id="cate" lay-filter="cate" style="width: 190px">
					
				</select>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">意向产品</label>
			<div class="layui-input-block" style="width: 400px;">
				<select id="getstaffByRoleid" name="pid" lay-verify="required" style="width: 400px;">
				
				</select>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">意向</label>
			<div class="layui-input-block" style="width: 400px;">
				<select class="getintentionstate" name="iid" lay-verify="required" style="width: 400px;">
					
				</select>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">回访状态</label>
			<div class="layui-input-block" style="width: 400px;">
				<select class="getvisitstate" name="vid" lay-verify="required" style="width: 400px;">
					
				</select>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">所属员工</label>
			<div class="layui-input-block" style="width: 400px;">
				<select class="getstaff" name="sid" lay-verify="required" style="width: 400px;">
					
				</select>
			</div>
		</div>
		<div class="layui-form-item layui-form-text">
	    <label class="layui-form-label">备注</label>
	    <div class="layui-input-block">
	      <textarea name="cremarks" class="layui-textarea" rows="5" cols="10" style="width: 400px;">${param.cremarks }</textarea>
	    </div>
	  </div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn" id="myForm" lay-submit lay-filter="formDemo" style="width: 280px;">立即提交</button>
				<button type="reset" class="layui-btn layui-btn-primary" style="width: 100px;">重置</button>
			</div>
		</div>
	</form>

</body>
</html>



<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<form class="layui-form">
		<div class="layui-form-item">
			<label class="layui-form-label">员工ID</label>
			<div class="layui-input-block">
				<input type="text" name="sid" required lay-verify="required"
					value="${sessionScope.staff.sid }" readonly="readonly"  autocomplete="off" class="layui-input" style="width: 190px" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">员工姓名</label>
			<div class="layui-input-block">
				<input type="text" name="sname" required lay-verify="required"
					value=" ${sessionScope.staff.sname }"  autocomplete="off" class="layui-input" style="width: 190px" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">性别</label>
			<div class="layui-input-block">
				<c:if test="${sessionScope.staff.ssex == '男' }">
					<input type="radio" name="ssex" value="男" title="男" checked />
					<input type="radio" name="ssex" value="女" title="女" />
				</c:if>
				<c:if test="${sessionScope.staff.ssex == '女' }">
					<input type="radio" name="ssex" value="男" title="男" />
					<input type="radio" name="ssex" value="女" title="女" checked />
				</c:if>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">出生年月</label>
			<div class="layui-input-inline">
				<input type="text" name="birthday" id="date" lay-verify="date"
					 autocomplete="off" class="layui-input" value="<fmt:formatDate value="${sessionScope.staff.sbirthday }" pattern="yyyy-MM-dd"/>" />
			</div>
			<div class="layui-form-mid layui-word-aux">日期格式为年年年年-月月-日日</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">电话</label>
			<div class="layui-input-block">
				<input type="text" name="sphone" required lay-verify="required"
					 autocomplete="off" class="layui-input" style="width: 190px" value="${sessionScope.staff.sphone }"/>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">状态</label>
			<div class="layui-input-block" style="width: 190px">
				<select name="sstate" lay-verify="required" style="width: 190px">
					<option value="${sessionScope.staff.sstate }"></option>
					<option value="正式">正式</option>
					<option value="实习生">实习生</option>
					<option value="临时">临时</option>
				</select>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">休假天数</label>
			<div class="layui-input-block">
				<input type="text" name="stime" required lay-verify="required"
				 autocomplete="off" class="layui-input" style="width: 190px;" value="${sessionScope.staff.stime }" />
			</div>
			<div class="layui-form-mid layui-word-aux" style="margin-left: 110px;">休假天数以天为单位!!!</div>
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
	  getrole();
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
	    	url:"Staff/MyInfoupdate.action",
	    	data:data.field,
	    	type:"post",
	    	dataType:"json",
	    	success:function(resbody){
	    		//layer.msg(resbody.msg);
	    		if(resbody.code>0){
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
	});
	
	//个人信息
	function getrole(){
		var rid = ${sessionScope.staff.roleid };
		$.ajax({
			url:"view/getrole.action",
			async: false,
			type:"post",
			data:{},
			dataType:"JSON",
			success:function(data){
				
				var html ="";
				$.each(data,function(index,item){
					if (rid == item.rid) {
					html +="<option value="+item.rid+" selected>"+item.rname+"</option>";
					} else {
					html +="<option value="+item.rid+">"+item.rname+"</option>";
					}
				})
				$(".getrole").html(html);
			}
			
		});
		}
</script>
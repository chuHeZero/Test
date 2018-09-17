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
</head>
<body>
	<!-- 引入Echarts.js -->
    <script type="text/javascript" src="js/echarts.js"></script>
    
    <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
    <div id="main" style="width: 1300px;height:400px;"></div>
    <div id="yeji" style="width: 1300px; height:400px;"></div>
    <script type="text/javascript">
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main'));
     
        $.ajax({
        	url: "Product/getSalesCount.action",
        	type: "post",
        	dataType : "JSON",
        	success : function(data){
        		
        		var pnames = new Array();
        		var counts = new Array();
        		
        		$.each(data,function(index,item){
        			pnames.push(item.pname);
        			counts.push(item.amcount);
        		});
        		
        		  // 指定图表的配置项和数据
                var option = {
                    title: {
                        text: '产品销量'
                    },
                    grid:{
                    	top: 50,
                    	x:45,
                    	x2:30,
                    	y2:80,
                    },
                    tooltip: {},
                    legend: {
                        data:['销量']
                    },
                    xAxis: {
                        data: pnames,
                        axisLabel:{
						     interval:0,//横轴信息全部显示
						       rotate:-30,//-30度角倾斜显示  
						},
                    },
                    yAxis: {},
                    series: [{
                        name: '销量',
                        type: 'bar',
                        data: counts
                    }]
                };

                // 使用刚指定的配置项和数据显示图表。
                myChart.setOption(option);
        	} 
        });
     // 基于准备好的dom，初始化echarts实例
		var myCharta = echarts.init(document.getElementById('yeji'));

		$.ajax({
			url : "Staff/getStaffCount.action",
			type : "post",
			dataType : "JSON",
			success : function(data) {

				var snames = new Array();
				var counts = new Array();

				$.each(data, function(index, item) {
					snames.push(item.sname);
					counts.push(item.amcount);
				});

				// 指定图表的配置项和数据
				var option = {
					title : {
						text : '员工业绩'
					},
					grid : {
						top : 50,
						x : 45,
						x2 : 30,
						y2 : 80,
					},
					tooltip : {},
					legend : {
						data : [ '销量' ]
					},
					xAxis : {
						data : snames,
						axisLabel : {
							interval : 0,//横轴信息全部显示
							rotate : -30,//-30度角倾斜显示  
						},
					},
					yAxis : {},
					series : [ {
						name : '销量',
						type : 'bar',
						data : counts
					} ]
				};

				// 使用刚指定的配置项和数据显示图表。
				myCharta.setOption(option);
			}
		});
    </script>
    </div> 
</body>
</html>
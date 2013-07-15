<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	// 点数量
	int point_Count = 10;
	// div大小
	int div_Width = 400;
	int div_Height = 200;
	// 点大小
	int point_Width = 10;
	int point_Height = 10;
	
	// 存储已经随机出的点
	int[] left_Array = new int[point_Count];
	int[] top_Array = new int[point_Count];
	// 随机类
	class Mice{
		public int randomNum(int MIN, int MAX){
			return new Random().nextInt(MAX - MIN + 1) + MIN; 
		}
	}
	Mice mice = new Mice();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="../../../headerinclude.jsp"%>
<style>
		.block {background-color: #009900;height: <%=point_Height%>px;width: <%=point_Width%>px;}
	</style>
</head>
<body class="mxkbody mxkbackgroud" >
<%@ include file="../public/user_page_header.jsp"%>
  	<div class="container">
  	  <div class="row">
<div class="span9" >
  	<div id="tprs" style="position:absolute;">
  		<img class="img-polaroid" src="http://www.waileecn.com/mxk/image/51dec4ac0cf2b647c875d66a_full.png">
  		<% 
  			for(int i = 0;i < point_Count;i++){
  				int left = 0;
  				int top = 0;
  				// 随机数需要注意
  				// 1 与点宽度/长度相加不能超出div范围
  				// 2 不能出现点与点之间重叠的情况
  				// 随机处理
  				boolean again = true;
  				while(again){
  					left = mice.randomNum(0, div_Width);
  					top = mice.randomNum(0, div_Height);
  					// 2.1 随机点不能超出div范围
  					if(left > div_Width - point_Width || top > div_Height - point_Height){
  						again = true;
  						continue;
  					}else{
  						again = false;
  					}
  					// 对比已经存在的点数据
  					for(int j = 0;j < i;j++){
  						// 判断四个顶点是否已经存在于已有节点中
  						// 左上顶点
  						int zb1_x = left;
  						int zb1_y = top;
  						// 右上顶点
  						int zb2_x = left + point_Width;
  						int zb2_y = top;
  						// 左下顶点
  						int zb3_x = left;
  						int zb3_y = top + point_Height;
  						// 右下顶点
  						int zb4_x = left + point_Width;
  						int zb4_y = top + point_Height;
  						// 已经存在的坐标的范围
						int left_FW = left_Array[j] + point_Width;
						int top_FW = top_Array[j] + point_Height;
						// 判断标记
						boolean mark =  false;
						if(zb1_x <= left_FW && zb1_x >= left_Array[j] && zb1_y <= top_FW && zb1_y >= top_Array[j]){
							mark = true;
						}
						if(zb2_x <= left_FW && zb2_x >= left_Array[j] && zb2_y <= top_FW && zb2_y >= top_Array[j]){
							mark = true;
						}
						if(zb3_x <= left_FW && zb3_x >= left_Array[j] && zb3_y <= top_FW && zb3_y >= top_Array[j]){
							mark = true;
						}
						if(zb4_x <= left_FW && zb4_x >= left_Array[j] && zb4_y <= top_FW && zb4_y >= top_Array[j]){
							mark = true;
						}
						if(mark){
							again = true;
	  						continue;
						}
  	  				}
  				}
  				left_Array[i] = left;
  				top_Array[i] = top;
  				out.println("<div style='top:"+top+"px; left:"+left+"px; position:absolute'><a href='#' title='first tooltip'><i class='icon-comment-alt'></i></a></div>");	
  			}
  		%>	
	</div>
</div>  	    
  	    <div class="span3">
  	    </div>
  	
  	
  	  </div>
  	</div>
  	<%@ include file="../../../footinclude.jsp"%>
  </body>
</html>
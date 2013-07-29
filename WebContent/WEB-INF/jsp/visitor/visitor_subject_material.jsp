<%@page import="org.apache.struts2.ServletActionContext"%>
<%@page import="com.opensymphony.xwork2.util.ValueStack"%>
<%@page import="com.mxk.org.web.subject.domain.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
 <%@ include file="../../../headerinclude.jsp"%>
 <%
   
  ValueStack v = ServletActionContext.getValueStack(request);
  SubjectMaterailDetailRespone sub  =  (SubjectMaterailDetailRespone) v.findValue("subjectMaterailDetailRespone");
  String data = sub.getChartData();
  %>
</head>

<body class="mxkbody mxkbackgroud" onload="showChart()">
<%@ include file="../public/user_page_header.jsp"%>
<c:if test="${empty subjectMaterailDetailRespone.list  }">
<div class="container">
	  <div class="alert alert-block">
	     <a class="close" data-dismiss="alert">×</a>
	     <h4 class="alert-heading">没有创建材料单</h4>
	   </div>
  </div>
</c:if>
<c:if test="${!empty subjectMaterailDetailRespone.list  }">
<div class="container">
	<div class="row">
	  <div class="span7 mxkplan mxkshadow">
	     <div style='padding:5px;margin-bottom:5px;'>
	      <table id="listtableshow" class="table table-striped table-bordered table-condensed">
	         <tr>
	          <td width="45%">材料名称</td>
	          <td width="15%">类型</td>
	           <td width="20%">品牌</td>
	           <td width="10%">数量</td>
	           <td width="10%">单价</td>
	         </tr>
                <c:forEach var="options" items="${subjectMaterailDetailRespone.list }">
                <tr>
	                <td width="45%">${options.name }</td>
		            <td width="15%">${options.type }</td>
		            <td width="20%">${options.brand }</td>
		            <td width="10%">${options.num }</td>
		            <td width="10%">${options.money }</td>
                </tr>
               </c:forEach>
	       </table>
	     </div>
	  </div>
	  <div class="span5 mxkplan mxkshadow" >
	     <table style="width:100%" >
				  <tr>
				    <td width="16%">
				          <img class="img-polaroid" style="width:30px" src="<%=imgurl %>${subjectEntity.faceimage }" />
				     </td>
				    <td width="84%">
					    <div style="width:150px;text-overflow:ellipsis; white-space:nowrap; overflow:hidden;">
					       <strong>${subjectEntity.name }</strong>
					    </div>
					    <div style="width:150px;text-overflow:ellipsis; white-space:nowrap; overflow:hidden;">
					      <small >${subjectEntity.info }</small>
					    </div>
				    </td>
				  </tr>
				</table>
				<div style='padding:1px;margin-bottom:1px;'>
			            <div style='width:100%; border-top:1px solid #cccccc'></div>
			    </div>
			    <div id="chart" ></div>
	            <div style='padding:1px;margin-bottom:5px;'>
		           <span class="pull-right">
		              <a class="btn" target="_blank" href="<%=excel%>${subjectMaterailDetailRespone.summary.dowmloadExl}"> <i class="icon-cloud-download"></i>下载Excel</a>
		           </span>
		           <br /><br />
	           </div>
	  </div>
	</div>
</div>
</c:if>

<%@ include file="../../../footinclude.jsp"%>
<%@ include file="../../../chartinclude.jsp"%>
<script type="text/javascript">
    function showChart(){
        $.jqplot('chart', [<%=data%>], {
    	    animate: true,
            animateReplot: true,
            grid: {
                drawBorder: false,
                drawGridlines: false,
                background: '#ffffff',
                shadow:false
            },
            axesDefaults: {
                 
            },
            seriesDefaults:{
                renderer:$.jqplot.PieRenderer,
                rendererOptions: {
                    showDataLabels: true
                }
            },
            legend: {
                show: true,
                rendererOptions: {
                    numberRows: 1
                },
                location: 's'
            }
        });
    }
</script>
 </body>
</html>

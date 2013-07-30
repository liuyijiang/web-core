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
<div class="container">
	<div class="row">
	  <div class="span7 mxkplan mxkshadow">
	     <div style='padding:5px;margin-bottom:5px;'>
	      <table id="listtableshow" class="table table-striped table-bordered table-condensed">
	         <tr>
	          <td width="35%">材料名称</td>
	          <td width="15%">类型</td>
	           <td width="20%">品牌</td>
	           <td width="10%">数量</td>
	           <td width="10%">单价</td>
	           <td width="10%">操作</td>
	         </tr>
                <c:forEach var="options" items="${subjectMaterailDetailRespone.list }">
                <tr>
	                <td width="35%">${options.name }</td>
		            <td width="15%">${options.type }</td>
		            <td width="20%">${options.brand }</td>
		            <td width="10%">${options.num }</td>
		            <td width="10%">${options.money }</td>
		            <td width="10%"><a href="javascript:;" onclick="deleteMaterialDetail('${options.id }')">删除</a></td>
                </tr>
               </c:forEach>
	       </table>
	     </div>
	  </div>
	  <div class="span5 mxkplan mxkshadow" >
	     <table style="width:100%" >
				  <tr>
				    <td width="16%">
				          <img class="img-polaroid" style="width:30px" src="<%=imgurl %>${currentSubjectEntity.faceimage }" />
				     </td>
				    <td width="84%">
					    <div style="width:150px;text-overflow:ellipsis; white-space:nowrap; overflow:hidden;">
					       <strong>${currentSubjectEntity.name }</strong>
					    </div>
					    <div style="width:150px;text-overflow:ellipsis; white-space:nowrap; overflow:hidden;">
					      <small >${currentSubjectEntity.info }</small>
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
		              <a class="btn btn-inverse" href="javascript:;" onclick="showCreateMaterial()">
                         <i class="icon-calendar "></i>继续添加
                      </a>
		           </span>
		           <br /><br />
	           </div>
	  </div>
	</div>
</div>

    <div id="materialSubjectModal" class="modalbig hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	    <div class="modal-header">
	       <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	       <h3>添加材料单</h3>
        </div>
        <div style="padding:10px;margin-bottom:5px;">
            <div class="alert alert-error" id="errormessagediv" style="display: none">
			   <span id="errormessage"></span>
		    </div>
	        <div class="form-inline">
				<input type="text" style="width:360px" id="mname"
					class="input-block-level" placeholder="材料名称" onblur="cleanError()" />
				<input type="text" style="width: 180px" id="factroy"
					class="input-block-level" placeholder="品牌" onblur="cleanError()" />	
				<select id="type" style="width: 120px">
					<option value="模型板件">模型板件</option>
					<option value="工具辅料">工具辅料</option>
					<option value="改造材料">改造材料</option>
					<option value="油漆辅料">油漆辅料</option>
					<option value="其他材料">其他材料</option>
				</select> 
				<input type="text" style="width: 60px" id="num"
					class="input-block-level" placeholder="数量" onblur="cleanError()" />
				<input type="text" style="width: 60px" id="money"
					class="input-block-level" placeholder="单价" onblur="cleanError()" />
				<button class="btn pull-right btn-info" onclick="addList()">
					<i class="icon-plus"></i>添加
				</button>
			</div>
			<br /> <span class="text-success"><i
				class="icon-shopping-cart"></i>制作材料清单</span>
			<table id="listtable"
				class="table table-striped table-bordered table-condensed">
				<tr>
					<td width="45%">材料名称</td>
					<td width="15%">品牌</td>
					<td width="10%">类型</td>
					<td width="10%">数量</td>
					<td width="10%">单价</td>
					<td width="10%">操作</td>
				</tr>
			</table>
	    </div>		
	    <div class="modal-footer">
	      <a href="javascript:;" class="btn btn-primary" onclick="add()" >保存</a>
	      <a href="javascript:;" class="btn" onclick="closeCreateMaterial()" >关闭</a>
	    </div>
    </div>
    
    <!-- 材料  -->	   
     <form id="tfrom" action="updateSujectMaterial" method="post" style="display:none">
		<table id="upfrom">

		</table>
	</form>
    
<script type="text/javascript">

function deleteMaterialDetail(id){
	 $.ajax({
    		url : path + "/deleteSubjectMaterial.action",
    		type : "POST",
    		cache : false,
    		async : false,
    		data: {"targetId":id},
    		dataType : "json",
    		success : function(item) {
    			if(item == 'success'){
		    	    window.location.href= path + "/showSubjectMaterial";
		        }else{
		    	    alert("网络异常请重试");
		        }
    		  }
		  });
}
   
   
function showCreateMaterial(){
	 $('#materialSubjectModal').modal({
	       keyboard: false
	 }); 
}

function closeCreateMaterial(){
	 $('#materialSubjectModal').modal('hide');
}

</script>
<script type="text/javascript">
    var namearray = new Array();
	var typearray = new Array();
	var cjarray = new Array();
	var slarray = new Array();
	var jearray = new Array();

	function cleanError() {
		$('#errormessagediv').hide();
		$('#errormessage').html("");
	}

	function addList() {
		var name = $("#mname").val();
		var type = $("#type").val();
		var factroy = $("#factroy").val();
		var num = $("#num").val();
		var money = $("#money").val();

		if (name.trim() == "") {
			$('#errormessagediv').show();
			$('#errormessage').html("你还没输入材料名称");
			return;
		}

		if (factroy.trim() == "") {
			$('#errormessagediv').show();
			$('#errormessage').html("你还没输入品牌名称");
			return;
		}

		if (num.trim() == "") {
			$('#errormessagediv').show();
			$('#errormessage').html("你还没输入材料数量");
			return;
		} else {
			var regu = /^[-]{0,1}[0-9]{1,}$/;
			if (!regu.test(num.trim())) {
				$('#errormessagediv').show();
				$('#errormessage').html("材料数量格式有误");
				return;
			}
		}

		if (money.trim() == "") {
			$('#errormessagediv').show();
			$('#errormessage').html("你还没输入材料单价");
			return;
		} else {
			if (isNaN(money)) {
				$('#errormessagediv').show();
				$('#errormessage').html("材料单价格式有误");
				return;
			}
		}
		// var len = $("#tab tr").length;     
		$("#listtable").append("<tr>"
								+ "<td>"
								+ name
								+ "</td>"
								+ "<td>"
								+ type
								+ "</td>"
								+ "<td>"
								+ factroy
								+ "</td>"
								+ "<td>"
								+ num
								+ "</td>"
								+ "<td>"
								+ money
								+ "</td>"
								+ "<td><a href='javascript:' onclick='removeLine(this);'>删除</a></td>"
								+ "</tr>");

	}

	function removeLine(k) {
		$(k).parent().parent().remove();
	}

	function add() {

		$("#listtable tr td:nth-child(1)").each(function(i) {
			if (i != 0) {
				var s = $(this).text();
				namearray.push(s);
			}

		});
		$("#listtable tr td:nth-child(2)").each(function(i) {
			if (i != 0) {
				var s = $(this).text();
				typearray.push(s);
			}
		});
		$("#listtable tr td:nth-child(3)").each(function(i) {
			if (i != 0) {
				var s = $(this).text();
				cjarray.push(s);
			}
		});
		$("#listtable tr td:nth-child(4)").each(function(i) {
			if (i != 0) {
				var s = $(this).text();
				slarray.push(s);
			}
		});
		$("#listtable tr td:nth-child(5)").each(function(i) {
			if (i != 0) {
				var s = $(this).text();
				jearray.push(s);
			}
		});
		for ( var i = 0; i < typearray.length; i++) {
			$("#upfrom")
					.append(
							"<tr><td>"
									+ "<input name='createSubjectMaiterialRequest.list["+i+"].name' value="+namearray[i]+"><input name='createSubjectMaiterialRequest.list["+i+"].type' value="+typearray[i]+">"
									+ "<input name='createSubjectMaiterialRequest.list["+i+"].brand' value="+cjarray[i]+"><input  name='createSubjectMaiterialRequest.list["+i+"].num' value="+slarray[i]+">"
									+ "<input name='createSubjectMaiterialRequest.list["+i+"].money' value="+jearray[i]+">"
									+ "</td></tr>");
		}
		$("#tfrom").submit();

	}
 
 </script>
<%@ include file="../../../footinclude.jsp"%>
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
<%@ include file="../../../chartinclude.jsp"%>
 </body>
</html>

<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
 <%@ include file="../../../headerinclude.jsp"%>
</head>

<body onload="showChart()">
<%@ include file="../public/user_page_header.jsp"%>
<script type="text/javascript">
    function showChart(){
    	var s1 = [['板件', 9],['PE辅助', 80], ['喷漆', 7],['工具', 6],['其他', 5]];
        
        var plot8 = $.jqplot('chart', [s1], {
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
<div class="container">
	<div class="row">
	  <div class="span8 mxkplan mxkshadow">
	     <div style='padding:5px;margin-bottom:5px;'>
	      <table id="listtable" class="table table-striped table-bordered table-condensed">
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
		            <td width="10%"><a href="javascript:;">删除</a></td>
                </tr>
               </c:forEach>
	       </table>
	     </div>
	  </div>
	  <div class="span4 mxkplan mxkshadow" >
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
		              <a class="btn">下载Excel</a>
		              <a class="btn btn-inverse" href="javascript:;" onclick="showCreateMaterial()">
                         <i class="icon-calendar "></i>继续添加
                      </a>
		           </span>
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
   
function showCreateMaterial(){
	 $('#materialSubjectModal').modal({
	       keyboard: false
	 }); 
}

function closeCreateMaterial(){
	 $('#materialSubjectModal').modal('hide');
}

</script>
<%@ include file="../../../footinclude.jsp"%>
<%@ include file="../../../chartinclude.jsp"%>
 </body>
</html>

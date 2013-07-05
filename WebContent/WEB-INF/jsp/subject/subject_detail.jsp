<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
 <%@ include file="../../../headerinclude.jsp"%>
</head>
<script type="text/javascript">
var page = 2;
var userid = '${currentSubjectEntity.userid}';
var subjectid = '${currentSubjectEntity.id}';
var allpage = '${partShowResponse.allPage}';
var isrun = false;
function createPartPlane(list,subjectid,partthumnailid){
	var show = '';
	for(var i in list)//照片墙第一个位置
	{ 
		 show = show + "<li class='span3 mxkplan mxkshadow'><div class='thumbnail'>"+
		 "<div style='position:relative;' onmouseover='mouseover(\""+ list[i].id +"\")' onmouseout='mouseout(\""+list[i].id +"\")' >" +
		 "<span style='position:absolute; z-index:-1; opacity: 0.8;' id='"+ list[i].id +"'>"+
		 "<a class='btn btn-small' href='javascript:;' onclick='useForSubjectFace(\""+ list[i].id +",\"" + subjectid + "\")'>"+
		 "<i class='icon-picture'></i>封面</a><a class='btn btn-small' href='"+ path +"/showPartsComments?target="+ list[i].id + "'>"+
		 "<i class='icon-comment-alt'></i>评论 </a></span><a href='"+ path +"/partDetail?target="+list[i].id +"'><img src='"+ imgurl + list[i].minimage +"'/></a></div>"+	            
		 "<span class='muted'>"+ list[i].desc +"</span><br /><span class='form-inline'><label class='checkbox' id='checks' style='display:none'>"+               
		 "<input type='checkbox'><span class='text-info'>使用</span></label><span class='pull-right muted'>"+	            
         "<i class='icon-comment'></i>评论"+ list[i].comments +"<i class='icon-pushpin'></i>收藏"+ list[i].collect +"</span></span><br /></div></li>";           
	}
	$('#'+partthumnailid).append(show);
}

function loadMore(){
	if(page <= allpage){
	$('#loaddiv').show();
	   var datas = {"searchPartRequest.page":page,"searchPartRequest.userid":userid,"searchPartRequest.subjectid":subjectid};
	   $.ajax({
	 		url : path + "/loadMoreSubjectParts.action",
	 		type : "POST",
	 		cache : false,
	 		async : false,
	 		data: datas,
	 		dataType : "json",
	 		success : function(item) {
	 			$('#loaddiv').hide();
	 			page = page + 1;
	 			var list1 = item.list1;
				var list2 = item.list2;
				var list3 = item.list3;
				var list4 = item.list4;
				if(list1 != null){
					createPartPlane(list1,subjectid,"partshow1");
				}
				if(list2 != null){
					createPartPlane(list2,subjectid,"partshow2");
				}
				if(list3 != null){
					createPartPlane(list3,subjectid,"partshow3");
				}
				if(list4 != null){
					createPartPlane(list4,subjectid,"partshow4");
				}
				if(useforgif || userforpdf ){
					showchecks();
				}
	 	   }
		});
	}
}

function showload(){ 
   var scrollh = document.documentElement.scrollHeight;
   var scrollt = document.documentElement.scrollTop + document.body.scrollTop;
   if ( scrollt/scrollh > 0.2 ) {
	   if(!isrun){
		   isrun = true;
		   loadMore();
	   }
    }
} 

//绑定事件
function bindScroll(){
    $(window).bind("scroll", function(){ 
       showload();
    }); 
}
</script> 
 <script type="text/javascript" >
       var useforgif = false;
       var userforpdf = false;
      
       function mouseover(id){
         $("#"+id).css("z-index","1");
       }
	   
       function mouseout(id){
		$("#"+id).css("z-index","-1");
	   }
       
       function useForSubjectFace(partid,subid){
    	     var datas = {"setFaceImageRequest.partid":partid,"setFaceImageRequest.subjectid":subid};
    	     $.ajax({
	       		url : path + "/setSubjectFaceImage.action",
	       		type : "POST",
	       		cache : false,
	       		async : false,
	       		data: datas,
	       		dataType : "json",
	       		success : function(item) {
	       			if(item == 'success'){
	   		    	    window.location.href= path + "/showSubjectDetailView";
	   		        }else{
	   		    	    alert("网络异常请重试");
	   		        }
	       		  }
       		  });
       }
       
       function useforgifshow(message){
    	   useforgif = true;
    	   userforpdf = false;
    	   showchecks();
    	   $('#usepart').show();
    	   $('#usepart').html(message);
       }
       
       function useforpdfshow(message){
    	   useforgif = false;
    	   userforpdf = true;
    	   showchecks();
    	   $('#usepart').show();
    	   $('#usepart').html(message);
       }
       
       function showchecks(){
    	   $('.checkbox').show();
    	   //$('[id=checks]').show();
       }
       
       function doaction(){
    	   if(userforpdf){
    		   createpdf();  
    	   }else{
    		   createGif();
    	   }
       }
       
       function createGif(){
    	   var ids = "";
    	   $('.thechecks').each(function(i){
    		   if($(this).attr("checked")){
    			   ids = ids + $(this).val() + ",";
   			   }
    	   });  
    	   if(ids != ""){
    		   $("#action").show();
    		   $.ajax({
     	       		url : path + "/createGif.action",
     	       		type : "POST",
     	       		cache : false,
     	       		async : false,
     	       		data: {"partids":ids},
     	       		dataType : "json",
     	       		success : function(item) {
     	       		     $("#action").hide();
     		       		 if(item == 'success'){
     	    		    	 alter("操作成功！");
     	    		     }else{
     	    		    	 alert("网络异常请重试");
     	    		     }
     	       		  }
               }); 
    	   }
       }
       
       function createpdf(){
    	   var ids = "";
    	   $('.thechecks').each(function(i){
    		   if($(this).attr("checked")){
    			   ids = ids + $(this).val() + ",";
   			   }
    	   }); 
    	   if(ids != ""){
    		   $("#action").show();
    		   $.ajax({
     	       		url : path + "/createPdf.action",
     	       		type : "POST",
     	       		cache : false,
     	       		async : false,
     	       		data: {"partids":ids},
     	       		dataType : "json",
     	       		success : function(item) {
     	       		     $("#action").hide();
     		       		 if(item == 'success'){
     	    		    	 alter("操作成功！");
     	    		     }else{
     	    		    	 alert("网络异常请重试");
     	    		     }
     	       		  }
               }); 
    	   }
       }
       
</script>
<script type="text/javascript">
function changeSubjectStutas(subid,status){
	  var datas = {"updateSubjectStatusRequest.id":subid,"updateSubjectStatusRequest.stauts":status};
	  $.ajax({
		url : path + "/changeSubjectStatus.action",
		type : "POST",
		cache : false,
		async : false,
		data: datas,
		dataType : "json",
		success : function(item) {
		     if(item == 'success'){
		    	 window.location.href= path + "/showSubjectDetailView";
		     }else{
		    	 alert("网络异常请重试");
		     }
		  }
	 }); 
}


function deleteSubject(id){
	if(!confirm("确定要删除吗？删除专题会同时删除Parts和所有评论")){
  		return;  //deleteProject
    }else{
		var datas = {"targetId":id};
		$.ajax({
			url : path + "/deleteSubject.action",
			type : "POST",
			cache : false,
			async : false,
			data: datas,
			dataType : "json",
			success : function(item) {
			     if(item == 'success'){
			    	 window.location.href= path + "/userIndex";
			     }else{
			    	 alert("网络异常请重试");
			     }
			  }
		 }); 
    }
}

</script>
<body class="mxkbody  mxkbackgroud" onload="bindScroll()">
<%@ include file="../public/user_page_header.jsp"%>
<div class="container">
  <div class="row">
     <div class="span1">
        <img class="img-polaroid border-radius"  style="height:60px;width:60px"
         src="<%=imgurl %>${currentSubjectEntity.faceimage }" >
     </div>
     <div class="span11">
        <span>
          <span style="font-size: 20px;"><strong>${currentSubjectEntity.name }</strong></span>
             &nbsp;/&nbsp;<span class="muted">(<i class="icon-tags"></i>${currentSubjectEntity.tags })
             <div class="btn-group">
               <c:choose>
                <c:when test="${currentSubjectEntity.type == 'PUBLIC'}">
                         <a id="substatus" class="btn dropdown-toggle btn-success btn-mini" data-toggle="dropdown" href="#">
                            <i class="icon-hdd"></i>公开
				   </a>
                </c:when>
                <c:when test="${currentSubjectEntity.type == 'PRIVATE'}">
                  <a  id="substatus" class="btn dropdown-toggle btn-danger btn-mini" data-toggle="dropdown" href="#">
                          <i class="icon-lock"></i>私有
				   </a>
                </c:when>
             </c:choose>
              <ul class="dropdown-menu">
		       <li><a href="javascript:;" onclick="changeSubjectStutas('${currentSubjectEntity.id}','PUBLIC')"><i class="icon-hdd"></i>公开</a></li>
			   <li><a href="javascript:;" onclick="changeSubjectStutas('${currentSubjectEntity.id}','PRIVATE')"><i class="icon-lock"></i>私有</a></li>
		       </ul>
             </div>
           </span>
        </span>
        <span class="pull-right">
           <a href="javascript:;" class="btn btn-info" onclick="showCreatePart()"><i class="icon-pushpin"></i>添加Part</a>
            <a class="btn btn-inverse" href="javascript:;" onclick="showCreateMaterial()">
              <i class="icon-calendar "></i>材料列表
            </a>
         </span>
        <br />
        <span class="muted"><small>${currentSubjectEntity.info }</small></span><br />
        <span><i class="icon-time"></i>Create Time:${currentSubjectEntity.createTime }</span>
        <span>
           <c:if test="${subjectExtraEntity.pdfUrl != '-' }">
              <a class="btn btn-mini" href="<%=pdf %>${subjectExtraEntity.pdfUrl}" target="_blank"><i class='icon-download-alt'></i>下载PDF</a>
           </c:if>
           <c:if test="${subjectExtraEntity.gifUrl != '-' }">
              <button class="btn btn-mini" onclick="showGifSubject()" ><i class="icon-picture"></i>查看GIF</button>
           </c:if>
        </span>
             <div class="btn-group pull-right " >
			  <a href="<%=rootPath %>/subjectMessage" class="btn btn-mini" style="font-family:Microsoft YaHei;"><i class="icon-rss"></i>订阅${currentSubjectEntity.attention }</a>
			  <a href="<%=rootPath %>/subjectCommentsText"class="btn btn-mini" style="font-family:Microsoft YaHei;"><i class="icon-comment-alt"></i>评论${currentSubjectEntity.comments }</a>
			  <a class="btn btn-mini" style="font-family:Microsoft YaHei;"><i class="icon-pushpin"></i>Parts${currentSubjectEntity.parts }</a>
	        </div>
        <br />
     </div>
  </div>
  <br />
<div class="container ">
		<div class="navbar">
			<div class="navbar-inner">
				 <span>
            <a class="btn" href="javascript:;" onclick="showShareSubject()">
              <i class="icon-globe"></i>分享
            </a>
         </span>
          <span>
          <div class="btn-group">
		    <button class="btn"><i class="icon-cog"></i>操作</button>
			    <button class="btn dropdown-toggle" data-toggle="dropdown">
			    <span class="caret"></span>
	            </button>
			    <ul class="dropdown-menu">
			       <li><a href="javascript:;" onclick="useforgifshow('生成GIF')">生成GIF动态图片</a></li>
				   <li><a href="javascript:;" onclick="useforpdfshow('生成PDF')">生成PDF电子文档</a></li>
				   <li><a href="javascript:;" onclick="deleteSubject('${currentSubjectEntity.id}')">删除专题</a></li>
               </ul>
           </div>
         </span>
         <span>
           <button onclick="doaction()" class="btn btn-info" id="usepart" style='display:none'>ok</button>
            <span id="action" style="display:none" class="muted"><img src="<%=domain %>/image/loadingred.gif" ><small>正在为你生成...</small></span>
         </span>
          <span class="pull-right">
            <a class="btn" href="<%=rootPath %>/showSubjectDetailView">
              <i class="icon-refresh"></i>刷新
            </a>
             <a class="btn" href="<%=rootPath %>/subjectComments">
               <i class="icon-comment-alt"></i>评论${currentSubjectEntity.comments }
            </a>
         </span>
			</div>
		</div>
	</div>
</div>
<c:if test="${!empty partShowResponse }">
 <div class="container">
	      <div class="row">
	      
			<div class="span3">
				<ul class="thumbnails" id="partshow1">
				    <c:forEach var="options" items="${partShowResponse.list1 }">
					  <li class="span3 mxkplan mxkshadow">
						<div class="thumbnail">
						   <div style="position:relative;" onmouseover="mouseover('${options.id }')" onmouseout="mouseout('${options.id }')" >
						       <span style="position:absolute; z-index:-1; opacity: 0.8;" id="${options.id }">
						            <a class="btn btn-small" href="javascript:;" onclick="useForSubjectFace('${options.id }','${currentSubjectEntity.id }')">
						               <i class="icon-picture"></i>封面
						            </a>
                                    <a class="btn btn-small" href="<%=rootPath %>/showPartsComments?target=${options.id}">
                                       <i class="icon-comment-alt"></i>评论
                                    </a>
						       </span>
						       	<a href="<%=rootPath %>/partDetail?target=${options.id}"><img src="<%=imgurl %>${options.minimage}" /></a>
						   </div>
							<span class="muted"><small>${options.desc }</small></span><br />
						    <span class="form-inline">
							        <label class="checkbox" style="display:none">
	                                 <input class="thechecks"  type="checkbox"  value="${options.id }" ><span class="text-info">使用</span>
	                                </label>
							    <span class="pull-right muted">
							         <small>
									    <i class="icon-comment"></i>评论${options.comments }
									    <i class="icon-pushpin"></i>收藏${options.collect }
								     </small>
							    </span>
						    </span><br />
						</div>
				      </li>
				    </c:forEach>
				</ul>
			</div> 
			
			<div class="span3">
				<ul class="thumbnails" id="partshow2">
					  <c:forEach var="options" items="${partShowResponse.list2 }">
					  <li class="span3 mxkplan mxkshadow">
						<div class="thumbnail">
						   <div style="position:relative;" onmouseover="mouseover('${options.id }')" onmouseout="mouseout('${options.id }')" >
						       <span style="position:absolute; z-index:-1; opacity: 0.8;" id="${options.id }">
						            <a class="btn btn-small" href="javascript:;" onclick="useForSubjectFace('${options.id }','${currentSubjectEntity.id }')">
						               <i class="icon-picture"></i>封面
						            </a>
                                   <a class="btn btn-small" href="<%=rootPath %>/showPartsComments?target=${options.id}">
                                       <i class="icon-comment-alt"></i>评论
                                    </a>
						       </span>
						       	<a href="<%=rootPath %>/partDetail?target=${options.id}"><img src="<%=imgurl %>${options.minimage}" /></a>
						   </div>
							<span class="muted"><small>${options.desc }</small></span><br />
						    <span class="form-inline">
							       <label class="checkbox" style="display:none">
	                                 <input class="thechecks"  type="checkbox" value="${options.id }"><span class="text-info">使用</span>
	                                </label>
							     <span class="pull-right muted">
							         <small>
									    <i class="icon-comment"></i>评论${options.comments }
									    <i class="icon-pushpin"></i>收藏${options.collect }
								     </small>
							    </span>
						    </span><br />
						</div>
				      </li>
				    </c:forEach>
				</ul>
			</div> 
			
			<div class="span3">
				<ul class="thumbnails" id="partshow3">
					  <c:forEach var="options" items="${partShowResponse.list3 }">
					  <li class="span3 mxkplan mxkshadow">
						<div class="thumbnail">
						   <div style="position:relative;" onmouseover="mouseover('${options.id }')" onmouseout="mouseout('${options.id }')" >
						       <span style="position:absolute; z-index:-1; opacity: 0.8;" id="${options.id }">
						            <a class="btn btn-small" href="javascript:;" onclick="useForSubjectFace('${options.id }','${currentSubjectEntity.id }')">
						               <i class="icon-picture"></i>封面
						            </a>
                                   <a class="btn btn-small" href="<%=rootPath %>/showPartsComments?target=${options.id}">
                                       <i class="icon-comment-alt"></i>评论
                                    </a>
						       </span>
						       	<a href="<%=rootPath %>/partDetail?target=${options.id}"><img src="<%=imgurl %>${options.minimage}" /></a>
						   </div>
							<span class="muted"><small>${options.desc }</small></span><br />
						    <span class="form-inline">
							       <label class="checkbox" style="display:none">
	                                 <input  class="thechecks"  type="checkbox" value="${options.id }" ><span class="text-info">使用</span>
	                                </label>
							     <span class="pull-right muted">
							         <small>
									    <i class="icon-comment"></i>评论${options.comments }
									    <i class="icon-pushpin"></i>收藏${options.collect }
								     </small>
							    </span>
						    </span><br />
						</div>
				      </li>
				    </c:forEach>
				</ul>
			</div> 
			
			<div class="span3">
				<ul class="thumbnails" id="partshow4">
					  <c:forEach var="options" items="${partShowResponse.list4 }">
					  <li class="span3 mxkplan mxkshadow">
						<div class="thumbnail">
						   <div style="position:relative;" onmouseover="mouseover('${options.id }')" onmouseout="mouseout('${options.id }')" >
						       <span style="position:absolute; z-index:-1; opacity: 0.8;" id="${options.id }">
						             <a class="btn btn-small" href="javascript:;" onclick="useForSubjectFace('${options.id }','${currentSubjectEntity.id }')">
						               <i class="icon-picture"></i>封面
						            </a>
                                    <a class="btn btn-small" href="<%=rootPath %>/showPartsComments?target=${options.id}">
                                       <i class="icon-comment-alt"></i>评论
                                    </a>
						       </span>
						       	<a href="<%=rootPath %>/partDetail?target=${options.id}" ><img src="<%=imgurl %>${options.minimage}" /></a>
						   </div>
							<span class="muted"><small>${options.desc }</small></span><br />
						    <span class="form-inline">
							       <label class="checkbox" style="display:none">
	                                 <input class="thechecks" type="checkbox" value="${options.id }"><span class="text-info">使用</span>
	                                </label>
							     <span class="pull-right muted">
							         <small>
									    <i class="icon-comment"></i>评论${options.comments }
									    <i class="icon-pushpin"></i>收藏${options.collect }
								     </small>
							    </span>
						    </span><br />
						</div>
				      </li>
				    </c:forEach>
				</ul>
			</div> 
			
         </div>
          <div id="loaddiv" class="mxkdivmid" style="display:none" >
             <img src="<%=domain %>/image/loadingred.gif" >
             <span class="muted"><small>正在努力加载...</small></span>
          </div>
     </div>
 </c:if>    
     <!-- 添加part -->
    <div id="createPartModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	    <div class="modal-header">
	       <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	       <h3>添加Part</h3>
        </div>
        <div class="modal-body">
          <form id="planform" action="createProjectPlan" enctype="multipart/form-data"
				method="post">
			 <span>
				 <small>选择图片</small>
				 <img id="loading" src="<%=domain %>/image/loadingred.gif" style="display:none">
			 </span>
			 <br />
			 <input id="fileToUpload" type="file" size="45" name="image"  /><br />
			 <small>写点描述吧</small><br />
			 <textarea id="partinfo" rows="3" style="width:98%" ></textarea>
			 <label class="checkbox" >
                <input type="checkbox" id="useforfaceimage" checked="checked"><span class="text-info">设为专题封面</span>
             </label>
          </form>
        </div>
	    <div class="modal-footer">
	      <a href="javascript:;" class="btn btn-primary" onclick="ajaxFileUpload('${currentSubjectEntity.id }','${currentSubjectEntity.tags }','${uservo.id }')">发布</a>
	      <a href="javascript:;" class="btn" onclick="closeCreatePart()">关闭</a>
	    </div>
    </div>
    
   <!-- gif -->
     <div id="gifSubjectModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	    <div class="modal-header">
	       <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	       <h3>gif</h3>
        </div>
        <div class="modal-body">
           <img class="img-polaroid border-radius" src="<%=imgurl%>/${subjectExtraEntity.gifUrl}">
        </div>
	    <div class="modal-footer">
	      <a href="javascript:;" class="btn" onclick="closeGifSubject()" >关闭</a>
	    </div>
    </div>
    
    <!-- 材料 -->
    <div id="materialSubjectModal" class="modalbig hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	    <div class="modal-header">
	       <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	       <h3>创建材料单</h3>
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
 
  <script type="text/javascript">
    
    var hasmaterial = '${message}';
  
     function showCreateMaterial(){
    	 if(hasmaterial == 'success'){
    		 window.location.href= path + "/showSubjectMaterial";
    	 }else{
    		 $('#materialSubjectModal').modal({
    		       keyboard: false
    		 }); 
    	 }
		
	 }

	 function closeCreateMaterial(){
		 $('#materialSubjectModal').modal('hide');
	 }
  
  
	 function showCreatePart(){
		 $('#createPartModal').modal({
	       keyboard: false
	   });
	 }
 
	 function closeCreatePart(){
		 $('#createPartModal').modal('hide');
	 }
	 
	 function showGifSubject(){
		 $('#gifSubjectModal').modal({
	       keyboard: false
	   });
     }
	 
	 function closeGifSubject(){
		 $('#gifSubjectModal').modal('hide'); 
	 }
 
 </script>
  <script type="text/javascript"> 
   function validateImage() {
  	  return true;
   }
  
  
	function ajaxFileUpload(subid,tags,username)
	{   
		if(validateImage()){
			var info = $('#partinfo').val();
			var faceimage = 1;
			if($("#useforfaceimage").attr("checked")){
				faceimage = 1;
			}else{
				faceimage = 0; 
			}
			var datas = {"createPartRequest.subjectid":subid,"createPartRequest.desc":info,"createPartRequest.type":tags,"createPartRequest.subname":username,"createPartRequest.forfaceimage":faceimage};
			$("#loading").show();
			$.ajaxFileUpload
			(
				{
					url:path + "/createPart.action",
					secureuri:false,
					fileElementId:'fileToUpload',
					dataType: 'json',
					data:datas,
					success: function (data, status)
					{  
						if(data.message="success"){
							$("#loading").hide();
							closeCreatePart();
			    		    window.location.href= path + "/showSubjectDetailView";
						}
						
					},
					error: function (data, status, e)
					{
						$("#loading").hide();
						alert(data.message);
					}
				}
			);
		}
		return false;
	}
	</script>
	<!-- 材料  -->	   
     <form id="tfrom" action="createSubjectMaterial" method="post" style="display:none">
		<table id="upfrom">

		</table>
	</form>
<%@ include file="../../../footinclude.jsp"%>
</body>
</html>
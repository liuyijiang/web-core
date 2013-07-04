<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
 <%@ include file="../../../headerinclude.jsp"%>
</head>
<script type="text/javascript">

  function mouseover(){
    $("#subjectfun").css("z-index","1");
  }
  
  function mouseout(){
	$("#subjectfun").css("z-index","-1");
  }

  function showEditPartModal(){
		 $('#editPartModal').modal({
	       keyboard: false
	   });
	 }

  function closeEditPartModal(){
	 $('#editPartModal').modal('hide');
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
    		    	 window.location.href= path + "partDetail?target=" + partid;
    		     }else{
    		    	 alert("网络异常请重试");
    		     }
    		  }
		  });
   }
  
  function updatePart(partid){
	     var info = $('#partinfo').val();
	     var datas = {"updatePartInfoRequest.partid":partid,"updatePartInfoRequest.info":info};
	     $.ajax({
    		url : path + "/updatePart.action",
    		type : "POST",
    		cache : false,
    		async : false,
    		data: datas,
    		dataType : "json",
    		success : function(item) {
    		    $('#partmessage').html(info);
    		    closeEditPartModal();
    		  }
		  });
   }
  
  function deletePart(partid){
	  if(!confirm("确定要删除吗？")){
  		return;  //deleteProject
       }else{
	    var datas = {"target":partid};
	     $.ajax({
 		url : path + "/deletePart.action",
 		type : "POST",
 		cache : false,
 		async : false,
 		data: datas,
 		dataType : "json",
 		success : function(item) {
 			if(item == 'success'){
 			   window.location.href= path + "/showSubjectDetailView";
 		   }else{
 			   alert("操作失败");
 		   }
 	  }
	});
   }
}
</script>
<body class="mxkbody mxkbackgroud" >
	<%@ include file="../public/user_page_header.jsp"%>
<div class="container ">
<div class="row">
     <div class="span9 mxkplan mxkshadow">
       	<div class="navbar">
			<div class="navbar-inner form-inline ">
				<div class="btn-group" >
				  <button class="btn" style="font-family:Microsoft YaHei;"><i class="icon-pushpin"></i>收藏${partEntity.collect }</button>
				  <button class="btn" style="font-family:Microsoft YaHei;"><i class="icon-comment-alt"></i>评论${partEntity.comments }</button>
				  <button class="btn" style="font-family:Microsoft YaHei;"><i class="icon-volume-off"></i>音评${partEntity.audios }</button>
		        </div>
			     <span class="pull-right">
	                  <div class="btn-group">
                      <a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
                        <i class="icon-globe"></i>分享
                      <span class="caret"></span>
				    </a>
				     <ul class="dropdown-menu">
					       <li><a href="#">分享到新浪微博</a></li>
						   <li><a href="#">分享到QQ微信</a></li>
						   <li><a href="#">分享到QQ空间</a></li>
		               </ul>
				    </div>
			         <div class="btn-group">
		               <button class="btn" style="font-family:Microsoft YaHei;"><i class="icon-cog"></i>操作</button>
					    <button class="btn dropdown-toggle" data-toggle="dropdown">
					    <span class="caret"></span>
			            </button>
					    <ul class="dropdown-menu" >
					       <li><a href="javascript:;" onclick="showEditPartModal()"><i class="icon-edit"></i>编辑 </a></li>
					       <li><a href="javascript:;" onclick="useForSubjectFace('${partEntity.id }','${currentSubjectEntity.id }')"><i class="icon-picture"></i>封面</a></li>
						   <li><a href="javascript:;" onclick="deletePart('${partEntity.id}')"><i class="icon-trash"></i>删除 </a></li>
		               </ul>
                    </div>
			     </span>
			</div>
		</div>
		<center>
		   <img class="img-polaroid" src="<%=imgurl %>${partEntity.image }" /><br/>
		   <span id="partmessage" >${partEntity.desc }</span>
		</center>
		<hr />
		<c:forEach var="options" items="${partNewCommentsResponse.list }">
		  
		   <div class='row' style='padding:5px;margin-bottom:5px;'>
	          <div class='span1'>
	           <img class='img-polaroid border-radius' src='<%=imgurl%>${options.userimage}'/>
	          </div>
	           <div class='span7'>
	             <span><a href='<%=imgurl %>/vistiorShowUserIndex?target=${options.userid}'>${options.username }</a>&nbsp;${options.reply }</span><br />
	             <c:if test="${options.type == 'text' }">
	               <span class='muted'>${options.info}</span><br />
	             </c:if>
	             <c:if test="${options.type == 'wav' }">
	               <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="150" height="20">
					    <param name="movie" value="singlemp3player.swf?showDownload=false" />
					    <param name="wmode" value="transparent" />
					    <embed wmode="transparent" width="150" height="20" src="singlemp3player.swf?file=<%=voice %>${options.info }&showDownload=false"
		                type="application/x-shockwave-flash" />
                   </object>
	             </c:if>
	             <span><i class='icon-time'></i>${options.createTime }</span>
	           </div>
            </div>
            <div style='padding:1px;margin-bottom:1px;'><div style='width:100%; border-top:1px solid #cccccc'></div></div>
		</c:forEach>
		<span class="pull-right"><a href="<%=rootPath %>/showPartsComments?target=${partEntity.id}">更多评论</a></span>
     </div>
     <div class="span3">
     	<ul class="thumbnails">
			  <li class="span3 mxkplan mxkshadow">
				<div class="thumbnail">
				 <div style="position:relative;" onmouseover="mouseover()" onmouseout="mouseout()" >
						       <span style="position:absolute; z-index:-1; opacity: 0.8;" id="subjectfun">
<!-- 						             <i class="icon-rss"></i>12&nbsp; -->
<!--                                     <i class="icon-comment-alt"></i>8&nbsp; -->
<!--                                     <i class="icon-pushpin"></i>3&nbsp; -->
						       </span>
				            <a href="<%=rootPath %>/showSubjectDetailView"><img src="<%=imgurl %>${currentSubjectEntity.faceimage }" /></a>
					</div>
					<span style="font-size: 18px;"><strong>${currentSubjectEntity.name }</strong></span>
                    &nbsp;/&nbsp;<span class="muted">(<i class="icon-tags"></i>${currentSubjectEntity.tags })</span><br />
                     <br />
                    <span class="pull-right">
                       <a href="javascript:;" class="btn btn-info btn-mini" onclick="showCreatePart()"><i class="icon-pushpin"></i>添加Part</a>
                    </span>
                    <br />
				</div>
		      </li>
		</ul>
     </div>
  </div>
</div>
<br />
<!-- 编辑 -->
     <div id="editPartModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	    <div class="modal-header">
	       <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	       <h3>重新编辑Part</h3>
        </div>
        <div class="modal-body">
          <textarea id="partinfo" rows="3" style="width:96%" ></textarea>
        </div>
	    <div class="modal-footer">
	      <a href="javascript:;" class="btn btn-primary" onclick="updatePart('${partEntity.id }')">更新</a>
	      <a href="javascript:;" class="btn" onclick="closeEditPartModal()">关闭</a>
	    </div>
    </div>
    
<!-- part -->
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
      <script type="text/javascript">

	 function showCreatePart(){
		 $('#createPartModal').modal({
	       keyboard: false
	   });
	 }
 
	 function closeCreatePart(){
		 $('#createPartModal').modal('hide');
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
    
    
<%@ include file="../../../footinclude.jsp"%>
</body>
</html>
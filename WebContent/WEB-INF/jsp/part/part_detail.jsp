<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
 <%@ include file="../../../headerinclude.jsp"%>
</head>

<body class="mxkbody mxkbackgroud" >
	<%@ include file="../public/user_page_header.jsp"%>
<div class="container ">
<div class="row">
     <div class="span9 mxkplan mxkshadow">
       	<div class="navbar">
			<div class="navbar-inner form-inline ">
			     <span >
	                  <div class="btn-group">
                      <a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
                        <i class="icon-globe"></i>分享
                      <span class="caret"></span>
				    </a>
				     <ul class="dropdown-menu">
					       <li>
						      <a href="http://service.weibo.com/share/share.php?url=<%=rootPath%>/visitorShowPartDetailFromShare?target=${partEntity.id }&pic=<%=imgurl %>${partEntity.image }&title=${currentSubjectEntity.name }&nbsp;&nbsp;${partEntity.desc }" target="_blank">
						                   分享到新浪微博
						       </a>
					       </li>
						   <li>
							   <a href="http://share.v.t.qq.com/index.php?c=share&a=index&url=<%=rootPath%>/visitorShowPartDetailFromShare?target=${partEntity.id }&pic=<%=imgurl %>${partEntity.image }&title=${currentSubjectEntity.name }&nbsp;&nbsp;${partEntity.desc }" target="_blank">
							         分享到QQ微信
							   </a>
						   </li>
						   <li>
							   <a href="http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url=<%=rootPath%>/index&pic=<%=imgurl %>${partEntity.image }&title=${currentSubjectEntity.name }&nbsp;&summary=${partEntity.desc }|&nbsp;<%=rootPath%>/visitorShowPartDetailFromShare?target=${partEntity.id }" target="_blank">
							         分享到QQ空间
							   </a>
						  </li>
		               </ul>
				    </div>
				    <a class="btn" href="<%=rootPath%>/visitorShowPartsCollecter?target=${partEntity.id}">
		               <i class="icon-pushpin"></i>收藏次数${partEntity.collect }
		            </a>
			     </span>
			     <span class="pull-right">
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
	                    <a class="btn btn-primary" href="<%=rootPath %>/showPartsComments?target=${partEntity.id}"><i class="icon-comments-alt"></i>评论Parts</a>
			     </span>
			</div>
		</div>
		<div style="position:relative;" onmouseover="mouseoverp()" onmouseout="mouseoutp()" >
	        <center>
	          <div style="width:660px">
		        <span style="position:absolute; z-index:-1; opacity:0.8;" id="partfun">
		           <span class="label label-success"><i class="icon-microphone"></i>语音${partEntity.audios}</span>
		           <span class="label"><i class="icon-comment-alt"></i>文字${partEntity.comments  }</span>
		        </span>
		        <img class="img-polaroid" src="<%=imgurl %>${partEntity.image }" /><br/>
		          </div>
		    </center>
		</div>
		<span style="padding: 19px;" id="partmessage" >${partEntity.desc }</span><br />
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
					    <param name="movie" value="singlemp3player.swf?file=<%=voice %>${options.info }&showDownload=false" />
					    <param name="wmode" value="transparent" />
					    <embed wmode="transparent" width="150" height="20" src="singlemp3player.swf?file=<%=voice %>${options.info }&showDownload=false"
		                type="application/x-shockwave-flash" />
                   </object>
	             </c:if>
	             <span><i class='icon-time'></i>${options.createTime }</span>
	              <c:if test="${options.userid == uservo.id || options.commentedUserId == uservo.id}">
	                <span class="pull-right"><a href="javascript:;" onclick="deleCom('${options.id}','${options.commentedId }')">删除</a></span>
	             </c:if>
	           </div>
            </div>
            <div style='padding:1px;margin-bottom:1px;'><div style='width:100%; border-top:1px solid #cccccc'></div></div>
		</c:forEach>
		<c:if test="${! empty partNewCommentsResponse.list}">
		   <span class="pull-right"><a class="btn" href="<%=rootPath %>/showPartsComments?target=${partEntity.id}">更多评论</a>&nbsp;&nbsp;</span>
		</c:if>
		<br/><br/>
     </div>
     <c:if test="${partEntity.subjectid =='#'}">
        <div class="span3">
     	   <ul class="thumbnails">
			 <li class="span3 mxkplan mxkshadow">
			   <div class="thumbnail">
			        <div style="position:relative;" onmouseover="mouseoveru()" onmouseout="mouseoutu()" >
				         <span style="position:absolute; z-index:-1; opacity:0.8;" id="userfun">
				           <a href="javascript:;" class="pull-right btn-inverse btn btn-mini" onclick="createUserRelation('${uservo.id}')" >加关注</a>
				        </span>
				        <a href="<%=rootPath%>/userSharePartsIndex">
				          <img src="<%=imgurl %>${uservo.image }" />
				        </a>  
				    </div>
				    <div style="text-overflow:ellipsis; white-space:nowrap; overflow:hidden;">
					<span><strong><a href="<%=rootPath%>/userSharePartsIndex">${uservo.name }</a></strong></span>
	                    <c:if test="${uservo.sex == 1 }" >
				           <img src="<%=assets%>mxkimage/male1.png">
				        </c:if>
				         <c:if test="${uservo.sex == 0 }" >
				           <img src="<%=assets%>mxkimage/male2.png">
				        </c:if>
	                    </div>
	                    <div style="text-overflow:ellipsis; white-space:nowrap; overflow:hidden;">
	                     <small>${uservo.info }</small>
	                     </div>
				         <span class="label">${uservo.interest }</span>
				        <span >
				         <a class="pull-right btn btn-success btn-mini" href="<%=rootPath%>/userIndex"><i class="icon-hdd"></i>专题数量${uservo.subject }</a>
					    </span>
					  <br /> 
			   </div>
             </li>
           </ul>
         </div>
     </c:if>
     <c:if test="${partEntity.subjectid !='#'}">
     <div class="span3">
     	<ul class="thumbnails">
			  <li class="span3 mxkplan mxkshadow">
				<div class="thumbnail">
				 <div style="position:relative;" onmouseover="mouseover()" onmouseout="mouseout()" >
						       <span style="position:absolute; z-index:-1; opacity: 0.8;" id="subjectfun">
						       </span>
				            <a href="<%=rootPath %>/showSubjectDetailView"><img src="<%=imgurl %>${currentSubjectEntity.faceimage }" /></a>
					</div>
					<div style="text-overflow:ellipsis; white-space:nowrap; overflow:hidden;">
					  <span><strong><a href="<%=rootPath %>/showSubjectDetailView">${currentSubjectEntity.name }</a></strong></span>
                       &nbsp;/&nbsp;<small class="muted">(<i class="icon-tags"></i>${currentSubjectEntity.tags })</small><br />
                    </div>
                    <div style="text-overflow:ellipsis; white-space:nowrap; overflow:hidden;">
                     <small>${currentSubjectEntity.info }</small>
                    </div>
                     <br />
                     <span>
                      	<span class="label">${currentSubjectEntity.category }</span>
                      	 <c:choose>
		                <c:when test="${currentSubjectEntity.type == 'PUBLIC'}">
                           <span class="label label-success">
                              <i class="icon-hdd"></i>公开
						   </span>
		                </c:when>
		                <c:when test="${currentSubjectEntity.type == 'FOR-ALL'}">
		                  <span class="label label-warning">
                             <i class="icon-globe"></i>共享
						   </span>
		                </c:when>
		                <c:when test="${currentSubjectEntity.type == 'PRIVATE'}">
		                  <span class="label label-important">
                             <i class="icon-globe"></i>私有
						   </span>
		                </c:when>
		             </c:choose>
                    </span>
                    <span class="pull-right">
                       <a href="javascript:;" class="btn btn-info btn-mini" onclick="showCreatePart()"><i class="icon-pushpin"></i>添加Part</a>
                    </span>
                    <br />
				</div>
		      </li>
		</ul>
     </div>
     </c:if>
  </div>
</div>
<br />
<div id="addtextcommentdiv" class="container">
  <div class="row">
    <div class="span9 mxkplan mxkshadow " >
         <div class="row" style="padding:5px;margin-bottom:5px;">
          <div class="span1">
            <img class="img-polaroid border-radius" src="<%=imgurl %>${uservo.image }"/> 
            <span class="muted"><small>${uservo.name}</small></span>
          </div>
          <div class="span7">
            <span>
              <span class="muted">你的评论</span>
              <span class="pull-right muted"><a href="<%=rootPath %>/visitorShowPartsCommnets?target=${partEntity.id}" ><i class="icon-microphone"></i>语音评论</a></span>
             </span><br />
            <textarea id="commentstextarea" rows="3" style="width:100%"></textarea>
            <button class="pull-right btn btn-primary btn-small" onclick="addTextComents('${partEntity.id}','${partEntity.userid }','part')">评论</button>
          </div>
         </div>
    </div>
   </div>
   <br /> <br />
</div>
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
				 <img id="loading" src="<%=domain %>loadingred.gif" style="display:none">
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
	<script type="text/javascript">
  function deleCom(comid,partid){
	  if(!confirm("确定要删除这个评论吗？")){
	  		return;  //deleteComments
	  }else{
		  $.ajax({
		   		url : path + "/deleteComments.action",
		   		type : "POST",
		   		cache : false,
		   		async : false,
		   		data: {"traget":comid},
		   		dataType : "json",
		   		success : function(item) {
		   		    if(item == 'success'){
		 			   alert("删除成功！");
		 			   window.location.href= path + "/partDetail?target="+ partid;
				    }else if( item == 'error'){
				   	   alert("网络异常请重试");
				    }else {
				     	alert(item);
				    }
		   	}
		 }); 
	}
  }

</script>
	
     <script type="text/javascript">
  replyuserid = '';
  
  function addTextComents(commentedId,commentedUserId,traget){
	  var info = $("#commentstextarea").val();
	  var datas = {"commentsAddRequest.replyUserId":replyuserid,"commentsAddRequest.commentedUserId":commentedUserId,"commentsAddRequest.commentedId":commentedId,"commentsAddRequest.info":info,"commentsAddRequest.target":traget,"commentsAddRequest.type":"text"};
	  $.ajax({
	   		url : path + "/addTextComments.action",
	   		type : "POST",
	   		cache : false,
	   		async : false,
	   		data: datas,
	   		dataType : "json",
	   		success : function(item) {
	   		    if(item == 'success'){
	 			   alert("评论成功！");
	 			   replyuserid = '';
	 			   window.location.href= path + "/partDetail?target="+ commentedId;
			    }else if( item == 'error'){
			   	   alert("网络异常请重试");
			    }else {
			     	alert(item);
			    }
	   		  }
	 }); 
}
 </script>
    
<%@ include file="../../../footinclude.jsp"%>
<script type="text/javascript">

  function mouseover(){
    $("#subjectfun").css("z-index","1");
  }
  
  function mouseout(){
	$("#subjectfun").css("z-index","-1");
  }

  function mouseoverp(){
	    $("#partfun").css("z-index","1");
  }
	  
  function mouseoutp(){
	$("#partfun").css("z-index","-1");
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
</body>
</html>
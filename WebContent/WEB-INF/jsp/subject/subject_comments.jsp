<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="../../../headerinclude.jsp"%>
</head>
<body class="mxkbody mxkbackgroud" onload="bindScroll()">
<%@ include file="../public/user_page_header.jsp"%>
<script type="text/javascript">
  function mouseover(id){
    $("#"+id).css("z-index","1");
  }
  
  function mouseout(id){
	$("#"+id).css("z-index","-1");
  }

  var replyuserid = '';
</script>
<script type="text/javascript">
   

   function filterComments(){
	   
   }
   
   
   function createCommnetsPlane(list,comdiv){
	   var show = '';
	   for (var i in list){
		   
		   "<li class='span3 mxkplan mxkshadow'><div style='padding:5px;margin-bottom:1px;'><table style='width:100%'><tr>" +
		   "<td width='26%' rowspan='2'><div style='position:relative;' onmouseover='mouseover(\""+ list[i].id +"\")' onmouseout='mouseout(\""+ list[i].id +"\")' >" +
		   "<span style='position:absolute; z-index:-1; opacity: 0.8;' id='"+ list[i].id +"'><a class='btn btn-mini btn-danger' href='javascript:;' onclick='createUserRelation('${options.userid}')'>" +
	       "<i class='icon-remove-circle'></i>删除</a></span><a href='"+ path + "/vistiorShowUserIndex?target="+ list[i].userid +"'>" +
	       "<img style='width:40px;height:40px'  class='img-polaroid border-radius' src='"+ imgurl + list[i].userimage +"' />" +
           "</a></div></td><td width='35%'><div style='width:80px;text-overflow:ellipsis; white-space:nowrap; overflow:hidden;'>" +
           "<strong><a href='"+ path + "/vistiorShowUserIndex?target="+ list[i].userid +"'>"+ list[i].username +"</a></strong>" +
           "</div></td><td><span class='pull-right'><a href='javascript:;' onclick='relaycomments(\""+ list[i].userid +"\")'>回复</a></span></td></tr><tr><td colspan='2'><div style='width:150px;text-overflow:ellipsis; white-space:nowrap; overflow:hidden;'><span class='muted'>" +
           "<small>"+ list[i].reply +"</small></span></div></td></tr></table>";
           if (list[i].type == 'wav') {
        	 show = show + "<div style='padding:5px;margin-bottom:1px;'><object classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000' width='150' height='20'>" +
        	 "<param name='movie' value='singlemp3player.swf?showDownload=false' />" +
        	 "<param name='wmode' value='transparent' />" +
        	 "<embed width='80' height='20' src='singlemp3player.swf?file="+ voice +list[i].info + "&showDownload=false' type='application/x-shockwave-flash' />" +
             "</object></div>";
           }else{
        	  show = show + "<span class='muted'><small>"+ list[i].info +"</small></span><br />";
           }
           show = show + "<span class='pull-right muted'><small><i class='icon-time'></i>"+ list[i].createTime +"</small></span><br /></div></li>";
       }
       $("#"+comdiv).append(show);
   }
   
   
</script>
<script type="text/javascript">
var allpage = '${loadCommentsRespone.allpage}';
var isrun = false;
var page = 2;
var subjectid = '${currentSubjectEntity.id}';

  function showload(){ 
	 
	   var scrollh = document.documentElement.scrollHeight;
	   var scrollt = document.documentElement.scrollTop + document.body.scrollTop;
	   if ( scrollt/scrollh > 0.01 ) {
		 
		     if (!isrun) {
		    	 isrun = true; 
		    	 loadComments();  
		     }
	   }
	} 

	//绑定事件
	function bindScroll(){
	    $(window).bind("scroll", function(){
	         showload();
	    }); 
	}

	
	function loadComments(){
		 if(page <= allpage){
			  var datas = {"loadCommentsRequest.targeid":subjectid,"loadCommentsRequest.page":page};
			  $('#loaddiv').show();
			  $.ajax({
			   		url : path + "/loadMoreSubjectComments.action",
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
							createCommnetsPlane(list1,"comments1");
						}
						if(list2 != null){
							createCommnetsPlane(list2,"comments2");
						}
						if(list3 != null){
							createCommnetsPlane(list3,"comments3");
						}
						if(list4 != null){
							createCommnetsPlane(list4,"comments4");
						}
						isrun = false;
			   		  }
			 	 }); 
		     } 
	}
	
</script>
<div class="container">
  <div class="row">
     <div class="span1">
        <img class="img-polaroid border-radius"  style="height:60px;width:60px"
         src="<%=imgurl %>${currentSubjectEntity.faceimage }" >
     </div>
     <div class="span11">
        <span>
          <span style="font-size: 20px;"><strong><a href="<%=rootPath%>/vistiorShowUserIndex?target=${uservo.id}">${uservo.name }</a>&nbsp;/&nbsp;${currentSubjectEntity.name }</strong></span>
             &nbsp;<span class="muted"><small>(<i class="icon-tags"></i>${currentSubjectEntity.tags }-${currentSubjectEntity.category})</small>
                <c:choose>
	             <c:when test="${currentSubjectEntity.type == 'PUBLIC'}">
                  <span class="label label-success">
                       <i class="icon-hdd"></i>公开
		          </span>
                </c:when>
                <c:when test="${currentSubjectEntity.type == 'PRIVATE'}">
                  <span class="label label-important">
                       <i class="icon-lock"></i>私有
				   </span>
                </c:when>
                </c:choose>
           </span>
        </span> 
        <span class="pull-right">
           <a class="btn" href="<%=rootPath %>/vistiorShowSubjectDatail?target=${currentSubjectEntity.id }"><i class="icon-hdd"></i>返回专题</a>
           <a href="javascript:;" class="btn btn-info" onclick="popdivfrombtn()">
              <i class="icon-comment-alt"></i>评论专题
           </a>
        </span>
        <br />
        <span class="muted"><small>${currentSubjectEntity.info }</small></span>
        <br />
        <span>
          <c:forEach var="options" items="${subjectTop5NewPartsRespone.list }">
              <a href="<%=rootPath%>/visitorShowPartDetail?target=${options.id}">
                 <img style="height:24px;width:24px" src="<%=imgurl %>${options.minimage }"/>
              </a>
           </c:forEach>
           <c:if test="${!empty subjectTop5NewPartsRespone }">
              <a href="<%=rootPath %>/vistiorShowSubjectDatail?target=${subjectEntity.id }">...</a>
           </c:if>
        </span>
        <span class="pull-right">
          <i class="icon-time"></i>Create Time:${currentSubjectEntity.createTime }
        </span>
     </div>
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
             <span class="pull-right">
	            <a class="btn" href="<%=rootPath %>/showSubjectDetailView">
	              <i class="icon-refresh"></i>刷新
	            </a>
	            <div class="btn-group">
			        <button class="btn">评论过滤</button>
				    <button class="btn dropdown-toggle" data-toggle="dropdown">
				    <span class="caret"></span>
		            </button>
				    <ul class="dropdown-menu">
				       <li><a href="javascript:;" onclick=""><i class="icon-comment-alt"></i>文本评论</a></li>
					   <li><a href="javascript:;" onclick=""><i class="icon-microphone"></i>语音评论</a></li>
	               </ul>
               </div>
             </span>
		</div>
	</div>
</div>

<div class="container">
    <div class="row">
       
       <div class="span3">
            <ul class="thumbnails" id="comments1">
			   <c:forEach var="options" items="${loadCommentsRespone.list1 }">
				    <li class="span3 mxkplan mxkshadow">
				       <div style='padding:5px;margin-bottom:1px;'>
				         <table style='width:100%'>
				             <tr>
							   <td width='26%' rowspan='2'>
							      <div style="position:relative;" onmouseover="mouseover('${options.id}')" onmouseout="mouseout('${options.id}')" >
							         <span style="position:absolute; z-index:-1; opacity: 0.8;" id="${options.id}">
							            <a class="btn btn-mini btn-danger" href="javascript:;" onclick="createUserRelation('${options.userid}')">
							               <i class='icon-remove-circle'></i>删除
							            </a>
							         </span>
							         <a href="<%=rootPath %>/vistiorShowUserIndex?target=${options.userid}">
							          <img style="width:40px;height:40px"  class='img-polaroid border-radius' src="<%=imgurl %>${options.userimage }" />
							         </a>
							      </div>
							   </td>
				               <td width='35%'>
								   <div style='width:80px;text-overflow:ellipsis; white-space:nowrap; overflow:hidden;'>
								    <strong><a href="<%=rootPath %>/vistiorShowUserIndex?target=${options.userid}">${options.username }</a></strong>
								   </div>
							   </td>
				               <td>
					               <span class='pull-right'>
								      <a href='javascript:;' onclick="relaycomments('${options.userid }')" >
								               回复</a>
								   </span>
							   </td>
						    </tr>
							<tr>
							  <td colspan='2'>
							      <div style='width:150px;text-overflow:ellipsis; white-space:nowrap; overflow:hidden;'>
					                  <span class='muted'>
					                     <small>${options.reply }</small>
					                  </span>
				                  </div>
				              </td>
				           </tr>
				         </table>
				         <c:if test="${options.type == 'wav' }">
				          <div style='padding:5px;margin-bottom:1px;'>
					         <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="150" height="20">
							    <param name="movie" value="singlemp3player.swf?showDownload=false" />
							    <param name="wmode" value="transparent" />
							    <embed width="80" height="20" src="singlemp3player.swf?file=<%=voice %>${options.info }&showDownload=false"
							    type="application/x-shockwave-flash" />
							</object>
				         </div>
				         </c:if>
				         <c:if test="${options.type == 'text' }">
				           <span class="muted"><small>${options.info }</small></span><br /> 
				         </c:if>
				        <span class=" pull-right muted"><small><i class='icon-time'></i>2012-12-12 23:12:34</small></span><br /> 
				        </div>
				   </li>
			    </c:forEach>
			</ul>
        </div>
       
        <div class="span3">
            <ul class="thumbnails" id="comments2">
			   <c:forEach var="options" items="${loadCommentsRespone.list2 }">
				    <li class="span3 mxkplan mxkshadow">
				       <div style='padding:5px;margin-bottom:1px;'>
				         <table style='width:100%'>
				             <tr>
							   <td width='26%' rowspan='2'>
							      <div style="position:relative;" onmouseover="mouseover('${options.id}')" onmouseout="mouseout('${options.id}')" >
							         <span style="position:absolute; z-index:-1; opacity: 0.8;" id="${options.id}">
							            <a class="btn btn-mini btn-danger" href="javascript:;" onclick="createUserRelation('${options.userid}')">
							               <i class='icon-remove-circle'></i>删除
							            </a>
							         </span>
							         <a href="<%=rootPath %>/vistiorShowUserIndex?target=${options.userid}">
							          <img style="width:40px;height:40px"  class='img-polaroid border-radius' src="<%=imgurl %>${options.userimage }" />
							         </a>
							      </div>
							   </td>
				               <td width='35%'>
								   <div style='width:80px;text-overflow:ellipsis; white-space:nowrap; overflow:hidden;'>
								    <strong><a href="<%=rootPath %>/vistiorShowUserIndex?target=${options.userid}">${options.username }</a></strong>
								   </div>
							   </td>
				               <td>
					               <span class='pull-right'>
								      <a href='javascript:;' onclick="relaycomments('${options.userid }')" >
								               回复</a>
								   </span>
							   </td>
						    </tr>
							<tr>
							  <td colspan='2'>
				                  <div style='width:150px;text-overflow:ellipsis; white-space:nowrap; overflow:hidden;'>
					                  <span class='muted'>
					                     <small>${options.reply }</small>
					                  </span>
				                  </div>
				              </td>
				           </tr>
				         </table>
				         <c:if test="${options.type == 'wav' }">
				          <div style='padding:5px;margin-bottom:1px;'>
					         <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="150" height="20">
							    <param name="movie" value="singlemp3player.swf?showDownload=false" />
							    <param name="wmode" value="transparent" />
							    <embed width="80" height="20" src="singlemp3player.swf?file=<%=voice %>${options.info }&showDownload=false"
							    type="application/x-shockwave-flash" />
							</object>
				         </div>
				         </c:if>
				         <c:if test="${options.type == 'text' }">
				           <span class="muted"><small>${options.info }</small></span><br /> 
				         </c:if>
				        <span class=" pull-right muted"><small><i class='icon-time'></i>2012-12-12 23:12:34</small></span><br /> 
				        </div>
				   </li>
			    </c:forEach>
			</ul>
        </div>
       
        <div class="span3">
            <ul class="thumbnails" id="comments3">
			   <c:forEach var="options" items="${loadCommentsRespone.list3 }">
				    <li class="span3 mxkplan mxkshadow">
				       <div style='padding:5px;margin-bottom:1px;'>
				         <table style='width:100%'>
				             <tr>
							   <td width='26%' rowspan='2'>
							      <div style="position:relative;" onmouseover="mouseover('${options.id}')" onmouseout="mouseout('${options.id}')" >
							         <span style="position:absolute; z-index:-1; opacity: 0.8;" id="${options.id}">
							            <a class="btn btn-mini btn-danger" href="javascript:;" onclick="createUserRelation('${options.userid}')">
							               <i class='icon-remove-circle'></i>删除
							            </a>
							         </span>
							         <a href="<%=rootPath %>/vistiorShowUserIndex?target=${options.userid}">
							          <img style="width:40px;height:40px"  class='img-polaroid border-radius' src="<%=imgurl %>${options.userimage }" />
							         </a>
							      </div>
							   </td>
				               <td width='35%'>
								   <div style='width:80px;text-overflow:ellipsis; white-space:nowrap; overflow:hidden;'>
								    <strong><a href="<%=rootPath %>/vistiorShowUserIndex?target=${options.userid}">${options.username }</a></strong>
								   </div>
							   </td>
				               <td>
					               <span class='pull-right'>
								      <a href='javascript:;' onclick="relaycomments('${options.userid }')" >
								               回复</a>
								   </span>
							   </td>
						    </tr>
							<tr>
							  <td colspan='2'>
				                  <div style='width:150px;text-overflow:ellipsis; white-space:nowrap; overflow:hidden;'>
					                  <span class='muted'>
					                     <small>${options.reply }</small>
					                  </span>
				                  </div>
				              </td>
				           </tr>
				         </table>
				         <c:if test="${options.type == 'wav' }">
				          <div style='padding:5px;margin-bottom:1px;'>
					         <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="150" height="20">
							    <param name="movie" value="singlemp3player.swf?showDownload=false" />
							    <param name="wmode" value="transparent" />
							    <embed width="80" height="20" src="singlemp3player.swf?file=<%=voice %>${options.info }&showDownload=false"
							    type="application/x-shockwave-flash" />
							</object>
				         </div>
				         </c:if>
				         <c:if test="${options.type == 'text' }">
				           <span class="muted"><small>${options.info }</small></span><br /> 
				         </c:if>
				        <span class=" pull-right muted"><small><i class='icon-time'></i>2012-12-12 23:12:34</small></span><br /> 
				        </div>
				   </li>
			    </c:forEach>
			</ul>
        </div>
       
        <div class="span3">
            <ul class="thumbnails" id="comments4">
			   <c:forEach var="options" items="${loadCommentsRespone.list4 }">
				    <li class="span3 mxkplan mxkshadow">
				       <div style='padding:5px;margin-bottom:1px;'>
				         <table style='width:100%'>
				             <tr>
							   <td width='26%' rowspan='2'>
							      <div style="position:relative;" onmouseover="mouseover('${options.id}')" onmouseout="mouseout('${options.id}')" >
							         <span style="position:absolute; z-index:-1; opacity: 0.8;" id="${options.id}">
							            <a class="btn btn-mini btn-danger" href="javascript:;" onclick="createUserRelation('${options.userid}')">
							               <i class='icon-remove-circle'></i>删除
							            </a>
							         </span>
							         <a href="<%=rootPath %>/vistiorShowUserIndex?target=${options.userid}">
							          <img style="width:40px;height:40px"  class='img-polaroid border-radius' src="<%=imgurl %>${options.userimage }" />
							         </a>
							      </div>
							   </td>
				               <td width='35%'>
								   <div style='width:80px;text-overflow:ellipsis; white-space:nowrap; overflow:hidden;'>
								    <strong><a href="<%=rootPath %>/vistiorShowUserIndex?target=${options.userid}">${options.username }</a></strong>
								   </div>
							   </td>
				               <td>
					               <span class='pull-right'>
								     <a href='javascript:;' onclick="relaycomments('${options.userid }')" >
								               回复</a>
								   </span>
							   </td>
						    </tr>
							<tr>
							  <td colspan='2'>
				                  <div style='width:150px;text-overflow:ellipsis; white-space:nowrap; overflow:hidden;'>
					                  <span class='muted'>
					                     <small>${options.reply }</small>
					                  </span>
				                  </div>
				              </td>
				           </tr>
				         </table>
				         <c:if test="${options.type == 'wav' }">
				          <div style='padding:5px;margin-bottom:1px;'>
					         <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="150" height="20">
							    <param name="movie" value="singlemp3player.swf?showDownload=false" />
							    <param name="wmode" value="transparent" />
							    <embed width="80" height="20" src="singlemp3player.swf?file=<%=voice %>${options.info }&showDownload=false"
							    type="application/x-shockwave-flash" />
							</object>
				         </div>
				         </c:if>
				         <c:if test="${options.type == 'text' }">
				           <span class="muted"><small>${options.info }</small></span><br /> 
				         </c:if>
				        <span class=" pull-right muted"><small><i class='icon-time'></i>2012-12-12 23:12:34</small></span><br /> 
				        </div>
				   </li>
			    </c:forEach>
			</ul>
        </div>
       
       <div id="loaddiv" class="mxkdivmid" style="display:none" >
             <img src="<%=domain %>/image/loadingred.gif" >
             <span class="muted"><small>正在努力加载...</small></span>
          </div>
       
    </div>
</div>

<!-- comments -->
   <div id="createTextCommentsModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	    <div class="modal-header">
	       <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	       <h3>文字评论</h3>
        </div>
        <div class="modal-body">
          <div >
            <span>
              <span class="muted">你的评论</span>
              <span class="pull-right muted">
                 <a class="btn btn-success btn-mini" href="javascript:;" onclick="closeTextCommentsPop();createVoiceCommentsPop();">
                    <i class="icon-microphone"></i>语音评论
                 </a>
              </span>
             </span><br />
            <textarea id="commentstextarea" rows="3" style="width:98%"></textarea>
          </div>
        </div>
	    <div class="modal-footer">
	      <a href="javascript:;" class="btn btn-primary" onclick="addTextComents('${currentSubjectEntity.id}','${currentSubjectEntity.userid }','subject')">发布</a>
	      <a href="javascript:;" class="btn" onclick="closeTextCommentsPop()">关闭</a>
	    </div>
    </div>
    
    
    <div id="createVoiceCommentsModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	    <div class="modal-header">
	       <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	       <h3>语音评论</h3>
        </div>
        <div class="modal-body">
          <div>
            <span>
               <span id="status" class="muted">你的音评</span>
              &nbsp;
              <small><span id="time" class="muted"></span></small>
              <span class="pull-right">
                 <a class="btn btn-success btn-mini" href="javascript:;" onclick="closeVoiceCommentsPop();createTextCommentsPop();" >
                      <i class="icon-comment-alt"></i>文字评论
                 </a>
              </span>
             </span><br />
			 <div style="background-color:#eeeeee; width:200px; border:1px solid #cccccc">
				<div id="levelbase" style="width:200px;height:15px;background-color:#ffff00">
				  <div id="levelbar" style="height:14px; width:2px;background-color:red"></div>
				</div>
			</div>
			<div style="height:5px;"></div>
			 <div>
				<a class="btn" href="javascript:;" id="record"><i class="icon-microphone"></i>录音</a>  
				<a class="btn" href="javascript:;" id="stop"><i class="icon-exclamation-sign"></i>停止</a>  
				<a class="btn btn-success" href="javascript:;" id="send" style="display:none"><i class="icon-upload-alt"></i>保存</a>  
             </div>
          </div>
          
        </div>
	    <div class="modal-footer">
	      <a href="javascript:;" class="btn btn-primary" onclick="">发布</a>
	      <a href="javascript:;" class="btn" onclick="closeVoiceCommentsPop()">关闭</a>
	    </div>
    </div>
<script type="text/javascript">

function relaycomments(userid){
	replyuserid = userid;
	popdiv();
}

  
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
			    }else if( item == 'error'){
			   	   alert("网络异常请重试");
			    }else {
			     	alert(item);
			    }
	   		  }
	 }); 
}

</script>
<script type="text/javascript">

var istext = false;

function popdiv(){
	if(istext){
		createTextCommentsPop();
	}else{
		createVoiceCommentsPop();
	}
}

function popdivfrombtn(){
	replyuserid = '';
	if(istext){
		createTextCommentsPop();
	}else{
		createVoiceCommentsPop();
	}
}


function closeTextCommentsPop(){
	 $('#createTextCommentsModal').modal('hide');
}

function createTextCommentsPop(){
	 istext = true;
	 $('#createTextCommentsModal').modal({
      keyboard: false
  });
}

function closeVoiceCommentsPop(){
	 $('#createVoiceCommentsModal').modal('hide');
}

function createVoiceCommentsPop(){
	 istext = false;
	 $('#createVoiceCommentsModal').modal({
     keyboard: false
     });
	 clear();
}

function clear(){
	 $.jRecorder.stop();
	 $('#send').hide();
	 $('#status').html('你的音评 ');
	 $('#time').html("");
}

</script>
<%@ include file="../../../recordfootinclude.jsp"%>
<script>
   var partsId = '${partEntity.id}';
   var partsOwner = '${partEntity.userid}';
   $.jRecorder(
     
     { 
        host : "<%=webcontext %>" + "addVoiceComments?savefile=hello.wav&target=part&type=wav&commentedId=" + partsId + "&commentedUserId=" + partsOwner + "&replyUserId=" + replyuserid,  
        callback_started_recording:     function(){callback_started(); },
        callback_stopped_recording:     function(){callback_stopped(); },
        callback_activityLevel:          function(level){callback_activityLevel(level); },
        callback_activityTime:     function(time){callback_activityTime(time); },
        callback_finished_sending:     function(time){ callback_finished_sending() },
        swf_path : 'jRecorder.swf',
        'rec_width': '500',
		'rec_height': '400',
     }
   
   );
   
   
   $('#record').click(function(){
	   $('#send').hide();
       $.jRecorder.record(5);
   });
   
   
   $('#stop').click(function(){
      $.jRecorder.stop();
      $('#send').show();
   });
   
   
    $('#send').click(function(){
      $.jRecorder.sendData();
    });
   

   function callback_finished()
   {
       $('#status').html('录音结束');
       $('#send').show();
   }
   
   function callback_started()
   {
	   $('#send').hide();
       $('#status').html('录音开始');
   }
   
   function callback_error(code)
   {
       $('#status').html('出了点小问题');
       $('#send').hide();
   }
   
   
   function callback_stopped()
   {
       $('#status').html('录音停止');
       $('#send').show();
   }

   function callback_finished_recording()
   {
       $('#status').html('录音完成');
       $('#send').show();
   }
   
   function callback_finished_sending()
   {
	   alert("发送成功");
       $('#status').html('已经将你的录音评论发送到服务器');
       $('#send').hide();
   }
   
   function callback_activityLevel(level)
   {
     
     $('#level').html(level);
     
     if(level == -1)
     {
       $('#levelbar').css("width",  "2px");
     }
     else
     {
       $('#levelbar').css("width", (level * 2)+ "px");
     }
     
     
   }
   
   function callback_activityTime(time)
   {
     $('#time').html(time+"秒");
   }

   </script> 
</body>
</html>
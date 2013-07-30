<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="../../../headerinclude.jsp"%>
</head>
<body class="mxkbody mxkbackgroud" onload="bindScroll()">
<%@ include file="../public/user_page_header.jsp"%>
<div class="container">
  <div class="row">
     <div class="span1">
        <img class="img-polaroid border-radius"  style="height:60px;width:60px"
         src="<%=imgurl %>${currentSubjectEntity.faceimage }" >
     </div>
     <div class="span11">
        <span>
          <span style="font-size: 20px;"><strong><a href="<%=rootPath%>/userIndex">${uservo.name }</a>&nbsp;/&nbsp;${currentSubjectEntity.name }</strong></span>
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
           <a class="btn" href="<%=rootPath %>/showSubjectDetailView"><i class="icon-hdd"></i>返回专题</a>
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
              <a href="<%=rootPath %>/vistiorShowSubjectDatail?target=${currentSubjectEntity.id }">...</a>
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
	             <div class="btn-group">
                      <a class="btn dropdown-toggle btn " data-toggle="dropdown" href="#">
                        <i class="icon-globe"></i>分享
                      <span class="caret"></span>
				    </a>
				     <ul class="dropdown-menu">
					       <li>
						      <a href="http://service.weibo.com/share/share.php?url=<%=rootPath%>/vistiorShowSubjectDatail?target=${currentSubjectEntity.id }&pic=<%=imgurl %>${currentSubjectEntity.faceimage }&title=${currentSubjectEntity.name }&nbsp;&nbsp;${partEntity.info }" target="_blank">
						                     分享到新浪微博
						       </a>
					       </li>
						   <li>
							   <a href="http://share.v.t.qq.com/index.php?c=share&a=index&url=<%=rootPath%>/vistiorShowSubjectDatail?target=${currentSubjectEntity.id }&pic=<%=imgurl %>${currentSubjectEntity.faceimage }&title=${currentSubjectEntity.name }&nbsp;&nbsp;${partEntity.info }" target="_blank">
							         分享到QQ微信
							   </a>
						   </li>
						   <li>
							   <a href="http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url=<%=rootPath%>/index&pic=<%=imgurl %>${currentSubjectEntity.faceimage }&title=${currentSubjectEntity.name }&nbsp;&summary=${partEntity.info }|&nbsp;<%=rootPath%>/vistiorShowSubjectDatail?target=${currentSubjectEntity.id }" target="_blank">
							         分享到QQ空间
							   </a>
						  </li>
		               </ul>
				    </div>
              </span>
             <span class="pull-right">
	            <a class="btn" href="<%=rootPath %>/subjectComments">
	              <i class="icon-refresh"></i>刷新
	            </a>
             </span>
		</div>
	</div>
</div>


<div class="container">
   <div class="row">
       <div class="span4">
          <ul class="thumbnails">
			  <li class="span4 mxkplan mxkshadow">
			  <div class='thumbnail'>
	            <c:if test="${empty subjectNewPartsVO }">
				   <a href="<%=rootPath %>/vistiorShowSubjectDatail?target=${currentSubjectEntity.id}"><img src="<%=imgurl %>/${currentSubjectEntity.faceimage }" /></a>  <!-- style="width: 100%;" -->
			     </c:if>
				<c:if test="${!empty subjectNewPartsVO }">
					<table style="width:100%">
	                <tr>
	                  <td rowspan="2" colspan="2">
	                  <a href="<%=rootPath %>/vistiorShowSubjectDatail?target=${currentSubjectEntity.id}">
	                    <img src="<%=imgurl %>/${currentSubjectEntity.faceimage}" style="border-radius:3px 3px 3px 3px;border: 1px solid #e5e5e5;width:203px;height:195px;">  <!-- style="width: 100%;" -->
	                  </a>
	                  </td>
	                  <td>
	                  <a href="<%=rootPath %>/visitorShowPartDetail?target=${subjectNewPartsVO.partId1}">
	                  <img src="<%=imgurl %>/${subjectNewPartsVO.partImage1}" style="border-radius:3px 3px 3px 3px;border: 1px solid #e5e5e5;width:80px;height:95px;">
	                  </a>
	                  </td>
	                </tr>
	                <tr>
	                  <td>
	                  <a href="<%=rootPath %>/visitorShowPartDetail?target=${subjectNewPartsVO.partId2}">
	                  <img src="<%=imgurl %>/${subjectNewPartsVO.partImage2}" style="border-radius:3px 3px 3px 3px;border: 1px solid #e5e5e5;width:80px;height:95px;">
	                  </a>
	                  </td>
	                </tr>
	                <tr>
	                  <td><a href="<%=rootPath %>/visitorShowPartDetail?target=${subjectNewPartsVO.partId3}"><img src="<%=imgurl %>/${subjectNewPartsVO.partImage3}" style="border-radius:3px 3px 3px 3px;border: 1px solid #e5e5e5;width:100px;height:90px;"></a></td>
	                  <td><a href="<%=rootPath %>/visitorShowPartDetail?target=${subjectNewPartsVO.partId4}"><img src="<%=imgurl %>/${subjectNewPartsVO.partImage4}" style="border-radius:3px 3px 3px 3px;border: 1px solid #e5e5e5;width:100px;height:90px;"></a></td>
	                  <td><a href="<%=rootPath %>/visitorShowPartDetail?target=${subjectNewPartsVO.partId5}"><img src="<%=imgurl %>/${subjectNewPartsVO.partImage5}" style="border-radius:3px 3px 3px 3px;border: 1px solid #e5e5e5;width:80px;height:90px;"></a></td>
	                </tr>
			      </table>
				</c:if>
				<div style="text-overflow:ellipsis; white-space:nowrap; overflow:hidden;">
					<span><strong><a href="<%=rootPath %>/vistiorShowSubjectDatail?target=${currentSubjectEntity.id}">${currentSubjectEntity.name }</a></strong></span>
                    &nbsp;&nbsp;<small class="muted"><span class="label">${currentSubjectEntity.category }</span></small><br />
                 </div>
                 <span><small>${currentSubjectEntity.info }</small></span><br />
				<span class="pull-right">
					<a class="btn" href="<%=rootPath %>/showSubjectDetailView"><i class="icon-hdd"></i>专题详情</a>
				</span>
				<br/><br/>
				</div>
			  </li>
		   </ul>
       </div>
       
       <!-- 评论 -->
       <div class="span8 mxkplan mxkshadow">
         
         <div class="row" style="padding:5px;margin-bottom:5px;">
          <div class="span1">
            <c:if test="${!empty uservo}">
               <img class="img-polaroid border-radius" src="<%=imgurl %>${uservo.image }"/>
               <span class="muted"><small>${uservo.name}</small></span>
            </c:if>
            <c:if test="${empty uservo}">
               <img class="img-polaroid border-radius" src="<%=imgurl %>userheader.png"/>
            </c:if>
          </div>
          <div class="span6">
            <span>
              <span class="muted">你的评论</span>
              <span class="pull-right muted"><a href="javascript:;" onclick="closeTextCommentsPop();createVoiceCommentsPop();"><i class="icon-microphone"></i>语音评论</a></span>
             </span><br />
            <textarea id="commentstextarea" rows="3" style="width:100%"></textarea>
            <button class="pull-right btn btn-primary btn-small" onclick="addTextComents('${currentSubjectEntity.id}','${currentSubjectEntity.userid }','subject')">评论</button>
          </div>
         </div>
         <hr />
         
         <c:forEach var="options" items="${loadCommentsRespone.listAll }">
		  
		   <div class='row' style='padding:5px;margin-bottom:5px;'>
	          <div class='span1'>
	           <img class='img-polaroid border-radius' src='<%=imgurl%>${options.userimage}'/>
	          </div>
	           <div class='span6'>
	             <span>
	             <a href='<%=rootPath %>/vistiorShowUserIndex?target=${options.userid}'>${options.username }</a>&nbsp;${options.reply }&nbsp;
		             <c:if test="${options.reply =='回复' }">
		               <span>
		               <img style="width:20px" src='<%=imgurl%>${options.replyUserImage}'/>
		                <a href='<%=rootPath %>/vistiorShowUserIndex?target=${options.replyUserId}'>${options.replyUserName }</a>
		               </span>
		             </c:if>
	             </span>
	             <span class="pull-right">
	               <a href='javascript:;' onclick="relaycomments('${options.userid }')" >回复</a>
	             </span>
	             <br />
	             <c:if test="${options.type == 'text' }">
	               <span class='muted'>${options.info}</span><br />
	             </c:if>
	             <c:if test="${options.type == 'wav' }">
	               <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="150" height="20">
					    <param name="movie" value="singlemp3player.swf?file=<%=voice %>${options.info }&showDownload=false" />
					    <param name="wmode" value="transparent" />
					    <embed wmode="transparent" width="150" height="20" src="singlemp3player.swf?file=<%=voice %>${options.info }&showDownload=false"
		                type="application/x-shockwave-flash" />
                   </object><br />
	             </c:if>
	             <span><i class='icon-time'></i>${options.createTime }</span>
	           </div>
            </div>
            <div style='padding:1px;margin-bottom:1px;'><div style='width:100%; border-top:1px solid #cccccc'></div></div>
		</c:forEach>
         
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
	 			  window.location.href= path + "/subjectComments";
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
function showCreatePart(){
	 $('#createPartModal').modal({
      keyboard: false
  });
}

function closeCreatePart(){
	 $('#createPartModal').modal('hide');
}


// var allpage = '${loadCommentsRespone.allpage}';
// var isrun = false;
// var page = 2;
var subjectid = '${currentSubjectEntity.id}';
	
</script>
<script>
   var partsId = '${currentSubjectEntity.id}';
   var partsOwner = '${currentSubjectEntity.userid}'; 
   $.jRecorder(
     
     { 
        host : "<%=webcontext %>" + "addVoiceComments?savefile=hello.wav&target=subject&type=wav&commentedId=" + partsId + "&commentedUserId=" + partsOwner + "&replyUserId=" + replyuserid,  
        callback_started_recording:     function(){callback_started(); },
        callback_stopped_recording:     function(){callback_stopped(); },
        callback_activityLevel:          function(level){callback_activityLevel(level); },
        callback_activityTime:     function(time){callback_activityTime(time); },
        callback_finished_sending:     function(time){ callback_finished_sending() },
        swf_path : 'jRecorder.swf',
        'rec_width': '600',
		'rec_height': '500',
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
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
        <img class="img-polaroid border-radius" 
         src="<%=imgurl %>${targetUserVO.image }" >
     </div>
     <div class="span11">
       <span style="font-size: 20px;"><strong>From:&nbsp;<a href="<%=rootPath%>/vistiorShowUserIndex?target=${targetUserVO.id}">${targetUserVO.name }</a></strong></span>
        <c:if test="${targetUserVO.sex == 1 }" >
           <img src="<%=assets%>mxkimage/male1.png">
        </c:if>
         <c:if test="${targetUserVO.sex == 0 }" >
           <img src="<%=assets%>mxkimage/male2.png">
        </c:if>
        <span class="pull-right">
            <a href="visitorShowPartDetail?target=${partEntity.id }" class="btn">
               <i class="icon-list"></i>Parts详情
            </a>
            <a class="btn btn btn-info" href="javascript:;" onclick="popdivfrombtn()">
              <i class="icon-comment-alt"></i>发布评论
            </a>
         </span><br />
        <span>${targetUserVO.info }</span><br />
        <span><i class="icon-time"></i>Create Time:${partEntity.createTime }</span>
        <span class="pull-right">
          <span class="label label-success"><i class="icon-microphone"></i>语音${partEntity.audios}</span>
		  <span class="label"><i class="icon-comment-alt"></i>文字${partEntity.comments  }</span>
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
						      <a href="http://service.weibo.com/share/share.php?url=<%=rootPath%>/visitorShowPartDetailFromShare?target=${partEntity.id }&pic=<%=imgurl %>${partEntity.image }&title=${subjectEntity.name }&nbsp;&nbsp;${partEntity.desc }" target="_blank">
						                   分享到新浪微博
						       </a>
					       </li>
						   <li>
							   <a href="http://share.v.t.qq.com/index.php?c=share&a=index&url=<%=rootPath%>/visitorShowPartDetailFromShare?target=${partEntity.id }&pic=<%=imgurl %>${partEntity.image }&title=${subjectEntity.name }&nbsp;&nbsp;${partEntity.desc }" target="_blank">
							         分享到QQ微信
							   </a>
						   </li>
						   <li>
							   <a href="http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url=<%=rootPath%>/index&pic=<%=imgurl %>${partEntity.image }&title=${subjectEntity.name }&nbsp;&summary=${partEntity.desc }|&nbsp;<%=rootPath%>/visitorShowPartDetailFromShare?target=${partEntity.id }" target="_blank">
							         分享到QQ空间
							   </a>
						  </li>
		               </ul>
				    </div>
				    <a class="btn" href="<%=rootPath%>/visitorShowPartsCollecter?target=${partEntity.id}">
		               <i class="icon-pushpin"></i>收藏次数<span id="coll">${partEntity.collect }</span>
		            </a>
              </span>
             <span class="pull-right">
	            <a class="btn" href="<%=rootPath %>/visitorShowSinglePartsComments?target=${partEntity.id }">
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
				 <img src="<%=imgurl %>${partEntity.image }" />
                 <span><small>${partEntity.desc }</small></span><br />
							    <span class="label">${partEntity.type }</span>
							    <a class="btn btn-danger btn-mini" href="javascript:;" onclick="collectPart('${partEntity.id}')">
		                           <i class="icon-pushpin"></i>收藏
		                        </a>
							    <span class="pull-right muted">
							        <small>
								    <i class="icon-comment"></i>评论${partEntity.comments + partEntity.audios  }
								    <i class="icon-pushpin"></i>收藏<span id="coll">${partEntity.collect }</span>
								    </small>
							    </span>
				<br/>
				</div>
			  </li>
		   </ul>
       </div>
       
       <!-- 评论 -->
       <div class="span8 mxkplan mxkshadow">
         
         
         <div class="row" style="padding:5px;margin-bottom:5px;">
          <div class="span1">
            <img class="img-polaroid border-radius" src="<%=imgurl %>${uservo.image }"/> 
            <span class="muted"><small>${uservo.name}</small></span>
          </div>
          <div class="span6">
            <span>
              <span class="muted">你的评论</span>
              <span class="pull-right muted"><a href="javascript:;" onclick="closeTextCommentsPop();createVoiceCommentsPop();"><i class="icon-microphone"></i>语音评论</a></span>
             </span><br />
            <textarea id="commentstextarea" rows="3" style="width:100%"></textarea>
            <button class="pull-right btn btn-primary btn-small" onclick="addTextComents('${partEntity.id}','${partEntity.userid }','part')">评论</button>
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
	             <a href='<%=rootPath %>/vistiorShowUserIndex?target=${options.userid}'>${options.username }</a>&nbsp;${options.reply }
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
					    <param name="movie" value="singlemp3player.swf?showDownload=false" />
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
	      <a href="javascript:;" class="btn btn-primary" onclick="addTextComents('${partEntity.id}','${partEntity.userid }','part')">发布</a>
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
	 			  window.location.href= path + "/visitorShowSinglePartsComments?target="+ commentedId;
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

  function mouseover(){
    $("partfun").css("z-index","1");
  }
  
  function mouseout(){
	$("partfun").css("z-index","-1");
  }

  var replyuserid = '';
  
  function collectPart(partid){
	  $.ajax({
   		url : path + "/createUserCollect.action",
   		type : "POST",
   		cache : false,
   		async : false,
   		data: {"collectPartsRequest.targetId":partid},
   		dataType : "json",
   		success : function(item) {
   		    if(item == 'success'){
 			   alert("已将Part加入到你的收藏夹");
 			  var num = $("#coll").html();
		    	 var number = parseInt(num);
		    	 var sum = 1+ number;
		    	 $("#coll").html(sum);
		    }else if( item == 'error'){
		   	   alert("网络异常请重试");
		    }else {
		     	alert(item);
		    }
   		  }
 	 }); 
  }
  
</script>
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
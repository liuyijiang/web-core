<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
 <%@ include file="../../../headerinclude.jsp"%>
</head>
<script type="text/javascript">
  
  var page = 1; // 记录页数
  var traget = '${partEntity.id}';
  
  function createUserRelation(id){	  
	  $.ajax({
	   		url : path + "/createUserRelation.action",
	   		type : "POST",
	   		cache : false,
	   		async : false,
	   		data: {"createRelationShipRequest.userid":id},
	   		dataType : "json",
	   		success : function(item) {
	   		    if(item == 'success'){
	 			   alert("关注成功");
			    }else if( item == 'error'){
			   	   alert("已经关注");
			    }else {
			     	alert(item);
			    }
	   		  }
	 	 });  
  }
  
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
		    }else if( item == 'error'){
		   	   alert("网络异常请重试");
		    }else {
		     	alert(item);
		    }
   		  }
 	 }); 
  }
  
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

//   function showTextCommecnt(){
// 	  $("#textcommentsdiv").show();
// 	  $("#voicecommentsdiv").hide();
// 	  page = 1;
// 	  loadTextComent("text");
//   }
  
//   function showVoiceComment(){
// 	  $("#voicecommentsdiv").show();
// 	  $("#textcommentsdiv").hide();
// 	  page = 1;
// 	  loadVoiceComent("wav");
//   }
  
//   function showAddVoiceCommentsDiv(){
// 	  $("#addvoicecommentsdiv").show();
// 	  $("#addtextcommentdiv").hide();
//   }
  
//   function showAddTextCommentDiv(){
// 	  $("#addtextcommentdiv").show();
// 	  $("#addvoicecommentsdiv").hide();
//   }
  
//   function loadTextComent(type){
// 	  $("#textload").show();
// 	  var datas = {"loadCommentsRequest.targeid":traget,"loadCommentsRequest.page":page,"loadCommentsRequest.type":type};
// 	  $.ajax({
// 	   		url : path + "/loadTrageComments.action",
// 	   		type : "POST",
// 	   		cache : false,
// 	   		async : false,
// 	   		data: datas,
// 	   		dataType : "json",
// 	   		success : function(item) {
// 	   		    $("#textload").hide();
// 	   		    createTextList(item.list);
// 	   		}
// 	 }); 
//   }
  
//   function loadVoiceComent(type){
// 	  $("#textload").show();
// 	  var datas = {"loadCommentsRequest.targeid":traget,"loadCommentsRequest.page":page,"loadCommentsRequest.type":type};
// 	  $.ajax({
// 	   		url : path + "/loadTrageComments.action",
// 	   		type : "POST",
// 	   		cache : false,
// 	   		async : false,
// 	   		data: datas,
// 	   		dataType : "json",
// 	   		success : function(item) {
// 	   		    $("#voiceload").hide();
// 	   		    createVoiceList(item.list);
// 	   		}
// 	 }); 
//   }
  
  
//   function createTextList(list){
// 	  var showdiv = '';
// 	  for(var i in list){
// 		  showdiv = showdiv + "<div class='row' style='padding:5px;margin-bottom:5px;'><div class='span1'>" +
// 		  "<img class='img-polaroid border-radius' src='"+ imgurl + list[i].userimage +"'/></div>" +
// 		  "<div class='span7'><span><a href=''>"+ list[i].username +"</a>&nbsp;评论:</span><br />" +
// 		  "<span class='muted'>"+ list[i].info +"</span><br />" +
// 		  "<span><i class='icon-time'></i>"+list[i].createTime +"</span></div></div>" +
// 		  "<div style='padding:1px;margin-bottom:1px;'><div style='width:100%; border-top:1px solid #cccccc'></div></div>";
// 	  }
// 	  $('#textcomentslist').append(showdiv);
//   }
  
//   function createVoiceList(list){
// 	  var showdiv = '';
// 	  for(var i in list){
// 		  showdiv = showdiv + "<div class='row' style='padding:5px;margin-bottom:5px;'><div class='span1'>" +
// 		  "<img class='img-polaroid border-radius' src='"+ imgurl + list[i].userimage +"'/></div>" +
// 		  "<div class='span7'><span><a href=''>"+ list[i].username +"</a>&nbsp;评论:</span><br />" +
// 		  "<span><object classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000' width='300' height='20'>" +
// 		  "<embed wmode='transparent' width='150' height='20' src='singlemp3player.swf?file="+ voice + list[i].info +"&showDownload=false' type='application/x-shockwave-flash' pluginspage='http://www.macromedia.com/go/getflashplayer' />" +
// 	      "</object></span><br />" +
// 		  "<span><i class='icon-time'></i>"+list[i].createTime +"</span></div></div>" +
// 		  "<div style='padding:1px;margin-bottom:1px;'><div style='width:100%; border-top:1px solid #cccccc'></div></div>";
// 	  }
// 	  $('#voicecomentslist').append(showdiv);
//   }
  
//   function addTextComents(commentedId,commentedUserId,traget){
// 	  var info = $("#commentstextarea").val();
// 	  var datas = {"commentsAddRequest.commentedUserId":commentedUserId,"commentsAddRequest.commentedId":commentedId,"commentsAddRequest.info":info,"commentsAddRequest.target":traget,"commentsAddRequest.type":"text"};
// 	  $.ajax({
// 	   		url : path + "/addTextComments.action",
// 	   		type : "POST",
// 	   		cache : false,
// 	   		async : false,
// 	   		data: datas,
// 	   		dataType : "json",
// 	   		success : function(item) {
// 	   		    if(item == 'success'){
// 	 			   alert("评论成功！");
// 			    }else if( item == 'error'){
// 			   	   alert("网络异常请重试");
// 			    }else {
// 			     	alert(item);
// 			    }
// 	   		  }
// 	 	 }); 
//   }
  
  
  function rsssubject(subjectid,subjectOwnerId){
	  var datas = {"rssSubjectRequest.subjectid":subjectid,"rssSubjectRequest.subjectOwnerId":subjectOwnerId};
	  $.ajax({
	   		url : path + "/rsssubject.action",
	   		type : "POST",
	   		cache : false,
	   		async : false,
	   		data: datas,
	   		dataType : "json",
	   		success : function(item) {
	   		    if(item == 'success'){
	 			   alert("订阅成功！");
			    }else if( item == 'error'){
			   	   alert("网络异常请重试");
			    }else {
			       alert(item);
			    }
	   		  }
	 	 }); 
  }
  
</script>
<body class="mxkbody mxkbackgroud" >
	<%@ include file="../public/user_page_header.jsp"%>
<div class="container ">
<div class="row">
     <div class="span9 mxkplan mxkshadow">
       	<div class="navbar">
			<div class="navbar-inner form-inline ">
			     <span >
	                  <div class="btn-group">
                      <a class="btn dropdown-toggle btn " data-toggle="dropdown" href="#">
                        <i class="icon-globe"></i>分享
                      <span class="caret"></span>
				    </a>
				     <ul class="dropdown-menu">
					       <li>
						      <a href="http://service.weibo.com/share/share.php?url=<%=rootPath%>/visitorShowPartDetail?target=${partEntity.id }&pic=<%=imgurl %>${partEntity.image }&title=${subjectEntity.name }&nbsp;&nbsp;${partEntity.desc }" target="_blank">
						                   分享到新浪微博
						       </a>
					       </li>
						   <li>
							   <a href="http://share.v.t.qq.com/index.php?c=share&a=index&url=<%=rootPath%>/visitorShowPartDetail?target=${partEntity.id }&pic=<%=imgurl %>${partEntity.image }&title=${subjectEntity.name }&nbsp;&nbsp;${partEntity.desc }" target="_blank">
							         分享到QQ微信
							   </a>
						   </li>
						   <li>
							   <a href="http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url=<%=rootPath%>/index&pic=<%=imgurl %>${partEntity.image }&title=${subjectEntity.name }&nbsp;&summary=${partEntity.desc }|&nbsp;<%=rootPath%>/visitorShowPartDetail?target=${partEntity.id }" target="_blank">
							         分享到QQ空间
							   </a>
						  </li>
		               </ul>
				    </div>
				    <a class="btn btn-danger" href="javascript:;" onclick="collectPart('${partEntity.id}')">
		               <i class="icon-pushpin"></i>收藏
		            </a>
			     </span>
			     <span class="pull-right">
			          <a class="btn btn-primary" href="<%=rootPath %>/visitorShowPartsCommnets?target=${partEntity.id}"><i class="icon-comments-alt"></i>评论Parts</a>
			     </span>
			</div>
		</div>
		<div style="position:relative;" onmouseover="mouseoverp()" onmouseout="mouseoutp()" >
	        <center>
		        <span style="position:absolute; z-index:-1; opacity:0.8;" id="partfun">
		           <span class="label label-success"><i class="icon-microphone"></i>语音${partEntity.audios}</span>
		           <span class="label"><i class="icon-comment-alt"></i>文字${partEntity.comments  }</span>
		        </span>
		        <img class="img-polaroid" src="<%=imgurl %>${partEntity.image }" /><br/>
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
		<c:if test="${! empty partNewCommentsResponse.list}">
		   <span class="pull-right"><a class="btn" href="<%=rootPath %>/visitorShowPartsCommnets?target=${partEntity.id}">更多评论</a>&nbsp;&nbsp;</span>
		</c:if>
		<br/><br/>
     </div>
     <div class="span3">
     	<ul class="thumbnails">
			  <li class="span3 mxkplan mxkshadow">
				<div class="thumbnail">
				<div style="margin-bottom:5px;">
				<table style="width:100%" >
				  <tr>
				    <td width="20%">
				     <div style="position:relative;" onmouseover="mouseover()" onmouseout="mouseout()" >
				        <a href="<%=rootPath%>/vistiorShowUserIndex?target=${targetUserVO.id}">
				          <img class="img-polaroid" style="width:30px" src="<%=imgurl %>${targetUserVO.image }" />
				        </a>  
				        <span style="position:absolute; z-index:-1; opacity:0.8;" id="subjectfun">
				           <a href="javascript:;" class="pull-right btn-inverse btn btn-mini" onclick="createUserRelation('${targetUserVO.id}')" >关注</a>
				        </span>
				     </div>
				     </td>
				    <td width="80%">
					    <div style="width:150px;text-overflow:ellipsis; white-space:nowrap; overflow:hidden;">
					       <strong><a href="<%=rootPath%>/vistiorShowUserIndex?target=${targetUserVO.id}">${targetUserVO.name }</a></strong>
					    </div>
					    <div style="width:150px;text-overflow:ellipsis; white-space:nowrap; overflow:hidden;">
					      <small >${targetUserVO.info }</small>
					    </div>
				    </td>
				  </tr>
				</table>
				    <a href="<%=rootPath %>/vistiorShowSubjectDatail?target=${subjectEntity.id}"><img src="<%=imgurl %>${subjectEntity.faceimage }" /></a>
					<div style="text-overflow:ellipsis; white-space:nowrap; overflow:hidden;">
					<span><strong><a href="<%=rootPath %>/vistiorShowSubjectDatail?target=${subjectEntity.id}">${subjectEntity.name }</a></strong></span>
                    &nbsp;/&nbsp;<small class="muted">(<i class="icon-tags"></i>${subjectEntity.tags })</small><br />
                    </div>
                    <div style="text-overflow:ellipsis; white-space:nowrap; overflow:hidden;">
                     <small>${subjectEntity.info }</small>
                    </div>
                     <br />
                    <span>
                      	<span class="label">${subjectEntity.category }</span>
                      	 <c:choose>
		                <c:when test="${subjectEntity.type == 'PUBLIC'}">
                           <span class="label label-success">
                              <i class="icon-hdd"></i>公开
						   </span>
		                </c:when>
		                <c:when test="${subjectEntity.type == 'FOR-ALL'}">
		                  <span class="label label-warning">
                             <i class="icon-globe"></i>共享
						   </span>
		                </c:when>
		             </c:choose>
                    </span>
                    <span class="pull-right">
		              <a href="javascript:;" class="btn btn-mini" onclick="rsssubject('${subjectEntity.id}','${subjectEntity.userid }')"><i class="icon-rss"></i>订阅专题</a>
                    </span>
                    <br />
				</div>
				</div>
		   </li>
		</ul>
     </div>
  </div>
</div>
<br />
<!-- commnets -->
<!-- <div class="container"> -->
<!--    <div class="row"> -->
   
<!--    <div class='span12'>  -->
<!--    <ul class="thumbnails" id="partshow1"> -->
<%--      <c:forEach var="options" items="${partNewCommentsResponse.list  }"> --%>
    
<!-- 	   <li class="span3 mxkplan mxkshadow"> -->
<!-- 				<div class="thumbnail"> -->
<!-- 				   <table> -->
<!-- 				     <tr> -->
<!-- 				       <td width="150px"> -->
<%-- 				        <img style="width:100%" src="<%=imgurl %>${options.userimage}" /> --%>
<!-- 				       </td> -->
<!-- 				       <td valign="top"> -->
<%-- 				         <a href="<%=rootPath %>/visitorShowPartsCommnets?target=${partEntity.id}">回复</a> --%>
<!-- 				       </td> -->
<!-- 				     </tr> -->
<!-- 				   </table> -->
<%-- 				    <span><a href="#">${options.username }</a><br /> --%>
<%-- 				    <span class='muted'><small>${options.reply }</small></span></span><br /> --%>
<%-- 					<c:if test="${options.type == 'text' }"> --%>
<%-- 	                   <span class='muted'>${options.info}</span><br /> --%>
<%-- 	                </c:if> --%>
<%-- 		             <c:if test="${options.type == 'wav' }"> --%>
<!-- 		               <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="150" height="20"> -->
<!-- 						    <param name="movie" value="singlemp3player.swf?showDownload=false" /> -->
<!-- 						    <param name="wmode" value="transparent" /> -->
<%-- 						    <embed wmode="transparent" width="150" height="20" src="singlemp3player.swf?file=<%=voice %>${options.info }&showDownload=false" --%>
<!-- 			                type="application/x-shockwave-flash" /> -->
<!-- 	                   </object><br /> -->
<%-- 		             </c:if> --%>
<%-- 					<span class="muted"><small><i class="icon-time"></i>${options.createTime }</small></span><br /> --%>
<!-- 				</div> -->
<!-- 		      </li> -->
<%-- 	   </c:forEach> --%>
<!-- 	  </ul>   -->
<!--     </div>	     -->
<!--  </div> -->



<!-- <div id="textcommentsdiv" class="container" style="display:none"> -->
<!--        <div class="row"> -->
<!--           <div class="span9 mxkplan mxkshadow" > -->
<!-- 	        <div id="textcomentslist"> -->
<!-- 		    </div>  -->
<!-- 		     <div id="textload" class="row" style="padding:5px;margin-bottom:5px;" style="display:none">  -->
<!-- 		         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
<%-- 		         <img src="<%=domain %>/image/loadingred.gif" >  --%>
<!-- 		     </div> -->
<!--           </div> -->
<!--        </div> -->
<!--     <br /> -->
<!-- </div> -->

 
<!-- 语音评论 -->
<!-- <div id="voicecommentsdiv" class="container" style="display:none"> -->
<!--   <div class="row"> -->
<!--      <div class="span9 mxkplan mxkshadow " > -->
<!--             <div id="voicecomentslist"> -->
<!-- 		    </div>  -->
<!-- 		     <div id="voiceload" class="row" style="padding:5px;margin-bottom:5px;" style="display:none">  -->
<!-- 		         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
<%-- 		         <img src="<%=domain %>/image/loadingred.gif" >  --%>
<!-- 		     </div> -->
<!--         </div> -->
<!--      </div> -->
<!--   <br /> -->
<!-- </div> -->


<!-- <div id="addtextcommentdiv" class="container"> -->
<!--   <div class="row"> -->
<!--     <div class="span9 mxkplan mxkshadow " > -->
<!--          <div class="row" style="padding:5px;margin-bottom:5px;"> -->
<!--           <div class="span1"> -->
<%--             <img class="img-polaroid border-radius" src="<%=imgurl %>${uservo.image }"/>  --%>
<%--             <span class="muted"><small>${uservo.name}</small></span> --%>
<!--           </div> -->
<!--           <div class="span7"> -->
<!--             <span> -->
<!--               <span class="muted">你的评论</span> -->
<!--               <span class="pull-right muted"><a href="javascript:;" onclick="showAddVoiceCommentsDiv()">语音评论</a></span> -->
<!--              </span><br /> -->
<!--             <textarea id="commentstextarea" rows="3" style="width:100%"></textarea> -->
<%--             <button class="pull-right btn btn-success btn-small" onclick="addTextComents('${partEntity.id}','${partEntity.userid }','part')">评论</button> --%>
<!--           </div> -->
<!--          </div> -->
<!--     </div> -->
<!--    </div> -->
<!-- </div> -->

<!-- <div id="addvoicecommentsdiv" class="container" style="display:none"> -->
<!--   <div class="row"> -->
<!--     <div class="span9 mxkplan mxkshadow " > -->
<!--          <div class="row" style="padding:5px;margin-bottom:5px;"> -->
<!--           <div class="span1"> -->
<%--             <img class="img-polaroid border-radius" src="<%=imgurl %>${uservo.image }"/>  --%>
<%--             <span class="muted"><small>${uservo.name}</small></span> --%>
<!--           </div> -->
<!--           <div class="span7"> -->
<!--             <span> -->
<!--               <span id="status" class="muted">你的音评</span> -->
<!--               &nbsp; -->
<!--               <small><span id="time" class="muted"></span></small> -->
<!--               <span class="pull-right muted"><a href="javascript:;" onclick="showAddTextCommentDiv()" >文字评论</a></span> -->
<!--              </span><br /> -->
<!-- 			 <div style="background-color:#eeeeee; width:200px; border:1px solid #cccccc"> -->
<!-- 				<div id="levelbase" style="width:200px;height:15px;background-color:#ffff00"> -->
<!-- 				  <div id="levelbar" style="height:14px; width:2px;background-color:red"></div> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 			<div style="height:5px;"></div> -->
<!-- 			 <div> -->
<!-- 				<a class="btn" href="javascript:;" id="record"><i class=" icon-volume-down"></i>录音</a>   -->
<!-- 				<a class="btn" href="javascript:;" id="stop"><i class="icon-exclamation-sign"></i>停止</a>   -->
<!-- 				<a class="btn btn-success" href="javascript:;" id="send" style="display:none"><i class="icon-upload-alt"></i>保存</a>   -->
<!--              </div> -->
<!--           </div> -->
<!--          </div> -->
<!--     </div> -->
<!--    </div> -->
<!-- </div> -->
    
    
  <script type="text/javascript">

// 	 function showCreatePart(){
// 		 $('#createPartModal').modal({
// 	       keyboard: false
// 	   });
// 	 }
 
// 	 function closeCreatePart(){
// 		 $('#createPartModal').modal('hide');
// 	 }
	 
 </script>
    
<%@ include file="../../../recordfootinclude.jsp"%>
<script>
//    var partsId = '${partEntity.id}';
//    var partsOwner = '${partEntity.userid}';
//    $.jRecorder(
     
//      { 
<%--         host : "<%=webcontext %>" + "addVoiceComments?savefile=hello.wav&target=part&type=wav&commentedId=" + partsId + "&commentedUserId=" + partsOwner,  //replace with your server path please --%>
//         callback_started_recording:     function(){callback_started(); },
//         callback_stopped_recording:     function(){callback_stopped(); },
//         callback_activityLevel:          function(level){callback_activityLevel(level); },
//         callback_activityTime:     function(time){callback_activityTime(time); },
//         callback_finished_sending:     function(time){ callback_finished_sending() },
//         swf_path : 'jRecorder.swf',
//         'rec_width': '600',
// 		'rec_height': '500',
//      }
   
//    );
   
   
//    $('#record').click(function(){
// 	   $('#send').hide();
//        $.jRecorder.record(5);
//    });
   
   
//    $('#stop').click(function(){
//       $.jRecorder.stop();
//       $('#send').show();
//    });
   
   
//     $('#send').click(function(){
//       $.jRecorder.sendData();
//     });
   

//    function callback_finished()
//    {
//        $('#status').html('录音结束');
//        $('#send').show();
//    }
   
//    function callback_started()
//    {
// 	   $('#send').hide();
//        $('#status').html('录音开始');
//    }
   
//    function callback_error(code)
//    {
//        $('#status').html('出了点小问题');
//        $('#send').hide();
//    }
   
   
//    function callback_stopped()
//    {
//        $('#status').html('录音停止');
//        $('#send').show();
//    }

//    function callback_finished_recording()
//    {
//        $('#status').html('录音完成');
//        $('#send').show();
//    }
   
//    function callback_finished_sending()
//    {
// 	   alert("发送成功");
//        $('#status').html('已经将你的录音评论发送到服务器');
//        $('#send').hide();
//    }
   
//    function callback_activityLevel(level)
//    {
     
//      $('#level').html(level);
     
//      if(level == -1)
//      {
//        $('#levelbar').css("width",  "2px");
//      }
//      else
//      {
//        $('#levelbar').css("width", (level * 2)+ "px");
//      }
     
     
//    }
   
//    function callback_activityTime(time)
//    {
//      $('#time').html(time+"秒");
//    }

   </script> 
</body>
</html>
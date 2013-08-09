<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri= "http://java.sun.com/jsp/jstl/core" prefix= "c" %>  
<%
String rootPath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
// String imgurl = "http://192.168.2.127/mxk/image/";
// String voice = "http://192.168.2.127/mxk/voice/";
String imgurl = "http://www.waileecn.com/mxk/image/";
String voice = "http://www.waileecn.com/mxk/voice/";
String assets = "http://www.waileecn.com/mxk/assets/";   
%>
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
			          <c:if test="${! empty subjectEntity}">
			            <a class="btn btn-primary" href="<%=rootPath %>/visitorShowPartsCommnets?target=${partEntity.id}"><i class="icon-comments-alt"></i>评论Parts</a>
			          </c:if>
			          <c:if test="${empty subjectEntity}">
			            <a class="btn btn-primary" href="<%=rootPath %>/visitorShowSinglePartsComments?target=${partEntity.id}"><i class="icon-comments-alt"></i>评论Parts</a>
			          </c:if>
			     </span>
			</div>
		</div>
		<div style="position:relative;" onmouseover="mouseoverp()" onmouseout="mouseoutp()" >
	        <center>
	            <div style="width:660px">
		        <span style="position:absolute; z-index:-1; opacity:0.8;" id="partfun">
		           <a class="btn btn-success btn-mini" href="<%=rootPath %>/visitorShowPartsCommnets?target=${partEntity.id}"><i class="icon-microphone"></i>语音${partEntity.audios}</a>
		           <a class="btn btn-info btn-mini" href="<%=rootPath %>/visitorShowPartsCommnets?target=${partEntity.id}"><i class="icon-comment-alt"></i>文字${partEntity.comments  }</a>
		           <a class="btn btn-danger btn-mini" href="javascript:;" onclick="collectPart('${partEntity.id}')">
		               <i class="icon-pushpin"></i>收藏
		           </a>
		        </span>
		        <img class="img-polaroid" src="<%=imgurl %>${partEntity.image }" /><br/>
		        </div>
		    </center>
		</div>
		<span style="padding:19px;" id="partmessage" >${partEntity.desc }</span><br />
		  <hr />
		<c:forEach var="options" items="${partNewCommentsResponse.list }">
		  
		   <div class='row' id="commnetstext" style='padding:5px;margin-bottom:5px;'>
	          <div class='span1'>
	           <img class='img-polaroid border-radius' src='<%=imgurl%>${options.userimage}'/>
	          </div>
	           <div class='span7'>
	             <span><a href='<%=rootPath %>/vistiorShowUserIndex?target=${options.userid}'>${options.username }</a>&nbsp;${options.reply }</span><br />
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
	            <c:if test="${options.userid == uservo.id || options.commentedUserId == uservo.id}">
	                <span class="pull-right"><a href="javascript:;" onclick="deleCom('${options.id}','${options.commentedId }')">删除</a></span>
	             </c:if>
	           </div>
            </div>
            <div style='padding:1px;margin-bottom:1px;'><div style='width:100%; border-top:1px solid #cccccc'></div></div>
		</c:forEach>
		<c:if test="${!empty partNewCommentsResponse.list}">
		
		   <c:if test="${!empty subjectEntity}">
			  <span class="pull-right"><a class="btn" href="<%=rootPath %>/visitorShowPartsCommnets?target=${partEntity.id}">更多评论</a>&nbsp;&nbsp;</span>
		   </c:if>
		   <c:if test="${empty subjectEntity}">
			  <span class="pull-right"><a class="btn" href="<%=rootPath %>/visitorShowSinglePartsComments?target=${partEntity.id}">更多评论</a>&nbsp;&nbsp;</span>
		   </c:if>
		</c:if>
		<br/><br/>
     </div>
     <c:if test="${empty subjectEntity}">
         <div class="span3">
     	   <ul class="thumbnails">
			 <li class="span3 mxkplan mxkshadow">
			   <div class="thumbnail">
			        <div style="position:relative;" onmouseover="mouseoveru()" onmouseout="mouseoutu()" >
				         <span style="position:absolute; z-index:-1; opacity:0.8;" id="userfun">
				           <a href="javascript:;" class="pull-right btn-inverse btn btn-mini" onclick="createUserRelation('${targetUserVO.id}')" >加关注</a>
				        </span>
				        <a href="<%=rootPath%>/vistiorShowUserIndex?target=${targetUserVO.id}">
				          <img src="<%=imgurl %>${targetUserVO.image }" />
				        </a>  
				    </div>
				    <div style="text-overflow:ellipsis; white-space:nowrap; overflow:hidden;">
					<span><strong><a href="<%=rootPath%>/vistiorShowUserIndex?target=${targetUserVO.id}">${targetUserVO.name }</a></strong></span>
	                    <c:if test="${targetUserVO.sex == 1 }" >
				           <img src="<%=assets%>mxkimage/male1.png">
				        </c:if>
				         <c:if test="${targetUserVO.sex == 0 }" >
				           <img src="<%=assets%>mxkimage/male2.png">
				        </c:if>
	                    </div>
	                    <div style="text-overflow:ellipsis; white-space:nowrap; overflow:hidden;">
	                     <small>${targetUserVO.info }</small>
	                     </div>
				         <span class="label">${targetUserVO.interest }</span>
				        <span >
				         <a class="pull-right btn btn-success btn-mini" href="<%=rootPath%>/vistiorShowUserIndex?target=${targetUserVO.id}"><i class="icon-hdd"></i>专题数量${targetUserVO.subject }</a>
					    </span>
					  <br /> 
			   </div>
             </li>
           </ul>
         </div>
     </c:if>
     
     <c:if test="${!empty subjectEntity}">
     <div class="span3">
     	<ul class="thumbnails">
			  <li class="span3 mxkplan mxkshadow">
				<div class="thumbnail">
				<div style="margin-bottom:5px;">
				<table style="width:100%" >
				  <tr>
				    <td width="20%">
				     <div style="position:relative;" onmouseover="mouseovers()" onmouseout="mouseouts()" >
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
     </c:if>
  </div>
<br />

<div id="addtextcommentdiv" class="container">
  <div class="row">
    <div class="span9 mxkplan mxkshadow " >
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
		 			   replyuserid = '';
		 			   window.location.href= path + "/visitorShowPartDetail?target="+ partid;
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
	 			  loadParts(commentedId);
	 			   //window.location.href= path + "/visitorShowPartDetail?target="+ commentedId;
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
  
  var partpage = 1; // 记录页数
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
  
  function mouseovers(){
    $("#subjectfun").css("z-index","1");
  }
  
  function mouseouts(){
	$("#subjectfun").css("z-index","-1");
  }
  
  function mouseoveru(){
    $("#userfun").css("z-index","1");
  }
	  
  function mouseoutu(){
	$("#userfun").css("z-index","-1");
  }
  
  function mouseoverp(){
	    $("#partfun").css("z-index","1");
  }
	  
  function mouseoutp(){
	$("#partfun").css("z-index","-1");
  }

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
<script type="text/javascript">
function loadParts(id){ 
	$("#partsdivshow").show();
	$("#londingprts").show();
	var divheight = document.documentElement.scrollTop + document.body.scrollTop + 20;
	$("#divheight").css("height",divheight);
	var currentpage = page;
    $("#partsdiv").load(path +'/visitorShowPartDetailPop?target='+id,function() {
    	page = currentpage;
    	$("#londingprts").hide();
    });  
}  
</script>
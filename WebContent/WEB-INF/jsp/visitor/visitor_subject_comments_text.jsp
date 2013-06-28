<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="../../../headerinclude.jsp"%>
</head>
<body class="mxkbody mxkbackgroud" >
<%@ include file="../public/user_page_header.jsp"%>
<script type="text/javascript">
  
function addTextComents(commentedId,commentedUserId,traget){
  var info = $("#commentstextarea").val();
  var datas = {"commentsAddRequest.commentedUserId":commentedUserId,"commentsAddRequest.commentedId":commentedId,"commentsAddRequest.info":info,"commentsAddRequest.target":traget,"commentsAddRequest.type":"text"};
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
<div class="container">
	<div class="row">
	     <c:if test="${vistitorSeeSubjectCommentsRespone.type == 'text' }">
	        <!-- text comments -->
	         <div class="span8 mxkplan mxkshadow">
	         <div id="textdiv" style="padding:5px;margin-bottom:1px;">
	             <c:if test="${empty vistitorSeeSubjectCommentsRespone.loadCommentsRespone.list }">
	                 <div class="alert alert-block">
                          <a class="close" data-dismiss="alert">×</a>
                          <h4 class="alert-heading">目前还没有人评论你的专题!</h4>
                                                                                       每天发布几张专题最新图片可以提高你专题的知名度
                     </div>
	             </c:if>
	             <c:if test="${!empty vistitorSeeSubjectCommentsRespone.loadCommentsRespone.list }">
	               <c:forEach var="options" items="${vistitorSeeSubjectCommentsRespone.loadCommentsRespone.list }">
		               <table style="width:100%">
				          <tr>
				            <td width="12%">
				             <img class='img-polaroid border-radius' src="<%=imgurl %>/${options.userimage}" style="width:55px" />
				            </td>
				            <td width="88%">
				                <span>
				                   <a href="<%=rootPath %>vistiorShowUserIndex?target=${options.userid}">${options.username}</a>
				                   &nbsp;评论&nbsp;
				                   <span>${options.reply }</span>
				                </span>
				                <span class="pull-right"><a href="javascript:;" >回复</a></span>
				                <br />
				                <span class="muted">${options.info }</span><br />
				                <span class="muted"><i class="icon-time"></i>评论时间：${options.createTime }</span>
				            </td>
				          </tr>
			           </table>
			           <div style='padding:1px;margin-bottom:1px;'>
			            <div style='width:100%; border-top:1px solid #cccccc'></div>
			           </div>
		          </c:forEach>
	             </c:if>
	         </div>
	         
	         <c:if test="${!empty vistitorSeeSubjectCommentsRespone.loadCommentsRespone.list }">
		         <div style="padding:5px;margin-bottom:1px;">
		          <span id="loading" style="display:none"><img src="<%=domain %>/image/loadingred.gif" >正在加载...</span>
		          <span class="pull-right" id="rssmore"><a href="javascript:;" class="btn btn-small btn-primary" onclick="loadmorelist()" ><i class="icon-refresh"></i>加载更多</a></span><br />
		         </div>
		         <script type="text/javascript">
		            function loadmorelist(){
		            	var datas = {"showRssSubjectUserRequest.subjectid":subjectid,"showRssSubjectUserRequest.page":page};
		            	$("#loading").show();
		            	 $.ajax({
		        				url : path + "/subjectMessageMore.action",
		        				type : "POST",
		        				cache : false,
		        				async : false,
		        				data: datas,
		        				dataType : "json",
		        				success : function(item) {
		        					$("#loading").hide();
		        					createlist(item.list);
		        					page = page + 1 ;
		        				}
		        	   });
		            }
		            
		            function createlist(list){
		            	var show = '';
		            	for (var i in list) {
		            		//show = show + "<div style='padding:1px;margin-bottom:1px;'><div style='width:100%; border-top:1px solid #cccccc'></div></div>";
 		            		show = show + "<table style='width:100%'><tr><td width='12%'>" +
		            		"<img class='img-polaroid border-radius' src='"+ imgurl + list[i].userimage +"' style='width:55px' />" +
		            		"</td><td width='88%'><span><a href='"+ path + "/vistiorShowUserIndex?target="+ list[i].userid +"'>"+ list[i].username + "</a></span>" +
		                    "<span class='pull-right'><button class='btn btn-small' onclick='removeRss(\""+list[i].userid + "\")' >取消订阅</button></span>" +
		                    "<br /><span class='muted'>"+ list[i].userdesc +"</span><br />" + 
		                    "<span class='muted'><i class='icon-time'></i>订阅时间："+ list[i].ceateTime + "</span></td></tr></table>" +
		                    "<div style='padding:1px;margin-bottom:1px;'><div style='width:100%; border-top:1px solid #cccccc'></div></div>";
		               }
		               $("#rssdiv").append(show);          
		            }
		         </script>
	         </c:if>
	         <table style="width:97%">
	            <tr>
	              <td width='10%'>
	                <c:if test="${!empty uservo }">
	                  <img class="img-polaroid border-radius" src="<%=imgurl %>${uservo.image }" style="width:55px" />
	                </c:if>
	              </td>
	              <td width='80%'>
	                 <span>
		                <span class="muted">你的评论</span>
	                    <span class="pull-right muted"><a href="javascript:;" onclick="showAddVoiceCommentsDiv()">语音评论</a></span>
                      </span><br />
                      <textarea id="commentstextarea" rows="3" style="width:95%"></textarea>
                      <button class="pull-right btn btn-success btn-small" onclick="addTextComents('${vistitorSeeSubjectCommentsRespone.subjectEntity.id}','${vistitorSeeSubjectCommentsRespone.subjectEntity.userid }','subject')">评论</button>
	              </td>
	            </tr>
	         </table>
	         
	        </div>
	     </c:if>
	 
	     
	  <!--  -->
	      <div class="span4">
	         <ul class="thumbnails">
			    <li class="span4 mxkplan mxkshadow">
				<div class="thumbnail" >
				<div style="margin-bottom:5px;">
				<table style="width:100%" >
				  <tr>
				    <td width="16%">
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
				</div>
					<c:if test="${empty vistitorSeeSubjectCommentsRespone.subjectNewPartsVO }">
					  <img src="<%=imgurl %>/${vistitorSeeSubjectCommentsRespone.subjectEntity.faceimage}" />  <!-- style="width: 100%;" -->
					</c:if>
					<c:if test="${!empty vistitorSeeSubjectCommentsRespone.subjectNewPartsVO }">
						<table style="width:100%">
		                <tr>
		                  <td rowspan="2" colspan="2">
		                  <img src="<%=imgurl %>/${vistitorSeeSubjectCommentsRespone.subjectEntity.faceimage}" style="border-radius:3px 3px 3px 3px;border: 1px solid #e5e5e5;width:200px;height:200px;">  <!-- style="width: 100%;" -->
		                  </td>
		                  <td><img src="<%=imgurl %>/${vistitorSeeSubjectCommentsRespone.subjectNewPartsVO.partImage1}" style="border-radius:3px 3px 3px 3px;border: 1px solid #e5e5e5;width:80px;height:95px;"></td>
		                </tr>
		                <tr>
		                  <td><img src="<%=imgurl %>/${vistitorSeeSubjectCommentsRespone.subjectNewPartsVO.partImage2}" style="border-radius:3px 3px 3px 3px;border: 1px solid #e5e5e5;width:80px;height:95px;"></td>
		                </tr>
		                <tr>
		                  <td><img src="<%=imgurl %>/${vistitorSeeSubjectCommentsRespone.subjectNewPartsVO.partImage3}" style="border-radius:3px 3px 3px 3px;border: 1px solid #e5e5e5;width:95px;height:90px;"></td>
		                  <td><img src="<%=imgurl %>/${vistitorSeeSubjectCommentsRespone.subjectNewPartsVO.partImage4}" style="border-radius:3px 3px 3px 3px;border: 1px solid #e5e5e5;width:95px;height:90px;"></td>
		                  <td><img src="<%=imgurl %>/${vistitorSeeSubjectCommentsRespone.subjectNewPartsVO.partImage5}" style="border-radius:3px 3px 3px 3px;border: 1px solid #e5e5e5;width:80px;height:90px;"></td>
		                </tr>
				      </table>
					</c:if>
					<div style="text-overflow:ellipsis; white-space:nowrap; overflow:hidden;">
					<span><strong><a href="<%=rootPath %>/vistiorShowSubjectDatail?target=${subjectEntity.id}">${vistitorSeeSubjectCommentsRespone.subjectEntity.name }</a></strong></span>
                    &nbsp;/&nbsp;<small class="muted">(<i class="icon-tags"></i>${vistitorSeeSubjectCommentsRespone.subjectEntity.tags })</small><br />
                    </div>
                    <div style="text-overflow:ellipsis; white-space:nowrap; overflow:hidden;">
                     <small>${vistitorSeeSubjectCommentsRespone.subjectEntity.info }</small>
                    </div>
                     <br />
		         </div>
		      </li>
		  </ul>
	   </div>
	   
	</div>
	
</div>

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


<%@ include file="../../../recordfootinclude.jsp"%>
</body>
</html>
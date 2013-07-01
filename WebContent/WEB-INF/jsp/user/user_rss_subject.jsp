<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
 <%@ include file="../../../headerinclude.jsp"%>
</head>
<body class="mxkbody mxkbackgroud">
<%@ include file="../public/user_page_header.jsp"%>
<%@ include file="../public/user_public_header.jsp"%>
<script type="text/javascript">
   
   var userid = '${uservo.id}';

  function mouseover(id){
    $("#"+id).css("z-index","1");
  }
  
  function mouseout(id){
	$("#"+id).css("z-index","-1");
  }
  
  function removeRss(subjectid){
		 var datas = {"removeRssSubjectRequest.userid":userid,"removeRssSubjectRequest.subjectid":subjectid};
		 $.ajax({
				url : path + "/removeRssSubject.action",
				type : "POST",
				cache : false,
				async : false,
				data: datas,
				dataType : "json",
				success : function(item) {
					if(item == 'success'){
						window.location.href= path + "/showUserRssSubject";
					}else{
						alert("网络连接异常！");
					}
				}
	    });
		
	}
  
</script>
<div class="container ">
		<div class="navbar">
			<div class="navbar-inner">
				<ul class="nav" >
					<li >
					<a href="#">&nbsp;<i class="icon-hdd"></i>我的专辑&nbsp;</a>
					</li>
					<li class="divider-vertical"></li>
					<li>
					<a href="#">&nbsp;<i class="icon-rss"></i>我的关注&nbsp;</a>
					</li>
					<li class="divider-vertical"></li>
					<li>
					<a href="<%=rootPath%>/userCollectIndex">&nbsp;<i class="icon-pushpin"></i>我的收藏&nbsp;</a>
					</li>
					<li class="divider-vertical"></li>
				</ul>
				<span class="pull-right">
				    <div class="btn-group" >
					  <a href="<%=rootPath %>/showUserRssSubject" class="active btn" style="font-family:Microsoft YaHei;"><i class="icon-rss"></i>我的订阅${uservo.rsssubject }</a>
					  <a href="<%=rootPath %>/showUserJoinSubject" class=" btn" style="font-family:Microsoft YaHei;"><i class="icon-external-link"></i>我参与的${uservo.joinsubject }</a>
			          <a href="<%=rootPath%>/userOnMessage" class="btn" style="font-family:Microsoft YaHei;"><i class="icon-envelope-alt"></i>我的消息${uservo.message }</a>
	                </div>
                </span>
			</div>
		</div>
	</div>
<c:if test="${empty subjectsShowResponse }">
 <div class="container">
  <div class="alert alert-block">
     <a class="close" data-dismiss="alert">×</a>
     <h4 class="alert-heading">你还没有订阅专辑!</h4>
                            现在就去看看
   </div>
  </div>
</c:if>
<c:if test="${!empty subjectsShowResponse}">
 <div class="container">
	      <div class="row">
	      
			<div class="span3">
				<ul class="thumbnails" id="partshow1">
				    <c:forEach var="options" items="${subjectsShowResponse.list1 }">
					  <li class="span3 mxkplan mxkshadow">
						<div class="thumbnail">
						   <div style="position:relative;" onmouseover="mouseover('${options.id }')" onmouseout="mouseout('${options.id }')" >
						       <span style="position:absolute; z-index:-1; opacity: 0.8;" id="${options.id }">
						            <a class="btn btn-mini btn-danger" href="javascript:;" onclick="removeRss('${options.id}')">
						               <i class="icon-remove-circle"></i>取消
						            </a>
						            <c:if test="${options.type == 'FOR-ALL'}">
							            <br />
						                <span class="label label-important"><small><i class="icon-group "></i>${options.joinpeople }人参与</small></span>
							         </c:if>
						       </span>
						       	<a href="<%=rootPath %>/vistiorShowSubjectDatail?target=${options.id}"><img src="<%=imgurl %>${options.faceimage}" /></a>
						   </div>
							<span class="muted"><small><strong>${options.name }</strong></small></span><br />
							<span class="muted"><small>${options.info }</small></span><br />
							    <span class="pull-right muted">
							        <small>
							         <i class="icon-comment"></i>评论${options.comments }
							         <i class="icon-pushpin"></i>Parts${options.parts }
							         <c:if test="${options.type == 'PUBLIC'}">
							           <span class="label label-success">公开</span>
							         </c:if>
							         <c:if test="${options.type == 'FOR-ALL'}">
							           <span class="label label-warning">共享</span>
							         </c:if>
								    </small>
							    </span>
						    <br />
						</div>
				      </li>
				    </c:forEach>
				</ul>
			</div> 
			
			<div class="span3">
				<ul class="thumbnails" id="partshow2">
					  <c:forEach var="options" items="${subjectsShowResponse.list2 }">
					   <li class="span3 mxkplan mxkshadow">
						<div class="thumbnail">
						   <div style="position:relative;" onmouseover="mouseover('${options.id }')" onmouseout="mouseout('${options.id }')" >
						       <span style="position:absolute; z-index:-1; opacity: 0.8;" id="${options.id }">
						             <a class="btn btn-mini btn-danger" href="javascript:;" onclick="removeRss('${options.id}')">
						               <i class="icon-remove-circle"></i>取消
						            </a>
						             <c:if test="${options.type == 'FOR-ALL'}">
							            <br />
						                <span class="label label-important"><small><i class="icon-group "></i>${options.joinpeople }人参与</small></span>
							         </c:if>
						       </span>
						       		<a href="<%=rootPath %>/vistiorShowSubjectDatail?target=${options.id}"><img src="<%=imgurl %>${options.faceimage}" /></a>
						   </div>
							<span class="muted"><small><strong>${options.name }</strong></small></span><br />
							<span class="muted"><small>${options.info }</small></span><br />
							    <span class="pull-right muted">
							        <small>
							         <i class="icon-comment"></i>评论${options.comments }
							         <i class="icon-pushpin"></i>Parts${options.parts }
							         <c:if test="${options.type == 'PUBLIC'}">
							           <span class="label label-success">公开</span>
							         </c:if>
							         <c:if test="${options.type == 'FOR-ALL'}">
							           <span class="label label-warning">共享</span>
							         </c:if>
								    </small>
							    </span>
						    <br />
						</div>
				      </li>
				    </c:forEach>
				</ul>
			</div> 
			
			<div class="span3">
				<ul class="thumbnails" id="partshow3">
					  <c:forEach var="options" items="${subjectsShowResponse.list3 }">
					   <li class="span3 mxkplan mxkshadow">
						<div class="thumbnail">
						   <div style="position:relative;" onmouseover="mouseover('${options.id }')" onmouseout="mouseout('${options.id }')" >
						       <span style="position:absolute; z-index:-1; opacity: 0.8;" id="${options.id }">
						           <a class="btn btn-mini btn-danger" href="javascript:;" onclick="removeRss('${options.id}')">
						               <i class="icon-remove-circle"></i>取消
						            </a>
						             <c:if test="${options.type == 'FOR-ALL'}">
							            <br />
						                <span class="label label-important"><small><i class="icon-group "></i>${options.joinpeople }人参与</small></span>
							         </c:if>
						       </span>
						       		<a href="<%=rootPath %>/vistiorShowSubjectDatail?target=${options.id}"><img src="<%=imgurl %>${options.faceimage}" /></a>
						   </div>
							<span class="muted"><small><strong>${options.name }</strong></small></span><br />
							<span class="muted"><small>${options.info }</small></span><br />
							    <span class="pull-right muted">
							        <small>
							         <i class="icon-comment"></i>评论${options.comments }
							         <i class="icon-pushpin"></i>Parts${options.parts }
							         <c:if test="${options.type == 'PUBLIC'}">
							           <span class="label label-success">公开</span>
							         </c:if>
							         <c:if test="${options.type == 'FOR-ALL'}">
							           <span class="label label-warning">共享</span>
							         </c:if>
								    </small>
							    </span>
						    <br />
						</div>
				      </li>
				    </c:forEach>
				</ul>
			</div> 
			
			<div class="span3">
				<ul class="thumbnails" id="partshow4">
					  <c:forEach var="options" items="${subjectsShowResponse.list4 }">
					   <li class="span3 mxkplan mxkshadow">
						<div class="thumbnail">
						   <div style="position:relative;" onmouseover="mouseover('${options.id }')" onmouseout="mouseout('${options.id }')" >
						       <span style="position:absolute; z-index:-1; opacity: 0.8;" id="${options.id }">
						             <a class="btn btn-mini btn-danger" href="javascript:;" onclick="removeRss('${options.id}')">
						               <i class="icon-remove-circle"></i>取消
						            </a>
						             <c:if test="${options.type == 'FOR-ALL'}">
							            <br />
						                <span class="label label-important"><small><i class="icon-group "></i>${options.joinpeople }人参与</small></span>
							         </c:if>
						       </span>
						       		<a href="<%=rootPath %>/vistiorShowSubjectDatail?target=${options.id}"><img src="<%=imgurl %>${options.faceimage}" /></a>
						   </div>
							<span class="muted"><small><strong>${options.name }</strong></small></span><br />
							<span class="muted"><small>${options.info }</small></span><br />
							    <span class="pull-right muted">
							        <small>
							         <i class="icon-comment"></i>评论${options.comments }
							         <i class="icon-pushpin"></i>Parts${options.parts }
							         <c:if test="${options.type == 'PUBLIC'}">
							           <span class="label label-success">公开</span>
							         </c:if>
							         <c:if test="${options.type == 'FOR-ALL'}">
							           <span class="label label-warning">共享</span>
							         </c:if>
								    </small>
							    </span>
						    <br />
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

<%@ include file="../../../footinclude.jsp"%>
</body>
</html>
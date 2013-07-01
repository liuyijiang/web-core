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
  function mouseover(id){
    $("#"+id).css("z-index","1");
  }
  
  function mouseout(id){
	$("#"+id).css("z-index","-1");
  }
  
</script>
<div class="container ">
		<div class="navbar">
			<div class="navbar-inner">
				<ul class="nav" >
					<li>
					<a href="<%=rootPath%>/userIndex">&nbsp;<i class="icon-hdd"></i>我的专辑&nbsp;</a>
					</li>
					<li class="divider-vertical"></li>
					<li class="active">
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
					  <a href="<%=rootPath %>/showUserRssSubject" class="btn" style="font-family:Microsoft YaHei;"><i class="icon-rss"></i>我的订阅${uservo.rsssubject }</a>
					  <a href="<%=rootPath %>/showUserJoinSubject" class="btn" style="font-family:Microsoft YaHei;"><i class="icon-external-link"></i>我参与的${uservo.joinsubject }</a>
			          <a href="<%=rootPath%>/userOnMessage" class="btn" style="font-family:Microsoft YaHei;"><i class="icon-envelope-alt"></i>我的消息${uservo.message }</a>
	                </div>
                </span>
			</div>
		</div>
	</div>
<c:if test="${empty partShowResponse }">
   <div class="container">
	  <div class="alert alert-block">
	     <a class="close" data-dismiss="alert">×</a>
	     <h4 class="alert-heading">你还没有关注什么新鲜事</h4>
	                            现在就去关注好友订阅专题吧
	   </div>
  </div>
</c:if>
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
						            <a class="btn btn-mini btn-danger" href="javascript:;" onclick="collectPart('${options.id}')">
						               <i class="icon-pushpin"></i>收藏
						            </a>
                                    <a class="btn btn-mini" href="<%=rootPath %>/visitorShowPartDetail?target=${options.id}">
                                       <i class="icon-comment"></i>评论
                                    </a>
						       </span>
						       	<a href="<%=rootPath %>/visitorShowPartDetail?target=${options.id}"><img src="<%=imgurl %>${options.minimage}" /></a>
						   </div>
							<span class="muted"><small>${options.desc }</small></span><br />
							<span class="text-info"><small><a href="<%=rootPath %>/vistiorShowSubjectDatail?target=${options.subjectid}">《${options.subname }》</a></small></span><br />
							    <span class="pull-right muted">
							        <small>
								    <i class="icon-comment"></i>评论${options.comments }
								    <i class="icon-pushpin"></i>收藏${options.collect }
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
					  <c:forEach var="options" items="${partShowResponse.list2 }">
					  <li class="span3 mxkplan mxkshadow">
						<div class="thumbnail">
						   <div style="position:relative;" onmouseover="mouseover('${options.id }')" onmouseout="mouseout('${options.id }')" >
						       <span style="position:absolute; z-index:-1; opacity: 0.8;" id="${options.id }">
						            <a class="btn btn-mini btn-danger" href="javascript:;" onclick="collectPart('${options.id}')">
						               <i class="icon-pushpin"></i>收藏
						            </a>
                                    <a class="btn btn-mini" href="<%=rootPath %>/visitorShowPartDetail?target=${options.id}">
                                       <i class="icon-comment"></i>评论
                                    </a>
						       </span>
						       	<a href="<%=rootPath %>/visitorShowPartDetail?target=${options.id}"><img src="<%=imgurl %>${options.minimage}" /></a>
						   </div>
							<span class="muted"><small>${options.desc }</small></span><br />
							<span class="text-info"><small><a href="<%=rootPath %>/vistiorShowSubjectDatail?target=${options.subjectid}">《${options.subname }》</a></small></span><br />
							    <span class="pull-right muted">
							       <small>
								    <i class="icon-comment"></i>评论${options.comments }
								    <i class="icon-pushpin"></i>收藏${options.collect }
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
					  <c:forEach var="options" items="${partShowResponse.list3 }">
					  <li class="span3 mxkplan mxkshadow">
						<div class="thumbnail">
						   <div style="position:relative;" onmouseover="mouseover('${options.id }')" onmouseout="mouseout('${options.id }')" >
						       <span style="position:absolute; z-index:-1; opacity: 0.8;" id="${options.id }">
						           <a class="btn btn-mini btn-danger" href="javascript:;" onclick="collectPart('${options.id}')">
						               <i class="icon-pushpin"></i>收藏
						            </a>
                                    <a class="btn btn-mini" href="<%=rootPath %>/visitorShowPartDetail?target=${options.id}">
                                       <i class="icon-comment"></i>评论
                                    </a>
						       </span>
						       	<a href="<%=rootPath %>/visitorShowPartDetail?target=${options.id}"><img src="<%=imgurl %>${options.minimage}" /></a>
						   </div>
							<span class="muted"><small>${options.desc }</small></span><br />
							<span class="text-info"><small><a href="<%=rootPath %>/vistiorShowSubjectDatail?target=${options.subjectid}">《${options.subname }》</a></small></span><br />
							    <span class="pull-right muted">
							        <small>
									    <i class="icon-comment"></i>评论${options.comments }
									    <i class="icon-pushpin"></i>收藏${options.collect }
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
					  <c:forEach var="options" items="${partShowResponse.list4 }">
					  <li class="span3 mxkplan mxkshadow">
						<div class="thumbnail">
						   <div style="position:relative;" onmouseover="mouseover('${options.id }')" onmouseout="mouseout('${options.id }')" >
						       <span style="position:absolute; z-index:-1; opacity: 0.8;" id="${options.id }">
						            <a class="btn btn-mini btn-danger" href="javascript:;" onclick="collectPart('${options.id}')">
						               <i class="icon-pushpin"></i>收藏
						            </a>
                                   <a class="btn btn-mini" href="<%=rootPath %>/visitorShowPartDetail?target=${options.id}">
                                       <i class="icon-comment"></i>评论
                                    </a>
						       </span>
						       	<a href="<%=rootPath %>/visitorShowPartDetail?target=${options.id}" ><img src="<%=imgurl %>${options.minimage}" /></a>
						   </div>
							<span class="muted"><small>${options.desc }</small></span><br />
							<span class="text-info"><small><a href="<%=rootPath %>/vistiorShowSubjectDatail?target=${options.subjectid}">《${options.subname }》</a></small></span><br />
							    <span class="pull-right muted">
							        <small>
									    <i class="icon-comment"></i>评论${options.comments }
									    <i class="icon-pushpin"></i>收藏${options.collect }
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
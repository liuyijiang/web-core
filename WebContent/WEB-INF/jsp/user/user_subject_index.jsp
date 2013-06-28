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
					<li class="active">
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
                   <a href="<%=rootPath%>/userOnMessage" class="btn" ><i class="icon-envelope-alt"></i>我的消息${uservo.message }</a>
                </span>
			</div>
		</div>
	</div>
 <div class="container">
   <c:if test="${!empty subjectsShowResponse }">
	      <div class="row">
			<div class="span3">
				<ul class="thumbnails" id="planshow1">
				      <c:forEach var="options" items="${subjectsShowResponse.list1 }">
				         <li class="span3 mxkplan mxkshadow">
				           <div class="thumbnail">
				               <div style="position:relative;" onmouseover="mouseover('${options.id }')" onmouseout="mouseout('${options.id }')" >
						       <span style="position:absolute; z-index:-1; opacity: 0.8;" id="${options.id }">
						            <c:if test="${options.type == 'PUBLIC'}">
							           <span class="label label-success">公开</span>
							         </c:if>
							         <c:if test="${options.type == 'FOR-ALL'}">
							           <span class="label label-warning">共享</span>
							         </c:if>
						             <c:if test="${options.type == 'PRIVATE'}">
							           <span class="label label-important">私有</span>
							         </c:if>
						       </span>
						        <a href="cachSubject?subid=${options.id }"><img src="<%=imgurl %>${options.faceimage }" /></a>
						      </div>
				              <div class="mxkomitdiv"><small>${options.name }</small></div>
				              <span class="muted"><small>${options.info }</small></span><br />
				               <a class="btn btn-block" href="cachSubject?subid=${options.id }"><i class="icon-edit"></i>继续编辑</a>
				           </div>
				         </li>
				      </c:forEach>
				</ul>
			</div> 
			
			<div class="span3 ">
				<ul class="thumbnails" id="planshow2">
					 <c:forEach var="options" items="${subjectsShowResponse.list2 }">
				         <li class="span3 mxkplan mxkshadow">
				           <div class="thumbnail">
				               <div style="position:relative;" onmouseover="mouseover('${options.id }')" onmouseout="mouseout('${options.id }')" >
						       <span style="position:absolute; z-index:-1; opacity: 0.8;" id="${options.id }">
						            <c:if test="${options.type == 'PUBLIC'}">
							           <span class="label label-success">公开</span>
							         </c:if>
							         <c:if test="${options.type == 'FOR-ALL'}">
							           <span class="label label-warning">共享</span>
							         </c:if>
						             <c:if test="${options.type == 'PRIVATE'}">
							           <span class="label label-important">私有</span>
							         </c:if>
						       </span>
						        <a href="cachSubject?subid=${options.id }"><img src="<%=imgurl %>${options.faceimage }" /></a>
						      </div>
				              <div class="mxkomitdiv"><small>${options.name }</small></div>
				              <span class="muted"><small>${options.info }</small></span><br />
				               <a class="btn btn-block" href="cachSubject?subid=${options.id }"><i class="icon-edit"></i>继续编辑</a>
				           </div>
				         </li>
				      </c:forEach>
				</ul>
			</div> 
			
			<div class="span3">
				<ul class="thumbnails" id="planshow3">
					<c:forEach var="options" items="${subjectsShowResponse.list3 }">
				        <li class="span3 mxkplan mxkshadow">
				           <div class="thumbnail">
				               <div style="position:relative;" onmouseover="mouseover('${options.id }')" onmouseout="mouseout('${options.id }')" >
						       <span style="position:absolute; z-index:-1; opacity: 0.8;" id="${options.id }">
						            <c:if test="${options.type == 'PUBLIC'}">
							           <span class="label label-success">公开</span>
							         </c:if>
							         <c:if test="${options.type == 'FOR-ALL'}">
							           <span class="label label-warning">共享</span>
							         </c:if>
						             <c:if test="${options.type == 'PRIVATE'}">
							           <span class="label label-important">私有</span>
							         </c:if>
						       </span>
						        <a href="cachSubject?subid=${options.id }"><img src="<%=imgurl %>${options.faceimage }" /></a>
						      </div>
				              <div class="mxkomitdiv"><small>${options.name }</small></div>
				              <span class="muted"><small>${options.info }</small></span><br />
				               <a class="btn btn-block" href="cachSubject?subid=${options.id }"><i class="icon-edit"></i>继续编辑</a>
				           </div>
				         </li>
				      </c:forEach>
				</ul>
			</div> 
			
			<div class="span3">
				<ul class="thumbnails" id="planshow4">
					<c:forEach var="options" items="${subjectsShowResponse.list4 }">
				         <li class="span3 mxkplan mxkshadow">
				           <div class="thumbnail">
				               <div style="position:relative;" onmouseover="mouseover('${options.id }')" onmouseout="mouseout('${options.id }')" >
						       <span style="position:absolute; z-index:-1; opacity: 0.8;" id="${options.id }">
						            <c:if test="${options.type == 'PUBLIC'}">
							           <span class="label label-success">公开</span>
							         </c:if>
							         <c:if test="${options.type == 'FOR-ALL'}">
							           <span class="label label-warning">共享</span>
							         </c:if>
						             <c:if test="${options.type == 'PRIVATE'}">
							           <span class="label label-important">私有</span>
							         </c:if>
						       </span>
						        <a href="cachSubject?subid=${options.id }"><img src="<%=imgurl %>${options.faceimage }" /></a>
						      </div>
				              <div class="mxkomitdiv"><small>${options.name }</small></div>
				              <span class="muted"><small>${options.info }</small></span><br />
				               <a class="btn btn-block" href="cachSubject?subid=${options.id }"><i class="icon-edit"></i>继续编辑</a>
				           </div>
				         </li>
				      </c:forEach>
				</ul>
			</div> 
			
         </div>
          </c:if>
     </div>

<%@ include file="../../../footinclude.jsp"%>
</body>
</html>
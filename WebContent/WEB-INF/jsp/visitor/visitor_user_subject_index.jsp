<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="../../../headerinclude.jsp"%>
</head>
<body class="mxkbody mxkbackgroud">
<%@ include file="../public/user_page_header.jsp"%>
<%@ include file="../public/visitor_user_public_header.jsp"%> 
<div class="container ">
		<div class="navbar">
			<div class="navbar-inner">
				<ul class="nav" >
				    <li>
					<a href="<%=rootPath%>/visitorSeeUserShareSingleParts?target=${targetUserVO.id}">&nbsp;<i class="icon-rss-sign"></i>单图分享</a>
					</li>
					<li class="divider-vertical"></li>
					<li class="active">
					<a href="#">&nbsp;<i class="icon-hdd"></i>他的专辑&nbsp;</a>
					</li>
					<li class="divider-vertical"></li>
				</ul>
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
						            <a class="btn btn-small  btn-primary" href="javascript:;" >
						               <i class="icon-rss"></i>订阅
						            </a>
						       </span>
				              <a href="vistiorShowSubjectDatail?target=${options.id }"><img src="<%=imgurl %>${options.faceimage }" /></a>
				              </div>
				              <div class="mxkomitdiv">${options.name }</div>
				              <span class="muted"><small>${options.info }</small></span><br />
				               <a class="btn btn-block" href="vistiorShowSubjectDatail?target=${options.id }"><i class="icon-th"></i>查看详情</a>
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
						            <a class="btn btn-small  btn-primary" href="javascript:;" >
						               <i class="icon-rss"></i>订阅
						            </a>
						       </span>
				              <a href="vistiorShowSubjectDatail?target=${options.id }"><img src="<%=imgurl %>${options.faceimage }" /></a>
				              </div>
				              <div class="mxkomitdiv">${options.name }</div>
				              <span class="muted"><small>${options.info }</small></span><br />
				               <a class="btn btn-block" href="vistiorShowSubjectDatail?target=${options.id }"><i class="icon-th"></i>查看详情</a>
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
						            <a class="btn btn-small  btn-primary" href="javascript:;" >
						               <i class="icon-rss"></i>订阅
						            </a>
						       </span>
				              <a href="vistiorShowSubjectDatail?target=${options.id }"><img src="<%=imgurl %>${options.faceimage }" /></a>
				              </div>
				              <div class="mxkomitdiv">${options.name }</div>
				              <span class="muted"><small>${options.info }</small></span><br />
				               <a class="btn btn-block" href="vistiorShowSubjectDatail?target=${options.id }"><i class="icon-th"></i>查看详情</a>
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
						            <a class="btn btn-small  btn-primary" href="javascript:;" >
						               <i class="icon-rss"></i>订阅
						            </a>
						       </span>
				              <a href="vistiorShowSubjectDatail?target=${options.id }"><img src="<%=imgurl %>${options.faceimage }" /></a>
				              </div>
				              <div class="mxkomitdiv">${options.name }</div>
				              <span class="muted"><small>${options.info }</small></span><br />
				               <a class="btn btn-block" href="vistiorShowSubjectDatail?target=${options.id }"><i class="icon-th"></i>查看详情</a>
				           </div>
				         </li>
				      </c:forEach>
				</ul>
			</div> 
			
         </div>
          </c:if>
     </div>

<%@ include file="../../../footinclude.jsp"%>
<script type="text/javascript">

  function mouseover(id){
    $("#"+id).css("z-index","1");
  }
  
  function mouseout(id){
	$("#"+id).css("z-index","-1");
  }

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
  
</script>
</body>
</html>
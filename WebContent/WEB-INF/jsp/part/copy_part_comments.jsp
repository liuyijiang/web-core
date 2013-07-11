<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
 <%@ include file="../../../headerinclude.jsp"%>
</head>

<body class="mxkbody mxkbackgroud" >
<%@ include file="../public/user_page_header.jsp"%>
<%@ include file="../../../footinclude.jsp"%>
<script type="text/javascript">
  
function mouseover(id){
    $("#"+id).css("z-index","1");
  }
  
  function mouseout(id){
	$("#"+id).css("z-index","-1");
  }

</script>
<div class="container">
  <div class="row">
     <div class="span1">
        <img class="img-polaroid border-radius" style="height:60px;width:60px" 
        src="<%=imgurl %>${partEntity.minimage }" >
     </div>
     <div class="span11">
        <span style="font-size:20px;">
           <strong>From:<span>
             <a href="<%=rootPath%>/userIndex">${uservo.name }</a>
           </span>/<span>
           ${partEntity.subname }</span></strong><span class="muted"><small>(<i class="icon-tags"></i>${currentSubjectEntity.tags }-${currentSubjectEntity.category})</small></span>
           </span>
        <span class="pull-right">
            <a href="javascript:;" class="btn" onclick="showCreatePart()">
               <i class="icon-list"></i>Parts详情
            </a>
            <a class="btn btn btn-info" href="javascript:;" onclick="showCreateMaterial()">
              <i class="icon-comment-alt"></i>发布评论
            </a>
         </span><br />
        <span>${partEntity.desc }</span><br />
        <span><i class="icon-time"></i>Create Time:${partEntity.createTime }</span>
        <span class="pull-right">
           <div class="btn-group">
              <a class="btn dropdown-toggle btn-mini " data-toggle="dropdown" href="<%=rootPath %>/visitiorShowSubjectComements?target=${subjectEntity.id}&type=text">
                 <i class="icon-comments-alt"></i>过滤评论
                 <span class="caret"></span>
		      </a>
		     <ul class="dropdown-menu">
			       <li><a href="#"><i class="icon-comment-alt"></i>文字评论</a></li>
				   <li><a href="#"><i class="icon-microphone"></i>音评评论</a></li>
             </ul>
		   </div>
        </span>
     </div>
   </div>
   <br />
   <div style='width:100%; border-top:1px solid #cccccc'></div>
</div>     
<br />
<!--  -->
<div class="container">
    <div class="row">
	      
		<div class="span3">
			 <ul class="thumbnails" id="partshow1">
			   <c:forEach var="options" items="${loadCommentsRespone.list1 }">
				   <li class="span3 mxkplan mxkshadow">
							<div class="thumbnail">
							   <div style="position:relative;" onmouseover="mouseover('${options.id}')" onmouseout="mouseout('${options.id}')" >
							       <span style="position:absolute; z-index:-1; opacity: 0.8;" id="${options.id}">
							            <a class="btn btn-mini btn-danger" href="javascript:;" onclick="">
							               <i class="icon-pushpin"></i>删除
							            </a>
	                                    <a class="btn btn-mini" href="javascript:;">
	                                       <i class="icon-comment"></i>回复
	                                    </a>
							       </span>
							       <a href="<%=rootPath %>/visitorShowPartDetail?target=${options.id}">
							          <img src="<%=imgurl %>${options.userimage}" />
							       </a>
							   </div>
							    <span><a href="#">${options.username }</a>&nbsp;<span class='muted'><small>评论:</small></span></span><br />
								<span class="muted"><small>${options.info }发哇我发啊发我发我福娃我发发我</small></span><br />
								<span class="muted"><small><i class="icon-time"></i>${options.createTime }</small></span><br />
							</div>
					      </li>
				   </c:forEach>
			    </ul>
			</div>
			
			<div class="span3">
			   <ul class="thumbnails" id="partshow2">
			   <c:forEach var="options" items="${loadCommentsRespone.list2 }">
				   <li class="span3 mxkplan mxkshadow">
							<div class="thumbnail">
							   <div style="position:relative;" onmouseover="mouseover('${options.id}')" onmouseout="mouseout('${options.id}')" >
							       <span style="position:absolute; z-index:-1; opacity: 0.8;" id="${options.id}">
							            <a class="btn btn-mini btn-danger" href="javascript:;" onclick="">
							               <i class="icon-pushpin"></i>删除
							            </a>
	                                    <a class="btn btn-mini" href="javascript:;">
	                                       <i class="icon-comment"></i>回复
	                                    </a>
							       </span>
							       <a href="<%=rootPath %>/visitorShowPartDetail?target=${options.id}">
							          <img src="<%=imgurl %>${options.userimage}" />
							       </a>
							   </div>
							    <span><a href="#">${options.username }</a>&nbsp;<span class='muted'><small>评论:</small></span></span><br />
								<span class="muted"><small>${options.info }发哇我发啊发我发我福娃我发发我</small></span><br />
								<span class="muted"><small><i class="icon-time"></i>${options.createTime }</small></span><br />
							</div>
					      </li>
				   </c:forEach>
			    </ul>
			</div>
			
			<div class="span3">
			 <ul class="thumbnails" id="partshow1">
			   <c:forEach var="options" items="${loadCommentsRespone.list1 }">
				   <li class="span3 mxkplan mxkshadow">
							<div class="thumbnail">
							   <div style="position:relative;" onmouseover="mouseover('${options.id}')" onmouseout="mouseout('${options.id}')" >
							       <span style="position:absolute; z-index:-1; opacity: 0.8;" id="${options.id}">
							            <a class="btn btn-mini btn-danger" href="javascript:;" onclick="">
							               <i class="icon-pushpin"></i>删除
							            </a>
	                                    <a class="btn btn-mini" href="javascript:;">
	                                       <i class="icon-comment"></i>回复
	                                    </a>
							       </span>
							       <a href="<%=rootPath %>/visitorShowPartDetail?target=${options.id}">
							          <img src="<%=imgurl %>${options.userimage}" />
							       </a>
							   </div>
							    <span><a href="#">${options.username }</a>&nbsp;<span class='muted'><small>评论:</small></span></span><br />
								<span class="muted"><small>${options.info }发哇我发啊发我发我福娃我发发我</small></span><br />
								<span class="muted"><small><i class="icon-time"></i>${options.createTime }</small></span><br />
							</div>
					      </li>
				   </c:forEach>
			    </ul>
			</div>
			
			<div class="span3">
			 <ul class="thumbnails" id="partshow1">
			   <c:forEach var="options" items="${loadCommentsRespone.list1 }">
				   <li class="span3 mxkplan mxkshadow">
							<div class="thumbnail">
							   <div style="position:relative;" onmouseover="mouseover('${options.id}')" onmouseout="mouseout('${options.id}')" >
							       <span style="position:absolute; z-index:-1; opacity: 0.8;" id="${options.id}">
							            <a class="btn btn-mini btn-danger" href="javascript:;" onclick="">
							               <i class="icon-pushpin"></i>删除
							            </a>
	                                    <a class="btn btn-mini" href="javascript:;">
	                                       <i class="icon-comment"></i>回复
	                                    </a>
							       </span>
							       <a href="<%=rootPath %>/visitorShowPartDetail?target=${options.id}">
							          <img src="<%=imgurl %>${options.userimage}" />
							       </a>
							   </div>
							    <span><a href="#">${options.username }</a>&nbsp;<span class='muted'><small>评论:</small></span></span><br />
								<span class="muted"><small>${options.info }发哇我发啊发我发我福娃我发发我</small></span><br />
								<span class="muted"><small><i class="icon-time"></i>${options.createTime }</small></span><br />
							</div>
					      </li>
				   </c:forEach>
			    </ul>
			</div>
			
			
    </div>
</div>
</body>
<%@ include file="../../../recordfootinclude.jsp"%>
</html>
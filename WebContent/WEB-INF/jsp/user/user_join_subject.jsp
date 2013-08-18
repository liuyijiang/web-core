<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
 <%@ include file="../../../headerinclude.jsp"%>
</head>
<body class="mxkbody mxkbackgroud" onload="bindScroll()">
<%@ include file="../public/user_page_header.jsp"%>
<%@ include file="../public/update_user_public_header.jsp"%>
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
					<a href="<%=rootPath%>/userSharePartsIndex">&nbsp;<i class="icon-rss-sign"></i>单图分享</a>
					</li>
					<li >
					<a href="<%=rootPath%>/userIndex">&nbsp;<i class="icon-hdd"></i>我的专辑&nbsp;</a>
					</li>
					<li class="divider-vertical"></li>
					<li>
					<a href="<%=rootPath%>/showNewRssMessage">&nbsp;<i class="icon-rss"></i>我的关注&nbsp;</a>
					</li>
					<li class="divider-vertical"></li>
					<li>
					<a href="<%=rootPath%>/userCollectIndex">&nbsp;<i class="icon-pushpin"></i>我的收藏&nbsp;</a>
					</li>
					<li class="divider-vertical"></li>
				</ul>
				<span class="pull-right">
				    <div class="btn-group" >
					  <a href="<%=rootPath %>/showUserRssSubject" class=" btn" style="font-family:Microsoft YaHei;"><i class="icon-rss"></i>我的订阅${uservo.rsssubject }</a>
					  <a href="<%=rootPath %>/showUserJoinSubject" class="active btn" style="font-family:Microsoft YaHei;"><i class="icon-external-link"></i>我参与的${uservo.joinsubject }</a>
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
     <h4 class="alert-heading">你还没参与专辑发布!</h4>
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
						            <a class="btn btn-mini btn-primary" href="javascript:;" onclick="rsssubject('${options.id}','${options.userid }')">
						               <i class="icon-rss"></i>订阅
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
						            <a class="btn btn-mini btn-primary" href="javascript:;" onclick="rsssubject('${options.id}','${options.userid }')">
						               <i class="icon-rss"></i>订阅
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
						            <a class="btn btn-mini btn-primary" href="javascript:;" onclick="rsssubject('${options.id}','${options.userid }')">
						               <i class="icon-rss"></i>订阅
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
						            <a class="btn btn-mini btn-primary" href="javascript:;" onclick="rsssubject('${options.id}','${options.userid }')">
						               <i class="icon-rss"></i>订阅
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
             <img src="<%=domain %>loadingred.gif" >
             <span class="muted"><small>正在努力加载...</small></span>
          </div>
     </div>
 </c:if> 
 <%@ include file="../../../footinclude.jsp"%>   
<script type="text/javascript">

var page = 2;
var isrun = false;
var allpage = '${subjectsShowResponse.allpage}';
var userid = '${uservo.id}';

function loadMore(){
    if(page <= allpage){
  	  var datas = {"searchUserJoinSubjectRequest.page":page,"searchUserJoinSubjectRequest.userid":userid};
	   $('#loaddiv').show();
	   $.ajax({
	   		url : path + "/loadMoreUserJoinSubject.action",
	   		type : "POST",
	   		cache : false,
	   		async : false,
	   		data: datas,
	   		dataType : "json",
	   		success : function(item) {
	   			$('#loaddiv').hide();
	 			page = page + 1;
	 			var list1 = item.list1;
				var list2 = item.list2;
				var list3 = item.list3;
				var list4 = item.list4;
				if(list1 != null){
					createSubjectPlane(list1,"partshow1");
				}
				if(list2 != null){
					createSubjectPlane(list2,"partshow2");
				}
				if(list3 != null){
					createSubjectPlane(list3,"partshow3");
				}
				if(list4 != null){
					createSubjectPlane(list4,"partshow4");
				}
				isrun = false;
	   		 }
	  }); 
	   
       }
  }

  function createSubjectPlane(list,subjectplanelist){
  	var show = '';
  	for (var i in list) {
  		show = show + "<li class='span3 mxkplan mxkshadow'><div class='thumbnail'><div style='position:relative;' onmouseover='mouseover(\""+ list[i].id +"\")' onmouseout='mouseout(\""+ list[i].id +"\")' >" +
  		"<span style='position:absolute; z-index:-1; opacity: 0.8;' id='"+ list[i].id +"'><a class='btn btn-mini btn-primary' href='javascript:;' onclick='rsssubject(\""+ list[i].id +"\",\""+ list[i].userid  +"\")'>" +
  		"<i class='icon-rss'></i>订阅</a>";  
  		if(list[i].type == 'FOR-ALL'){
  			show = show + "<br /> <span class='label label-important'><small><i class='icon-group'></i>"+ list[i].joinpeople +"人参与</small></span>";
  		}
  		show = show + "</span><a href='"+ path +"/vistiorShowSubjectDatail?target="+ list[i].id +"'><img src='"+ imgurl + list[i].faceimage +"' /></a></div>" + 
  		"<span class='muted'><small><strong>"+ list[i].name +"</strong></small></span><br />" +
  		"<span class='muted'><small>"+ list[i].info +"</small></span><br />" +
  		"<span class='pull-right muted'><small><i class='icon-comment'></i>评论"+ list[i].comments +"<i class='icon-pushpin'></i>Parts"+ list[i].parts; 
  	   if(list[i].type == 'FOR-ALL'){
  		  show = show + "<span class='label label-warning'>共享</span>";
  	   }else{
  		  show = show + "<span class='label label-success'>公开</span>";
  	   }
  	     show = show + "</small></span><br /></div></li>";
  	}
  	$("#"+subjectplanelist).append(show);
  }
  
  
  function showload(){ 
	   var scrollh = document.documentElement.scrollHeight;
	   var scrollt = document.documentElement.scrollTop + document.body.scrollTop;
	   if ( scrollt/scrollh > 0.1 ) {
		     if(!isrun){
		    	 isrun = true; 
		    	 loadMore();  
		     }
	   }
	} 

	//绑定事件
	function bindScroll(){
	    $(window).bind("scroll", function(){ 
	       showload();
	    }); 
	}

</script>
</body>
</html>
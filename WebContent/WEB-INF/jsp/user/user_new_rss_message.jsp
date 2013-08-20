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
<div class="container ">
		<div class="navbar">
			<div class="navbar-inner">
				<ul class="nav" >
				    <li>
					<a href="<%=rootPath%>/userSharePartsIndex">&nbsp;<i class="icon-rss-sign"></i>单图分享</a>
					</li>
					<li class="divider-vertical"></li>
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
					  <li class="span3 mxkplan ${options.shadow }">
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
							<c:if test="${options.subjectid != '#' }">
							  <span class="text-info"><small><a href="<%=rootPath %>/vistiorShowSubjectDatail?target=${options.subjectid}">《${options.subname }》</a></small></span><br />
							</c:if>
							    <span class="label">${options.type }</span>
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
					  <li class="span3 mxkplan ${options.shadow }">
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
							<c:if test="${options.subjectid != '#' }">
							  <span class="text-info"><small><a href="<%=rootPath %>/vistiorShowSubjectDatail?target=${options.subjectid}">《${options.subname }》</a></small></span><br />
							</c:if>
							    <span class="label">${options.type }</span>
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
					  <li class="span3 mxkplan ${options.shadow }">
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
							<c:if test="${options.subjectid != '#' }">
							  <span class="text-info"><small><a href="<%=rootPath %>/vistiorShowSubjectDatail?target=${options.subjectid}">《${options.subname }》</a></small></span><br />
							</c:if>
							    <span class="label">${options.type }</span>
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
					  <li class="span3 mxkplan ${options.shadow }">
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
							<c:if test="${options.subjectid != '#' }">
							  <span class="text-info"><small><a href="<%=rootPath %>/vistiorShowSubjectDatail?target=${options.subjectid}">《${options.subname }》</a></small></span><br />
							</c:if>
							    <span class="label">${options.type }</span>
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
             <img src="<%=domain %>loadingred.gif" >
             <span class="muted"><small>正在努力加载...</small></span>
          </div>
     </div>
 </c:if>    
<script type="text/javascript">
   var page = 2;
   var isrun = false;
   var userid= '${uservo.id}';
   var allpage = '${partShowResponse.allPage}';
   
   function loadMore(){
		  if(page <= allpage){
	   	  var datas = {"searchPartRequest.page":page,"searchPartRequest.userid":userid};
	      $('#loaddiv').show();
		  $.ajax({
		   		url : path + "/loadMoreNewRssMessage.action",
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
						createPartPlane(list1,"partshow1");
					}
					if(list2 != null){
						createPartPlane(list2,"partshow2");
					}
					if(list3 != null){
						createPartPlane(list3,"partshow3");
					}
					if(list4 != null){
						createPartPlane(list4,"partshow4");
					}
					isrun = false;
		   		 }
		 	 }); 
	      }
	   }
   
   function createPartPlane(list,planeid){
	  show = '';
	  for(var i in list){
		  show = show + "<li class='span3 mxkplan "+ list[i].shadow +"'><div class='thumbnail'>"+
		  "<div style='position:relative;' onmouseover='mouseover(\""+ list[i].id  +"\")' onmouseout='mouseout(\""+ list[i].id  +"\")' >" +
		  "<span style='position:absolute; z-index:-1; opacity: 0.8;' id='"+ list[i].id +"'>" +
		  "<a class='btn btn-mini btn-danger' href='javascript:;' onclick='collectPart(\""+ list[i].id  +"\")'>" +
	      "<i class='icon-pushpin'></i>收藏 </a>&nbsp;" +
	      "<a class='btn btn-mini' href='" + path + "/visitorShowPartDetail?target="+ list[i].id +"'>" +
	      "<i class='icon-comment'></i>评论</a></span>" + 	
	      "<a href='"+ path +"/visitorShowPartDetail?target="+ list[i].id +"'><img src='"+ imgurl + list[i].minimage +"' /></a>" +
	      "</div><span class='muted'><small>"+ list[i].desc +"</small></span><br />"; 
		  if(list[i].subjectid != "#"){
			  show = show + "<span class='text-info'><small><a href='"+ path +"/vistiorShowSubjectDatail?target="+ list[i].subjectid +"'>《"+ list[i].subname +"》</a></small></span><br />";
		  }
		  show = show + "<span class='label'>"+ list[i].type +"</span><span class='pull-right muted'><small><i class='icon-comment'></i>评论"+ list[i].comments + "<i class='icon-pushpin'></i>收藏"+ list[i].collect +"</small>" +
	      "</span><br /></div></li>";
	  }
	  $("#"+planeid).append(show);
   }
   
   function showload(){ 
 	   var scrollh = document.documentElement.scrollHeight;
 	   var scrollt = document.documentElement.scrollTop + document.body.scrollTop;
 	   if ( scrollt/scrollh > 0.2 ) {
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
<%@ include file="../../../footinclude.jsp"%>
<script type="text/javascript">
  function mouseover(id){
    $("#"+id).css("z-index","1");
  }
  
  function mouseout(id){
	$("#"+id).css("z-index","-1");
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
</script>
</body>
</html>
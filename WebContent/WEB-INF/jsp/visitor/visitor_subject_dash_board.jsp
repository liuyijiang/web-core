<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="../../../headerinclude.jsp"%>
<body class="mxkbody  mxkbackgroud" onload="bindScroll()">
<%@ include file="../public/subject_dash_board_header.jsp"%>
<c:if test="${empty visitorSearchSubjectRespone.subjectsShowResponse }">
 <div class="container">
  <div class="alert alert-block">
     <a class="close" data-dismiss="alert">×</a>
     <h4 class="alert-heading">没有找到类似的专辑!</h4>
                            现在就去发布一个专辑
   </div>
  </div>
</c:if>
<c:if test="${!empty visitorSearchSubjectRespone.subjectsShowResponse}">
 <div class="container">
	      <div class="row">
	      
			<div class="span3">
				<ul class="thumbnails" id="partshow1">
				    <c:forEach var="options" items="${visitorSearchSubjectRespone.subjectsShowResponse.list1 }">
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
							<span class="muted"><small><strong>${options.name }</strong><span class="muted">(${options.category })</span></small></span><br />
							<span class="muted"><small>${options.info }</small></span><br />
							<span>
							  <img class="img-polaroid" src="<%=imgurl %>${options.userimage}" style="width:15px">
							  <a href="<%=rootPath%>/vistiorShowUserIndex?target=${options.userid}">${options.username }</a>
							</span><br />
							    <span class="label">${options.category }</span>
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
					  <c:forEach var="options" items="${visitorSearchSubjectRespone.subjectsShowResponse.list2 }">
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
							<span class="muted"><small><strong>${options.name }</strong><span class="muted">(${options.category })</span></small></span><br />
							<span class="muted"><small>${options.info }</small></span><br />
							<span>
							  <img class="img-polaroid" src="<%=imgurl %>${options.userimage}" style="width:15px">
							  <a href="<%=rootPath%>/vistiorShowUserIndex?target=${options.userid}">${options.username }</a>
							</span><br />    
							<span class="label">${options.category }</span>
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
					  <c:forEach var="options" items="${visitorSearchSubjectRespone.subjectsShowResponse.list3 }">
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
							<span class="muted"><small><strong>${options.name }</strong><span class="muted">(${options.category })</span></small></span><br />
							<span class="muted"><small>${options.info }</small></span><br />
							<span>
							  <img class="img-polaroid" src="<%=imgurl %>${options.userimage}" style="width:15px">
							  <a href="<%=rootPath%>/vistiorShowUserIndex?target=${options.userid}">${options.username }</a>
							</span><br />  
							<span class="label">${options.category }</span>
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
					  <c:forEach var="options" items="${visitorSearchSubjectRespone.subjectsShowResponse.list4 }">
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
							<span class="muted"><small><strong>${options.name }</strong><span class="muted">(${options.category })</span></small></span><br />
							<span class="muted"><small>${options.info }</small></span><br />
							<span>
							  <img class="img-polaroid" src="<%=imgurl %>${options.userimage}" style="width:15px">
							  <a href="<%=rootPath%>/vistiorShowUserIndex?target=${options.userid}">${options.username }</a>
							</span><br />  
							<span class="label">${options.category }</span> 
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
 <%@ include file="../public/public_page_footer.jsp"%> 
<%@ include file="../../../basefootinclude.jsp"%>
<script type="text/javascript">
  function mouseover(id){
    $("#"+id).css("z-index","1");
  }
  
  function mouseout(id){
	$("#"+id).css("z-index","-1");
  }
</script>
<script type="text/javascript">
   
    var allpage = '${visitorSearchSubjectRespone.allPage}';
    var page = 2;
    var isrun = false;
    var type = '${type}';
    
    function filterParts(){
    	  $("#partshow1").html('');
    	  $("#partshow2").html('');
    	  $("#partshow3").html('');
    	  $("#partshow4").html('');
    	  var datas = {"visitorSeeSubjectDashBoardRequest.page":1,"visitorSeeSubjectDashBoardRequest.tags":filtertype};
    	  $.ajax({
    	   		url : path + "/visitorFilterSubjectByType",
    	   		type : "POST",
    	   		cache : false,
    	   		async : false,
    	   		data: datas,
    	   		dataType : "json",
    	   		success : function(item) {
    	   			$('#loaddiv').hide();
    	   			page = 2;
    	 			allpage = item.allPage;
		 			var list1 = item.subjectsShowResponse.list1;
					var list2 = item.subjectsShowResponse.list2;
					var list3 = item.subjectsShowResponse.list3;
					var list4 = item.subjectsShowResponse.list4;
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
    	   		 }
    	 	 });  
    }
    
    
    function loadMore(){
      if(page <= allpage){
    	  var datas;
    	  if(filtertype != ''){
    		 datas = {"visitorSeeSubjectDashBoardRequest.type":type,"visitorSeeSubjectDashBoardRequest.page":page,"visitorSeeSubjectDashBoardRequest.tags":filtertype};
    	  }else{
    		 datas = {"visitorSeeSubjectDashBoardRequest.type":type,"visitorSeeSubjectDashBoardRequest.page":page};
    	  }
    	  if(searchparm != ''){
    		  datas = {"visitorSeeSubjectDashBoardRequest.page":page,"visitorSeeSubjectDashBoardRequest.parm":searchparm};
    	  }
	      $('#loaddiv').show();
		  $.ajax({
		   		url : path + "/visitorLoadMoreSubject",
		   		type : "POST",
		   		cache : false,
		   		async : false,
		   		data: datas,
		   		dataType : "json",
		   		success : function(item) {
		   			$('#loaddiv').hide();
		   		    number = parseInt(page);
		 			page = number + 1;
		 			setfooterPage(page-1);
		 			var list1 = item.subjectsShowResponse.list1;
					var list2 = item.subjectsShowResponse.list2;
					var list3 = item.subjectsShowResponse.list3;
					var list4 = item.subjectsShowResponse.list4;
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
    		"<span class='muted'><small><strong>"+ list[i].name +"</strong><span class='muted'>("+ list[i].category +")</span></small></span><br />" +
    		"<span class='muted'><small>"+ list[i].info +"</small></span><br />" +
    		"<span><img class='img-polaroid' src='" + imgurl + list[i].userimage +"' style='width:15px'><a href='"+ path + "/vistiorShowUserIndex?target="+ list[i].userid +"'>"+ list[i].username +"</a></span><br /><span class='label'>" + list[i].category +"</span>" +
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
 	   if ( scrollh - scrollt <= 1000 ) {
 		     if(!isrun){
 		    	 isrun = true; 
 		    	 loadMore();  
 		     }
 	   }
 	} 

 	//绑定事件
 	function bindScroll(){
 		setfooterallpage(allpage);
 	    $(window).bind("scroll", function(){ 
 	       showload();
 	    }); 
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
</body>
</html>
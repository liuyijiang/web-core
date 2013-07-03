<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
 <%@ include file="../../../headerinclude.jsp"%> 
</head>
<body class="mxkbody mxkbackgroud" onload="bindScroll()">
<%@ include file="../public/user_page_header.jsp"%>
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
<script type="text/javascript">
   var page = 1;
   var allpage = '${subjectJoinPeopleRespone.allpage}';
   var isrun = false;
   var subjectid = '${subjectEntity.id}';
   
   function loadMore(){
		  if(page <= allpage){
			  var datas = {"searchJoinSubjectPeopleRequest.page":page,"searchJoinSubjectPeopleRequest.subjectid":subjectid};
			  $('#loaddiv').show();
			  $.ajax({
			   		url : path + "/visitorLoadMoreJoinSubjectUsers.action",
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
							createUserPlane(list1,"usershow1");
						}
						if(list2 != null){
							createUserPlane(list2,"usershow2");
						}
						if(list3 != null){
							createUserPlane(list3,"usershow3");
						}
						if(list4 != null){
							createUserPlane(list4,"usershow4");
						}
						isrun = false;
			   		 }
			 	 }); 
		  }
		 
	  }
   
   
   function createUserPlane(list,userplane){
	   var show = '';
	   for (var i in list) {
		   
		   show = show +"<li class='span3 mxkplan mxkshadow'><div class='thumbnail'><div style='position:relative;' onmouseover='mouseover("+ list[i].id +")' onmouseout='mouseout("+ list[i].id +")' >" +
		   "<span style='position:absolute; z-index:-1; opacity: 0.8;' id='"+ list[i].id +"'>"+
		   "<a class='btn btn-mini btn-inverse' href='javascript:;' onclick='createUserRelation("+ list[i].userid +")'>"+
		   "<i class='icon-plus'></i>加关注</a></span><a href='"+ path + "/visitorShowPartDetail?target="+ list[i].userid + "'>"+
		   "<img src='"+ imgurl + list[i].userimage +"' /></a></div>"+   
		   "<span><a href='"+ path + "/visitorShowPartDetail?target="+ list[i].userid +"'><small>"+ list[i].username +"</small></a></span><br />"+       
		   "<span class='muted'><small>"+ list[i].userdesc + "</small></span><br />"+            
		   "<span class='pull-right muted'><small><i class='icon-pushpin'></i>分享Parts"+ list[i].parts +"</small></span><br />" +
		   "</div></li>";
			            
	   }
	   $("#"+userplane).append(show);
   }
   
   function showload(){ 
	   var scrollh = document.documentElement.scrollHeight;
	   var scrollt = document.documentElement.scrollTop + document.body.scrollTop;
	   if ( scrollt/scrollh > 0.03 ) {
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
<div class="container">
  <div class="row">
     <div class="span1">
        <img class="img-polaroid border-radius"  style="height:60px;width:60px"
         src="<%=imgurl %>${subjectEntity.faceimage }" >
     </div>
     <div class="span11">
        <span>
          <span style="font-size: 20px;"><strong><a href="<%=rootPath%>/vistiorShowUserIndex?target=${targetUserVO.id}">${targetUserVO.name }</a>&nbsp;/&nbsp;${subjectEntity.name }</strong></span>
             &nbsp;<span class="muted"><small>(<i class="icon-tags"></i>${subjectEntity.tags })</small>
                <c:choose>
	                <c:when test="${subjectEntity.type == 'FOR-ALL'}">
	                  <span class="label label-warning">共享</span>
	                </c:when>
                </c:choose>
           </span>
        </span>
        <span class="pull-right">
           <a class="btn" href="<%=rootPath %>/vistiorShowSubjectDatail?target=${subjectEntity.id }"><i class="icon-hdd"></i>返回专题</a>
        </span>
        <br />
        <span class="muted"><small>${subjectEntity.info }</small></span>
        <br />
        <span>
          <c:forEach var="options" items="${subjectTop5NewPartsRespone.list }">
              <a href="<%=rootPath%>/visitorShowPartDetail?target=${options.id}">
                 <img style="height:24px;width:24px" src="<%=imgurl %>${options.minimage }"/>
              </a>
           </c:forEach>
           <c:if test="${!empty subjectTop5NewPartsRespone }">
              <a href="<%=rootPath %>/vistiorShowSubjectDatail?target=${subjectEntity.id }">...</a>
           </c:if>
        </span>
     </div>
  </div>
  <div style='width:100%;height:5px'></div>
  <div style='width:100%; border-top:1px solid #cccccc'></div>
</div>
<br />
<div class="container">
    <div class="row">
      
        <div class="span3">
            <ul class="thumbnails" id="usershow1">
			   <c:forEach var="options" items="${subjectJoinPeopleRespone.list1 }">
				   <li class="span3 mxkplan mxkshadow">
							<div class="thumbnail">
							   <div style="position:relative;" onmouseover="mouseover('${options.id}')" onmouseout="mouseout('${options.id}')" >
							       <span style="position:absolute; z-index:-1; opacity: 0.8;" id="${options.id}">
							            <a class="btn btn-mini btn-inverse" href="javascript:;" onclick="createUserRelation('${options.userid}')">
							               <i class="icon-plus"></i>加关注
							            </a>
							       </span>
							       <a href="<%=rootPath %>/visitorShowPartDetail?target=${options.userid}">
							          <img src="<%=imgurl %>${options.userimage}" />
							       </a>
							   </div>
							    <span><a href="<%=rootPath %>/visitorShowPartDetail?target=${options.userid}"><small>${options.username }</small></a></span><br />
								<span class="muted"><small>${options.userdesc }</small></span><br />
								<span class="pull-right muted"><small><i class="icon-pushpin"></i>分享Parts${options.parts }</small></span><br />
							</div>
					      </li>
			    </c:forEach>
			</ul>
        </div>
        
         <div class="span3">
            <ul class="thumbnails" id="usershow2">
			   <c:forEach var="options" items="${subjectJoinPeopleRespone.list2 }">
				   <li class="span3 mxkplan mxkshadow">
							<div class="thumbnail">
							   <div style="position:relative;" onmouseover="mouseover('${options.id}')" onmouseout="mouseout('${options.id}')" >
							       <span style="position:absolute; z-index:-1; opacity: 0.8;" id="${options.id}">
							            <a class="btn btn-mini btn-inverse" href="javascript:;" onclick="createUserRelation('${options.userid}')">
							               <i class="icon-plus"></i>加关注
							            </a>
							       </span>
							       <a href="<%=rootPath %>/visitorShowPartDetail?target=${options.userid}">
							          <img src="<%=imgurl %>${options.userimage}" />
							       </a>
							   </div>
							    <span><a href="<%=rootPath %>/visitorShowPartDetail?target=${options.userid}"><small>${options.username }</small></a></span><br />
								<span class="muted"><small>${options.userdesc }</small></span><br />
								<span class="pull-right muted"><small><i class="icon-pushpin"></i>分享Parts${options.parts }</small></span><br />
							</div>
					      </li>
			    </c:forEach>
			</ul>
        </div>
        
         <div class="span3">
            <ul class="thumbnails" id="usershow3">
			   <c:forEach var="options" items="${subjectJoinPeopleRespone.list3 }">
				   <li class="span3 mxkplan mxkshadow">
							<div class="thumbnail">
							   <div style="position:relative;" onmouseover="mouseover('${options.id}')" onmouseout="mouseout('${options.id}')" >
							       <span style="position:absolute; z-index:-1; opacity: 0.8;" id="${options.id}">
							            <a class="btn btn-mini btn-inverse" href="javascript:;" onclick="createUserRelation('${options.userid}')">
							               <i class="icon-plus"></i>加关注
							            </a>
							       </span>
							       <a href="<%=rootPath %>/visitorShowPartDetail?target=${options.userid}">
							          <img src="<%=imgurl %>${options.userimage}" />
							       </a>
							   </div>
							    <span><a href="<%=rootPath %>/visitorShowPartDetail?target=${options.userid}"><small>${options.username }</small></a></span><br />
								<span class="muted"><small>${options.userdesc }</small></span><br />
								<span class="pull-right muted"><small><i class="icon-pushpin"></i>分享Parts${options.parts }</small></span><br />
							</div>
					      </li>
			    </c:forEach>
			</ul>
        </div>
        
         <div class="span3">
            <ul class="thumbnails" id="usershow4">
			   <c:forEach var="options" items="${subjectJoinPeopleRespone.list4 }">
				   <li class="span3 mxkplan mxkshadow">
							<div class="thumbnail">
							   <div style="position:relative;" onmouseover="mouseover('${options.id}')" onmouseout="mouseout('${options.id}')" >
							       <span style="position:absolute; z-index:-1; opacity: 0.8;" id="${options.id}">
							            <a class="btn btn-mini btn-inverse" href="javascript:;" onclick="createUserRelation('${options.userid}')">
							               <i class="icon-plus"></i>加关注
							            </a>
							       </span>
							       <a href="<%=rootPath %>/visitorShowPartDetail?target=${options.userid}">
							          <img src="<%=imgurl %>${options.userimage}" />
							       </a>
							   </div>
							    <span><a href="<%=rootPath %>/visitorShowPartDetail?target=${options.userid}"><small>${options.username }</small></a></span><br />
								<span class="muted"><small>${options.userdesc }</small></span><br />
								<span class="pull-right muted"><small><i class="icon-pushpin"></i>分享Parts${options.parts }</small></span><br />
							</div>
					      </li>
			    </c:forEach>
			</ul>
        </div>
        <div id="loaddiv" class="mxkdivmid" style="display:none" >
             <img src="<%=domain %>/image/loadingred.gif" >
             <span class="muted"><small>正在努力加载...</small></span>
          </div>
    </div>
</div>    
<%@ include file="../../../footinclude.jsp"%>
</body>
</html>
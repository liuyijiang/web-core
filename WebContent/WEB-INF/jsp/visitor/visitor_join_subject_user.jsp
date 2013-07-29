<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
 <%@ include file="../../../headerinclude.jsp"%> 
</head>
<body class="mxkbody mxkbackgroud" onload="bindScroll()">
<%@ include file="../public/user_page_header.jsp"%>
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
							          <img style="height:24px;width:24px" src="<%=imgurl %>${options.userimage}" />
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
								       <a  href="<%=rootPath %>/visitorShowPartDetail?target=${options.userid}">
								          <img class="img-polaroid border-radius" style="width:120px;height:120px" src="<%=imgurl %>${options.userimage}" />
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
			   <c:forEach var="options" items="${subjectJoinPeopleRespone.list2 }">
				   <li class="span3 mxkplan mxkshadow">
				   <div style='padding:5px;margin-bottom:1px;'>
				     <table style='width:100%'>
				   <tr>
				   <td width='26%' rowspan='2'>
				   <img class='img-polaroid border-radius' src='http://192.168.1.101/image/51cc4032d2f43f1d9965f3d0_full.png' style='width:60px'>
				   </td>
				   <td width='30%'>
				   <div style='width:80px;text-overflow:ellipsis; white-space:nowrap; overflow:hidden;'>
				   <strong><a href='#'>大鸡鸡</a></strong>
				   </div>
				   </td>
				   <td>
				   <span class='pull-right'>
				   <a class='btn btn-inverse btn-mini' href='javascript:;' onclick='createUserRelation("51cc4032d2f43f1d9965f3d0")'>
				   <i class='icon-plus'></i>加关注</a></span>
				   </td>
				   </tr>
				   <tr>
				   <td colspan='2'>
				   <div style='width:100px;text-overflow:ellipsis; white-space:nowrap; overflow:hidden;'>
				   <span class='muted'>非我分色非负数粉色发色粉 额v</span>
				   </div>
				   <span>
				   <span class='muted'>
				   <small><i class='icon-tags'></i>舰船模型</small></span><small class='pull-right'>
				   <i class='icon-rss'></i><a href='#'>0</a>&nbsp;<i class='icon-group'></i><a href='#'>1</a></small></span></td></tr></table>
				   <span class="muted"><small>评论</small></span><br /> 
				   <span class="muted"><small>dwadawdwadadaadawdwad分分色分色分色</small></span><br /> 
				   </div>
				   
<!-- 				       <table style='width:100%'> -->
<!-- 				          <tr> -->
<!-- 				            <td width='26%' rowspan='2'> -->
<%-- 				            <img class='img-polaroid border-radius' src="<%=imgurl %>${options.userimage}" style='width:60px'> --%>
<!-- 				            </td> -->
<!-- 				            <td width='30%'> -->
<!-- 				            <div style='width:140px;text-overflow:ellipsis; white-space:nowrap; overflow:hidden;'> -->
<!-- 				            <div style='width:140px;text-overflow:ellipsis; white-space:nowrap; overflow:hidden;'> -->
<!-- 				            </div></td><td> -->
<!-- 							<div class="thumbnail"> -->
<%-- 							   <div style="position:relative;" onmouseover="mouseover('${options.id}')" onmouseout="mouseout('${options.id}')" > --%>
<%-- 							       <span style="position:absolute; z-index:-1; opacity: 0.8;" id="${options.id}"> --%>
<%-- 							            <a class="btn btn-mini btn-inverse" href="javascript:;" onclick="createUserRelation('${options.userid}')"> --%>
<!-- 							               <i class="icon-plus"></i>加关注 -->
<!-- 							            </a> -->
<!-- 							       </span> -->
<%-- 							       <a href="<%=rootPath %>/visitorShowPartDetail?target=${options.userid}"> --%>
<%-- 							          <img src="<%=imgurl %>${options.userimage}" /> --%>
<!-- 							       </a> -->
<!-- 							   </div> -->
<%-- 							    <span><a href="<%=rootPath %>/visitorShowPartDetail?target=${options.userid}"><small>${options.username }</small></a></span><br /> --%>
<%-- 								<span class="muted"><small>${options.userdesc }</small></span><br /> --%>
<%-- 								<span class="pull-right muted"><small><i class="icon-pushpin"></i>分享Parts${options.parts }</small></span><br /> --%>
<!-- 							</div> -->
					      </li>
			    </c:forEach>
			</ul>
        </div>
        
         <div class="span3">
            <ul class="thumbnails" id="usershow4">
			   <c:forEach var="options" items="${subjectJoinPeopleRespone.list2 }">
				    <li class="span3 mxkplan mxkshadow">
				       <div style='padding:5px;margin-bottom:1px;'>
				         <table style='width:100%'>
				             <tr>
							   <td width='26%' rowspan='2'>
							      <div style="position:relative;" onmouseover="mouseover('aa')" onmouseout="mouseout('aa')" >
							         <span style="position:absolute; z-index:-1; opacity: 0.8;" id="aa">
							            <a class="btn btn-mini btn-danger" href="javascript:;" onclick="createUserRelation('${options.userid}')">
							               <i class='icon-remove-circle'></i>删除
							            </a>
							         </span>
							         <a href="<%=rootPath %>/visitorShowPartDetail?target=${options.userid}">
							          <img style="width:60px"  class='img-polaroid border-radius' src="<%=imgurl %>${options.userimage}" />
							         </a>
							      </div>
							   </td>
				               <td width='35%'>
								   <div style='width:80px;text-overflow:ellipsis; white-space:nowrap; overflow:hidden;'>
								    <strong><a href='#'>大鸡鸡</a></strong>
								   </div>
							   </td>
				               <td>
					               <span class='pull-right'>
								      <a class='btn btn-success btn-mini' href='javascript:;' onclick='createUserRelation("51cc4032d2f43f1d9965f3d0")'>
								               回复</a>
								   </span>
							   </td>
						    </tr>
							<tr>
							  <td colspan='2'>
								   <div style='width:140px;text-overflow:ellipsis; white-space:nowrap; overflow:hidden;'>
								     <span class='muted'>非我分色非负数粉色发色粉 额v</span>
								   </div>
				                  <span class='muted'>
				                     <small>评论:</small>
				                  </span>
				              </td>
				           </tr>
				         </table>
				        <span class="muted"><small>dwadawdwadadaadawdwad分分色分色分色</small></span><br /> 
				        <span class=" pull-right muted"><small><i class='icon-time'></i>2012-12-12 23:12:34</small></span><br /> 
				        </div>
				   </li>
			    </c:forEach>
			</ul>
        </div>

        
        <div id="loaddiv" class="mxkdivmid" style="display:none" >
             <img src="<%=domain %>loadingred.gif" >
             <span class="muted"><small>正在努力加载...</small></span>
          </div>
    </div>
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
</body>
</html>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="../../../headerinclude.jsp"%> 
</head>
<script type="text/javascript">
   var allpage = '${partShowResponse.allPage}'; //当加载页数超过总页数后不加载
   var page = 2;
   var isrun = false;
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
  
  function filterParts(){
	  $("#partshow1").html('');
	  $("#partshow2").html('');
	  $("#partshow3").html('');
	  $("#partshow4").html('');
	  var datas = {"searchPartRequest.page":1,"searchPartRequest.type":filtertype};
	  $.ajax({
	   		url : path + "/visitorFilterPartsType.action",
	   		type : "POST",
	   		cache : false,
	   		async : false,
	   		data: datas,
	   		dataType : "json",
	   		success : function(item) {
	   			$('#loaddiv').hide();
	 			page = 2;
	 			allpage = item.allPage;
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
	   		 }
	 	 });  
  }
  
  function loadMore(){
	  if(page <= allpage){
		  var datas;
		  if(filtertype = ''){
			  datas = {"searchPartRequest.page":page};
		  }else{
			  datas = {"searchPartRequest.page":page,"searchPartRequest.type":filtertype};
		  }
		  $('#loaddiv').show();
		  $.ajax({
		   		url : path + "/visitorLoadMoreParts.action",
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
  
  function createPartPlane(list,partthumnailid){
	  show = '';
	  for(var i in list){
		  show = show + "<li class='span3 mxkplan mxkshadow'><div class='thumbnail'>"+
		  "<div style='position:relative;' onmouseover='mouseover(\""+ list[i].id  +"\")' onmouseout='mouseout(\""+ list[i].id  +"\")' >" +
		  "<span style='position:absolute; z-index:-1; opacity: 0.8;' id='"+ list[i].id +"'>" +
		  "<a class='btn btn-mini btn-danger' href='javascript:;' onclick='collectPart(\""+ list[i].id  +"\")'>" +
	      "<i class='icon-pushpin'></i>收藏 </a>&nbsp;" +
	      "<a class='btn btn-mini' href='" + path + "/visitorShowPartDetail?target="+ list[i].id +"'>" +
	      "<i class='icon-comment'></i>评论</a></span>" + 	
	      "<a href='"+ path +"/visitorShowPartDetail?target="+ list[i].id +"'><img src='"+ imgurl + list[i].minimage +"' /></a>" +
	      "</div><span class='muted'><small>"+ list[i].desc +"</small></span><br />" +  
	      "<span class='text-info'><small><a href='"+ path +"/vistiorShowSubjectDatail?target="+ list[i].subjectid +"'>《"+ list[i].subname +"》</a></small></span><br />" +
	      "<span class='pull-right muted'><small><i class='icon-comment'></i>评论"+ list[i].comments + "<i class='icon-pushpin'></i>收藏"+ list[i].collect +"</small>" +
	      "</span><br /></div></li>";
	  }
	  $("#"+partthumnailid).append(show);
  }
  
  
  function showload(){ 
	   var scrollh = document.documentElement.scrollHeight;
	   var scrollt = document.documentElement.scrollTop + document.body.scrollTop;
	   if ( scrollt/scrollh > 0.01) {
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
<body class="mxkbody  mxkbackgroud" onload="bindScroll()">
<%@ include file="../public/part_dash_board_header.jsp"%>
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
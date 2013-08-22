<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="../../../headerinclude.jsp"%>  
</head>
<body class="mxkbody  mxkbackgroud" onload="bindScroll();">
<%@ include file="../public/part_dash_board_header.jsp"%> 
<br /><br />  
<script type="text/javascript">
function loadParts(id){ 
	$("#partsdivshow").show();
	$("#londingprts").show();
	var divheight = document.documentElement.scrollTop + document.body.scrollTop + 20;
	$("#divheight").css("height",divheight);
	var currentpage = page;
    $("#partsdiv").load(path +'/visitorShowPartDetailPop?target='+id,function() {
    	page = currentpage;
    	$("#londingprts").hide();
    });  
}  
</script>

<div style="position:relative;" >
<!--   <div id="pubLayer_Msg" class="pub_Pop_Style" style="width: 550px; height: 350px; position: fixed; margin: 0px; left: 399px; top: 10px; z-index:1; opacity: 1;background-image: url(http://www.waileecn.com/mxk/assets/mxkimage/probg.png);"> -->
<!-- </div> -->

 <div id="partsdivshow" style="display:none;height:100%;width:100%;position:absolute;z-index:1;background-image: url(http://www.waileecn.com/mxk/assets/mxkimage/probg.png);" >
      <div id="divheight"></div>
       <div id="londingprts" class="mxkdivmid" style="display:none" >
            <img id="" src="<%=domain %>loadingred.gif">
            <span class="muted"><small>正在努力加载...</small></span>
       </div>
       <div style="width:100%;">
         <button class="btn pull-right btn-danger" onclick="$('#partsdivshow').hide();$('#partsdiv').html('');">&times;</button>
       </div>
	   <div id="partsdiv" class="container">
	   
	   </div>
 </div>
<c:if test="${!empty partShowResponse }">
<br />  
 <div class="container">
	      <div class="row">
			<div class="span3">
				<ul class="thumbnails" id="partshow1">
				    <c:forEach var="options" items="${partShowResponse.list1 }">
					  <li class="span3 mxkplan ${options.shadow }">
						<div class="thumbnail" >
						   <div style="position:relative;" onmouseover="mouseover('${options.id }')" onmouseout="mouseout('${options.id }')" >
						       <span style="position:absolute; z-index:-1; opacity: 0.8;" id="${options.id }">
						            <a class="btn btn-mini btn-danger" href="javascript:;" onclick="collectPart('${options.id}')">
						               <i class="icon-pushpin"></i>收藏
						            </a>
                                    <a class="btn btn-mini" href="<%=rootPath %>/visitorShowPartDetail?target=${options.id}">
                                       <i class="icon-comment"></i>评论
                                    </a>
                                    <c:if test="${options.audios != 0 }">
	                                    <br />
	                                    <span class="label label-warning"><i class="icon-microphone"></i>语音评论${options.audios}</span>
                                    </c:if>
						       </span>
						       	<a onclick="loadParts('${options.id}')" href="javascript:;" style="cursor:-moz-zoom-in" ><img src="<%=imgurl %>${options.minimage}" /></a>
						   </div>
							<span class="muted"><small>${options.desc }</small></span><br />
							<c:if test="${options.subjectid != '#' }">
							  <span class="text-info"><small><a href="<%=rootPath %>/vistiorShowSubjectDatail?target=${options.subjectid}">《${options.subname }》</a></small></span><br />
							</c:if>
							   <span class="label">${options.type }</span>
							    <span class="pull-right muted">
							        <small>
								    <i class="icon-comment"></i>评论${options.comments + options.audios  }
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
                                    <c:if test="${options.audios != 0 }">
	                                    <br />
	                                    <span class="label label-warning"><i class="icon-microphone"></i>语音评论${options.audios}</span>
                                    </c:if>
						       </span>
						       	<a onclick="loadParts('${options.id}')" href="javascript:;" style="cursor:-moz-zoom-in" ><img src="<%=imgurl %>${options.minimage}" /></a>
						   </div>
							<span class="muted"><small>${options.desc }</small></span><br />
							<c:if test="${options.subjectid != '#' }">
							  <span class="text-info"><small><a href="<%=rootPath %>/vistiorShowSubjectDatail?target=${options.subjectid}">《${options.subname }》</a></small></span><br />
							</c:if>
							<span class="label">${options.type }</span>
							    <span class="pull-right muted">
							       <small>
								    <i class="icon-comment"></i>评论${options.comments + options.audios  }
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
                                    <c:if test="${options.audios != 0 }">
	                                    <br />
	                                    <span class="label label-warning"><i class="icon-microphone"></i>语音评论${options.audios}</span>
                                    </c:if>
						       </span>
						       	<a onclick="loadParts('${options.id}')" href="javascript:;" style="cursor:-moz-zoom-in" ><img style="cursor:-moz-zoom-in" src="<%=imgurl %>${options.minimage}" /></a>
						   </div>
							<span class="muted"><small>${options.desc }</small></span><br />
							<c:if test="${options.subjectid != '#' }">
							  <span class="text-info"><small><a href="<%=rootPath %>/vistiorShowSubjectDatail?target=${options.subjectid}">《${options.subname }》</a></small></span><br />
							</c:if>
							<span class="label">${options.type }</span>
							    <span class="pull-right muted">
							        <small>
									    <i class="icon-comment"></i>评论${options.comments + options.audios  }
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
                                    <c:if test="${options.audios != 0 }">
	                                    <br />
	                                    <span class="label label-warning"><i class="icon-microphone"></i>语音评论${options.audios}</span>
                                    </c:if>
						       </span>
						       	<a onclick="loadParts('${options.id}')" href="javascript:;" style="cursor:-moz-zoom-in" ><img src="<%=imgurl %>${options.minimage}" /></a>
						   </div>
							<span class="muted"><small>${options.desc }</small></span><br />
							<c:if test="${options.subjectid != '#' }">
							  <span class="text-info"><small><a href="<%=rootPath %>/vistiorShowSubjectDatail?target=${options.subjectid}">《${options.subname }》</a></small></span><br />
							</c:if>
							<span class="label">${options.type }</span>
							    <span class="pull-right muted">
							        <small>
									    <i class="icon-comment"></i>评论${options.comments + options.audios  }
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
 </div>
 
 <%@ include file="../public/public_page_footer.jsp"%> 
 <%@ include file="../../../basefootinclude.jsp"%>
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
	   		url : path + "/visitorFilterPartsType",
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
		  if(filtertype == ''){
			  datas = {"searchPartRequest.page":page};
		  }else{
			  datas = {"searchPartRequest.page":page,"searchPartRequest.type":filtertype};
		  }
		  $('#loaddiv').show();
		  $.ajax({
		   		url : path + "/visitorLoadMoreParts",
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
		  var num = list[i].comments + list[i].audios;
		  show = show + "<li class='span3 mxkplan "+ list[i].shadow +"'><div class='thumbnail'>"+
		  "<div style='position:relative;' onmouseover='mouseover(\""+ list[i].id  +"\")' onmouseout='mouseout(\""+ list[i].id  +"\")' >" +
		  "<span style='position:absolute; z-index:-1; opacity: 0.8;' id='"+ list[i].id +"'>" +
		  "<a class='btn btn-mini btn-danger' href='javascript:;' onclick='collectPart(\""+ list[i].id  +"\")'>" +
	      "<i class='icon-pushpin'></i>收藏 </a>&nbsp;" +
	      "<a class='btn btn-mini' href='" + path + "/visitorShowPartDetail?target="+ list[i].id +"'>" +
	      "<i class='icon-comment'></i>评论</a>";
	      if(list[i].audios != 0){
	    	  show = show + " <br /><span class='label label-warning'><i class='icon-microphone'></i>语音评论"+ list[i].audios +"</span>";  
	      }
	      show = show +  "</span><a onclick='loadParts(\""+ list[i].id +"\")' href='javascript:;' style='cursor:-moz-zoom-in' ><img src='"+ imgurl + list[i].minimage +"' /></a>" +
	      "</div><span class='muted'><small>"+ list[i].desc +"</small></span><br />";  
	      if(list[i].subjectid != "#"){
	    	  show = show + "<span class='text-info'><small><a href='"+ path +"/vistiorShowSubjectDatail?target="+ list[i].subjectid +"'>《"+ list[i].subname +"》</a></small></span><br />";
	      }
	      show = show + "<span class='label'>"+ list[i].type +"</span><span class='pull-right muted'><small><i class='icon-comment'></i>评论"+ num + "<i class='icon-pushpin'></i>收藏"+ list[i].collect +"</small>" +
	      "</span><br /></div></li>";
	      
	  }
	  $("#"+partthumnailid).append(show);
  }
  
  
  function showload(){ 
	   var scrollh = document.documentElement.scrollHeight;
	   var scrollt = document.documentElement.scrollTop + document.body.scrollTop;
	   
	   if ( scrollh - scrollt <= 1000) {
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

</script>
</body>
</html>
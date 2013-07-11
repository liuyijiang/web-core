<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
 <%@ include file="../../../headerinclude.jsp"%> 
</head>
<script type="text/javascript">
var page = 2;
var userid = '${subjectEntity.userid}';
var subjectid = '${subjectEntity.id}';
var allpage = '${partShowResponse.allPage}';
var isrun = false;

function createPartPlane(list,subjectid,partthumnailid){
	var show = '';
	for(var i in list)//照片墙第一个位置
	{
		 show = show + "<li class='span3 mxkplan mxkshadow'><div class='thumbnail'>"+
		 "<div style='position:relative;' onmouseover='mouseover(\""+ list[i].id +"\")' onmouseout='mouseout(\""+list[i].id +"\")' >" +
		 "<span style='position:absolute; z-index:-1; opacity: 0.8;' id='"+ list[i].id +"'>"+
		 "<a class='btn btn-small' href='javascript:;' onclick='useForSubjectFace(\""+ list[i].id +",\"" + subjectid + "\")'>"+
		 "<i class='icon-picture'></i>封面</a><a class='btn btn-small' href='"+ path +"/partDetail?target="+ list[i].id + "'>"+
		 "<i class='icon-cog'></i>操作 </a></span><a href='"+ path +"/partDetail?target="+list[i].id +"'><img src='"+ imgurl + list[i].minimage +"'/></a></div>"+	            
		 "<span class='muted'>"+ list[i].desc +"</span><br /><span class='form-inline'><label class='checkbox' id='checks' style='display:none'>"+               
		 "<input type='checkbox'><span class='text-info'>使用</span></label><span class='pull-right muted'>"+	            
         "<i class='icon-comment'></i>评论"+ list[i].comments +"<i class='icon-pushpin'></i>收藏"+ list[i].collect +"</span></span><br /></div></li>";           
	}
	$('#'+partthumnailid).append(show);
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

function loadMore(){
	if(page <= allpage){
		 $('#loaddiv').show();
		   var datas = {"searchPartRequest.page":page,"searchPartRequest.userid":userid,"searchPartRequest.subjectid":subjectid};
		   $.ajax({
		 		url : path + "/loadMoreSubjectParts.action",
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
						createPartPlane(list1,subjectid,"partshow1");
					}
					if(list2 != null){
						createPartPlane(list2,subjectid,"partshow2");
					}
					if(list3 != null){
						createPartPlane(list3,subjectid,"partshow3");
					}
					if(list4 != null){
						createPartPlane(list4,subjectid,"partshow4");
					}
					isrun = false;
		 	   }
			});
	}
}


//绑定事件
function bindScroll(){
    $(window).bind("scroll", function(){ 
       showload();
    }); 
}
</script> 
 <script type="text/javascript" >
      
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
<%-- 评论部分  --%>
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
                <c:when test="${subjectEntity.type == 'PUBLIC'}">
                  <span class="label label-success">公开</span>
                </c:when>
             </c:choose>
           </span>
        </span>
        <span class="pull-right">
           <a href="javascript:;" class="btn btn-primary"  onclick="rsssubject('${subjectEntity.id}','${subjectEntity.userid }')"><i class="icon-rss"></i>订阅专题</a>
        </span>
        <br />
        <span class="muted"><small>${subjectEntity.info }</small></span><br />
        <span><i class="icon-time"></i>Create Time:${subjectEntity.createTime }</span>
               <div class="btn-group pull-right " >
                  <a class="btn" href="<%=rootPath %>/visitorShowPartSilderView?target=${subjectEntity.id}">
                    <i class="icon-expand "></i>幻灯播放
                  </a>
				  <button class="btn " style="font-family:Microsoft YaHei;"><i class="icon-rss"></i>订阅${subjectEntity.attention }</button>
				  <button class="btn " style="font-family:Microsoft YaHei;"><i class="icon-comment-alt"></i>评论${subjectEntity.comments }</button>
				  <button class="btn " style="font-family:Microsoft YaHei;"><i class="icon-pushpin"></i>Parts${subjectEntity.parts }</button>
		        </div>
        <br />
     </div>
  </div>
  <br />
<div class="container ">
		<div class="navbar">
			<div class="navbar-inner">
				 <span>
                <div class="btn-group">
                      <a class="btn dropdown-toggle btn " data-toggle="dropdown" href="#">
                        <i class="icon-globe"></i>分享
                      <span class="caret"></span>
				    </a>
				     <ul class="dropdown-menu">
					       <li><a href="#">分享到新浪微博</a></li>
						   <li><a href="#">分享到QQ微信</a></li>
						   <li><a href="#">分享到QQ空间</a></li>
		               </ul>
				    </div>
            <a class="btn" href="<%=rootPath %>/visitorShowSubjectMaterial?target=${subjectEntity.id}" > 
              <i class="icon-calendar "></i>材料列表
            </a>
         </span>
               <span class="pull-right">
                <a class="btn" href="<%=rootPath %>/visitiorShowSubjectComements?target=${subjectEntity.id}"><i class="icon-comments-alt"></i>评论${subjectEntity.comments }</a>
               </span>
			</div>
		</div>
	</div>
</div>

<!-- part -->
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
						       </span>
						       	<a href="<%=rootPath %>/visitorShowPartDetail?target=${options.id}"><img src="<%=imgurl %>${options.minimage}" /></a>
						   </div>
							<span class="muted"><small>${options.desc }</small></span><br />
						    <span class="form-inline">
							   <span class="pull-right muted">
							   <small>
								    <i class="icon-comment"></i>评论${options.comments }
								    <i class="icon-pushpin"></i>收藏${options.collect }
							    </small>
							    </span>
						    </span><br />
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
						       </span>
						       	<a href="<%=rootPath %>/visitorShowPartDetail?target=${options.id}"><img src="<%=imgurl %>${options.minimage}" /></a>
						   </div>
							<span class="muted"><small>${options.desc }</small></span><br />
						    <span class="form-inline">
							    <span class="pull-right muted">
							    <small>
								    <i class="icon-comment"></i>评论${options.comments }
								    <i class="icon-pushpin"></i>收藏${options.collect }
							    </small>
							    </span>
						    </span><br />
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
						       </span>
						       	<a href="<%=rootPath %>/visitorShowPartDetail?target=${options.id}"><img src="<%=imgurl %>${options.minimage}" /></a>
						   </div>
							<span class="muted"><small>${options.desc }</small></span><br />
						    <span class="form-inline">
							    <span class="pull-right muted">
							    <small>
								    <i class="icon-comment"></i>评论${options.comments }
								    <i class="icon-pushpin"></i>收藏${options.collect }
							    </small>
							    </span>
						    </span><br />
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
						       </span>
						       	<a href="<%=rootPath %>/visitorShowPartDetail?target=${options.id}" ><img src="<%=imgurl %>${options.minimage}" /></a>
						   </div>
							<span class="muted"><small>${options.desc }</small></span><br />
						    <span class="form-inline">
							    <span class="pull-right muted">
							    <small>
								    <i class="icon-comment"></i>评论${options.comments }
								    <i class="icon-pushpin"></i>收藏${options.collect }
							    </small>
							    </span>
						    </span><br />
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
<br /><br /><br />
 <%@ include file="../../../footinclude.jsp"%>
</body>
</html>
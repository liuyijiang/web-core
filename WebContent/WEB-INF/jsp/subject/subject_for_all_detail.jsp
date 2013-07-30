<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
 <%@ include file="../../../headerinclude.jsp"%> 
</head>
<%-- 评论部分  --%>
<body class="mxkbody mxkbackgroud" onload="bindScroll()">
<%@ include file="../public/user_page_header.jsp"%>
<div class="container">
  <div class="row">
     <div class="span1">
        <img class="img-polaroid border-radius"  style="height:60px;width:60px"
         src="<%=imgurl %>${currentSubjectEntity.faceimage }" >
     </div>
     <div class="span11">
        <span>
          <span style="font-size: 20px;"><strong><a href="<%=rootPath%>/userIndex">${uservo.name }</a>&nbsp;/&nbsp;${currentSubjectEntity.name }</strong></span>
             &nbsp;<span class="muted"><small>(<i class="icon-tags"></i>${currentSubjectEntity.tags })</small>
                <c:choose>
	                <c:when test="${currentSubjectEntity.type == 'FOR-ALL'}">
	                  <span class="label label-warning">共享</span>
	                </c:when>
                </c:choose>
           </span>
        </span>
        <span class="pull-right">
           <a href="javascript:;" class="btn btn-primary"  onclick="rsssubject('${currentSubjectEntity.id}','${currentSubjectEntity.userid }')"><i class="icon-rss"></i>订阅专题</a>
           <a href="javascript:;" class="btn btn-info" onclick="showCreatePart()"><i class="icon-pushpin"></i>添加Part</a>
         </span>
        <br />
        <span class="muted"><small>${currentSubjectEntity.info }</small></span>
        <br />
        <span><i class="icon-time"></i>Create Time:${currentSubjectEntity.createTime }</span>
         <span class="pull-right">
           <c:forEach var="options" items="${partShowResponse.joiner }">
              <a href="<%=rootPath%>/vistiorShowUserIndex?target=${options.userid}"><img style="width:24px" src="<%=imgurl %>${options.userimage }"/></a>
           </c:forEach>
           <c:if test="${!empty partShowResponse.joiner }">
              <a href="javascript:;"><small>等${currentSubjectEntity.joinpeople }人参与</small></a>
           </c:if>
         </span>
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
					       <li>
						      <a href="http://service.weibo.com/share/share.php?url=<%=rootPath%>/vistiorShowSubjectDatail?target=${currentSubjectEntity.id }&pic=<%=imgurl %>${currentSubjectEntity.faceimage }&title=${subjectEntity.name }&nbsp;&nbsp;${currentSubjectEntity.info }" target="_blank">
						                   分享到新浪微博
						       </a>
					       </li>
						   <li>
							   <a href="http://share.v.t.qq.com/index.php?c=share&a=index&url=<%=rootPath%>/vistiorShowSubjectDatail?target=${currentSubjectEntity.id }&pic=<%=imgurl %>${currentSubjectEntity.faceimage }&title=${subjectEntity.name }&nbsp;&nbsp;${currentSubjectEntity.info }" target="_blank">
							         分享到QQ微信
							   </a>
						   </li>
						   <li>
							   <a href="http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url=<%=rootPath%>/index&pic=<%=imgurl %>${currentSubjectEntity.faceimage }&title=${currentSubjectEntity.name }&nbsp;&summary=${subjectEntity.info }|&nbsp;<%=rootPath%>/vistiorShowSubjectDatail?target=${currentSubjectEntity.id }" target="_blank">
							         分享到QQ空间
							   </a>
						  </li>
		               </ul>
				    </div>
         </span>
          <span class="pull-right">
             <a class="btn" href="<%=rootPath %>/visitorShowPartSilderView?target=${currentSubjectEntity.id}">
              <i class="icon-expand "></i>幻灯播放
             </a>
             <a class="btn" href=""><i class="icon-comments-alt"></i>评论${currentSubjectEntity.comments }</a>
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
								<div style='width:190px;text-overflow:ellipsis; white-space:nowrap; overflow:hidden;'>
									<a href="<%=rootPath%>/vistiorShowUserIndex?target=${options.userid}">
									  <img style="width:20px" src="<%=imgurl %>${options.userimage }"/>
									  ${options.username }
									</a>
								</div>
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
						       </span>
						       	<a href="<%=rootPath %>/visitorShowPartDetail?target=${options.id}"><img src="<%=imgurl %>${options.minimage}" /></a>
						   </div>
							<span class="muted"><small>${options.desc }</small></span><br />
						    <div style='width:190px;text-overflow:ellipsis; white-space:nowrap; overflow:hidden;'>
									<a href="<%=rootPath%>/vistiorShowUserIndex?target=${options.userid}">
									  <img style="width:20px" src="<%=imgurl %>${options.userimage }"/>
									  ${options.username }
									</a>
								</div>
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
						       </span>
						       	<a href="<%=rootPath %>/visitorShowPartDetail?target=${options.id}"><img src="<%=imgurl %>${options.minimage}" /></a>
						   </div>
							<span class="muted"><small>${options.desc }</small></span><br />
						    <div style='width:190px;text-overflow:ellipsis; white-space:nowrap; overflow:hidden;'>
									<a href="<%=rootPath%>/vistiorShowUserIndex?target=${options.userid}">
									  <img style="width:20px" src="<%=imgurl %>${options.userimage }"/>
									  ${options.username }
									</a>
								</div>
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
						       </span>
						       	<a href="<%=rootPath %>/visitorShowPartDetail?target=${options.id}" ><img src="<%=imgurl %>${options.minimage}" /></a>
						   </div>
							<span class="muted"><small>${options.desc }</small></span><br />
						   <div style='width:190px;text-overflow:ellipsis; white-space:nowrap; overflow:hidden;'>
									<a href="<%=rootPath%>/vistiorShowUserIndex?target=${options.userid}">
									  <img style="width:20px" src="<%=imgurl %>${options.userimage }"/>
									  ${options.username }
									</a>
								</div>
						    <span class="pull-right muted">
							    <small>
								    <i class="icon-comment"></i>评论${options.comments }
								    <i class="icon-pushpin"></i>收藏${options.collect }
							    </small>
						    </span><br />
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
<br /><br /><br />
 
     <!-- 添加part -->
    <div id="createPartModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	    <div class="modal-header">
	       <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	       <h3>添加Part</h3>
        </div>
        <div class="modal-body">
          <form id="planform" action="createProjectPlan" enctype="multipart/form-data"
				method="post">
			 <span>
				 <small>选择图片</small>
				 <img id="loading" src="<%=domain %>loadingred.gif" style="display:none">
			 </span>
			 <br />
			 <input id="fileToUpload" type="file" size="45" name="image"  /><br />
			 <small>写点描述吧</small><br />
			 <textarea id="partinfo" rows="3" style="width:98%" ></textarea>
          </form>
        </div>
	    <div class="modal-footer">
	      <a href="javascript:;" class="btn btn-primary" onclick="ajaxFileUpload('${currentSubjectEntity.id }','${currentSubjectEntity.tags }','${currentSubjectEntity.name }')">发布</a>
	      <a href="javascript:;" class="btn" onclick="closeCreatePart()">关闭</a>
	    </div>
    </div>
    
  <script type="text/javascript">

	 function showCreatePart(){
		 $('#createPartModal').modal({
	       keyboard: false
	   });
	 }
 
	 function closeCreatePart(){
		 $('#createPartModal').modal('hide');
	 }

 </script>
  <script type="text/javascript"> 
  
  
   function validateImage() {
  	  return true;
   }
  
	function ajaxFileUpload(subid,tags,username)
	{   
		if(validateImage()){
			var info = $('#partinfo').val();
			var faceimage = 1;
			if($("#useforfaceimage").attr("checked")){
				faceimage = 1;
			}else{
				faceimage = 0; 
			}
			var datas = {"createPartRequest.subjectid":subid,"createPartRequest.desc":info,"createPartRequest.type":tags,"createPartRequest.subname":username,"createPartRequest.forfaceimage":faceimage};
			$("#loading").show();
			$.ajaxFileUpload
			(
				{
					url:path + "/createPartBySubjectId.action",
					secureuri:false,
					fileElementId:'fileToUpload',
					dataType: 'json',
					data:datas,
					success: function (data, status)
					{  
						if(data.message ="success"){
							$("#loading").hide();
							closeCreatePart();
			    		    window.location.href = path + "/vistiorShowSubjectDatail?target=" + subid;
						}else{
							$("#loading").hide();
							alert(data.message);
						}
						
					},
					error: function (data, status, e)
					{
						$("#loading").hide();
						alert(data.message);
					}
				}
			);
		}
		return false;
	}
	</script>	   
     
 <%@ include file="../../../footinclude.jsp"%>
 <script type="text/javascript">
var page = 2;
var userid = '${currentSubjectEntity.userid}';
var subjectid = '${currentSubjectEntity.id}';
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
   if ( scrollt/scrollh > 0.2 ) {
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
</body>
</html>
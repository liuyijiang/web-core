<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
 <%@ include file="../../../headerinclude.jsp"%>
</head>
<script type="text/javascript">
function showCreatePart(){
	 $('#createPartModal').modal({
      keyboard: false
  });
}

function closeCreatePart(){
	 $('#createPartModal').modal('hide');
}


function showCreateSubjectWorking(){
	 $('#createSubjectWorking').modal({
     keyboard: false
 });
}

function closeCreateSubjectWorking(){
	 $('#createSubjectWorking').modal('hide');
}

</script>
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
		 var num = list[i].comments + list[i].audios;
		 show = show + "<li class='span3 mxkplan mxkshadow'><div class='thumbnail'>"+
		 "<div style='position:relative;' onmouseover='mouseover(\""+ list[i].id +"\")' onmouseout='mouseout(\""+list[i].id +"\")' >" +
		 "<span style='position:absolute; z-index:-1; opacity: 0.8;' id='"+ list[i].id +"'>"+
		 "<a class='btn btn-small' href='javascript:;' onclick='useForSubjectFace(\""+ list[i].id +",\"" + subjectid + "\")'>"+
		 "<i class='icon-picture'></i>封面</a><a class='btn btn-small' href='"+ path +"/showPartsComments?target="+ list[i].id + "'>"+
		 "<i class='icon-comment-alt'></i>评论 </a></span><a href='"+ path +"/partDetail?target="+list[i].id +"'><img src='"+ imgurl + list[i].minimage +"'/></a></div>"+	            
		 "<span class='muted'>"+ list[i].desc +"</span><br /><span class='form-inline'><label class='checkbox' id='checks' style='display:none'>"+               
		 "<input type='checkbox'><span class='text-info'>使用</span></label><span class='pull-right muted'>"+	            
         "<i class='icon-comment'></i>评论"+ num +"<i class='icon-pushpin'></i>收藏"+ list[i].collect +"</span></span><br /></div></li>";           
	}
	$('#'+partthumnailid).append(show);
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
				if(useforgif || userforpdf ){
					showchecks();
				}
	 	   }
		});
	}
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
 <script type="text/javascript" >
       var useforgif = false;
       var userforpdf = false;
      
       function mouseover(id){
         $("#"+id).css("z-index","1");
       }
	   
       function mouseout(id){
		$("#"+id).css("z-index","-1");
	   }
       
       function useForSubjectFace(partid,subid){
    	     var datas = {"setFaceImageRequest.partid":partid,"setFaceImageRequest.subjectid":subid};
    	     $.ajax({
	       		url : path + "/setSubjectFaceImage.action",
	       		type : "POST",
	       		cache : false,
	       		async : false,
	       		data: datas,
	       		dataType : "json",
	       		success : function(item) {
	       			if(item == 'success'){
	   		    	    window.location.href= path + "/showSubjectDetailView";
	   		        }else{
	   		    	    alert("网络异常请重试");
	   		        }
	       		  }
       		  });
       }
       
       
</script>
<script type="text/javascript">
function changeSubjectStutas(subid,status){
	  var datas = {"updateSubjectStatusRequest.id":subid,"updateSubjectStatusRequest.stauts":status};
	  $.ajax({
		url : path + "/changeSubjectStatus.action",
		type : "POST",
		cache : false,
		async : false,
		data: datas,
		dataType : "json",
		success : function(item) {
		     if(item == 'success'){
		    	 window.location.href= path + "/showSubjectDetailView";
		     }else{
		    	 alert("网络异常请重试");
		     }
		  }
	 }); 
}


function deleteSubject(id){
	if(!confirm("确定要删除吗？删除专题会同时删除Parts和所有评论")){
  		return;  //deleteProject
    }else{
		var datas = {"targetId":id};
		$.ajax({
			url : path + "/deleteSubject.action",
			type : "POST",
			cache : false,
			async : false,
			data: datas,
			dataType : "json",
			success : function(item) {
			     if(item == 'success'){
			    	 window.location.href= path + "/userIndex";
			     }else{
			    	 alert("网络异常请重试");
			     }
			  }
		 }); 
    }
}

</script>
<body class="mxkbody  mxkbackgroud" onload="bindScroll()">
<%@ include file="../public/user_page_header.jsp"%>
<div class="container">
  <div class="row">
     <div class="span1">
        <img class="img-polaroid border-radius"  style="height:60px;width:60px"
         src="<%=imgurl %>${currentSubjectEntity.faceimage }" >
     </div>
     <div class="span11">
        <span>
          <span style="font-size: 20px;"><strong>${currentSubjectEntity.name }</strong></span>
             &nbsp;/&nbsp;<span class="muted">(<i class="icon-tags"></i>${currentSubjectEntity.tags })
             
                   <a id="substatus" class="btn dropdown-toggle btn-success btn-mini" data-toggle="dropdown" href="#">
                                                             编辑
				   </a>
               
           </span>
        </span>
        <span class="pull-right">
           <a href="javascript:;" class="btn btn-info" onclick="showCreatePart()"><i class="icon-pushpin"></i>添加Part</a>
            <a class="btn btn-warning" href="javascript:;" onclick="showCreateSubjectWorking()">
              <i class="icon-edit-sign"></i>进度总结
            </a>
         </span>
        <br />
        <span class="muted"><small>${currentSubjectEntity.info }</small></span><br />
        <span><i class="icon-time"></i>Create Time:${currentSubjectEntity.createTime }</span>
        <span class="span3 pull-right">
           <div class="progress progress-success progress-striped">
              <div class="bar bar-success" style="width: 60%;">完成60%</div>
           </div>
        </span>
     </div>
  </div>
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
          <span>
          <div class="btn-group">
		    <button class="btn"><i class="icon-cog"></i>操作</button>
			    <button class="btn dropdown-toggle" data-toggle="dropdown">
			    <span class="caret"></span>
	            </button>
			    <ul class="dropdown-menu">
			       <li><a href="javascript:;" onclick="useforgifshow('生成GIF')">生成GIF动态图片</a></li>
				   <li><a href="javascript:;" onclick="useforpdfshow('生成PDF')">生成PDF电子文档</a></li>
				   <li><a href="javascript:;" onclick="deleteSubject('${currentSubjectEntity.id}')">删除专题</a></li>
               </ul>
           </div>
         </span>
         <span>
           <button onclick="doaction()" class="btn btn-info" id="usepart" style='display:none'>ok</button>
            <span id="action" style="display:none" class="muted"><img src="<%=domain %>loadingred.gif" ><small>正在为你生成...</small></span>
         </span>
          <span class="pull-right">
            <a class="btn" href="<%=rootPath %>/showPartSilderView">
              <i class="icon-expand "></i>幻灯播放
            </a>
            <a class="btn" href="<%=rootPath %>/showSubjectDetailView">
              <i class="icon-refresh"></i>刷新
            </a>
             <a class="btn" href="<%=rootPath %>/subjectComments">
               <i class="icon-comment-alt"></i>评论${currentSubjectEntity.comments }
            </a>
         </span>
			</div>
		</div>
	</div>
</div>
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
						            <a class="btn btn-small" href="javascript:;" onclick="useForSubjectFace('${options.id }','${currentSubjectEntity.id }')">
						               <i class="icon-picture"></i>封面
						            </a>
                                    <a class="btn btn-small" href="<%=rootPath %>/showPartsComments?target=${options.id}">
                                       <i class="icon-comment-alt"></i>评论
                                    </a>
						       </span>
						       	<a href="<%=rootPath %>/partDetail?target=${options.id}"><img src="<%=imgurl %>${options.minimage}" /></a>
						   </div>
							<span class="muted"><small>${options.desc }</small></span><br />
						    <span class="form-inline">
							        <label class="checkbox" style="display:none">
	                                 <input class="thechecks"  type="checkbox"  value="${options.id }" ><span class="text-info">使用</span>
	                                </label>
							    <span class="pull-right muted">
							         <small>
									    <i class="icon-comment"></i>评论${options.comments + options.audios }
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
						            <a class="btn btn-small" href="javascript:;" onclick="useForSubjectFace('${options.id }','${currentSubjectEntity.id }')">
						               <i class="icon-picture"></i>封面
						            </a>
                                   <a class="btn btn-small" href="<%=rootPath %>/showPartsComments?target=${options.id}">
                                       <i class="icon-comment-alt"></i>评论
                                    </a>
						       </span>
						       	<a href="<%=rootPath %>/partDetail?target=${options.id}"><img src="<%=imgurl %>${options.minimage}" /></a>
						   </div>
							<span class="muted"><small>${options.desc }</small></span><br />
						    <span class="form-inline">
							       <label class="checkbox" style="display:none">
	                                 <input class="thechecks"  type="checkbox" value="${options.id }"><span class="text-info">使用</span>
	                                </label>
							     <span class="pull-right muted">
							         <small>
									    <i class="icon-comment"></i>评论${options.comments + options.audios }
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
						            <a class="btn btn-small" href="javascript:;" onclick="useForSubjectFace('${options.id }','${currentSubjectEntity.id }')">
						               <i class="icon-picture"></i>封面
						            </a>
                                   <a class="btn btn-small" href="<%=rootPath %>/showPartsComments?target=${options.id}">
                                       <i class="icon-comment-alt"></i>评论
                                    </a>
						       </span>
						       	<a href="<%=rootPath %>/partDetail?target=${options.id}"><img src="<%=imgurl %>${options.minimage}" /></a>
						   </div>
							<span class="muted"><small>${options.desc }</small></span><br />
						    <span class="form-inline">
							       <label class="checkbox" style="display:none">
	                                 <input  class="thechecks"  type="checkbox" value="${options.id }" ><span class="text-info">使用</span>
	                                </label>
							     <span class="pull-right muted">
							         <small>
									    <i class="icon-comment"></i>评论${options.comments + options.audios }
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
						             <a class="btn btn-small" href="javascript:;" onclick="useForSubjectFace('${options.id }','${currentSubjectEntity.id }')">
						               <i class="icon-picture"></i>封面
						            </a>
                                    <a class="btn btn-small" href="<%=rootPath %>/showPartsComments?target=${options.id}">
                                       <i class="icon-comment-alt"></i>评论
                                    </a>
						       </span>
						       	<a href="<%=rootPath %>/partDetail?target=${options.id}" ><img src="<%=imgurl %>${options.minimage}" /></a>
						   </div>
							<span class="muted"><small>${options.desc }</small></span><br />
						    <span class="form-inline">
							       <label class="checkbox" style="display:none">
	                                 <input class="thechecks" type="checkbox" value="${options.id }"><span class="text-info">使用</span>
	                                </label>
							     <span class="pull-right muted">
							         <small>
									    <i class="icon-comment"></i>评论${options.comments + options.audios }
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
             <img src="<%=domain %>loadingred.gif" >
             <span class="muted"><small>正在努力加载...</small></span>
          </div>
     </div>
 </c:if>    
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
			 <label class="checkbox" >
                <input type="checkbox" id="useforfaceimage" checked="checked"><span class="text-info">设为专题封面</span>
             </label>
          </form>
        </div>
	    <div class="modal-footer">
	      <a href="javascript:;" class="btn btn-primary" onclick="ajaxFileUpload('${currentSubjectEntity.id }','${currentSubjectEntity.tags }','${uservo.id }')">发布</a>
	      <a href="javascript:;" class="btn" onclick="closeCreatePart()">关闭</a>
	    </div>
    </div>
    
    <!--   -->
    <div id="createSubjectWorking" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	    <div class="modal-header">
	       <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	       <h3>进度总结</h3>
        </div>
        <div class="modal-body">
          <form id="planform" action="createProjectPlan" method="post">
			 <span>
				 <small>完成进度</small><br />
				 <input id="tagname" type="text" class="input-block-level" style="width:300px">%
			 </span>
			 <br />
			 <small>写点总结吧</small><br />
			 <textarea id="partinfo" rows="3" style="width:98%" ></textarea>
			 <span class="text-info">优秀的进度管控会让你的制作充满乐趣绝不烂尾.</span>
          </form>
        </div>
	    <div class="modal-footer">
	      <a href="javascript:;" class="btn btn-primary" onclick="saveWorking()">发布</a>
	      <a href="javascript:;" class="btn" onclick="closeCreateSubjectWorking()">关闭</a>
	    </div>
    </div>
   <script type="text/javascript">
     function saveWorking(){
    	 
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
					url:path + "/createPart.action",
					secureuri:false,
					fileElementId:'fileToUpload',
					dataType: 'json',
					data:datas,
					success: function (data, status)
					{  
						if(data.message == "success"){
							$("#loading").hide();
							closeCreatePart();
			    		    window.location.href= path + "/showSubjectDetailView";
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
</body>
</html>
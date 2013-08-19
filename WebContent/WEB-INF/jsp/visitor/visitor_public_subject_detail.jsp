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
     <div class="span2">
        <img class="img-polaroid border-radius" 
            src="<%=imgurl %>${subjectEntity.faceimage }" 
             style="height:140px;width:230px">
     </div>
     <div class="span10">
       <span style="font-size: 20px;"><strong><a href="<%=rootPath%>/vistiorShowUserIndex?target=${targetUserVO.id}">${targetUserVO.name }</a></strong>&nbsp;/&nbsp;${subjectEntity.name }</span>
         &nbsp;
	    <span class="muted"><small>(<i class="icon-tags"></i>${subjectEntity.tags })</small>
         <c:choose>
            <c:when test="${subjectEntity.type == 'PUBLIC'}">
              <span class="label label-success"><i class="icon-hdd"></i>公开</span>
            </c:when>
         </c:choose>
		</span>
         <span class="pull-right">
          <a href="javascript:;" class="btn btn-primary"  onclick="rsssubject('${subjectEntity.id}','${subjectEntity.userid }')"><i class="icon-rss"></i>订阅专题</a>
<%--           <c:if test=""></c:if> --%>
          <a href="javascript:;" class="btn btn-success"  onclick=""><i class="icon-jpy"></i>专题定价</a>
          <br />
            <span class="pull-right">
              <c:if test="${subjectEntity.qrcodeImage != null }">
                <div style="height:3px"></div>
                <img  style="width:85px;" src="<%=imgurl %>${subjectEntity.qrcodeImage}">
              </c:if>
		   </span>
         </span>
        <br />
		<div style="height:3px"></div>
	  <span style="font-size:15px;" class="muted">${subjectEntity.info }</span>
	  <br />
       <div style="height:3px"></div>
        <span class="label label-important">${subjectEntity.category }类 专题</span>
	   <span class="label">最高定价 ${subjectEntity.highMoney } 元</span>
	   <span class="label">最高评分 ${subjectEntity.highPoint} 分</span>
	   <small><a href="#">更多</a></small>
	  <div style="height:3px"></div>   
	   <span >
	     <a href="#" class="btn btn-mini" >喜欢x${subjectEntity.likes }</a>
		 <a href="#" class="btn btn-mini" >礼物x${subjectEntity.gifts }</a>
	   </span>
	   <br />
	   <div style="height:3px"></div>
        <span class="muted"><i class="icon-time"></i>Join Time:${subjectEntity.createTime }</span><br />
		<div style="height:3px"></div>
          <div class="btn-group btn-mini " >
			  <a class="btn btn-mini" href="<%=rootPath %>/visitorShowPartSilderView">
				<i class="icon-expand "></i>幻灯播放
			  </a>
				<button class="btn btn-mini" style="font-family:Microsoft YaHei;"><i class="icon-rss"></i>订阅${subjectEntity.attention }</button>
				 <button class="btn btn-mini" style="font-family:Microsoft YaHei;"><i class="icon-comment-alt"></i>评论${subjectEntity.comments }</button>
				<button class="btn btn-mini" style="font-family:Microsoft YaHei;"><i class="icon-pushpin"></i>Parts${subjectEntity.parts }</button>
		  </div>
		  <span class="pull-right">
		     <div class="btn-group btn-mini" >
				<a class="btn btn-mini" href="javascript:;" onclick="showSubCommentsModal(1)"><i
					class="icon-gift"></i>送礼</a>
				<a class="btn btn-mini" href="javascript:;"
					onclick="showSubCommentsModal(2);setlike('${partEntity.id }','part');"><i
					class="icon-heart"></i>喜欢</a> 
				<a class="btn btn-mini" href="javascript:;"
					onclick="showSubCommentsModal(3)"><i class="icon-trophy"></i>评分</a>
		     </div>
          </span>
        </div>
    </div>
</div>
<br />

  <div id="sendSubCommentModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	    <div class="modal-header">
	       <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	       <h3 id="subCommentsheader">赠送送礼</h3>
        </div>
        <div class="modal-body">
        
               <div class="well" id="gift_this_model" style="display: none">
					<span class="muted">感谢你对&nbsp;<a href="javascript:;">${targetUserVO.name
							}</a>&nbsp;积极分享的肯定 你可以送一个礼物给他
					</span><br /> <span class="pull-right"><a class="btn btn-mini"
						href="javascript:;"
						onclick="sendGift('${partEntity.userid}','${partEntity.id }','part')">送礼</a></span><br />
					<div id="gift_show" style="display: none">
						<center>
							<span class="label label-success"><strong><span
									id="gif_name"></span></strong><img id="gif_image" /></span><br /> <small><span
								id="gif_message" class="muted"></span></small>
						</center>
					</div>
				</div>
				
				
				<div class="well" id="point_this_model" style="display: none">
					<span>1~10分&nbsp;你觉得这个作品能得多少分</span> <br /> <span class="form-inline">
						<select id="point_select" style="width: 60px">
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="7">7</option>
							<option value="8">8</option>
							<option value="9">9</option>
							<option value="10">10</option>
					</select>&nbsp;<a class="btn" href="javascript:;"
						onclick="setPoint('${partEntity.id}','part')">评分</a>
					</span>
					<center id="point_show" style="display: none">
						<br />
						<div style="background-color: #008800;; width: 60px; height: 60px">
							<center>
								<br /> <font style="font-size: 25px;" color="#FFFFFF"><strong><span
										id="point_str"></span>分</strong></font>
							</center>
						</div>
					</center>
				</div>
				
				
        </div>
    </div>
    
<script type="text/javascript">

function showSubCommentsModal(type){
	  if(type == 1){
		  $("#gift_this_model").show();
		  $("#point_this_model").hide();  
	  }else if(type == 2){
		  
	  }else if(type == 3){
		  $("#gift_this_model").hide();
		  $("#point_this_model").show();  
	  }
	
	  $('#sendSubCommentModal').modal({
	      keyboard: false
	  });
}
 
</script>
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
						      <a href="http://service.weibo.com/share/share.php?url=<%=rootPath%>/vistiorShowSubjectDatailFromShare?target=${subjectEntity.id }&pic=<%=imgurl %>${subjectEntity.faceimage }&title=${subjectEntity.name }&nbsp;&nbsp;${subjectEntity.info }" target="_blank">
						                   分享到新浪微博
						       </a>
					       </li>
						   <li>
							   <a href="http://share.v.t.qq.com/index.php?c=share&a=index&url=<%=rootPath%>/vistiorShowSubjectDatailFromShare?target=${subjectEntity.id }&pic=<%=imgurl %>${subjectEntity.faceimage }&title=${subjectEntity.name }&nbsp;&nbsp;${subjectEntity.info }" target="_blank">
							         分享到QQ微信
							   </a>
						   </li>
						   <li>
							   <a href="http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url=<%=rootPath%>/index&pic=<%=imgurl %>${subjectEntity.faceimage }&title=${subjectEntity.name }&nbsp;&summary=${subjectEntity.info }|&nbsp;<%=rootPath%>/vistiorShowSubjectDatailFromShare?target=${partEntity.id }" target="_blank">
							         分享到QQ空间
							   </a>
						  </li>
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
             <img src="<%=domain %>loadingred.gif" >
             <span class="muted"><small>正在努力加载...</small></span>
          </div>
     </div>
 </c:if>    
<br /><br /><br />
 <%@ include file="../../../footinclude.jsp"%>
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
</body>
</html>
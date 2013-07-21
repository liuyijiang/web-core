<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri= "http://java.sun.com/jsp/jstl/core" prefix= "c" %> 
<div class="container">
  <div class="row">
     <div class="span1">
        <img class="img-polaroid border-radius" 
         src="<%=imgurl %>${uservo.image }" >
     </div>
     <div class="span11">
        <span style="font-size: 20px;"><strong>${uservo.name } </strong>
        <c:if test="${uservo.sex == 1 }" >
           <img src="<%=assets%>mxkimage/male1.png">
        </c:if>
         <c:if test="${uservo.sex == 0 }" >
           <img src="<%=assets%>mxkimage/male2.png">
        </c:if>
        <a class="btn btn-warning btn-mini" href="<%=rootPath%>/updateUserView">编辑</a></span>
           <span class="pull-right">
              <a onclick="showCreatePart()" href="javascript:;" class="btn btn-success"><i class="icon-rss-sign"></i>分享Part</a>
              <a href="showCreateSubjectView" class="btn btn-info"><i class="icon-plus-sign"></i>创建专辑</a>
           </span>
        <br />
        <span class="muted">${uservo.info }</span><br />
        <span><i class="icon-time"></i>Join Time:${uservo.createTime }</span>
        
         <div class="btn-group pull-right " >
				  <a href="<%=rootPath%>/userIndex" class="btn btn-mini" style="font-family:Microsoft YaHei;"><i class="icon-hdd"></i>专题${uservo.subject }</a>
				  <a href="<%=rootPath%>/userFoucsView" class="btn btn-mini" style="font-family:Microsoft YaHei;"><i class="icon-rss"></i>关注${uservo.focus }</a>
				  <a href="<%=rootPath%>/userFollowersView" class="btn btn-mini" style="font-family:Microsoft YaHei;"><i class="icon-group"></i>粉丝${uservo.followors }</a>
		 </div>
        <br />
     </div>
  </div>
</div>
<br />

<div id="createPartModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	    <div class="modal-header">
	       <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	       <h3>快速分享Part</h3>
        </div>
        <div class="modal-body">
          <form id="planform" action="createProjectPlan" enctype="multipart/form-data"
				method="post">
			 <span class="muted">把你看到你做过的经典分享给大家</span>	
			 <span>
				 <img id="loading" src="<%=domain %>loadingred.gif" style="display:none">
			 </span>
			 <br />
			 <div class="btn-group">
                      <a class="btn dropdown-toggle btn " data-toggle="dropdown" href="javascript:;">
                        <i class="icon-tags"></i><span id="showtags">Part标签</span>
                      <span class="caret"></span>
				    </a>
				     <ul class="dropdown-menu">
					   <li><a href="javascript:;" onclick="chooseTags('舰船模型')">舰船模型</a></li>
					   <li><a href="javascript:;" onclick="chooseTags('装甲模型')">装甲模型</a></li>
					   <li><a href="javascript:;" onclick="chooseTags('战机模型')">战机模型</a></li>
					   <li><a href="javascript:;" onclick="chooseTags('手办模型')">手办模型</a></li>
					   <li><a href="javascript:;" onclick="chooseTags('动漫模型')">动漫模型</a></li>
					   <li><a href="javascript:;" onclick="chooseTags('高达模型')">高达模型</a></li>
					   <li><a href="javascript:;" onclick="chooseTags('其他模型')">其他模型</a></li>
		               </ul>
				    </div>
			 <input id="fileToUpload" type="file" size="45" name="image"  /><br />
			 <small>写点描述吧</small><br />
			 <textarea id="partinfo" rows="3" style="width:98%" ></textarea>
          </form>
        </div>
	    <div class="modal-footer">
	      <a href="javascript:;" class="btn btn-primary" onclick="ajaxFileUpload()">发布</a>
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

function chooseTags(tag){
	tags = tag;
	$('#showtags').html(tag);
	   
}
</script>
<script type="text/javascript"> 
   var tags = '';

   function validateImage() {
  	  return true;
   }
  
  
	function ajaxFileUpload()
	{   
		if(validateImage()){
			var info = $('#partinfo').val();
			if(tags == ''){
				alert("为Part加个标签吧！");
				return ;
			}
			var datas = {"createPartRequest.desc":info,"createPartRequest.type":tags};
			$("#loading").show();
			$.ajaxFileUpload
			(
				{
					url:path + "/createSinglePart.action",
					secureuri:false,
					fileElementId:'fileToUpload',
					dataType: 'json',
					data:datas,
					success: function (data, status)
					{  
						if(data.message == "success"){
							$("#loading").hide();
							closeCreatePart();
			    		    window.location.href= path + "/userSharePartsIndex";
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
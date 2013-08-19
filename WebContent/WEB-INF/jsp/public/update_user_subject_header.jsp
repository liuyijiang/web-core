<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri= "http://java.sun.com/jsp/jstl/core" prefix= "c" %> 
<div class="container">
  <div class="row">
     <div class="span2">
        <img class="img-polaroid border-radius" 
            src="<%=imgurl %>${currentSubjectEntity.faceimage }" 
             style="height:140px;width:230px">
     </div>
     <div class="span10">
       <span style="font-size: 20px;"><strong>${uservo.name }</strong>&nbsp;/&nbsp;${currentSubjectEntity.name }</span>
         &nbsp;
	    <span class="muted"><small>(<i class="icon-tags"></i>${currentSubjectEntity.tags })</small>
         <c:choose>
            <c:when test="${currentSubjectEntity.type == 'PUBLIC'}">
              <span class="label label-success"><i class="icon-hdd"></i>公开</span>
            </c:when>
            <c:when test="${currentSubjectEntity.type == 'PRIVATE'}">
               <span class="label label-important"> <i class="icon-lock"></i>私有</span>
            </c:when>
         </c:choose>
		</span>
         <span class="pull-right">
           <a href="javascript:;" class="btn btn-info" onclick="showCreatePart()"><i class="icon-pushpin"></i>添加Part</a>
            <a class="btn btn-inverse" href="javascript:;" onclick="showCreateMaterial()">
              <i class="icon-calendar "></i>材料列表
            </a>
            <br />
            <span class="pull-right">
              <c:if test="${currentSubjectEntity.qrcodeImage != null }">
                <div style="height:3px"></div>
                <img  style="width:85px;" src="<%=imgurl %>${currentSubjectEntity.qrcodeImage}">
              </c:if>
               <span id="qrcodeloading" style="display:none" >
	             <img src="<%=domain %>loadingred.gif" >
	             <span class="muted"><small>正在生成...</small></span>
               </span>
		   </span>
         </span>
        <br />
		<div style="height:3px"></div>
	  <span style="font-size:15px;" class="muted">${currentSubjectEntity.info }</span><br />
       <div style="height:3px"></div>
       <span class="label label-important">${currentSubjectEntity.category }类 专题</span>
	   <span class="label">最高定价 ${currentSubjectEntity.highMoney } 元</span>
	   <span class="label">最高评分 ${currentSubjectEntity.highPoint} 分</span>
	   <small><a href="#">更多</a></small>
	  <div style="height:3px"></div>   
	   <span >
	     <a href="#" class="btn btn-mini" >喜欢x${currentSubjectEntity.likes }</a>
		 <a href="#" class="btn btn-mini" >礼物x${currentSubjectEntity.gifts }</a>
	   </span>
        <c:if test="${subjectExtraEntity.pdfUrl != '-' }">
             <a class="btn btn-mini" href="<%=pdf %>${subjectExtraEntity.pdfUrl}" target="_blank"><i class='icon-download-alt'></i>下载PDF</a>
          </c:if>
          <c:if test="${subjectExtraEntity.gifUrl != '-' }">
             <button class="btn btn-mini" onclick="showGifSubject()" ><i class="icon-picture"></i>查看GIF</button>
          </c:if>
	   <br />
	   <div style="height:3px"></div>
        <span class="muted"><i class="icon-time"></i>Join Time:${currentSubjectEntity.createTime }</span><br />
		<div style="height:3px"></div>
          <div class="btn-group btn-mini" >
			  <a class="btn btn-mini" href="<%=rootPath %>/visitorShowPartSilderView">
				<i class="icon-expand "></i>幻灯播放
			  </a>
			 <a href="<%=rootPath %>/subjectMessage" class="btn btn-mini" style="font-family:Microsoft YaHei;"><i class="icon-rss"></i>订阅${currentSubjectEntity.attention }</a>
			  <a href="<%=rootPath %>/subjectCommentsText"class="btn btn-mini" style="font-family:Microsoft YaHei;"><i class="icon-comment-alt"></i>评论${currentSubjectEntity.comments }</a>
			  <a class="btn btn-mini" style="font-family:Microsoft YaHei;"><i class="icon-pushpin"></i>Parts${currentSubjectEntity.parts }</a>
		  </div>
		  <span class="pull-right">
		    <a class="btn btn-mini" href="javascript:;" onclick="createqrcode('${currentSubjectEntity.id}')"><i class="icon-qrcode"></i>生产二维码</a>
		  </span>
        </div>
    </div>
</div>
<br />
 <script type="text/javascript">
    function createqrcode(id){
    	$("#qrcodeloading").show();
    	$.ajax({
       		url : path + "/createSubjectQrCode",
       		type : "POST",
       		cache : false,
       		async : false,
       		data : {"targetId":id},
       		dataType : "json",
       		success : function(item) {
       		    if(item == 'success'){
       		    	  $("#qrcodeloading").hide();
       		         location.reload(); 
    		    }else if( item == 'error'){
    		   	   alert("网络异常请重试");
    		    }else {
    		     	alert(item);
    		    }
       		  }
     	 }); 
    }
 </script>
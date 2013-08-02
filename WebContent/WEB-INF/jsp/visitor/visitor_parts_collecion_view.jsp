<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.opensymphony.xwork2.util.ValueStack"%>
<%@page import="org.apache.struts2.ServletActionContext"%>
<%@page import="com.mxk.org.web.visitor.domain.*"%>
<%@page import="com.mxk.org.entity.CollectInformationEntity"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="../../../headerinclude.jsp"%>
</head>
<body class="mxkbody mxkbackgroud" >
<%@ include file="../public/user_page_header.jsp"%>
<c:if test="${!empty subjectEntity }">
<div class="container">
  <div class="row">
     <div class="span1">
        <img class="img-polaroid border-radius"  style="height:60px;width:60px"
         src="<%=imgurl %>${subjectEntity.faceimage }" >
     </div>
     <div class="span11">
        <span>
          <span style="font-size: 20px;"><strong><a href="<%=rootPath%>/vistiorShowUserIndex?target=${targetUserVO.id}">${targetUserVO.name }</a>&nbsp;/&nbsp;${subjectEntity.name }</strong></span>
             &nbsp;<span class="muted"><small>(<i class="icon-tags"></i>${subjectEntity.tags }-${subjectEntity.category})</small>
                <c:choose>
	             <c:when test="${subjectEntity.type == 'PUBLIC'}">
                  <span class="label label-success">
                       <i class="icon-hdd"></i>公开
		          </span>
                </c:when>
                <c:when test="${subjectEntity.type == 'PRIVATE'}">
                  <span class="label label-important">
                       <i class="icon-lock"></i>私有
				   </span>
                </c:when>
                </c:choose>
           </span>
        </span> 
        <span class="pull-right">
           <a class="btn" href="<%=rootPath %>/vistiorShowSubjectDatail?target=${subjectEntity.id }"><i class="icon-hdd"></i>查看专题</a>
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
        <span class="pull-right">
          <i class="icon-time"></i>Create Time:${subjectEntity.createTime }
        </span>
     </div>
  </div>
</div>
<br />
</c:if>


<c:if test="${empty subjectEntity }">
<div class="container">
  <div class="row">
     <div class="span1">
        <img class="img-polaroid border-radius" 
         src="<%=imgurl %>${targetUserVO.image }" >
     </div>
     <div class="span11">
       <span style="font-size: 20px;"><strong>From:&nbsp;<a href="<%=rootPath%>/vistiorShowUserIndex?target=${targetUserVO.id}">${targetUserVO.name }</a></strong></span>
        <c:if test="${targetUserVO.sex == 1 }" >
           <img src="<%=assets%>mxkimage/male1.png">
        </c:if>
         <c:if test="${targetUserVO.sex == 0 }" >
           <img src="<%=assets%>mxkimage/male2.png">
        </c:if>
        <span class="pull-right">
            <a href="visitorShowPartDetail?target=${partEntity.id }" class="btn">
               <i class="icon-list"></i>Parts详情
            </a>
         </span><br />
        <span>${targetUserVO.info }</span><br />
        <span><i class="icon-time"></i>Create Time:${partEntity.createTime }</span>
        <span class="pull-right">
		  <span class="label"><i class="icon-pushpin"></i>收藏${partEntity.collect  }</span>
        </span>
     </div>
   </div>
</div>    
<br />
</c:if>

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
						      <a href="http://service.weibo.com/share/share.php?url=<%=rootPath%>/visitorShowPartDetailFromShare?target=${partEntity.id }&pic=<%=imgurl %>${partEntity.image }&title=${subjectEntity.name }&nbsp;&nbsp;${partEntity.desc }" target="_blank">
						                   分享到新浪微博
						       </a>
					       </li>
						   <li>
							   <a href="http://share.v.t.qq.com/index.php?c=share&a=index&url=<%=rootPath%>/visitorShowPartDetailFromShare?target=${partEntity.id }&pic=<%=imgurl %>${partEntity.image }&title=${subjectEntity.name }&nbsp;&nbsp;${partEntity.desc }" target="_blank">
							         分享到QQ微信
							   </a>
						   </li>
						   <li>
							   <a href="http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url=<%=rootPath%>/index&pic=<%=imgurl %>${partEntity.image }&title=${subjectEntity.name }&nbsp;&summary=${partEntity.desc }|&nbsp;<%=rootPath%>/visitorShowPartDetailFromShare?target=${partEntity.id }" target="_blank">
							         分享到QQ空间
							   </a>
						  </li>
		               </ul>
				    </div>
              </span>
             <span class="pull-right">
	            <a class="btn" href="<%=rootPath %>/showSubjectDetailView">
	              <i class="icon-refresh"></i>刷新
	            </a>
	              <a class="btn btn-danger" href="javascript:;" onclick="collectPart('${partEntity.id}')">
		               <i class="icon-pushpin"></i>收藏
		           </a>
             </span>
		</div>
	</div>
</div>

  	<div class="container">
  	  <div class="row">
  	  
  	       <div class="span3">
  	       <span id="loaddiv" style="display:none" >
             <img src="<%=domain %>loadingred.gif" >
             <span class="muted"><small>正在努力加载...</small></span>
          </span>
	  	      <ul id="us" class="thumbnails">
				 
			</ul>
  	    </div>
  	  
         <div class="span9" >
		  	<div id="tprs" style="position:absolute;" class="mxkplan mxkshadow">
		  		<img class="img-polaroid" src="<%=imgurl%>${partEntity.image}">
		  		<%
					ValueStack v = ServletActionContext.getValueStack(request);
					CollectPartsPointReponse col  =  (CollectPartsPointReponse) v.findValue("collectPartsPointReponse");
					if(col != null){
						List<CollectPartsDataReponse> list = col.getList();
						if(list != null && !list.isEmpty()){
							for (CollectPartsDataReponse c : list) {
								CollectInformationEntity cn = c.getEntity();
								out.println("<div style='top:"+c.getTop()+"px; left:"+c.getLeft()+"px; position:absolute'><a onclick='showUser(\""+ cn.getCollecterId() +"\")' href='javascript:;' title='"+ cn.getCollecterName() +"'><img src='http://www.waileecn.com/mxk/assets/mxkimage/"+cn.getPin()+"' /></a></div>");	
							}
						}
					}
               %>
			</div>
        </div>  	    
  	  
  	  </div>
  	</div>
  	<%@ include file="../../../footinclude.jsp"%>
  	  	<script type="text/javascript">
  	   function showUser(id){
  		 $('#loaddiv').show();
  		 $.ajax({
 	   		url : path + "/visitorSeeUser.action",
 	   		type : "POST",
 	   		cache : false,
 	   		async : false,
 	   		data: {"target":id},
 	   		dataType : "json",
 	   		success : function(item) {
 	   			$('#loaddiv').hide();
 	   		    createUser(item);
 	   		 }
 	 	 });  
  	   }
  	   
  	  function createUser(item){
  		var show = '';
  		show = "<li class='span3 mxkplan mxkshadow'><div class='thumbnail'>" +
  		"<img src='"+ imgurl + item.image +"'><span><a href='"+ path +"/vistiorShowUserIndex?target="+ item.id +"'>"+ item.name +"</a></span><br />" +
  		"<span><small>"+ item.info +"</small></span><br />" +
  		"<span class='pull-right'><a href='javascript:;' class='btn btn-inverse btn-small' onclick='createUserRelation(\""+ item.id + "\")'><i class='icon-plus'></i>加关注</a></span>" +
	    "<br/><br/></div></li>";
  		$("#us").html(show);
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
  </body>
</html>
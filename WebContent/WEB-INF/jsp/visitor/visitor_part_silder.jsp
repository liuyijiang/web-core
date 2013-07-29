<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="../../../headerinclude.jsp"%>
</head>
<body class="mxkbody mxkbackgroud" >
<%@ include file="../public/user_page_header.jsp"%>
<div class="container">
   <span style="font-size: 20px;"><strong>${subjectEntity.name } </strong></span>
   <span>
      	<span class="label">${subjectEntity.category }</span>
                      	 <c:choose>
		                <c:when test="${subjectEntity.type == 'PUBLIC'}">
                           <span class="label label-success">
                              <i class="icon-hdd"></i>公开
						   </span>
		                </c:when>
		                <c:when test="${subjectEntity.type == 'FOR-ALL'}">
		                  <span class="label label-warning">
                             <i class="icon-globe"></i>共享
						   </span>
		                </c:when>
		                <c:when test="${subjectEntity.type == 'PRIVATE'}">
		                  <span class="label label-important">
                             <i class="icon-globe"></i>私有
						   </span>
		                </c:when>
		             </c:choose>
   
   </span>
</div>
<div class="container">
     
     <div class="row">
        <div class="span9 mxkplan mxkshadow">
           <div id="myCarousel" class="carousel slide">
		      <div class="carousel-inner">
		       <c:forEach var="options" items="${partsAllResponse.list }" varStatus="status">
		        <c:if test="${status.index == 0 }">
		          <div class="item active">
		           <img src="<%=imgurl %>${options.image }" >
                   <div class="container">
		            <div class="carousel-caption">
		              <span class="lead"><font color="#FFFFFF">${options.desc }</font></span>
		            </div>
                  </div>
                </div>
		        </c:if>
		        <c:if test="${status.index != 0 }">
		          <div class="item">
		           <img src="<%=imgurl %>${options.image }" >
                  <div class="container">
		            <div class="carousel-caption">
		              <span class="lead"><font color="#FFFFFF">${options.desc }</font></span>
		            </div>
                  </div>
                </div>
		        </c:if>
		       </c:forEach>
           </div>
		   <a class="left carousel-control" href="#myCarousel" data-slide="prev">&lsaquo;</a>
		   <a class="right carousel-control" href="#myCarousel" data-slide="next">&rsaquo;</a>
          </div>
       </div>
        
        <div class="span3 ">
          <ul class="thumbnails" >
              <li class="span3 mxkplan mxkshadow">
	            <div class="thumbnail">
	               <img  src="<%=imgurl %>${targetUserVO.image }" >
	               <span ><strong>${targetUserVO.name } </strong>
				        <c:if test="${targetUserVO.sex == 1 }" >
				           <img src="<%=assets%>mxkimage/male1.png">
				        </c:if>
				         <c:if test="${uservo.sex == 0 }" >
				           <img src="<%=assets%>mxkimage/male2.png">
				        </c:if></span>
                     <br />
                    <span class="muted">${targetUserVO.info }</span><br />
                    <span class="pull-right">
                          <a class="btn btn-primary" href="<%=rootPath %>/visitiorShowSubjectComements?target=${subjectEntity.id}"><i class="icon-comments-alt"></i>评论专题</a>
			              <a href="javascript:;" class="btn btn-inverse" onclick="createUserRelation('${targetUserVO.id}')"><i class="icon-plus"></i>加关注</a>
			         </span><br /><br />
	             </div>
		      </li>
			</ul>
        </div>
        
        
     </div>
 
 
</div>
<script type="text/javascript">
  
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
<%@ include file="../../../footinclude.jsp"%>
</body>
</html>
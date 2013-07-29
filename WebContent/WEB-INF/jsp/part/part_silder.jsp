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
   <span style="font-size: 20px;"><strong>${currentSubjectEntity.name } </strong></span>
   <span>
      	<span class="label">${currentSubjectEntity.category }</span>
                      	 <c:choose>
		                <c:when test="${currentSubjectEntity.type == 'PUBLIC'}">
                           <span class="label label-success">
                              <i class="icon-hdd"></i>公开
						   </span>
		                </c:when>
		                <c:when test="${currentSubjectEntity.type == 'FOR-ALL'}">
		                  <span class="label label-warning">
                             <i class="icon-globe"></i>共享
						   </span>
		                </c:when>
		                <c:when test="${currentSubjectEntity.type == 'PRIVATE'}">
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
	               <img  src="<%=imgurl %>${uservo.image }" >
	               <span ><strong>${uservo.name } </strong>
				        <c:if test="${uservo.sex == 1 }" >
				           <img src="<%=assets%>mxkimage/male1.png">
				        </c:if>
				         <c:if test="${uservo.sex == 0 }" >
				           <img src="<%=assets%>mxkimage/male2.png">
				        </c:if>
                      <a class="btn btn-success btn-mini" href="<%=rootPath%>/updateUserView">编辑</a></span>
                     <br />
                    <span class="muted">${uservo.info }</span><br />
                    <span class="pull-right">
			              <a href="showCreateSubjectView" class="btn btn-info"><i class="icon-plus-sign"></i>创建专辑</a>
			         </span><br /><br />
	             </div>
		      </li>
			</ul>
        </div>
        
        
     </div>
 
 
</div>
<%@ include file="../../../footinclude.jsp"%>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
 <%@ include file="../../../headerinclude.jsp"%>
</head>
<body class="mxkbody  mxkbackgroud" >
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
             <c:choose>
                <c:when test="${currentSubjectEntity.type == 'PUBLIC'}">
                  <a class="btn btn-success btn-mini" href="#">公开</a>
                </c:when>
                <c:when test="${currentSubjectEntity.type == 'PRIVATE'}">
                  <a class="btn btn-danger btn-mini" href="#">私有</a>
                </c:when>
                <c:when test="${currentSubjectEntity.type == 'FOR-ALL'}">
                  <a class="btn btn-warning btn-mini" href="#">共享</a>
                </c:when>
             </c:choose>
           </span>
        </span>
        <span class="pull-right">
             <a class="btn" href="showSubjectDetailView">
               <i class="icon-edit"></i>继续编辑
             </a>  
         </span>
        <br />
        <span class="muted"><small>${currentSubjectEntity.info }</small></span><br />
        <span><i class="icon-time"></i>Create Time:${currentSubjectEntity.createTime }</span>
        <br />
     </div>
  </div>
  <hr />

</body>
</html>
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
        <a class="btn btn-success btn-mini" href="<%=rootPath%>/updateUserView">编辑</a></span>
           <span class="pull-right">
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
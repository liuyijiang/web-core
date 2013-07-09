<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri= "http://java.sun.com/jsp/jstl/core" prefix= "c" %> 
<div class="container">
  <div class="row">
     <div class="span1">
       <img class="img-polaroid border-radius" 
         src="<%=imgurl %>${targetUserVO.image }" >
     </div>
     <div class="span11">
        <span style="font-size: 20px;"><strong>${targetUserVO.name }</strong></span>
        <c:if test="${targetUserVO.sex == 1 }" >
           <img src="<%=assets%>mxkimage/male1.png">
        </c:if>
         <c:if test="${targetUserVO.sex == 0 }" >
           <img src="<%=assets%>mxkimage/male2.png">
        </c:if>
        <span class="muted"><small>(<i class="icon-tags"></i>${targetUserVO.interest })</small></span>
           <span class="pull-right">
             <a href="javascript:;" class="btn btn-inverse" onclick="createUserRelation('${targetUserVO.id}')"><i class="icon-plus"></i>加关注</a>
           </span>
        <br /> 
        <span class="muted">${targetUserVO.info }</span><br />
        <span>
           <i class="icon-time"></i>Join Time:${targetUserVO.createTime }
         </span>
         <div class="btn-group pull-right">
		  <a href="#" class="btn btn-mini" style="font-family:Microsoft YaHei;"><i class="icon-hdd"></i>专题${targetUserVO.subject }</a>
		  <a href="#" class="btn btn-mini" style="font-family:Microsoft YaHei;"><i class="icon-rss"></i>关注${targetUserVO.focus }</a>
		  <a href="#" class="btn btn-mini" style="font-family:Microsoft YaHei;"><i class="icon-group"></i>粉丝${targetUserVO.followors }</a>
		 </div>
        <br />
     </div>
  </div>
</div>
<br />
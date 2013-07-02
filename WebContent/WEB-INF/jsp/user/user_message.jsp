<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
 <%@ include file="../../../headerinclude.jsp"%>
</head>
<body class="mxkbody mxkbackgroud">
<%@ include file="../public/user_page_header.jsp"%>
<%@ include file="../public/user_public_header.jsp"%>
<div class="container ">
		<div class="navbar">
			<div class="navbar-inner">
				<ul class="nav" >
					<li>
					<a href="<%=rootPath%>/userIndex">&nbsp;<i class="icon-hdd"></i>我的专辑&nbsp;</a>
					</li>
					<li class="divider-vertical"></li>
					<li>
					<a href="#">&nbsp;<i class="icon-rss"></i>我的关注&nbsp;</a>
					</li>
					<li class="divider-vertical"></li>
					<li>
					<a href="<%=rootPath%>/userCollectIndex">&nbsp;<i class="icon-pushpin"></i>我的收藏&nbsp;</a>
					</li>
					<li class="divider-vertical"></li>
				</ul>
				<span class="pull-right">
                    <div class="btn-group" >
					  <a href="<%=rootPath %>/showUserRssSubject" class="btn" style="font-family:Microsoft YaHei;"><i class="icon-rss"></i>我的订阅${uservo.rsssubject }</a>
					  <a href="<%=rootPath %>/showUserJoinSubject" class="btn" style="font-family:Microsoft YaHei;"><i class="icon-external-link"></i>我参与的${uservo.joinsubject }</a>
			          <a href="<%=rootPath%>/userOnMessage" class="btn active" style="font-family:Microsoft YaHei;"><i class="icon-envelope-alt"></i>我的消息${uservo.message }</a>
	                </div>
                </span>
			</div>
		</div>
	</div>
 <div class="container" >
   <div class="row" id="messagelist">
     <c:forEach var="options" items="${loadUserMessageRespone.list }">
       <span class="span12" >
	       <img style="width:18px" class="img-polaroid border-radius"  src="<%=imgurl %>${options.userimage }"/>
	       <span><a href="#">${options.username }</a>评论了你的
	       <c:if test="${options.type == 'part'}">
	          part
	       </c:if>
	       <c:if test="${options.type == 'subject'}">
	                              专题
	       </c:if>
	       <a href="<%=rootPath %>/userSeeMessageDetail?target=${options.id}">去看看</a></span>
       </span>
       <br /><br />
     </c:forEach>
    </div>
    <c:if test="${uservo.message > 12 }">
      <a href="" class="pull-right btn btn-primary btn-small"><i class="icon-refresh"></i>更多消息</a>
    </c:if>
</div>
<%@ include file="../../../footinclude.jsp"%>
</body>
</html>
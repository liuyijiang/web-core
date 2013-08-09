<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="../../../headerinclude.jsp"%>
</head>
<body class="mxkbody mxkbackgroud">
<%@ include file="../public/part_dash_board_header.jsp"%>  
<br /><br /><br />
<div class="container">
<span style="font-size:20px"><strong>最近7天最火Part Top10</strong></span>
<span class="pull-right">
           <div class="btn-group">
             <a class="btn dropdown-toggle btn " data-toggle="dropdown" href="#">
               <span id="category_btn"><i class="icon-certificate"></i>分类</span>
               <span class="caret"></span>
		     </a>
		     <ul class="dropdown-menu">
			       <li><a href="javascript:;" onclick="choosecategory('原创')">原创</a></li>
				   <li><a href="javascript:;" onclick="choosecategory('分享')">分享</a></li>
              </ul>
		   </div>
</span><br />
 <c:forEach var="options" items="${topRespone.list }">
    <div class="row">
      <div class="span12 mxkplan ${options.shadow }" style="padding:5px;" >
         <div class="row">
           <div class="span2">
             <a href="<%=rootPath %>/visitorShowPartDetail?target=${options.id}">
                 <img class="img-polaroid border-radius" 
                 src="<%=imgurl %>${options.minimage}">
             </a>
           </div>
           <div class="span10">
              <div class="row">
                 <span class="span8"> 
                   <a href="" class="btn btn-danger"><i class="icon-pushpin"></i>收藏</a>
                   <a href="" class="btn btn-primary"><i class="icon-comment"></i>评论</a>
                   <br />
                    <span class="muted"><i class="icon-time">${options.createTime }</i></span> 
                                                             由&nbsp;<a href="<%=rootPath%>/vistiorShowUserIndex?target=${options.userid}">${options.username }</a>&nbsp;分享<br />
                    <span class="muted">${options.desc }</span>
                    <br />
                    <span class="label">${options.type }</span>
                    <span class="">
                        <span class="label label-success">语音${options.audios }</span>
                     	<span class="label label-info">文字${options.comments }</span>
                     	<span class="label label-warning">收藏${options.collect }</span>
                    </span>
                  <h4>关注次数${options.audios + options.comments + options.collect }</h4>
                 </span>
                 <span class="pull-right span1">
                    <img  src="<%=imgurl %>${options.userimage}" />
                    <br />
                    <a href="#" class="btn btn-small">加关注</a>
                 </span>
              </div>
           </div>
         </div>
      </div>
   </div><!-- end row -->
    <br />
 </c:forEach>
</div>
 <%@ include file="../../../basefootinclude.jsp"%>
</body>
</html>
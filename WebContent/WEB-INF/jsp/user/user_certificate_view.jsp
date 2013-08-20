<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
 <%@ include file="../../../headerinclude.jsp"%>
</head>
<body class="mxkbody mxkbackgroud" onload="">
<%@ include file="../public/user_page_header.jsp"%>
<%@ include file="../public/update_user_public_header.jsp"%> 
<div class="container ">
		<div class="navbar">
			<div class="navbar-inner">
				<ul class="nav" >
				    <li>
					<a href="<%=rootPath%>/userSharePartsIndex">&nbsp;<i class="icon-rss-sign"></i>单图分享</a>
					</li>
					<li class="divider-vertical"></li>
					<li>
					<a href="<%=rootPath%>/userIndex">&nbsp;<i class="icon-hdd"></i>我的专辑&nbsp;</a>
					</li>
					<li class="divider-vertical"></li>
					<li>
					<a href="<%=rootPath%>/showNewRssMessage">&nbsp;<i class="icon-rss"></i>我的关注&nbsp;</a>
					</li>
					<li class="divider-vertical"></li>
					<li>
					<a href="<%=rootPath%>/userCollectIndex">&nbsp;<i class="icon-pushpin"></i>我的收藏&nbsp;</a>
					</li>
					<li class="divider-vertical"></li>
				</ul>
				<span class="pull-right">
				   <ul class="nav">
				    <li class="active">
					<a href="#">&nbsp;<i class="icon-bookmark"></i>我的证书&nbsp;</a>
					</li>
					</ul>
                </span>
			</div>
		</div>
	</div>
 <div class="container">
   <c:if test="${empty certificateRespone }">
	  <div class="alert alert-block">
	     <a class="close" data-dismiss="alert">×</a>
	     <h4 class="alert-heading">你还没有获得证书!</h4>
	                         分享 评论 发布专辑都可以获得积分得到证书
	  </div>
    </c:if>
</div>    
<div class="container">
	<c:if test="${!empty certificateRespone }">
	    <div class="row">
	       <div class="span3">
	         <ul class="thumbnails" id="planshow1"> 
	           <c:forEach var="options" items="${certificateRespone.list1 }"> 
	              <li class="span3 mxkplan mxkshadow">
	                  <div class="thumbnail">
	                   <div style="position:relative;" onmouseover="mouseover('${options.id }')" onmouseout="mouseout('${options.id }')" > 
	                    <span style="position:absolute; z-index:-1; opacity: 0.8;" id="${options.id }">
	                      <span class="label label-info">获证时间：${options.createTime }</span>
	                    </span>
	                    <img src="<%=imgurl %>${options.imageurl }" />
	                    </div>
	                    <span class='label'><img src="<%=metootitle%>${options.titleImage }">${options.title}</span>
	                    <span class="pull-right">
	                          <div class="btn-group">
			                      <a class="btn dropdown-toggle btn-mini btn-danger" data-toggle="dropdown" href="#">
			                        <i class="icon-globe"></i>分享
			                        <span class="caret"></span>
				                  </a>
							     <ul class="dropdown-menu">
								       <li>
									      <a href="http://service.weibo.com/share/share.php?url=<%=rootPath%>/vistiorShowUserIndex?target=${uservo.id }&pic=<%=imgurl %>${options.imageurl }&title=我获得了一个新证书&nbsp;&nbsp;${options.title }" target="_blank">
									                   分享到新浪微博
									       </a>
								       </li>
									   <li>
										   <a href="http://share.v.t.qq.com/index.php?c=share&a=index&url=<%=rootPath%>/vistiorShowUserIndex?target=${uservo.id }&pic=<%=imgurl %>${options.imageurl }&title=我获得了一个新证书&nbsp;&nbsp;${options.title}" target="_blank">
										         分享到QQ微信
										   </a>
									   </li>
									   <li>
										   <a href="http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url=<%=rootPath%>/index&pic=<%=imgurl %>${options.imageurl }&title=我获得了一个新证书&nbsp;&summary=${options.title}|&nbsp;<%=rootPath%>/vistiorShowUserIndex?target=${partEntity.id }" target="_blank">
										         分享到QQ空间
										   </a>
									  </li>
					               </ul>
				             </div>
	                    </span>
	                  </div>
	              </li>
	           </c:forEach>
	         </ul>
	       </div>
	       
	        <div class="span3">
	         <ul class="thumbnails" id="planshow1"> 
	           <c:forEach var="options" items="${certificateRespone.list2 }"> 
	              <li class="span3 mxkplan mxkshadow">
	                  <div class="thumbnail">
	                   <div style="position:relative;" onmouseover="mouseover('${options.id }')" onmouseout="mouseout('${options.id }')" > 
	                    <span style="position:absolute; z-index:-1; opacity: 0.8;" id="${options.id }">
	                      <span class="label label-info">获证时间：${options.createTime }</span>
	                    </span>
	                    <img src="<%=imgurl %>${options.imageurl }" />
	                    </div>
	                    <span class='label'><img src="<%=metootitle%>${options.titleImage }">${options.title}</span>
	                    <span class="pull-right">
	                          <div class="btn-group">
			                      <a class="btn dropdown-toggle btn-mini btn-danger" data-toggle="dropdown" href="#">
			                        <i class="icon-globe"></i>分享
			                        <span class="caret"></span>
				                  </a>
							     <ul class="dropdown-menu">
								       <li>
									      <a href="http://service.weibo.com/share/share.php?url=<%=rootPath%>/vistiorShowUserIndex?target=${uservo.id }&pic=<%=imgurl %>${options.imageurl }&title=我获得了一个新证书&nbsp;&nbsp;${options.title }" target="_blank">
									                   分享到新浪微博
									       </a>
								       </li>
									   <li>
										   <a href="http://share.v.t.qq.com/index.php?c=share&a=index&url=<%=rootPath%>/vistiorShowUserIndex?target=${uservo.id }&pic=<%=imgurl %>${options.imageurl }&title=我获得了一个新证书&nbsp;&nbsp;${options.title}" target="_blank">
										         分享到QQ微信
										   </a>
									   </li>
									   <li>
										   <a href="http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url=<%=rootPath%>/index&pic=<%=imgurl %>${options.imageurl }&title=我获得了一个新证书&nbsp;&summary=${options.title}|&nbsp;<%=rootPath%>/vistiorShowUserIndex?target=${partEntity.id }" target="_blank">
										         分享到QQ空间
										   </a>
									  </li>
					               </ul>
				             </div>
	                    </span>
	                  </div>
	              </li>
	           </c:forEach>
	         </ul>
	       </div>
	       
	        <div class="span3">
	         <ul class="thumbnails" id="planshow1"> 
	           <c:forEach var="options" items="${certificateRespone.list3 }"> 
	              <li class="span3 mxkplan mxkshadow">
	                  <div class="thumbnail">
	                   <div style="position:relative;" onmouseover="mouseover('${options.id }')" onmouseout="mouseout('${options.id }')" > 
	                    <span style="position:absolute; z-index:-1; opacity: 0.8;" id="${options.id }">
	                      <span class="label label-info">获证时间：${options.createTime }</span>
	                    </span>
	                    <img src="<%=imgurl %>${options.imageurl }" />
	                    </div>
	                    <span class='label'><img src="<%=metootitle%>${options.titleImage }">${options.title}</span>
	                    <span class="pull-right">
	                          <div class="btn-group">
			                      <a class="btn dropdown-toggle btn-mini btn-danger" data-toggle="dropdown" href="#">
			                        <i class="icon-globe"></i>分享
			                        <span class="caret"></span>
				                  </a>
							     <ul class="dropdown-menu">
								       <li>
									      <a href="http://service.weibo.com/share/share.php?url=<%=rootPath%>/vistiorShowUserIndex?target=${uservo.id }&pic=<%=imgurl %>${options.imageurl }&title=我获得了一个新证书&nbsp;&nbsp;${options.title }" target="_blank">
									                   分享到新浪微博
									       </a>
								       </li>
									   <li>
										   <a href="http://share.v.t.qq.com/index.php?c=share&a=index&url=<%=rootPath%>/vistiorShowUserIndex?target=${uservo.id }&pic=<%=imgurl %>${options.imageurl }&title=我获得了一个新证书&nbsp;&nbsp;${options.title}" target="_blank">
										         分享到QQ微信
										   </a>
									   </li>
									   <li>
										   <a href="http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url=<%=rootPath%>/index&pic=<%=imgurl %>${options.imageurl }&title=我获得了一个新证书&nbsp;&summary=${options.title}|&nbsp;<%=rootPath%>/vistiorShowUserIndex?target=${partEntity.id }" target="_blank">
										         分享到QQ空间
										   </a>
									  </li>
					               </ul>
				             </div>
	                    </span>
	                  </div>
	              </li>
	           </c:forEach>
	         </ul>
	       </div>
	       
	        <div class="span3">
	         <ul class="thumbnails" id="planshow1"> 
	           <c:forEach var="options" items="${certificateRespone.list4 }"> 
	              <li class="span3 mxkplan mxkshadow">
	                  <div class="thumbnail">
	                   <div style="position:relative;" onmouseover="mouseover('${options.id }')" onmouseout="mouseout('${options.id }')" > 
	                    <span style="position:absolute; z-index:-1; opacity: 0.8;" id="${options.id }">
	                      <span class="label label-info">获证时间：${options.createTime }</span>
	                    </span>
	                    <img src="<%=imgurl %>${options.imageurl }" />
	                    </div>
	                    <span class='label'><img src="<%=metootitle%>${options.titleImage }">${options.title}</span>
	                    <span class="pull-right">
	                          <div class="btn-group">
			                      <a class="btn dropdown-toggle btn-mini btn-danger" data-toggle="dropdown" href="#">
			                        <i class="icon-globe"></i>分享
			                        <span class="caret"></span>
				                  </a>
							     <ul class="dropdown-menu">
								       <li>
									      <a href="http://service.weibo.com/share/share.php?url=<%=rootPath%>/vistiorShowUserIndex?target=${uservo.id }&pic=<%=imgurl %>${options.imageurl }&title=我获得了一个新证书&nbsp;&nbsp;${options.title }" target="_blank">
									                   分享到新浪微博
									       </a>
								       </li>
									   <li>
										   <a href="http://share.v.t.qq.com/index.php?c=share&a=index&url=<%=rootPath%>/vistiorShowUserIndex?target=${uservo.id }&pic=<%=imgurl %>${options.imageurl }&title=我获得了一个新证书&nbsp;&nbsp;${options.title}" target="_blank">
										         分享到QQ微信
										   </a>
									   </li>
									   <li>
										   <a href="http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url=<%=rootPath%>/index&pic=<%=imgurl %>${options.imageurl }&title=我获得了一个新证书&nbsp;&summary=${options.title}|&nbsp;<%=rootPath%>/vistiorShowUserIndex?target=${partEntity.id }" target="_blank">
										         分享到QQ空间
										   </a>
									  </li>
					               </ul>
				             </div>
	                    </span>
	                  </div>
	              </li>
	           </c:forEach>
	         </ul>
	       </div>
	       
	     </div>
	</c:if>
</div>
<script type="text/javascript">
function mouseover(id){
    $("#"+id).css("z-index","1");
  }
  
  function mouseout(id){
	$("#"+id).css("z-index","-1");
  }
</script>
<%@ include file="../../../footinclude.jsp"%>
</body>
</html>
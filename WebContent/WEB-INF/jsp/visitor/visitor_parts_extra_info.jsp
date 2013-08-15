<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="../../../headerinclude.jsp"%>
</head>
<body class="mxkbody mxkbackgroud">
<%@ include file="../public/user_page_header.jsp"%>
<body>
<div class="container">
  <div class="row">
     <div class="span1">
        <img class="img-polaroid border-radius" style="height:60px;width:60px" 
        src="<%=imgurl %>${partEntity.minimage }" >
     </div>
     <div class="span11">
        <span style="font-size:20px;">
           <strong>From:&nbsp;<span>
             <a href="<%=rootPath%>/vistiorShowUserIndex?target=${targetUserVO.id}">${targetUserVO.name }</a>
           </span></strong>
           </span>
        <span class="pull-right">
            <a href="visitorShowPartDetail?target=${partEntity.id }" class="btn">
               <i class="icon-list"></i>Parts详情
            </a>
            <a class="btn btn btn-info" href="javascript:;" onclick="popdivfrombtn()">
              <i class="icon-comment-alt"></i>发布评论
            </a>
         </span><br />
        <span>${partEntity.desc }</span><br />
        <span><i class="icon-time"></i>Create Time:${partEntity.createTime }</span>
        <span class="pull-right">
          <span class="label label-success"><i class="icon-microphone"></i>语音${partEntity.audios}</span>
		  <span class="label"><i class="icon-comment-alt"></i>文字${partEntity.comments  }</span>
        </span>
     </div>
   </div>
</div>    
<br />

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
	            
	            <a class="btn" href="<%=rootPath%>/visitorShowPartsCollecter?target=${partEntity.id}">
		               <i class="icon-pushpin"></i>收藏次数<span id="coll">${partEntity.collect }</span>
		            </a>
              </span>
              
             <span class="pull-right">
	            <a class="btn" href="<%=rootPath %>/visitorShowPartsCommnets?target=${partEntity.id }">
	              <i class="icon-refresh"></i>刷新
	            </a>
             </span>
		</div>
	</div>
</div>

<script type="text/javascript">
  
  function mouseover(){
    $("#point_div").css("z-index","1");
  }
  
  function mouseout(){
	$("#point_div").css("z-index","-1");
  }
  

</script>

<div class="container">
   <div class="row">
       <div class="span4">
          <ul class="thumbnails">
			  <li class="span4 mxkplan mxkshadow">
			    <div class='thumbnail'>
					<div style="position:relative;" onmouseover="mouseover()" onmouseout="mouseout()" >
						       <span style="position:absolute; z-index:-1; opacity: 0.8;" id="point_div">
						            <c:if test="${partEntity.highPoint != 0 }">
							           <div style="background-color:#008800;width:60px;height:60px;text-align:right" align="right">
						                  <center>
						                    <br /> 
						                    <font style="font-size:25px;" color="#FFFFFF"><strong id="point_str">${partEntity.highPoint }分</strong></font>
						                  </center>
						               </div>
							         </c:if>
						       </span>
						<a href="javascript:;" ><img src="<%=imgurl %>${partEntity.minimage}" /></a>
				     </div>
				     <c:if test="${partEntity.subjectid != '#' }">
						<span class="text-info"><small><a href="<%=rootPath %>/vistiorShowSubjectDatail?target=${partEntity.subjectid}">《${partEntity.subname }》</a></small></span><br />
					</c:if>
                    <span><small>${partEntity.desc }</small></span><br />
                    <span class="pull-right">
                        <a class="btn btn-danger " href="javascript:;" onclick="collectPart('${partEntity.id}')">
						    <i class="icon-pushpin"></i>收藏part
						 </a>
                         <a class="btn " href="<%=rootPath %>/visitorShowPartDetail?target=${partEntity.id}">
                            <i class="icon-comment"></i>评论part
                         </a>
                    </span>
                    <br /><br />
				</div>
			  </li>
		   </ul>
       </div>
       
    <div class="span8 mxkplan mxkshadow">
      <div style="padding:5px">
        <ul class="nav nav-tabs">
			<li class="active">
			   <a href="javascript:;">
			   <i class="icon-gift"></i>礼物x${partEntity.gifts  }</a>
			</li>
			<li>
			   <a href="javascript:;">
			   <i class="icon-heart"></i>喜欢x${partEntity.likes  }</a>
			</li>
			<li >
			  <a href="javascript:;">
			  <i class="icon-trophy"></i>评分</a>
			</li>
		</ul>
	  </div>
	  
	  <!-- 礼物 -->
	   <div id="show_gift_div" style="padding:5px">
	      <div class='row'>
	         <div class='span1'>
	           <img class='img-polaroid border-radius' src='http://192.168.1.127/mxk/image/userheader.png'>
	         </div>
	         <div class='span6'>
	           <a href=''>寂寞的4机器喷漆</a>&nbsp;送礼 <span class="label label-success"><strong>宝石</strong><img src='http://www.waileecn.com/mxk/assets/mxkimage/gift/ruby.png'/></span><br />
	           <span class="muted"><small>一颗10卡拉的大红宝石</small></span><br />
	           <i class="icon-time"></i>2012-12-12 12:12:21
	         </div>
	      </div>
	    <div style="height:3px;"></div>
	      <div class='row'>
	         <div class='span1'>
	           <img class='img-polaroid border-radius' src='http://192.168.1.127/mxk/image/userheader.png'>
	         </div>
	         <div class='span6'>
	           <a href=''>寂寞的4机器喷漆</a>&nbsp;送礼 <span class='label label-success'><strong>闹钟</strong><img src='http://www.waileecn.com/mxk/assets/mxkimage/gift/alarm.png'/></span><br />
	           <span class="muted"><small>送你一个闹钟 定好时间随时开工</small></span><br />
	           <i class="icon-time"></i>2012-12-12 12:12:21
	         </div>
	      </div>
	  </div>
	  
	  
	  <!-- 喜欢 -->
	  <div id="show_gift_div" style="padding:5px">
	      <div class='row'>
	         <div class='span1'>
	           <img class='img-polaroid border-radius' src='http://192.168.1.127/mxk/image/userheader.png'>
	         </div>
	         <div class='span6'>
	           <a href=''>寂寞的4机器喷漆</a><br />
	           <span class="muted"><small>喜欢这个Part&nbsp;<i class="icon-heart"></i></small></span><br />
	           <i class="icon-time"></i>2012-12-12 12:12:21
	         </div>
	      </div>
	    <div style="height:3px;"></div>
	      <div class='row'>
	         <div class='span1'>
	           <img class='img-polaroid border-radius' src='http://192.168.1.127/mxk/image/userheader.png'>
	         </div>
	         <div class='span6'>
	           <a href=''>寂寞的4机器喷漆</a><br />
	           <span class="muted"><small>喜欢这个Part&nbsp;<i class="icon-heart"></i></small></span><br />
	           <i class="icon-time"></i>2012-12-12 12:12:21
	         </div>
	      </div>
	  </div>
	  
	  <!-- 评分 -->
	   <div id="show_gift_div" style="padding:5px">
	      <div class='row'>
	         <div class='span1'>
	           <img class='img-polaroid border-radius' src='http://192.168.1.127/mxk/image/userheader.png'>
	         </div>
	         <div class='span6'>
	           <a href=''>寂寞的4机器喷漆</a>&nbsp;<span class='label'><strong>评分</strong></span><br />
	           <span class="muted"><small>10 分&nbsp;<i class="icon-trophy"></i></small></span><br />
	           <i class="icon-time"></i>2012-12-12 12:12:21
	         </div>
	      </div>
	    <div style="height:3px;"></div>
	      <div class='row'>
	         <div class='span1'>
	           <img class='img-polaroid border-radius' src='http://192.168.1.127/mxk/image/userheader.png'>
	         </div>
	         <div class='span6'>
	           <a href=''>寂寞的4机器喷漆</a>&nbsp;<span class='label'><strong>评分</strong></span><br />
	           <span class="muted"><small>10 分&nbsp;<i class="icon-trophy"></i></small></span><br />
	           <i class="icon-time"></i>2012-12-12 12:12:21
	         </div>
	      </div>
	  </div>
	  
    </div>
   </div>
</div>
 <%@ include file="../../../basefootinclude.jsp"%>
</body>
</html>
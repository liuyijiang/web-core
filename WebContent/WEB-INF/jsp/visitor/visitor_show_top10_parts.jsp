<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="../../../headerinclude.jsp"%>
</head>
<body class="mxkbody  mxkbackgroud">
<%@ include file="../public/part_dash_board_header.jsp"%>  
<br /><br /><br />
<div class="container">
<span style="font-size:20px"><strong>本周最火Part Top10</strong></span>
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
   <div class="row">
      <div class="span12 mxkplan mxkshadow" style="padding:5px;" >
         <div class="row">
           <div class="span2">
             <a href="http://localhost:8080/webmxk/visitorShowPartDetail?target=51fe4b8c0cf25d3dad7ac27b">
                 <img class="img-polaroid border-radius" 
                 src="http://192.168.1.127/mxk/image/51fe4a820cf25d3dad7ac26c_mini.png">
             </a>
           </div>
           <div class="span10">
              <div class="row">
                 <span class="span8"> 
                   <a href="" class="btn btn-danger"><i class="icon-pushpin"></i>收藏</a>
                   <a href="" class="btn btn-primary"><i class="icon-comment"></i>评论</a>
                   <br />
                    <i class="icon-time">2012-12-21 23:12:12</i> 
                                                    由 &nbsp;<a href="#">寂寞的4家钱</a> &nbsp;分享<br />
                    <span class="muted">达瓦达瓦大丰富鹅鹅鹅发的色粉色</span>
                    <br /><br />
                    <span class="label">舰船模型</span>
                    <span class="">
                        <span class="label label-success">语音3</span>
                     	<span class="label label-info">文字1</span>
                     	<span class="label label-warning">收藏11</span>
                    </span>
                  <h4>关注次数100</h4>
                 </span>
                 <span class="pull-right span1">
                    <img src="http://www.waileecn.com/mxk/image/51e90cad0cf26f682c01ca6a_full.png">
                    <br />
                    <a href="#" class="btn btn-small">加关注</a>
                 </span>
              </div>
           </div>
         </div>
      </div>
   </div><!-- end row -->
</div>
<%@ include file="../public/public_page_footer.jsp"%> 
 <%@ include file="../../../basefootinclude.jsp"%>
</body>
</html>
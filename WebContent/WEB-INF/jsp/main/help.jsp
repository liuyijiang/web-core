<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html xmlns:wb=“http://open.weibo.com/wb”>
<script src="http://tjs.sjs.sinajs.cn/open/api/js/wb.js" type="text/javascript" charset="utf-8"></script>
<head>
<%@ include file="../../../headerinclude.jsp"%>
</head>
<body class="mxkbody mxkbackgroud" >
<%@ include file="../public/user_page_header.jsp"%>
<div class="container">
       <h4>关于米兔Metoo</h4>
	  <span>在米兔Metoo你可以享受什么</span>
	  <br />
	  <ol>
	    <li><a href="#part">收藏Parts</a></li>
	    <li><a href="#rss">订阅专题</a></li>
	    <li><a href="#frind">关注好友</a></li>
	    <li><a href="#allshare">参与共享专题</a></li>
	    <li><a href="#comment">语音或文字评论</a></li>
	    <li><a href="#colloct">查看收藏的用户</a></li>
	    <li><a href="#hot">了解最热门的图片</a></li>
	    <li><a href="#hot">完美平板享受</a></li>
	  </ol>
	  
	  <span>在米兔Metoo你可以创造什么</span><br />
	  <ol>
	    <li><a href="#mkpart">分享part</a></li>
	    <li><a href="#mksubject">创建专题</a></li>
<!-- 	    <li><a href="#mkwork">管理制作进度</a></li> -->
	    <li><a href="#mkgif">生成电子文档或GIF图片</a></li>
	    <li><a href="#mkm">分享制作材料</a></li>
	  </ol>
	  
	  <br />
	  <h4>享受</h4>
	  <div id="part">
          <span class="label label-important">收藏Parts</span><br />
          <span class="muted">你可以收藏parts.当你看到有让你眼前一亮的图片时赶紧收藏吧!模型玩家就是要学习借鉴提高的.好的作品可以让你充满灵感.</span><br />
           <img src="<%=domain%>collect.png">
      </div>
      <hr />
      <div id="rss">
          <span class="label label-important">订阅专题</span><br />
          <span class="muted">你可以订阅有兴趣的专题,这样专题的所有者每次发布你都可以收到信息.</span><br />
          <img src="<%=domain%>rsssubject.png">
      </div>
      
	   <hr />
      <div id="frind">
          <span class="label label-important">关注好友</span><br />
          <span class="muted">你可以关注好友，好友分享的parts,发布的专题你都可以第一时间收到.就让我们在这里以模型会友吧!</span><br />
          <img src="<%=domain%>adduser.png">
      </div>
      
       <hr />
      <div id="allshare">
          <span class="label label-important">了解最热门的图片</span><br />
          <span class="muted">分享的part被收藏和评论次数越多,part也会相应的改变颜色并发光.最火的图片将更加突出.</span><br />
          <img src="<%=domain%>allshare.png">
      </div>
      
      <hr />
      <div id="comment">
          <span class="label label-important">语音或文字评论</span><br />
          <span class="muted">打字累了吗?试试语音评论吧！相信他听到你的声音,一定会兴奋不已.</span><br />
          <img src="<%=domain%>voice.png">
      </div>
      <hr />
       <div id="colloct">
          <span class="label label-important">查看收藏的用户</span><br />
          <span class="muted">当你分享的图片被其他用户收藏后,你分享的图片就会被打上图钉像这样. </span><br />
          <img src="<%=domain%>share.png">
      </div>
       <hr />
       <div id="hot">
          <span class="label label-important">了解最热门的图片</span><br />
          <span class="muted">分享的part关注此次越多 parts也就会相应的改变发光颜色像这样. </span><br />
          <img src="<%=domain%>hot.png">
      </div>
      
      <br />
	  <h4>创造</h4>
      <div id="mkpart">
          <span class="label label-important">分享part</span><br />
          <span class="muted">你看到你做过你分享.在我们制作模型的时候是不是想去找一些质料考证或是借鉴一些作品启发自己, 当你发现好东西的时候不要忘了分享给其他朋友.</span><br />
          <img src="<%=domain%>sharetoall.png">
      </div>
      
      <hr />
      <div id="mksubject">
          <span class="label label-important">创建专题</span><br />
          <span class="muted">你可以将自己的或看到的一些美图,技术图,细节图,考证图制作成一个专题分享给大家像这样.</span><br />
          <img src="<%=domain%>mksubject.png">
      </div>
      
       <hr />
      <div id="mkwork">
          <span class="label label-important">管理制作进度</span><br />
          <span class="muted">控制和管理自己的制作进度,让制作更专业更高效.</span><br />
<%--           <img src="<%=domain%>mksubject.png"> --%>
      </div>
      
       <hr />
       <div id="mksubject">
          <span class="label label-important">生成电子文档或GIF图片</span><br />
          <span class="muted">如果能把图片生成图文的电子问题或是动态的GIF图片会不会是件很爽的事</span><br />
          <img src="<%=domain%>gif.png">
      </div>
      
       <hr />
       <div id="mkm">
          <span class="label label-important">分享制作材料</span><br />
          <span class="muted">你也可以在这里创建一个使用材料的总结分享给好友，让他们了解你的模型用到了哪些具体材料。</span><br />
          <img src="<%=domain%>m.png">
      </div>
      
      <center>
       <h4>更多功能将继续开发中 请多支持 关注官方微博米兔Metoo微博 <span><wb:follow-button uid="1841004522" type="red_3" width="100%" height="24" ></wb:follow-button></span></h4>
      </center>
      
     </div>
</div>

 <%@ include file="../../../footinclude.jsp"%>
</body>
</html>
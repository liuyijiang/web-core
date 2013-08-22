<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
 <%@ include file="../../../headerinclude.jsp"%>
</head>
<body class="mxkbody mxkbackgroud" onload="showloadgift(true);">
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
						<a href="javascript:;">&nbsp;<i class="icon-gift"></i>我的礼物&nbsp;</a>
						</li>
					</ul>
                </span>
			</div>
		</div>
	</div>

<div class="container mxkplan mxkshadow">
    <div class="row">
       <div class="span12" style="padding:5px;width:97%">
            <ul class="nav nav-tabs">
			    <li id="giftdiv" class="active">
			       <a href="javascript:;">专题礼物</a>
			    </li>
		    </ul>
       </div>
       
      <div id="show_gift_con" style="padding:5px;display:none" class="span12" >
         <div id="show_gift_load" style="display:none" >
             <img src="<%=domain %>loadingred.gif" >
             <span class="muted"><small>正在努力加载...</small></span>
         </div>
         <div id="show_gift_div"></div>
         <span id="show_gift_more" style="display:none" class="pull-right"><a href="javascript:;" onclick="showloadgift(false)">加载更多</a>&nbsp; &nbsp;&nbsp; &nbsp;</span>
      </div><!-- gift -->
      
    </div>
</div>
<br /><br /><br />
<script type="text/javascript">
var giftallpage = 0;
var giftpage = 1;
var tragetId = '${uservo.id}';
function showloadgift(clean){
	   $("#giftdiv").attr("class","active");
	   if(clean){
		   $("#show_gift_div").html('');
	   }
	   $("#show_gift_con").show();
	   loadgift();
}


function loadgift(){
	  var datas = {"pageModel.tragetId":tragetId,"pageModel.currentPage":giftpage,"pageModel.allPage":giftallpage};
	  $("#show_gift_load").show();
	  $.ajax({
 		url : path + "/findUserAllGift",
 		type : "POST",
 		cache : false,
 		async : false,
 		data: datas,
 		dataType : "json",
 		success : function(item) {
 			$("#show_gift_load").hide();
 			if(item.allpage > 1){
 				giftallpage = item.allpage;
 				$("#show_gift_more").show();
 			}
 			giftpage = giftpage + 1;
 			createGiftDiv(item.list);
 		  }
	  }); 
 }

 function createGiftDiv(list){
	   var show = '';
	   for (var i in list) {
		   show = show + "<div class='row'><div class='span1'><img class='img-polaroid border-radius' src='"+ imgurl + list[i].sendGiftUserImage +"'>"
		   +"</div><div class='span6'><a href='"+ path + "/vistiorShowUserIndex?target="+ list[i].sendGiftUserId +"'>"+ list[i].sendGiftUserName +"</a>"
		   +"&nbsp;送礼 <span class='label label-success'><strong>"+ list[i].giftName +"</strong>"
		   + "<img src='"+ metoogift + list[i].gifImage +"'/></span><br /><span class='muted'><small>"+ list[i].gifMessage +"</small></span><br />"
		   + "<i class='icon-time'></i>"+ list[i].sendGiftTime +"</div></div><div style='height:5px;'></div>";
	   }
	   $("#show_gift_div").append(show);
 }
 

</script>
<%@ include file="../../../footinclude.jsp"%>
</body>
</html>
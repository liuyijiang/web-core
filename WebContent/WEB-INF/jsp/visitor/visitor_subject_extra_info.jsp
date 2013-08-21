<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="../../../headerinclude.jsp"%> 
</head>
<body class="mxkbody mxkbackgroud" onload="load()">
<%@ include file="../public/user_page_header.jsp"%>
<%@ include file="../public/visitor_subject_public_header.jsp"%> 
<div class="container mxkplan mxkshadow">
    <div class="row">
       <div class="span12" style="padding:5px;width:97%">
            <ul class="nav nav-tabs">
	            <li id="pricediv" >
			       <a href="javascript:;" onclick="showloadPrice(true);">专题定价</a>
			    </li>
			    <li id="pointdiv">
			       <a href="javascript:;" onclick="showloadPoint(true);">专题评分</a>
			    </li>
			    <li id="giftdiv">
			       <a href="javascript:;" onclick="showloadgift(true);">专题礼物</a>
			    </li>
			    <li id="likediv">
			       <a href="javascript:;" onclick="showloadlike(true);">喜欢专题</a>
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
      
      <div id="show_like_con" style="padding:5px;display:none" class="span12" >
         <div id="show_like_load" style="display:none" >
             <img src="<%=domain %>loadingred.gif" >
             <span class="muted"><small>正在努力加载...</small></span>
         </div>
         <div id="show_like_div"></div>
         <span id="show_like_more" style="display:none" class="pull-right"><a href="javascript:;" onclick="showloadlike(false)">加载更多</a>&nbsp; &nbsp;&nbsp; &nbsp;</span>
      </div><!-- like -->
       
       <div id="show_point_con" style="padding:5px;display:none" class="span12" >
         <div id="show_point_load" style="display:none" >
             <img src="<%=domain %>loadingred.gif" >
             <span class="muted"><small>正在努力加载...</small></span>
         </div>
         <div id="show_point_div"></div>
         <span id="show_point_more"  style="display:none" class="pull-right"><a href="javascript:;" onclick="showloadPoint(false)">加载更多</a>&nbsp; &nbsp;&nbsp; &nbsp;</span>
      </div><!-- point -->
      
      <div id="show_price_con" style="padding:5px;display:none" class="span12" >
         <div id="show_price_load" style="display:none" >
             <img src="<%=domain %>loadingred.gif" >
             <span class="muted"><small>正在努力加载...</small></span>
         </div>
         <div id="show_price_div"></div>
         <span id="show_price_more" style="display:none"  class="pull-right"><a href="javascript:;" onclick="showloadPrice(false)">加载更多</a>&nbsp; &nbsp;&nbsp; &nbsp;</span>
      </div><!-- price -->
       
    </div>
</div>
<br /><br /><br />

<script type="text/javascript">
   var type = '${type}';
   var tragetId = '${subjectEntity.id}';
   var giftallpage = 0;
   var likeallpage = 0;
   var pointallpage = 0;
   var priceallpage = 0;
   var giftpage = 1;
   var likepage = 1;
   var pointpage = 1;
   var pricepage = 1;
   
   function cleangiftdiv(){
	   $("#show_gift_con").hide();
	   giftpage = 1;
	   giftallpage = 0;
	   $("#giftdiv").attr("class","");
   }
   
   function cleanlikediv(){
	   $("#show_like_con").hide();
	   likepage = 1;
	   likeallpage = 0;
	   $("#likediv").attr("class",""); 
   }
   
   function cleanpointdiv(){
	   $("#show_point_con").hide();
	   pointpage = 1;
	   pointallpage = 0;
	   $("#pointdiv").attr("class","");   
   }
   
   function cleanpricediv(){
	   $("#show_price_con").hide();
	   pricepage = 1;
	   priceallpage = 0;
	   $("#pricediv").attr("class","");   
   }
   
   function showloadgift(clean){
	   $("#giftdiv").attr("class","active");
	   if(clean){
		   $("#show_gift_div").html('');
	   }
	   cleanlikediv();
	   cleanpricediv();
	   cleanpointdiv();
	   $("#show_gift_con").show();
	   loadgift();
   }
   
   function showloadlike(clean){
	   $("#likediv").attr("class","active");
	   if(clean){
		   $("#show_like_div").html('');
	   }
	   cleangiftdiv();
	   cleanpricediv();
	   cleanpointdiv();
	   $("#show_like_con").show();
	   loadlike();
   }
   
   function showloadPoint(clean){
	   $("#pointdiv").attr("class","active");
	   if(clean){
		   $("#show_point_div").html('');
	   }
	   cleangiftdiv();
	   cleanpricediv();
	   cleanlikediv();
	   $("#show_point_con").show();
	   loadPoint();
   }
   
   function showloadPrice(clean){
	   $("#pricediv").attr("class","active");
	   if(clean){
		   $("#show_price_div").html('');
	   }
	   cleangiftdiv();
	   cleanpointdiv();
	   cleanlikediv();
	   $("#show_price_con").show(); 
	   loadPrice();
   }
   
   function load(){
	   if(type == 1){
		   showloadgift(true);
	   }else if(type == 2){
		   showloadlike(true);
	   }else if(type == 3){
		   showloadPoint(true);
	   }else if(type == 4){
		   showloadPrice(true);
	   }
   }

   function loadPrice(){
	   var datas = {"pageModel.tragetId":tragetId,"pageModel.currentPage":pricepage,"pageModel.allPage":priceallpage};
		  $("#show_price_load").show();
		  $.ajax({
	   		url : path + "/findSetPriceToSubjectByPage",
	   		type : "POST",
	   		cache : false,
	   		async : false,
	   		data: datas,
	   		dataType : "json",
	   		success : function(item) {
	   			if(item.allpage > 1){
	   				priceallpage = item.allpage;
	   				$("#show_price_more").show();
	   			}
	   			pricepage = pricepage + 1;
	   			$("#show_price_load").hide();
	   			createPriceDiv(item.list);
	   		  }
		  }); 
   }
   
   function createPriceDiv(list){
	   var show = '';
	   for (var i in list) {
		   show = show + "<div class='row'><div class='span1'><img class='img-polaroid border-radius' src='"+ imgurl + list[i].setPriceUserImage +"'>"
		   + "</div><div class='span6'><a href='"+ path + "/vistiorShowUserIndex?target="+ list[i].setPriceUserId +"'>"+ list[i].setPriceUserName +"</a>&nbsp;<span class='label label-important'><strong>定价</strong></span><br />"
	       + "<span class='muted'><small>"+ list[i].money +"元&nbsp;<i class='icon-jpy'></i></small></span><br />"
	       + "<i class='icon-time'></i>"+ list[i].createTime+ "</div></div><div style='height:5px;'></div>";
	   }
	   $("#show_price_div").append(show);
   }
   
   function loadgift(){
	  var datas = {"pageModel.tragetId":tragetId,"pageModel.currentPage":giftpage,"pageModel.allPage":giftallpage};
	  $("#show_gift_load").show();
	  $.ajax({
   		url : path + "/findSendGiftByPage",
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
   
   
   function loadlike(){
	   var datas = {"pageModel.tragetId":tragetId,"pageModel.currentPage":likepage,"pageModel.allPage":likeallpage};
	   $("#show_like_load").show();
	   $.ajax({
	   		url : path + "/findLikeThisByPage",
	   		type : "POST",
	   		cache : false,
	   		async : false,
	   		data: datas,
	   		dataType : "json",
	   		success : function(item) {
	   		 $("#show_like_load").hide();
		   		if(item.allpage > 1){
		   			likeallpage = item.allpage;
	   				$("#show_like_more").show();
	   			}
		   		likepage = likepage + 1;
	   			createLikeDiv(item.list);
	   		  }
		  }); 
   }
   
   function createLikeDiv(list){
	   var show = '';
	   for (var i in list) {
		   show = show + "<div class='row'><div class='span1'><img class='img-polaroid border-radius' src='"+ imgurl + list[i].userimage +"'>"
		   + "</div><div class='span6'><a href='"+ path + "/vistiorShowUserIndex?target="+ list[i].userid +"'>"+ list[i].username +"</a><br />"
		   + "<span class='muted'><small>喜欢这个Part&nbsp;<i class='icon-heart'></i></small></span><br />"
	       + "<i class='icon-time'></i>"+ list[i].createTime +"</div></div><div style='height:5px;'></div>";
		   
	   }
	   $("#show_like_div").append(show);
   }
   
   
   function loadPoint(){
	   var datas = {"pageModel.tragetId":tragetId,"pageModel.currentPage":pointpage,"pageModel.allPage":pointallpage};
	   $("#show_point_load").show();
	   $.ajax({
	   		url : path + "/findSetPointByPage",
	   		type : "POST",
	   		cache : false,
	   		async : false,
	   		data: datas,
	   		dataType : "json",
	   		success : function(item) {
	   			if(item.allpage > 1){
	   				pointallpage = item.allpage;
	   				$("#show_point_more").show();
	   			}
	   			pointpage = pointpage + 1;
	   			$("#show_point_load").hide();
	   			createPointDiv(item.list);
	   		  }
		 }); 
   }
  
   
   function createPointDiv(list){
	   var show = '';
	   for (var i in list) {
		   show = show + "<div class='row'><div class='span1'><img class='img-polaroid border-radius' src='"+ imgurl + list[i].userimage +"'>"
		   + "</div><div class='span6'><a href='"+ path + "/vistiorShowUserIndex?target="+ list[i].userid +"'>"+ list[i].username +"</a>&nbsp;<span class='label'><strong>评分</strong></span><br />"
	       + "<span class='muted'><small>"+ list[i].point +"分&nbsp;<i class='icon-trophy'></i></small></span><br />"
	       + "<i class='icon-time'></i>"+ list[i].createTime+ "</div></div><div style='height:5px;'></div>";
	   }
	   $("#show_point_div").append(show);
   }
   
</script>
<%@ include file="../../../footinclude.jsp"%>
</body>
</html>

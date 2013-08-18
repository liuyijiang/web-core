<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="../../../headerinclude.jsp"%>
</head>
<body class="mxkbody mxkbackgroud" onload="seachUserFriends()">
<%@ include file="../public/user_page_header.jsp"%>
<%@ include file="../public/update_user_public_header.jsp"%>

<div class="container">
		<div class="navbar">
			<div class="navbar-inner">
				<ul class="nav" >
					<li class="active">
					<a href="javascript:;">&nbsp;<i class="icon-rss"></i>我的关注&nbsp;</a>
					</li>
					<li class="divider-vertical"></li>
					<li>
					<a href="<%=rootPath%>/userFollowersView">&nbsp;<i class="icon-group"></i>我的粉丝&nbsp;</a>
					</li>
				</ul>
				<div class="navbar-form pull-right">
					<div class="input-append">
					   <input id="theparm" class="span3" placeholder="搜索好友..." type="text">
				       <button class="btn" type="button" onclick="searchUser()">Go!</button>
					</div>
			    </div>
			</div>
		</div>
	</div>
<div class="container" >
  <ul class="thumbnails" id="showlist">  
		
  </ul>
</div>
<div class="container" id="loadings" >
  <img src="<%=domain %>loadingred.gif" >
  <span class="muted"><small>正在努力加载...</small></span>
</div>
<div class="container" id="actiondiv" style="display:none">
    <br />
    <span class="text-warning pull-right"><a class="btn-link">上一页</a>&nbsp;<a class="btn-link">下一页</a></span> 
</div>
<%@ include file="../../../footinclude.jsp"%>
<script type="text/javascript">
    var friendpage = 1; 
    var all = '${uservo.focus}';
    var userid = '${uservo.id}';
    function seachUserFriends(){
    	var datas = {"searchUserRequest.parm":userid,"searchUserRequest.page":friendpage,"searchUserRequest.follower":false};
    	$("#loadings").show();
    	 $.ajax({
				url : path + "/seachUserFriends.action",
				type : "POST",
				cache : false,
				async : false,
				data: datas,
				dataType : "json",
				success : function(item) {
					$("#loadings").hide();
					createFriendList(item.list);
				}
	   });
    }

    function createFriendList(list){
    	var show = '';
    	for(var i in list){
    		show = show + "<li class='span4 mxkplan mxkshadow'><div style='padding:5px;margin-bottom:1px;'>"+
    	    "<table style='width:100%'><tr><td width='26%' rowspan='2'><img class='img-polaroid border-radius' src='"+ imgurl + list[i].image +"' style='width:60px'>" +
    		"</td><td width='30%'><div style='width:140px;text-overflow:ellipsis; white-space:nowrap; overflow:hidden;'>" +
    		"<div style='width:140px;text-overflow:ellipsis; white-space:nowrap; overflow:hidden;'><strong><a href='#'>"+ list[i].name +"</a></strong>" +
    		"</div></td><td><span class='pull-right'><a class='btn btn-danger btn-mini' href='javascript:;' onclick='createUserRelation(\"" + list[i].id +"\")'>取消关注</a></span></td></tr>"+     
    		"<tr><td colspan='2'><div style='width:210px;text-overflow:ellipsis; white-space:nowrap; overflow:hidden;'>"+
    		"<span class='muted'>"+ list[i].info +"</span></div><span>" +
    		"<span class='muted'><small><i class='icon-tags'></i>"+ list[i].interest +"</small></span>" +
    		"<small class='pull-right'><i class='icon-rss'></i><a href='#'>"+ list[i].focus +"</a>&nbsp;<i class='icon-group'></i><a href='#'>"+ list[i].followors +"</a></small>" +
    		"</span></td></tr></table></div></li>";         
    	}
    	$("#loadings").hide();
    	$("#showlist").html(show);
    	if(all > 12){
    		$("#actiondiv").show();
    	}
    }
    
</script>
<script type="text/javascript">
    var page = 1; 
    function searchUser(){
    	var parm = $("#theparm").val();
    	if(parm == ""){
    		alert("请输入要查询的信息");
    		return;
    	}
    	$("#showlist").html("");
    	var datas = {"searchUserRequest.parm":parm,"searchUserRequest.page":page};
    	$("#loadings").show();
    	 $.ajax({
				url : path + "/seachUser.action",
				type : "POST",
				cache : false,
				async : false,
				data: datas,
				dataType : "json",
				success : function(item) {
					createList(item.list);
				}
		  });
    	
    }
    
    function createList(list){
    	var show = '';
    	for(var i in list){
    		show = show + "<li class='span4 mxkplan mxkshadow'><div style='padding:5px;margin-bottom:1px;'>"+
    	    "<table style='width:100%'><tr><td width='26%' rowspan='2'><img class='img-polaroid border-radius' src='"+ imgurl + list[i].image +"' style='width:60px'>" +
    		"</td><td width='30%'><div style='width:140px;text-overflow:ellipsis; white-space:nowrap; overflow:hidden;'>" +
    		"<div style='width:140px;text-overflow:ellipsis; white-space:nowrap; overflow:hidden;'><strong><a href='#'>"+ list[i].name +"</a></strong>" +
    		"</div></td><td><span class='pull-right'><a class='btn btn-inverse btn-mini' href='javascript:;' onclick='createUserRelation(\"" + list[i].id +"\")'><i class='icon-plus'></i>加关注</a></span></td></tr>"+     
    		"<tr><td colspan='2'><div style='width:210px;text-overflow:ellipsis; white-space:nowrap; overflow:hidden;'>"+
    		"<span class='muted'>"+ list[i].info +"</span></div><span>" +
    		"<span class='muted'><small><i class='icon-tags'></i>"+ list[i].interest +"</small></span>" +
    		"<small class='pull-right'><i class='icon-rss'></i><a href='#'>"+ list[i].focus +"</a>&nbsp;<i class='icon-group'></i><a href='#'>"+ list[i].followors +"</a></small>" +
    		"</span></td></tr></table></div></li>";         
    	}
    	$("#loadings").hide();
    	$("#showlist").html(show);
    
    }
    
    function createUserRelation(id){	  
    	  $.ajax({
    	   		url : path + "/createUserRelation.action",
    	   		type : "POST",
    	   		cache : false,
    	   		async : false,
    	   		data: {"createRelationShipRequest.userid":id},
    	   		dataType : "json",
    	   		success : function(item) {
    	   		    if(item == 'success'){
    	 			   alert("关注成功");
    			    }else if( item == 'error'){
    			   	   alert("已经关注");
    			    }else {
    			     	alert(item);
    			    }
    	   		  }
    	 	 });  
      }
    
</script>
</body>
</html>
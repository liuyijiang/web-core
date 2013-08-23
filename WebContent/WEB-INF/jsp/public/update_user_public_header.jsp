<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri= "http://java.sun.com/jsp/jstl/core" prefix= "c" %> 
<div class="container">
  <div class="row">
     <div class="span2">
       <div style="position:relative;" onmouseover="mouseoverheader()" onmouseout="mouseoutheader()" >
	       <span style="position:absolute; z-index:-1; opacity: 0.8;" id="userheaderimage">
	            <span class="label label-warning">Level1</span>
	       </span>
	       <img class="img-polaroid border-radius" 
            src="<%=imgurl %>${uservo.image }" >
        </div>
     </div>
     <div class="span10">
 
        <span style="font-size: 20px;"><strong>${uservo.name }</strong>
        <c:if test="${uservo.sex == 1 }" >
           <img src="<%=assets%>mxkimage/male1.png">
        </c:if>
         <c:if test="${uservo.sex == 0 }" >
           <img src="<%=assets%>mxkimage/male2.png">
        </c:if>
		<span style="font-size: 15px;">(${uservo.interest })</span>
		</span>
           <span class="pull-right">
              <a onclick="showCreatePart()" href="javascript:;" class="btn btn-success"><i class="icon-rss-sign"></i>分享Part</a>
              <a href="showCreateSubjectView" class="btn btn-info"><i class="icon-plus-sign"></i>创建专辑</a>
           </span>
        <br />
		<div style="height:3px"></div>
	  <span style="font-size: 15px;" class="muted">
	     <strong>目前头衔</strong>：
	     <span class="label label-info"><img src="<%=metootitle%>${uservo.shareTileImage }">${uservo.shareTitle}</span>/
	     <span class="label label-success"><img src="<%=metootitle%>${uservo.commentTileImage}">${uservo.commentTitle } </span>/
	     <span class="label label-important"><img src="<%=metootitle%>${uservo.subjectTileImage}">${uservo.subjectTitle }</span> 
	  </span>  
	     <small><a href="javascript:;" onclick="showuserTitleModal()">更多头衔</a></small><br />
       <div style="height:3px"></div>
	   <span><a class="btn btn-mini" href="<%=rootPath%>/showUserCertificate">证书x${uservo.eCret }</a></span>
	   <span><a class="btn btn-mini" href="<%=rootPath%>/showUserGift">收到礼物</a></span>
	  <div style="height:3px"></div>   
	   <span class="muted">${uservo.info }</span>
	   	<a class="btn btn-warning btn-mini" href="<%=rootPath%>/updateUserView">编辑</a></span>
	   <br />
	   <div style="height:3px"></div>
        <span class="muted"><i class="icon-time"></i>Join Time:${uservo.createTime }</span>
        <span class="pull-right muted">
        <small>
                             总积分${uservo.commentPoint+uservo.sharePoint+uservo.subjectPoint }
             <span>|分享${uservo.sharePoint }</span>
             <span>|评论${uservo.commentPoint }</span>
             <span>|专题${uservo.subjectPoint }</span></small>
        </span>
        <br />
		<div style="height:3px"></div>
        <div class="btn-group" >
		          <a href="/userIndex" class="btn btn-mini" style="font-family:Microsoft YaHei;"><i class="icon-hdd"></i>Parts3</a>
				  <a href="<%=rootPath%>/userIndex" class="btn btn-mini" style="font-family:Microsoft YaHei;"><i class="icon-hdd"></i>专题${uservo.subject }</a>
				  <a href="<%=rootPath%>/userFoucsView" class="btn btn-mini" style="font-family:Microsoft YaHei;"><i class="icon-rss"></i>关注${uservo.focus }</a>
				  <a href="<%=rootPath%>/userFollowersView" class="btn btn-mini" style="font-family:Microsoft YaHei;"><i class="icon-group"></i>粉丝${uservo.followors }</a>
		 </div>
		 <span class="pull-right">
		 <a href="javascript:;" onclick="refreshUserStatus()" class="btn btn-mini">刷新状态</a>
		  <div class="btn-group">
             <a class="btn dropdown-toggle btn-mini " data-toggle="dropdown" href="#">
               <span >升级</span>
               <span class="caret"></span>
		     </a>
		     <ul class="dropdown-menu">
			       <li><a href="javascript:;" onclick="upgradeUserTile(1)">分享家</a></li>
				   <li><a href="javascript:;" onclick="upgradeUserTile(2)">评论家</a></li>
				   <li><a href="javascript:;" onclick="upgradeUserTile(3)">制作家</a></li>
              </ul>
		   </div>
		 
		 </span>
     </div>
  </div>
</div>
<br />

<div id="userTitleModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	    <div class="modal-header">
	       <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	       <h3>头衔状态</h3>
        </div>
        <div class="modal-body">
           <table class="table table-striped">
           <tr>
            <td>
                                       等级
             </td>
             <td>
                                     类型
             </td>
             <td>
                                      所需积分
             </td>
           </tr>
             <tr>
             <td>
              <span class='label'><img src="<%=metootitle%>rumen.png">入门级</span>
             </td>
             <td>
                                      分享家/评论家/制作家
             </td>
             <td>
                                      所需积分 10 分
             </td>
             </tr>
             
              <tr>
             <td>
              <span class='label'><img src="<%=metootitle%>caogen.png">草根级</span>
             </td>
             <td>
                                      分享家/评论家/制作家
             </td>
             <td>
                                      所需积分 30 分
             </td>
             </tr>
             
             
             <tr>
             <td>
              <span class='label'><img src="<%=metootitle%>diaosi.png">屌丝级</span>
             </td>
             <td>
                                      分享家/评论家/制作家
             </td>
             <td>
                                      所需积分 50 分
             </td>
             </tr>
             
             
             <tr>
             <td>
              <span class='label'><img src="<%=metootitle%>chuji.png">初级</span>
             </td>
             <td>
                                      分享家/评论家/制作家
             </td>
             <td>
                                      所需积分 100 分
             </td>
             </tr>
             
             <tr>
             <td>
              <span class='label'><img src="<%=metootitle%>zhongji.png">中级</span>
             </td>
             <td>
                                      分享家/评论家/制作家
             </td>
             <td>
                                      所需积分 200 分
             </td>
             </tr>
             
             
             <tr>
             <td>
              <span class='label'><img src="<%=metootitle%>gaoji.png">高级</span>
             </td>
             <td>
                                      分享家/评论家/制作家
             </td>
             <td>
                                      所需积分 300 分
             </td>
             </tr>
             
             
             <tr>
             <td>
              <span class='label'><img src="<%=metootitle%>tongpai.png">铜牌</span>
             </td>
             <td>
                                      分享家/评论家/制作家
             </td>
             <td>
                                      所需积分 500 分
             </td>
             </tr>
             
              <tr>
             <td>
              <span class='label'><img src="<%=metootitle%>yinpai.png">银牌</span>
             </td>
             <td>
                                      分享家/评论家/制作家
             </td>
             <td>
                                      所需积分 700 分
             </td>
             </tr>
             
              <tr>
             <td>
              <span class='label'><img src="<%=metootitle%>jinpai.png">金牌</span>
             </td>
             <td>
                                      分享家/评论家/制作家
             </td>
             <td>
                                      所需积分 1000 分
             </td>
             </tr>
             
                <tr>
             <td>
              <span class='label'><img src="<%=metootitle%>zhuanjia.png">专家级</span>
             </td>
             <td>
                                      分享家/评论家/制作家
             </td>
             <td>
                                      所需积分 1500 分
             </td>
             </tr>
             
             
               <tr>
             <td>
              <span class='label'><img src="<%=metootitle%>fasao.png">发烧级</span>
             </td>
             <td>
                                      分享家/评论家/制作家
             </td>
             <td>
                                      所需积分 2200 分
             </td>
             </tr>
             
             
               <tr>
             <td>
              <span class='label'><img src="<%=metootitle%>zuanshi.png">钻石级</span>
             </td>
             <td>
                                      分享家/评论家/制作家
             </td>
             <td>
                                      所需积分 3000 分
             </td>
             </tr>
             
             
               <tr>
             <td>
              <span class='label'><img src="<%=metootitle%>guhui.png">专家级</span>
             </td>
             <td>
                                      分享家/评论家/制作家
             </td>
             <td>
                                      所需积分 4000 分
             </td>
             </tr>
             
              <tr>
             <td>
              <span class='label'><img src="<%=metootitle%>tianshi.png">天使级</span>
             </td>
             <td>
                                      分享家/评论家/制作家
             </td>
             <td>
                                      所需积分 5500 分
             </td>
             </tr>
             
           </table>
        </div>
    </div>


<div id="createPartModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	    <div class="modal-header">
	       <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	       <h3>快速分享Part</h3>
        </div>
        <div class="modal-body">
          <form id="planform" action="createProjectPlan" enctype="multipart/form-data"
				method="post">
			 <span class="muted">把你看到你做过的经典分享给大家</span>	
			 <span>
				 <img id="loading" src="<%=domain %>loadingred.gif" style="display:none">
			 </span>
			 <br />
			 <div class="btn-group">
                      <a class="btn dropdown-toggle btn " data-toggle="dropdown" href="javascript:;">
                        <i class="icon-tags"></i><span id="showtags">Part标签</span>
                      <span class="caret"></span>
				    </a>
				     <ul class="dropdown-menu">
					   <li><a href="javascript:;" onclick="chooseTags('舰船模型')">舰船模型</a></li>
					   <li><a href="javascript:;" onclick="chooseTags('装甲模型')">装甲模型</a></li>
					   <li><a href="javascript:;" onclick="chooseTags('战机模型')">战机模型</a></li>
					   <li><a href="javascript:;" onclick="chooseTags('手办模型')">手办模型</a></li>
					   <li><a href="javascript:;" onclick="chooseTags('动漫模型')">动漫模型</a></li>
					   <li><a href="javascript:;" onclick="chooseTags('高达模型')">高达模型</a></li>
					   <li><a href="javascript:;" onclick="chooseTags('其他模型')">其他模型</a></li>
		               </ul>
				    </div>
			 <input id="fileToUpload" type="file" size="45" name="image"  /><br />
			 <small>写点描述吧</small><br />
			 <textarea id="partinfo" rows="3" style="width:98%" ></textarea>
          </form>
        </div>
	    <div class="modal-footer">
	      <a href="javascript:;" class="btn btn-primary" onclick="ajaxFileUpload()">发布</a>
	      <a href="javascript:;" class="btn" onclick="closeCreatePart()">关闭</a>
	    </div>
    </div>
    
<script type="text/javascript">
function showuserTitleModal(){
	 $('#userTitleModal').modal({
	      keyboard: false
	  });
}


function mouseoverheader(){
    $("#userheaderimage").css("z-index","1");
  }
  
  function mouseoutheader(){
	$("#userheaderimage").css("z-index","-1");
  }

function showCreatePart(){
	 $('#createPartModal').modal({
      keyboard: false
  });
}

function closeCreatePart(){
	 $('#createPartModal').modal('hide');
}

function chooseTags(tag){
	tags = tag;
	$('#showtags').html(tag);
	   
}
</script>
<script type="text/javascript"> 
   var tags = '';

   function validateImage() {
  	  return true;
   }
  
  
	function ajaxFileUpload()
	{   
		if(validateImage()){
			var info = $('#partinfo').val();
			if(tags == ''){
				alert("为Part加个标签吧！");
				return ;
			}
			var datas = {"createPartRequest.desc":info,"createPartRequest.type":tags};
			$("#loading").show();
			$.ajaxFileUpload
			(
				{
					url:path + "/createSinglePart.action",
					secureuri:false,
					fileElementId:'fileToUpload',
					dataType: 'json',
					data:datas,
					success: function (data, status)
					{  
						if(data.message == "success"){
							$("#loading").hide();
							closeCreatePart();
			    		    window.location.href= path + "/userSharePartsIndex";
						}
						
					},
					error: function (data, status, e)
					{
						$("#loading").hide();
						alert(data.message);
					}
				}
			);
		}
		return false;
	}
	</script>
	
	
<script type="text/javascript">
  var fireworks = function(){
	this.size = 20;
	this.rise();
  };
  
  
  fireworks.prototype = {
	color:function(){
		var c = ['0','3','6','9','c','f'];
		var t = [c[Math.floor(Math.random()*100)%6],'0','f'];
		t.sort(function(){return Math.random()>0.5?-1:1;});
		return '#'+t.join('');
	},
	aheight:function(){
		var h = document.documentElement.clientHeight+250;
		return Math.abs(Math.floor(Math.random()*h+10))+10;
	},
	firecracker:function(){
		var b = document.createElement('div');
		var w = document.documentElement.clientWidth;
		b.style.position = 'absolute';
		b.style.color = this.color();
		b.style.bottom = 0;
		b.style.left = Math.floor(Math.random()*w)+1+'px';
		
		var c = document.getElementById('upgrade_div');
		c.appendChild(b);
		return b;
	},
	rise:function(){
		var o = this.firecracker();
		var n = this.aheight();
		var c = this.color;
		var e = this.expl;
		var s = this.size;
		var k = n;
		var m = function(){
			o.style.bottom = parseFloat(o.style.bottom)+k*0.1+'px';
			k-=k*0.1;
			if(k<2){
				clearInterval(clear);
				e(o,n,s,c);
			}
		}
		o.innerHTML = '.';
		if(parseInt(o.style.bottom)<n){
			var clear = setInterval(m,20);
		}
	},
	expl:function(o,n,s,c){
		var R=n/3,Ri=n/6,Rii=n/9;
		var r=0,ri=0,rii=0;
		for(var i=0;i<s;i++){
			var span = document.createElement('span');
			var p = document.createElement('i');
			var a = document.createElement('a');
			span.style.position = 'absolute';
			span.style.fontSize = n/10+'px';
			span.style.left = 0;
			span.style.top = 0;
			span.innerHTML = '*';
			p.style.position = 'absolute';
			p.style.left = 0;
			p.style.top = 0;
			p.innerHTML = '*';
			a.style.position = 'absolute';
			a.style.left = 0;
			a.style.top = 0;
			a.innerHTML = '*';
			o.appendChild(span);
			o.appendChild(p);
			o.appendChild(a);
		}
		function spr(){
			r += R*0.1;
			ri+= Ri*0.06;
			rii+= Rii*0.06;
			sp = o.getElementsByTagName('span');
			p = o.getElementsByTagName('i');
			a = o.getElementsByTagName('a');
			for(var i=0; i<sp.length;i++){
				sp[i].style.color = c();
				p[i].style.color = c();
				a[i].style.color = c();
				sp[i].style.left=r*Math.cos(360/s*i)+'px';
				sp[i].style.top=r*Math.sin(360/s*i)+'px';
				sp[i].style.fontSize=parseFloat(sp[i].style.fontSize)*0.96+'px';
				p[i].style.left=ri*Math.cos(360/s*i)+'px';
				p[i].style.top=ri*Math.sin(360/s*i)+'px';
				p[i].style.fontSize=parseFloat(sp[i].style.fontSize)*0.96+'px';
				a[i].style.left=rii*Math.cos(360/s*i)+'px';
				a[i].style.top=rii*Math.sin(360/s*i)+'px';
				a[i].style.fontSize=parseFloat(sp[i].style.fontSize)*0.96+'px';
			}
			R-=R*0.1;
			if(R<2){
				o.innerHTML = '';
				o.parentNode.removeChild(o);
				clearInterval(clearI);
			}
		}
		var clearI = setInterval(spr,20);
	}
   };
  
    function show_upgrade_ok_div(){
    	
    	$("#upgrade_div").show();
		function happyNewYear(){
			new fireworks();
		}
		var a = setInterval(happyNewYear,500);
		setTimeout(closeupgradediv, 10000, a); 
		
    }
    
    function closeupgradediv(a){
    	clearInterval(a);
    	$("#upgrade_div").hide();
    	location.reload(); 
    }
    
    
    function upgradeUserTile(type){
    	$("#upgrade_div").show();
    	$("#upgrade_start").show();
    	$.ajax({
	   		url : path + "/metooUpgradeUserTile",
	   		type : "POST",
	   		cache : false,
	   		data:{"type":type},
	   		async : false,
	   		dataType : "json",
	   		success : function(item) {
	 			if(item.indexOf(",") != -1){
	 				var arr = item.split(",");
	 				$("#upgrade_message").html(arr[1]);
	 				$("#upgrade_start").hide();
	 				$("#upgrade_complete").show();
	 				show_upgrade_ok_div();
	 			}else{
	 				$("#upgrade_start").hide();
	 				$("#upgrade_div").hide();
	 				alert(item);
	 			}
	   		 }
	 	 }); 
    	
    }
    
</script>

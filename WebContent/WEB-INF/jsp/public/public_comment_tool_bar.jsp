<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<div class="span3">
	<ul class="thumbnails">
		<li class="span3">
			<div class="thumbnail">
			
			   <div class="well" id="gift_this" style="display: none">
					<span class="muted">感谢你对&nbsp;<a href="javascript:;">${targetUserVO.name
							}</a>&nbsp;积极分享的肯定 你可以送一个礼物给他
					</span><br /> <span class="pull-right"><a class="btn btn-mini"
						href="javascript:;"
						onclick="sendGift('${partEntity.userid}','${partEntity.id }','part')">送礼</a></span><br />
					<div id="gift_show" style="display: none">
						<center>
							<span class="label label-success"><strong><span
									id="gif_name"></span></strong><img id="gif_image" /></span><br /> <small><span
								id="gif_message" class="muted"></span></small>
						</center>
					</div>
				</div>
				<div class="well" id="like_this" style="display: none">
					<center id="like_show" style="display: none">
						<br />
						<div style="background-color: #FFFF00; width: 60px; height: 60px">
							<center>
								<br /> <font style="font-size: 25px;" color="#000000"><strong>+1</strong></font>
							</center>
						</div>
					</center>
				</div>
				<div class="well" id="point_this" style="display: none">
					<span>1~10分&nbsp;你怎么看</span> <br /> <span class="form-inline">
						<select id="point_select" style="width: 60px">
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="7">7</option>
							<option value="8">8</option>
							<option value="9">9</option>
							<option value="10">10</option>
					</select>&nbsp;<a class="btn" href="javascript:;"
						onclick="setPoint('${partEntity.id}','part')">评分</a>
					</span>
					<center id="point_show" style="display: none">
						<br />
						<div style="background-color: #008800;; width: 60px; height: 60px">
							<center>
								<br /> <font style="font-size: 25px;" color="#FFFFFF"><strong><span
										id="point_str"></span>分</strong></font>
							</center>
						</div>
					</center>
				</div>
			    <span class="pull-right">
				<a class="btn btn-mini" href="javascript:;" onclick="showactionthis(1)"><i
					class="icon-gift"></i>送礼</a>
				<a class="btn btn-mini" href="javascript:;"
					onclick="showactionthis(2);setlike('${partEntity.id }','part');"><i
					class="icon-heart"></i>喜欢</a> 
				<a class="btn btn-mini" href="javascript:;"
					onclick="showactionthis(3)"><i class="icon-trophy"></i>评分</a>
			  </span>		
			</div>
		</li>
	</ul>
</div>
     <script type="text/javascript">
        function showactionthis(type){
        	if(type == 1) {
        		$("#gift_this").show();
        		$("#like_this").hide();
        		$("#point_this").hide();
        	}else if(type == 2) {
        		$("#like_this").show();
        		$("#gift_this").hide();
        		$("#point_this").hide();
        	}else if(type == 3) {
        		$("#point_this").show();
        		$("#like_this").hide();
        		$("#gift_this").hide();
        	}
        }
     
        function sendGift(userid,targetId,type){
        	var datas = {"sendGiftRequest.sendGifttToUserId":userid,"sendGiftRequest.targetId":targetId,"sendGiftRequest.type":type};
        	$.ajax({
    	   		url : path + "/sendGift.action",
    	   		type : "POST",
    	   		cache : false,
    	   		async : false,
    	   		data: datas,
    	   		dataType : "json",
    	   		success : function(item) {
    	   		    if(item.indexOf(',') != -1){
    	 			   array = item.split(",");
    	 			   $("#gif_image").attr("src","http://www.waileecn.com/mxk/assets/mxkimage/gift/"+array[2]);
    	 			   $("#gif_name").html(array[0]);
    	 			   $("#gif_message").html(array[1]);
    	 			   $("#gift_show").show(1000);
    			    }else {
    			     	alert(item);
    			    }
    	   		  }
    	   }); 
        }
        
        function setPoint(targetId,type){
        	var point = $("#point_select").val();
        	var datas = {"setPointRequest.tragetid":targetId,"setPointRequest.trageType":type,"setPointRequest.point":point};
        	$.ajax({
    	   		url : path + "/setPoint.action",
    	   		type : "POST",
    	   		cache : false,
    	   		async : false,
    	   		data: datas,
    	   		dataType : "json",
    	   		success : function(item) {
    	   		    if(item == 'success'){
    	 			   $("#point_str").html(point);
    	 			   $("#point_show").show(1000);
    			    }else {
    			     	alert(item);
    			    }
    	   		 }
    	   });
        }
        
        function setlike(tragetid,trageType){
        	var datas = {"baseRequest.tragetid":tragetid,"setPointRequest.trageType":trageType};
        	$.ajax({
    	   		url : path + "/setLike.action",
    	   		type : "POST",
    	   		cache : false,
    	   		async : false,
    	   		data: datas,
    	   		dataType : "json",
    	   		success : function(item) {
    	   		    if(item == 'success'){
    	   		    	$("#like_show").show(1000);
    	   	        	$("#like_show").hide(3000,function(){
    	   	        		$("#like_this").hide();
    	   	        	});
    			    }else {
    			     	alert(item);
    			    }
    	   		 }
    	   });
        }
        
     </script>
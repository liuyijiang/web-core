  function collectPart(partid){
	  $.ajax({
   		url : path + "/createUserCollect.action",
   		type : "POST",
   		cache : false,
   		async : false,
   		data: {"collectPartsRequest.targetId":partid},
   		dataType : "json",
   		success : function(item) {
   		    if(item == 'success'){
 			   alert("已将Part加入到你的收藏夹");
		    }else if( item == 'error'){
		   	   alert("网络异常请重试");
		    }else {
		     	alert(item);
		    }
   		  }
 	 }); 
  }
  
  function refreshUserStatus(){
	  alert(1);
	  $.ajax({
   		url : path + "/refreshUserStatus",
   		type : "POST",
   		cache : false,
   		async : false,
   		dataType : "json",
   		success : function(item) {
   		    if(item == 'success'){
   		    	alert("状态已刷新");
   		    	location.reload(); 
		    }else {
		     	alert(item);
		    }
   		  }
 	 }); 
  }
  
 //visitor 
  function sendMomeyModal(){
		 $('#sendMomeyModal').modal({
		      keyboard: false
	   });
	}

	function closeSendMomeyModal(){
	   $('#sendMomeyModal').modal('hide');
	}

	function setMoney(id){
		var money = $("#submoney").val();
		var datas = {"setPriceRequest.subjectid":id,"setPriceRequest.money":money};
		if(isNaN(money)){
			alert('请输入一个正确的金额');
		}else{
		   if(money < 0){
			   alert("这也太少了吧");
		   }else{
			   $.ajax({
			 		url : path + "/setPriceToSubject",
			 		type : "POST",
			 		cache : false,
			 		async : false,
			 		data: datas,
			 		dataType : "json",
			 		success : function(item) {
			 			if(item=='success'){
			 				alert("定价成功");
			 				closeSendMomeyModal();
			 			}else if(item=='error'){
			 				alert("网络连接异常");
			 			}else{
			 				alert(item);
			 			}
			 	    }
			});
		   }
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
		var datas = {"baseRequest.tragetid":tragetid,"baseRequest.trageType":trageType};
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
	   	        	$("#like_show").hide(3000);
			    }else {
			     	alert(item);
			    }
	   		 }
	   });
	}
	
	 function showSubCommentsModal(type){
		  if(type == 1){
			  $("#gift_this_model").show();
			  $("#like_this_model").hide();  
			  $("#point_this_model").hide();  
			  $("#subCommentsheader").html("赠送礼物");
		  }else if(type == 2){
			  $("#like_this_model").show();  
			  $("#gift_this_model").hide();
			  $("#point_this_model").hide(); 
			  $("#subCommentsheader").html("喜欢专题");
		  }else if(type == 3){
			  $("#gift_this_model").hide();
			  $("#like_this_model").hide();  
			  $("#point_this_model").show();  
			  $("#subCommentsheader").html("专题评分");
		  }
		
		  $('#sendSubCommentModal').modal({
		      keyboard: false
		  });
	}
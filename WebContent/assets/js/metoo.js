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
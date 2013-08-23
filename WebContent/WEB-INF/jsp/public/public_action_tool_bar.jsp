<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div >
  <div id="upgrade_div" style="padding:5px;display:none;height:1000px;width:100%; background-image: url(http://www.waileecn.com/mxk/assets/mxkimage/probg.png);" >
     <br /><br /><br /><br /><br /><br /><br /><br />
     <center>
       <font id="upgrade_complete" color="#FFFFFF" style="display:none;font-size:40px">恭喜升级为：<span id="upgrade_message"></span></font>
       <div id="upgrade_start" style="display:none;">
          <img id="" src="<%=domain %>loadingred.gif">
           <span class="muted"><small>正在升级中...</small></span>
       </div>
     </center>
  </div>
  <div id="actionbar"  style="padding:5px;display:none;height:40px;width:100%;background-image: url(http://www.waileecn.com/mxk/assets/mxkimage/probg.png);" >
     <div class="container">
     <a class="btn btn-small" href="<%=rootPath %>/partDashBoard">
	   <i class="icon-th"></i>Parts面板
	 </a>
     <a class="btn btn-small" href="<%=rootPath %>/visitiorShowSubjectDashBorad">
	   <i class="icon-th-large"></i>专题面板
	 </a>
	 <a class="btn btn-small btn-success" href="javascript:;" onclick="$('#actionbar_fastgo').show();">
	   <i class="icon-external-link"></i>快速跳转
	 </a>
	 <a class="btn btn btn-danger btn-small" href="javascript:;" onclick="$('#actionbar_top10').show();showTop10('1');">
	   <i class="icon-signal"></i>Top 10
	 </a>
     <a href="http://weibo.com/u/1841004522" target="_blank" class="btn btn-warning btn-small"><i class="icon-weibo"></i>官方微博</a>
      <span class="pull-right">
        <a href="javascript:;" onclick="showActionBar(false)"><i class="icon-remove-sign" ></i></a>
           &nbsp; &nbsp;  
       </span>
     </div>
  </div>

  <div id="actionbar_fastgo"  style="padding:5px;display:none;height:40px;width:100%; background-image: url(http://www.waileecn.com/mxk/assets/mxkimage/probg.png);" >
	  <div class="container" > 
	         <div class="row">
	          <div class="span11">
		          <div class="input-append">
	                 <input class="span2" id="fast_go_page" placeholder="去第几页" type="text">
	                 <button class="btn" type="button" onclick="chagePage()">GO</button>
	              </div>
              </div>
              <div class="span1">
              <a class="pull-right" href="javascript:;" onclick="$('#actionbar_fastgo').hide();">
                <i class="icon-remove-sign" ></i>
              </a>
              </div>
              </div>
	  </div>
  </div>
  
  <div id="actionbar_top10"  style="padding:5px;display:none;height:70px;width:100%; background-image: url(http://www.waileecn.com/mxk/assets/mxkimage/probg.png);" >
       <div class="container" > 
           <div class="span1">
              <span style="font-size: 20px;"><strong><font id="part_time_info" color="#FFFFFF">本周内Top10</font></strong></span>
              <div class="btn-group">
	             <a class="btn dropdown-toggle btn-mini " data-toggle="dropdown" href="javascript:;">
	               <span id="tool_part_time_btn">本周</span>
			     </a>
		     <ul class="dropdown-menu">
			       <li><a href="javascript:;" onclick="showTop10('1');$('#tool_part_time_btn').html('本周');$('#part_time_info').html('本周内Top10');">本周</a></li>
				   <li><a href="javascript:;" onclick="showTop10('2');$('#tool_part_time_btn').html('本月');$('#part_time_info').html('本月内Top10');">本月</a></li>
                   <li><a href="javascript:;" onclick="showTop10('3');$('#tool_part_time_btn').html('全站');$('#part_time_info').html('全站内Top10');">全站</a></li>
              </ul>
		   </div>
           </div>
            <div id="top10_div">
               <div>
                  <img src="<%=domain %>loadingred.gif" >
                  <span class="muted"><small>正在努力加载...</small></span>
                </div>
            </div>
            <span class="pull-right">
                <a href="javascript:;" onclick="$('#actionbar_top10').hide();"><i class="icon-remove-sign" ></i></a>
           &nbsp; &nbsp;  
           </span>
     </div> 
  </div>
  
</div>
<script type="text/javascript">
   function chagePage(){
	   var fp = $("#fast_go_page").val();
	   var regu = /^[-]{0,1}[0-9]{1,}$/;
	   if (regu.test(fp.trim())) {
		   page = fp;
		   loadMore();
	   }
   }

   function showActionBar(actionbarshow){
	   
	   if(actionbarshow){
		   actionbarshow = false; 
		   $("#actionbar").show();
	   }else{
		   actionbarshow = true; 
		   $("#actionbar").hide();
	   }
	   
   }
   
   function showTop10(type){
	   $.ajax({
	   		url : path + "/showTopParts",
	   		type : "POST",
	   		cache : false,
	   		data:{"type":type},
	   		async : false,
	   		dataType : "json",
	   		success : function(item) {
	 			var lists = item.list;
	 			var showtop = '';
	 			for (var i in lists) {
	 				showtop = showtop +"<a href='"+ path + "/visitorShowPartDetail?target=" +lists[i].id +"'><div class='span1'><img style='height:60px;width: 60px;' class='img-polaroid'  src='"+ imgurl + lists[i].minimage +"'></div></a>";
	 			}
	   			$("#top10_div").html(showtop);
	   		 }
	 	 }); 
   }
   
</script> 
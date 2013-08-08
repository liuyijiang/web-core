<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div style="position:relative;" >
  <span id="actionbar" style="padding:5px;display:none;height:50px;width:100%;background-color:#000000; position: fixed; z-index:2; opacity: 0.7;" >
     <a class="btn btn-small" href="<%=rootPath %>/partDashBoard">
	   <i class="icon-th"></i>Parts面板
	 </a>
     <a class="btn btn-small" href="<%=rootPath %>/visitiorShowSubjectDashBorad">
	   <i class="icon-th-large"></i>专题面板
	 </a>
	 <a class="btn btn btn-danger btn-small" href="<%=rootPath %>/showTopParts">
	   <i class="icon-signal"></i>Top 10
	 </a>
	 
     <a href="http://weibo.com/u/1841004522" target="_blank" class="btn btn-warning btn-small"><i class="icon-weibo"></i>官方微博</a>
      
      <span class="pull-right">
        <a href="javascript:;" onclick="showActionBar(false)"><i class="icon-remove-sign" ></i></a>
           &nbsp; &nbsp;  
       </span>
     
  </span>
</div>
<script type="text/javascript">
   function showActionBar(actionbarshow){
	   
	   if(actionbarshow){
		   actionbarshow = false; 
		   $("#actionbar").show();
	   }else{
		   actionbarshow = true; 
		   $("#actionbar").hide();
	   }
	   
   }
</script> 
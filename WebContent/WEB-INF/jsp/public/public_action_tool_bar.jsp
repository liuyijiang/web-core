<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div >
  <div id="actionbar"  style="padding:5px;display:none;height:40px;width:100%;background-image: url(http://www.waileecn.com/mxk/assets/mxkimage/probg.png);" >
     <div class="container">
     <a class="btn btn-small" href="<%=rootPath %>/partDashBoard">
	   <i class="icon-th"></i>Parts面板
	 </a>
     <a class="btn btn-small" href="<%=rootPath %>/visitiorShowSubjectDashBorad">
	   <i class="icon-th-large"></i>专题面板
	 </a>
<!-- 	 <a class="btn btn-small" href="#" onclick="$('#actionbar_user').show();"> -->
<!-- 	   <i class="icon-th-large"></i>找模友 -->
<!-- 	 </a> -->
<%-- 	 <a class="btn btn btn-danger btn-small" href="<%=rootPath %>/showTopParts"> --%>
<!-- 	   <i class="icon-signal"></i>Top 10 -->
<!-- 	 </a> -->
     <a href="http://weibo.com/u/1841004522" target="_blank" class="btn btn-warning btn-small"><i class="icon-weibo"></i>官方微博</a>
      <span class="pull-right">
        <a href="javascript:;" onclick="showActionBar(false)"><i class="icon-remove-sign" ></i></a>
           &nbsp; &nbsp;  
       </span>
     </div>
  </div>
  
<!--   <div id="actionbar_user"  style="padding:5px;display:none;height:40px;width:100%;background-color:#34495e;  opacity: 0.9;" > -->
<!--      dadasd -->
    
<!--   </div> -->
  
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
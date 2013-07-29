<%
	String record = "http://www.waileecn.com/mxk/assets/"; 
%>
<script type="text/javascript" src="<%=record %>/js/jquery-1.7.2.js"></script>
<script type="text/javascript" src="<%=record %>/js/jRecorder.js"></script>
<script type="text/javascript" src="<%=record %>/js/bootstrap-modal.js"></script>
<script type="text/javascript" src="<%=record %>/js/bootstrap-transition.js" ></script>
<script type="text/javascript" src="<%=record %>/js/bootstrap-carousel.js" ></script>
<script type="text/javascript" src="<%=record %>/js/bootstrap-dropdown.js" ></script>
<script type="text/javascript" src="<%=record %>/js/bootstrap-alert.js" ></script>
<script type="text/javascript" src="<%=record %>/js/jquery-caretposition-getter.js"></script>

<script type="text/javascript"> 
     var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
      document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3Fb2b2d8bf1eddfda520470cc87bb9d858' type='text/javascript'%3E%3C/script%3E"));
 </script>
 
 <script type="text/javascript">
  
  function to_search(){
	 var top_parm = $("#form_parm").val();
	 if(top_parm == ""){
		 alert("请输入查询条件！");
	 }else{
		 $("#topsearchparm").val(top_parm);
		 $("#top_form").submit();
	 } 
  }
  
</script>

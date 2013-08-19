<%
	String fassets = "http://www.waileecn.com/mxk/assets"; 
%>
<script type="text/javascript" src="<%=fassets %>/js/jquery-1.7.2.js"></script>
<script type="text/javascript" src="<%=fassets %>/js/bootstrap-modal.js"></script>
<script type="text/javascript" src="<%=fassets %>/js/bootstrap-transition.js" ></script>
<script type="text/javascript" src="<%=fassets %>/js/bootstrap-carousel.js" ></script>
<script type="text/javascript" src="<%=fassets %>/js/bootstrap-dropdown.js" ></script>
<script type="text/javascript" src="<%=fassets %>/js/bootstrap-alert.js" ></script>
<script type="text/javascript" src="<%=fassets %>/js/jquery-caretposition-getter.js"></script>
<script type="text/javascript" src="<%=fassets %>/js/bootstrap-tooltip.js"></script>
<script type="text/javascript" src="<%=fassets %>/js/bootstrap-popover.js"></script>
<script type="text/javascript" src="<%=fassets %>/js/jquery.form.js"></script>
<script type="text/javascript" src="<%=fassets %>/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="assets/js/metoo.js"></script>

<!-- <script type="text/javascript" src="assets/js/jquery-1.7.2.js"></script> -->
<!-- <script type="text/javascript" src="assets/js/bootstrap-modal.js"></script> -->
<!-- <script type="text/javascript" src="assets/js/bootstrap-transition.js" ></script> -->
<!-- <script type="text/javascript" src="assets/js/bootstrap-carousel.js" ></script> -->
<!-- <script type="text/javascript" src="assets/js/bootstrap-dropdown.js" ></script> -->
<!-- <script type="text/javascript" src="assets/js/bootstrap-alert.js" ></script> -->
<!-- <script type="text/javascript" src="assets/js/jquery-caretposition-getter.js"></script> -->
<!-- <script type="text/javascript" src="assets/js/bootstrap-tooltip.js"></script> -->
<!-- <script type="text/javascript" src="assets/js/bootstrap-popover.js"></script> -->
<!-- <script type="text/javascript" src="assets/js/jquery.form.js"></script> -->
<!-- <script type="text/javascript" src="assets/js/ajaxfileupload.js"></script> -->
<!-- <script type="text/javascript" src="assets/js/cloud-carousel.1.0.5.js"></script> -->

<script type="text/javascript"> 
     var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
      document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3Fb2b2d8bf1eddfda520470cc87bb9d858' type='text/javascript'%3E%3C/script%3E"));
 </script>
 
 <script type="text/javascript">
  
  function to_search(){
	 var top_parm = $("#form_parm").val();
	 if(top_parm == ""){
		 alert("请输入查询条件");
	 }else{
		 $("#topsearchparm").val(top_parm);
		 $("#top_form").submit();
	 } 
  }
  
</script>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<span class="label" style="position:fixed;left:0;bottom:0;height:30px">总页数:<span id="f_allpage"></span><br />当前页数:<span id="f_countpage">1</span></span>
<a class="btn" onclick="toTop()" style="position:fixed;right:0;bottom:0;height:40px"><i class="icon-long-arrow-up icon-3x"></i></a>
<script type="text/javascript">
   function toTop(){
	   window.scrollTo(0,0);
   }
   
   function setfooterPage(page){
	   $("#f_countpage").html(page);
   }
   
   function setfooterallpage(allpage){
		 $("#f_allpage").html(allpage);
   }
</script> 
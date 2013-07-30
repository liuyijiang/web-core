<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
 <%@ include file="../../../headerinclude.jsp"%>
</head>
<body class="mxkbody mxkbackgroud" >
	<%@ include file="../public/user_page_header.jsp"%>
	<div class="container mxkplan mxkshadow">
	  <br />
	  <table class="table">
	    <tr>
	     <td width="14%" style="border:0">
	     <span>&nbsp;</span><br>
	       <span class="pull-right text-info" style="font-size: 16px;"><span id="showtype" >PUBLIC</span>:<i class="icon-hdd "></i>&nbsp;</span>
	     </td>
	     <td width="66%" style="border:0">
	     <span><strong>专辑标签</strong></span>
	     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	     <span><strong>专辑名称</strong></span>
	     <br>
	     <div class="form-inline">
	               <div class="btn-group">
                    <button onclick="javascript:;" class="btn"><i class="icon-tags"></i><span id="showtags">专题标签</span></button>
		            <button class="btn dropdown-toggle" data-toggle="dropdown">
				       <span class="caret"></span>
				    </button>
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
         &nbsp;/&nbsp;
         <input id="tagname" type="text" class="input-block-level" style="width:300px">
          <div class="btn-group">
             <a class="btn dropdown-toggle btn " data-toggle="dropdown" href="#">
               <span id="category_btn">原创</span>
               <span class="caret"></span>
		     </a>
		     <ul class="dropdown-menu">
			       <li><a href="javascript:;" onclick="choosecategory('原创')">原创</a></li>
				   <li><a href="javascript:;" onclick="choosecategory('分享')">分享</a></li>
              </ul>
		   </div>
         <br />
         <small>伟大的作品名称是短小和令人难忘的。需要灵感吗?<span class="text-success">我的战舰系列.</span></small>
         <br /><br />
         <form id="form" action="createSubject" method="POST">
         <span><strong>专辑描述</strong></span><br />
         <input name="createSubjectRequest.info" type="text" class="input-block-level" style="width:730px">
         <small>简短又生动的描述会让专题更加出彩.</small>
         <hr />
         <label class="radio">
            <i class="icon-hdd"></i>
              <input onclick="chooseType('PUBLIC')" name="upvo.ispublic" type="radio"  id="optionsRadios1" value="1" checked>
                 <strong>公开</strong><br />
                 &nbsp;&nbsp;&nbsp;<span class="muted"><small>任何人都可以看到并分享你的专辑.</small></span>                                                       
          </label><br />
           <label class="radio">
              <i class="icon-lock"></i>
	             <input onclick="chooseType('PRIVATE')" name="upvo.ispublic" type="radio"  id="optionsRadios1" value="0" >
	                <strong>私人</strong> <br />                                                       
	              &nbsp;&nbsp;&nbsp;<span class="muted"><small>其他人占时不可以看到你的专辑除非你将工程设为公开.</small></span>                                                       
           </label><br />
            <label class="radio">
              <i class="icon-globe"></i>
	             <input onclick="chooseType('FOR-ALL')" name="upvo.ispublic" type="radio" id="optionsRadios1" value="0" >
	                <strong>共享</strong> <br />                                                       
	              &nbsp;&nbsp;&nbsp;<span class="muted"><small>你的专题是被共享的任何用户都可以再你的专题中上传图片.</small></span>                                                       
           </label><br />
         <hr />
         <input id="subjectname" name="createSubjectRequest.name"  style="display:none"/>
         <input id="subjecttag" name="createSubjectRequest.tags" style="display:none"/>
          <input id="subjectcategory" name="createSubjectRequest.category" value="原创" style="display:none"/>
         <input id="subjecttype" name="createSubjectRequest.type" value="PUBLIC" style="display:none"/>
         </form>
         <button class="btn btn-primary btn-large" onclick="subform()">创建专题</button>
	     </td>
	      <td width="10%" style="border:0">&nbsp;</td>
	    </tr>
	  </table>
	  <br />
	</div>
	<%@ include file="../../../footinclude.jsp"%>
	<script type="text/javascript">
	   function chooseType(type){
		   $('#subjecttype').val(type);
		   $('#showtype').html(type);
	   }
	   
	   function chooseTags(tag){
		   $('#subjecttag').val(tag);
		   $('#showtags').html(tag);
		   
	   }
	   
	   function subform(){
		   var name = $('#tagname').val();
		   var tags = $('#subjecttag').val();
		   if(name == ''){
			   alert("请输入专题名称");
			   return;
		   }
		   if(tags == ''){
			   alert("请选择专题标签");
			   return; 
		   }
		   $('#subjectname').val(name);
		   $('#form').submit();
		   
	   }
	   
	   function choosecategory(category){
		   $("#category_btn").html(category);
		   $("#subjectcategory").val(category);
	   }
	   
	</script>
	
</body>
</html>
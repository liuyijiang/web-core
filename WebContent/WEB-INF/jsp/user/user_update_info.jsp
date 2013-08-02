<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
 <%@ include file="../../../headerinclude.jsp"%>
</head>
<body class="mxkbody mxkbackgroud">
<%@ include file="../public/user_page_header.jsp"%>
  <div class="container ">
		<div class="row">
           <div class="span1">
             &nbsp;
           </div>		
		   <div class="span10 mxkplan mxkshadow" style=" padding:19px; margin-bottom: 20px;">
		      <form id="re" action="userUpdateInfo" enctype="multipart/form-data" method="post">
					<span style="font-size: 20px;" class="text-info"><strong>修改个人信息</strong></span><br />
					<hr />
					<label>用户昵称</label>
					<input id="username" type="text" value="${uservo.name }"
						class="input-block-level" style="width:400px" name="userRegisterRequest.username"
						onblur="valiateparm('name')" /><span id="emailvaliate"></span><br /> 
					<span class="muted"><small>用户名要唯一哟</small></span> <br />
					<hr />
					<label>性别</label> 
					<select name="userRegisterRequest.sex">
						<option value="1">男</option>
						<option value="0">女</option>
					</select> <br /> 
					<label>关注方向</label> 
					<select name="userRegisterRequest.interest">
						<option value='舰船模型'>舰船模型</option>
						<option value='装甲模型'>装甲模型</option>
						<option value='战机模型'>战机模型</option>
						<option value='动漫模型'>动漫模型</option>
						<option value='动态航空'>动态模型</option>
						<option value='其他模型'>其他模型</option>
					</select> 
					<hr />
					<div id="more">
						<label>个性头像:</label> <input type="file" name="userRegisterRequest.image"
							class="input-block-level"> <br />
					    <label>个性宣言</label> <input
							id="useremail" type="text" class="input-block-level" value="${uservo.info }"
							name="userRegisterRequest.info" />
					</div>
		    </form>
			<button class="btn btn-success btn-large" onclick="sub()">完成修改</button>
		   </div>
		   <br /> <br />
		   <div class="span1">
		     &nbsp; 
		   </div>
		</div>
	</div>
<%@ include file="../../../footinclude.jsp"%>
<script type="text/javascript">
   
   var emailvalidate = true;
   
    function valiateparm(type){
    	emailvalidate = false;
    	if(type == "name"){
    		$("#emailvaliate").html("");
    		var parm = $('#username').val();
    		var datas = {"registerCheckRequest.parm":parm,"registerCheckRequest.type":type};
    		validate(datas,type);
    	}
    }
   
    function validate(datas,type){
    	$.ajax({
			url : path + "/registerCheck.action",
			type : "POST",
			cache : false,
			async : false,
			data: datas,
			dataType : "json",
			success : function(item) {
				callback(item,type);
			}
       });
    }
    
    function callback(message,type){
    	if(type == "name"){
    		if(message == "success"){
    			$("#emailvaliate").html("<span class='text-success'><i class='icon-ok icon-2x'></i>可以使用这个昵称</span>");
    			emailvalidate = true;
    		}else{
    			emailvalidate = false;
    			$("#emailvaliate").html("<span class='text-error'><i class='icon-remove icon-2x'></i>这个昵称已被使用</span>");
    		}
    	}
    }
    
    
    function sub(){
    	if(emailvalidate){
    		$("#re").submit();
    	}
    }

</script>
</body>

</html>
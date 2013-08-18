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
           
           </div>		
		   <div class="span10 mxkplan mxkshadow" style=" padding:19px; margin-bottom: 20px;">
		      <form id="re" action="userRegister" enctype="multipart/form-data" method="post">
					<span style="font-size: 20px;" class="text-info"><strong>用户注册</strong></span><br />
					<span class="muted">注册后你可以创建自己的模型专题，分享收藏其他模型玩家的part</span>
					<hr />
					<label>用户昵称</label>
					<input id="username" type="text"
						class="input-block-level" style="width:400px" name="userRegisterRequest.username"
						onblur="valiateparm('name')" /><span id="namevaliate"></span><br /> 
					<span class="muted">用户名要唯一哟</span> <br />
					<br /> 
					<label>邮箱地址</label> 
					<input id="useremail" type="text"
						class="input-block-level" style="width:400px" onblur="valiateparm('email')"
						name="userRegisterRequest.email"><span id="emailvaliate"></span><br /> 
				    <span class="muted">邮箱地址也要唯一哟这是你的登陆账号</span>
					<br /> <br /> <label>用户密码</label> 
					<input id="password"
						type="password" class="input-block-level" name="userRegisterRequest.password"
						style="width: 400px" onblur="ispass()" /><span id="passwordvaliate"></span><br />
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
					</select> <br /> <br /> 
					<hr />
					<label class="checkbox"> <input type="checkbox" id="iii"
						value="ok" onclick="show()"> 其他信息
					</label>
					<div id="more" style="display: none">
						<label>个性头像:</label> <input type="file" name="userRegisterRequest.image"
							class="input-block-level"> <br />
					    <label>个性宣言</label> <input
							id="useremail" type="text" class="input-block-level"
							name="userRegisterRequest.info" />
					</div>
					
		  </form>
			<button class="btn btn-primary btn-large" onclick="smb()">完成注册</button>
		   </div>
		   <br /> <br />
		   <div class="span1">
		   
		   </div>
		</div>
	</div>
	
	<script type="text/javascript">
          function show(){
        	  if($("#iii").attr("checked")){
   			      $("#more").show();
   		       }else{
   		    	  $("#more").hide();
   		       }
          }
      </script>
	
<!-- 	   <footer> -->
<%-- 			<%@ include file="../public/footer.jsp"%> --%>
<!-- 		</footer> -->
	<%@ include file="../../../footinclude.jsp"%>
	<script type="text/javascript">
   
	  function valiateparm(type){
	    	if(type == "email"){
	    		$("#emailvaliate").html("");
	    		if(!isEmail()){
	    			return;
	    		}
	    		var parm = $('#useremail').val();
	    		var datas = {"registerCheckRequest.parm":parm,"registerCheckRequest.type":type};
	    		validate(datas,type);
	    	}else if(type == "name"){
	    		$("#namevaliate").html("");
	    		if(!isName()){
	    			return;
	    		}
	    		var parm = $('#username').val();
	    		var datas = {"registerCheckRequest.parm":parm,"registerCheckRequest.type":type};
	    		validate(datas,type);
	    	}
	    }
	   
	    function validate(datas,type){
	    	$.ajax({
				url : path + "/registerCheck",
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
	    	if(type == "email"){
	    		if(message == "success"){
	    			emailvalidate = true;
	    			$("#emailvaliate").html("<span class='text-success'><i class='icon-ok icon-2x'></i>可以使用这个邮箱</span>");
	    		}else{
	    			emailvalidate = false;
	    			$("#emailvaliate").html("<span class='text-error'><i class='icon-remove icon-2x'></i>这个邮箱已被使用</span>");
	    		}
	    	}else if(type == "name"){
	    		if(message == "success"){
	    			namevalidate = true;
	    			$("#namevaliate").html("<span class='text-success'><i class='icon-ok icon-2x'></i>可以使用这个昵称</span>");
	    		}else{
	    			namevalidate = false;
	    			$("#namevaliate").html("<span class='text-error'><i class='icon-remove icon-2x'></i>这个昵称已被使用</span>");
	    		}
	    	}
	    }
	    
	</script>
	<script type="text/javascript">
	var passbeanvalidate = false;
	var namevalidate = false;
	var emailvalidate = false;
	
	function isEmail() {
		var strEmail = $("#useremail").val();
		if (strEmail.search(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/) != -1){
			return true;
		}else{
			$("#emailvaliate").html("<span class='text-error'><i class='icon-remove icon-2x'></i>这个邮箱格式不正确</span>");
			return false;
		}
	  }  
	
	function isName(){
		var parm = $("#username").val();
		if(parm != ""){
			return true;
		}else{
			$("#namevaliate").html("<span class='text-error'><i class='icon-remove icon-2x'></i>昵称不能为空</span>");
			return false;
		}
	}
	
	function ispass(){
		var parm = $("#password").val();
		if(parm != ""){
			passbeanvalidate = true;
			$("#passwordvaliate").html("<span class='text-success'><i class='icon-ok icon-2x'></i>密码输入正确</span>");
		}else{
			passbeanvalidate = false;
			$("#passwordvaliate").html("<span class='text-error'><i class='icon-remove icon-2x'></i>密码不能为空</span>");
		}
	}
	
	function smb(){
        if(passbeanvalidate && namevalidate && emailvalidate){
        	$('#re').submit();
        }
	}
	</script>
</body>
</html>
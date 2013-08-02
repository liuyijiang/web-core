<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
 <%@ include file="../../../headerinclude.jsp"%>
</head>
<style type="text/css">
body {
	padding-top: 40px;
	padding-bottom: 40px;
}

</style>

<body class="mxkbody">
	<%@ include file="../public/user_page_header.jsp"%>
	<div class="container" id="logindiv">
	   <c:if test="${!empty message}">
			<div id="error" class="alert alert-error">
			   <a class="close" data-dismiss="alert">×</a>
			   <p>${message }</p>
			</div>
	   </c:if>
		<form class="form-signin" action="loginIn" method="post">
			<h2 class="form-signin-heading">用户登陆</h2>
			<input type="text" name="userLoginRequest.loginName" class="input-block-level"
				placeholder="用户邮箱" /> <input type="password" name="userLoginRequest.loginPass"
				class="input-block-level" placeholder="用户密码" /> 
			<span class="pull-right">
			   <a href="#" onclick="$('#logindiv').hide();$('#passdiv').show();"><i class="icon-key"></i>&nbsp;忘记密码</a>&nbsp;&nbsp;
			   <button class="btn btn-primary" type="submit">&nbsp;登陆&nbsp;</button>
			</span>
			<br/><br/>
		</form>

	</div>
	<div class="container" id="passdiv" style="display:none">
	
	    <div class="form-signin" >
			<h2 class="form-signin-heading">找回密码</h2>
			<div class="control-group success">
			<label class="control-label" for="inputSuccess">你的邮箱地址</label>
			<div class="controls">
			<input id="sendmail" type="text" class="input-block-level">
			</div>
			</div>
			<span class="pull-right">
			   <a href="#" onclick="$('#logindiv').show();$('#passdiv').hide();">&nbsp;返回登陆&nbsp;</a>
			   <button class="btn btn-success" onclick="sendmail()" >&nbsp;修改&nbsp;</button>
			</span>
			<br/><br/>
		</div>
	</div>
	<%@ include file="../../../footinclude.jsp"%>
	<script type="text/javascript">
	   function sendmail(){
		   var mail = $('#sendmail').val();
		   $.ajax({
				url : path + "/sendChangePasswordMail",
				type : "POST",
				cache : false,
				async : false,
				data: {"changePasswordRequest.usermail": mail},
				dataType : "json",
				success : function(item) {
					if(item == "success"){
						alert("邮件已发送请查收！");
					}else{
						alert("网络延时请重试！");
					}
				}
		  });
	   }
	</script>
</body>
</html>
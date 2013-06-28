<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../../../headerinclude.jsp"%>
</head>
<body class="mxkbody">
<%@ include file="../public/user_page_header.jsp"%>
	<div class="container">
	   <div class="alert alert-block">
                            <a class="close" data-dismiss="alert">×</a>
                            <c:if test="${message == 'success' }">
                            <h4 class="alert-heading">你现在正在修改!</h4>
                                      ${usermail } 这个账户的密码
                            </c:if>
                            <c:if test="${message != 'success' }">
                            <h4 class="alert-heading">修改请求已过期!</h4>
                            </c:if>
                           </div>
	   <c:if test="${message == 'success' }">
		<form id="passfrom" class="form-signin" action="updateUserPassword" method="post">
			   <h2 class="form-signin-heading text-error"><i class="icon-warning-sign"></i>修改密码</h2>
			    <input type="text" name="userChangePasswordRequest.usermail"  value="${usermail }" style="display:none"/> 
			     <input type="text" name="userChangePasswordRequest.uuid"  value="${uuid }" style="display:none"/>
			     <input id="one" type="password" name="userChangePasswordRequest.onepassword" class="input-block-level"
				 placeholder="新的密码" /> 
				<input id="two" type="password" name="userChangePasswordRequest.twopassword"
				class="input-block-level" placeholder="再次确认" /> 
			<a href="#" class="btn btn-large btn-primary" onclick="sub()" >&nbsp;修改&nbsp;</a>
		</form>
     </c:if>
	</div>
	<script type="text/javascript">
	  function sub(){
		  var one = $('#one').val();
		  var two = $('#two').val();
		  if(one != "" && two != "" ){
			  if(one == two){
				  $('#passfrom').submit(); 
			  }else{
				  alert("密码不一致");
				  return;
			  }
		  }else{
			  alert("新密码不能为空");
			  return;
		  }
		  
	  }
	</script>
	 <%@ include file="../../../footinclude.jsp"%>
</body>
</html>
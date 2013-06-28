<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="../../../headerinclude.jsp"%>
</head>
<body class="mxkbody mxkbackgroud" >
<%@ include file="../public/user_page_header.jsp"%>
	 <%@ include file="../../../footinclude.jsp"%>
<div class="container">
  <br/><br/><br/><br/><br/><br/><br/>
  <a class="btn btn-success btn-large" href="<%=rootPath%>/loginView"><i class="icon-group"></i>加入米兔</a>
  <a class="btn btn-primary btn-large" href="<%=rootPath%>/partDashBoard"><i class="icon-coffee"></i>随便看看</a>
  
  <a  id="a"  data-placement="bottom"  href="#" onmouseout="$('#a').popover('hide');" onmouseover="$('#a').popover('show');"   class="btn btn-danger" rel="popover" data-content="他来" data-original-title="他是谁">鼠标经过弹出提示</a>
  
</div>

</body>
</html>
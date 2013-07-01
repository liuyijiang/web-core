<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri= "http://java.sun.com/jsp/jstl/core" prefix= "c" %>    
<%
	String rootPath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
	String domain = "http://www.waileecn.com";
	String webcontext = "http://localhost:8080/webmxk/";
// 	String imgurl = "http://192.168.1.101/image/";
// 	String voice = "http://192.168.1.101/voice/";
	String imgurl = "http://192.168.2.127/mxk/image/";
	String voice = "http://192.168.2.127/mxk/voice/";
	String pdf = "http://www.waileecn.com/mxk/pdf/";
	String assets = "http://www.waileecn.com/mxk/assets/"; 
	//String imgurl = "http://192.168.1.102/image/";   
%>
<title>米兔</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="baidu-site-verification" content="fGnwyrMhEn5OFnZv" />
<meta name="description" content="米兔 模型控 模型Fan 模型 进度">
<meta name="keyword" content="米兔 模型控 模型Fan 模型 进度 管理  军事模型  ">
<link type="image/x-icon" href="assets/mxkimage/LogoMaker.png" rel="icon">
<link type="image/x-icon" href="assets/mxkimage/LogoMaker.png"  rel="shortcut icon">
<link rel="stylesheet" type="text/css" href="assets/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="assets/css/font-awesome.min.css" /> 
<link rel="stylesheet" type="text/css" href="assets/css/mxk.css" /> 
<script type="text/javascript">
var path = '<%=rootPath%>';
var imgurl = '<%=imgurl %>';
var voice = '<%=voice %>';
</script>
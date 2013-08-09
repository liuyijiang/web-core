<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri= "http://java.sun.com/jsp/jstl/core" prefix= "c" %> 
<div class="navbar navbar-inverse navbar-fixed-top" style="opacity: 0.9;">
		<div class="navbar-inner">
			<div class="container">
				<a class="brand" href="index"><strong>米兔Metoo</strong></a>
				<div class="nav-collapse">
					<ul class="nav">
					   <li class="divider-vertical"></li>
					       <a id="top_a" class="btn btn-inverse" onclick="showActionBar(true)" href="javascript:;" >
						      <i class="icon-list"></i> 
					       </a>
                            <div class="btn-group">
							    <button id="filterbtn" class="btn btn-inverse" style="font-family:Microsoft YaHei;" ><i class="icon-search"></i>过滤查询</button>
							    <button class="btn dropdown-toggle btn-inverse" data-toggle="dropdown">
							       <span class="caret"></span>
                                </button>
						    <ul class="dropdown-menu">
						         <li><a onclick="fliter_part('舰船模型')" href="javascript:;">舰船模型</a></li>
							     <li><a onclick="fliter_part('装甲模型')" href="javascript:;">装甲模型</a></li>
							     <li><a onclick="fliter_part('战机模型')" href="javascript:;">战机模型</a></li>
							     <li><a onclick="fliter_part('手办模型')" href="javascript:;">手办模型</a></li>
							     <li><a onclick="fliter_part('动漫模型')" href="javascript:;">动漫模型</a></li>
							     <li><a onclick="fliter_part('高达模型')" href="javascript:;">高达模型</a></li>
							     <li><a onclick="fliter_part('其他模型')" href="javascript:;">其他模型</a></li>
							     <li class="divider"></li>
							     <li><a href="<%=rootPath %>/partDashBoard">所有模型</a></li>
						    </ul>
                         </div>
					  </ul>
					    <div class="navbar-form"> 
					     &nbsp; &nbsp;
					     <input id="form_parm" class="span4" placeholder="搜专辑..." type="text">
					     <button class="btn btn-inverse" onclick="to_search()" type="button">Go!</button>
						<c:choose>
						     <c:when test="${!empty uservo}">
						              <span class="pull-right">
						                 <div class="btn-group">
												    <button class="btn btn-inverse"><img style="width:18px" src="<%=imgurl %>${uservo.minimage }"/><strong>${uservo.name }</strong></button>
												    <button class="btn dropdown-toggle btn-inverse" data-toggle="dropdown">
												    <span class="caret"></span>
						                           </button>
											    <ul class="dropdown-menu">
											         <li><a href="<%=rootPath%>/userSharePartsIndex">单图分享</a></li>
											         <li><a href="<%=rootPath %>/userIndex">我的专题</a></li>
												     <li><a href="<%=rootPath %>/showNewRssMessage">我的关注</a></li>
												     <li><a href="<%=rootPath %>/userCollectIndex">我的收藏</a></li>
												     <li class="divider"></li>
												     <li><a href="<%=rootPath %>/showHelp"><i class="icon-book"></i>帮助</a></li>
												     <li><a href="<%=rootPath %>/userLoginOut"><i class="icon-signout"></i>退出</a></li>
											    </ul>
						                        </div>
						               </span>
						     </c:when>
						     <c:otherwise>
						            <span class="pull-right">
						                <a href="registerView" class="btn btn-success"><i class="icon-user"></i>&nbsp;用户注册 &nbsp;</a>
						                <a href="loginView" class="btn btn-inverse"><i class="icon-signin"></i>&nbsp;登陆</a>
						              </span>
						     </c:otherwise>
						</c:choose>
                    </div>
				</div>
			</div>
		</div>
		<%@ include file="public_action_tool_bar.jsp"%>
	</div>
<form id="top_form" action="<%=rootPath %>/visitiorShowSubjectDashBorad" method="POST" style="display:none">
   <input id="topsearchparm" name="visitorSeeSubjectDashBoardRequest.parm" >
</form>
<script type="text/javascript">
  
  var filtertype = '';

  function to_search(){
	 var top_parm = $("#form_parm").val();
	 if(top_parm == ""){
		 alert("请输入查询条件！");
	 }else{
		 $("#topsearchparm").val(top_parm);
		 $("#top_form").submit();
	 } 
  }
  
  function fliter_part(type){
	  $("#filterbtn").html(type);
	  filtertype = type;//
	  filterParts();
  }
  
</script>

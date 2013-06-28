<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="../../../headerinclude.jsp"%>
</head>
<body class="mxkbody mxkbackgroud" >
<%@ include file="../public/user_page_header.jsp"%>
<div class="container">
	<div class="row">
	      <div class="span8 mxkplan mxkshadow">
	         <div id="rssdiv" style="padding:5px;margin-bottom:1px;">
	             <c:if test="${empty subjectMessageShowRespone.list }">
	                 <div class="alert alert-block">
                          <a class="close" data-dismiss="alert">×</a>
                          <h4 class="alert-heading">目前还没有人订阅你的专题!</h4>
                                                                                       每天发布几张专题最新图片可以提高你专题的知名度
                     </div>
	             </c:if>
	             <c:if test="${!empty subjectMessageShowRespone.list }">
	               <c:forEach var="options" items="${subjectMessageShowRespone.list }">
		               <table style="width:100%">
				          <tr>
				            <td width="12%">
				             <img class='img-polaroid border-radius' src="<%=imgurl %>/${options.userimage}" style="width:55px" />
				            </td>
				            <td width="88%">
				                <span><a href="<%=rootPath %>vistiorShowUserIndex?target=${options.userid}">${options.username}</a></span>
				                <span class="pull-right"><button class="btn btn-small" onclick="removeRss('${options.userid}')">取消订阅</button></span>
				                <br />
				                <span class="muted">${options.userdesc }</span><br />
				                <span class="muted"><i class="icon-time"></i>订阅时间：${options.ceateTime }</span>
				            </td>
				          </tr>
			           </table>
			           <div style='padding:1px;margin-bottom:1px;'>
			            <div style='width:100%; border-top:1px solid #cccccc'></div>
			           </div>
		          </c:forEach>
	             </c:if>
	         </div>
	         
	         <c:if test="${!empty subjectMessageShowRespone.list }">
		         <div style="padding:5px;margin-bottom:1px;">
		          <span id="loading" style="display:none"><img src="<%=domain %>/image/loadingred.gif" >正在加载...</span>
		          <span class="pull-right" id="rssmore"><a href="javascript:;" class="btn btn-small btn-primary" onclick="loadmorelist()" ><i class="icon-refresh"></i>加载更多</a></span><br />
		         </div>
		         <script type="text/javascript">
		            function loadmorelist(){
		            	var datas = {"showRssSubjectUserRequest.subjectid":subjectid,"showRssSubjectUserRequest.page":page};
		            	$("#loading").show();
		            	 $.ajax({
		        				url : path + "/subjectMessageMore.action",
		        				type : "POST",
		        				cache : false,
		        				async : false,
		        				data: datas,
		        				dataType : "json",
		        				success : function(item) {
		        					$("#loading").hide();
		        					createlist(item.list);
		        					page = page + 1 ;
		        				}
		        	   });
		            }
		            
		            function createlist(list){
		            	var show = '';
		            	for (var i in list) {
		            		//show = show + "<div style='padding:1px;margin-bottom:1px;'><div style='width:100%; border-top:1px solid #cccccc'></div></div>";
 		            		show = show + "<table style='width:100%'><tr><td width='12%'>" +
		            		"<img class='img-polaroid border-radius' src='"+ imgurl + list[i].userimage +"' style='width:55px' />" +
		            		"</td><td width='88%'><span><a href='"+ path + "/vistiorShowUserIndex?target="+ list[i].userid +"'>"+ list[i].username + "</a></span>" +
		                    "<span class='pull-right'><button class='btn btn-small' onclick='removeRss(\""+list[i].userid + "\")' >取消订阅</button></span>" +
		                    "<br /><span class='muted'>"+ list[i].userdesc +"</span><br />" + 
		                    "<span class='muted'><i class='icon-time'></i>订阅时间："+ list[i].ceateTime + "</span></td></tr></table>" +
		                    "<div style='padding:1px;margin-bottom:1px;'><div style='width:100%; border-top:1px solid #cccccc'></div></div>";
		               }
		               $("#rssdiv").append(show);          
		            }
		         </script>
	         </c:if>
	         
	        </div>
	  
	      <div class="span4">
	         <ul class="thumbnails">
			    <li class="span4 mxkplan mxkshadow">
				<div class="thumbnail" >
					<c:if test="${empty subjectMessageShowRespone.subjectNewPartsVO }">
					  <img src="<%=imgurl %>/${subjectMessageShowRespone.subjectEntity.faceimage}" />  <!-- style="width: 100%;" -->
					</c:if>
					<c:if test="${!empty subjectMessageShowRespone.subjectNewPartsVO }">
						<table style="width:100%">
		                <tr>
		                  <td rowspan="2" colspan="2">
		                  <img src="<%=imgurl %>/${subjectMessageShowRespone.subjectEntity.faceimage}" style="border-radius:3px 3px 3px 3px;border: 1px solid #e5e5e5;width:200px;height:200px;">  <!-- style="width: 100%;" -->
		                  </td>
		                  <td><img src="<%=imgurl %>/${subjectMessageShowRespone.subjectNewPartsVO.partImage1}" style="border-radius:3px 3px 3px 3px;border: 1px solid #e5e5e5;width:80px;height:95px;"></td>
		                </tr>
		                <tr>
		                  <td><img src="<%=imgurl %>/${subjectMessageShowRespone.subjectNewPartsVO.partImage2}" style="border-radius:3px 3px 3px 3px;border: 1px solid #e5e5e5;width:80px;height:95px;"></td>
		                </tr>
		                <tr>
		                  <td><img src="<%=imgurl %>/${subjectMessageShowRespone.subjectNewPartsVO.partImage3}" style="border-radius:3px 3px 3px 3px;border: 1px solid #e5e5e5;width:95px;height:90px;"></td>
		                  <td><img src="<%=imgurl %>/${subjectMessageShowRespone.subjectNewPartsVO.partImage4}" style="border-radius:3px 3px 3px 3px;border: 1px solid #e5e5e5;width:95px;height:90px;"></td>
		                  <td><img src="<%=imgurl %>/${subjectMessageShowRespone.subjectNewPartsVO.partImage5}" style="border-radius:3px 3px 3px 3px;border: 1px solid #e5e5e5;width:80px;height:90px;"></td>
		                </tr>
				      </table>
					</c:if>
		         </div>
		      </li>
		  </ul>
	   </div>
	</div>
</div>
<%@ include file="../../../footinclude.jsp"%>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<div class="container">
	<div class="row">
		<div class="span2">
			<img class="img-polaroid border-radius"
				src="<%=imgurl %>${subjectEntity.faceimage }"
				style="height: 140px; width: 230px">
		</div>
		<div class="span10">
			<span style="font-size: 20px;"><strong><a
					href="<%=rootPath%>/vistiorShowUserIndex?target=${targetUserVO.id}">${targetUserVO.name
						}</a></strong>&nbsp;/&nbsp;${subjectEntity.name }</span> &nbsp; <span class="muted"><small>(<i
					class="icon-tags"></i>${subjectEntity.tags })
			</small> <c:choose>
					<c:when test="${subjectEntity.type == 'PUBLIC'}">
						<span class="label label-success"><i class="icon-hdd"></i>公开</span>
					</c:when>
				</c:choose> </span> <span class="pull-right"> <a href="javascript:;"
				class="btn btn-primary"
				onclick="rsssubject('${subjectEntity.id}','${subjectEntity.userid }')"><i
					class="icon-rss"></i>订阅专题</a> <a href="javascript:;"
				class="btn btn-success" onclick="sendMomeyModal()"><i
					class="icon-jpy"></i>专题定价</a> <br /> <span class="pull-right">
					<c:if test="${subjectEntity.qrcodeImage != null }">
						<div style="height: 3px"></div>
						<img style="width: 85px;"
							src="<%=imgurl %>${subjectEntity.qrcodeImage}">
					</c:if>
			</span>
			</span> <br />
			<div style="height: 3px"></div>
			<span style="font-size: 15px;" class="muted">${subjectEntity.info
				}</span> <br />
			<div style="height: 3px"></div>
			<span class="label label-important">${subjectEntity.category
				}类 专题</span> <span class="label">最高定价 ${subjectEntity.highMoney } 元</span>
			<span class="label">最高评分 ${subjectEntity.highPoint} 分</span> <small><a
				href="<%=rootPath %>/vistiorShowSubjectExtra?type=4&target=${subjectEntity.id}">更多</a></small>
			<div style="height: 3px"></div>
			<span> <a href="<%=rootPath %>/vistiorShowSubjectExtra?type=3&target=${subjectEntity.id}" class="btn btn-mini">喜欢x${subjectEntity.likes
					}</a> <a href="<%=rootPath %>/vistiorShowSubjectExtra?type=1&target=${subjectEntity.id}" class="btn btn-mini">礼物x${subjectEntity.gifts }</a>
			</span> <br />
			<div style="height: 3px"></div>
			<span class="muted"><i class="icon-time"></i>Join
				Time:${subjectEntity.createTime }</span><br />
			<div style="height: 3px"></div>
			<div class="btn-group btn-mini ">
				<a class="btn btn-mini"
					href="<%=rootPath%>/visitorShowPartSilderView"> <i
					class="icon-expand "></i>幻灯播放
				</a>
				<button class="btn btn-mini" style="font-family: Microsoft YaHei;">
					<i class="icon-rss"></i>订阅${subjectEntity.attention }
				</button>
				<button class="btn btn-mini" style="font-family: Microsoft YaHei;">
					<i class="icon-comment-alt"></i>评论${subjectEntity.comments }
				</button>
				<button class="btn btn-mini" style="font-family: Microsoft YaHei;">
					<i class="icon-pushpin"></i>Parts${subjectEntity.parts }
				</button>
			</div>
			<span class="pull-right">
				<div class="btn-group btn-mini">
					<a class="btn btn-mini" href="javascript:;"
						onclick="showSubCommentsModal(1)"><i class="icon-gift"></i>送礼</a>
					<a class="btn btn-mini" href="javascript:;"
						onclick="showSubCommentsModal(2);setlike('${subjectEntity.id }','subject');"><i
						class="icon-heart"></i>喜欢</a> <a class="btn btn-mini"
						href="javascript:;" onclick="showSubCommentsModal(3)"><i
						class="icon-trophy"></i>评分</a>
				</div>
			</span>
		</div>
	</div>
</div>
<br />
<div id="sendMomeyModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">&times;</button>
		<h3>专题作品定价</h3>
	</div>
	<div class="modal-body">
		<div class="well">
			<div class="control-group success">
				<label class="control-label" for="inputSuccess">你来为这个专题作品定个价吧！</label>
				<div class="controls">
					<span class="form-inline"> <input type="text" id="submoney">
						<a class="btn" href="javascript:;"
						onclick="setMoney('${subjectEntity.id}')">确定</a> &nbsp; <span
						style="font-size: 18px;"><strong>
								最高定价：${subjectEntity.highMoney } 元 </strong></span>
					</span>
				</div>
			</div>
		</div>
	</div>
</div>



<div id="sendSubCommentModal" class="modal hide fade" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">&times;</button>
		<h3 id="subCommentsheader"></h3>
	</div>
	<div class="modal-body">

		<div class="well" id="gift_this_model" style="display: none">
			<span class="muted">感谢你对&nbsp;<a href="javascript:;">${targetUserVO.name
					}</a>&nbsp;积极分享的肯定 你可以送一个礼物给他
			</span><br /> <span class="pull-right"><a class="btn btn-mini"
				href="javascript:;"
				onclick="sendGift('${subjectEntity.userid}','${subjectEntity.id }','subject')">送礼</a></span><br />
			<div id="gift_show" style="display: none">
				<center>
					<span class="label label-success"><strong><span
							id="gif_name"></span></strong><img id="gif_image" /></span><br /> <small><span
						id="gif_message" class="muted"></span></small>
				</center>
			</div>
		</div>

		<div class="well" id="like_this_model" style="display: none">
			<center id="like_show" style="display: none">
				<br />
				<div style="background-color: #FFFF00; width: 60px; height: 60px">
					<center>
						<br /> <font style="font-size: 25px;" color="#000000"><strong>+1</strong></font>
					</center>
				</div>
			</center>
		</div>

		<div class="well" id="point_this_model" style="display: none">
			<span>1~10分&nbsp;你觉得这个作品能得多少分</span> <br /> <span
				class="form-inline"> <select id="point_select"
				style="width: 60px">
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
					<option value="6">6</option>
					<option value="7">7</option>
					<option value="8">8</option>
					<option value="9">9</option>
					<option value="10">10</option>
			</select>&nbsp;<a class="btn" href="javascript:;"
				onclick="setPoint('${subjectEntity.id}','subject')">评分</a>
			</span>
			<center id="point_show" style="display: none">
				<br />
				<div style="background-color: #008800;; width: 60px; height: 60px">
					<center>
						<br /> <font style="font-size: 25px;" color="#FFFFFF"><strong><span
								id="point_str"></span>分</strong></font>
					</center>
				</div>
			</center>
		</div>
	</div>
</div>
<div class="container ">
		<div class="navbar">
			<div class="navbar-inner">
				 <span>
                <div class="btn-group">
                      <a class="btn dropdown-toggle btn " data-toggle="dropdown" href="#">
                        <i class="icon-globe"></i>分享
                      <span class="caret"></span>
				    </a>
				     <ul class="dropdown-menu">
					       <li>
						      <a href="http://service.weibo.com/share/share.php?url=<%=rootPath%>/vistiorShowSubjectDatailFromShare?target=${subjectEntity.id }&pic=<%=imgurl %>${subjectEntity.faceimage }&title=${subjectEntity.name }&nbsp;&nbsp;${subjectEntity.info }" target="_blank">
						                   分享到新浪微博
						       </a>
					       </li>
						   <li>
							   <a href="http://share.v.t.qq.com/index.php?c=share&a=index&url=<%=rootPath%>/vistiorShowSubjectDatailFromShare?target=${subjectEntity.id }&pic=<%=imgurl %>${subjectEntity.faceimage }&title=${subjectEntity.name }&nbsp;&nbsp;${subjectEntity.info }" target="_blank">
							         分享到QQ微信
							   </a>
						   </li>
						   <li>
							   <a href="http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url=<%=rootPath%>/index&pic=<%=imgurl %>${subjectEntity.faceimage }&title=${subjectEntity.name }&nbsp;&summary=${subjectEntity.info }|&nbsp;<%=rootPath%>/vistiorShowSubjectDatailFromShare?target=${partEntity.id }" target="_blank">
							         分享到QQ空间
							   </a>
						  </li>
		               </ul>
				    </div>
            <a class="btn" href="<%=rootPath %>/visitorShowSubjectMaterial?target=${subjectEntity.id}" > 
              <i class="icon-calendar "></i>材料列表
            </a>
         </span>
               <span class="pull-right">
                <a class="btn" href="<%=rootPath %>/visitiorShowSubjectComements?target=${subjectEntity.id}"><i class="icon-comments-alt"></i>评论${subjectEntity.comments }</a>
               </span>
			</div>
		</div>
	</div>
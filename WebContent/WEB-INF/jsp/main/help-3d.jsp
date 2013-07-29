<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html xmlns:wb=“http://open.weibo.com/wb”>
<script src="http://tjs.sjs.sinajs.cn/open/api/js/wb.js" type="text/javascript" charset="utf-8"></script>
<head>
<%@ include file="../../../headerinclude.jsp"%>
</head>
<body class="mxkbody mxkbackgroud" onload="showChar()" >
<%@ include file="../public/user_page_header.jsp"%>
<script type="text/javascript">
  
  function showChar(){
	  $("#carousel1").CloudCarousel(		
				{			
					xPos: 450,
					yPos: 27,
					minScale: 0.2,
					reflHeight:0,
					reflGap:0,
					reflOpacity:0.1,
					buttonLeft: $("#left-but"),
					buttonRight: $("#right-but"),
					altBox: $("#alt-text"),
					titleBox: $("#title-text")
				}
			);
  }

</script>	
<div class="container mxkplan mxkshadow">
     <div id = "carousel1" style="width:960px; height:720px;">            
            <!-- All images with class of "cloudcarousel" will be turned into carousel items -->
            <!-- You can place links around these images -->
            <img class = "cloudcarousel img-polaroid border-radius" src="http://192.168.1.127/mxk/image/51eff6390cf2c3481d34bfc5_mini.png" alt="Flag 11 Description" title="Flag 221 Title" />
            <img class = "cloudcarousel img-polaroid border-radius" src="http://192.168.1.127/mxk/image/51eff6390cf2c3481d34bfc5_mini.png" alt="Flag 2dw Description" title="Flag 2 Title" />
            <img class = "cloudcarousel img-polaroid border-radius" src="http://192.168.1.127/mxk/image/51eff6390cf2c3481d34bfc5_mini.png" alt="Flag 3 Description" title="Flag 3 Title" />
            <img class = "cloudcarousel img-polaroid border-radius" src="http://192.168.1.127/mxk/image/51eff6390cf2c3481d34bfc5_mini.png" alt="Flag 4 Description" title="Flag 4 Title" />
             <img class = "cloudcarousel img-polaroid border-radius" src="http://192.168.1.127/mxk/image/51eff6390cf2c3481d34bfc5_mini.png" alt="Flag 3 Description" title="Flag 3 Title" />
            <img class = "cloudcarousel img-polaroid border-radius" src="http://192.168.1.127/mxk/image/51eff6390cf2c3481d34bfc5_mini.png" alt="Flag 4 Description" title="Flag 4 Title" />
           <img class = "cloudcarousel img-polaroid border-radius" src="http://192.168.1.127/mxk/image/51f0dd7ce24ac33601bee7f7_mini.png" alt="Flag 4 Description" title="Flag 4 Title" />
        
        </div>
        
        <!-- Define left and right buttons. -->
        <input id="left-but"  type="button" value="Left" />
        <input id="right-but" type="button" value="Right" />
        
        <!-- Define elements to accept the alt and title text from the images. -->
        <p id="title-text"></p>
        <p id="alt-text"></p>
</div>

 <%@ include file="../../../footinclude.jsp"%>
</body>
</html>
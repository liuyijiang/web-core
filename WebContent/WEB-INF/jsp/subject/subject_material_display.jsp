<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 <head>
  <title>dw </title>
<!--[if IE]><script language="javascript" type="text/javascript" src="js/excanvas.min.js"></script><![endif]--> 
<!-- <link rel="stylesheet" type="text/css" href="css/jquery.jqplot.min.css" />  -->
<!-- <script language="javascript" type="text/javascript" src="js/jquery.min.js"></script>  -->
<!-- <script language="javascript" type="text/javascript" src="js/jquery.jqplot.min.js"></script>  -->
<!-- <script language="javascript" type="text/javascript" src="js/jqplot.pieRenderer.min.js"></script> -->
<!-- <script type="text/javascript" src="js/jqplot.highlighter.min.js"></script> -->
<!-- <script type="text/javascript" src="js/jqplot.cursor.min.js"></script> -->
<%@ include file="../../../footinclude.jsp"%>
<%@ include file="../../../chartinclude.jsp"%>
<script type="text/javascript">

		 

$(document).ready(function(){
    var s1 = [['dawd', 9],['PEf', 80], ['dwadaw', 7],['dawd', 6],['dawd', 5]];
         
    var plot8 = $.jqplot('chart', [s1], {
	    animate: true,
        // Will animate plot on calls to plot1.replot({resetAxes:true})
        animateReplot: true,
        grid: {
            drawBorder: false,
            drawGridlines: false,
            shadow:false
        },
        axesDefaults: {
             
        },
        seriesDefaults:{
            renderer:$.jqplot.PieRenderer,
            rendererOptions: {
                showDataLabels: true
            }
        },
        legend: {
            show: true,
            rendererOptions: {
                numberRows: 1
            },
            location: 's'
        }
    });
});

//-->
</script>
 </head>

 <body>
  <div id="chart" style="margin-top:20px; margin-left:20px; width:460px; height:300px;"></div>
 </body>
</html>

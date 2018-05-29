<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--meta http-equiv="Content-Type" content="text/html; charset=utf-8" /-->
<meta http-equiv="X-UA-Compatible" content="IE=9; IE=8; IE=7; IE=EDGE"> 
<script type="text/JavaScript" src="javascript/cookie.js"></script>
<title>Network Camera</title>
<script type="text/JavaScript">

function frameLoad(top,left)
{
	var timeVal = (new Date()).getTime();
	document.getElementById("topFrame").src = top+"?_="+timeVal;
	document.getElementById("rightFrame").src = left+"?_="+timeVal;

}

function initFrame()
{
    var i = isSU();
	if(i==0){
		window.location.replace(window.location.protocol+"//"+window.location.host);	
		return;
	}
	document.getElementById("mainFrame").src = "video/videoindex.asp" ;
    var lang = 	navigator.language||navigator.systemLanguage;
	if(lang.toLowerCase() == "zh-cn")
		frameLoad("/browse/top/roottopC.asp","/browse/video/videosetC.asp");
	else
		frameLoad("/browse/top/roottop.asp","/browse/video/videoset.asp");

}

</script>
</head>

<frameset rows="55,*" cols="*" frameborder="no" border="0" framespacing="0" style="background-color:#aaaaaa;" onLoad="initFrame()">
  <frame name="topFrame" scrolling="No" noresize="noresize" id="topFrame" />

  <frameset cols="0,*,280" id="main" name="main" frameborder="no" border="0" framespacing="0">
  
    <frame name="leftFrame" noresize="noresize" id="leftFrame" style="padding:0 0;border:1px solid #6197fe;"  />
    <frame name="mainFrame" id="mainFrame"  />
    <frame name="rightFrame" id="rightFrame" style="padding:0 0"  />
  </frameset>
</frameset>
<noframes><body>
</body>
</noframes>
</html>


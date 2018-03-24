<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>my own asp</title>
<style type="text/css">

html,body {
	margin:0;
	padding:0;
	background-color:#999999;
	height:100%;
}


.spreadDiv{

	border:none;
	height:100%;
	/*background:url(../images/hidden.gif) no-repeat center;*/
	position:relative;
}

.spreadDiv p{
	position:absolute;
	top:47%;
	cursor:pointer;
}
</style>
<script type="text/javascript" language="javascript">

function hiddenfun()
{
	document.getElementById("imgHidden").style.display = "none";
	document.getElementById("imgSpread").style.display = "inline";
	top.document.getElementById("main").cols = "0,*,0";

}
function spreadfun()
{
	document.getElementById("imgHidden").style.display = "inline";
	document.getElementById("imgSpread").style.display = "none";
	top.document.getElementById("main").cols = "0,*,280";	
}

document.documentElement.oncontextmenu = function(){return false;}

</script>

</head>
<body>
<div class="spreadDiv">
<p><img id="imgHidden" src="../images/hiddenright.gif"  width="7" height="36" onclick="hiddenfun();"  border="0" />
  <img id="imgSpread" src="../images/hiddenleft.gif"  width="7" height="36" onclick="spreadfun();" border="0" style="display:none" /></p>
</div>

</body>
</html>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link type="text/css" rel="stylesheet" href="../css/reControl.css" />
<script type="text/javascript" src="../javascript/jquery.js"></script>
<script type="text/javascript" src="../javascript/common.js"></script>
<script type="text/javascript" src="../javascript/dialog.js"></script>
<script type="text/javascript" src="../javascript/reControl.js"></script>
<script type="text/javascript">
window.onload = function(){
	//reControlInit();
	sysShow('hankClass',0);
	setTimeout('replayerInit()',100);
}
</script>
</head>
<body>
<input type="hidden" id="PAGE_LANGUAGE" value="1" />
<input type="hidden" id="UsdUsb" value='<%SDGet("USB","net");%>' />
<input type="hidden" id="Hi3518E" value='<%videoparaGet("hi3518e", "net");%>' />
<input type="hidden" id="Hi3518EV200" value='<%videoparaGet("hi3518ev200", "net");%>' />
<input type="hidden" id="Hi3516A" value='<%videoparaGet("hi3516a", "net");%>' />
<input type="hidden" id="Hi3516C" value='<%videoparaGet("hi3516c", "net");%>' />
<input type="hidden" id="Hi3519" value='<%videoparaGet("hi3519", "net");%>' />
<iframe id="hideFrame" name="hideFrame" style=" display:none"></iframe>
<!--
<div class="topMenu">
	<ul style="width:190px">
    	<li class="choose" onclick="stopPlay();sysShow('hankClass',0)">参数设置</li>
        <li class="choose" onclick="sysShow('hankClass',1);setTimeout('replayerInit()',100);">录像回放</li>
    </ul>
</div>
-->

<div align="center" class="hankClass" style="padding-top:15px;">
            <input name="RtspPort" id="rtspPort" type="hidden" value="<%NetPortGet("RtspPort","net");%>"/>
            <input name="HttpPort" id="httpPort" type="hidden" value="<%NetPortGet("HttpPort","net");%>"/>
            <input name="RecordPort" id="recordPort" type="hidden" value="<%NetPortGet("RecordPort","net");%>"/>
		  	<!--<object id="replay" name="replay" width="930" height="540" border="0" classid="clsid:BF55C34E-FB1B-4FAF-8C1D-82C5265D87D9" codebase="../video/IPC_PlayerAX.cab#version=2,0,0,7" standby="Waiting..." viewastext></object>-->
<script language="javascript">
	if(navigator.userAgent.indexOf("Chrome") == -1 && navigator.userAgent.indexOf("Firefox") == -1)
		document.write('<object id="replay" name="replay" width="930" height="540" border="0" classid="clsid:BF55C34E-FB1B-4FAF-8C1D-82C5265D87D9" codebase="../video/IPC_PlayerAX.cab#version=2,0,0,7" standby="Waiting..." viewastext>');
	else
		document.write('<object id="replay" name="replay" width="930" height="540" border="0" type="application/x-itst-activex" clsid="{BF55C34E-FB1B-4FAF-8C1D-82C5265D87D9}" progid="../video/IPC_PlayerAX.cab#version=2,0,0,7" standby="Waiting..." viewastext>');
	document.write('</object>');
</script>
</div>
</body>
</html>

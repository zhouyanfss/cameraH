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
	reControlInit();
}

</script>
</head>
<body>
<input type="hidden" id="PAGE_LANGUAGE" value="0" />
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
    	<li class="choose" onclick="stopPlay();sysShow('hankClass',0)">Settings</li>
        <li class="choose" onclick="sysShow('hankClass',1);setTimeout('replayerInit();replayerLang()',100);">Playback</li>
    </ul>
</div>
-->

<div class="hankClass">
    <div class="hankName"><label>Recording Control</label></div>
    <form name="SDControlForm" id="SDControlForm" action="/form/SDSet"  method="post" target="hideFrame">
        <input type="hidden" name="flag" value="1" />
        <input type="hidden" id="SDModeGet" value='<%SDGet("SDMode","net");%>' />
        <input type="hidden" id="SDStartGet" value='<%SDGet("SDStart","net");%>' />
        <input type="hidden" id="NLostRecordGet" value='<%SDGet("NLostRecord","net");%>' />
        <input type="hidden" id="SDStreamTypeGet" value='<%SDGet("SDStreamType","net");%>' />
        <br />
        <div class="content">
            <label class="setExplain_en" id="jsSDfull">When SD card is full:</label>
            <div class="radioSelect">
                 <input type="radio" name="SDMode" id="SDMode1" value="1" />
                 <label for="SDMode1">Overwrite</label>
            </div>
            <div class="radioSelect">
                 <input type="radio" name="SDMode" id="SDMode0" value="0" />
                 <label for="SDMode0">Stop</label>
            </div>
        </div>
        <div class="content">
            <label class="setExplain_en">Manual recording control:</label>
            <div class="radioSelect">
                 <input type="radio" name="SDStart" id="SDStart1" value="1" />
                 <label for="SDStart1">Start</label>
            </div>
            <div class="radioSelect">
                 <input type="radio" name="SDStart" id="SDStart0" value="0" />
                 <label for="SDStart0">Stop</label>
            </div>
        </div>
        <div class="content">
            <label class="setExplain_en">Auto-record when network is abnormal:</label>
            <div class="radioSelect">
           <input type="radio" name="NLostRecord" id="NLostRecord1" value="1" />
                 <label for="NLostRecord1">Start</label>
            </div>
            <div class="radioSelect">
                 <input type="radio" name="NLostRecord" id="NLostRecord0" value="0" />
                 <label for="NLostRecord0">Stop</label>
            </div>
        </div>
         <div class="content">
            <label class="setExplain_en">Recording StreamType:</label>
            <div class="radioSelect">
                 <input type="radio" name="SDStreamType" id="SDStreamType0" value="0" />
                 <label for="SDStreamType0">Major</label>
            </div>
            <div class="radioSelect">
                 <input type="radio" name="SDStreamType" id="SDStreamType1" value="1" />
                 <label for="SDStreamType1">Minor</label>
            </div>
        </div>
        <div class="content contButton contBot">
             <label class="setExplain" style="visibility:hidden">&nbsp;</label>
            <input class="SDbto" type="button" style="visibility:hidden" />
            <input class="SDbto" type="button" value="Save" onclick="fSDSet()" style="margin-left:98px" />
        </div>
    </form>
    <div class="hankName"><label>Peripheral equipment management</label></div>
    <input type="hidden" id="DevStatusGet" value='<%SDGet("DevStatus","net");%>' />
    <input type="hidden" id="WriteProtectedGet" value='<%SDGet("WriteProtected","net");%>' />
    <br />
    <div class="content">
        <label class="setExplain" id="jsSDStatus">SD Card status:</label>
      <label class="hankType">State:</label>
        <label class="hankVal" id="DevStatus">&nbsp;</label>
        <label class="hankType" style="width:120px;">write-protect:</label>
        <label class="hankVal" id="WriteProtected">&nbsp;</label>
    </div>
    <div class="content">
        <label class="setExplain">&nbsp;</label>
        <label class="hankType">Occupied space:</label>
        <label class="hankVal" id="usedSpace"><%SDGet("UsedSpace","net");%></label>
        <label class="hankType" style="width:120px;">Total size:</label>
      <label class="hankVal" id="totalSpace"><%SDGet("TotalSize","net");%></label>
    </div>
    <div class="content" id="SDControlDiv" style="padding-top:15px; display:none">
        <form name="SDDeviceForm" id="SDDeviceForm" action="/form/SDSet"  method="post" target="hideFrame">
            <input type="hidden" name="flag" id="SDCtrlFlag" value="2" />
            <input type="hidden" name="SDMount" id="SDMountPara" value='<%SDGet("SDMount","net");%>' />
            <input type="hidden" name="SDFormat" value="1" />
            <label class="setExplain" style="margin-top:7px" id="jsSDOperation">SD card operation:</label>
            <input class="SDbto" type="button" id="SDMount1" value="Unmount" onclick="fSDControl(0)" />
            <input class="SDbto" type="button" id="SDMount0" value="Mount" onclick="fSDControl(1)" />
             <input class="SDbto" type="button" value="Format" onclick="fSDControl(2)" style="margin-left:98px" />
        </form>
    </div>
</div>
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

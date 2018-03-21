<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Login</title>
<link rel="stylesheet" type="text/css" href="../css/top.css" />
<script language="javascript" src="../javascript/jquery.js"></script>
<script language="javascript" src="../javascript/cookie.js"></script>
<script language="javascript" src="../javascript/top.js"></script>
<script type="text/javascript" src="../javascript/jQueryPie.js"></script>
<script type="text/javascript" src="../javascript/imageProcess.js"></script>
<script type="text/javascript" src="../javascript/videosave.js"></script>
<script type="text/javascript" src="../javascript/videoset.js"></script>
<script type="text/javascript" src="../javascript/sysInf.js"></script>
</head>

<body class="body" onLoad="topOnload();" onUnload="OnUnload()">
<input type="hidden" id="PAGE_LANGUAGE" value="0" />
<input type="hidden" id="OCX_ONCE" value="1" />
<input type="hidden" id="chipIDGet" value='<%DeviceIDGet("chipid","net");%>' /><!--0 hisi; 1 goke; 2 mstar-->
<input type="hidden" id="deviceIDGet" value='<%DeviceIDGet("deviceid","net");%>' />
<input type="hidden" id="videoPort" value="<%NetPortGet("VideoPort","net");%>">
<input type="hidden" id="rtspPort" value="<%NetPortGet("RtspPort","net");%>">
<div class="topImg">
	<div class="logoPic"></div>
	<label class="versionLable" style="display:none;"><%VersionGet("version","net");%></label>
<!--	<div class="topImgLamp"><img id="img1" src="../images/off.gif"/><img id="img2" src="../images/on.gif" style="display:none;"></div> -->
</div>

<div class="topmenu">
	<ul>
		<li id="li0" onclick="realScan('videoset.asp');" style="background-image:url(../images/topbutton1.gif); letter-spacing:0px;">Browse</li>
		<li id="li1" onclick="set('rootleftset.htm','sysInf.asp');" style="letter-spacing:0px; font-family:Arial, Helvetica, sans-serif">Setting</li>
	</ul>
    <select name="lanSelect" id="lanSelect" onchange="lanChange();">
		<option value="0" selected="selected">English</option>
		<option value="1">中文</option>
	</select>
<!--	<input type="hidden" id="recordType" value='0'/>
	<input type="hidden" id="snapShotType" value='0'/>
	<input type="hidden" id="snapShotPath" value='C:\IPC_PlayerAX\Picture'/>
	<input type="hidden" id="recordPath" value='C:\IPC_PlayerAX\Video'/>-->
	<input type="hidden" name="resMax" id="resMax"   value="<%videoparaGet("resolution","net");%>" > 
	<input type="hidden" name="resMin" id="resMin"   value="<%ExtVideoparaGet("resolution","net");%>" > 
	<input type="hidden" name="resMjpeg" id="resMjpeg"  value="<%mjpegparaGet("resolution","net");%>" >
	<input type="hidden" name="imagePath" id="imagePath"  value="<%IVPathGet("imagepath","net");%>" />
	<input type="hidden" name="videoPath" id="videoPath"  value="<%IVPathGet("videopath","net");%>" />
	<input type="hidden" name="imageType" id="imageType" value='<%IVPathGet("imageType","net");%>' />
	<input type="hidden" name="videoType" id="videoType" value='<%IVPathGet("videoType","net");%>'/>
    <input type="hidden" name="audioType" id="audioType" value='<%audioparaGet("AudioFormat","net");%>' />
<div class="selectButton" id="butSelect">
	<div class="unitDivIn">
			<img id="in_on" onclick="AIn(0);"  style="display:none" src="../images/audio_in.gif"  title="Audio in off">
            <img id="in_off"  onclick="AIn(1);"   src="../images/audio_in_off.gif"   title="Audio in on"><!--alt="Audio in on"-->
			<div class="imgMask"></div>	
	</div>
	<div class="unitDivOut">
			<img id="out_on" onclick="AOut(0);"  style="display:none" src="../images/audio_out.gif"  title="Audio out off">
            <img id="out_off"   onclick="AOut(1);" src="../images/audio_out_off.gif" title="Audio out on"><!--alt="Audio out on"-->
			<div class="imgMask"></div>
	</div>
	<div class="unitDivRePath" style="display:none;">
			<img id="recordOpen" onclick="openVideoDir();" src="../images/path.gif" title="Open path">
			<div class="imgMask"></div>
	</div>
	<!--<div class="unitDivOut">--><div class="unitDivRecord">
		<div id="startR"> 
			<img name="startP" id="startP" onclick="startRecord();" src="../images/record.gif" title="Start record" >
			<div class="imgMask"></div>			
		</div>	
		<div id="stopR"  style="display:none;  position:relative;"> 
			<img name="stopP" id="stopP" onclick="stopRecord();"  src="../images/record_off.gif"  title="Stop record" >
			<div class="imgMask"></div>	
	  </div>
	</div>
	<div class="unitDivCaPath" style="display:none;">
    		<img id="snapOpen" onclick="openImgDir();" src="../images/path.gif" title="Open path">
			<div class="imgMask"></div>	
	</div>
	<!--<div class="unitDivIn">--><div class="unitDivCamera">
		<div id="h264Snap"> 
			<img name="SnapShotSet" onclick="setSnapShot();" id="SnapShotSet" src="../images/snap.gif" title="Snap" onmousedown="old=this.src;this.src='../images/snap_on.gif';"onmouseup="this.src=old;">
		</div>
		<div id="mjpegSnap"  onclick="showImage();" style="display:none"> 
			<img name="SnapShotSet" src="../images/snap.gif" title="Snap" >
		</div>
	</div>

	<div class="unitDivZoom">
		<div id="startZ"> 
			<img name="startZP" id="startZP" onclick="startZoom();" src="../images/dzoom.gif" title="Digital zoom" >
			<div class="imgMask"></div>			
		</div>	
		<div id="stopZ"  style="display:none;  position:relative;"> 
			<img name="stopZP" id="stopZP" onclick="stopZoom();"  src="../images/dzoom_off.gif"  title="Stop" >
			<div class="imgMask"></div>	
	  </div>
	</div>

	<div class="unitDivMov" id="motinDiv" style="display:none">
    	<input type="hidden" id="motionSwitchGet" value='<%Getalarmpara("MotionSwitch","net");%>' />
		<img id="motion_on" onclick="MSwitch(1);" src="../images/motion_on.gif" title="Open motion" />
        <img id="motion_off"  onclick="MSwitch(0);" style="display:none"  src="../images/motion_off.gif" title="Close motion" />
		<div class="imgMask"></div>	
	</div>	
	<div class="unitDivPri" id="privacyDiv" style="display:none">
    	<input type="hidden" id="privacySwitchGet" value='<%PrivacyGet("PrivacySwitch","net");%>' />
		<img id="privacy_on" onclick="PSwitch(1);" src="../images/privacy_on.gif" title="Open privacy" />
        <img id="privacy_off"  onclick="PSwitch(0);" style="display:none"  src="../images/privacy_off.gif" title="Close privacy" />
		<div class="imgMask"></div>	
	</div>
</div>
</div>
</body>
</html>

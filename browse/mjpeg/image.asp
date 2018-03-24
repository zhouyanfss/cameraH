<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>MJPEG Image</title>
<link href="../css/video.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript" src="../javascript/jquery.js"></script>
<script type="text/javascript" src="../javascript/imageProcess.js"></script>
<script type="text/javascript" src="../javascript/videoset.js"></script>
<script language="JavaScript" type="text/JavaScript">
function Click(){window.event.returnValue=false;}
document.oncontextmenu=Click; 
</script>

</head>
<body onLoad="initMjpegVideosize();fun();initLan();" onunload="stopRequest();for(var i=0; i<10000; i++);"  style="margin:0; padding:0; background-color:#c9c6c6">
    <form id="f1">  	
		<div id="imageDiv1" align="center">
			<img id="myImg1" galleryimg="no" />
			<img id="myImg2" galleryimg="no" />
		</div>
	
		<input type="button" onClick="restart();" ID="btnRestart" style="display:none" />
		<input type="button" onClick="stopRequest();" ID="btnStop" style="display:none" />
	</form>
	
<input type="hidden" name="resMax" id="resMax"   value="<%videoparaGet("resolution","net");%>" > 
<input type="hidden" name="resMin" id="resMin"   value="<%ExtVideoparaGet("resolution","net");%>" > 
<input type="hidden" name="resMjpeg" id="resMjpeg"  value="<%mjpegparaGet("resolution","net");%>" >
<input type="hidden" name="imagePath" id="imagePath"  value="<%IVPathGet("imagepath","net");%>" />
<input type="hidden" name="videoPath" id="videoPath"  value="<%IVPathGet("videopath","net");%>" />
<input type="hidden" name="imageType" id="imageType" value='<%IVPathGet("imageType","net");%>' />
<input type="hidden" name="videoType" id="videoType" value='<%IVPathGet("videoType","net");%>'/>
<input type="hidden" name="audioType" id="audioType" value='<%audioparaGet("AudioFormat","net");%>' />

<div style="height:30px; display:block; margin:auto;width:100%;background-color:#c9c6c6; border-top:2px solid #999999;">
	   
	<div id="videoBottom" style="height:30px; display:block; margin:auto; position:relative;">
		<div class="btnArea" style="background:url(../images/bfms.png) no-repeat 0px 5px;">
			<div class="selectArea">
				<select name="BitSelect" id="BitSelect" style="height:50px; width:80px;" onChange="vedioParaChange('BitSelect');" class="videoSet_select" multiple="multiple" size="3">
					<option value="0" _enlan="Main stream">主码流</option>
					<option value="1" _enlan="Sub stream">副码流</option>
					<option value="2" _enlan="MJPEG">MJPEG</option>
				</select>
				<iframe id="iframe1" src="about:blank" frameBorder="0" marginHeight="0" marginWidth="0" style="position:absolute; visibility:inherit; top:0px;left:0px;width:80px; height:50px;z-index:-1; filter:alpha(opacity=0);"></iframe>

			</div>
		</div>
		<div class="btnArea" style="background:url(../images/spdx.png) no-repeat 0px 5px; ">
			<div class="selectArea">
				<select name="videoSizeSelect" id="videoSizeSelect" style="height:90px; width:60px;"  class="videoSet_select" onChange="vedioParaChange('videoSizeSelect');" multiple="multiple" size="5">
				  <option value="0">1 x</option>
				  <option value="1">1/2 x</option>
				  <option value="2">1/4 x</option>
				  <option value="3" selected="selected" _enlan="Auto">自适应</option>
				  <option value="4" _enlan="Full">完全</option>
				</select>
				<iframe id="iframe1" src="about:blank" frameBorder="0" marginHeight="0" marginWidth="0" style="position:absolute; visibility:inherit; top:0px;left:0px;width:60px; height:90px;z-index:-1; filter:alpha(opacity=0);"></iframe>

			</div>
		</div>
		<div class="btnArea" style="background:url(../images/splx.png) no-repeat 0px 5px;">
			<div  class="selectArea">
				<select id="playModeSelect" class="videoSet_select"  style="height:34px; width:60px;" onChange="vedioParaChange('playModeSelect');" multiple="multiple" size="2">
				  <option value="0" _enlan="Live">实时</option>
				  <option value="1" _enlan="Smooth">流畅</option>
				</select>
				<iframe id="iframe1" src="about:blank" frameBorder="0" marginHeight="0" marginWidth="0" style="position:absolute; visibility:inherit; top:0px;left:0px;width:60px; height:34px;z-index:-1; filter:alpha(opacity=0);"></iframe>

			</div>
		</div>
		<div class="btnArea" style="background:url(../images/txsc.png) no-repeat 0px 5px;">
			<div class="selectArea">
				<select name="videoColorSelect" id="videoColorSelect" style="height:50px; width:60px;" class="videoSet_select" onChange="vedioParaChange('videoColorSelect');" multiple="multiple" size="3">
				  <option value="0" _enlan="Fresh">鲜艳</option>
				  <option value="1" _enlan="Standard">标准</option>
				  <option value="2" _enlan="Cold">冷色调</option>
				</select>
				<iframe id="iframe1" src="about:blank" frameBorder="0" marginHeight="0" marginWidth="0" style="position:absolute; visibility:inherit; top:0px;left:0px;width:60px; height:50px;z-index:-1; filter:alpha(opacity=0);"></iframe>

			</div>
		</div>
		<!--
		<div id="btnArea" style="position:absolute;bottom:37px; z-index:1000;">

			<div class="rowDiv">
				<label class="videoSizeTest_cn1">视频类型</label>
				<select name="BitSelect" id="BitSelect" style="height:50px;" class="videoSet_select" onChange="BitSet();" multiple="multiple" size="3">
					<option value="0">主码流</option>
					<option value="1">副码流</option>
					<option value="2">MJPEG</option>
				</select>
			</div>
			
			<div class="rowDiv">
				<label class="videoSizeTest_cn1">视频大小</label>
				<select name="videoSizeSelect" id="videoSizeSelect" class="videoSet_select" onChange="videoSizeSet();">
				  <option value="0">1 x</option>
				  <option value="1">1/2 x</option>
				  <option value="2">1/4 x</option>
				  <option value="3" selected="selected">自适应</option>
				  <option value="4">完全</option>
				</select>
			</div>
			<div class="rowDiv">
				<label class="videoSizeTest_cn1">播放模式</label>
				<select id="playModeSelect" class="videoSet_select" onChange="playMode();">
				  <option value="0">实时</option>
				  <option value="1">流畅</option>
				</select>
			</div>
			
			<div class="rowDiv">
				<label class="videoSizeTest_cn1">图像色彩</label>
				<select name="videoColorSelect" id="videoColorSelect" class="videoSet_select" onChange="colorMode();">
				  <option value="0">鲜艳</option>
				  <option value="1">标准</option>
				  <option value="2">冷色调</option>
				</select>
			</div>
			
		<iframe id="iframe1" src="about:blank" frameBorder="0" marginHeight="0" marginWidth="0" style="position:absolute; visibility:inherit; top:0px;left:0px;width:120px; height:120px;z-index:-1; filter:alpha(opacity=0);"></iframe>
		</div>
-->
		<div class="selectButton" id="butSelect">
			<div class="unitDivZoom unitDiv">
				<div id="startZ"> 
					<img name="startZP" id="startZP" onclick="startZoom();" src="../images/dzoom.png"  _title="Digital zoom" title="电子放大" >
					<div class="imgMask"></div>			
				</div>	
				<div id="stopZ"  style="display:none;  position:relative;"> 
					<img name="stopZP" id="stopZP" onclick="stopZoom();"  src="../images/dzoom_off.png"  _title="Stop" title="停止" >
					<div class="imgMask"></div>	
			  </div>
			</div>
			<div class="unitDivCamera unitDiv">
				<div id="h264Snap" onclick="setSnapShot();" style="display:none"> 
					<img name="SnapShotSet" id="SnapShotSet" src="../images/snap.png"  _title="Snap" title="快照" >			
				</div>
				<div id="mjpegSnap" onclick="showImage();"> 
					<img name="SnapShotSet" id="SnapShotSetMjpeg" src="../images/snap.png"  _title="Snap" title="快照" >	
				</div>		
			</div>
			<div class="unitDivCaPath unitDiv" style="display:none;">
					<img id="snapOpen" onclick="openImgDir();" src="../images/path.gif"  _title="Open path" title="打开快拍存储路径">
					<div class="imgMask"></div>	
			</div>
			<div class="unitDivRecord unitDiv">
				<div id="startR"> 
					<img name="startP" id="startP" onclick="startRecord();" src="../images/record_off.png" _title="Start record" title="开始录像" >
					<div class="imgMask"></div>			
				</div>	
				<div id="stopR"  style="display:none;  position:relative;"> 
					<img name="stopP" id="stopP" onclick="stopRecord();"  src="../images/record.png" _title="Stop record" title="停止录像" >
					<div class="imgMask"></div>	
			  </div>
			</div>
			<div class="unitDivOut unitDiv">
					<img name="out_on" id="out_on" onclick="AOut(0);" style="display:none"  src="../images/audio_out.png" _title="Audio out off" title="关闭音频输出">
					<img name="out_off" id="out_off"   onclick="AOut(1);" src="../images/audio_out_off.png" _title="Audio out on" title="开启音频输出">
					<div class="imgMask"></div>
			</div>
			<div class="unitDivRePath unitDiv" style="display:none;">
					<img id="recordOpen" onclick="openVideoDir();" src="../images/path.gif" _title="Open path" title="打开录像存储路径">
					<div class="imgMask"></div>
			</div>
			<div class="unitDivIn unitDiv">
					<img name="in_on" id="in_on" onclick="AIn(0);" style="display:none"  src="../images/audio_in.png"  _title="Audio in off" title="关闭音频输入">
					<img name="in_off" id="in_off"  onclick="AIn(1);"  src="../images/audio_in_off.png" _title="Audio in on" title="开启音频输入">
					<div class="imgMask"></div>	
			</div>



			<div class="unitDivMov" id="motinDiv" style="display:none">
				<input type="hidden" id="motionSwitchGet" value='<%Getalarmpara("MotionSwitch","net");%>' />
				<img id="motion_on" onclick="MSwitch(1);" src="../images/motion_on.gif" _title="Open motion" title="开启移动侦测" />
				<img id="motion_off"  onclick="MSwitch(0);" style="display:none"  src="../images/motion_off.gif" _title="Close motion" title="关闭移动侦测" />
				<div class="imgMask"></div>	
			</div>	
			<div class="unitDivPri" id="privacyDiv" style="display:none">
				<input type="hidden" id="privacySwitchGet" value='<%PrivacyGet("PrivacySwitch","net");%>' />
				<img id="privacy_on" onclick="PSwitch(1);" src="../images/privacy_on.gif" _title="Open privacy" title="开启隐私区域" />
				<img id="privacy_off"  onclick="PSwitch(0);" style="display:none"  src="../images/privacy_off.gif" _title="Close privacy" title="关闭隐私区域" />
				<div class="imgMask"></div>	
			</div>
		</div>
	</div>
</div>
</body>
</html>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Control Player</title>
<link href="../css/videoSet.css" rel="stylesheet" type="text/css">
<link href="../css/slider.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../javascript/jquery.js"></script>
<script type="text/javascript" src="../javascript/cookie.js"></script>
<script type="text/javascript" src="../javascript/common.js"></script>
<script type="text/javascript" src="../javascript/videosave.js"></script>
<script type="text/javascript" src="../javascript/domset.js"></script>
<script type="text/javascript" src="../javascript/jQueryPie.js"></script>
<script type="text/javascript" src="../javascript/imageProcess.js"></script>
<style type="text/css">

body{
	font-size:12px;
} 
.listdiv div {
	letter-spacing:0px;
	margin-left:25px; 	
}
.listdiv div label{
	width:185px;
}
.videoSizeTest{
	width:85px;
}
.ptzRow select{
	width:65px;
}
.ptzText{
	width:85px;
	text-align:left;
	text-indent:2px;
}
</style>
</head>
<body>
<input type="hidden" id="PAGE_LANGUAGE" value="0" />
<input type="hidden" id="Hi3518E" value='<%videoparaGet("hi3518e", "net");%>' />
<input type="hidden" id="Hi3518EV200" value='<%videoparaGet("hi3518ev200", "net");%>' />
<iframe id="hideFrame" name="hideFrame" style="display: none;"></iframe>

	<!--
	 <div class="listdiven" id="pNod0" onClick="showList(this.id);"><div><label>Time</label><img id="pNod0_img" src="../images/bit_up.gif"></div></div>

	
	<div id="pNod0_div" class="childdiv">
		<div>
        	<label id="CameraDate" class="timeOn">&nbsp;</label>
            <label id="CameraTime" class="timeOn">&nbsp;</label>
        </div>
        <div id="modeHank"></div>
	</div>
	-->
	<div style="display:none"  class="listdiven" id="pNod1" onClick="showList(this.id);">
		<div>
			<label>View</label>
			<img id="pNod1_img" src="../images/bit_up.gif">
		</div>
	</div>
	
  
<div id="pNod1_div" class="childdiv" style="display:none">
			<input type="hidden" name="resMax" id="resMax" value="<%videoparaGet("resolution","net");%>" /> 
			<input type="hidden" name="resMin" id="resMin" value="<%ExtVideoparaGet("resolution","net");%>" /> 
			<input type="hidden" name="resMjpeg" id="resMjpeg" value="<%mjpegparaGet("resolution","net");%>" />
           <input type="hidden" name="colorMode" id="colorMode" value=' <%CameraGet("ColorMode","net");%>'/>
		<div class="rowDiv">
			<label class="videoSizeTest">Stream type</label>
			<select name="BitSelect" id="BitSelect" class="videoSet_select" onChange="BitSet();">
				<option value="0">Main stream</option>
				<option value="1">Sub stream</option>
				<option value="2">MJPEG</option>
			</select>
		</div>
		
		<div class="rowDiv">
		<label class="videoSizeTest">Video size</label>
			<select name="videoSizeSelect" id="videoSizeSelect" class="videoSet_select" onChange="videoSizeSet();">
			  <option value="0">1 x</option>
			  <option value="1">1/2 x</option>
			  <option value="2">1/4 x</option>
			  <option value="3" selected="selected">Auto</option>
			  <option value="4">Full</option>
			</select>
		</div>
        
        <div class="rowDiv">
			<label class="videoSizeTest">Play mode</label>
			<select id="playModeSelect" class="videoSet_select" onChange="playMode();">
			  <option value="0">Live</option>
			  <option value="1">Smooth</option>
			</select>
		</div>
		
        <div class="rowDiv">
			<label class="videoSizeTest">Color mode</label>
			<select id="videoColorSelect" class="videoSet_select" onChange="colorMode();">
			  <option value="0">Fresh</option>
			  <option value="1">Standard</option>
			  <option value="2">Cold</option>
			</select>
		</div>

		<div class="picDiv" style="display:none;">
		  <div class="unitDiv">
			<div id="h264Snap" onclick="setSnapShot();"> 
				<img name="SnapShotSet" src="../images/snap.gif" title="Snap" >
			</div>
			<div id="mjpegSnap"  onclick="showImage();" style="display:none"> 
				<img name="SnapShotSet" src="../images/snap.gif" title="Snap" >
			</div>
		  </div>
		  
		  <div class="unitDiv">
			<div style="position:relative">
			<img id="snapOpen" onclick="openImgDir();" src="../images/path.gif" title="Open path">
			<div class="imgMask"></div>
			</div>
		  </div>
			
		  <div class="unitDiv" style="margin-left:20px;">
			<div id="startR" style="position:relative;"> 
				<img name="startP" id="startP" onclick="startRecord();"  src="../images/record.gif" title="Start record" >
				<div class="imgMask"></div>
			</div>
		 
			
			
			<div id="stopR"  style="display:none; position:relative;"> 
				<img name="stopP" id="stopP" onclick="stopRecord();" src="../images/record_off.gif" title="Stop record" >
				<!--<span class="imgMask" style="margin-left:10px;"></span>	-->
			</div>
 			
		</div>
			
		<div class="unitDiv">	
			<div style="position:relative">
			<img id="recordOpen"  onclick="openVideoDir();"  src="../images/path.gif" title="Open path">
			<div class="imgMask"></div>
			</div>
		</div>
		
			
	</div>
		
</div>
<!--
		<div class="listdiven" id="pNod2" onClick="showList(this.id);" style="display:none;"><div><label>Function buttons</label><img src="../images/bit_up.gif"  id="pNod2_img"></div></div>
  <div id="pNod2_div" class="childdiv" style="display:none;">
    <div class="picDiv">
			<div class="unitDiv" style="display:none;">
				<div style="position:relative;">
					<img id="out_on" onclick="AOut(1);"  src="../images/audio_out.gif" title="Audio out on">
                    <img id="out_off"   onclick="AOut(0);" style="display:none" src="../images/audio_out_off.gif" title="Audio out off">
					<div class="imgMask"></div>
				</div>
			</div>	
				
			<div class="unitDiv" style="display:none;">	
				<div style="position:relative">
					<img id="in_on"  onclick="AIn(1);"  src="../images/audio_in.gif" title="Audio in on">
                    <img id="in_off" onclick="AIn(0);" style="display:none" src="../images/audio_in_off.gif" title="Audio in off">
					<div class="imgMask"></div>
				</div>
			</div>
            <div class="unitDiv" id="motinDiv">
				<input type="hidden" id="motionSwitchGet" value='<%Getalarmpara("MotionSwitch","net");%>' />
                <div style="position:relative">
					<img id="motion_on" onclick="MSwitch(1);" src="../images/motion_on.gif" title="Open motion" />
                    <img id="motion_off" onclick="MSwitch(0);" style="display:none" src="../images/motion_off.gif" title="Close motion" />
					<div class="M_P_mask" id="jsMotionMask"></div>			
				</div>
			</div>
            
            <div class="unitDiv" id="privacyDiv">
				<input type="hidden" id="privacySwitchGet" value='<%PrivacyGet("PrivacySwitch","net");%>' />
                <div style="position:relative">
					<img id="privacy_on" onclick="PSwitch(1);" src="../images/privacy_on.gif" title="Open privacy" />
                    <img id="privacy_off" onclick="PSwitch(0);" style="display:none" src="../images/privacy_off.gif" title="Close privacy" />
					<div class="M_P_mask" id="jsPrivacyMask"></div>			
				</div>
			</div>
            
		</div>
   </div> 
    
 -->
    
<div id="ptz" style="display:block;">
    
  <div class="listdiven" id="pNod3" onClick="showList(this.id);">
   <div><label>PTZ control</label></div>
</div>
<div id="pNod3_div" class="childdiv" align="center">
	<div class="ptzDiv" align="center">
	<form name="PTZForm" id="PTZForm" method="post" action="/form/setPTZCfg" target="hideframe" >
      <input id="focusSpeedGet" type="hidden" value="<%getPTZCfg("focusSpeed_", "net");%>" />
      <input id="zoomSpeedGet" type="hidden" value="<%getPTZCfg("zoomSpeed_", "net");%>" />
      <input id="panSpeedGet" type="hidden" value="<%getPTZCfg("panSpeed_", "net");%>" />
      <input id="tiltSpeedGet" type="hidden" value="<%getPTZCfg("tilteSpeed_", "net");%>" />
      <div>
          <div id="pie"></div>
          <input name="command" id="command" type="hidden" value="0" />
          <input name="ZFSpeed" id="ZFSpeed" type="hidden" value="0" />
          <input name="PTSpeed" id="PTSpeed" type="hidden" value="0" />
      </div>
       	<div class="picRow">
      		<div id="irisClose" class="picRowLeft"></div>
        	<div id="irisOpen" class="picRowRight"></div>
        	<div class=" picRowTest">Iris</div>
      	</div>
      	<div class="picRow">
      		<div id="focusNear" class="picRowLeft"></div>
        	<div id="focusFar" class="picRowRight"></div>
        	<div class=" picRowTest">Focus</div>
      	</div>
      	<div class="picRow">
      		<div id="zoomOut" class="picRowLeft"></div>
        	<div id="zoomIn" class="picRowRight"></div>
        	<div class=" picRowTest">Zoom</div>
      	</div>
   
      <div class="ptzRow">
      	<div class="ptzText"><label>PanSpeed</label></div>
      	<select name="panSpeed" id="jsPanSpeed" onchange="submitFun(52,'jsPanSpeed','PTSpeed','PTZForm')">
           <option value="1">1(S)</option>
           <option value="2">2</option>
           <option value="3">3</option>
           <option value="4">4</option>
           <option value="5">5</option>
           <option value="6">6</option>
           <option value="7">7</option>
           <option value="8">8(F)</option>
	    </select>
      </div>
      <div class="ptzRow">
      	<div class="ptzText"><label>TiltSpeed</label></div>
        <select name="tiltSpeed" id="jsTiltSpeed" onchange="submitFun(53,'jsTiltSpeed','PTSpeed','PTZForm');">
               <option value="1">1(S)</option>
               <option value="2">2</option>
               <option value="3">3</option>
               <option value="4">4</option>
               <option value="5">5</option>
               <option value="6">6</option>
               <option value="7">7</option>
               <option value="8">8(F)</option>
         </select>
      </div>
       <div class="ptzRow">
                <div class="ptzText"><label>FocusSpeed</label></div>
                <select name="focusSpeed" id="jsFocusSpeed" onchange="submitFun(40,'jsFocusSpeed','ZFSpeed','PTZForm');">
                   <option value="0">Slow</option>
                   <option value="1">Moderate</option>
                   <option value="2">Fast</option>
                </select>
              </div>
              <div class="ptzRow">
                <div class="ptzText"><label>ZoomSpeed</label></div>
                <select name="zoomSpeed" id="jsZoomSpeed" onchange="submitFun(41,'jsZoomSpeed','ZFSpeed','PTZForm');">
                   <option value="0">Slow</option>
                   <option value="1">Moderate</option>
                   <option value="2">Fast</option>
                </select>
              </div>
    </form>
	
<form id="livePosHankForm" method="post" action="/form/presetSet" target="hideframe">
    	<input type="hidden" name="flag" id="jslivePresetFlag" />
        <input type="hidden" name="existFlag" id="jslivePresetExist" />
		<input type="hidden" name="language" value="cn" />
		<div class="rowDivY" style="width:100%;">
        	<div class="testDivBSD" style="padding-left:37px; padding-bottom:20px;padding-top:20px;">
				<label style="float:left;">Preset</label>
				<select name="presetNum" id="jsLivePresetNo"  style="float:left; margin-left:34px;width:75px;" class="domSelectBSD" onchange="ajaxHankGet('/user/presetAjax','livePosHankForm','jsLivePresetNo');">
				</select> 
			</div>
			<div class="buttonDivBSD" style="padding-right:39px;"><input name="Input" type="button" value="Call"  onclick="callPst();"/></div>
            <div class="buttonDivBSD"><input name="Input" type="button" value="Mov"  onclick="clearPst();"/></div>
            <div class="buttonDivBSD"><input name="Input" type="button" value="Set"  onclick="setPst();"/></div>

		</div>
    </form>

    <input type="hidden" id="patternShow" name="pattern_state" value="<%getPTZCfg("patternDisplay_", "net");%>" />
     <form id="liveAutopanForm" method="post" action="/form/autopanSet" target="hideframe" style="display:none">
	  	<input type="hidden" name="flag" id="jsliveAutopanFlag" />
      	<input type="hidden" name="existFlag" id="jsliveAutopanExist" />
		<div class="rowDivY">
			<div class="testDiv"><label>Auto-pan</label></div>
            <div class="buttonDiv"><input name="Input" type="button" class="ButtonSet" value="Call"  onclick="callAutopan()" /></div>
			<select name="autopanNum" id="jsLiveAutopanNo" class="domSelect" onchange="ajaxHankGet('/user/autopanAjax','liveAutopanForm','jsLiveAutopanNo');">
			</select> 
		</div>
	</form>
	<form id="livePatternForm" method="post" action="/form/patternSet" target="hideframe" style="display:none">
		<input type="hidden" name="flag" id="jslivePatternFlag" />
        <input type="hidden" name="existFlag" id="jslivePatternExist" />
		<div class="rowDivY" style="margin-bottom: 5px">
			<div class="testDivBSD"><label>Pattern</label></div>
            <div class="buttonDiv" style="margin-right:30px;"><input name="Input" type="button" class="ButtonSet" value="Call"  onclick="callPtn();"/></div>
			<select name="patternNum" id="jslivePatternNum" class="domSelectBSD" onchange="ajaxHankGet('/user/patternAjax','livePatternForm','jslivePatternNum')">
			</select> 
		</div>
	</form>
	<form id="liveTourForm" method="post" action="/form/tourSet" target="hideframe">
    	<input type="hidden" name="flag" id="jsliveTourFlag" />
        <input type="hidden" name="existFlag" id="jsliveTourExist" />
        <input type="hidden" name="presetValue" id="jsPresetValue" />
		<div class="rowDivY" style="width:100%;">
			<div class="testDivBSD" style="padding-left:37px;padding-bottom:20px;padding-top:20px;">
				<label style="float:left;line-height:26px;">Tour</label>
				
				<select name="tourNum" id="jsliveTourNum" style="float:left; margin-left:10px;margin-top:3px;" class="domSelectBSD" onchange="ajaxHankGet('/user/tourAjax','liveTourForm','jsliveTourNum')">
				</select> 
				<div class="buttonDivBSD" style="margin-right:83px;"><input name="Input" type="button" class="button" value="Call"  onclick="callTour();"/></div>
			</div>
		</div>
    </form>
    <form name="YunTaiForm" id="jsYunTaiForm" method="post" action="/form/setSpecialFunc" target="hideframe">
        <div class="autoScan" align="center">
             <input type="hidden" name="flag" id="autoscanflag" value="0"/>
			 <input type="hidden" name="command" id="jscommand" value="0"/>
		     <input type="button" name="autoscan" style="background-image:url(../images/scan_big.gif); width:100px;" class="scan" id="autoscan"  value="Auto-pan" onclick="CallAtpPtn(2);"/>&nbsp;
		     <input type="button" name="flip" class="scan" id="jsflip"  style="display:none"  value="Pattern" onclick="CallAtpPtn(3);"/>
		</div>
	</form>
	
  </div>
  
</div>
<!--
<div class="listdiv" id="pNod4" onClick="showList(this.id);" style="display:block">
    <div><label>PTZ function</label><img src="../images/bit_down.gif"  id="pNod4_img"></div>
</div>
-->

<!--
<div class="listdiv" id="pNod5" onClick="showList(this.id);">
    <div><label>Menu control</label><img src="../images/bit_down.gif"  id="pNod5_img"></div>
</div>
<div id="pNod5_div" class="childdiv" align="center" style="display:none">
<div class="ptzDiv" align="center">
	<form name="MenuForm" id="MenuForm" method="post" action="/form/menuSet" target="hideframe" >
    	<input id="focusSwitchGet" type="hidden" value="" />
    	<div>
		<div id="menu"></div>
     		<input name="menuCommand" id="menuCommand" type="hidden" value="0" />
        	<input name="focusSwitch" id="focusSwitch" type="hidden" value="0" />
    	</div>
        <div class="picRow">
      		<div id="mFocusNear" class="picRowLeft"></div>
        	<div id="mFocusFar" class="picRowRight"></div>
        	<div class=" picRowTest">Focus</div>
      	</div>
      	<div class="picRow">
      		<div id="mZoomOut" class="picRowLeft"></div>
        	<div id="mZoomIn" class="picRowRight"></div>
        	<div class=" picRowTest">Zoom</div>
      	</div>
        <div class="ptzText" style="width:100px; margin-left:65px;">
        	<input name="jsFocusSwitch" id="jsFocusSwitch" type="checkbox" onclick="menusubmitFun(7, 'jsFocusSwitch', 'focusSwitch', 'MenuForm');" /> <labal>Click focus</labal>
        </div>
    </form>
</div>
</div>
-->
</div>
<script type="text/javascript" src="../javascript/PTZInit.js"></script>
</body>
</html>

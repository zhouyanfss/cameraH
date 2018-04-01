<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Control Player</title>
<link href="../css/videoSet.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../javascript/jquery.js"></script>
<script type="text/javascript" src="../javascript/cookie.js"></script>
<script type="text/javascript" src="../javascript/common.js"></script>
<script type="text/javascript" src="../javascript/videosave.js"></script>
<script type="text/javascript" src="../javascript/domset.js"></script>
<script type="text/javascript" src="../javascript/jQueryPie.js"></script>
<script type="text/javascript" src="../javascript/imageProcess.js"></script>
</head>
<body>
<input type="hidden" id="PAGE_LANGUAGE" value="1" />
<input type="hidden" id="Hi3518E" value='<%videoparaGet("hi3518e", "net");%>' />
<input type="hidden" id="Hi3518EV200" value='<%videoparaGet("hi3518ev200", "net");%>' />
<iframe id="hideFrame" name="hideFrame" style="display: none;"></iframe>


	<div style="display:none" class="listdiv" id="pNod1" onClick="showList(this.id);">
		<div>
			<label>视频操作</label>
			<img id="pNod1_img" src="../images/bit_up.gif">
		</div>
	</div>

	

  <div id="pNod1_div" class="childdiv" style="display:none">
			<input type="hidden" name="resMax" id="resMax"   value="<%videoparaGet("resolution","net");%>" > 
			<input type="hidden" name="resMin" id="resMin"   value="<%ExtVideoparaGet("resolution","net");%>" > 
			<input type="hidden" name="resMjpeg" id="resMjpeg"  value="<%mjpegparaGet("resolution","net");%>" >
           <input type="hidden" name="colorMode" id="colorMode" value=' <%CameraGet("ColorMode","net");%>'/>

		<div class="rowDiv">
			<label class="videoSizeTest_cn1">视频类型</label>
			<select name="BitSelect" id="BitSelect" class="videoSet_select" onChange="BitSet();">
				<option value="0" selected="selected">主码流</option>
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
			  <option value="0" selected="selected" >实时</option>
			  <option value="1">流畅</option>
			</select>
		</div>
		
        <div class="rowDiv">
			<label class="videoSizeTest_cn1">图像色彩</label>
			<select name="videoColorSelect" id="videoColorSelect" class="videoSet_select" onChange="colorMode();">
			  <option value="0">鲜艳</option>
			  <option value="1" selected="selected" >标准</option>
              <option value="2">冷色调</option>
			</select>
		</div>
		<div class="picDiv" style="">
			<div class="unitDiv">
				<div id="startZ"> 
					<img name="startZP" id="startZP" onclick="startZoom();" src="../images/dzoom.gif" title="电子放大" >
					<div class="imgMask"></div>			
				</div>	
				<div id="stopZ"  style="display:none;  position:relative;"> 
					<img name="stopZP" id="stopZP" onclick="stopZoom();"  src="../images/dzoom_off.gif"  title="停止" >
					<div class="imgMask"></div>	
			  </div>
			</div>
			<div class="unitDiv">
				<div id="h264Snap" onclick="setSnapShot();"> 
					<img name="SnapShotSet" id="SnapShotSet" src="../images/snap.gif" title="快照" >			
				</div>
				<div id="mjpegSnap" onclick="showImage();" style="display:none"> 
					<img name="SnapShotSet" id="SnapShotSetMjpeg" src="../images/snap.gif" title="快照" >			
				</div>
			</div>
			
			<div class="unitDiv">
				<div style="position:relative">
                    <img id="snapOpen" onclick="openImgDir();" src="../images/path.gif" title="打开快拍存储路径">
					<div class="imgMask"></div>			
				</div>
			</div>
			<div class="unitDiv" style="">
				<div id="startR" style="position:relative;"> 
					<img name="startP" id="startP" onclick="startRecord();" src="../images/record.gif" title="开始录像" >
					<div class="imgMask"></div>			
				</div>	
			
				<div id="stopR"  style="display:none; position:relative;"> 
					<img name="stopP" id="stopP" onclick="stopRecord();"  src="../images/record_off.gif" title="停止录像" >
				</div>
				
			</div>
			<div class="unitDiv">
				<img name="in_on" id="in_on" onclick="AIn(0);" style="display:none"  src="../images/audio_in.gif"  title="关闭音频输入">
				<img name="in_off" id="in_off"  onclick="AIn(1);"  src="../images/audio_in_off.gif"   title="开启音频输入">
				<div class="imgMask"></div>	
			</div>
			<div class="unitDiv">
					<img name="out_on" id="out_on" onclick="AOut(0);" style="display:none"  src="../images/audio_out.gif"  title="关闭音频输出">
					<img name="out_off" id="out_off"   onclick="AOut(1);" src="../images/audio_out_off.gif" title="开启音频输出">
					<div class="imgMask"></div>
			</div>
			<div class="unitDiv">
				<div style="position:relative">
					<img id="recordOpen" onclick="openVideoDir();" src="../images/path.gif" title="打开录像存储路径">
					<div class="imgMask"></div>
				</div>
			</div>
			
		</div>
		
		  
</div>
  
<!--        
<div class="listdiv" id="pNod2" onClick="showList(this.id);" style="display:none;">
    <div><label>功能开关</label><img src="../images/bit_up.gif"  id="pNod2_img"></div>
</div>
<div id="pNod2_div" class="childdiv" style="display:none;">
<div class="picDiv">      
           	<div class="unitDiv" style="display:none;">
				<div style="position:relative;">
					<img id="out_on" onclick="AOut(1);"  src="../images/audio_out.gif" title="开启音频输出">
                    <img id="out_off" style="display:none"  onclick="AOut(0);" src="../images/audio_out_off.gif" title="关闭音频输出">
					<div class="imgMask"></div>
				</div>
			</div>

			<div class="unitDiv" style="display:none;">
				<div style="position:relative">
					<img id="in_on" onclick="AIn(1);" src="../images/audio_in.gif" title="开启音频输入">
                    <img id="in_off"  onclick="AIn(0);" style="display:none"  src="../images/audio_in_off.gif" title="关闭音频输入">
					<div class="imgMask"></div>			
				</div>
			</div>
            
            <div class="unitDiv" id="motinDiv">
            	<input type="hidden" id="motionSwitchGet" value='<%Getalarmpara("MotionSwitch","net");%>' />
				<div style="position:relative">
					<img id="motion_on" onclick="MSwitch(1);" src="../images/motion_on.gif" title="开启移动侦测" />
                    <img id="motion_off"  onclick="MSwitch(0);" style="display:none"  src="../images/motion_off.gif" title="关闭移动侦测" />
					<div class="M_P_mask" id="jsMotionMask"></div>			
				</div>
			</div>
            
            <div class="unitDiv" id="privacyDiv">
            	<input type="hidden" id="privacySwitchGet" value='<%PrivacyGet("PrivacySwitch","net");%>' />
				<div style="position:relative">
					<img id="privacy_on" onclick="PSwitch(1);" src="../images/privacy_on.gif" title="开启隐私区域" />
                    <img id="privacy_off"  onclick="PSwitch(0);" style="display:none"  src="../images/privacy_off.gif" title="关闭隐私区域" />
					<div class="M_P_mask" id="jsPrivacyMask"></div>			
				</div>
			</div>
            
	</div>

</div>
-->
<div id="ptz" style="display:block;">

<div class="listdiv" id="pNod3" onClick="showList(this.id);">
    <label>云台控制</label>
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
        	<div class=" picRowTest">光圈</div>
      	</div>
      	<div class="picRow">
      		<div id="focusNear" class="picRowLeft"></div>
        	<div id="focusFar" class="picRowRight"></div>
        	<div class=" picRowTest">聚焦</div>
      	</div>
      	<div class="picRow">
      		<div id="zoomOut" class="picRowLeft"></div>
        	<div id="zoomIn" class="picRowRight"></div>
        	<div class=" picRowTest">缩放</div>
      	</div>
   
      <div class="ptzRow">
      	<div class="ptzText"><label>水平速度</label></div>
      	<select name="panSpeed" id="jsPanSpeed" onchange="submitFun(52,'jsPanSpeed','PTSpeed','PTZForm')">
           <option value="1">1(慢)</option>
           <option value="2">2</option>
           <option value="3">3</option>
           <option value="4">4</option>
           <option value="5">5</option>
           <option value="6">6</option>
           <option value="7">7</option>
           <option value="8">8(快)</option>
	    </select>
      </div>
      <div class="ptzRow">
      	<div class="ptzText"><label>垂直速度</label></div>
        <select name="tiltSpeed" id="jsTiltSpeed" onchange="submitFun(53,'jsTiltSpeed','PTSpeed','PTZForm');">
               <option value="1">1(慢)</option>
               <option value="2">2</option>
               <option value="3">3</option>
               <option value="4">4</option>
               <option value="5">5</option>
               <option value="6">6</option>
               <option value="7">7</option>
               <option value="8">8(快)</option>
         </select>
      </div>
      <div class="ptzRow">
      	<div class="ptzText"><label>聚焦速度</label></div>
      	<select name="focusSpeed" id="jsFocusSpeed" onchange="submitFun(40,'jsFocusSpeed','ZFSpeed','PTZForm');">
           <option value="0">慢</option>
           <option value="1">中</option>
           <option value="2">快</option>
	    </select>
      </div>
      <div class="ptzRow">
      	<div class="ptzText"><label>缩放速度</label></div>
      	<select name="zoomSpeed" id="jsZoomSpeed" onchange="submitFun(41,'jsZoomSpeed','ZFSpeed','PTZForm');">
           <option value="0">慢</option>
           <option value="1">中</option>
           <option value="2">快</option>
	    </select>
      </div>
    </form>
	
	<form id="livePosHankForm" method="post" action="/form/presetSet" target="hideframe">
    	<input type="hidden" name="flag" id="jslivePresetFlag" />
        <input type="hidden" name="existFlag" id="jslivePresetExist" />
		<input type="hidden" name="language" value="cn" />
		<div class="rowDivY" style="width:100%;">
			<div class="testDivBSD" style="padding-left:37px; padding-bottom:20px;padding-top:20px;">
				<label style="float:left;">预置位</label>
				<select name="presetNum" id="jsLivePresetNo" style="float:left; margin-left:30px;width:85px;" class="domSelectBSD" onchange="ajaxHankGet('/user/presetAjax','livePosHankForm','jsLivePresetNo');">
				</select>
			</div>
            <div class="buttonDivBSD" style="padding-right:25px;"><input name="Input" type="button" value="调用"  onclick="callPst();"/></div>
            <div class="buttonDivBSD"><input name="Input" type="button" value="删除"  onclick="clearPst();"/></div>
            <div class="buttonDivBSD"><input name="Input" type="button" value="设置"  onclick="setPst();"/></div>
			
		</div>
    </form>

    <input type="hidden" id="patternShow" name="pattern_state" value="<%getPTZCfg("patternDisplay_", "net");%>" />
     <form id="liveAutopanForm" method="post" action="/form/autopanSet" target="hideframe" style="display:none">
	  	<input type="hidden" name="flag" id="jsliveAutopanFlag" />
      	<input type="hidden" name="existFlag" id="jsliveAutopanExist" />
		<div class="rowDivY">
			<div class="testDiv"><label>水平扫描</label></div>
            <div class="buttonDiv"><input name="Input" type="button" class="ButtonSet" value="调用"  onclick="callAutopan()" /></div>
			<select name="autopanNum" id="jsLiveAutopanNo" class="domSelect" onchange="ajaxHankGet('/user/autopanAjax','liveAutopanForm','jsLiveAutopanNo');">
			</select> 
		</div>
	</form>
	<form id="livePatternForm" method="post" action="/form/patternSet" target="hideframe" style="display:none">
		<input type="hidden" name="flag" id="jslivePatternFlag" />
        <input type="hidden" name="existFlag" id="jslivePatternExist" />
		<div class="rowDivY" style="margin-bottom: 5px">
			<div class="testDiv"><label>花样扫描</label></div>
            <div class="buttonDiv" style="margin-right:30px;"><input name="Input" type="button" class="ButtonSet" value="调用"  onclick="callPtn();"/></div>
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
			<label style="float:left;line-height:26px;">巡视</label>
			<select name="tourNum" id="jsliveTourNum"  style="float:left; margin-left:10px;margin-top:3px;" class="domSelectBSD" onchange="ajaxHankGet('/user/tourAjax','liveTourForm','jsliveTourNum')">
			</select> 
            <div class="buttonDivBSD" style="margin-right:74px;"><input name="Input" type="button" value="调用"  onclick="callTour();"/>
			</div>
			</div>
		</div>
    </form>
    <form name="YunTaiForm" id="jsYunTaiForm" method="post" action="/form/setSpecialFunc" target="hideframe">
        <div class="autoScan" align="center">
             <input type="hidden" name="flag" id="autoscanflag" value="0"/>
			 <input type="hidden" name="command" id="jscommand" value="0"/>
		     <input type="button" style="background-image:url(../images/scan_big.gif); width:100px;" name="autoscan" class="scan" id="autoscan"  value="水平扫描" onclick="CallAtpPtn(2);"/>&nbsp;
		     <input type="button" name="flip" class="scan" id="jsflip"  style="display:none" value="花样扫描" onclick="CallAtpPtn(3);" />
		</div>
	</form>
	

</div>

</div>


<!--
<div class="listdiv" id="pNod5" onClick="showList(this.id);">
    <div><label>菜单控制</label><img src="../images/bit_down.gif"  id="pNod5_img"></div>
</div>
-->
<!--
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
        	<div class=" picRowTest">聚焦</div>
      	</div>
      	<div class="picRow">
      		<div id="mZoomOut" class="picRowLeft"></div>
        	<div id="mZoomIn" class="picRowRight"></div>
        	<div class=" picRowTest">缩放</div>
      	</div>
        <div class="ptzText" style="width:90px; margin-left:65px;">
        	<input name="jsFocusSwitch" id="jsFocusSwitch" type="checkbox" onclick="menusubmitFun(7, 'jsFocusSwitch', 'focusSwitch', 'MenuForm');" /> <labal>一键聚焦</labal>
        </div>
    </form>
</div>
</div>
-->
</div>

<script type="text/javascript" src="../javascript/PTZInit.js"></script>
</body>


</html>

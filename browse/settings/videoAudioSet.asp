<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="../css/sysInf.css" rel="stylesheet" type="text/css" />
<link href="../css/videoAudioSet.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../javascript/jquery.js"></script>
<script type="text/javascript" src="../javascript/common.js"></script>
<script type="text/javascript" src="../javascript/detect-zoom.min.js"></script>
<script type="text/javascript" src="../javascript/dragLine_new.js"></script>
<script type="text/javascript" src="../javascript/videoAudioSet.js"></script>
<script type="text/javascript" src="../javascript/jQueryPie.js"></script>
<script type="text/javascript">
window.onload=function(){
	videoInit();
	videoInit = null;
}
</script>

<style type="text/css">
<!--
.videoSetShow{
	width: 240px;
	padding-left:10px;
}
.videoSetList{
	width: 240px;
}
.videoSetList label{
	width: 140px;
}
.OSDraidoLabel{
	margin-top: 3px;
}
.areaSetContain{
	width: 490px;
}
.areaName{
	margin-top: 4px;
	width: 50px;
}
.motionSenstive{
	margin-top:3px;
	width:90px;
}
.sensDiv{
	width: 331px;
}
.areaNameInput{
	width: 361px;
}
.areaSet{
	width: 600px;
	margin-left: 90px;
}
-->
</style>
</head>

<body>
<input type="hidden" id="PAGE_LANGUAGE" value="0" />
<input type="hidden" id="Hi3518E" value='<%videoparaGet("hi3518e", "net");%>' />
<input type="hidden" id="Hi3518EV200" value='<%videoparaGet("hi3518ev200", "net");%>' />
<input type="hidden" id="Hi3516CV300" value='<%videoparaGet("hi3516cv300", "net");%>' />
<input type="hidden" id="Hi3519" value='<%videoparaGet("hi3519", "net");%>' />
<input type="hidden" id="Hi3516A" value='<%videoparaGet("hi3516a", "net");%>' />
<input type="hidden" id="ISVPTX0" value='<%videoparaGet("isvptx0", "net");%>' />
<input type="hidden" id="Full60fps" value='<%videoparaGet("Full60fps", "net");%>' />
<input type="hidden" id="WifiResource_Get" value='<%WifiGet("WifiResource", "net");%>' />
<input type="hidden" id="WifiKit_Get" value='<%WifiGet("WifiKit", "net");%>' />
<input type="hidden" id="res_fake" value='<%videoparaGet("resolution_fake", "net");%>' />
<input type="hidden" id="res_limit" value='<%videoparaGet("resolution_limit", "net");%>' />
<input type="hidden" id="area_check" value='<%videoparaGet("area_check", "net");%>' />
<input type="hidden" id="SHDBType" value='<%NetparaGet("SHDBType","net");%>' />
<iframe name="hideFrame" style=" display:none"></iframe>
<div class="topMenu" style="min-width:900px;">
	<ul style="width:900px">
    	<li class="choose" onclick="videoShow(0)">Video</li>
        <li class="choose" onclick="videoShow(1)" style="width:160px">Character display</li>
        <li class="choose" onclick="videoShow(2)" style="width:150px">Motion detection</li>
        <li class="choose" onclick="videoShow(3)" style="width:130px">Privacy mask</li>
        <li class="choose gokehide mstarhide hisihide" onclick="videoShow(4)" id="roi_LI">ROI</li>
        <li class="choose" onclick="videoShow(5)">Path</li>
        <li class="choose mstarhide" onclick="videoShow(6)">Audio</li>
    </ul>
</div>
<div class="videoWindow">
	<div id="iframeDIV" style="width: 480px; height: 270px;border:#777 solid 1px;overflow:hidden; float:left">
    	<iframe id='jsVedioIframe' name='jsVedioIframe' width='480' height='270' scrolling='no' frameborder='0'></iframe>
    </div>
</div>
<div></div>
<div class="videoClass" id="firstPage">
    <div class="videoSet" style="margin-left: 100px">
    	<div class="videoSetShow">
           	<input type="hidden" id="VinRes960p" value='<%videoparaGet("VinRes960p", "net");%>' />
        	<form class="clearSpace" method="post" name="videParaSet" id="mainVideoForm" target="hideFrame" action="/form/videoparaCfg">
	        	<div class="cssVideoMode">
                    <input type="radio" name="ie6need" id="jsMainVideo" onclick="videoChanged('mainVideoForm', 1)" />
                    <label for="jsMainVideo">Main stream</label>
     	        </div>
                <div style="display:none">
                	<input type="text" id="resolution" value='<%videoparaGet("resolution", "net");%>' />
                	<input type="text" id="frameRate" value='<%videoparaGet("framerate","net");%>' />
                	<input type="text" id="bitRateControl" value='<%videoparaGet("BitRateControlSelect","net");%>'  />
                	<input type="text" id="bitRateTop" value='<%videoparaGet("BitRate","net");%>' />
                	<input type="text" id="IPrate" value='<%videoparaGet("IPRate","net");%>' />
                	<input type="text" id="Payload_" value='<%videoparaGet("Payload","net");%>' />
					<input type="text" id="Quality" value='<%videoparaGet("quality","net");%>' />
                    <%CameraGet("BasicCMDConf","net");%>
                </div>
                <div class="videoSetList" style="display:none" id="PayloadSelect">
                	<label>Enc type:&nbsp;</label><select name="Payload" id="Payload">
                    														<option value="0">H264</option>
                                                                            <option value="1">H265</option>
                                                                        </select>
                </div>
        	    <div class="videoSetList">
            		<label>Resolution:&nbsp;</label>
					<select  name="resolution" id="jsResolution" onchange="CheckFramerate();">        
                    	<option value="34">3840x2160</option>                
						<option value="33">2592x1944</option>
						<option value="32">2592x1520</option>
						<option value="31">2304x1296</option>
						<option value="12">2048x1536</option>
						<option value="10">1920x1080</option>
						<option value="8">1280x960</option>
                        <option value="5">1280x720</option>
                        <option value="16">720x576</option>
                        <option value="17">720x480</option>
                        <option value="6">640x480</option>
                    </select>
            	</div>
                <div class="videoSetList">
                	<label>Frame rate:&nbsp;</label><select name="framerate" id="jsFrameRate">
        	            												<option value="30">30</option>
                                                                        <option value="25">25</option>
        	                                                            <option value="20">20</option>
        	                                                            <option value="15">15</option>
        	                                                            <option value="10">10</option>
        	                                                            <option value="5">5</option>
        	                                                            <option value="3">3</option>
      	                                                          </select>
                </div>
                <div class="videoSetList">
                	<label>I/P rate:&nbsp;</label><select name="IPRate" id="jsIPrate">
          		          												<option value="5">5</option>
																		<option value="10">10</option>
																		<option value="15">15</option>
																		<option value="20">20</option>
																		<option value="25">25</option>
																		<option value="30">30</option>
																		<option value="40">40</option>
																		<option value="50">50</option>
																		<option value="60">60</option>
																		<option value="100">100</option>
																		<option value="120">120</option>
                                                                </select>
                </div>
                <div class="videoSetList">
                	<label>BitRate type:&nbsp;</label><select name="BitRateControlSelect" id="jsBitRateControl" onChange="BitRateSelect('mainVideoForm')";>
                    														<option value="0">VBR</option>
                                                                            <option value="1">CBR</option>
                                                                        </select>
                </div>
                <div class="videoSetList">
                	<label>Image quality:&nbsp;</label><select name="quality" id="jsQuality">
               		     														<option value="4">Highest</option>
            	                                                                <option value="3">High</option>
            	                                                                <option value="2">Average</option>
            	                                                                <option value="1">Low</option>
            	                                                                <option value="0">Lowest</option>
                                                                        </select>
                </div>
                <input type="hidden" name="BitRate" id="jsBitRateTopActr" />
                <div class="videoSetList" id="maxStreamLimit_1">
                	<label>BitRate:</label>
                    <input type="text" id="jsBitRateTop" style="width:60px;float:left" maxlength="5" onblur="bitRateCheck(128,10000,this)" />
                    <label style="display:inline; width:30px; font-size:12px">Kbps</label>
                </div>
				<div class="videoSetList" id="maxStreamLimit_2">
                    <label>BitRate:</label>
                    <input type="text" id="jsBitRateTop" style="width:60px;float:left" maxlength="5" onblur="bitRateCheck(128,5120,this)" />
                    <label style="display:inline; width:30px; font-size:12px">Kbps</label>
                </div>
                <div class="videoSetList" id="maxStreamLimit1">
                	<label style="visibility:hidden">&nbsp;</label>
                    <label style="font-size:12px; width:90px;">(128~10000)</label>
                </div>
				 <div class="videoSetList" id="maxStreamLimit2">
                    <label style="visibility:hidden;">&nbsp;</label>
                    <label style="font-size:12px; width:90px;">(128~5120)</label>
                </div>
                <br />  	            
                <div class="submitButton">
                	<input type="button" class="ButtonRight" value="Save" onclick="frameRateLimit();videoSet('mainVideoForm');refreshweb_Major();saveNotice()" />
  	            </div>
            </form>
    	</div>  	 
	    <div class="videoSetShow">
        	<form class="clearSpace" method="post" name="videParaSet" id="extVideoForm" target="hideFrame" action="/form/ExtVideoparaCfg">
	        	<div class="cssVideoMode">
                    <input type="radio" name="ie6need" id="jsExtVideo" onclick="videoChanged('extVideoForm', 1)" />
                	<label id="videoTypeExt" for="jsExtVideo">Sub stream</label>
     	        </div>
                <div style="display:none">
                	<input type="text" id="ExtResolution" value='<%ExtVideoparaGet("resolution","net");%>' />
                	<input type="text" id="ExtFrameRate" value='<%ExtVideoparaGet("framerate","net");%>' />
                	<input type="text" id="ExtBitRateControl" value='<%ExtVideoparaGet("BitRateControlSelect","net");%>' />
                	<input type="text" id="ExtBitRateTop" value='<%ExtVideoparaGet("BitRate","net");%>' />
                	<input type="text" id="ExtIPrate" value='<%ExtVideoparaGet("IPRate","net");%>' />
                	<input type="text" id="ExtPayload_" value='<%ExtVideoparaGet("Payload","net");%>' />
					<input type="text" id="ExtQuality" value='<%ExtVideoparaGet("quality","net");%>' />
                </div>
                <div class="videoSetList" style="display:none" id="ExtPayloadSelect">
                	<label>Enc type:&nbsp;</label><select name="Payload" id="ExtPayload">
                    														<option value="0">H264</option>
                                                                            <option value="1">H265</option>
                                                                        </select>
                </div>
                <div class="videoSetList">
            		<label>Resolution:&nbsp;</label>
					<select  name="resolution" id="jsExtResolution" onchange="CheckFramerate();">
                      <option value="5">1280x720</option>
					  <option value="16">720x576</option>
                      <option value="17">720x480</option>
                      <option value="6">640x480</option>
                      <option value="24">480x360</option>
                      <option value="2">352x288</option>
					  <option value="28">320x240</option>
                      <option value="1">176x144</option>
                     <option value="0">Closed</option>
                    </select>
            	</div>
                <div class="videoSetList">
                	<label>Frame rate:&nbsp;</label><select name="framerate" id="jsExtFrameRate">
        	            												<option value="30">30</option>
                                                                        <option value="25">25</option>
        	                                                            <option value="20">20</option>
        	                                                            <option value="15">15</option>
        	                                                            <option value="10">10</option>
        	                                                            <option value="5">5</option>
        	                                                            <option value="3">3</option>
      	                                                          </select>
                </div>
                <div class="videoSetList">
                	<label>I/P rate:&nbsp;</label><select name="IPRate" id="jsExtIPrate">
          		          												<option value="5">5</option>
																		<option value="10">10</option>
																		<option value="15">15</option>
																		<option value="20">20</option>
																		<option value="25">25</option>
																		<option value="30">30</option>
																		<option value="40">40</option>
																		<option value="50">50</option>
																		<option value="60">60</option>
																		<option value="100">100</option>
																		<option value="120">120</option>
                                                                </select>
                </div>
                <div class="videoSetList">
                	<label>BitRate type:&nbsp;</label><select name="BitRateControlSelect" id="jsExtBitRateControl" onChange="BitRateSelect('extVideoForm');">
                    														<option value="0">VBR</option>
                                                                            <option value="1">CBR</option>
                                                                        </select>
                </div>
                <div class="videoSetList">
                	<label>Image quality:&nbsp;</label><select name="quality" id="jsExtQuality">
               		     														<option value="4">Highest</option>
            	                                                                <option value="3">High</option>
            	                                                                <option value="2">Average</option>
            	                                                                <option value="1">Low</option>
            	                                                                <option value="0">Lowest</option>
                                                                        </select>
                </div>
                <input type="hidden" name="BitRate" id="jsExtBitRateTopActr" />
                <div class="videoSetList">
                	<label>BitRate:</label>
                    <input type="text" id="jsExtBitRateTop" style="width:60px;float:left" maxlength="4" onblur="bitRateCheck(32,2000,this)" />
                    <label style="display:inline; width:30px; font-size:12px">Kbps</label>
                </div>
                <div class="videoSetList">
                	<label style="visibility:hidden">&nbsp;</label>
                    <label style="font-size:12px; width:90px;">(32~2000)</label>
                </div>
                <br />
  	            <div class="submitButton">
                	<input type="button" class="ButtonRight" value="Save" onclick="videoSet('extVideoForm');refreshweb_Minor();saveNotice()" />
  	            </div>
            </form>
    	</div>  	
         <div class="videoSetShow">
        	<form class="clearSpace mstarhide" method="post" name="videParaSet" id="MJPEGform" target="hideFrame" action="/form/mjpegparaCfg">
	        	<div class="cssVideoMode">
                    <input type="radio" name="ie6need" id="jsMJPEGvideo" onclick="videoChanged('MJPEGform', 1)" />
                    <label for="jsMJPEGvideo">MJPEG</label>
     	        </div>
                <div style="display:none">
	                <input type="text" id="MJPEGresolution" value='<%mjpegparaGet("resolution","net");%>' />
     	           <input type="text" id="MJPEGframeRate" value='<%mjpegparaGet("frame","net");%>' />
                   <input type="text" id="MJPEGQuality" value='<%mjpegparaGet("quality","net");%>' />
               </div>
                <div class="videoSetList gokehide">
            		<label>Resolution:&nbsp;</label>
					<select  name="resolution" id="jsMJPEGresolution">
                      <option value="34">3840x2160</option>
            		  <option value="33">2592x1944</option>
            		  <option value="32">2592x1520</option>
            		  <option value="12">2048x1536</option>
                      <option value="10">1920x1080</option>
					  <option value="8">1280x960</option>
                      <option value="5">1280x720</option>
					  <option value="0">Closed</option>
                    </select>
            	</div>
                <div class="videoSetList">
                	<label>Frame rate:&nbsp;</label>
					<select name="frame" id="jsMJPEGframeRate">
        	          <option value="30">30</option>
        	          <option value="25">25</option>
        	          <option value="20">20</option>
        	          <option value="15">15</option>
        	          <option value="10">10</option>
        	          <option value="5">5</option>
                      <option value="4">4</option>
        	          <option value="3">3</option>
                      <option value="2">2</option>
        	          <option value="1">1</option>
      	            </select>
                </div> 
                <div class="videoSetList">
                	<label>Image quality:&nbsp;</label><select name="quality" id="jsMJPEGQuality">
               		     														<option value="4">Highest</option>
            	                                                                <option value="3">High</option>
            	                                                                <option value="2">Average</option>
            	                                                                <option value="1">Low</option>
            	                                                                <option value="0">Lowest</option>
                                                                        </select>
                </div>
                <div class="videoSetList"></div>
                <div class="videoSetList"></div>
                <div class="videoSetList"></div>
                <br />
                <div class="submitButton">
                	<input type="button" class="ButtonRight" value="Save" onclick="videoSet('MJPEGform');saveNotice()" />
  	            </div>
            </form>
        </div>
    </div>
	<pre id="limitNoteLab" class="noteLabel">(Note: When the main stream has a resolution of 1080p, 30fps, the sub stream will be shut down, so will adjustment 
 be made to the MJPEG stream for better performance and video recording supports main stream only.)</pre>
 	<pre id="recordNoteLab" class="noteLabel">(Note: When sub stream is shut, video recording supports main stream only.)</pre>
</div>

<div class="videoClass">
    <div class="videoSet">
        <form class="clearSpace" method="post" name="auvi_OSDForm" id="OSDform" action="/form/OSDSet" target="hideFrame">
            <div class="OSDset">
                <div style="display:none">
                    <input type="text" id="Text1OSDEnable" value='<%OSDGet("Text1OSDEnable","net");%>'/>
                </div>
                <label class="OSDcontain">Text 1:</label>
                <div class="OSDstate">
                    <input class="OSDopen" type="radio" name="Text1OSDEnable" id="jsText1OSDstate1" value="1" onclick="textOSDchanged(1,1)" />
                    <label class="OSDraidoLabel" for="jsText1OSDstate1">On</label>
                    <input class="OSDopen" type="radio" name="Text1OSDEnable" id="jsText1OSDstate0" value="0" onclick="textOSDchanged(1,0)" />
                    <label class="OSDraidoLabel" for="jsText1OSDstate0">Off</label>
                    <label class="OSDXYlabel" id="jsText1OSDxyLab">X/Y(0-99):</label>
                      <input class="textX" type="text" name="Text1OSDX" id="jsText1OSDx" maxlength="2" value='<%OSDGet("Text1OSDX","net");%>' />
                      <input class="textY" type="text" name="Text1OSDY" id="jsText1OSDy" maxlength="2" value='<%OSDGet("Text1OSDY","net");%>' />
                </div>
            </div>
            <div class="OSDset mstarhide"  style="padding-top:5px">
                <input type="hidden" id="OSD1SizeGet" value='<%OSDGet("OSD1Size","net");%>' />
                <label class="OSDcontain">Font size:</label>
                <div class="OSDstate">
                    <select name="OSD1Size" id="jsOSD1Size" style="width:35px; text-align:center">
                        <option value="1"> 1</option>
                        <option value="2"> 2</option>
                        <option value="3"> 3</option>
                        <option value="4"> 4</option>
                        <option value="5"> 5</option>
                        <option value="6"> 6</option>
                        <option value="7"> 7</option>
                        <option value="8"> 8</option>
                    </select>
                </div>
            </div>
            <div class="OSDset">
                <label class="OSDcontain" id="jsText1OSDstrLab">Content:</label>
                <div class="OSDstate">
                    <input type="text" class="OSDtext" name="OSD1Str" id="OSD1Text" maxlength="36" onkeyup="input_size(this,1);" value='<%OSDGet("OSD1Str","net");%>' onfocus="OBJfocus('OSD1Text', 'OSD1Label', 127)" onblur="OBJblur()" />
   		 			<label id="word1Count" style="font-size:14px;margin-top:0px" lang="textremain">Total:36.Remain:</label><label style="font-size:14px" id="OsdRemainLabel1">36</label>.
                    <label class="lenOSD" id="OSD1Label">Length over limit!</label>
                </div>
            </div>
		<div class="mstarhide">
            <div class="OSDset" style="padding-top:5px">
                <div style="display:none">
                    <input type="text" id="Text2OSDEnable" value='<%OSDGet("Text2OSDEnable","net");%>'/>
                </div>
                <label class="OSDcontain">Text 2:</label>
                <div class="OSDstate">
                    <input class="OSDopen" type="radio" name="Text2OSDEnable" id="jsText2OSDstate1" value="1" onclick="textOSDchanged(2,1)" />
                    <label class="OSDraidoLabel" for="jsText2OSDstate1">On</label>
                    <input class="OSDopen" type="radio" name="Text2OSDEnable" id="jsText2OSDstate0" value="0" onclick="textOSDchanged(2,0)" />
                    <label class="OSDraidoLabel" for="jsText2OSDstate0">Off</label>
                    <label class="OSDXYlabel" id="jsText2OSDxyLab">X/Y(0-99):</label>
                      <input class="textX" type="text" name="Text2OSDX" id="jsText2OSDx" maxlength="2" value='<%OSDGet("Text2OSDX","net");%>' />
                      <input class="textY" type="text" name="Text2OSDY" id="jsText2OSDy" maxlength="2" value='<%OSDGet("Text2OSDY","net");%>' />
                </div>
            </div>
             <div class="OSDset"  style="padding-top:5px">
                <input type="hidden" id="OSD2SizeGet" value='<%OSDGet("OSD2Size","net");%>' />
                <label class="OSDcontain">Font size:</label>
                <div class="OSDstate">
                    <select name="OSD2Size" id="jsOSD2Size" style="width:35px; text-align:center">
                        <option value="1"> 1</option>
                        <option value="2"> 2</option>
                        <option value="3"> 3</option>
                        <option value="4"> 4</option>
                        <option value="5"> 5</option>
                        <option value="6"> 6</option>
                        <option value="7"> 7</option>
                        <option value="8"> 8</option>
                    </select>
                </div>
            </div>
            <div class="OSDset">
                <label class="OSDcontain" id="jsText2OSDstrLab">Content:</label>
                <div class="OSDstate">
                    <input type="text" class="OSDtext" name="OSD2Str" id="OSD2Text" maxlength="36" onkeyup="input_size(this,2);" value='<%OSDGet("OSD2Str","net");%>' onfocus="OBJfocus('OSD2Text', 'OSD2Label', 127)" onblur="OBJblur()" />
   		 			<label id="word2Count" style="font-size:14px;margin-top:0px" lang="textremain">Total:36.Remain:</label><label style="font-size:14px" id="OsdRemainLabel2">36</label>.
                    <label class="lenOSD" id="OSD2Label">Length over limit!</label>
                </div>
            </div>
		</div>
		<div class="gokehide mstarhide">
            <div class="OSDset" style="padding-top:5px">
                <div style="display:none">
                    <input type="text" id="Text3OSDEnable" value='<%OSDGet("Text3OSDEnable","net");%>'/>
                </div>
                <label class="OSDcontain">Text 3:</label>
                <div class="OSDstate">
                    <input class="OSDopen" type="radio" name="Text3OSDEnable" id="jsText3OSDstate1" value="1" onclick="textOSDchanged(3,1)" />
                    <label class="OSDraidoLabel" for="jsText3OSDstate1">On</label>
                    <input class="OSDopen" type="radio" name="Text3OSDEnable" id="jsText3OSDstate0" value="0" onclick="textOSDchanged(3,0)" />
                    <label class="OSDraidoLabel" for="jsText3OSDstate0">Off</label>
                    <label class="OSDXYlabel" id="jsText3OSDxyLab">X/Y(0-99):</label>
                      <input class="textX" type="text" name="Text3OSDX" id="jsText3OSDx" maxlength="2" value='<%OSDGet("Text3OSDX","net");%>' />
                      <input class="textY" type="text" name="Text3OSDY" id="jsText3OSDy" maxlength="2" value='<%OSDGet("Text3OSDY","net");%>' />
                </div>
            </div>
            <div class="OSDset"  style="padding-top:5px">
                <input type="hidden" id="OSD3SizeGet" value='<%OSDGet("OSD3Size","net");%>' />
                <label class="OSDcontain">Font size:</label>
                <div class="OSDstate">
                    <select name="OSD3Size" id="jsOSD3Size" style="width:35px; text-align:center">
                        <option value="1"> 1</option>
                        <option value="2"> 2</option>
                        <option value="3"> 3</option>
                        <option value="4"> 4</option>
                        <option value="5"> 5</option>
                        <option value="6"> 6</option>
                        <option value="7"> 7</option>
                        <option value="8"> 8</option>
                    </select>
                </div>
            </div>
            <div class="OSDset">
                <label class="OSDcontain" id="jsText3OSDstrLab">Content:</label>
                <div class="OSDstate">
                    <input type="text" class="OSDtext" name="OSD3Str" id="OSD3Text" maxlength="36" onkeyup="input_size(this,3);" value='<%OSDGet("OSD3Str","net");%>' onfocus="OBJfocus('OSD3Text', 'OSD3Label', 127)" onblur="OBJblur()" />
   		 			<label id="word3Count" style="font-size:14px;margin-top:0px" lang="textremain">Total:36.Remain:</label><label style="font-size:14px" id="OsdRemainLabel3">36</label>.
                    <label class="lenOSD" id="OSD3Label">Length over limit!</label>
                </div>
            </div>

            <div class="OSDset" style="padding-top:5px">
                <div style="display:none">
                    <input type="text" id="Text4OSDEnable" value='<%OSDGet("Text4OSDEnable","net");%>'/>
                </div>
                <label class="OSDcontain">Text 4:</label>
                <div class="OSDstate">
                    <input class="OSDopen" type="radio" name="Text4OSDEnable" id="jsText4OSDstate1" value="1" onclick="textOSDchanged(4,1)" />
                    <label class="OSDraidoLabel" for="jsText4OSDstate1">On</label>
                    <input class="OSDopen" type="radio" name="Text4OSDEnable" id="jsText4OSDstate0" value="0" onclick="textOSDchanged(4,0)" />
                    <label class="OSDraidoLabel" for="jsText4OSDstate0">Off</label>
                    <label class="OSDXYlabel" id="jsText4OSDxyLab">X/Y(0-99):</label>
                      <input class="textX" type="text" name="Text4OSDX" id="jsText4OSDx" maxlength="2" value='<%OSDGet("Text4OSDX","net");%>' />
                      <input class="textY" type="text" name="Text4OSDY" id="jsText4OSDy" maxlength="2" value='<%OSDGet("Text4OSDY","net");%>' />
                </div>
            </div>
            <div class="OSDset"  style="padding-top:5px">
                <input type="hidden" id="OSD4SizeGet" value='<%OSDGet("OSD4Size","net");%>' />
                <label class="OSDcontain">Font size:</label>
                <div class="OSDstate">
                    <select name="OSD4Size" id="jsOSD4Size" style="width:35px; text-align:center">
                        <option value="1"> 1</option>
                        <option value="2"> 2</option>
                        <option value="3"> 3</option>
                        <option value="4"> 4</option>
                        <option value="5"> 5</option>
                        <option value="6"> 6</option>
                        <option value="7"> 7</option>
                        <option value="8"> 8</option>
                    </select>
                </div>
            </div>
            <div class="OSDset">
                <label class="OSDcontain" id="jsText4OSDstrLab">Content:</label>
                <div class="OSDstate">
                    <input type="text" class="OSDtext" name="OSD4Str" id="OSD4Text" maxlength="36" onkeyup="input_size(this,4);" value='<%OSDGet("OSD4Str","net");%>' onfocus="OBJfocus('OSD4Text', 'OSD4Label', 127)" onblur="OBJblur()" />
   		 			<label id="word4Count" style="font-size:14px;margin-top:0px" lang="textremain">Total:36.Remain:</label><label style="font-size:14px" id="OsdRemainLabel4">36</label>.
                    <label class="lenOSD" id="OSD4Label">Length over limit!</label>
                </div>
            </div>

            <div class="OSDset" style="padding-top:5px">
                <div style="display:none">
                    <input type="text" id="Text5OSDEnable" value='<%OSDGet("Text5OSDEnable","net");%>'/>
                </div>
                <label class="OSDcontain">Text 5:</label>
                <div class="OSDstate">
                    <input class="OSDopen" type="radio" name="Text5OSDEnable" id="jsText5OSDstate1" value="1" onclick="textOSDchanged(5,1)" />
                    <label class="OSDraidoLabel" for="jsText5OSDstate1">On</label>
                    <input class="OSDopen" type="radio" name="Text5OSDEnable" id="jsText5OSDstate0" value="0" onclick="textOSDchanged(5,0)" />
                    <label class="OSDraidoLabel" for="jsText5OSDstate0">Off</label>
                    <label class="OSDXYlabel" id="jsText5OSDxyLab">X/Y(0-99):</label>
                      <input class="textX" type="text" name="Text5OSDX" id="jsText5OSDx" maxlength="2" value='<%OSDGet("Text5OSDX","net");%>' />
                      <input class="textY" type="text" name="Text5OSDY" id="jsText5OSDy" maxlength="2" value='<%OSDGet("Text5OSDY","net");%>' />
                </div>
            </div>
            <div class="OSDset"  style="padding-top:5px">
                <input type="hidden" id="OSD5SizeGet" value='<%OSDGet("OSD5Size","net");%>' />
                <label class="OSDcontain">Font size:</label>
                <div class="OSDstate">
                    <select name="OSD5Size" id="jsOSD5Size" style="width:35px; text-align:center">
                        <option value="1"> 1</option>
                        <option value="2"> 2</option>
                        <option value="3"> 3</option>
                        <option value="4"> 4</option>
                        <option value="5"> 5</option>
                        <option value="6"> 6</option>
                        <option value="7"> 7</option>
                        <option value="8"> 8</option>
                    </select>
                </div>
            </div>
            <div class="OSDset">
                <label class="OSDcontain" id="jsText5OSDstrLab">Content:</label>
                <div class="OSDstate">
                    <input type="text" class="OSDtext" name="OSD5Str" id="OSD5Text" maxlength="36" onkeyup="input_size(this,5);" value='<%OSDGet("OSD5Str","net");%>' onfocus="OBJfocus('OSD5Text', 'OSD5Label', 127)" onblur="OBJblur()" />
   		 			<label id="word5Count" style="font-size:14px;margin-top:0px" lang="textremain">Total:36.Remain:</label><label style="font-size:14px" id="OsdRemainLabel5">36</label>.
                    <label class="lenOSD" id="OSD5Label">Length over limit!</label>
                </div>
            </div>

            <div style="display:none">
                    <input type="text" id="Multiple_enable" value='<%OSDGet("MultipleEnable","net");%>'>
            </div>
            <div class="OSDset" id="Multiple_Osd" style="padding-top:5px">
                <div style="display:none">
                    <input type="text" id="MultipleOSDEnable" value='<%OSDGet("MultipleOSDEnable","net");%>'>
                </div>
                <label class="OSDcontain">Multiple:</label>
                <div class="OSDstate">
                    <input class="OSDopen" type="radio" name="MultipleOSDEnable" id="jsMultipleOSDstate1" value="1" onclick="MultipleOSDchanged(1)" />
                    <label class="OSDraidoLabel" for="jsMultipleOSDstate1">On</label>
                    <input class="OSDopen" type="radio" name="MultipleOSDEnable" id="jsMultipleOSDstate0" value="0" onclick="MultipleOSDchanged(0)" />
                    <label class="OSDraidoLabel" for="jsMultipleOSDstate0">Off</label>
                    <label class="OSDXYlabel" id="jsMultipleOSDxyLab">X/Y(0-99):</label>
                      <input class="textX" type="text" name="MultipleOSDX" id="jsMultipleOSDx" maxlength="2" value='<%OSDGet("MultipleOSDX","net");%>' />
                      <input class="textY" type="text" name="MultipleOSDY" id="jsMultipleOSDy" maxlength="2" value='<%OSDGet("MultipleOSDY","net");%>' />
                </div>
            </div>
            <div class="OSDset" id="Multiple_size" style="padding-top:5px">
                <input type="hidden" id="MultipleSizeGet" value='<%OSDGet("MultipleOSDSize","net");%>' />
                <label class="OSDcontain">Font size:</label>
                <div class="OSDstate">
                    <select name="MultipleOSDSize" id="jsMultipleOSDSize" style="width:35px; text-align:center">
                        <option value="1"> 1</option>
                        <option value="2"> 2</option>
                        <option value="3"> 3</option>
                        <option value="4"> 4</option>
                        <option value="5"> 5</option>
                        <option value="6"> 6</option>
                        <option value="7"> 7</option>
                        <option value="8"> 8</option>
                    </select>
                </div>
            </div>
        </div>
            <div class="OSDset" style="padding-top:5px">
                <div style="display:none">
                    <input type="text" id="TimeOSDEnable" value='<%OSDGet("DTimeOSDEnable","net");%>'>
                </div>
                <label class="OSDcontain">Date&amp;Time:</label>
                <div class="OSDstate">
                    <input class="OSDopen" type="radio" name="DTimeOSDEnable" id="jsTimeOSDstate1" value="1" onclick="timeOSDchanged(1)" />
                    <label class="OSDraidoLabel" for="jsTimeOSDstate1">On</label>
                    <input class="OSDopen" type="radio" name="DTimeOSDEnable" id="jsTimeOSDstate0" value="0" onclick="timeOSDchanged(0)" />
                    <label class="OSDraidoLabel" for="jsTimeOSDstate0">Off</label>
                    <label class="OSDXYlabel" id="jsTimeOSDxyLab">X/Y(0-99):</label>
                      <input class="textX" type="text" name="DTimeOSDX" id="jsTimeOSDx" maxlength="2" value='<%OSDGet("DTimeOSDX","net");%>' />
                      <input class="textY" type="text" name="DTimeOSDY" id="jsTimeOSDy" maxlength="2" value='<%OSDGet("DTimeOSDY","net");%>' />
                </div>
            </div>
            <div class="OSDset mstarhide"  style="padding-top:5px">
                <input type="hidden" id="DTimeSizeGet" value='<%OSDGet("DTimeOSDSize","net");%>' />
                <label class="OSDcontain">Font size:</label>
                <div class="OSDstate">
                    <select name="DTimeOSDSize" id="jsDTimeOSDSize" style="width:35px; text-align:center">
                        <option value="1"> 1</option>
                        <option value="2"> 2</option>
                        <option value="3"> 3</option>
                        <option value="4"> 4</option>
                        <option value="5"> 5</option>
                        <option value="6"> 6</option>
                        <option value="7"> 7</option>
                        <option value="8"> 8</option>
                    </select>
                </div>
            </div>
            <br />
            <div class="OSDset" style="position:relative">
            <input type="button" value="Save" onclick="osdSubmit('OSDform');saveNotice()" class="ButtonRight" style="position:absolute; left:364px" />
            </div>
        </form>
    </div>
</div>

<div class="videoClass">
	<form class="clearSpace" method="post" name="MDScopeForm" id="jsMDScopeForm" action="/form/SetMdScopeCfg" target="hideFrame">
    	<div style="display:none">
		<input type="text" name="MDEnable" id="jsMDEnable" value="<%GetMdScopeCfg("MDEnable", "net");%>" />
        <input type="text" name="MDSensitivity" id="jsMotion5Sens" value='<%GetMdScopeCfg("MDSensitivity","net");%>' />
        <!--<input type="text" id="jsMotion5Sback" />-->
        </div>
            
        <div class="areaSet" style="margin-left:70px">
           	<div class="mdScopeDrag">
            <input type="button" value="Drag scope" id="jsMDScopeDrag" onclick="MDScopeAction(1)" />
    		<input type="button" value="Clear all" id="jsMDScopeClear" onclick="MDScopeAction(0)" />
            </div>
            
            <div class="sensDiv">
                <label class="motionSenstive" id="jsMotion5SensLab">sensitivity&nbsp;</label>
    	        <label id="jsMotion5SensLabel" class="sensLabel">99</label>
                <div class="slider" id="jsSens5"></div>
        	    <label class="sensExplain">(Most sensitive)</label>
            </div>
            </div>
            <br />
            <br />
        	<div class="areaSet" style="margin-left:100px">
            	<input type="checkbox" id="jsMDCheckbox" />
            	<label>Enable motion detect</label>
            </div>
            <br />
            <br />
            
           	<div class="areaSet">
           		<input type="button" class="mdScopeBut" value="save" id="jsMDScopeSubmit" onclick="MDScopeSave();saveNotice()" />
           	</div>    
	</form>
</div>

<div class="videoClass">
	<input type="hidden" id="privacySwitchGet" value='<%PrivacyGet("PrivacySwitch","net");%>' />
	<div class="areaSet">
		<div class="areaSetName">
    		<label id="jsPrivacy1Lab" for="jsPrivacy1Checkbox">Zone 1:</label>
        	<input type="checkbox" value="1" id="jsPrivacy1Checkbox" onclick="privacyAreaEnable(1)" />
    	</div>
        <form class="clearSpace" method="post" name="PrivacyForm" id="PrivacyForm1" action="/form/PrivacySet" target="hideFrame">
        	<div style="display:none">
            	<input type="text" name="flag" value="1" />
        		<input type="text" name="PrivacyEnable1" id="jsPrivacy1Active" value='<%PrivacyGet("PrivacyEnable1","net");%>' />
            	<input type="text" name="PTop1" id="jsPrivacy1Top" value='<%PrivacyGet("PTop1","net");%>' />
          		<input type="text" name="PBottom1" id="jsPrivacy1Bottom" value='<%PrivacyGet("PBottom1","net");%>' />
            	<input type="text" name="PLeft1" id="jsPrivacy1Left" value='<%PrivacyGet("PLeft1","net");%>' />
            	<input type="text" name="PRight1" id="jsPrivacy1Right" value='<%PrivacyGet("PRight1","net");%>' />
        	</div>
        	<div class="areaSetContain">
        		<div class="areaSetTop">
	        		<input type="button" class="dragBegin" value="Draw" id="jsPrivacy1Drag" onclick="privacyAreaAdd(1); privacyAreaDrag(1); privacyOperateLimit(1)" />
    	        	<label class="areaName" id="jsPrivacy1NameLab">Name:&nbsp;</label>
                    	<input type="hidden" id="jsPrivacy1Nback" />
        	    		<input class="areaNameInput" type="text" name="PName1" id="jsPrivacy1Name" maxlength="63" value='<%PrivacyGet("PName1","net");%>   ' onfocus="OBJfocus('jsPrivacy1Name', 'P1Label', 63)" onblur="OBJblur()" />
                        <label class="lenLabel" id="P1Label">!</label>
            	</div>
            	<div class="areaSetBottom">
                	<div class="sensDiv">&nbsp;</div>
                 	<input type="button" value="Save" id="jsPrivacy1Sub" onclick="privacyAreaGet(1);privacyAreaSub(1);privacyOperateRes();saveNotice()" />
                	<input type="button" value="Cancel" id="jsPrivacy1Res" onclick="privacyAreaReset(1);privacyOperateRes()" />
            	</div>
        	</div>
        </form>
    </div>
    <div class="areaSet">
		<div class="areaSetName">
    		<label id="jsPrivacy2Lab" for="jsPrivacy2Checkbox">Zone 2:</label>
        	<input type="checkbox" value="2" id="jsPrivacy2Checkbox" onclick="privacyAreaEnable(2)"/>
    	</div>
        <form class="clearSpace" method="post" name="PrivacyForm" id="PrivacyForm2" action="/form/PrivacySet" target="hideFrame">
        	<div style="display:none">
            	<input type="text" name="flag" value="2" />
        		<input type="text" name="PrivacyEnable2" id="jsPrivacy2Active" value='<%PrivacyGet("PrivacyEnable2","net");%>' />
            	<input type="text" name="PTop2" id="jsPrivacy2Top" value='<%PrivacyGet("PTop2","net");%>' />
          		<input type="text" name="PBottom2" id="jsPrivacy2Bottom" value='<%PrivacyGet("PBottom2","net");%>' />
            	<input type="text" name="PLeft2" id="jsPrivacy2Left" value='<%PrivacyGet("PLeft2","net");%>' />
            	<input type="text" name="PRight2" id="jsPrivacy2Right" value='<%PrivacyGet("PRight2","net");%>' />
        	</div>
        	<div class="areaSetContain">
        		<div class="areaSetTop">
	        		<input type="button" class="dragBegin" value="Draw" id="jsPrivacy2Drag" onclick="privacyAreaAdd(2); privacyAreaDrag(2); privacyOperateLimit(2)" />
    	        	<label class="areaName" id="jsPrivacy2NameLab">Name:&nbsp;</label>
                    	<input type="hidden" id="jsPrivacy2Nback" />
        	    		<input class="areaNameInput" type="text" name="PName2" id="jsPrivacy2Name" maxlength="63" value='<%PrivacyGet("PName2","net");%>   ' onfocus="OBJfocus('jsPrivacy2Name', 'P2Label', 63)" onblur="OBJblur()" />
                        <label class="lenLabel" id="P2Label">!</label>
            	</div>
            	<div class="areaSetBottom">
                	<div class="sensDiv">&nbsp;</div>
            		<input type="button" value="Save" id="jsPrivacy2Sub" onclick="privacyAreaGet(2);privacyAreaSub(2);privacyOperateRes();saveNotice()" />
                	<input type="button" value="Cancel" id="jsPrivacy2Res" onclick="privacyAreaReset(2);privacyOperateRes()" />
            	</div>
        	</div>
        </form>
    </div>
    <div class="areaSet">
		<div class="areaSetName">
    		<label id="jsPrivacy3Lab" for="jsPrivacy3Checkbox">Zone 3:</label>
        	<input type="checkbox" value="3" id="jsPrivacy3Checkbox" onclick="privacyAreaEnable(3)" />
    	</div>
        <form class="clearSpace" method="post" name="PrivacyForm" id="PrivacyForm3" action="/form/PrivacySet" target="hideFrame">
        	<div style="display:none">
            	<input type="text" name="flag" value="3" />
        		<input type="text" name="PrivacyEnable3" id="jsPrivacy3Active" value='<%PrivacyGet("PrivacyEnable3","net");%>' />
            	<input type="text" name="PTop3" id="jsPrivacy3Top" value='<%PrivacyGet("PTop3","net");%>' />
          		<input type="text" name="PBottom3" id="jsPrivacy3Bottom" value='<%PrivacyGet("PBottom3","net");%>' />
            	<input type="text" name="PLeft3" id="jsPrivacy3Left" value='<%PrivacyGet("PLeft3","net");%>' />
            	<input type="text" name="PRight3" id="jsPrivacy3Right" value='<%PrivacyGet("PRight3","net");%>' />
        	</div>
       		<div class="areaSetContain">
        		<div class="areaSetTop">
	        		<input type="button" class="dragBegin" value="Draw" id="jsPrivacy3Drag" onclick="privacyAreaAdd(3); privacyAreaDrag(3); privacyOperateLimit(3)" />
    	        	<label class="areaName" id="jsPrivacy3NameLab">Name:&nbsp;</label>
                    	<input type="hidden" id="jsPrivacy3Nback" />
        	    		<input class="areaNameInput" type="text" name="PName3" id="jsPrivacy3Name" maxlength="63" value='<%PrivacyGet("PName3","net");%>   ' onfocus="OBJfocus('jsPrivacy3Name', 'P3Label', 63)" onblur="OBJblur()" />
                        <label class="lenLabel" id="P3Label">!</label>
            	</div>
            	<div class="areaSetBottom">
                	<div class="sensDiv">&nbsp;</div>
            		<input type="button" value="Save" id="jsPrivacy3Sub" onclick="privacyAreaGet(3);privacyAreaSub(3);privacyOperateRes();saveNotice()" />
                	<input type="button" value="Cancel" id="jsPrivacy3Res" onclick="privacyAreaReset(3);privacyOperateRes()" />
           	 	</div>
        	</div>
        </form>
    </div>
    <div class="areaSet">
		<div class="areaSetName">
    		<label id="jsPrivacy4Lab" for="jsPrivacy4Checkbox">Zone 4:</label>
        	<input type="checkbox" value="4" id="jsPrivacy4Checkbox" onclick="privacyAreaEnable(4)" />
    	</div>
        <form class="clearSpace" method="post" name="PrivacyForm" id="PrivacyForm4" action="/form/PrivacySet" target="hideFrame">
        	<div style="display:none">
            	<input type="text" name="flag" value="4" />
        		<input type="text" name="PrivacyEnable4" id="jsPrivacy4Active" value='<%PrivacyGet("PrivacyEnable4","net");%>' />
            	<input type="text" name="PTop4" id="jsPrivacy4Top" value='<%PrivacyGet("PTop4","net");%>' />
          		<input type="text" name="PBottom4" id="jsPrivacy4Bottom" value='<%PrivacyGet("PBottom4","net");%>' />
            	<input type="text" name="PLeft4" id="jsPrivacy4Left" value='<%PrivacyGet("PLeft4","net");%>' />
            	<input type="text" name="PRight4" id="jsPrivacy4Right" value='<%PrivacyGet("PRight4","net");%>' />
        	</div>
        	<div class="areaSetContain">
        		<div class="areaSetTop">
	        		<input type="button" class="dragBegin" value="Draw" id="jsPrivacy4Drag" onclick="privacyAreaAdd(4); privacyAreaDrag(4); privacyOperateLimit(4)" />
    	        	<label class="areaName" id="jsPrivacy4NameLab">Name:&nbsp;</label>
                    	<input type="hidden" id="jsPrivacy4Nback" />
        	    		<input class="areaNameInput" type="text" name="PName4" id="jsPrivacy4Name" maxlength="63" value='<%PrivacyGet("PName4","net");%>   ' onfocus="OBJfocus('jsPrivacy4Name', 'P4Label', 63)" onblur="OBJblur()" />
                        <label class="lenLabel" id="P4Label">!</label>
            	</div>
            	<div class="areaSetBottom">
                	<div class="sensDiv">&nbsp;</div>
            		<input type="button" value="Save" id="jsPrivacy4Sub" onclick="privacyAreaGet(4);privacyAreaSub(4);privacyOperateRes();saveNotice()" />
                	<input type="button" value="Cancel" id="jsPrivacy4Res" onclick="privacyAreaReset(4);privacyOperateRes()" />
            	</div>
        	</div>
        </form>
    </div>    
</div>

<div class="videoClass">
	<div class="areaSet">
		<div class="areaSetName">
    		<label id="jsRoi1Lab" class="tahoma" for="jsRoi1Checkbox">Zone 1:</label>
        	<input type="checkbox" value="1" id="jsRoi1Checkbox" onclick="roiAreaEnable(1)" />
    	</div>
        <form class="clearSpace" method="post" name="RoiForm" id="RoiForm1" action="/form/RoiAreaSet" target="hideFrame">
        	<div style="display:none">
            	<input type="text" name="flag" value="1" />
        		<input type="text" name="RoiEnable1" id="jsRoi1Active" value='<%RoiAreaGet("RoiEnable1","net");%>' />
            	<input type="text" name="RoiTop1" id="jsRoi1Top" value='<%RoiAreaGet("RoiTop1","net");%>' />
          		<input type="text" name="RoiBottom1" id="jsRoi1Bottom" value='<%RoiAreaGet("RoiBottom1","net");%>' />
            	<input type="text" name="RoiLeft1" id="jsRoi1Left" value='<%RoiAreaGet("RoiLeft1","net");%>' />
            	<input type="text" name="RoiRight1" id="jsRoi1Right" value='<%RoiAreaGet("RoiRight1","net");%>' />
            	<input type="text" name="Roi1Level_" id="jsRoi1Level_" value='<%RoiAreaGet("RoiLevel1","net");%>' />
        	</div>
        	<div class="areaSetContain">
        		<div class="areaSetTop">
	        		<input type="button" class="dragBegin" value="Draw" id="jsRoi1Drag" onclick="roiAreaAdd(1); roiAreaDrag(1); roiOperateLimit(1)" />
    	        	<label class="areaName" id="jsRoi1LevelLab">Level:&nbsp;</label>
                        <select class="areaNinput" style="width:80px" name="Roi1Level" id="jsRoi1Level">
                        	<option value="0">Low</option>
                        	<option value="1">Middle</option>
                        	<option value="2">High</option>
                        </select>
            	</div>
            	<div class="areaSetBottom">
                	<div class="sensDiv">&nbsp;</div>
                 	<input type="button" value="Save" id="jsRoi1Sub" onclick="roiAreaGet(1);roiAreaSub(1);roiOperateRes();saveNotice()" />
                	<input type="button" value="Cancel" id="jsRoi1Res" onclick="roiAreaReset(1);roiOperateRes()" />
            	</div>
        	</div>
        </form>
    </div>
	<div class="areaSet">
		<div class="areaSetName">
    		<label id="jsRoi2Lab" class="tahoma" for="jsRoi2Checkbox">Zone 2:</label>
        	<input type="checkbox" value="1" id="jsRoi2Checkbox" onclick="roiAreaEnable(2)" />
    	</div>
        <form class="clearSpace" method="post" name="RoiForm" id="RoiForm2" action="/form/RoiAreaSet" target="hideFrame">
        	<div style="display:none">
            	<input type="text" name="flag" value="2" />
        		<input type="text" name="RoiEnable2" id="jsRoi2Active" value='<%RoiAreaGet("RoiEnable2","net");%>' />
            	<input type="text" name="RoiTop2" id="jsRoi2Top" value='<%RoiAreaGet("RoiTop2","net");%>' />
          		<input type="text" name="RoiBottom2" id="jsRoi2Bottom" value='<%RoiAreaGet("RoiBottom2","net");%>' />
            	<input type="text" name="RoiLeft2" id="jsRoi2Left" value='<%RoiAreaGet("RoiLeft2","net");%>' />
            	<input type="text" name="RoiRight2" id="jsRoi2Right" value='<%RoiAreaGet("RoiRight2","net");%>' />
            	<input type="text" name="Roi2Level_" id="jsRoi2Level_" value='<%RoiAreaGet("RoiLevel2","net");%>' />
        	</div>
        	<div class="areaSetContain">
        		<div class="areaSetTop">
	        		<input type="button" class="dragBegin" value="Draw" id="jsRoi2Drag" onclick="roiAreaAdd(2); roiAreaDrag(2); roiOperateLimit(2)" />
    	        	<label class="areaName" id="jsRoi2LevelLab">Level:&nbsp;</label>
                        <select class="areaNinput" style="width:80px" name="Roi2Level" id="jsRoi2Level">
                        	<option value="0">Low</option>
                        	<option value="1">Middle</option>
                        	<option value="2">High</option>
                        </select>
            	</div>
            	<div class="areaSetBottom">
                	<div class="sensDiv">&nbsp;</div>
                 	<input type="button" value="Save" id="jsRoi2Sub" onclick="roiAreaGet(2);roiAreaSub(2);roiOperateRes();saveNotice()" />
                	<input type="button" value="Cancel" id="jsRoi2Res" onclick="roiAreaReset(2);roiOperateRes()" />
            	</div>
        	</div>
        </form>
    </div>
	<div class="areaSet">
		<div class="areaSetName">
    		<label id="jsRoi3Lab" class="tahoma" for="jsRoi3Checkbox">Zone 3:</label>
        	<input type="checkbox" value="1" id="jsRoi3Checkbox" onclick="roiAreaEnable(3)" />
    	</div>
        <form class="clearSpace" method="post" name="RoiForm" id="RoiForm3" action="/form/RoiAreaSet" target="hideFrame">
        	<div style="display:none">
            	<input type="text" name="flag" value="3" />
        		<input type="text" name="RoiEnable3" id="jsRoi3Active" value='<%RoiAreaGet("RoiEnable3","net");%>' />
            	<input type="text" name="RoiTop3" id="jsRoi3Top" value='<%RoiAreaGet("RoiTop3","net");%>' />
          		<input type="text" name="RoiBottom3" id="jsRoi3Bottom" value='<%RoiAreaGet("RoiBottom3","net");%>' />
            	<input type="text" name="RoiLeft3" id="jsRoi3Left" value='<%RoiAreaGet("RoiLeft3","net");%>' />
            	<input type="text" name="RoiRight3" id="jsRoi3Right" value='<%RoiAreaGet("RoiRight3","net");%>' />
            	<input type="text" name="Roi3Level_" id="jsRoi3Level_" value='<%RoiAreaGet("RoiLevel3","net");%>' />
        	</div>
        	<div class="areaSetContain">
        		<div class="areaSetTop">
	        		<input type="button" class="dragBegin" value="Draw" id="jsRoi3Drag" onclick="roiAreaAdd(3); roiAreaDrag(3); roiOperateLimit(3)" />
    	        	<label class="areaName" id="jsRoi3LevelLab">Level:&nbsp;</label>
                        <select class="areaNinput" style="width:80px" name="Roi3Level" id="jsRoi3Level">
                        	<option value="0">Low</option>
                        	<option value="1">Middle</option>
                        	<option value="2">High</option>
                        </select>
            	</div>
            	<div class="areaSetBottom">
                	<div class="sensDiv">&nbsp;</div>
                 	<input type="button" value="Save" id="jsRoi3Sub" onclick="roiAreaGet(3);roiAreaSub(3);roiOperateRes();saveNotice()" />
                	<input type="button" value="Cancel" id="jsRoi3Res" onclick="roiAreaReset(3);roiOperateRes()" />
            	</div>
        	</div>
        </form>
    </div>
	<div class="areaSet">
		<div class="areaSetName">
    		<label id="jsRoi4Lab" class="tahoma" for="jsRoi4Checkbox">Zone 4:</label>
        	<input type="checkbox" value="1" id="jsRoi4Checkbox" onclick="roiAreaEnable(4)" />
    	</div>
        <form class="clearSpace" method="post" name="RoiForm" id="RoiForm4" action="/form/RoiAreaSet" target="hideFrame">
        	<div style="display:none">
            	<input type="text" name="flag" value="4" />
        		<input type="text" name="RoiEnable4" id="jsRoi4Active" value='<%RoiAreaGet("RoiEnable4","net");%>' />
            	<input type="text" name="RoiTop4" id="jsRoi4Top" value='<%RoiAreaGet("RoiTop4","net");%>' />
          		<input type="text" name="RoiBottom4" id="jsRoi4Bottom" value='<%RoiAreaGet("RoiBottom4","net");%>' />
            	<input type="text" name="RoiLeft4" id="jsRoi4Left" value='<%RoiAreaGet("RoiLeft4","net");%>' />
            	<input type="text" name="RoiRight4" id="jsRoi4Right" value='<%RoiAreaGet("RoiRight4","net");%>' />
            	<input type="text" name="Roi4Level_" id="jsRoi4Level_" value='<%RoiAreaGet("RoiLevel4","net");%>' />
        	</div>
        	<div class="areaSetContain">
        		<div class="areaSetTop">
	        		<input type="button" class="dragBegin" value="Draw" id="jsRoi4Drag" onclick="roiAreaAdd(4); roiAreaDrag(4); roiOperateLimit(4)" />
    	        	<label class="areaName" id="jsRoi4LevelLab">Level:&nbsp;</label>
                        <select class="areaNinput" style="width:80px" name="Roi4Level" id="jsRoi4Level">
                        	<option value="0">Low</option>
                        	<option value="1">Middle</option>
                        	<option value="2">High</option>
                        </select>
            	</div>
            	<div class="areaSetBottom">
                	<div class="sensDiv">&nbsp;</div>
                 	<input type="button" value="Save" id="jsRoi4Sub" onclick="roiAreaGet(4);roiAreaSub(4);roiOperateRes();saveNotice()" />
                	<input type="button" value="Cancel" id="jsRoi4Res" onclick="roiAreaReset(4);roiOperateRes()" />
            	</div>
        	</div>
        </form>
    </div>
</div>

<div class="videoClass">
	<div class="filePath">
    	<form class="clearSpace" id="pathSetForm" method="post" action="/form/IVPathSet" target="hideFrame">
        	<input type="hidden" name="language" value="cn" /><input type="hidden" id="jsPathSetFlag" name="flag" value="1" />
            <div class="shotPath" style="margin-left:2px">
        		<label style="width:190px; margin-top:2px">Photo saving path:&nbsp;</label>
            	<input class="shotPathInput" type="text" name="imagepath" id="jsShotPath" maxlength="300" value='<%IVPathGet("imagepath","net");%>' readonly="readonly" />
                <input class="shotPathbto" type="button" value="Browse..." onclick="getShotPath()" />
            </div>
            <div class="shotPath" style="margin-left:2px">
            	<input type="hidden" id="ImageTypeGet" value='<%IVPathGet("imageType","net");%>' />
            	<label style="width:190px; margin-top:2px">Format:&nbsp;</label>
                <select name="imageType" id="jsImageType">
                	<option value="0"> .jpg</option>
                    <option value="1"> .bmp</option>
            	</select>
            </div>
            <div class="shotPath" style="margin-left:2px">
            	<label style="width:190px; margin-top:2px">Video saving path:&nbsp;</label>
            	<input class="shotPathInput" type="text" name="videopath" id="jsRecordPath" maxlength="300" value='<%IVPathGet("videopath","net");%>' readonly="readonly" />
                <input class="shotPathbto" type="button" value="Browse..." onclick="getRecordPath()" />
            </div>
            <div class="shotPath" style="margin-left:2px">
            	<input type="hidden" id="VideoTypeGet" value='<%IVPathGet("videoType","net");%>'/>
            	<label style="width:190px; margin-top:2px">Format:&nbsp;</label>
                <select name="videoType" id="jsVideoType">
                	<option value="0"> .avi</option>
                    <option value="1"> .ifv</option>
            	</select>
            </div>
            <br />
            <input type="button" value="Save" onclick="pathSubmit('pathSetForm')" class="ButtonRight" style="margin-left:415px; margin-top: 25px"/>
        </form>
    </div>
</div>

<div class="videoClass">
	<div class="audioParaClass">
    	<form class="clearSpace" id="audioInfoForm" method="post" action="/form/audioparaSet" target="hideFrame">
            <input type="hidden" id="AudioSwitch" value='<%audioparaGet("AudioOnOff","net");%>' />
            <input type="hidden" id="AudioType" value='<%audioparaGet("AudioFormat","net");%>' />
            <input type="hidden" id="AudioINPUT_" value='<%audioparaGet("AudioInput","net");%>' />
			<label style="width:100px">Switch:</label>
           	<select name="AudioOnOff" id="jsAudioOnOff" style="width:60px;" onChange="document.getElementById('audioInfoForm').submit()">
				<option value="0">Off</option>
				<option value="1">On</option>
			</select>
            <br />
        	<label style="width:100px">SampleRate:&nbsp;</label><label>&nbsp;8K</label>
            <br />
            <label style="width:100px">Format:&nbsp;</label><!--<label>G711-U</label>-->
            <select name="AudioFormat" id="jsAudioFormat" style="width:75px;" onChange="document.getElementById('audioInfoForm').submit()">
				<option value="0">G711-U</option>
				<option value="1">G711-A</option>
				<option value="2">PCM</option>
				<option value="3">G726</option>
				<option value="4">AAC</option>
			</select>
            <br />
            <label style="width:100px">InputVolume:&nbsp;</label><!--<label>G711-U</label>-->
            <select name="AudioInput" id="jsAudioInput" style="width:75px;" onChange="document.getElementById('audioInfoForm').submit()">
				<option value="0">1</option>
                <option value="1">2</option>
                <option value="2">3</option>
                <option value="3">4</option>
                <option value="4">5</option>
                <option value="5">6</option>
                <option value="6">7</option>
                <option value="7">8</option>
                <option value="8">9</option>
                <option value="9">10</option>
			</select>
           <br />
			<label style="width:400px">Note: Audio config will take effect after reboot.</label>
		</form>
   </div>
</div>

<div class="videoClass">
	<input type="hidden" id="motionSwitchGet" value='<%Getalarmpara("MotionSwitch","net");%>' />
	<div class="areaSet">
		<div class="areaSetName">
    		<label id="jsMotion1Lab" for="jsMotion1Checkbox">Zone 1:</label>
        	<input type="checkbox" value="1" id="jsMotion1Checkbox" onclick="motionAreaEnable(1)" />
    	</div>
        <form class="clearSpace" method="post" name="MotionForm" id="MotionForm1" action="/form/Setalarmpara" target="hideFrame">
        	<div style="display:none">
            	<input type="text" name="flag" value="1" />
        		<input type="text" name="DetectEnable1" id="jsMotion1Active" value='<%Getalarmpara("DetectEnable1","net");%>' />
            	<input type="text" name="MTop1" id="jsMotion1Top" value='<%Getalarmpara("MTop1","net");%>' />
          		<input type="text" name="MBottom1" id="jsMotion1Bottom" value='<%Getalarmpara("MBottom1","net");%>' />
            	<input type="text" name="MLeft1" id="jsMotion1Left" value='<%Getalarmpara("MLeft1","net");%>' />
            	<input type="text" name="MRight1" id="jsMotion1Right" value='<%Getalarmpara("MRight1","net");%>' />
            	<input type="text" name="MSensitivity1" id="jsMotion1Sens" value='<%Getalarmpara("MSensitivity1","net");%>' />
                <input type="text" id="jsMotion1Sback" />
        	</div>
        	<div class="areaSetContain">
        		<div class="areaSetTop">
	        		<input type="button" class="dragBegin" value="Draw" id="jsMotion1Drag" onclick="motionAreaDrag(1); motionOperateLimit(1);" />
    	        	<label class="areaName" id="jsMotion1NameLab">Name:&nbsp;</label>
                    	<input type="hidden" id="jsMotion1Nback" />
        	    		<input class="areaNameInput" type="text" name="MName1" id="jsMotion1Name" maxlength="63" value='<%Getalarmpara("MName1","net");%>   ' onfocus="OBJfocus('jsMotion1Name', 'M1Label', 63)" onblur="OBJblur()" />
                        <label class="lenLabel" id="M1Label">!</label>
            	</div>
            	<div class="areaSetBottom">
                	<div class="sensDiv">
	            		<label class="motionSenstive" id="jsMotion1SensLab">Sensitivity:&nbsp;</label>
    	        		<label id="jsMotion1SensLabel" class="sensLabel">99</label>
                        <div class="slider" id="jsSens1"></div>
        	    		<label class="sensExplain">(Most sensitive)</label>
                    </div>
                 	<input type="button" value="Save" id="jsMotion1Sub" disabled="disabled" onclick="motionAreaGet(1);motionAreaSub(1);motionOperateRes();saveNotice()" />
                	<input type="button" value="Cancel" id="jsMotion1Res" disabled="disabled" onclick="motionAreaReset(1);motionOperateRes()" />
            	</div>
        	</div>
        </form>
    </div>
    <div class="areaSet">
		<div class="areaSetName">
    		<label id="jsMotion2Lab" for="jsMotion2Checkbox">Zone 2:</label>
        	<input type="checkbox" value="2" id="jsMotion2Checkbox" onclick="motionAreaEnable(2)"/>
    	</div>
        <form class="clearSpace" method="post" name="MotionForm" id="MotionForm2" action="/form/Setalarmpara" target="hideFrame">
        	<div style="display:none">
            	<input type="text" name="flag" value="2" />
        		<input type="text" name="DetectEnable2" id="jsMotion2Active" value='<%Getalarmpara("DetectEnable2","net");%>' />
            	<input type="text" name="MTop2" id="jsMotion2Top" value='<%Getalarmpara("MTop2","net");%>' />
          		<input type="text" name="MBottom2" id="jsMotion2Bottom" value='<%Getalarmpara("MBottom2","net");%>' />
            	<input type="text" name="MLeft2" id="jsMotion2Left" value='<%Getalarmpara("MLeft2","net");%>' />
            	<input type="text" name="MRight2" id="jsMotion2Right" value='<%Getalarmpara("MRight2","net");%>' />
            	<input type="text" name="MSensitivity2" id="jsMotion2Sens" value='<%Getalarmpara("MSensitivity2","net");%>' />
                <input type="text" id="jsMotion2Sback" />
        	</div>
        	<div class="areaSetContain">
        		<div class="areaSetTop">
	        		<input type="button" class="dragBegin" value="Draw" id="jsMotion2Drag" onclick="motionAreaDrag(2); motionOperateLimit(2);" />
    	        	<label class="areaName" id="jsMotion2NameLab">Name:&nbsp;</label>
                    	<input type="hidden" id="jsMotion2Nback" />
        	    		<input class="areaNameInput" type="text" name="MName2" id="jsMotion2Name" maxlength="63" value='<%Getalarmpara("MName2","net");%>   ' onfocus="OBJfocus('jsMotion2Name', 'M2Label', 63)" onblur="OBJblur()" />
                        <label class="lenLabel" id="M2Label">!</label>
            	</div>
            	<div class="areaSetBottom">
                	<div class="sensDiv">
	            		<label class="motionSenstive" id="jsMotion2SensLab">Sensitivity:</label>
    	        		<label id="jsMotion2SensLabel" class="sensLabel">99</label>
                        <div class="slider" id="jsSens2"></div>
        	    		<label class="sensExplain">(Most sensitive)</label>
                    </div>
            		<input type="button" value="Save" id="jsMotion2Sub" disabled="disabled" onclick="motionAreaGet(2);motionAreaSub(2);motionOperateRes();saveNotice()" />
                	<input type="button" value="Cancel" id="jsMotion2Res" disabled="disabled" onclick="motionAreaReset(2);motionOperateRes()" />
            	</div>
        	</div>
        </form>
    </div>
    <div class="areaSet">
		<div class="areaSetName">
    		<label id="jsMotion3Lab" for="jsMotion3Checkbox">Zone 3:</label>
        	<input type="checkbox" value="3" id="jsMotion3Checkbox" onclick="motionAreaEnable(3)" />
    	</div>
        <form class="clearSpace" method="post" name="MotionForm" id="MotionForm3" action="/form/Setalarmpara" target="hideFrame">
        	<div style="display:none">
            	<input type="text" name="flag" value="3" />
        		<input type="text" name="DetectEnable3" id="jsMotion3Active" value='<%Getalarmpara("DetectEnable3","net");%>' />
            	<input type="text" name="MTop3" id="jsMotion3Top" value='<%Getalarmpara("MTop3","net");%>' />
          		<input type="text" name="MBottom3" id="jsMotion3Bottom" value='<%Getalarmpara("MBottom3","net");%>' />
            	<input type="text" name="MLeft3" id="jsMotion3Left" value='<%Getalarmpara("MLeft3","net");%>' />
            	<input type="text" name="MRight3" id="jsMotion3Right" value='<%Getalarmpara("MRight3","net");%>' />
            	<input type="text" name="MSensitivity3" id="jsMotion3Sens" value='<%Getalarmpara("MSensitivity3","net");%>' />
                <input type="text" id="jsMotion3Sback" />
        	</div>
       		<div class="areaSetContain">
        		<div class="areaSetTop">
        		  <input type="button" class="dragBegin" id="jsMotion3Drag" value="Draw" onclick="motionAreaDrag(3); motionOperateLimit(3);" />
        		  <label class="areaName" id="jsMotion3NameLab">Name:&nbsp;</label>
                    	<input type="hidden" id="jsMotion3Nback" />
        	    		<input class="areaNameInput" type="text" name="MName3" id="jsMotion3Name" maxlength="63" value='<%Getalarmpara("MName3","net");%>   ' onfocus="OBJfocus('jsMotion3Name', 'M3Label', 63)" onblur="OBJblur()" />
                        <label class="lenLabel" id="M3Label">!</label>
           	  </div>
            	<div class="areaSetBottom">
                	<div class="sensDiv">
	            		<label class="motionSenstive" id="jsMotion3SensLab">Sensitivity:</label>
    	        		<label id="jsMotion3SensLabel" class="sensLabel">99</label>
                        <div class="slider" id="jsSens3"></div>
         		   		<label class="sensExplain">(Most sensitive)</label>
                    </div>
            		<input type="button" value="Save" id="jsMotion3Sub" disabled="disabled" onclick="motionAreaGet(3);motionAreaSub(3);motionOperateRes();saveNotice()" />
                	<input type="button" value="Cancel" id="jsMotion3Res" disabled="disabled" onclick="motionAreaReset(3);motionOperateRes()" />
           	 	</div>
        	</div>
        </form>
    </div>
    <div class="areaSet">
		<div class="areaSetName">
    		<label id="jsMotion4Lab" for="jsMotion4Checkbox">Zone 4:</label>
        	<input type="checkbox" value="4" id="jsMotion4Checkbox" onclick="motionAreaEnable(4)" />
    	</div>
        <form class="clearSpace" method="post" name="MotionForm" id="MotionForm4" action="/form/Setalarmpara" target="hideFrame">
        	<div style="display:none">
            	<input type="text" name="flag" value="4" />
        		<input type="text" name="DetectEnable4" id="jsMotion4Active" value='<%Getalarmpara("DetectEnable4","net");%>' />
            	<input type="text" name="MTop4" id="jsMotion4Top" value='<%Getalarmpara("MTop4","net");%>' />
          		<input type="text" name="MBottom4" id="jsMotion4Bottom" value='<%Getalarmpara("MBottom4","net");%>' />
            	<input type="text" name="MLeft4" id="jsMotion4Left" value='<%Getalarmpara("MLeft4","net");%>' />
            	<input type="text" name="MRight4" id="jsMotion4Right" value='<%Getalarmpara("MRight4","net");%>' />
            	<input type="text" name="MSensitivity4" id="jsMotion4Sens" value='<%Getalarmpara("MSensitivity4","net");%>' />
                <input type="text" id="jsMotion4Sback" />
        	</div>
        	<div class="areaSetContain">
        		<div class="areaSetTop">
	        		<input type="button" class="dragBegin" value="Draw" id="jsMotion4Drag" onclick="motionAreaDrag(4); motionOperateLimit(4);" />
    	        	<label class="areaName" id="jsMotion4NameLab">Name:&nbsp;</label>
                    	<input type="hidden" id="jsMotion4Nback" />
        	    		<input class="areaNameInput" type="text" name="MName4" id="jsMotion4Name" maxlength="63" value='<%Getalarmpara("MName4","net");%>   ' onfocus="OBJfocus('jsMotion4Name', 'M4Label', 63)" onblur="OBJblur()" />
                        <label class="lenLabel" id="M4Label">!</label>
            	</div>
            	<div class="areaSetBottom">
                	<div class="sensDiv">
	            		<label class="motionSenstive" id="jsMotion4SensLab">Sensitivity:</label>
    	        		<label id="jsMotion4SensLabel" class="sensLabel">99</label>
                        <div class="slider" id="jsSens4"></div>
        	    		<label class="sensExplain">(Most sensitive)</label>
                    </div>
            		<input type="button" value="Save" id="jsMotion4Sub" disabled="disabled" onclick="motionAreaGet(4);motionAreaSub(4);motionOperateRes();saveNotice()" />
                	<input type="button" value="Cancel" id="jsMotion4Res" disabled="disabled" onclick="motionAreaReset(4);motionOperateRes()" />
            	</div>
        	</div>
        </form>
    </div>    
</div>
<script type="text/javascript">
	var DragObj = new Slider();
	DragObj.imgSet('../images/minus.gif', '../images/plus.gif', '../images/slider_handle_new.gif','../images/slope.gif');
	DragObj.creat("jsSens1","jsMotion1Sens","jsMotion1SensLabel", 0, 100);
	DragObj.creat("jsSens2","jsMotion2Sens","jsMotion2SensLabel", 0, 100);
	DragObj.creat("jsSens3","jsMotion3Sens","jsMotion3SensLabel", 0, 100);
	DragObj.creat("jsSens4","jsMotion4Sens","jsMotion4SensLabel", 0, 100);
	DragObj.creat("jsSens5","jsMotion5Sens","jsMotion5SensLabel", 0, 100);
</script>
</body>
</html>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link type="text/css" rel="stylesheet" href="../css/ytSet.css" />
<script type="text/javascript" src="../javascript/jquery.js"></script>
<script type="text/javascript" src="../javascript/cookie.js"></script>
<script type="text/javascript" src="../javascript/common.js"></script>
<script type="text/javascript" src="../javascript/videoset.js"/></script>
<script type="text/javascript" src="../javascript/videosave.js"/></script>
<script type="text/javascript" src="../javascript/domset.js"></script>
<script type="text/javascript" src="../javascript/jQueryPie.js"></script>
<script type="text/javascript">
window.onload = function(){
	set_height_width_camera();
	ytInit();
	sysShow('hankYunTai',5);
	nomalUserInit();
	try{
		document.execCommand('BackgroundImageCache', false, true);
    }catch(e){};
}
window.onbeforeunload = function(){
	if(IsSuperUser())
	{
		//autopanSubmit(7);
		//patternSubmit(4);
		//maskSubmit(7);
	}	
}
</script>
</head>

<body onUnload="Unload();">
<input type="hidden" id="PAGE_LANGUAGE" name="language" value="0" />
<iframe name="hideframe" id="hideframe" style=" display:none"></iframe>

<div class="topMenu">
	<ul style="width:1550px">
        <li class="choose" onclick="sysShow('hankYunTai',0)" style="display:block;">Preset</li>
        <li class="choose" onclick="sysShow('hankYunTai',1)" style="display:none;">Auto Pan</li>
        <li class="choose" onclick="sysShow('hankYunTai',2)" style="display:none;">Pattern</li>
        <li class="choose" onclick="sysShow('hankYunTai',3)" style="display:none">Home return</li>
        <li class="choose" onclick="sysShow('hankYunTai',4);loadAtpParas()" style="display:block;">Auto tour</li>
        <li class="choose" onclick="sysShow('hankYunTai',5)">PTZ protocol</li>
        <li class="choose" onclick="sysShow('hankYunTai',6)" style="display:none;">Transparent serial</li>
    </ul>
</div>
<div class="ptzFunWin">
	<div class="playerWin" id="videoWin">
		<script language="javascript" src="../javascript/browseEm.js"></script>
    </div>
	
    <div class="ptzWin">
<!--PTZ Panel    -->
			<div class="ptzDiv" align="center">
				<form name="PTZForm" id="PTZForm" method="get" action="/form/setPTZCfg" target="hideframe" >
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
        			<div class="picRowTest">Iris</div>
     			</div>
      
      			<div class="picRow">
      				<div id="focusNear" class="picRowLeft"></div>
        			<div id="focusFar" class="picRowRight"></div>
        			<div class="picRowTest">Focus</div>
      			</div>
      
      			<div class="picRow">
      				<div id="zoomOut" class="picRowLeft"></div>
        			<div id="zoomIn" class="picRowRight"></div>
        			<div class="picRowTest">Zoom</div>
      			</div>
      			<br />
      			<div class="ptzRow">
      				<div class="ptzSelectLaben"><label>Pan speed</label></div>
      				<select name="panSpeed" id="jsPanSpeed" onchange="submitFun(52,'jsPanSpeed','PTSpeed','PTZForm')">
           				<option value="1">1</option>
           				<option value="2">2</option>
          			 	<option value="3">3</option>
           				<option value="4">4</option>
           				<option value="5">5</option>
           				<option value="6">6</option>
           				<option value="7">7</option>
           				<option value="8">8</option>
	    			</select>
      			</div>
      		<div class="ptzRow">
      			<div class="ptzSelectLaben"><label>Tilt speed</label></div>
        		<select name="tiltSpeed" id="jsTiltSpeed" onchange="submitFun(53,'jsTiltSpeed','PTSpeed','PTZForm');">
               		<option value="1">1</option>
              		<option value="2">2</option>
               		<option value="3">3</option>
               		<option value="4">4</option>
               		<option value="5">5</option>
               		<option value="6">6</option>
               		<option value="7">7</option>
               		<option value="8">8</option>
         		</select>
      		</div>
    	</form>
  		</div>
    </div>
</div>

<div class="hankYunTai">
	<form id="posHankForm" method="post" action="/form/presetSet" target="hideframe">
    	<input type="hidden" name="flag" id="jsPresetFlag" />
        <input type="hidden" name="existFlag" id="jsPresetExist" />
		<input type="hidden" name="language" value="en" />
		<div class="posHank">
    		<label>No.:&nbsp;</label>
        	<select name="presetNum" id="jsPresetNum" onchange="ajaxHankGet('/form/presetAjax','posHankForm','jsPresetNum')">
        	</select>
    	</div>
    	<div class="posHank" style="position:relative">
    		<label style="margin-top:2px;">Title:&nbsp;</label>
        	<input type="text" id="jsPresetName" name="presetName" maxlength="16" class="titleText" />
        	<input class="titleSave" type="button" value="Save" onclick="presetSubmit(2)" />
    	</div>
    	<br />
        <br />
    	<div class="posHank">
			<input class="posBto" type="button" value="Set" onclick="presetSubmit(3);" />
        	<input class="posBto" type="button" value="Call" onclick="presetSubmit(4)" />
        	<input class="posBto" type="button" value="Delete" onclick="presetSubmit(5);" />
        	<input class="posBto" type="button" value="Delete all" onclick="presetSubmit(6);" style="display:none" />
    	</div>
    </form>
</div>

<div class="hankYunTai">
	<form id="autopanForm" method="post" action="/form/setSpecialFunc" target="hideframe">
    	<!--<div class="horiHank" style="display:none">
        	<input type="hidden" name="flag" id="jsAutopanFlag" />
        	<input type="hidden" name="existFlag" id="jsAutopanExist" />
			<input type="hidden" name="language" value="en" />
        	<label>NO.:&nbsp;</label>
            <select id="jsAutopanNum" name="autopanNum" onchange="ajaxHankGet('/form/autopanAjax','autopanForm','jsAutopanNum');">
            	<option value="0">1</option>
                <option value="1">2</option>
                <option value="2">3</option>
                <option value="3">4</option>
            </select>
        </div>
        <div class="horiHank" style="display:none">
        	<label>Direction:&nbsp;</label>
            <select id="jsAutopanDir" name="AutopanDir" onchange="autopanSubmit(2)">
            	<option value="0">Right</option>
                <option value="1">Left</option>
            </select>
        </div>
        <div class="horiHank" style="display:none">
        	<label>Speed:&nbsp;</label>
            <select id="jsAutopanSpd" name="AutopanSpd" onchange="autopanSubmit(3)">
            </select>
        </div>
        <div class="horiHank" style="display:none">
        	<label>Delay time:&nbsp;</label>
            <select id="jsAutopanDelaytime" name="AutopanDelaytime" onchange="autopanSubmit(4)">
            </select>
        </div>-->
        <!--<div class="horiHank" style="position:relative">
    		<label style="margin-top:2px;">Title:&nbsp;</label>
        	<input type="text" id="jsAutopanName" name="AutopanTitle" maxlength="16" class="titleText" />
        	<input type="button" value="Save" class="titleSave" onclick="autopanSubmit(5)" />
    	</div>-->
        <br />
        <br />
        <div class="horiHank" style="margin-left:170px">
        	<input type="hidden" name="flag" id="jsAutopanFlag" />
			<input type="hidden" name="language" value="en" />
        	<input class="posBto" type="button" id="jsAutoPanCall" value="Call" onclick="callAtp()" />
        </div>
        <!--<div class="horiHank">
			<input class="posBto" type="button" id="jsAutoPanStart" value="Start" onclick="autopanSubmit(6);" />
    		<input class="posBto" type="button" id="jsAutoPanStop" value="End" onclick="autopanSubmit(7);" style="display:none;background-image:url(../images/savaSet_red.gif)"  />
        	<input class="posBto" type="button" id="jsAutoPanCall" value="Call" onclick="autopanSubmit(8)" />
        	<input class="posBto" type="button"  id="jsAutoPanDel" value="Delete" onclick="autopanSubmit(9);" />
        	<input class="posBto" type="button" id="jsAutoPanDelAll" value="Delete all" onclick="autopanSubmit(10);" />
    	</div>-->
    </form>
</div>

<div class="hankYunTai">
	<form id="patternForm" method="post" action="/form/setSpecialFunc" target="hideframe">
    	<!--<div class="posHank" style="display:none">
       		<input type="hidden" name="flag" id="jspatternFlag" />
        	<input type="hidden" name="existFlag" id="jspatternExist" />
			<input type="hidden" name="language" value="en" />
    		<label>NO.:&nbsp;</label>
        	<select id="jsPatternNum" name="patternNum" onchange="ajaxHankGet('/form/patternAjax','patternForm','jsPatternNum')">
        		<option value="0">1</option>
            	<option value="1">2</option>
            	<option value="2">3</option>
            	<option value="3">4</option>
        	</select>
    	</div>
    	<div class="posHank" style="position:relative;display:none">
    		<label style="margin-top:2px;">Title:&nbsp;</label>
        	<input type="text" id="jsPatternName" name="Patterntitle" maxlength="16" class="titleText" />
        	<input class="titleSave" type="button" id="jsPatternSvNm" value="Save" onclick="patternSubmit(2)" />
    	</div>-->
        <br />
        <br />
        <div class="posHank" style="margin-left:170px">
        	<input type="hidden" name="flag" id="jspatternFlag" />
			<input type="hidden" name="language" value="en" />
        	<input class="posBto" type="button" value="Call" id="jsPatternRun" onclick="patternSubmit(5);" />
        </div>
    	<!--<div class="posHank">
        	<input class="posBto" type="button" value="Start" id="jsPatternStart" onclick="patternSubmit(3);" />
    		<input class="posBto" type="button" value="End" id="jsPatternStop" onclick="patternSubmit(4);" style="display:none;background-image:url(../images/savaSet_red.gif)" />
        	<input class="posBto" type="button" value="Call" id="jsPatternRun" onclick="patternSubmit(5);" />
        	<input class="posBto" type="button" value="Delete" id="jsPatternDel" onclick="patternSubmit(6);" />
        	<input class="posBto" type="button" value="Delete all" id="jsPatternDelAll" onclick="patternSubmit(7);" style="display:none" />
    	</div>-->
    </form>
</div>

<div class="hankYunTai">
	<form id="autoBackForm" method="post" action="/form/autoBackSet" target="hideframe">
			<input type="hidden" id="autoBackActGet" value=''  />
			<input type="hidden" id="autoBackPwOffGet" value=''  />
			<input type="hidden" id="autoBackTimeGet" value=''  />
		    <div class="autoBack">
        	<label>Return time:&nbsp;</label>
            <select name="autoBackTime" id="jsAutoBackTime">
            	<option value="0">Off</option>
                <option value="5">5S</option>
                <option value="10">10S</option>
                <option value="20">20S</option>
                <option value="40">40S</option>
                <option value="60">1M</option>
                <option value="300">5M</option>
                <option value="600">10M</option>
                <option value="1200">20M</option>
                <option value="2400">40M</option>
                <option value="3600">1H</option>
            </select>
      </div>
        <div class="autoBack">
        
        	<label>Action:&nbsp;</label>
            <select name="autoBackAct" id="jsAutoBackAct"></select>
        </div>
        <div class="autoBack">

        	<label>Power off save:&nbsp;</label>
            <select name="autoBackPwOff" id="jsAutoBackPwOff">
            	<option value="0">Off</option>
                <option value="1">On</option>
            </select>
        </div>
        <br />
        <input class="posBto" type="button" value="Save" onclick="ajaxPost('autoBackForm')" style="margin-left:100px;" />
    </form>
</div>

<div class="hankYunTai">
	<form id="tourForm" method="post" action="/form/tourSet" target="hideframe">
    	<input type="hidden" name="flag" id="jsTourFlag" />
        <input type="hidden" name="existFlag" id="jsTourExist" />
		<input type="hidden" name="language" value="en" />
		<div class="posHank">
    		<label>Tour No:&nbsp;</label>
        	<select name="tourNum" id="jsTourNum" onchange="ajaxHankGet('/form/tourAjax','tourForm','jsTourNum')">
            	<option value="0">1</option>
                <option value="1">2</option>
                <option value="2">3</option>
        	</select>
    	</div>
    	<!--<div class="posHank" style="position:relative">
    		<label>Action No:&nbsp;</label>
        	<input type="text" id="jsPresetValue" name="presetValue"  class="titleText" maxlength="3" />
    	</div>
     	<div class="posHank" style="position:relative">
    		<label>Delay Interval(s):&nbsp;</label>
        	<input type="text" id="jsStayInterval" name="StayInterval"  class="titleText" maxlength="3" />
    	</div>
    	<div class="posHank" style="position:relative">
    		<label>Max Tour Time(h):&nbsp;</label>
        	<input type="text" id="jsTourMaxTime" name="TourMaxTime"  class="titleText" maxlength="3" />
    	</div>-->
   	<br />
        <br />
    	<div class="patrol" style="margin-left:20px">
      		<!--<input class="posBto" type="button" value="Save" onclick="tourSubmit(1)" />
        	<!--<input class="posBto" type="button" value="Set" onclick="tourSubmit(1)" />-->
            <input class="posBto" style="margin-left:30px" type="button" value="Call" onclick="tourSubmit(2)" />
        	<!--<input class="posBto" type="button" value="Delete Preset" onclick="tourSubmit(5)" />
        	<input class="posBto" type="button" value="Stop" onclick="tourSubmit(0)" />
        	<input class="posBto" type="button" value="Clear" onclick="tourSubmit(3)" />
            <br />
            <br />
        	<input class="posBto" type="button" value="Pan Tour" onclick="tourSubmit(6)" />
        	<input class="posBto" type="button" value="Tilte Tour" onclick="tourSubmit(7)" />
        	<input class="posBto" type="button" value="Limit Set" onclick="tourSubmit(8)" />-->
      	</div>
        
        <!--<div class="posHank">
    		<label>Tour NO:&nbsp;</label>
        	<select name="tourNum" id="jsTourNum" onchange="ajaxHankGet('/form/tourAjax','tourForm','jsTourNum')">
            	<option value="0">1</option>
                <option value="1">2</option>
                <option value="2">3</option>
                <option value="3">4</option>
                <option value="4">5</option>
                <option value="5">6</option>
                <option value="6">7</option>
        	</select>
    	</div>
    	<div class="posHank">
    		<label>Preset NO:&nbsp;</label>
        	<select id="jsPstNumber" name="presetNumber"></select>
    	</div>
        <div class="posHank">
    		<label>Delay Time:</label>
        	<select id="jsDelayTour" name="delayTour"></select>
    	</div>
    	<br />
        <br />
    	<div class="patrol">
      		<input class="posBto" type="button" value="Add preset" onclick="tourSubmit(3)" />
        	<input class="posBto" type="button" value="Move preset" onclick="tourSubmit(4)" />
            <input class="posBto" type="button" value="Clear tour" onclick="tourSubmit(5)" />
        	<input class="posBto" type="button" value="Call tour" onclick="tourSubmit(6)" />
      	</div>-->
    </form>
</div>

<div class="hankYunTai">
<form id="ptzSpecialForm" name="ptzSpecialForm" target="hideframe" method="post" action="/form/Set485Cfg">
<input type="hidden" name="flag" id="PTZSpecialFlag" value="0" />
<input type="hidden" id="cameraAddr_ws" value='<%Get485Cfg("address_","net");%>' />
<input type="hidden" id="protocol_ws" value='<%Get485Cfg("protocol_","net");%>' />
<input type="hidden" id="baudRate_ws" value='<%Get485Cfg("baudRate_","net");%>' />
<input type="hidden" id="protocol3D_ws" value='<%Get485Cfg("protocol3DType_","net");%>' />
<input type="hidden" id="userMode_ws" value='<%Get485Cfg("userMode_","net");%>' />
	<div class="LaserPara">
		<label>Address:</label>
		<select name="cameraAddr" id="cameraAddr"  onChange="ptzSpecialSubmit(1);">	
		</select>
	</div>
	
	<div class="LaserPara">
		<label>Protocol:</label>
		<select name="protocol" id="protocol"  onChange="ptzSpecialSubmit(2);">	         
			<option value="pelco-d">Pelco-D</option>
			<option value="pelco-p">Pelco-P</option>
			<option value="samsung">Samsung</option>
		</select>
	</div>
	<div class="LaserPara">
		<label>Baud rate:</label>
		<select name="baudRate" id="baudRate"  onChange="ptzSpecialSubmit(3);">	 
			<option value="0">2400</option>
			<option value="1">4800</option>
			<option value="2">9600</option>
            <option value="3">19200</option>
            <option value="4">38400</option>
            <option value="5">57600</option>
		</select>
	</div>
    <div class="LaserPara">
		<label>3D Protocol：</label>
		<select name="protocol3D" id="protocol3D"  onChange="ptzSpecialSubmit(4);">	         
			<option value="0">Pelco-DH</option>
			<option value="1">Pelco-HK</option>
		</select>
	</div>
    <div class="LaserPara">
		<label>User mode：</label>
		<select name="userMode" id="userMode"  onChange="ptzSpecialSubmit(5);">	         
			<option value="0">Commom</option>
			<option value="1">HK-TST</option>
            <option value="2">MILESTONE</option>
            <option value="3">JNVR</option>
		</select>
	</div>
</form>
</div>
    
<div class="hankYunTai">
<form id="rs485transEnableFrom" name="rs485transEnableFrom" target="hideframe" method="post" action="/form/Set485Cfg">
	<input type="hidden" name="flag" id="PTZSpecialFlag" value="6" />
	<input type="hidden" id="rs485transEnable_ws" value='<%Get485Cfg("transparantEnable","net");%>' />
	<label style="line-height:40px">Transparent serial：</label>
    <select style="width:120px" name="rs485transEnable" id="rs485transEnable"  onChange="document.getElementById('rs485transEnableFrom').submit()">	
		<option value="0">Off</option>
		<option value="1">On</option>
	</select>
</form>
	<label style="line-height:40px" class="ptzRow">Transmit data:</label>
    <p>
	<form id="rs485transForm" name="rs485transForm" target="hideframe" method="post" action="/form/rs485Send">
		<input class="posBto" type="button" id="rs485send" value="send" onclick="rs485trans_send();" />
        <textarea id="sendtext" name="sendtext" rows="4" cols="60"></textarea>
	</form>
    </p>
    <p>
	<form id="rs485recvForm" name="rs485recvForm" target="hideframe" method="post" action="/form/rs485Read">
		<input class="posBto" type="button" id="rs485recv" value="receive" onclick="rs485trans_recv();" />
        <textarea id="recvtext" readonly="readonly" rows="4" cols="60"></textarea>
    </form>
	</p>
</div>
<script type="text/javascript" src="../javascript/PTZInitL.js"></script>
</body>
</html>

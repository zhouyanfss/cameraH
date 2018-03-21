<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="../css/sysInf.css" rel="stylesheet" type="text/css" />
<link href="../css/videoAudioSet.css" rel="stylesheet" type="text/css" />
<link href="../css/cameraSet.css" rel="stylesheet" type="text/css" />
<link href="../css/slider.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="../javascript/jquery.js"></script>
<script type="text/javascript" src="../javascript/common.js"></script>
<script type="text/javascript" src="../javascript/slider.js"></script>
<script type="text/javascript" src="../javascript/dragLine_new.js"></script>
<script type="text/javascript" src="../javascript/Intelligent.js"></script>
<script type="text/javascript" src="../javascript/jQueryPie.js"></script>
<script type="text/javascript">
window.onload=function(){
	refreshPlayer();
	Intelligent_Init();
}
</script>
</head>

<body>
<input type="hidden" id="PAGE_LANGUAGE" value="0" />
<input type="hidden" id="ICEtype" value='<%IntellegentGet("ICEtype","net");%>' />
<input type="hidden" id="VLPR" value='<%IntellegentGet("VLPR","net");%>' />
<input type="hidden" id="VinRes960p" value='<%videoparaGet("VinRes960p", "net");%>' />
<input type="hidden" id="Hi3516A" value='<%videoparaGet("hi3516a", "net");%>' />
<iframe name="hideFrame" style=" display:none"></iframe>
<div class="topMenu" style="min-width:550px;">
	<ul style="width:850px;">
        <li class="choose" id="line_counting" onclick="videoShow(0)">Count</li>
        <li class="choose" id="plate_recognition" onclick="videoShow(1)">Recognize</li>
        <li class="choose" id="target_checking" onclick="videoShow(2)">Targets</li>
        <li class="choose" id="clbr" onclick="videoShow(3)">Clbrset</li>
        <li class="choose" id="icedtca" onclick="videoShow(4)">Function</li>
        <li class="choose" id="icehcnt" onclick="videoShow(5)">Humcount</li>
        <li class="choose" id="iceface" onclick="videoShow(6)">Face detection</li>
    </ul>
</div>
<div class="videoWindow">
	<div id="iframeDIV" style="width: 480px; height: 270px; border:#777 solid 1px;overflow:hidden; float:left">
    	<iframe id='jsVedioIframe' name='jsVedioIframe' width='480' height='270' scrolling='no' frameborder='0'></iframe>
    </div>
</div>
<div></div>

<div class="videoClass">
	<div class="videoSet">
       	<div class="OSDset">
			<label class="OSDcontain">&nbsp;&nbsp;TotalNum:</label>
       		<div class="OSDstate">
				<div id="intel_line_num" style="color:red;"></div>
   	        	<div class="OSDXYlabel">
					<input type="button" class="ButtonRight" style="height: 25px;font-size: 12px" value="NumberReset" onclick="Line_ClearNum()" />
					<input type="button" class="ButtonRight" style="height: 25px;font-size: 12px" value="SendToUart" onclick="Line_SendNum()" />
				</div>
			</div>
			<br></br>
			<br></br>
			<form class="clearSpace" method="post" name="IntellLineForm" id="IntellLineForm" action="/form/IntellegentSet" target="hideFrame">
        		<div>
        	    	<input type="hidden" name="flag" value="1" />
        	    	<input type="hidden" name="LDirUL" id="jsLDirUL" value='<%IntellegentGet("LDirUL","net");%>' />
        	    	<input type="hidden" name="LDirDR" id="jsLDirDR" value='<%IntellegentGet("LDirDR","net");%>' />
                </div>
        		<input type="button" class="ButtonRight" value="DrawLine" id="jsCrossLineDrag" onclick="CrossLineDrag();draglineOperateLimit();" style="display:none" />
				<label style="font-size: 12px">&nbsp;&nbsp;LineCoordinate:&nbsp;(</label>
        	    <input type="text" name="LStartX" id="jsLineStartX" value='<%IntellegentGet("Lstartx","net");%>' style="width:20px" />
 				<label style="font-size: 12px">,</label>
	       	  	<input type="text" name="LStartY" id="jsLineStartY" value='<%IntellegentGet("Lstarty","net");%>' style="width:20px" />
 				<label style="font-size: 12px">) --> (</label>
        	    <input type="text" name="LEndX" id="jsLineEndX" value='<%IntellegentGet("Lendx","net");%>' style="width:20px" />
 				<label style="font-size: 12px">,</label>
        	    <input type="text" name="LEndY" id="jsLineEndY" value='<%IntellegentGet("Lendy","net");%>' style="width:20px" />
 				<label style="font-size: 12px">)</label>
                <br />
 				<label style="font-size: 12px">&nbsp;&nbsp;(LeftTop(0,0),DownBottom(99,99))</label>
				<br></br>
                    <label style="font-size: 12px">&nbsp;&nbsp;Direction:&nbsp;</label>
                    <input type="checkbox" value="0" id="jsDirectionUpLeft" />
                    <label style="font-size: 12px">Up(90deg)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                    <input type="checkbox" value="1" id="jsDirectionDownRight" />
                    <label style="font-size: 12px">Down(270deg)</label>
                    <br></br>
                <div id="Dir_Area">
                    <input type="button" class="ButtonRight" value="DrawT-Area" id="jsTargetAreaDrag" onclick="TargetAreaDrag();dragTargetOperateLimit();" style="display:none" />
                    <label style="font-size: 12px">&nbsp;&nbsp;TargetArea:</label>
                    <input type="text" name="ASize" id="jsAreaSize" style="font-size: 12px;width: 40px" value='<%IntellegentGet("ASize","net");%>' />
                    <br></br>
                </div>
                <div id="clbr_line1">
                    <label style="font-size: 12px">&nbsp;&nbsp;CalibrationLine1:&nbsp;(</label>
                    <input type="text" name="L1SX" id="jsL1SX" value='<%IntellegentGet("L1SX","net");%>' style="width:20px" />
                    <label style="font-size: 12px"> --> </label>
                    <input type="text" name="L1EX" id="jsL1EX" value='<%IntellegentGet("L1EX","net");%>' style="width:20px" />
                    <label style="font-size: 12px">,</label>
                    <input type="text" name="L1Y" id="jsL1Y" value='<%IntellegentGet("L1Y","net");%>' style="width:20px" />
                    <label style="font-size: 12px">),Length</label>
                    <input type="text" name="L1L" id="jsL1L" value='<%IntellegentGet("L1L","net");%>' style="width:20px" />
                    <label style="font-size: 12px">cm</label>
                </div>
                <div id="clbr_line2">
                    <label style="font-size: 12px">&nbsp;&nbsp;CalibrationLine2:&nbsp;(</label>
                    <input type="text" name="L2SX" id="jsL2SX" value='<%IntellegentGet("L2SX","net");%>' style="width:20px" />
                    <label style="font-size: 12px"> --> </label>
                    <input type="text" name="L2EX" id="jsL2EX" value='<%IntellegentGet("L2EX","net");%>' style="width:20px" />
                    <label style="font-size: 12px">,</label>
                    <input type="text" name="L2Y" id="jsL2Y" value='<%IntellegentGet("L2Y","net");%>' style="width:20px" />
                    <label style="font-size: 12px">),Length</label>
                    <input type="text" name="L2L" id="jsL2L" value='<%IntellegentGet("L2L","net");%>' style="width:20px" />
                    <label style="font-size: 12px">cm</label>
                </div>
                <div id="clbr_line3">
                    <label style="font-size: 12px">&nbsp;&nbsp;CalibrationLine3:&nbsp;(</label>
                    <input type="text" name="L3SX" id="jsL3SX" value='<%IntellegentGet("L3SX","net");%>' style="width:20px" />
                    <label style="font-size: 12px"> --> </label>
                    <input type="text" name="L3EX" id="jsL3EX" value='<%IntellegentGet("L3EX","net");%>' style="width:20px" />
                    <label style="font-size: 12px">,</label>
                    <input type="text" name="L3Y" id="jsL3Y" value='<%IntellegentGet("L3Y","net");%>' style="width:20px" />
                    <label style="font-size: 12px">),Length</label>
                    <input type="text" name="L3L" id="jsL3L" value='<%IntellegentGet("L3L","net");%>' style="width:20px" />
                    <label style="font-size: 12px">cm</label>
                </div>
				<br></br>
				<input type="button" class="ButtonRight" value="Save" style="margin-right: 500px;float:right" onclick="IntellineSubmit();" />
				<br></br>
				<input type="button" class="ButtonRight" value="Factoryset" style="margin-right: 500px;height: 20px;font-size:15px;float:right" onclick="IntelligentReset(1);" />
 			</form>
		</div>
    </div>
</div>

<div class="videoClass">
	<div class="videoSet">
       	<div class="OSDset">
			<label class="OSDcontain">&nbsp;&nbsp;PlateNum:</label>
       		<div class="OSDstate">
				<div id="intel_plate_num0"></div>
				<div id="intel_plate_num1"></div>
				<div id="intel_plate_num2"></div>
				<div id="intel_plate_num3"></div>
				<div id="intel_plate_num4"></div>
			</div>
			<br></br>
			<br></br>
			<br></br>
			<form class="clearSpace" method="post" name="IntellPlateForm" id="IntellPlateForm" action="/form/IntellegentSet" target="hideFrame">
        		<div style="display:none">
        	    	<input type="text" name="flag" value="2" />
        	  		<input type="text" name="LStartY" id="jsLineStartY" value='<%IntellegentGet("Lstarty","net");%>' />
                </div>
                <div id="IPG_Params1">
                    <label style="font-size: 12px">&nbsp;&nbsp;ParkingPlateNum:&nbsp;</label>
                    <input type="text" name="Plate_PlaceNum" id="jsPlate_PlaceNum" style="width: 30px" value='<%IntellegentGet("ParkingPlaceNumber","net");%>' />
                    <label style="font-size: 12px">(1~3)</label>
                    <br />
                    <label style="font-size: 12px">&nbsp;&nbsp;MinPlateWidth:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                    <input type="text" name="Plate_MinPlateWidth" id="jsPlate_MinPlateWidth" style="width: 30px" value='<%IntellegentGet("MinPlateWidth","net");%>' />
                    <label style="font-size: 12px">(60~200)</label>
                    <br />
                    <label style="font-size: 12px">&nbsp;&nbsp;MaxPlateWidth:&nbsp;&nbsp;&nbsp;&nbsp;</label>
                    <input type="text" name="Plate_MaxPlateWidth" id="jsPlate_MaxPlateWidth" style="width: 30px" value='<%IntellegentGet("MaxPlateWidth","net");%>' />
                    <label style="font-size: 12px">(200~350)</label>
                    <br />
                    <label style="font-size: 12px">&nbsp;&nbsp;PriorCitys:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                    <input type="text" name="Plate_PriorCity" id="jsPlate_PriorCity" style="width: 120px" value='<%IntellegentGet("PriorCity","net");%>' />
                    <label style="font-size: 12px">(Max 8)</label>
                    <br />
                    <label style="font-size: 12px">&nbsp;&nbsp;&nbsp;HandleFrameNum:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                    <input type="text" name="Plate_ProcessFrameNum" id="jsPlate_ProcessFrameNum" style="width: 30px" value='<%IntellegentGet("ProcessFrameNum","net");%>' />
                    <label style="font-size: 12px">(1~100)</label>
                    <label style="font-size: 12px">&nbsp;&nbsp;&nbsp;ValidCheckThrld:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                    <input type="text" name="Plate_ValidThrld" id="jsPlate_ValidThrld" style="width: 30px" value='<%IntellegentGet("ValidThrld","net");%>' />
                    <label style="font-size: 12px">(0~100)</label>
                    <br />
                    <label style="font-size: 12px">&nbsp;&nbsp;&nbsp;ConfidThrld:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                    <input type="text" name="Plate_ConfidThrld" id="jsPlate_ConfidThrld" style="width: 30px" value='<%IntellegentGet("ConfidThrld","net");%>' />
                    <label style="font-size: 12px">(-28~28)</label>
                    <br />
                </div>

                <div id="VLPR_Params1">
                    <div style="display:none">
                        <input type="text" name="PlateTop" id="PlateTop" value='<%IntellegentGet("PlateTop","net");%>' />
                        <input type="text" name="PlateBottom" id="PlateBottom" value='<%IntellegentGet("PlateBottom","net");%>' />
                        <input type="text" name="PlateLeft" id="PlateLeft" value='<%IntellegentGet("PlateLeft","net");%>' />
                        <input type="text" name="PlateRight" id="PlateRight" value='<%IntellegentGet("PlateRight","net");%>' />
                    </div>
                    <div class="areaSetBottom">
                    	<label style="font-size: 12px;">&nbsp;&nbsp;Algo Area:</label>
                   		<input type="button" value="Drag" id="PlateDrag" style="float:none" onclick="PlateAreaDrag(); PlateOperateLimit();" />
                        <input type="button" value="Confirm" id="PlateSub" style="float:none" disabled="disabled" onclick="PlateAreaGet();PlateOperateRes()" />
                        <input type="button" value="Cancel" id="PlateRes" style="float:none" disabled="disabled" onclick="PlateAreaReset();PlateOperateRes()" />
                    </div>
                </div>
				<br />
				<br />


 				<label style="font-size: 12px">&nbsp;&nbsp;&nbsp;VinSize:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
				<input type="text" name="Plate_InWidth" id="jsPlate_InWidth" style="width: 30px" value='<%IntellegentGet("InWidth","net");%>' />
                <label style="font-size: 12px">x</label>
				<input type="text" name="Plate_InHeight" id="jsPlate_InHeight" style="width: 30px" value='<%IntellegentGet("InHeight","net");%>' />
                <label id="IPG_Label1" style="font-size: 12px">(will not become effect before reboot)</label>
				<br />
                <div id="VLPR_Params2">
 					<label style="font-size: 12px">&nbsp;&nbsp;&nbsp;PlateConfidence:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<input type="text" name="PlateConfidence" id="PlateConfidence" style="width: 30px" value='<%IntellegentGet("PlateConfidence","net");%>' />
                    <br />
					<input type="hidden" name="PlatePriorcity_" id="PlatePriorcity_" value='<%IntellegentGet("PlatePriorcity","net");%>' />
 					<label style="font-size: 12px">&nbsp;&nbsp;&nbsp;PlatePriorcity:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<select name="PlatePriorcity" id="PlatePriorcity">
					  <option value="3">All</option>
					  <option value="4">Jing</option>
					  <option value="5">Hu</option>
					  <option value="6">Jin</option>
					  <option value="7">Yu2</option>
					  <option value="8">Hei</option>
					  <option value="9">Ji2</option>
					  <option value="10">Liao</option>
					  <option value="11">Nei</option>
					  <option value="12">Ji4</option>
					  <option value="13">Lu</option>
					  <option value="14">Jin</option>
					  <option value="15">Wan</option>
					  <option value="16">Su</option>
					  <option value="17">Zhe</option>
					  <option value="18">Min</option>
					  <option value="19">Yue</option>
					  <option value="20">Yu4</option>
					  <option value="21">Gan</option>
					  <option value="22">Xiang</option>
					  <option value="23">E</option>
					  <option value="24">Gui</option>
					  <option value="25">Qiong</option>
					  <option value="26">Yun</option>
					  <option value="27">Gui</option>
					  <option value="28">Chuan</option>
					  <option value="29">Qin</option>
					  <option value="30">Gan</option>
					  <option value="31">Ning</option>
					  <option value="32">Qing</option>
					  <option value="33">Zang</option>
					  <option value="34">Xin</option>
					</select>
                    <br />
                    <input type="hidden" name="Direction_" id="Direction_" value='<%IntellegentGet("Direction","net");%>' />
					<label style="font-size: 12px">&nbsp;&nbsp;&nbsp;RecoMode:&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<select name="Direction" id="Direction">
					  <option value="0">Head & Tail</option>
					  <option value="1">Only Head</option>
                      <option value="2">Only Tail</option>
					</select>
                    <br />
                    <input type="hidden" name="SnapOn" id="SnapOn" value='<%IntellegentGet("SnapOn","net");%>' />
                    <label style="font-size: 12px">&nbsp;&nbsp;&nbsp;SnapOn:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                    <input type="checkbox" value="0" id="SnapOnCheck" />
                    <br />
                </div>
                <label style="font-size: 12px">&nbsp;&nbsp;&nbsp;ServerIP:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                <input type="text" name="ServerIp" id="jsServerIp" style="width: 100px" value='<%IntellegentGet("ServerIp","net");%>' />
                <label style="font-size: 12px">(Please ensure the Ip address is correct)</label>
                <br />
                <div id="VLPR_Params3">
                    <input type="hidden" name="AlarmMode" id="AlarmMode" value='<%IntellegentGet("AlarmMode","net");%>' />
                    <label style="font-size: 12px">&nbsp;&nbsp;&nbsp;AlarmMode:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Trigger</label>
                    <input type="checkbox" value="0" id="AL_GPIO" />
                    <label style="font-size: 12px">&nbsp;Uart</label>
                    <input type="checkbox" value="0" id="AL_UART" />
                    <label style="font-size: 12px">&nbsp;Video</label>
                    <input type="checkbox" value="0" id="AL_VIDEO" />
                    <label style="font-size: 12px">&nbsp;Manual</label>
                    <input type="checkbox" value="0" id="AL_NET" />
                    <input type="hidden" name="ManualAlarm" id="ManualAlarm" value="0" />
                    <input type="button" value="ManAlarm" id="ManualAlarm"  style="float:none;background-image:url(../images/AreaSet.gif);padding:0;border:0;width: 65px;height: 24px;font-size:12px;" onclick="IntelplateAlarm();" />
                    <br />
                    <input type="hidden" name="AlarmOut_" id="AlarmOut_" value='<%IntellegentGet("AlarmOut","net");%>' />
					<label style="font-size: 12px">&nbsp;&nbsp;&nbsp;AlarmOut:&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<select name="AlarmOut" id="AlarmOut">
					  <option value="0">WhiteList</option>
					  <option value="1">Offline WhiteList</option>
					  <option value="2">All-Plates</option>
					  <option value="3">Offline All-Plate</option>
					</select>
                    <br />
                   <label style="font-size: 12px">&nbsp;&nbsp;&nbsp;AlarmInterval:&nbsp;&nbsp;</label>
                    <input type="text" name="AlarmInterval" id="AlarmInterval" style="width: 30px" value='<%IntellegentGet("AlarmInterval","net");%>' />
                    <label style="font-size: 12px">(s)</label>
                    <br />
                    <input type="hidden" name="TfSave_" id="TfSave_" value='<%IntellegentGet("TfSave","net");%>' />
					<label style="font-size: 12px">&nbsp;&nbsp;&nbsp;TfSave:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<select name="TfSave" id="TfSave">
					  <option value="0">NO SAVE</option>
					  <option value="1">NET DOWN SAVE</option>
                      <option value="2">SERVER DISCONNECT SAVE</option>
					</select>
                    <br />
                    <input type="hidden" name="UartBaudrate_" id="UartBaudrate_" value='<%IntellegentGet("UartBaudrate","net");%>' />
					<label style="font-size: 12px;margin-left:0px;align:left">&nbsp;&nbsp;&nbsp;SerialBaudrate:&nbsp;&nbsp;</label>
					<select name="UartBaudrate" id="UartBaudrate">
					  <option value="0">1200</option>
					  <option value="1">2400</option>
					  <option value="2">4800</option>
					  <option value="3">9600</option>
					  <option value="4">19200</option>
					  <option value="5">38400</option>
					  <option value="6">57600</option>
					  <option value="7">115200</option>
					</select>
                    <br />
                    <input type="hidden" name="UartMode_" id="UartMode_" value='<%IntellegentGet("UartMode","net");%>' />
					<label style="font-size: 12px;margin-left:0px;align:left">&nbsp;&nbsp;&nbsp;Uart Mode:&nbsp;&nbsp;</label>
					<select name="UartMode" id="UartMode" onchange="VLPR_UartMode_Select();">
					  <option value="0">AutoSendPlate</option>
					  <option value="1">ManualSendUart</option>
					</select>
                    <br />
					<div id="uart_transfer" style="width: 800px">
                		<label style="font-size: 12px">&nbsp;&nbsp;&nbsp;T-Serial:</label>
                        <select name="TextMode" id="TextMode" style="margin-left:20px">
                          <option value="0">Text</option>
                          <option value="1">Hex</option>
                        </select>
                		<textarea name="TextContent" id="TextContent" style="width:200px;height:30px"></textarea>
 						<input type="button" class="ButtonRight" value="Send" style="float:inherit" onclick="VLPR_UartTransfer();" />
					</div>
                    <input type="hidden" name="LedMode_" id="LedMode_" value='<%IntellegentGet("LedMode","net");%>' />
					<label style="font-size: 12px">&nbsp;&nbsp;&nbsp;LedMode:&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<select name="LedMode" id="LedMode">
					  <option value="0">OFF</option>
					  <option value="1">ADC CONTROL</option>
                      <option value="2">TIME CONTROL</option>
                      <option value="3">ADC+TIME CONTROL</option>
                      <option value="4">ALWAYS ON</option>
					</select>
                    <br />
                    <input type="hidden" name="LedNightTime" id="LedNightTime" value='<%IntellegentGet("LedNightTime","net");%>' />
                    <label style="font-size: 12px">&nbsp;&nbsp;&nbsp;LedTime:&nbsp;&nbsp;&nbsp;&nbsp;</label>
                    <input type="text" name="Tstart_H" id="Tstart_H" style="width:20px" />
                    <label style="font-size: 12px">:</label>
                    <input type="text" name="Tstart_M" id="Tstart_M" style="width:20px" />
                    <label style="font-size: 12px">-->NextDay</label>
                    <input type="text" name="Tend_H" id="Tend_H" style="width:20px" />
                    <label style="font-size: 12px">:</label>
                    <input type="text" name="Tend_M" id="Tend_M" style="width:20px" />
                    <br />
                    <input type="hidden" name="LedLightMode_" id="LedLightMode_" value='<%IntellegentGet("LedLightMode","net");%>' />
					<label style="font-size: 12px">&nbsp;&nbsp;&nbsp;LumCtrl:&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<select name="LedLightMode" id="LedLightMode">
					  <option value="0">Auto</option>
					  <option value="1">Const</option>
					</select>
              		<div class="sliderDiv" style="font-size: 12px;">
                  		<label class="sliderLabel" style="width:110px">&nbsp;&nbsp;&nbsp;LedLum:</label>
                   		<div class="slider" id="LedLum_Slider" style="height:25px;"></div>
                   		<input name="LedLum" id="LedLum" type="text" value='<%IntellegentGet("LedLum","net");%>' class="sliderText" readonly="true">
              		</div>
                </div>
                <br />
                <div id="IPG_Params2">
                    <label style="font-size: 12px">&nbsp;&nbsp;&nbsp;Place No.:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                    <input type="text" name="PlaceNo1" id="jsPlaceNo1" style="width: 30px" value='<%IntellegentGet("PlaceNo1","net");%>' />
                    <label style="font-size: 12px">,</label>
                    <input type="text" name="PlaceNo2" id="jsPlaceNo2" style="width: 30px" value='<%IntellegentGet("PlaceNo2","net");%>' />
                    <label style="font-size: 12px">,</label>
                    <input type="text" name="PlaceNo3" id="jsPlaceNo3" style="width: 30px" value='<%IntellegentGet("PlaceNo3","net");%>' />
                    <label style="font-size: 12px">(Max3)</label>
                    <br />
                    <label style="font-size: 12px">&nbsp;&nbsp;&nbsp;ServerConntrolLED:&nbsp;&nbsp;&nbsp;&nbsp;</label>
                    <input type="text" name="LedStatus" id="jsLedStatus" style="width: 30px" value='<%IntellegentGet("LedStatus","net");%>' />
                    <label style="font-size: 12px">(0~3,0 for Auto)</label>
                    <br />
                    <label style="font-size: 12px">&nbsp;&nbsp;&nbsp;ControlOtherLedIP:&nbsp;&nbsp;</label>
                    <input type="text" name="LedCamIp" id="jsLedCamIp" style="width: 100px" value='<%IntellegentGet("LedCamIp","net");%>' />
                    <label style="font-size: 12px">(Please ensure Ip correct,empty or 0 for local LED)</label>
                </div>
				<br></br>
				<input type="button" class="ButtonRight" value="Save" style="margin-right: 500px;float:right" onclick="IntelplateSubmit();" />
				<br></br>
				<input type="button" class="ButtonRight" value="Factoryset" style="margin-right: 500px;height: 20px;font-size:15px;float:right" onclick="IntelligentReset(2);" />
 			</form>
		</div>
    </div>
</div>

<div class="videoClass">
	<div class="videoSet">
       	<div class="OSDset">
			<label class="OSDcontain">&nbsp;TargetNum:</label>
       		<div class="OSDstate">
				<div id="intel_target_num" style="color:red;"></div>
   	        	<div class="OSDXYlabel">
				</div>
			</div>
			<br></br>
			<br></br>
			<br></br>
            <form class="clearSpace" method="post" name="IntellTargetForm" id="IntellTargetForm" action="/form/IntellegentSet" target="hideFrame">
            	<div style="display:none">
        	    	<input type="text" name="flag" value="3" />
               		<input type="hidden" id="IvmdEnable_" value='<%IntellegentGet("IvmdEnable","net");%>'/>
                </div>
                <label class="OSDcontain" id="for960p" style="width:800px"></label>
                </br>
            	<label class="OSDcontain">&nbsp;FuncSwitch:</label>
                <div class="OSDstate">
                	<input class="OSDopen" type="radio" name="IvmdEnable" id="jsIvmdEnable1" value="1" onclick="IntelTargetSubmit();" />
                    <label class="OSDraidoLabel" for="jsIvmdEnable1">On</label>
					<input class="OSDopen" type="radio" name="IvmdEnable" id="jsIvmdEnable0" value="0" onclick="IntelTargetSubmit();" />
                    <label class="OSDraidoLabel" for="jsIvmdEnable0">Off</label>
                </div>
            </form>
		</div>
    </div>
</div>

<div class="videoClass">
	<div class="videoSet">
    	<div id="divLine1" class="OSDset" style="padding-top:5px">
      		<form class="clearSpace" method="post" name="CLBRForm" id="CLBRForm1" action="/form/SetIceClbrPara" target="hideFrame">
        		
            	<input type="hidden" name="flag" value="1" />
            	<input type="hidden" name="CLBRStartx1" id="jsCLBR1Xs" value='<%GetIceClbrPara("CLBRStartx1","net");%>' />
          		<input type="hidden" name="CLBREndx1" id="jsCLBR1Xe" value='<%GetIceClbrPara("CLBREndx1","net");%>' />
            	<input type="hidden" name="CLBRStarty1" id="jsCLBR1Ys" value='<%GetIceClbrPara("CLBRStarty1","net");%>' />
            	<input type="hidden" name="CLBREndy1" id="jsCLBR1Ye" value='<%GetIceClbrPara("CLBREndy1","net");%>' />
            	<input type="hidden" name="CLBRDir1" id="jsCLBR1Dir" value='<%GetIceClbrPara("CLBRDir1","net");%>' />
        		
           		<div class="areaSetName" style="width:80px">
        		<label id="jsCLBR1Lab" class="tahoma" for="jsCLBR1Checkbox">Line1:</label>
      			</div>
                <label class="OSDraidoLabel" style="width:30px">V</label>
            	<input class="OSDopen" type="radio" name="CLBRDir1" id="jsCLBR1Dir1" value="1" onclick="ICEClbrDirSet(1,1);" />
            	<label class="OSDraidoLabel" style="width:30px">H</label>	
				<input class="OSDopen" type="radio" name="CLBRDir1" id="jsCLBR1Dir0" value="0" onclick="ICEClbrDirSet(1,0);" />
                <label class="OSDraidoLabel" style="width:70px">Length:</label>
                <input class="OSDraidoLabel" type="text" name="CLBRLength1" maxlength="32" value="<%GetIceClbrPara("CLBRLength1","net");%>" />cm
            	
            	<input type="button" class="dragBegin" value="Draw" id="jsCLBR1Drag" onclick="ICEClbrLineDrag(1);" />
        		<input type="button" class="dragBegin" value="Yes" onclick="ICEClbrLineGet(1);ICEClbrLineSubmit(1);" />
            	<input type="button" class="dragBegin" value="No" onclick="ICEClbrLineReset(1);" />
     		</form>
  		</div>
        
        <div id="divLine2" class="OSDset" style="padding-top:5px">
       
      		<form class="clearSpace" method="post" name="CLBRForm" id="CLBRForm2" action="/form/SetIceClbrPara" target="hideFrame">
            	<input type="hidden" name="flag" value="2" />
            	<input type="hidden" name="CLBRStartx2" id="jsCLBR2Xs" value='<%GetIceClbrPara("CLBRStartx2","net");%>' />
          		<input type="hidden" name="CLBREndx2" id="jsCLBR2Xe" value='<%GetIceClbrPara("CLBREndx2","net");%>' />
            	<input type="hidden" name="CLBRStarty2" id="jsCLBR2Ys" value='<%GetIceClbrPara("CLBRStarty2","net");%>' />
            	<input type="hidden" name="CLBREndy2" id="jsCLBR2Ye" value='<%GetIceClbrPara("CLBREndy2","net");%>' />
            	<input type="hidden" name="CLBRDir2" id="jsCLBR2Dir" value='<%GetIceClbrPara("CLBRDir2","net");%>' />
        		
                <div class="areaSetName" style="width:80px">
        			<label id="jsCLBR2Lab" class="tahoma" for="jsCLBR2Checkbox">Line2:</label>
      			</div>
           
           		<label class="OSDraidoLabel" style="width:30px">V</label>
            	<input class="OSDopen" type="radio" name="CLBRDir2" id="jsCLBR2Dir1" value="1" onclick="ICEClbrDirSet(2,1);" />
            	<label class="OSDraidoLabel" style="width:30px">H</label>	
				<input class="OSDopen" type="radio" name="CLBRDir2" id="jsCLBR2Dir0" value="0" onclick="ICEClbrDirSet(2,0);" />         	
                <label class="OSDraidoLabel" style="width:70px">Length:</label>
                <input class="OSDraidoLabel" type="text" name="CLBRLength2" maxlength="32" value="<%GetIceClbrPara("CLBRLength2","net");%>" />cm
        	
            	<input type="button" class="dragBegin" value="Draw" id="jsCLBR2Drag" onclick="ICEClbrLineDrag(2);" />
        		<input type="button" class="dragBegin" value="Yes" onclick="ICEClbrLineGet(2);ICEClbrLineSubmit(2);" />
            	<input type="button" class="dragBegin" value="No" onclick="ICEClbrLineReset(2);" />
     		</form>
  		</div>
        
  		<div id="divLine3" class="OSDset" style="padding-top:5px">
      		<form class="clearSpace" method="post" name="CLBRForm" id="CLBRForm3" action="/form/SetIceClbrPara" target="hideFrame">     		
            	<input type="hidden" name="flag" value="3" />
            	<input type="hidden" name="CLBRStartx3" id="jsCLBR3Xs" value='<%GetIceClbrPara("CLBRStartx3","net");%>' />
          		<input type="hidden" name="CLBREndx3" id="jsCLBR3Xe" value='<%GetIceClbrPara("CLBREndx3","net");%>' />
            	<input type="hidden" name="CLBRStarty3" id="jsCLBR3Ys" value='<%GetIceClbrPara("CLBRStarty3","net");%>' />
            	<input type="hidden" name="CLBREndy3" id="jsCLBR3Ye" value='<%GetIceClbrPara("CLBREndy3","net");%>' />
            	<input type="hidden" name="CLBRDir3" id="jsCLBR3Dir" value='<%GetIceClbrPara("CLBRDir3","net");%>' />
        
                
                <div class="areaSetName" style="width:80px">
        			<label id="jsCLBR3Lab" class="tahoma" for="jsCLBR3Checkbox">Line3:</label>
      			</div>
           
           		<label class="OSDraidoLabel" style="width:30px">V</label>
            	<input class="OSDopen" type="radio" name="CLBRDir3" id="jsCLBR3Dir1" value="1" onclick="ICEClbrDirSet(3,1);" />
            	<label class="OSDraidoLabel" style="width:30px">H</label>	
				<input class="OSDopen" type="radio" name="CLBRDir3" id="jsCLBR3Dir0" value="0" onclick="ICEClbrDirSet(3,0);" />        	
                <label class="OSDraidoLabel" style="width:70px">Length:</label>
                <input class="OSDraidoLabel" type="text" name="CLBRLength3" maxlength="32" value="<%GetIceClbrPara("CLBRLength3","net");%>" />cm
        	
            	<input type="button" class="dragBegin" value="Draw" id="jsCLBR3Drag" onclick="ICEClbrLineDrag(3);" />
        		<input type="button" class="dragBegin" value="Yes" onclick="ICEClbrLineGet(3);ICEClbrLineSubmit(3);" />
            	<input type="button" class="dragBegin" value="No" onclick="ICEClbrLineReset(3);" />
     		</form>
  		</div>
  		<div id="divLine4" class="OSDset" style="padding-top:5px">
      		<form class="clearSpace" method="post" name="CLBRForm" id="CLBRForm4" action="/form/SetIceClbrPara" target="hideFrame">
            	<input type="hidden" name="flag" value="4" />
            	<input type="hidden" name="CLBRStartx4" id="jsCLBR4Xs" value='<%GetIceClbrPara("CLBRStartx4","net");%>' />
          		<input type="hidden" name="CLBREndx4" id="jsCLBR4Xe" value='<%GetIceClbrPara("CLBREndx4","net");%>' />
            	<input type="hidden" name="CLBRStarty4" id="jsCLBR4Ys" value='<%GetIceClbrPara("CLBRStarty4","net");%>' />
            	<input type="hidden" name="CLBREndy4" id="jsCLBR4Ye" value='<%GetIceClbrPara("CLBREndy4","net");%>' />
            	<input type="hidden" name="CLBRDir4" id="jsCLBR4Dir" value='<%GetIceClbrPara("CLBRDir4","net");%>' />
        		
                <div class="areaSetName" style="width:80px">
        			<label id="jsCLBR4Lab" class="tahoma" for="jsCLBR4Checkbox">Line4:</label>
      			</div>
           
           		<label class="OSDraidoLabel" style="width:30px">V</label>
            	<input class="OSDopen" type="radio" name="CLBRDir4" id="jsCLBR4Dir1" value="1" onclick="ICEClbrDirSet(4,1);" />
            	<label class="OSDraidoLabel" style="width:30px">H</label>	
				<input class="OSDopen" type="radio" name="CLBRDir4" id="jsCLBR4Dir0" value="0" onclick="ICEClbrDirSet(4,0);" />
                <label class="OSDraidoLabel" style="width:70px">Length:</label>
                <input class="OSDraidoLabel" type="text" name="CLBRLength4" maxlength="32" value="<%GetIceClbrPara("CLBRLength4","net");%>" />cm
        	
            	<input type="button" class="dragBegin" value="Draw" id="jsCLBR4Drag" onclick="ICEClbrLineDrag(4);" />
        		<input type="button" class="dragBegin" value="Yes" onclick="ICEClbrLineGet(4);ICEClbrLineSubmit(4);" />
            	<input type="button" class="dragBegin" value="No" onclick="ICEClbrLineReset(4);" />
     		</form>
  		</div>
        <div class="OSDset" style="padding-top:5px">
        	<form class="clearSpace" method="post" name="CLBRForm" id="CLBRForm" action="/form/SetIceClbrPara" target="hideFrame">
            	<input type="hidden" name="flag" id="jsClbrFlag" />
                <br></br>
                <input type="button" class="ButtonRight" value="Reset" style="margin-left: 50px" onclick="ICEClbrLineSubmit(7);" />
                <input type="button" class="ButtonRight" value="Save" style="margin-right: 250px;float:right" onclick="ICEClbrLineSubmit(8);" /> 
            </form>
        </div>
	</div>
</div>

<div id="divDTCA" class="videoClass">
	<div class="videoSet">   
    	<form class="clearSpace" method="post" name="DTCAForm" id="DTCAForm" action="/form/SetIceDtcaPara" target="hideFrame">
        	
            <input type="hidden" name="PtzMovingSwitch" id="PtzMovingSwitch" value="<%GetIceDtcaPara("PtzMovingSwitch","net");%>" />
        	
            <input type="hidden" name="PerimeterRuleName" id="jsPerimeterRuleName" value="<%GetIceDtcaPara("PerimeterRuleName","net");%>" />
            <input type="hidden" name="TripWireRuleName" id="jsTripWireRuleName" value="<%GetIceDtcaPara("TripWireRuleName","net");%>" />
            <input type="hidden" name="MTripWireRuleName" id="jsMTripWireRuleName" value="<%GetIceDtcaPara("MTripWireRuleName","net");%>" />
            <input type="hidden" name="LoterRuleName" id="jsLoterRuleName" value="<%GetIceDtcaPara("LoterRuleName","net");%>" />
            <input type="hidden" name="ConverseRuleName" id="jsConverseRuleName" value="<%GetIceDtcaPara("ConverseRuleName","net");%>" />
            <input type="hidden" name="ObjLeftRuleName" id="jsObjLeftRuleName" value="<%GetIceDtcaPara("ObjLeftRuleName","net");%>" />
            
            <input type="hidden" name="PerimeterRuleEnable" id="jsPerimeterRuleEnable" value="<%GetIceDtcaPara("PerimeterRuleEnable","net");%>" />
            <input type="hidden" name="TripWireRuleEnable" id="jsTripWireRuleEnable" value="<%GetIceDtcaPara("TripWireRuleEnable","net");%>" />
            <input type="hidden" name="MTripWireRuleEnable" id="jsMTripWireRuleEnable" value="<%GetIceDtcaPara("MTripWireRuleEnable","net");%>" />
            <input type="hidden" name="LoterRuleEnable" id="jsLoterRuleEnable" value="<%GetIceDtcaPara("LoterRuleEnable","net");%>" />
            <input type="hidden" name="ConverseRuleEnable" id="jsConverseRuleEnable" value="<%GetIceDtcaPara("ConverseRuleEnable","net");%>" />
            <input type="hidden" name="ObjLeftRuleEnable" id="jsObjLeftRuleEnable" value="<%GetIceDtcaPara("ObjLeftRuleEnable","net");%>" />
            
            <input type="hidden" name="PerimeterObjLimit" id="jsPerimeterObjLimit" value="<%GetIceDtcaPara("PerimeterObjLimit","net");%>" />
            <input type="hidden" name="TripWireObjLimit" id="jsTripWireObjLimit" value="<%GetIceDtcaPara("TripWireObjLimit","net");%>" />
            <input type="hidden" name="MTripWireObjLimit" id="jsMTripWireObjLimit" value="<%GetIceDtcaPara("MTripWireObjLimit","net");%>" />
            <input type="hidden" name="LoterObjLimit" id="jsLoterObjLimit" value="<%GetIceDtcaPara("LoterObjLimit","net");%>" />
            <input type="hidden" name="ConverseObjLimit" id="jsConverseObjLimit" value="<%GetIceDtcaPara("ConverseObjLimit","net");%>" />
            
            <input type="hidden" name="PerimeterObjType" id="jsPerimeterObjType" value="<%GetIceDtcaPara("PerimeterObjType","net");%>" />
            <input type="hidden" name="TripWireObjType" id="jsTripWireObjType" value="<%GetIceDtcaPara("TripWireObjType","net");%>" />
            <input type="hidden" name="MTripWireObjType" id="jsMTripWireObjType" value="<%GetIceDtcaPara("MTripWireObjType","net");%>" />
            <input type="hidden" name="LoterObjType" id="jsLoterObjType" value="<%GetIceDtcaPara("LoterObjType","net");%>" />
            <input type="hidden" name="ConverseObjType" id="jsConverseObjType" value="<%GetIceDtcaPara("ConverseObjType","net");%>" />
            
            <input type="hidden" name="PerimeterObjSizeLimit" id="jsPerimeterObjSizeLimit" value="<%GetIceDtcaPara("PerimeterObjSizeLimit","net");%>" />
            <input type="hidden" name="TripWireObjSizeLimit" id="jsTripWireObjSizeLimit" value="<%GetIceDtcaPara("TripWireObjSizeLimit","net");%>" />
            <input type="hidden" name="MTripWireObjSizeLimit" id="jsMTripWireObjSizeLimit" value="<%GetIceDtcaPara("MTripWireObjSizeLimit","net");%>" />
            <input type="hidden" name="LoterObjSizeLimit" id="jsLoterObjSizeLimit" value="<%GetIceDtcaPara("LoterObjSizeLimit","net");%>" />
            <input type="hidden" name="ConverseObjSizeLimit" id="jsConverseObjSizeLimit" value="<%GetIceDtcaPara("ConverseObjSizeLimit","net");%>" />
            
            <input type="hidden" name="PerimeterObjMinSize" id="jsPerimeterObjMinSize" value="<%GetIceDtcaPara("PerimeterObjMinSize","net");%>" />
            <input type="hidden" name="TripWireObjMinSize" id="jsTripWireObjMinSize" value="<%GetIceDtcaPara("TripWireObjMinSize","net");%>" />
            <input type="hidden" name="MTripWireObjMinSize" id="jsMTripWireObjMinSize" value="<%GetIceDtcaPara("MTripWireObjMinSize","net");%>" />
            <input type="hidden" name="LoterObjMinSize" id="jsLoterObjMinSize" value="<%GetIceDtcaPara("LoterObjMinSize","net");%>" />
            <input type="hidden" name="ConverseObjMinSize" id="jsConverseObjMinSize" value="<%GetIceDtcaPara("ConverseObjMinSize","net");%>" />
            <input type="hidden" name="PerimeterObjMaxSize" id="jsPerimeterObjMaxSize" value="<%GetIceDtcaPara("PerimeterObjMaxSize","net");%>" />
            <input type="hidden" name="TripWireObjMaxSize" id="jsTripWireObjMaxSize" value="<%GetIceDtcaPara("TripWireObjMaxSize","net");%>" />
            <input type="hidden" name="MTripWireObjMaxSize" id="jsMTripWireObjMaxSize" value="<%GetIceDtcaPara("MTripWireObjMaxSize","net");%>" />
            <input type="hidden" name="LoterObjMaxSize" id="jsLoterObjMaxSize" value="<%GetIceDtcaPara("LoterObjMaxSize","net");%>" />
            <input type="hidden" name="ConverseObjMaxSize" id="jsConverseObjMaxSize" value="<%GetIceDtcaPara("ConverseObjMaxSize","net");%>" />
            
            <input type="hidden" name="PerimeterPonitNum" id="jsPerimeterPonitNum" value="<%GetIceDtcaPara("PerimeterPonitNum","net");%>" />
            <input type="hidden" name="PerimeterPonitX1" id="jsPerimeterPonitX1" value="<%GetIceDtcaPara("PerimeterPonitX1","net");%>" />
            <input type="hidden" name="PerimeterPonitY1" id="jsPerimeterPonitY1" value="<%GetIceDtcaPara("PerimeterPonitY1","net");%>" />
            <input type="hidden" name="PerimeterPonitX2" id="jsPerimeterPonitX2" value="<%GetIceDtcaPara("PerimeterPonitX2","net");%>" />
            <input type="hidden" name="PerimeterPonitY2" id="jsPerimeterPonitY2" value="<%GetIceDtcaPara("PerimeterPonitY2","net");%>" />
            <input type="hidden" name="PerimeterPonitX3" id="jsPerimeterPonitX3" value="<%GetIceDtcaPara("PerimeterPonitX3","net");%>" />
            <input type="hidden" name="PerimeterPonitY3" id="jsPerimeterPonitY3" value="<%GetIceDtcaPara("PerimeterPonitY3","net");%>" />
            <input type="hidden" name="PerimeterPonitX4" id="jsPerimeterPonitX4" value="<%GetIceDtcaPara("PerimeterPonitX4","net");%>" />
            <input type="hidden" name="PerimeterPonitY4" id="jsPerimeterPonitY4" value="<%GetIceDtcaPara("PerimeterPonitY4","net");%>" />
            <input type="hidden" name="PerimeterPonitX5" id="jsPerimeterPonitX5" value="<%GetIceDtcaPara("PerimeterPonitX5","net");%>" />
            <input type="hidden" name="PerimeterPonitY5" id="jsPerimeterPonitY5" value="<%GetIceDtcaPara("PerimeterPonitY5","net");%>" />
            <input type="hidden" name="PerimeterPonitX6" id="jsPerimeterPonitX6" value="<%GetIceDtcaPara("PerimeterPonitX6","net");%>" />
            <input type="hidden" name="PerimeterPonitY6" id="jsPerimeterPonitY6" value="<%GetIceDtcaPara("PerimeterPonitY6","net");%>" />
            <input type="hidden" name="PerimeterPonitX7" id="jsPerimeterPonitX7" value="<%GetIceDtcaPara("PerimeterPonitX7","net");%>" />
            <input type="hidden" name="PerimeterPonitY7" id="jsPerimeterPonitY7" value="<%GetIceDtcaPara("PerimeterPonitY7","net");%>" />
            <input type="hidden" name="PerimeterPonitX8" id="jsPerimeterPonitX8" value="<%GetIceDtcaPara("PerimeterPonitX8","net");%>" />
            <input type="hidden" name="PerimeterPonitY8" id="jsPerimeterPonitY8" value="<%GetIceDtcaPara("PerimeterPonitY8","net");%>" />
            
            <input type="hidden" name="TripWirePonitX1" id="jsTripWirePonitX1" value="<%GetIceDtcaPara("TripWirePonitX1","net");%>" />
            <input type="hidden" name="TripWirePonitY1" id="jsTripWirePonitY1" value="<%GetIceDtcaPara("TripWirePonitY1","net");%>" />
            <input type="hidden" name="TripWirePonitX2" id="jsTripWirePonitX2" value="<%GetIceDtcaPara("TripWirePonitX2","net");%>" />
            <input type="hidden" name="TripWirePonitY2" id="jsTripWirePonitY2" value="<%GetIceDtcaPara("TripWirePonitY2","net");%>" />
            
            <input type="hidden" name="MTripWirePonitX11" id="jsMTripWirePonitX11" value="<%GetIceDtcaPara("MTripWirePonitX11","net");%>" />
            <input type="hidden" name="MTripWirePonitY11" id="jsMTripWirePonitY11" value="<%GetIceDtcaPara("MTripWirePonitY11","net");%>" />
            <input type="hidden" name="MTripWirePonitX12" id="jsMTripWirePonitX12" value="<%GetIceDtcaPara("MTripWirePonitX12","net");%>" />
            <input type="hidden" name="MTripWirePonitY12" id="jsMTripWirePonitY12" value="<%GetIceDtcaPara("MTripWirePonitY12","net");%>" />
            <input type="hidden" name="MTripWirePonitX21" id="jsMTripWirePonitX21" value="<%GetIceDtcaPara("MTripWirePonitX21","net");%>" />
            <input type="hidden" name="MTripWirePonitY21" id="jsMTripWirePonitY21" value="<%GetIceDtcaPara("MTripWirePonitY21","net");%>" />
            <input type="hidden" name="MTripWirePonitX22" id="jsMTripWirePonitX22" value="<%GetIceDtcaPara("MTripWirePonitX22","net");%>" />
            <input type="hidden" name="MTripWirePonitY22" id="jsMTripWirePonitY22" value="<%GetIceDtcaPara("MTripWirePonitY22","net");%>" />
        
        	<input type="hidden" name="LoterPonitNum" id="jsLoterPonitNum" value="<%GetIceDtcaPara("LoterPonitNum","net");%>" />    
            <input type="hidden" name="LoterPonitX1" id="jsLoterPonitX1" value="<%GetIceDtcaPara("LoterPonitX1","net");%>" />
            <input type="hidden" name="LoterPonitY1" id="jsLoterPonitY1" value="<%GetIceDtcaPara("LoterPonitY1","net");%>" />
            <input type="hidden" name="LoterPonitX2" id="jsLoterPonitX2" value="<%GetIceDtcaPara("LoterPonitX2","net");%>" />
            <input type="hidden" name="LoterPonitY2" id="jsLoterPonitY2" value="<%GetIceDtcaPara("LoterPonitY2","net");%>" />
            <input type="hidden" name="LoterPonitX3" id="jsLoterPonitX3" value="<%GetIceDtcaPara("LoterPonitX3","net");%>" />
            <input type="hidden" name="LoterPonitY3" id="jsLoterPonitY3" value="<%GetIceDtcaPara("LoterPonitY3","net");%>" />
            <input type="hidden" name="LoterPonitX4" id="jsLoterPonitX4" value="<%GetIceDtcaPara("LoterPonitX4","net");%>" />
            <input type="hidden" name="LoterPonitY4" id="jsLoterPonitY4" value="<%GetIceDtcaPara("LoterPonitY4","net");%>" />
            <input type="hidden" name="LoterPonitX5" id="jsLoterPonitX5" value="<%GetIceDtcaPara("LoterPonitX5","net");%>" />
            <input type="hidden" name="LoterPonitY5" id="jsLoterPonitY5" value="<%GetIceDtcaPara("LoterPonitY5","net");%>" />
            <input type="hidden" name="LoterPonitX6" id="jsLoterPonitX6" value="<%GetIceDtcaPara("LoterPonitX6","net");%>" />
            <input type="hidden" name="LoterPonitY6" id="jsLoterPonitY6" value="<%GetIceDtcaPara("LoterPonitY6","net");%>" />
            <input type="hidden" name="LoterPonitX7" id="jsLoterPonitX7" value="<%GetIceDtcaPara("LoterPonitX7","net");%>" />
            <input type="hidden" name="LoterPonitY7" id="jsLoterPonitY7" value="<%GetIceDtcaPara("LoterPonitY7","net");%>" />
            <input type="hidden" name="LoterPonitX8" id="jsLoterPonitX8" value="<%GetIceDtcaPara("LoterPonitX8","net");%>" />
            <input type="hidden" name="LoterPonitY8" id="jsLoterPonitY8" value="<%GetIceDtcaPara("LoterPonitY8","net");%>" />
           
           	<input type="hidden" name="ConversePonitNum" id="jsConversePonitNum" value="<%GetIceDtcaPara("ConversePonitNum","net");%>" /> 
            <input type="hidden" name="ConversePonitX1" id="jsConversePonitX1" value="<%GetIceDtcaPara("ConversePonitX1","net");%>" />
            <input type="hidden" name="ConversePonitY1" id="jsConversePonitY1" value="<%GetIceDtcaPara("ConversePonitY1","net");%>" />
            <input type="hidden" name="ConversePonitX2" id="jsConversePonitX2" value="<%GetIceDtcaPara("ConversePonitX2","net");%>" />
            <input type="hidden" name="ConversePonitY2" id="jsConversePonitY2" value="<%GetIceDtcaPara("ConversePonitY2","net");%>" />
            <input type="hidden" name="ConversePonitX3" id="jsConversePonitX3" value="<%GetIceDtcaPara("ConversePonitX3","net");%>" />
            <input type="hidden" name="ConversePonitY3" id="jsConversePonitY3" value="<%GetIceDtcaPara("ConversePonitY3","net");%>" />
            <input type="hidden" name="ConversePonitX4" id="jsConversePonitX4" value="<%GetIceDtcaPara("ConversePonitX4","net");%>" />
            <input type="hidden" name="ConversePonitY4" id="jsConversePonitY4" value="<%GetIceDtcaPara("ConversePonitY4","net");%>" />
            <input type="hidden" name="ConversePonitX5" id="jsConversePonitX5" value="<%GetIceDtcaPara("ConversePonitX5","net");%>" />
            <input type="hidden" name="ConversePonitY5" id="jsConversePonitY5" value="<%GetIceDtcaPara("ConversePonitY5","net");%>" />
            <input type="hidden" name="ConversePonitX6" id="jsConversePonitX6" value="<%GetIceDtcaPara("ConversePonitX6","net");%>" />
            <input type="hidden" name="ConversePonitY6" id="jsConversePonitY6" value="<%GetIceDtcaPara("ConversePonitY6","net");%>" />
            <input type="hidden" name="ConversePonitX7" id="jsConversePonitX7" value="<%GetIceDtcaPara("ConversePonitX7","net");%>" />
            <input type="hidden" name="ConversePonitY7" id="jsConversePonitY7" value="<%GetIceDtcaPara("ConversePonitY7","net");%>" />
            <input type="hidden" name="ConversePonitX8" id="jsConversePonitX8" value="<%GetIceDtcaPara("ConversePonitX8","net");%>" />
            <input type="hidden" name="ConversePonitY8" id="jsConversePonitY8" value="<%GetIceDtcaPara("ConversePonitY8","net");%>" />
            
            <input type="hidden" name="ConverseDirXs" id="jsConverseDirXs" value="<%GetIceDtcaPara("ConverseDirXs","net");%>" />
            <input type="hidden" name="ConverseDirYs" id="jsConverseDirYs" value="<%GetIceDtcaPara("ConverseDirYs","net");%>" />
            <input type="hidden" name="ConverseDirXe" id="jsConverseDirXe" value="<%GetIceDtcaPara("ConverseDirXe","net");%>" />
            <input type="hidden" name="ConverseDirYe" id="jsConverseDirYe" value="<%GetIceDtcaPara("ConverseDirYe","net");%>" />
            
            <input type="hidden" name="ObjLeftPonitNum" id="jsObjLeftPonitNum" value="<%GetIceDtcaPara("ObjLeftPonitNum","net");%>" /> 
            <input type="hidden" name="ObjLeftPonitX1" id="jsObjLeftPonitX1" value="<%GetIceDtcaPara("ObjLeftPonitX1","net");%>" />
            <input type="hidden" name="ObjLeftPonitY1" id="jsObjLeftPonitY1" value="<%GetIceDtcaPara("ObjLeftPonitY1","net");%>" />
            <input type="hidden" name="ObjLeftPonitX2" id="jsObjLeftPonitX2" value="<%GetIceDtcaPara("ObjLeftPonitX2","net");%>" />
            <input type="hidden" name="ObjLeftPonitY2" id="jsObjLeftPonitY2" value="<%GetIceDtcaPara("ObjLeftPonitY2","net");%>" />
            <input type="hidden" name="ObjLeftPonitX3" id="jsObjLeftPonitX3" value="<%GetIceDtcaPara("ObjLeftPonitX3","net");%>" />
            <input type="hidden" name="ObjLeftPonitY3" id="jsObjLeftPonitY3" value="<%GetIceDtcaPara("ObjLeftPonitY3","net");%>" />
            <input type="hidden" name="ObjLeftPonitX4" id="jsObjLeftPonitX4" value="<%GetIceDtcaPara("ObjLeftPonitX4","net");%>" />
            <input type="hidden" name="ObjLeftPonitY4" id="jsObjLeftPonitY4" value="<%GetIceDtcaPara("ObjLeftPonitY4","net");%>" />
            <input type="hidden" name="ObjLeftPonitX5" id="jsObjLeftPonitX5" value="<%GetIceDtcaPara("ObjLeftPonitX5","net");%>" />
            <input type="hidden" name="ObjLeftPonitY5" id="jsObjLeftPonitY5" value="<%GetIceDtcaPara("ObjLeftPonitY5","net");%>" />
            <input type="hidden" name="ObjLeftPonitX6" id="jsObjLeftPonitX6" value="<%GetIceDtcaPara("ObjLeftPonitX6","net");%>" />
            <input type="hidden" name="ObjLeftPonitY6" id="jsObjLeftPonitY6" value="<%GetIceDtcaPara("ObjLeftPonitY6","net");%>" />
            <input type="hidden" name="ObjLeftPonitX7" id="jsObjLeftPonitX7" value="<%GetIceDtcaPara("ObjLeftPonitX7","net");%>" />
            <input type="hidden" name="ObjLeftPonitY7" id="jsObjLeftPonitY7" value="<%GetIceDtcaPara("ObjLeftPonitY7","net");%>" />
            <input type="hidden" name="ObjLeftPonitX8" id="jsObjLeftPonitX8" value="<%GetIceDtcaPara("ObjLeftPonitX8","net");%>" />
            <input type="hidden" name="ObjLeftPonitY8" id="jsObjLeftPonitY8" value="<%GetIceDtcaPara("ObjLeftPonitY8","net");%>" />
            
             <div class="OSDset" style="padding-top:5px" id="PTZmovingDiv">
            	<label class="OSDcontain">PtzMove:</label>
                <div class="OSDstate">
            		<input class="OSDopen" type="radio" name="PTZmoving" id="PTZmovingOn" value="1" />
            		<label class="OSDraidoLabel" style="width:50px" for="PTZmovingOn">On</label>
					<input class="OSDopen" type="radio" name="PTZmoving" id="PTZmovingOff" value="0" />
           	 		<label class="OSDraidoLabel" for="PTZmovingOff">Off</label>	
            	</div> 
            </div>
           
             
        	<div class="OSDset" style="padding-top:5px">
            	<label class="OSDcontain">RuleEvent:</label>
            	<select  name="DTCARuleEvent" id="IceDtcaRuleEventSelect" onchange="ICEDtcaRuleEventSelect();">
                	<option value="1">Perimeter</option>
                	<option value="2">Tripwire</option>
					<option value="3">Mtripwire</option>
                	<option value="4">Loieter</option>
                	<option value="5">Converse</option>
                    <option value="6">ObjLeft</option>
        		</select>
    		</div>
            
            <div class="OSDset" style="padding-top:5px">
            	<label class="OSDcontain">RuleSwitch:</label>
                <div class="OSDstate">
            		<input class="OSDopen" type="radio" name="DTCAActive1" id="jsDTCAActive1" value="1" onclick="ICEDtcaRuleEnable(1);" />
            		<label class="OSDraidoLabel" style="width:50px" for="jsDTCAActive1">on</label>
					<input class="OSDopen" type="radio" name="DTCAActive1" id="jsDTCAActive0" value="0" onclick="ICEDtcaRuleEnable(0);" />
           	 		<label class="OSDraidoLabel" for="jsDTCAActive0">off</label>	
            	</div> 
            </div>
        	
            <div id="ICEDTCAParam">
            <div class="OSDset" style="padding-top:5px">
    			<label class="OSDcontain">RuleName:</label>
    			<div class="OSDstate">
        			<input type="text" name="DTCARuleName" id="jsDTCARuleName" maxlength="32" value='perimeter' />
        		</div>
    		</div>
        	<br />
        	<div id="tripwire" class="OSDset" style="padding-top:5px">
        		<label class="OSDcontain" for="jsTripWireCheckbox">DoubleDir:</label>
       			<input type="checkbox" name="TripWireDDirEnable" id="jsTripWireCheckbox" onclick="ICEDtcaTripWireDDirSwitch();" value="<%GetIceDtcaPara("TripWireDDirEnable","net");%>" />
       		</div>
            
         	<div id="mtripwire" class="OSDset" style="padding-top:5px">
    			<label class="OSDcontain">MaxTime:</label>
    				<div class="OSDstate">
        				<input type="text" name="MTripWireMaxTime" maxlength="32" value="<%GetIceDtcaPara("MTripWireMaxTime","net");%>" />&nbsp;(s)
        			</div>
    		</div>
        
        <div id="loter">
        	<div class="OSDset" style="padding-top:5px">
    			<label class="OSDcontain">MinTime:</label>
    			<div class="OSDstate">
        			<input type="text" name="LoterMinTime" maxlength="32" value="<%GetIceDtcaPara("LoterMinTime","net");%>" />&nbsp;(s)
        		</div>
    		</div>
         	<div class="OSDset" style="padding-top:5px">
        		<label class="OSDcontain" for="jsLoterPathCheckbox">PathAnalysis:</label>
       			<input type="checkbox" name="LoterPathEnable" id="jsLoterPathCheckbox" value="<%GetIceDtcaPara("LoterPathEnable","net");%>" />
       		</div>
        </div>
        
        <div id="commonParam">
        
        <div class="OSDset" style="padding-top:5px">
        	<label class="OSDcontain" for="jsObjTypeCheckbox">ObjTypeLimit:</label>
       		<input type="checkbox" valie="1" id="jsObjTypeCheckbox" onclick="ICEDtcaObjTypeChecked();" />
       	</div>
        
        <div id="ObjectTypeLimit" class="OSDset" style="padding-top:5px">
            <label class="OSDcontain">ObjType:</label>
            <div class="OSDstate">
            	<input class="OSDopen" type="radio" name="ObjectType0" id="jsObjectType0" value="0" onclick="ICEDtcaObjTypeSet(0);" />
            	<label class="OSDraidoLabel" style="width:50px" for="jsObjectType0">man or car</label>
				<input class="OSDopen" type="radio" name="ObjectType1" id="jsObjectType1" value="1" onclick="ICEDtcaObjTypeSet(1);" />
            	<label class="OSDraidoLabel" for="jsObjectType1">man</label>	
            	<input class="OSDopen" type="radio" name="ObjectType2" id="jsObjectType2" value="2" onclick="ICEDtcaObjTypeSet(2);" />
            	<label class="OSDraidoLabel" for="jsObjectType2">car</label>	
            </div>
        </div>
        
        <br />
        <div class="OSDset" style="padding-top:5px">
        	<label class="OSDcontain" for="jsObjSizeCheckbox">ObjSizeLimit:</label>
       		<input type="checkbox" value="1" id="jsObjSizeCheckbox" onclick="ICEDtcaObjSizeChecked();" />
       	</div>
        
        <div id="ObjectSizeLimit" class="OSDset" style="padding-top:5px">
        	<label class="OSDcontain">MinSize:</label>
    		<div class="OSDstate">
        		<input type="text" name="ObjectMinSize" id="jsObjectMinSize" maxlength="32" />&nbsp;(Square centimeter)
        	</div>
            <label class="OSDcontain">MaxSize:</label>
    		<div class="OSDstate">
        		<input type="text" name="ObjectMaxSize" id="jsObjectMaxSize" maxlength="32" />&nbsp;(Square centimeter)
        	</div>
        </div>
        </div>
        
        </div>
        
        <div id="objleft" class="OSDset" style="padding-top:5px">
        	<label class="OSDcontain">ObjMinSize:</label>
    		<div class="OSDstate">
        		<input type="text" name="ObjLeftMinSize" maxlength="32" value="<%GetIceDtcaPara("ObjLeftMinSize","net");%>" />&nbsp;(Square centimeter)
        	</div>
            <label class="OSDcontain">ObjMaxSize:</label>
    		<div class="OSDstate">
        		<input type="text" name="ObjLeftMaxSize" maxlength="32" value="<%GetIceDtcaPara("ObjLeftMaxSize","net");%>" />&nbsp;(Square centimeter)
        	</div>
            
            <br />
            <br />
    		<label class="OSDcontain">LeftMinTime:</label>
    			<div class="OSDstate">
        			<input type="text" name="ObjLeftMinTime" maxlength="32" value="<%GetIceDtcaPara("ObjLeftMinTime","net");%>" />&nbsp;(s)
        		</div>
    	</div>
        <br />
        
        <div class="OSDset" style="padding-top:5px">
            <input type="hidden" name="flag" id="DTCAFlag" />
            <br></br>
            <input type="button" class="ButtonRight" value="Reset" style="margin-left: 10px" onclick="ICEDtcaReset();" />
            <input type="button" class="ButtonRight" value="Save" style="margin-right: 320px;float:right" onclick="ICEDtcaSubmit();" /> 
        </div>
      
        </form>
    </div>
    
</div>

<div class="videoClass">
	<div class="videoSet">   
    	<form class="clearSpace" method="post" name="HCNTForm" id="jsHCNTForm" action="/form/SetIceHcntPara" target="hideFrame">
        	<input type="hidden" name="HcntBaselineStartX" id="jsHcntBaselineStartX" value="<%GetIceHcntPara("HcntBaselineStartX","net");%>" />
            <input type="hidden" name="HcntBaselineStartY" id="jsHcntBaselineStartY" value="<%GetIceHcntPara("HcntBaselineStartY","net");%>" />
            <input type="hidden" name="HcntBaselineEndX" id="jsHcntBaselineEndX" value="<%GetIceHcntPara("HcntBaselineEndX","net");%>" />
            <input type="hidden" name="HcntBaselineEndY" id="jsHcntBaselineEndY" value="<%GetIceHcntPara("HcntBaselineEndY","net");%>" />
            
       		<div class="OSDset">
            	<label class="OSDcontain">Baseline set</label>
        		<input type="button" id="jsHcntBaselineDraw" class="ButtonRight" value="Draw" style="width:40px;" onclick="ICEHcntBaselineDraw();" />
                <input type="button" id="jsHcntBaselineOk" class="ButtonRight" value="Yes" style="width:40px;" onclick="ICEHcntBaselineDrawOk();" />
            	<input type="button" id="jsHcntBaselineCancel" class="ButtonRight" value="No" style="width:40px;" onclick="ICEHcntBaselineCancel();" />
        	</div>
        
        	<br />
        	<div>
        		<div class="OSDset" style="padding-top:5px">
        			<label class="OSDcontain">Use_clbr:</label>
       				<input type="checkbox" name="HcntClbrUsed" id="jsHcntClbrCheckbox" onclick="ICEHcntClbrChecked();" value="<%GetIceHcntPara("HcntClbrUsed","net");%>" />
            	</div>
     
     			
        		<div class="OSDset" style="padding-top:5px">
        			<label class="OSDcontain" style="width:125px">Head radius:</label>
                	<input type="text" name="HcntHeadRadius" id="jsHcntHeadRadius" maxlength="32" value="<%GetIceHcntPara("HcntHeadRadius","net");%>" />(cm/pixel)
            	</div>
            
            	<div class="OSDset" style="padding-top:5px">
            		<label class="OSDcontain" style="width:125px">Head radevi:</label>
                	<input type="text" name="HcntHeadRadiusRate" id="jsHcntHeadRadiusRate" maxlength="32" value="<%GetIceHcntPara("HcntHeadRadiusRate","net");%>" />(0.0~1.0)
            	</div>
            
            	<div class="OSDset" style="padding-top:5px">
            		<label class="OSDcontain" style="width:125px">Vote ratio:</label>
                	<input type="text" name="HcntRateThreshold" id="jsHcntRateThreshold" maxlength="32" value="<%GetIceHcntPara("HcntRateThreshold","net");%>" />(0~500)
            	</div>
            	
        	</div>
          	<br />
            <div id="divHcntSetButton" class="OSDset" style="padding-top:5px">
            	<input type="hidden" name="flag" id="jsHCNTFlag" />
                <input type="button" class="ButtonRight" value="Clear" style="margin-left: 10px" onclick="ICEHcntSubmit(2);" />
            	<input type="button" class="ButtonRight" value="Reset" style="margin-left: 10px" onclick="ICEHcntSubmit(0);" />
            	<input type="button" class="ButtonRight" value="Save" style="margin-left: 10px" onclick="ICEHcntSubmit(1);" /> 
        	</div>
    	</form>
	</div>
</div>

<div class="videoClass" style="padding-top:0px">
	<div class="videoSet">
       	<div class="OSDset" style="display:inline-block">
            <form class="clearSpace" method="post" name="FdtForm" id="FdtForm" action="/form/FdtSet" target="hideFrame">
            	<input type="hidden" name="MarkEnable" id="jsMarkEnable" value='<%FdtGet("markenable","net");%>'/>
            	<input type="hidden" name="FtpMode" id="jsFtpMode" value='<%FdtGet("ftpmode","net");%>'/>
            	<input type="hidden" name="HttpMode" id="jsHttpMode" value='<%FdtGet("httpmode","net");%>'/>
            	<input type="hidden" name="CaptureInterval" id="jsCaptureInterval" value='<%FdtGet("capture_interval","net");%>'/>
            	<input type="hidden" name="CaptureThreshold" id="jsCaptureThreshold" value='<%FdtGet("capture_threshold","net");%>'/>

                <br>
                <div class="content">
			        <label class="setExplain">Http Server :&nbsp;</label> 
			        <input class="showselect" name="HttpServerName" id="jsHttpServerName" type="text" maxlength="63" value='<%FdtGet("http_server_name","net");%>' >
				</div>
                <div class="content">
			        <label class="setExplain">Port :&nbsp;</label>
			        <input class="showselect" name="HttpServerPort" id="jsHttpServerPort" type="text" maxlength="5" value='<%FdtGet("http_server_port","net");%>' /> 
				</div>
                <div class="content">
					<input class="ButtonRight" style="margin-left: 10px;" onclick="FdtSubmit();" type="button" value="Save">
				</div>
            </form>
		</div>
    </div>
</div>
</body>
</html>

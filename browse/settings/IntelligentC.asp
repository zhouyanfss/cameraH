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
<input type="hidden" id="PAGE_LANGUAGE" value="1" />
<input type="hidden" id="ICEtype" value='<%IntellegentGet("ICEtype","net");%>' />
<input type="hidden" id="VLPR" value='<%IntellegentGet("VLPR","net");%>' />
<input type="hidden" id="VinRes960p" value='<%videoparaGet("VinRes960p", "net");%>' />
<input type="hidden" id="Hi3516A" value='<%videoparaGet("hi3516a", "net");%>' />
<iframe name="hideFrame" style=" display:none"></iframe>
<div class="topMenu" style="min-width:550px;">
	<ul style="width:850px;">
        <li class="choose" id="line_counting" onclick="videoShow(0)">越线计数</li>
        <li class="choose" id="plate_recognition" onclick="videoShow(1)">车牌识别</li>
        <li class="choose" id="target_checking" onclick="videoShow(2)">周界入侵</li>
        <li class="choose" id="clbr" onclick="videoShow(3)">景深标定</li>
        <li class="choose" id="icedtca" onclick="videoShow(4)">功能设定</li>
        <li class="choose" id="icehcnt" onclick="videoShow(5)">人数统计</li>
        <li class="choose" id="iceface" onclick="videoShow(6)">人脸识别</li>
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
			<label class="OSDcontain">&nbsp;&nbsp;越线总人数:</label>
       		<div class="OSDstate">
				<div id="intel_line_num" style="color:red;"></div>
   	        	<div class="OSDXYlabel">
					<input type="button" class="ButtonRight" style="height: 25px;font-size: 12px" value="人数清零" onclick="Line_ClearNum()" />
					<input type="button" class="ButtonRight" style="height: 25px;font-size: 12px" value="串口发送" onclick="Line_SendNum()" />
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
        		<input type="button" class="ButtonRight" value="划禁止线" id="jsCrossLineDrag" onclick="CrossLineDrag();draglineOperateLimit();" style="display:none" />
				<label style="font-size: 12px">&nbsp;&nbsp;禁止线起止坐标:&nbsp;(</label>
        	    <input type="text" name="LStartX" id="jsLineStartX" value='<%IntellegentGet("Lstartx","net");%>' style="width:20px" />
 				<label style="font-size: 12px">,</label>
	       	  	<input type="text" name="LStartY" id="jsLineStartY" value='<%IntellegentGet("Lstarty","net");%>' style="width:20px" />
 				<label style="font-size: 12px">) --> (</label>
        	    <input type="text" name="LEndX" id="jsLineEndX" value='<%IntellegentGet("Lendx","net");%>' style="width:20px" />
 				<label style="font-size: 12px">,</label>
        	    <input type="text" name="LEndY" id="jsLineEndY" value='<%IntellegentGet("Lendy","net");%>' style="width:20px" />
 				<label style="font-size: 12px">)</label>
                <br />
 				<label style="font-size: 12px">&nbsp;&nbsp;(左上角像素点坐标为(0,0),右下角像素点坐标为(99,99))</label>
				<br></br>
                    <label style="font-size: 12px">&nbsp;&nbsp;禁止方向:&nbsp;</label>
                    <input type="checkbox" value="0" id="jsDirectionUpLeft" />
                    <label style="font-size: 12px">上(90度)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                    <input type="checkbox" value="1" id="jsDirectionDownRight" />
                    <label style="font-size: 12px">下(270度)</label>
                    <br></br>
                <div id="Dir_Area">
                   <input type="button" class="ButtonRight" value="划目标框" id="jsTargetAreaDrag" onclick="TargetAreaDrag();dragTargetOperateLimit();" style="display:none" />
                    <label style="font-size: 12px">&nbsp;&nbsp;当前目标面积:</label>
                    <input type="text" name="ASize" id="jsAreaSize" style="font-size: 12px;width: 40px" value='<%IntellegentGet("ASize","net");%>' />
                    <br></br>
                </div>
                <div id="clbr_line1">
                    <label style="font-size: 12px">&nbsp;&nbsp;标定线段1起止坐标:&nbsp;(</label>
                    <input type="text" name="L1SX" id="jsL1SX" value='<%IntellegentGet("L1SX","net");%>' style="width:20px" />
                    <label style="font-size: 12px"> --> </label>
                    <input type="text" name="L1EX" id="jsL1EX" value='<%IntellegentGet("L1EX","net");%>' style="width:20px" />
                    <label style="font-size: 12px">,</label>
                    <input type="text" name="L1Y" id="jsL1Y" value='<%IntellegentGet("L1Y","net");%>' style="width:20px" />
                    <label style="font-size: 12px">),长度</label>
                    <input type="text" name="L1L" id="jsL1L" value='<%IntellegentGet("L1L","net");%>' style="width:20px" />
                    <label style="font-size: 12px">cm</label>
                </div>
                <div id="clbr_line2">
                    <label style="font-size: 12px">&nbsp;&nbsp;标定线段2起止坐标:&nbsp;(</label>
                    <input type="text" name="L2SX" id="jsL2SX" value='<%IntellegentGet("L2SX","net");%>' style="width:20px" />
                    <label style="font-size: 12px"> --> </label>
                    <input type="text" name="L2EX" id="jsL2EX" value='<%IntellegentGet("L2EX","net");%>' style="width:20px" />
                    <label style="font-size: 12px">,</label>
                    <input type="text" name="L2Y" id="jsL2Y" value='<%IntellegentGet("L2Y","net");%>' style="width:20px" />
                    <label style="font-size: 12px">),长度</label>
                    <input type="text" name="L2L" id="jsL2L" value='<%IntellegentGet("L2L","net");%>' style="width:20px" />
                    <label style="font-size: 12px">cm</label>
                </div>
                <div id="clbr_line3">
                    <label style="font-size: 12px">&nbsp;&nbsp;标定线段3起止坐标:&nbsp;(</label>
                    <input type="text" name="L3SX" id="jsL3SX" value='<%IntellegentGet("L3SX","net");%>' style="width:20px" />
                    <label style="font-size: 12px"> --> </label>
                    <input type="text" name="L3EX" id="jsL3EX" value='<%IntellegentGet("L3EX","net");%>' style="width:20px" />
                    <label style="font-size: 12px">,</label>
                    <input type="text" name="L3Y" id="jsL3Y" value='<%IntellegentGet("L3Y","net");%>' style="width:20px" />
                    <label style="font-size: 12px">),长度</label>
                    <input type="text" name="L3L" id="jsL3L" value='<%IntellegentGet("L3L","net");%>' style="width:20px" />
                    <label style="font-size: 12px">cm</label>
                </div>
				<br></br>
				<input type="button" class="ButtonRight" value="保存" style="margin-right: 500px;float:right" onclick="IntellineSubmit();" />
				<br></br>
				<input type="button" class="ButtonRight" value="恢复默认" style="margin-right: 500px;height: 20px;font-size:15px;float:right" onclick="IntelligentReset(1);" />
 			</form>
		</div>
    </div>
</div>

<div class="videoClass">
	<div class="videoSet">
       	<div class="OSDset">
			<label class="OSDcontain">&nbsp;&nbsp;车牌号码:</label>
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
                    <label style="font-size: 12px">&nbsp;&nbsp;&nbsp;车位数目:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                    <input type="text" name="Plate_PlaceNum" id="jsPlate_PlaceNum" style="width: 30px" value='<%IntellegentGet("ParkingPlaceNumber","net");%>' />
                    <label style="font-size: 12px">(1~3)</label>
                    <br />
                    <label style="font-size: 12px">&nbsp;&nbsp;&nbsp;最小车牌宽度:&nbsp;</label>
                    <input type="text" name="Plate_MinPlateWidth" id="jsPlate_MinPlateWidth" style="width: 30px" value='<%IntellegentGet("MinPlateWidth","net");%>' />
                    <label style="font-size: 12px">(60~200)</label>
                    <br />
                    <label style="font-size: 12px">&nbsp;&nbsp;&nbsp;最大车牌宽度:&nbsp;</label>
                    <input type="text" name="Plate_MaxPlateWidth" id="jsPlate_MaxPlateWidth" style="width: 30px" value='<%IntellegentGet("MaxPlateWidth","net");%>' />
                    <label style="font-size: 12px">(200~350)</label>
                    <br />
                    <label style="font-size: 12px">&nbsp;&nbsp;&nbsp;优先车牌省份:&nbsp;</label>
                    <input type="text" name="Plate_PriorCity" id="jsPlate_PriorCity" style="width: 120px" value='<%IntellegentGet("PriorCity","net");%>' />
                    <label style="font-size: 12px">(最多8个)</label>
                    <br />
                    <label style="font-size: 12px">&nbsp;&nbsp;&nbsp;处理帧数:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                    <input type="text" name="Plate_ProcessFrameNum" id="jsPlate_ProcessFrameNum" style="width: 30px" value='<%IntellegentGet("ProcessFrameNum","net");%>' />
                    <label style="font-size: 12px">(1~100)</label>
                    <label style="font-size: 12px">&nbsp;&nbsp;&nbsp;检测阈值:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                    <input type="text" name="Plate_ValidThrld" id="jsPlate_ValidThrld" style="width: 30px" value='<%IntellegentGet("ValidThrld","net");%>' />
                    <label style="font-size: 12px">(0~100)</label>
                    <br />
                    <label style="font-size: 12px">&nbsp;&nbsp;&nbsp;可信度阈值:&nbsp;&nbsp;&nbsp;&nbsp;</label>
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
                    	<label style="font-size: 12px;">&nbsp;&nbsp;识别区域:</label>
                   		<input type="button" value="拖框" id="PlateDrag" style="float:none" onclick="PlateAreaDrag(); PlateOperateLimit();" />
                        <input type="button" value="确定" id="PlateSub" style="float:none" disabled="disabled" onclick="PlateAreaGet();PlateOperateRes()" />
                        <input type="button" value="取消" id="PlateRes" style="float:none" disabled="disabled" onclick="PlateAreaReset();PlateOperateRes()" />
                    </div>
                </div>
				<br />
				<br />


 				<label style="font-size: 12px">&nbsp;&nbsp;&nbsp;算法输入图像大小:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
				<input type="text" name="Plate_InWidth" id="jsPlate_InWidth" style="width: 30px" value='<%IntellegentGet("InWidth","net");%>' />
                <label style="font-size: 12px">x</label>
				<input type="text" name="Plate_InHeight" id="jsPlate_InHeight" style="width: 30px" value='<%IntellegentGet("InHeight","net");%>' />
                <label id="IPG_Label1" style="font-size: 12px">(该项配置将会在设备下次重启后生效)</label>
				<br />
                <div id="VLPR_Params2">
 					<label style="font-size: 12px">&nbsp;&nbsp;&nbsp;车牌置信度阈值:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<input type="text" name="PlateConfidence" id="PlateConfidence" style="width: 30px" value='<%IntellegentGet("PlateConfidence","net");%>' />
                    <br />
					<input type="hidden" name="PlatePriorcity_" id="PlatePriorcity_" value='<%IntellegentGet("PlatePriorcity","net");%>' />
 					<label style="font-size: 12px">&nbsp;&nbsp;&nbsp;车牌优先省份:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<select name="PlatePriorcity" id="PlatePriorcity">
					  <option value="3">全国</option>
					  <option value="4">北京</option>
					  <option value="5">上海</option>
					  <option value="6">天津</option>
					  <option value="7">重庆</option>
					  <option value="8">黑龙江</option>
					  <option value="9">吉林</option>
					  <option value="10">辽宁</option>
					  <option value="11">内蒙古</option>
					  <option value="12">河北</option>
					  <option value="13">山东</option>
					  <option value="14">山西</option>
					  <option value="15">安徽</option>
					  <option value="16">江苏</option>
					  <option value="17">浙江</option>
					  <option value="18">福建</option>
					  <option value="19">广东</option>
					  <option value="20">河南</option>
					  <option value="21">江西</option>
					  <option value="22">湖南</option>
					  <option value="23">湖北</option>
					  <option value="24">广西</option>
					  <option value="25">海南</option>
					  <option value="26">云南</option>
					  <option value="27">贵州</option>
					  <option value="28">四川</option>
					  <option value="29">陕西</option>
					  <option value="30">甘肃</option>
					  <option value="31">宁夏</option>
					  <option value="32">青海</option>
					  <option value="33">西藏</option>
					  <option value="34">新疆</option>
					</select>
                    <br />
                    <input type="hidden" name="Direction_" id="Direction_" value='<%IntellegentGet("Direction","net");%>' />
					<label style="font-size: 12px">&nbsp;&nbsp;&nbsp;识别模式:&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<select name="Direction" id="Direction">
					  <option value="0">车头+车尾</option>
					  <option value="1">只识别车头</option>
                      <option value="2">只识别车尾</option>
					</select>
                    <br />
                    <input type="hidden" name="SnapOn" id="SnapOn" value='<%IntellegentGet("SnapOn","net");%>' />
                    <label style="font-size: 12px">&nbsp;&nbsp;&nbsp;报警启用:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                    <input type="checkbox" value="0" id="SnapOnCheck" />
                    <br />
                </div>
                <label style="font-size: 12px">&nbsp;&nbsp;&nbsp;服务器地址:&nbsp;&nbsp;&nbsp;&nbsp;</label>
                <input type="text" name="ServerIp" id="jsServerIp" style="width: 100px" value='<%IntellegentGet("ServerIp","net");%>' />
                <label style="font-size: 12px">(请务必填写正确的IP地址)</label>
                <br />
                <div id="VLPR_Params3">
                    <input type="hidden" name="AlarmMode" id="AlarmMode" value='<%IntellegentGet("AlarmMode","net");%>' />
                    <label style="font-size: 12px">&nbsp;&nbsp;&nbsp;报警模式:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Trigger</label>
                    <input type="checkbox" value="0" id="AL_GPIO" />
                    <label style="font-size: 12px">&nbsp;Uart</label>
                    <input type="checkbox" value="0" id="AL_UART" />
                    <label style="font-size: 12px">&nbsp;Video</label>
                    <input type="checkbox" value="0" id="AL_VIDEO" />
                    <label style="font-size: 12px">&nbsp;Manual</label>
                    <input type="checkbox" value="0" id="AL_NET" />
                    <input type="hidden" name="ManualAlarm" id="ManualAlarm" value="0" />
                    <input type="button" value="手动报警" style="float:none;width:80px;background-image:url(../images/AreaSet.gif);padding:0;border:0;width: 65px;height: 24px;font-size:12px;" onclick="IntelplateAlarm();" />
                    <br />
                    <input type="hidden" name="AlarmOut_" id="AlarmOut_" value='<%IntellegentGet("AlarmOut","net");%>' />
					<label style="font-size: 12px">&nbsp;&nbsp;&nbsp;报警输出:&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<select name="AlarmOut" id="AlarmOut">
					  <option value="0">白名单触发</option>
					  <option value="1">离线时白名单触发</option>
					  <option value="2">所有车牌触发</option>
					  <option value="3">离线时所有车牌触发</option>
					</select>
                    <br />
                    <label style="font-size: 12px">&nbsp;&nbsp;&nbsp;报警间隔:&nbsp;&nbsp;&nbsp;&nbsp;</label>
                    <input type="text" name="AlarmInterval" id="AlarmInterval" style="width: 30px" value='<%IntellegentGet("AlarmInterval","net");%>' />
                    <label style="font-size: 12px">(秒)</label>
                    <br />
                    <input type="hidden" name="TfSave_" id="TfSave_" value='<%IntellegentGet("TfSave","net");%>' />
					<label style="font-size: 12px">&nbsp;&nbsp;&nbsp;TF卡机制:&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<select name="TfSave" id="TfSave">
					  <option value="0">不保存</option>
					  <option value="1">网络异常存储</option>
                      <option value="2">服务器断线存储</option>
					</select>
                    <br />
                    <input type="hidden" name="UartBaudrate_" id="UartBaudrate_" value='<%IntellegentGet("UartBaudrate","net");%>' />
					<label style="font-size: 12px;margin-left:0px;align:left">&nbsp;&nbsp;&nbsp;串口波特率:&nbsp;&nbsp;</label>
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
					<label style="font-size: 12px;margin-left:0px;align:left">&nbsp;&nbsp;&nbsp;串口输出模式:&nbsp;&nbsp;</label>
					<select name="UartMode" id="UartMode" onchange="VLPR_UartMode_Select();">
					  <option value="0">自动输出车牌</option>
					  <option value="1">手动透明串口</option>
					</select>
                    <br />
					<div id="uart_transfer" style="width: 800px">
                		<label style="font-size: 12px">&nbsp;&nbsp;&nbsp;透明串口:</label>
                        <select name="TextMode" id="TextMode" style="margin-left:20px">
                          <option value="0">文本</option>
                          <option value="1">十六进制</option>
                        </select>
                		<textarea name="TextContent" id="TextContent" style="width:200px;height:30px"></textarea>
 						<input type="button" class="ButtonRight" value="发送" style="float:inherit" onclick="VLPR_UartTransfer();" />
					</div>
                    <input type="hidden" name="LedMode_" id="LedMode_" value='<%IntellegentGet("LedMode","net");%>' />
					<label style="font-size: 12px">&nbsp;&nbsp;&nbsp;补光模式:&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<select name="LedMode" id="LedMode">
					  <option value="0">关闭</option>
					  <option value="1">光敏控制</option>
                      <option value="2">时间控制</option>
                      <option value="3">光敏+时间控制</option>
                      <option value="4">常亮</option>
					</select>
                    <br />
                    <input type="hidden" name="LedNightTime" id="LedNightTime" value='<%IntellegentGet("LedNightTime","net");%>' />
                    <label style="font-size: 12px">&nbsp;&nbsp;&nbsp;补光时间:&nbsp;&nbsp;&nbsp;&nbsp;</label>
                    <input type="text" name="Tstart_H" id="Tstart_H" style="width:20px" />
                    <label style="font-size: 12px">:</label>
                    <input type="text" name="Tstart_M" id="Tstart_M" style="width:20px" />
                    <label style="font-size: 12px">-->次日</label>
                    <input type="text" name="Tend_H" id="Tend_H" style="width:20px" />
                    <label style="font-size: 12px">:</label>
                    <input type="text" name="Tend_M" id="Tend_M" style="width:20px" />
                    <br />
                    <input type="hidden" name="LedLightMode_" id="LedLightMode_" value='<%IntellegentGet("LedLightMode","net");%>' />
					<label style="font-size: 12px">&nbsp;&nbsp;&nbsp;亮度控制:&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<select name="LedLightMode" id="LedLightMode">
					  <option value="0">自动反馈</option>
					  <option value="1">固定亮度</option>
					</select>
                    <br />
                  	<label class="sliderLabel" style="width:85px;font-size: 12px">&nbsp;&nbsp;&nbsp;补光灯亮度:</label>
                   	<div class="slider" id="LedLum_Slider" style="height:25px;"></div>
                   	<input name="LedLum" id="LedLum" type="text" value='<%IntellegentGet("LedLum","net");%>' class="sliderText" readonly="true">
                    <br />
                </div>
                <div id="IPG_Params2">
                    <label style="font-size: 12px">&nbsp;&nbsp;&nbsp;车位编号:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                    <input type="text" name="PlaceNo1" id="jsPlaceNo1" style="width: 30px" value='<%IntellegentGet("PlaceNo1","net");%>' />
                    <label style="font-size: 12px">,</label>
                    <input type="text" name="PlaceNo2" id="jsPlaceNo2" style="width: 30px" value='<%IntellegentGet("PlaceNo2","net");%>' />
                    <label style="font-size: 12px">,</label>
                    <input type="text" name="PlaceNo3" id="jsPlaceNo3" style="width: 30px" value='<%IntellegentGet("PlaceNo3","net");%>' />
                    <label style="font-size: 12px">(最多3个)</label>
                    <br />
                    <label style="font-size: 12px">&nbsp;&nbsp;&nbsp;服务器控制LED状态:&nbsp;&nbsp;&nbsp;&nbsp;</label>
                    <input type="text" name="LedStatus" id="jsLedStatus" style="width: 30px" value='<%IntellegentGet("LedStatus","net");%>' />
                    <label style="font-size: 12px">(0~3,为0时由摄像机自动控制)</label>
                    <br />
                    <label style="font-size: 12px">&nbsp;&nbsp;&nbsp;控制灯摄像机地址:&nbsp;&nbsp;</label>
                    <input type="text" name="LedCamIp" id="jsLedCamIp" style="width: 100px" value='<%IntellegentGet("LedCamIp","net");%>' />
                    <label style="font-size: 12px">(请务必填写正确的IP地址,不填或填0表示控制本机LED灯)</label>
                </div>
				<br></br>
				<input type="button" class="ButtonRight" value="保存" style="margin-right: 500px;float:right" onclick="IntelplateSubmit();" />
				<br></br>
				<input type="button" class="ButtonRight" value="恢复默认" style="margin-right: 500px;height: 20px;font-size:15px;float:right" onclick="IntelligentReset(2);" />
 			</form>
		</div>
    </div>
</div>

<div class="videoClass">
	<div class="videoSet">
       	<div class="OSDset">
			<label class="OSDcontain">&nbsp;&nbsp;目标个数:</label>
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
            	<label class="OSDcontain">&nbsp;&nbsp;功能开关:</label>
                <div class="OSDstate">
                	<input class="OSDopen" type="radio" name="IvmdEnable" id="jsIvmdEnable1" value="1" onclick="IntelTargetSubmit();" />
                    <label class="OSDraidoLabel" for="jsIvmdEnable1">开启</label>
					<input class="OSDopen" type="radio" name="IvmdEnable" id="jsIvmdEnable0" value="0" onclick="IntelTargetSubmit();" />
                    <label class="OSDraidoLabel" for="jsIvmdEnable0">关闭</label>
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
        		<label id="jsCLBR1Lab" class="tahoma" for="jsCLBR1Checkbox">标注线段1:</label>
      			</div>
                <label class="OSDraidoLabel" style="width:30px">垂直</label>
            	<input class="OSDopen" type="radio" name="CLBRDir1" id="jsCLBR1Dir1" value="1" onclick="ICEClbrDirSet(1,1);" />
            	<label class="OSDraidoLabel" style="width:30px">水平</label>	
				<input class="OSDopen" type="radio" name="CLBRDir1" id="jsCLBR1Dir0" value="0" onclick="ICEClbrDirSet(1,0);" />
                <label class="OSDraidoLabel" style="width:70px">实际长度：</label>
                <input class="OSDraidoLabel" type="text" name="CLBRLength1" maxlength="32" value="<%GetIceClbrPara("CLBRLength1","net");%>" />cm
            	
            	<input type="button" class="dragBegin" value="标注" id="jsCLBR1Drag" onclick="ICEClbrLineDrag(1);" />
        		<input type="button" class="dragBegin" value="确认" onclick="ICEClbrLineGet(1);ICEClbrLineSubmit(1);" />
            	<input type="button" class="dragBegin" value="取消" onclick="ICEClbrLineReset(1);" />
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
        			<label id="jsCLBR2Lab" class="tahoma" for="jsCLBR2Checkbox">标注线段2:</label>
      			</div>
           
           		<label class="OSDraidoLabel" style="width:30px">垂直</label>
            	<input class="OSDopen" type="radio" name="CLBRDir2" id="jsCLBR2Dir1" value="1" onclick="ICEClbrDirSet(2,1);" />
            	<label class="OSDraidoLabel" style="width:30px">水平</label>	
				<input class="OSDopen" type="radio" name="CLBRDir2" id="jsCLBR2Dir0" value="0" onclick="ICEClbrDirSet(2,0);" />         	
                <label class="OSDraidoLabel" style="width:70px">实际长度：</label>
                <input class="OSDraidoLabel" type="text" name="CLBRLength2" maxlength="32" value="<%GetIceClbrPara("CLBRLength2","net");%>" />cm
        	
            	<input type="button" class="dragBegin" value="标注" id="jsCLBR2Drag" onclick="ICEClbrLineDrag(2);" />
        		<input type="button" class="dragBegin" value="确认" onclick="ICEClbrLineGet(2);ICEClbrLineSubmit(2);" />
            	<input type="button" class="dragBegin" value="取消" onclick="ICEClbrLineReset(2);" />
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
        			<label id="jsCLBR3Lab" class="tahoma" for="jsCLBR3Checkbox">标注线段3:</label>
      			</div>
           
           		<label class="OSDraidoLabel" style="width:30px">垂直</label>
            	<input class="OSDopen" type="radio" name="CLBRDir3" id="jsCLBR3Dir1" value="1" onclick="ICEClbrDirSet(3,1);" />
            	<label class="OSDraidoLabel" style="width:30px">水平</label>	
				<input class="OSDopen" type="radio" name="CLBRDir3" id="jsCLBR3Dir0" value="0" onclick="ICEClbrDirSet(3,0);" />        	
                <label class="OSDraidoLabel" style="width:70px">实际长度：</label>
                <input class="OSDraidoLabel" type="text" name="CLBRLength3" maxlength="32" value="<%GetIceClbrPara("CLBRLength3","net");%>" />cm
        	
            	<input type="button" class="dragBegin" value="标注" id="jsCLBR3Drag" onclick="ICEClbrLineDrag(3);" />
        		<input type="button" class="dragBegin" value="确认" onclick="ICEClbrLineGet(3);ICEClbrLineSubmit(3);" />
            	<input type="button" class="dragBegin" value="取消" onclick="ICEClbrLineReset(3);" />
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
        			<label id="jsCLBR4Lab" class="tahoma" for="jsCLBR4Checkbox">标注线段4:</label>
      			</div>
           
           		<label class="OSDraidoLabel" style="width:30px">垂直</label>
            	<input class="OSDopen" type="radio" name="CLBRDir4" id="jsCLBR4Dir1" value="1" onclick="ICEClbrDirSet(4,1);" />
            	<label class="OSDraidoLabel" style="width:30px">水平</label>	
				<input class="OSDopen" type="radio" name="CLBRDir4" id="jsCLBR4Dir0" value="0" onclick="ICEClbrDirSet(4,0);" />
                <label class="OSDraidoLabel" style="width:70px">实际长度：</label>
                <input class="OSDraidoLabel" type="text" name="CLBRLength4" maxlength="32" value="<%GetIceClbrPara("CLBRLength4","net");%>" />cm
        	
            	<input type="button" class="dragBegin" value="标注" id="jsCLBR4Drag" onclick="ICEClbrLineDrag(4);" />
        		<input type="button" class="dragBegin" value="确认" onclick="ICEClbrLineGet(4);ICEClbrLineSubmit(4);" />
            	<input type="button" class="dragBegin" value="取消" onclick="ICEClbrLineReset(4);" />
     		</form>
  		</div>
        <div class="OSDset" style="padding-top:5px">
        	<form class="clearSpace" method="post" name="CLBRForm" id="CLBRForm" action="/form/SetIceClbrPara" target="hideFrame">
            	<input type="hidden" name="flag" id="jsClbrFlag" />
                <br></br>
                <input type="button" class="ButtonRight" value="恢复默认" style="margin-left: 50px" onclick="ICEClbrLineSubmit(7);" />
                <input type="button" class="ButtonRight" value="保存" style="margin-right: 250px;float:right" onclick="ICEClbrLineSubmit(8);" /> 
            </form>
        </div>
	</div>
</div>

<div id="divDTCA" class="videoClass" style="display:none">
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
            	<label class="OSDcontain">跟踪开关:</label>
                <div class="OSDstate">
            		<input class="OSDopen" type="radio" name="PTZmoving" id="PTZmovingOn" value="1" />
            		<label class="OSDraidoLabel" style="width:50px" for="PTZmovingOn">开启</label>
					<input class="OSDopen" type="radio" name="PTZmoving" id="PTZmovingOff" value="0" />
           	 		<label class="OSDraidoLabel" for="PTZmovingOff">关闭</label>	
            	</div> 
            </div>
           
             
        	<div class="OSDset" style="padding-top:5px">
            	<label class="OSDcontain">规则事件:</label>
            	<select  name="DTCARuleEvent" id="IceDtcaRuleEventSelect" onchange="ICEDtcaRuleEventSelect();">
                	<option value="1">周界入侵</option>
                	<option value="2">绊线</option>
					<option value="3">双绊线</option>
                	<option value="4">徘徊</option>
                	<option value="5">逆行</option>
                    <option value="6">物品遗留</option>
        		</select>
    		</div>
            
            <div class="OSDset" style="padding-top:5px">
            	<label class="OSDcontain">规则开关:</label>
                <div class="OSDstate">
            		<input class="OSDopen" type="radio" name="DTCAActive1" id="jsDTCAActive1" value="1" onclick="ICEDtcaRuleEnable(1);" />
            		<label class="OSDraidoLabel" style="width:50px" for="jsDTCAActive1">开启</label>
					<input class="OSDopen" type="radio" name="DTCAActive1" id="jsDTCAActive0" value="0" onclick="ICEDtcaRuleEnable(0);" />
           	 		<label class="OSDraidoLabel" for="jsDTCAActive0">关闭</label>	
            	</div> 
            </div>
        	
            <div id="ICEDTCAParam">
            <div class="OSDset" style="padding-top:5px">
    			<label class="OSDcontain">规则名称:</label>
    			<div class="OSDstate">
        			<input type="text" name="DTCARuleName" id="jsDTCARuleName" maxlength="32" value='perimeter' />
        		</div>
    		</div>
        	<br />
        	<div id="tripwire" class="OSDset" style="padding-top:5px">
        		<label class="OSDcontain" for="jsTripWireCheckbox">双向绊线:</label>
       			<input type="checkbox" name="TripWireDDirEnable" id="jsTripWireCheckbox" onclick="ICEDtcaTripWireDDirSwitch();" value="<%GetIceDtcaPara("TripWireDDirEnable","net");%>" />
       		</div>
            
         	<div id="mtripwire" class="OSDset" style="padding-top:5px">
    			<label class="OSDcontain">最长时间间隔:</label>
    				<div class="OSDstate">
        				<input type="text" name="MTripWireMaxTime" maxlength="32" value="<%GetIceDtcaPara("MTripWireMaxTime","net");%>" />&nbsp;秒
        			</div>
    		</div>
        
        <div id="loter">
        	<div class="OSDset" style="padding-top:5px">
    			<label class="OSDcontain">闲逛最短时间:</label>
    			<div class="OSDstate">
        			<input type="text" name="LoterMinTime" maxlength="32" value="<%GetIceDtcaPara("LoterMinTime","net");%>" />&nbsp;秒
        		</div>
    		</div>
         	<div class="OSDset" style="padding-top:5px">
        		<label class="OSDcontain" for="jsLoterPathCheckbox">启用路径判断:</label>
       			<input type="checkbox" name="LoterPathEnable" id="jsLoterPathCheckbox" value="<%GetIceDtcaPara("LoterPathEnable","net");%>" />
       		</div>
        </div>
        
        <div id="commonParam">
        
        <div class="OSDset" style="padding-top:5px">
        	<label class="OSDcontain" style="width: 100px;" for="jsObjTypeCheckbox">限定目标类型:</label>
       		<input type="checkbox" valie="1" id="jsObjTypeCheckbox" onclick="ICEDtcaObjTypeChecked();" />
       	</div>
        
        <div id="ObjectTypeLimit" class="OSDset" style="padding-top:5px">
            <label class="OSDcontain" style="width: 100px;">类型限定模式:</label>
            <div class="OSDstate">
            	<input class="OSDopen" type="radio" name="ObjectType0" id="jsObjectType0" value="0" onclick="ICEDtcaObjTypeSet(0);" />
            	<label class="OSDraidoLabel" style="width:50px" for="jsObjectType0">人或车</label>
				<input class="OSDopen" type="radio" name="ObjectType1" id="jsObjectType1" value="1" onclick="ICEDtcaObjTypeSet(1);" />
            	<label class="OSDraidoLabel" for="jsObjectType1">人</label>	
            	<input class="OSDopen" type="radio" name="ObjectType2" id="jsObjectType2" value="2" onclick="ICEDtcaObjTypeSet(2);" />
            	<label class="OSDraidoLabel" for="jsObjectType2">车</label>	
            </div>
        </div>
        
        <br />
        <div class="OSDset" style="padding-top:5px">
        	<label class="OSDcontain" style="width: 100px;" for="jsObjSizeCheckbox">限定目标尺寸:</label>
       		<input type="checkbox" value="1" id="jsObjSizeCheckbox" onclick="ICEDtcaObjSizeChecked();" />
       	</div>
        
        <div id="ObjectSizeLimit" class="OSDset" style="padding-top:5px">
        	<label class="OSDcontain" style="width: 100px;">目标最小尺寸:</label>
    		<div class="OSDstate">
        		<input type="text" name="ObjectMinSize" id="jsObjectMinSize" maxlength="32" />&nbsp;平方厘米
        	</div>
            <label class="OSDcontain" style="width: 100px;">目标最大尺寸:</label>
    		<div class="OSDstate">
        		<input type="text" name="ObjectMaxSize" id="jsObjectMaxSize" maxlength="32" />&nbsp;平方厘米
        	</div>
        </div>
        </div>
        
        </div>
        
        <div id="objleft" class="OSDset" style="padding-top:5px">
        	<label class="OSDcontain">物品最小尺寸:</label>
    		<div class="OSDstate">
        		<input type="text" name="ObjLeftMinSize" maxlength="32" value="<%GetIceDtcaPara("ObjLeftMinSize","net");%>" />&nbsp;平方厘米
        	</div>
            <label class="OSDcontain">物品最大尺寸:</label>
    		<div class="OSDstate">
        		<input type="text" name="ObjLeftMaxSize" maxlength="32" value="<%GetIceDtcaPara("ObjLeftMaxSize","net");%>" />&nbsp;平方厘米
        	</div>
            
            <br />
            <br />
    		<label class="OSDcontain">遗留最短时间:</label>
    			<div class="OSDstate">
        			<input type="text" name="ObjLeftMinTime" maxlength="32" value="<%GetIceDtcaPara("ObjLeftMinTime","net");%>" />&nbsp;秒
        		</div>
    	</div>
        <br />
        
        <div class="OSDset" style="padding-top:5px">
            <input type="hidden" name="flag" id="DTCAFlag" />
            <br></br>
            <input type="button" class="ButtonRight" value="恢复默认" style="margin-left: 10px" onclick="ICEDtcaReset();" />
            <input type="button" class="ButtonRight" value="保存" style="margin-right: 320px;float:right" onclick="ICEDtcaSubmit();" /> 
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
            	<label class="OSDcontain">基准线设定:</label>
        		<input type="button" id="jsHcntBaselineDraw" class="ButtonRight" value="绘线" style="width:40px;" onclick="ICEHcntBaselineDraw();" />
                <input type="button" id="jsHcntBaselineOk" class="ButtonRight" value="确认" style="width:40px;" onclick="ICEHcntBaselineDrawOk();" />
            	<input type="button" id="jsHcntBaselineCancel" class="ButtonRight" value="取消" style="width:40px;" onclick="ICEHcntBaselineCancel();" />
        	</div>
        
        	<br />
        	<div>
        		<div class="OSDset" style="padding-top:5px">
        			<label class="OSDcontain">使用标定信息:</label>
       				<input type="checkbox" name="HcntClbrUsed" id="jsHcntClbrCheckbox" onclick="ICEHcntClbrChecked();" value="<%GetIceHcntPara("HcntClbrUsed","net");%>" />
            	</div>
     
     			
        		<div class="OSDset" style="padding-top:5px">
        			<label class="OSDcontain" style="width:125px">头部半径:</label>
                	<input type="text" name="HcntHeadRadius" id="jsHcntHeadRadius" maxlength="32" value="<%GetIceHcntPara("HcntHeadRadius","net");%>" />(厘米/像素)
            	</div>
            
            	<div class="OSDset" style="padding-top:5px">
            		<label class="OSDcontain" style="width:125px">头部半径容差比率:</label>
                	<input type="text" name="HcntHeadRadiusRate" id="jsHcntHeadRadiusRate" maxlength="32" value="<%GetIceHcntPara("HcntHeadRadiusRate","net");%>" />(0.0~1.0)
            	</div>
            
            	<div class="OSDset" style="padding-top:5px">
            		<label class="OSDcontain" style="width:125px">投票计数比率阈值:</label>
                	<input type="text" name="HcntRateThreshold" id="jsHcntRateThreshold" maxlength="32" value="<%GetIceHcntPara("HcntRateThreshold","net");%>" />(0~500)
            	</div>
            	
        	</div>
          	<br />
            <div id="divHcntSetButton" class="OSDset" style="padding-top:5px">
            	<input type="hidden" name="flag" id="jsHCNTFlag" />
                <input type="button" class="ButtonRight" value="统计清零" style="margin-left: 10px" onclick="ICEHcntSubmit(2);" />
            	<input type="button" class="ButtonRight" value="恢复默认" style="margin-left: 10px" onclick="ICEHcntSubmit(0);" />
                <input type="button" class="ButtonRight" value="保存" style="margin-left: 10px" onclick="ICEHcntSubmit(1);" />
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
			        <label class="setExplain">Http服务器 :&nbsp;</label> 
			        <input class="showselect" name="HttpServerName" id="jsHttpServerName" type="text" maxlength="63" value='<%FdtGet("http_server_name","net");%>' >
				</div>
                <div class="content">
			        <label class="setExplain">端口 :&nbsp;</label>
			        <input class="showselect" name="HttpServerPort" id="jsHttpServerPort" type="text" maxlength="5" value='<%FdtGet("http_server_port","net");%>' /> 
				</div>
                <div class="content">
					<input class="ButtonRight" style="margin-left: 10px;" onclick="FdtSubmit();" type="button" value="保存">
				</div>
            </form>
		</div>
    </div>
</div>
</body>
</html>

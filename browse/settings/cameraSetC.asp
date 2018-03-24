<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Camera Settings</title>
<link href="../css/sysInf.css" rel="stylesheet" type="text/css" />
<link href="../css/videoAudioSet.css" rel="stylesheet" type="text/css" />
<link href="../css/cameraSet.css" rel="stylesheet" type="text/css" />
<link href="../css/slider.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="../javascript/jquery.js"></script>
<script type="text/javascript" src="../javascript/cookie.js"/></script>
<script type="text/javascript" src="../javascript/videoset.js"/></script>
<script type="text/javascript" src="../javascript/slider.js"></script>
<script type="text/javascript" src="../javascript/common.js"/></script>
<script type="text/javascript" src="../javascript/detect-zoom.min.js"></script>
<script type="text/javascript" src="../javascript/cameraSet.js"></script>
<script type="text/javascript" src="../javascript/jQueryPie.js"></script>
<script type="text/javascript" src="../javascript/AF.js"></script>
<script type="text/javascript" src="../javascript/videoAudioSet.js"></script>
<script type="text/javascript">
window.onbeforeunload = Unload;
</script>
</head>

<body onLoad="initISP();set_height_width_camera();initSetBt();cameraSliderDisabled();">

<input type="hidden" id="PAGE_LANGUAGE" value="1" />
<iframe id="hideFrame" name="hideFrame" style="display: none;"></iframe>
<input type="hidden" name="flag" value="0">
<input type="hidden" id="Hi3518E" value='<%videoparaGet("hi3518e", "net");%>' />
<input type="hidden" id="Hi3516A" value='<%videoparaGet("hi3516a", "net");%>' />
<input type="hidden" id="Hi3518EV200" value='<%videoparaGet("hi3518ev200", "net");%>' />
<input type="hidden" id="ICEtype" value='<%IntellegentGet("ICEtype","net");%>' />

<div id="topMenu" class="topMenu"  style="width:100%;">
	<ul>
    	<li class="choose" onclick="divShow(0)">基本设置</li>
    	<li class="choose" onclick="divShow(1)">曝光设置</li>
        <li class="choose" onclick="divShow(2)">效果设置</li>
        <li class="choose" onclick="divShow(3)">白平衡</li>
    <!--    <li class="choose" onclick="divShow(4)" id="jsInfrared">红外设置</li>		-->
        <li class="choose" onclick="divShow(4)">恢复默认值</li>

    </ul>
</div>

<div class="videoWindow">
	<div class="playerDiv">
		<script language="javascript" src="../javascript/browseEm.js"></script>
	</div>
</div>

<div id="cameraDiv0" class="cameraDiv">
	<div class="basic">
	 <form name="mcBasicCMDSetForm" id="mcBasicCMDSetForm" method="post" target="hideFrame" action="/form/CameraSet">
	  <input name="flag" type="hidden" value="1">
			<%CameraGet("BasicCMDConf","net");%>
			<input name="powerflag" type="hidden" value="1">
					<div class="UnitDiv gokedisable">
						<label class="basicLabel">防闪频率:</label>
						<div class="basicRadio">
							<input type="radio" name="PFR" id="Power_Frequency_Radio_On" value="50" onClick="Power_Frequency_Checked();">
							<label>50Hz</label>
						</div>
						<div class="basicRadio">
							<input type="radio" name="PFR" id="Power_Frequency_Radio_Off" value="60" onClick="Power_Frequency_Checked();">
							<label>60Hz</label>
						</div>
					</div>
					<div class="UnitDiv">
						<label class="basicLabel">模拟输出:</label>
                        <div class="PNDiv">
							<input name="formatType" id="formatType" type="hidden" value="P">
							<label id="Similate_Out_Lable">PAL</label>
                        </div>	
					</div>
                    
					<div class="UnitDiv gokehide">
						<label class="basicLabel">垂直镜像:</label>
						<div class="basicRadio">
							<input type="radio" name="MVR" id="Mirror_Vertical_Radio_On" value="1" onClick="document.getElementById('mcBasicCMDSetForm').submit()">
							<label>开启</label>
						</div>
						<div class="basicRadio">
						  <input type="radio" name="MVR" id="Mirror_Vertical_Radio_Off" value="0" onClick="document.getElementById('mcBasicCMDSetForm').submit()">
						  <label>关闭</label>
					  </div>
					</div>
					
					<div class="UnitDiv gokehide">
						<label class="basicLabel">水平镜像:</label>
						<div class="basicRadio">
							<input type="radio" name="MHR" id="Mirror_Horizontal_Radio_On" value="1" onClick="document.getElementById('mcBasicCMDSetForm').submit()">
							<label>开启</label>
						</div>
						<div class="basicRadio">
							<input type="radio" name="MHR"  id="Mirror_Horizontal_Radio_Off" value="0" onClick="document.getElementById('mcBasicCMDSetForm').submit()">
							<label>关闭</label>
						</div>
					</div>
                    
                    <div class="UnitDiv gokehide mstarhide" id="BLC_SET">
						<label class="basicLabel">背光补偿:</label>
						<div class="basicRadio">
							<input type="radio" name="BLC" id="BLC_Radio_On" value="1" onClick="document.getElementById('mcBasicCMDSetForm').submit()">
							<label>开启</label>
						</div>
						<div class="basicRadio">
							<input type="radio" name="BLC"  id="BLC_Radio_Off" value="0" onClick="document.getElementById('mcBasicCMDSetForm').submit()">
							<label>关闭</label>
						</div>
					</div>
                    <div class="UnitDiv gokedisable mstardisable" id="DigitalWDRSwitchRadio">
						<label class="basicLabel">数字宽动态:</label>
						<div class="basicRadio">
							<input type="radio" name="WDR" id="WDR_Radio_On" value="1" onClick="document.getElementById('mcBasicCMDSetForm').submit()">
							<label>开启</label>
						</div>
						<div class="basicRadio">
							<input type="radio" name="WDR"  id="WDR_Radio_Off" value="0" onClick="document.getElementById('mcBasicCMDSetForm').submit()">
							<label>关闭</label>
						</div>
					</div>
		</form>
        <form class="gokehide mstarhide" name="WDRLevelForm" id="WDRLevelForm" method="post" target="hideFrame" action="/form/CameraSet">
        	<input name="flag" type="hidden" value="16"/>
            <input type="hidden" id="WDRLEVEL_" value="<%CameraGet("WDRLEVEL","net");%>" />
            <div class="UnitDiv">
                 <div class="UnitDivWB">
                    <label class="basicLabel">宽动态等级:</label>
                    <div class="slider" id="DWDRLevel" style="width:130px"></div>
                    <input name="WDRLEVEL" id="WDRLEVEL" type="text" value="0" class="sliderText" readonly="true">
                </div>
            </div>
        </form>        
		<form name="WDRForm" id="WDRForm" method="post" target="hideFrame" action="/form/CameraSet" style="display:none">
        	<input name="flag" type="hidden" value="18"/>
			<div class="divAE">
				<label class="AELabel1">高帧宽动态:</label>
				<select name="WDR_Select" id="WDR_Select"  onChange="WDR_Selected_Func();">
					<option value="0">关闭</option>
					<option value="1">高帧率</option>
					<option value="2">宽动态</option>
				</select>
			</div>
        </form>        

                    
    </div>
    
    <div class="basic" style="margin-top:3px;">
    	<form class="gokehide mstarhide" name="AFCForm" id="AFCForm" method="post" target="hideFrame" action="/form/CameraSet">
        <input name="flag" type="hidden" value="9"/>
        <input type="hidden" id="AFC_" value="<%CameraGet("AFC","net");%>" />
        	<div class="UnitDiv">
                    <label class="basicLabel">伪彩消除:</label>
                    <div class="basicRadio">
                        <input type="radio" name="AFC" id="AFC_Radio_On" value="1" onClick="document.getElementById('AFCForm').submit()">
                        <label>开启</label>
                    </div>
                    <div class="basicRadio">
                        <input type="radio" name="AFC"  id="AFC_Radio_Off" value="0" onClick="document.getElementById('AFCForm').submit()">
                        <label>关闭</label>
                    </div>
			</div>
        </form>
        <form class="gokehide mstarhide" name="AFGForm" id="AFGForm" method="post" target="hideFrame" action="/form/CameraSet">  
        <input name="flag" type="hidden" value="10"/>  
        <input type="hidden" id="AFG_" value="<%CameraGet("AFG","net");%>" />
            <div class="UnitDiv">
                    <label class="basicLabel">透雾功能:</label>
                    <div class="basicRadio">
                        <input type="radio" name="AFG" id="AFG_Radio_On" value="1" onClick="document.getElementById('AFGForm').submit()">
                        <label>开启</label>
                    </div>
                    <div class="basicRadio">
                        <input type="radio" name="AFG"  id="AFG_Radio_Off" value="0" onClick="document.getElementById('AFGForm').submit()">
                        <label>关闭</label>
                    </div>
			</div>
        </form>
        <form class="gokehide mstarhide" name="DISForm" id="DISForm" method="post" target="hideFrame" action="/form/CameraSet">   
         <input name="flag" type="hidden" value="12"/>  
         <input type="hidden" id="DIS_" value="<%CameraGet("DIS","net");%>" />
            <div class="UnitDiv" >
                    <label class="basicLabel">数字防抖:</label>
                    <div class="basicRadio">
                        <input type="radio" name="DIS" id="DIS_Radio_On" value="1" onClick="document.getElementById('DISForm').submit()">
                        <label>开启</label>
                    </div>
                    <div class="basicRadio">
                        <input type="radio" name="DIS"  id="DIS_Radio_Off" value="0" onClick="document.getElementById('DISForm').submit()">
                        <label>关闭</label>
                    </div>
			</div>
        </form>
        <form class="gokehide mstarhide" name="LSCForm" id="LSCForm" method="post" target="hideFrame" action="/form/CameraSet">      
        <input name="flag" type="hidden" value="11"/> 
        <input type="hidden" id="LSC_" value="<%CameraGet("LSC","net");%>" />
            <div class="UnitDiv">
                    <label class="basicLabel">阴影校正:</label>
                    <div class="basicRadio">
                        <input type="radio" name="LSC" id="LSC_Radio_On" value="1" onClick="document.getElementById('LSCForm').submit()">
                        <label>开启</label>
                    </div>
                    <div class="basicRadio">
                       <input type="radio" name="LSC"  id="LSC_Radio_Off" value="0" onClick="document.getElementById('LSCForm').submit()">
                       <label>关闭</label>
                    </div>
			</div>
         </form>
         <form class="gokehide mstarhide" name="LDCForm" id="LDCForm" method="post" target="hideFrame" action="/form/CameraSet">   
         <input name="flag" type="hidden" value="15"/>  
         <input type="hidden" id="LDC_" value="<%CameraGet("LDC","net");%>" />
            <div class="UnitDiv" >
                    <label class="basicLabel">畸变校正:</label>
                    <div class="basicRadio">
                        <input type="radio" name="LDC" id="LDC_Radio_On" value="1" onClick="document.getElementById('LDCForm').submit()">
                        <label>开启</label>
                    </div>
                    <div class="basicRadio">
                        <input type="radio" name="LDC"  id="LDC_Radio_Off" value="0" onClick="document.getElementById('LDCForm').submit()">
                        <label>关闭</label>
                    </div>
			</div>
        </form>
        <form class="gokehide mstarhide" name="LDCLevelForm" id="LDCLevelForm" method="post" target="hideFrame" action="/form/CameraSet">   
         <input name="flag" type="hidden" value="19"/>  
         <input type="hidden" id="LDCLevel_" value="<%CameraGet("LDCLevel","net");%>" />
             <div class="UnitDiv">
                 <div class="UnitDivWB">
                    <label class="basicLabel">校正强度:</label>
                    <div class="slider" id="DLDCLevel" style="width:130px"></div>
                    <input name="LDCLevel" id="LDCLevel" type="text" value="0" class="sliderText" readonly="true">
                </div>
            </div>
        </form>
		<!--
        <form name="lobbyForm" id="lobbyForm" method="post" target="hideFrame" action="/form/CameraSet">    
        <input name="flag" type="hidden" value="13"/>
        <input type="hidden" id="Lobby_" value="<%CameraGet("Lobby","net");%>" />
        	<div class="UnitDiv" >
                    <label class="basicLabel">走廊模式:</label>
                    <div class="basicRadio">
                        <input type="radio" name="Lobby" id="Lobby_Radio_On" value="1" onClick="document.getElementById('lobbyForm').submit()">
                        <label>开启</label>
                    </div>
                    <div class="basicRadio">
                        <input type="radio" name="Lobby"  id="Lobby_Radio_Off" value="0" onClick="document.getElementById('lobbyForm').submit()">
                        <label>关闭</label>
                    </div>
			</div>
        </form>
        <form name="RotateForm" id="RotateForm" method="post" target="hideFrame" action="/form/CameraSet">
        <input name="flag" type="hidden" value="14"/>
        <input type="hidden" id="Rotate_" value="<%CameraGet("Rotate","net");%>" />
            <div class="UnitDiv">
                    <label class="basicLabel">旋转角度:</label>
                    <div class="basicRadio">
                        <input type="radio" name="Rotate" id="Rotate_Radio_On" value="1" onClick="document.getElementById('RotateForm').submit()">
                        <label>90度</label>
                    </div>
                    <div class="basicRadio">
                        <input type="radio" name="Rotate"  id="Rotate_Radio_Off" value="0" onClick="document.getElementById('RotateForm').submit()">
                        <label>270度</label>
                    </div>
			</div>
    	</form>
		-->		
    </div>
    
    <br class="clear" />
      
</div>
   
<div id="cameraDiv1" class="cameraDiv">
    <div class="basic" >
    	<form name="mcAESetForm" id="mcAESetForm" method="post" target="hideFrame" action="/form/CameraSet">  	
			<input name="flag" type="hidden" value="2" />	
			<%CameraGet("AEConf","net");%>
             <input type="hidden" id="mainFrameRate" value="<%videoparaGet("framerate","net");%>" />
             <input type="hidden" id="minFrameRate" value="<%ExtVideoparaGet("framerate","net");%>" />     
            <div class="divAE gokehide mstardisable">
					<label class="AELabel1">曝光模式:</label>
					<select name="AEMode_Select" id="AEMode_Select"  onChange="AEModeSelect();">
					  <option value="0">场景模式</option>
					  <option value="2">快门模式</option>
                      <option value="1">手动模式</option>
					</select>
			  </div>
             
             <div id="scene_div" class="divAE mstardisable">
					<label class="AELabel1">场景选择:</label>
					<select name="scene_Select" id="scene_Select" onChange="document.getElementById('mcAESetForm').submit()">
					  <option value="0" >室外</option>
					  <option value="1">室内</option>
					</select>
			  </div>
              
               <div class="divAE mstarhide">
					<label class="AELabel1">慢快门模式:</label>
					<select name="slowshutter" id="slowshutter" onChange="document.getElementById('mcAESetForm').submit()">
					  <option value="25" >关闭</option>
					  <option value="20">1/20</option>
                      <option value="15">1/15</option>
                      <option value="10">1/10</option>
                      <option value="8">1/8</option>
                      <option value="5">1/5</option>
                      <option value="3">1/3</option>
                      <option value="2">1/2</option>
                      <option value="1">1</option>
					</select>
			  </div>
              
			  <div class="divAE mstarhide">
			        <label class="AELabel1">最大增益:</label>
			        <select name="maxAE_Select" id="maxAE_Select" onChange="document.getElementById('mcAESetForm').submit()">
						<option value="8">8X</option>
						<option value="16">16X</option>
						<option value="32">32X</option>
						<option value="48">48X</option>
						<option value="64">64X</option>
					</select>
			   </div>
               
               <div class="divAE gokehide mstarhide">
			  	<label class="AELabel1">快门速度:</label>
				<div class="AESlider" id="Slider_ShutterSpeed50"></div>
				<div class="AESliderText">
                	<input name="ShutterSpeed" id="ShutterSpeed" type="hidden" value="" >
                	<input name="ShutterSpeedText" id="ShutterSpeedText" type="text"  value=""  class="sliderTextSh" readonly="true">
                </div>
			   </div>
			  
			  <div class="divAE gokehide mstarhide">
			  	<label class="AELabel1">手动增益:</label>
				<div class="AESlider" id="Slider_AEGain"></div>
				<div class="AESliderText">
                	<input name="AEGain" id="AEGain" type="hidden" value="">
                    <input name="AEGainText" id="AEGainText" type="text"  value=""  class="sliderTextSh" readonly="true">
                </div>
			  </div>
              
              <div id="jsICRcfg">
                <div class="divAE">
                        <label class="AELabel1">ICR控制:</label>
                        <select name="C2B_Switch_Select" id="C2B_Switch_Select" >
                            <option value="0">固定夜晚</option>
                            <option value="1">固定白天</option> 
                            <option value="2">自动模式</option>
                            <option value="3">IO输入1</option>
                            <option value="4">IO输入2</option>
                        </select>
                        
                  </div>
                   <div class="divAE">
                        <label class="AELabel1">ICR切换时间:</label>
                        <select name="IRC_Time" id="IRC_Time">
                            <option value="5">5s</option>
                            <option value="10">10s</option>
                            <option value="15">15s</option>
                            <option value="20">20s</option>
                            <option value="25">25s</option>
                            <option value="30">30s</option>
                        </select>
                   </div>
                </div> 
        </form> 
    </div>
    
    <div class="basic">
    	<form name="IRSetForm" id="IRSetForm" method="post" target="hideFrame" action="/form/IRset">
			<%IRget("IRconf","net");%>
              <div id="msgIRDiv" style="height:25px;">
              </div>
              <div class="UnitDivWB">
                  <label class="basicLabel">彩黑转换:</label>
                  <select id="IRmode" name="IRmode" onChange="IRmode_Select()">
                           <option value="1">外部控制</option>
                           <option value="2">固定黑白</option>
                           <option value="3">固定彩色</option>
                           <option value="4">程序控制</option>
                  </select>
              </div>
              
              <div id="colorblackthr" class="UnitDivWB gokehide mstarhide">
                <label class="basicLabel">彩转黑阈值:</label>
                <div class="slider" id="Color2BwThr"  style="width: 120px"></div>
                <input name="c2bwthr" id="c2bwthr" type="text" value="0" class="sliderText" readonly="true">
              </div>    
                      
              <div id="blackcolorthr" class="UnitDivWB gokehide mstarhide">
                <label class="basicLabel">黑转彩阈值:</label>
                <div class="slider" id="Bw2ColorThr"  style="width: 120px"></div>
                <input name="bw2cthr" id="bw2cthr" type="text" value="0" class="sliderText" readonly="true">
              </div>    
              
              <div class="UnitDivWB gokehide mstarhide">
                  <label class="basicLabel">红外灯使能:</label>
                  <select id="IRenable" name="IRenable" onChange="IRmode_Select()">
                           <option value="1">开启</option>
                           <option value="0">关闭</option>
                   </select>
              </div>
              
              <div class="UnitDivWB mstarhide">
                  <label class="basicLabel">切换时间:</label>
                  <select  id="IRdelay" name="IRdelay" onChange="document.getElementById('IRSetForm').submit()">
                           <option value="0">0s</option>
                           <option value="1">1s</option>
                           <option value="2">2s</option>
                           <option value="3">3s</option>
                           <option value="5">5s</option>
                           <option value="10">10s</option>
                           <option value="15">15s</option>
                    </select>
              </div>
              <!--
              <div class="UnitDivWB" style="margin-top:5px;">
                  <label class="basicLabel">红外功率:</label>
                  <select  id="PowerMode" name="PowerMode" onchange="PMChange();">
                           <option value="1">自动</option>
                           <option value="2">手动</option>
                    </select>
             </div>
        
             <div class="UnitDivWB" style="margin-top:5px;">
                  <label class="WBbasicLabel">功率控制:</label>
                  <div class="imgSlider" id="Slider_PowerValue"></div>
                  <input name="PowerValue" id="PowerValue" type="text" value="0" class="sliderText" onChange="" >
             </div>
             -->   
         </form>    
         
         <form name="ExpFrom" id="ExpFrom" method="post" target="hideFrame" action="/form/CameraSet">
            <input name="flag" type="hidden" value="6"/>
            <input type="hidden" id="colormode_" value="<%CameraGet("ColorMode","net");%>" />
       		<div class="UnitDivWB">
                <label class="basicLabel">图像色彩:</label>
                <select name="colormode" id="colormode" onChange="document.getElementById('ExpFrom').submit()">
                  <option value="0">鲜艳</option>
                  <option value="1">标准</option>
                  <option value="2">冷色调</option>
                </select>
			</div>
         </form>   
         <form class="gokehide mstarhide" name="HLCForm" id="HLCForm" method="post" target="hideFrame" action="/form/CameraSet">
            <input name="flag" type="hidden" value="7"/>
            <input type="hidden" id="HLC_" value="<%CameraGet("HLC","net");%>" />
       		<div class="UnitDivWB">
                <label class="basicLabel">强光抑制:</label>
                <select name="HLC" id="HLC" onChange="HLC_change();">
                  <option value="0">智能红外</option>
                  <option value="1">中心测光</option>
                  <option value="2">平均测光</option>
                  <option value="3">区域测光</option>
                  <option value="4">自适应</option>
                </select>
			</div>
         </form>
        <div>
            <div style="display: none;">
                <label id="jsRoi1Lab" class="tahoma" for="jsRoi1Checkbox">区域1:</label>
                <input type="checkbox" value="1" id="jsRoi1Checkbox" onclick="roiAreaEnable(1)" />
            </div>
            <form class="clearSpace" method="post" name="RoiForm" id="RoiForm1" action="/form/AreaExpSet" target="hideFrame">
                <div style="display:none">
                    <input type="text" name="flag" value="1" />
                    <input type="text" name="RoiEnable1" id="jsRoi1Active" value='<%AreaExpGet("AexpEnable1","net");%>' />
                    <input type="text" name="RoiTop1" id="jsRoi1Top" value='<%AreaExpGet("AexpTop1","net");%>' />
                    <input type="text" name="RoiBottom1" id="jsRoi1Bottom" value='<%AreaExpGet("AexpBottom1","net");%>' />
                    <input type="text" name="RoiLeft1" id="jsRoi1Left" value='<%AreaExpGet("AexpLeft1","net");%>' />
                    <input type="text" name="RoiRight1" id="jsRoi1Right" value='<%AreaExpGet("AexpRight1","net");%>' />
                    <input type="text" name="Roi1Level_" id="jsRoi1Level_" value='<%AreaExpGet("AexpLevel1","net");%>' />
                </div>
                <div class="basic">
                    <div id="jsareaexposure">
                        <input type="button" class="dragBegin" value="拖框" id="jsRoi1Drag" onclick="roiAreaAdd(1); roiAreaDrag(1); roiOperateLimit(1)" />
                        <input type="button" class="dragBegin" value="保存" id="jsRoi1Sub" onclick="roiAreaGet(1);roiAreaSub(1);roiOperateRes()" />
                        <label class="areaName" style="margin-left: -2px;" id="jsRoi1LevelLab">等级:&nbsp;</label>
                            <select class="areaNinput" style="width:60px" name="Roi1Level" id="jsRoi1Level">
                                <option value="0">低</option>
                                <option value="1">中</option>
                                <option value="2">高</option>
                            </select>
                    </div>
                    <div class="areaSetBottom" style="display:none">
                        <div class="sensDiv">&nbsp;</div>
                        <input type="button" value="取消" id="jsRoi1Res" onclick="roiAreaReset(1);roiOperateRes()" />
                    </div>
                </div>
            </form>
        </div>   
         <form class="gokehide mstarhide" name="ExpForm" id="ExpForm" method="post" target="hideFrame" action="/form/CameraSet">
            <input name="flag" type="hidden" value="8"/>
            <input type="hidden" id="EXP_" value="<%CameraGet("EXP","net");%>" />
            <div class="UnitDiv">
       		<div class="UnitDivWB">
                <label class="basicLabel">曝光补偿:</label>
                  <div class="slider" id="ExpCompensation" style="width: 120px"></div>
                  <input name="EXP" id="EXP" type="text" value="0" class="sliderText" readonly="true">
            </div>
            </div>      
         </form>  
    </div>
    
    <br class="clear" />
      
</div>


<div id="cameraDiv2" class="cameraDiv">
	<div id="imageAdjust">
		<div class="modulate">
        	<div class="basicRadio"><input name="modeSwitch" id="modeSwitchOff" type="radio" value="0" onclick="modulatType();" /><label>常规</label></div>
        	<div class="basicRadio"><input name="modeSwitch" id="modeSwitchOn" type="radio" value="1" onclick="modulatType();"/><label>定时模式</label></div><input name="modeEnable" id="modeEnable" type="hidden" value="<%CameraModeGet("mode_enable","net");%>" />
      	</div> 
          
          <form id="modeEnableForm" method="get" target="hideFrame" action="/form/CameraModeSet">
          	<input name="mode_enable" id="mode_enable" type="hidden" value="0"/>
          </form> 
    
    	<div id="imageDiv">
          <form name="sliderForm" id="sliderForm" method="post" target="hideFrame" action="/form/CameraSet">
          <input name="flag" type="hidden" value="4">
  	
         <%CameraGet("generalGet","net");%>
              <div id="msgDiv" style="height:25px;"></div>
              <div class="sliderDiv">
                  <label class="sliderLabel">亮度:</label>
                  <div class="slider" id="RBrightSlider_G"></div>
                  <input name="ImgBrightness_G" id="ImgBrightness_G" type="text" value="0" class="sliderText" readonly="true">
              </div>
              
              <div class="sliderDiv">
                  <label class="sliderLabel">锐度:</label>
                  <div class="slider" id="RSharpSlider_G"></div>
                  <input name="EdgeStrength_G" id="EdgeStrength_G" type="text" value="0" class="sliderText" readonly="true">
              </div>
              
              <div class="sliderDiv">
                  <label class="sliderLabel">色度:</label>
                  <div class="slider" id="RHueSlider_G"></div>
                  <input name="ImgHue_G" id="ImgHue_G" type="text" value="0" class="sliderText" readonly="true">
              </div>
              
              <div class="sliderDiv">
                  <label class="sliderLabel">对比度:</label>
                  <div class="slider" id="RContrastSlider_G"></div>
                  <input name="ImgContrast_G" id="ImgContrast_G" type="text" value="0" class="sliderText" readonly="true">
              </div>
              
              <div class="sliderDiv">
                  <label class="sliderLabel">饱和度:</label>
                  <div class="slider" id="RSatuationSlider_G"></div>
                  <input name="ImgSaturation_G" id="ImgSaturation_G" type="text" value="0" class="sliderText" readonly="true">
              </div>
              
              <div class="sliderDiv gokehide mstarhide">
                  <label class="sliderLabel">3D 降噪:</label>
                  <div class="slider" id="RDenoiseSlider_G"></div>
                  <input name="ImgDenoise_G" id="ImgDenoise_G" type="text" value="0" class="sliderText" readonly="true">
              </div>
            
           </form>	
           
           <form class="gokehide mstarhide" name="GammaForm" id="GammaForm" method="post" target="hideFrame" action="/form/CameraSet">
                <input name="flag" type="hidden" value="17"/>
                <input type="hidden" id="Gamma_" value="<%CameraGet("Gamma","net");%>" />
                <div class="UnitDivWB">
                    <label class="basicLabel">Gamma曲线:</label>
                    <select name="Gamma" id="Gamma" onChange="document.getElementById('GammaForm').submit()">
                      <option value="0">标准模式</option>
                      <option value="1">通透模式1</option>
                      <option value="2">通透模式2</option>
                      <option value="3">通透模式3</option>
                      <option value="4">真色彩模式</option>
                      <option value="5">宽动态范围</option>
                    </select>
                </div>
             </form>   
        </div>
    
        <div id="modeDiv">
		<!--**********modeSet*************************--> 
    	<div id="modeSet">

            <div class="modeTitle"><label><strong>模式调用</strong></label></div>
            <form name="modeSetForm" id="modeSetForm" method="post" target="hideFrame" action="/form/CameraModeSet"> 
              <input name="modeSetFlag" type="hidden" value="1"/><%CameraModeGet("modeSet","net");%>
          
                  <table class="modeTable" cellspacing="0" cellpadding="0">
                    <tr height="25px" align="center">
                      <td width="59">开始时间</td>
                      <td width="60">结束时间</td>
                      <td width="72">模式调用</td>
                      <td width="29">启用</td>
                    </tr>
                    <tr>
                      <td><input name="startH0" id="startH0" class="timeText" type="text" value="0" readonly="true" />:<input name="startM0" id="startM0" class="timeText" type="text" value="00" readonly="true" /></td>
                      <td><input name="endH0" id="endH0" class="timeText" type="text" onfocus="wheelChangeH();" onblur="linkH(1);prevent();"  />:<input name="endM0" id="endM0" class="timeText" type="text" onfocus="wheelChangeM();" onblur="linkM(1);prevent();" /></td>
                      <td><select name="ms0" id="ms0" class="mode_select"></select></td>
                      <td><input name="mc0" id="mc0" type="checkbox" value="" onclick="modeEnableSwitch(0);"/><input name="mcVal0" id="mcVal0" type="hidden" value="" /></td>
                    </tr>
                    <tr>
                      <td><input name="startH1" id="startH1" class="timeText" type="text" readonly="true" />:<input name="startM1" id="startM1" class="timeText" type="text" readonly="true" /></td>
                      <td><input name="endH1" id="endH1" class="timeText" type="text" onfocus="wheelChangeH();" onblur="linkH(2);prevent();"/>:<input name="endM1" id="endM1" class="timeText" type="text" onfocus="wheelChangeM();" onblur="linkM(2);prevent();" /></td>
                      <td><select name="ms1" id="ms1" class="mode_select">
                          </select></td>
                      <td><input name="mc1" id="mc1" type="checkbox" value="" onclick="modeEnableSwitch(1)"/><input name="mcVal1" id="mcVal1" type="hidden" value="" /></td>
                    </tr>
                    <tr>
                      <td><input name="startH2" id="startH2" class="timeText" type="text" readonly="true" />:<input name="startM2" id="startM2" class="timeText" type="text" readonly="true" /></td>
                      <td><input name="endH2" id="endH2" class="timeText" type="text" onfocus="wheelChangeH();" onblur="linkH(3);prevent();"/>:<input name="endM2" id="endM2" class="timeText" type="text" onfocus="wheelChangeM();" onblur="linkM(3);prevent();" /></td>
                      <td><select name="ms2" id="ms2" class="mode_select">	
                          </select></td>
                      <td><input name="mc2" id="mc2" type="checkbox" value="" onclick="modeEnableSwitch(2);"/><input name="mcVal2" id="mcVal2" type="hidden" value="" /></td>
                    </tr>
                    <tr>
                      <td><input name="startH3" id="startH3" class="timeText" type="text" readonly="true" />:<input name="startM3" id="startM3" class="timeText" type="text" readonly="true" /></td>
                      <td><input name="endH3" id="endH3" class="timeText" type="text" onfocus="wheelChangeH();" onblur="linkH(4);prevent();"/>:<input name="endM3" id="endM3" class="timeText" type="text" onfocus="wheelChangeM();" onblur="linkM(4);prevent();" /></td>
                      <td><select name="ms3" id="ms3" class="mode_select">
                      </select></td>
                      <td><input name="mc3" id="mc3" type="checkbox" value="" onclick="modeEnableSwitch(3);" /><input name="mcVal3" id="mcVal3" type="hidden" value="" /></td>
                    </tr>
                    <tr>
                      <td><input name="startH4" id="startH4" class="timeText" type="text" readonly="true" />:<input name="startM4" id="startM4" class="timeText" type="text" readonly="true" /></td>
                      <td><input name="endH4" id="endH4" class="timeText" type="text" onfocus="wheelChangeH();" onblur="linkH(5);prevent();"/>:<input name="endM4" id="endM4" class="timeText" type="text" onfocus="wheelChangeM();" onblur="linkM(5);prevent();" /></td>
                      <td><select name="ms4" id="ms4" class="mode_select">
                          </select></td>
                      <td><input name="mc4" id="mc4" type="checkbox" value="" onclick="modeEnableSwitch(4);" /><input name="mcVal4" id="mcVal4" type="hidden" value="" /></td>
                    </tr>
                    <tr>
                      <td><input name="startH5" id="startH5" class="timeText" type="text" readonly="true" />:<input name="startM5" id="startM5" class="timeText" type="text" readonly="true" /></td>
                      <td><input name="endH5" id="endH5" class="timeText" type="text" onfocus="wheelChangeH();" onblur="checkLastH(5);prevent();" />:<input name="endM5" id="endM5" class="timeText" type="text" onfocus="wheelChangeM();" onblur="checkH(5);prevent();" /></td>
                      <td><select name="ms5" id="ms5" class="mode_select">
                          </select></td>
                      <td><input name="mc5" id="mc5" type="checkbox" value="" onclick="modeEnableSwitch(5);"/> <input name="mcVal5" id="mcVal5" type="hidden" value="" /></td>
                    </tr>
                  </table>
              <div align="center" style="margin-top:18px;" >
                <input name="mode_enable" id="mode_enable" type="hidden" value="1" /><input name="Input" type="button" class="ButtonSet" value="保存"  onclick="modeSubmit();"/>
              </div> 
              </form>
            </div>
        
        
            <!--**********modeEdit*************************-->   
            <div id="modeEdit">
      
            <div class="modeTitle"><label><strong>模式编辑</strong></label></div>
              <form name="modeEditForm" id="modeEditForm" method="post" target="hideFrame" action="/form/CameraModeSet">
                  <%CameraModeGet("modeEdit","net");%> <%CamDefaultModeGet("r","net");%>
                      <div class="mode_editDiv">
                          <label>模式:</label>
                          <select name="mode_select" id="mode_select" class="videoSet_select" onchange="modeChange();">
                          </select>
                      </div>
                      <div class="mode_editDiv">
                          <label>名称:</label>
                          <input name="mode_text" id="mode_text" type="text" class="mode_name_text" onselectstart = "event.cancelBubble = true;"/>
                      </div>
                      <div class="mode_editDiv" id="jsICRmodeCfg">
                          <label>ICR 控制:</label>
                          <select name="C2B_Switch_Select_M" id="C2B_Switch_Select_M" class="videoSet_select">
                                <option value="0">固定夜晚</option>
                                <option value="1">固定白天</option> 
                                <option value="2">自动模式</option>
                                <option value="3">IO 输入1</option>
                                <option value="4">IO 输入2</option>
                          </select>
                      </div>
                       <div class="mode_editDiv" id="jsIRmodeCfg">
                          <label>红外模式:</label>
                          <select id="IRmode_M" name="IRmode_M" class="videoSet_select">
                                <option value="1">自动</option>
                                <option value="2">固定夜晚</option>
                                <option value="3">固定白天</option>
                          </select>
                      </div>	
					                       
                      <div class="editSliderDiv" >
                          <div class="sliderDiv">
                              <label class="sliderLabel">亮度:</label>
                              <div class="slider" id="RBrightSlider_M"></div>
                              <input name="ImgBrightness_M" id="ImgBrightness_M" type="text" value="0" class="sliderText" readonly="true">
                          </div>
                              
                          <div class="sliderDiv">
                              <label class="sliderLabel">锐度:</label>
                              <div class="slider" id="RSharpSlider_M"></div>
                              <input name="EdgeStrength_M" id="EdgeStrength_M" type="text" value="0" class="sliderText" readonly="true">
                          </div>
                          
                          <div class="sliderDiv">
                              <label class="sliderLabel">色度:</label>
                              <div class="slider" id="RHueSlider_M"></div>
                              <input name="ImgHue_M" id="ImgHue_M" type="text" value="0" class="sliderText" readonly="true">
                          </div>
                          
                          <div class="sliderDiv">
                              <label class="sliderLabel">对比度:</label>
                              <div class="slider" id="RContrastSlider_M"></div>
                              <input name="ImgContrast_M" id="ImgContrast_M" type="text" value="0" class="sliderText" readonly="true"/>
                          </div>
                          
                          <div class="sliderDiv">
                              <label class="sliderLabel">饱和度:</label>
                              <div class="slider" id="RSatuationSlider_M"></div>
                              <input name="ImgSaturation_M" id="ImgSaturation_M" type="text" value="0" class="sliderText">
                          </div>
                          <div class="sliderDiv gokehide mstarhide">
                              <label class="sliderLabel">3D 降噪:</label>
                              <div class="slider" id="RDenoiseSlider_M"></div>
                              <input name="ImgDenoise_M" id="ImgDenoise_M" type="text" value="0" class="sliderText">
                          </div>
                      </div>
                      <div>
                        <input name="mode_enable" id="mode_enable" type="hidden" value="1" />
                        <input name="" type="button" class="ButtonSet" value="默认" style="margin-left:0px;" onclick="recommand();" />
                        <input name="" type="button" class="ButtonSet" value="保存"  onclick="recommandSubmit();"/ >
                        <input name="" type="button" class="ButtonSet" value="取消"  onclick="modeEditCancel();"/ >
                      </div>
                  </form>
      
            </div>
           <!--**********end modeEdit*************************-->  
        
        
        
        </div>
    </div>
   
</div>


<div id="cameraDiv3" class="cameraDiv">
	  <div id="WBDiv">
		<form class="mstardisable" name="mcWBSetForm" id="mcWBSetForm" method="post" target="hideFrame" action="/form/CameraSet">
		  <input name="flag" type="hidden" value="3">	
			<%CameraGet("WBConf","net");%>
			
			<div class="UnitDivWB">
			<label class="basicLabel">模式选择:</label>
			<select id="WBMode_Select" name="WBMode_Select" onChange="WB_Mode_SelectSet();">
						 <option value="0">自动</option>
						 <option value="1">手动</option>
						 <option value="2">晴天</option>
						 <option value="3">阴天</option>
						 <option value="4">白炽灯</option>
						 <option value="5">荧光灯</option>
						 <option value="6">钠灯</option>
		      </select>
			</div>
			
			<div class="UnitDivWB" style="margin-top:5px;">
				<label class="WBbasicLabel">红色增益:</label>
				<div class="imgSlider" id="Slider_RedGain"></div>
				<input name="WhiteBalanceRedGain" id="WhiteBalanceRedGain" type="text" value="0" class="sliderText" onChange="" >
			</div>
			
			<div class="UnitDivWB">
				<label class="WBbasicLabel">蓝色增益:</label>
				<div class="imgSlider" id="Slider_BlueGain"></div>
				<input name="WhiteBalanceBlueGain" id="WhiteBalanceBlueGain" type="text" value="0" class="sliderText" onChange="" >
			</div>
	  </form>

   </div>

</div>

<div id="cameraDiv4" class="cameraDiv">
    <form name="mcCustomSetForm" method="post" target="hideFrame" action="/form/CameraSet">
    <div style="margin-left:170px;">
      <input type="hidden" name="flag" value="5">
      <input width="91"  name="factorySetBtn" id="factorySetBtn" type="button" class="bigbt1" onClick="factorySet();" value="恢复默认值 "  >
    </div>
    </form>
</div>

<script language="javascript" src="../javascript/cameraSetLast.js"></script>
</body>
</html>

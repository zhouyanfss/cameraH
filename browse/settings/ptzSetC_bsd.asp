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
<input type="hidden" id="PAGE_LANGUAGE" name="language" value="1" />
<iframe name="hideframe" id="hideframe" style=" display:none"></iframe>
<div class="topMenu">
	<ul style="width:1050px">
        <li class="choose" onclick="sysShow('hankYunTai',0)" style="display:block;">预置位</li>
        <li class="choose" onclick="sysShow('hankYunTai',1)" style="display:none;">水平扫描</li>
        <li class="choose" onclick="sysShow('hankYunTai',2)" style="display:none;">花样扫描</li>
        <li class="choose" onclick="sysShow('hankYunTai',3)" style="display:none">自动归位</li>
        <li class="choose" onclick="sysShow('hankYunTai',4);loadAtpParas()" style="display:block;">预置点巡视</li>
        <li class="choose" onclick="sysShow('hankYunTai',5)">协议设置</li>
        <li class="choose" onclick="sysShow('hankYunTai',6)" style="display:none;">透明串口</li>
    </ul>
</div>
<div class="ptzFunWin">
	<div class="playerWin" id="videoWin">
		<script language="javascript" src="../javascript/browseEm.js"></script>
    </div>
    <div class="ptzWin">
<!--PTZ面板-->
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
      				<div class="ptzSelectLab"><label>水平速度</label></div>
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
      			<div class="ptzSelectLab"><label>垂直速度</label></div>
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
		<input type="hidden" name="language" value="cn" />
		<div class="posHank">
    		<label>序号:&nbsp;</label>
        	<select name="presetNum" id="jsPresetNum" onchange="ajaxHankGet('/form/presetAjax','posHankForm','jsPresetNum')">
        	</select>
    	</div>
    	<div class="posHank" style="position:relative">
    		<label>标题:&nbsp;</label>
        	<input type="text" id="jsPresetName" name="presetName"  class="titleText" maxlength="16" />
			<input class="titleSave" type="button" value="保存" onclick="presetSubmit(2)" />
    	</div>
    	<br />
        <br />
    	<div class="posHank">
			<input class="posBto" type="button" value="保存"  onclick="presetSubmit(3);" />
        	<input class="posBto" type="button" value="调用" onclick="presetSubmit(4)" />
        	<input class="posBto" type="button" value="删除" onclick="presetSubmit(5);" />
        	<input class="posBto" type="button" value="删除所有" onclick="presetSubmit(6);" style="display:none" />
    	</div>
    </form>
</div>

<div class="hankYunTai">
	<form id="autopanForm" method="post" action="/form/setSpecialFunc" target="hideframe">
    	<!--<div class="horiHank" style="display:none">
        	<input type="hidden" name="flag" id="jsAutopanFlag" />
        	<input type="hidden" name="existFlag" id="jsAutopanExist" />
			<input type="hidden" name="language" value="cn" />
        	<label>序号:&nbsp;</label>
            <select id="jsAutopanNum" name="autopanNum" onchange="ajaxHankGet('/form/autopanAjax','autopanForm','jsAutopanNum')">
            	<option value="0">1</option>
                <option value="1">2</option>
                <option value="2">3</option>
                <option value="3">4</option>
            </select>
        </div>
        <div class="horiHank" style="display:none">
        	<label>方向:&nbsp;</label>
            <select id="jsAutopanDir" name="AutopanDir" onchange="autopanSubmit(2)">
            	<option value="0">右</option>
                <option value="1">左</option>
            </select>
        </div>
        <div class="horiHank" style="display:none">
        	<label>速度:&nbsp;</label>
            <select id="jsAutopanSpd" name="AutopanSpd" onchange="autopanSubmit(3)">
            </select>
        </div>
        <div class="horiHank" style="display:none">
        	<label>驻留时间:&nbsp;</label>
            <select id="jsAutopanDelaytime" name="AutopanDelaytime" onchange="autopanSubmit(4)">
            </select>
        </div>-->
<!--        <div class="horiHank" style="position:relative">
    		<label>标题:&nbsp;</label>
        	<input type="text" id="jsAutopanName" name="AutopanTitle" class="titleText"  maxlength="16" />
        	<input type="button" value="保存" class="titleSave" onclick="autopanSubmit(5)" />
    	</div>-->
        <br />
        <br />
        <div class="horiHank" style="margin-left:170px">
         	<input type="hidden" name="flag" id="jsAutopanFlag" />
			<input type="hidden" name="language" value="cn" />
        	<input class="posBto" type="button" id="jsAutoPanCall" value="调用" onclick="callAtp()" />
        </div>
        <!--<div class="horiHank" style="display:none">
			<input class="posBto" type="button" id="jsAutoPanStart" value="开始" onclick="autopanSubmit(6);" />
    		<input class="posBto" type="button" id="jsAutoPanStop" value="结束" onclick="autopanSubmit(7);" style="display:none;background-image:url(../images/savaSet_red.gif)"  />
        	<input class="posBto" type="button" id="jsAutoPanCall" value="调用" onclick="autopanSubmit(8)" />
        	<input class="posBto" type="button"  id="jsAutoPanDel" value="删除" onclick="autopanSubmit(9);" />
        	<input class="posBto" type="button" id="jsAutoPanDelAll" value="删除所有" onclick="autopanSubmit(10);" />
    	</div>-->
    </form>
</div>

<div class="hankYunTai">
	<form id="patternForm" method="post" action="/form/setSpecialFunc" target="hideframe">
    	<!--<div class="posHank" style="display:none">
       		<input type="hidden" name="flag" id="jspatternFlag" />
        	<input type="hidden" name="existFlag" id="jspatternExist" />
			<input type="hidden" name="language" value="cn" />
    		<label>序号:&nbsp;</label>
        	<select id="jsPatternNum" name="patternNum" onchange="ajaxHankGet('/form/patternAjax','patternForm','jsPatternNum')">
        		<option value="0">1</option>
            	<option value="1">2</option>
            	<option value="2">3</option>
            	<option value="3">4</option>
        	</select>
    	</div>
    	<div class="posHank" style="position:relative;display:none">
    		<label>标题:&nbsp;</label>
        	<input type="text" id="jsPatternName" name="Patterntitle" maxlength="16" class="titleText" />
        	<input class="titleSave" type="button" id="jsPatternSvNm" value="保存" onclick="patternSubmit(2)" />
    	</div>-->
        <br />
        <br />
        <div class="posHank" style="margin-left:170px">
        	<input type="hidden" name="flag" id="jspatternFlag" />
			<input type="hidden" name="language" value="cn" />
        	<input class="posBto" type="button" value="调用" id="jsPatternRun" onclick="callPtn();" />
        </div>
    	<!--<div class="posHank">
        	<input class="posBto" type="button" value="开始" id="jsPatternStart" onclick="patternSubmit(3);" />
    		<input class="posBto" type="button" value="结束" id="jsPatternStop" onclick="patternSubmit(4);" style="display:none;background-image:url(../images/savaSet_red.gif)" />
        	<input class="posBto" type="button" value="调用" id="jsPatternRun" onclick="patternSubmit(5);" />
        	<input class="posBto" type="button" value="删除" id="jsPatternDel" onclick="patternSubmit(6);" />
        	<input class="posBto" type="button" value="删除所有" id="jsPatternDelAll" onclick="patternSubmit(7);" />
    	</div>-->
    </form>
</div>

<div class="hankYunTai">
	<form id="autoBackForm" method="post" action="/form/autoBackSet" target="hideframe">
			<input type="hidden" id="autoBackActGet" value=''  />
			<input type="hidden" id="autoBackPwOffGet" value=''  />
			<input type="hidden" id="autoBackTimeGet" value=''  />
		    <div class="autoBack">
        	<label>归位时间:&nbsp;</label>
            <select name="autoBackTime" id="jsAutoBackTime">
            	<option value="0">关</option>
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
        
        	<label>执行动作:&nbsp;</label>
            <select name="autoBackAct" id="jsAutoBackAct"></select>
        </div>
        <div class="autoBack">

        	<label>断电恢复位置:&nbsp;</label>
            <select name="autoBackPwOff" id="jsAutoBackPwOff">
            	<option value="0">关</option>
                <option value="1">开</option>
            </select>
        </div>
        <br />
        <input style="margin-left:100px" class="posBto" type="button" value="保存" onclick="ajaxPost('autoBackForm')"/>
    </form>
</div>

<div class="hankYunTai">
	<form id="tourForm" method="post" action="/form/tourSet" target="hideframe">
    	<input type="hidden" name="flag" id="jsTourFlag" />
        <input type="hidden" name="existFlag" id="jsTourExist" />
		<input type="hidden" name="language" value="cn" />
		<div class="posHank">
    		<label>巡视号:&nbsp;</label>
        	<select name="tourNum" id="jsTourNum" onchange="ajaxHankGet('/form/tourAjax','tourForm','jsTourNum')">
            	<option value="0">1</option>
                <option value="1">2</option>
                <option value="2">3</option>
        	</select>
    	</div>
    	<!--<div class="posHank" style="position:relative">
    		<label>预置点:&nbsp;</label>
        	<input type="text" id="jsPresetValue" name="presetValue"  class="titleText" maxlength="3" />
    	</div>
    	<div class="posHank" style="position:relative">
    		<label>时间间隔(s):&nbsp;</label>
        	<input type="text" id="jsStayInterval" name="StayInterval"  class="titleText" maxlength="3" />
    	</div>
    	<div class="posHank" style="position:relative">
    		<label>巡视时限(h):&nbsp;</label>
        	<input type="text" id="jsTourMaxTime" name="TourMaxTime"  class="titleText" maxlength="3" />
    	</div>-->
    	<br />
        <br />
    	<div class="patrol" style="margin-left:20px">
      		<!--<input class="posBto" type="button" value="保存" onclick="tourSubmit(1)" />-->
        	<!--<input class="posBto" type="button" value="设置" onclick="tourSubmit(1)" />-->
            <input class="posBto" style="margin-left:30px" type="button" value="调用" onclick="tourSubmit(2)" />
        	<!--<input class="posBto" type="button" value="删除预置位" onclick="tourSubmit(5)" />
        	<input class="posBto" type="button" value="停止" onclick="tourSubmit(0)" />
        	<input class="posBto" type="button" value="清除" onclick="tourSubmit(3)" />
            <br />
            <br />
        	<input class="posBto" type="button" value="水平巡视" onclick="tourSubmit(6)" />
        	<input class="posBto" type="button" value="垂直巡视" onclick="tourSubmit(7)" />
        	<input class="posBto" type="button" value="设置时限" onclick="tourSubmit(8)" />-->
      	</div>
       <!-- <div class="posHank">
    		<label>巡视号:&nbsp;</label>
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
    		<label>预置点:&nbsp;</label>
        	<select id="jsPstNumber" name="presetNumber"></select>
    	</div>
        <div class="posHank">
    		<label>时间间隔:</label>
        	<select id="jsDelayTour" name="delayTour"></select>
    	</div>
    	<br />
        <br />
    	<div class="patrol">
      		<input class="posBto" type="button" value="增加预置点" onclick="tourSubmit(3)" />
        	<input class="posBto" type="button" value="清除预置点" onclick="tourSubmit(4)" />
            <input class="posBto" type="button" value="清除巡航" onclick="tourSubmit(5)" />
        	<input class="posBto" type="button" value="调用巡航" onclick="tourSubmit(6)" />
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
		<label>地址：</label>
			<select name="cameraAddr" id="cameraAddr"  onChange="ptzSpecialSubmit(1);">	
			</select>
	</div>
	<div class="LaserPara">
		<label>协议：</label>
		<select name="protocol" id="protocol"  onChange="ptzSpecialSubmit(2);">	         
			<option value="pelco-d">Pelco-D</option>
			<option value="pelco-p">Pelco-P</option>
			<option value="samsung">Samsung</option>
		</select>
	</div>
	<div class="LaserPara">
		<label>波特率：</label>
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
		<label>3D定位协议：</label>
		<select name="protocol3D" id="protocol3D"  onChange="ptzSpecialSubmit(4);">	         
			<option value="0">Pelco-DH</option>
			<option value="1">Pelco-HK</option>
		</select>
	</div>
    <div class="LaserPara">
		<label>用户模式：</label>
		<select name="userMode" id="userMode"  onChange="ptzSpecialSubmit(5);">	         
			<option value="0">通用</option>
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
	<label style="line-height:40px">透明串口：</label>
    <select style="width:120px" name="rs485transEnable" id="rs485transEnable"  onChange="document.getElementById('rs485transEnableFrom').submit()">	
		<option value="0">关闭</option>
		<option value="1">开启</option>
	</select>
</form>
	<label style="line-height:40px" class="ptzRow">数据传输：</label>
    <p>
	<form id="rs485transForm" name="rs485transForm" target="hideframe" method="post" action="/form/rs485Send">
		<input class="posBto" type="button" id="rs485send" value="发送" onclick="rs485trans_send();" />
        <textarea id="sendtext" name="sendtext" rows="4" cols="60"></textarea>
	</form>
    </p>
    <p>
	<form id="rs485recvForm" name="rs485recvForm" target="hideframe" method="post" action="/form/rs485Read">
		<input class="posBto" type="button" id="rs485recv" value="读取" onclick="rs485trans_recv();" />
        <textarea id="recvtext" readonly="readonly" rows="4" cols="60"></textarea>
    </form>
	</p>
</div>

<script type="text/javascript" src="../javascript/PTZInitL.js"></script>
</body>
</html>


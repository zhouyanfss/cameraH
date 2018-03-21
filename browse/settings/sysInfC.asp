<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link type="text/css" rel="stylesheet" href="../css/sysInf.css" />
<script type="text/javascript" src="../javascript/jquery.js"></script>
<script type="text/javascript" src="../javascript/common.js"></script>
<script type="text/javascript" src="../javascript/cookie.js"/></script>
<script type="text/javascript" src="../javascript/sysInf.js"></script>
<script type="text/javascript" >
window.onload = function(){
	sysSetInit();
	sysShow('hankClass',0);
	sysSetInit = null;
	try{
		document.execCommand('BackgroundImageCache', false, true);
    }catch(e){
	};
}
</script>
</head>

<body>
<input type="hidden" id="PAGE_LANGUAGE" value="1" />
<input type="hidden" id="Hi3518E" value='<%videoparaGet("hi3518e", "net");%>' />
<input type="hidden" id="Hi3518EV200" value='<%videoparaGet("hi3518ev200", "net");%>' />
<input type="hidden" id="Hi3516CV300" value='<%videoparaGet("hi3516cv300", "net");%>' />
<iframe onload="iframeLoad()" id="hideFrame" name="hideFrame" style=" display:none"></iframe>
<div class="topMenu" style="min-width:280px">
	<ul style="width:280px">
    	<li class="choose" onclick="sysShow('hankClass',0)">系统信息</li>
        <li class="choose" onclick="sysShow('hankClass',1)">时间</li>
        <li class="choose" onclick="sysShow('hankClass',2)">维护</li>
    </ul>
</div>
<div class="hankClass" id="firstPage">

	<div class="hankName"><label>基本信息</label></div>
	    <div class="content contTop">
	    	<label class="explainLeft">版本号:</label><label class="hank"><%VersionGet("version","net");%></label>
 		   	<label class="explain">时区:</label><label class="hank eleHide" id="jsHankTimeZone"><%TimezoneGet("Tzone","net");%></label>
	    </div> 
   		<div class="content contBot" style="width:1000px">
        	<label class="explainLeft">产品系列:</label><label class="hank"><%SystemInfoGet("devicemodel","net");%>系列</label>
			<label class="explain">序列号:</label><label class="hank"><%SystemInfoGet("serialnum","net");%></label>
        </div>
        
    <div class="hankName"><label>网络配置</label></div>
	    <div class="content contTop">
	    	<label class="explainLeft">MAC地址:</label><label class="hank eleHide" id="jsSysHankMAC"><%NetparaGet("MACAddress", "net");%></label>
	    	<label class="explain">IP 地址:</label><label class="hank"><%NetparaGet("outIPAddr","net");%></label>
	    </div>
	    <div class="content contBot">
	    	<label class="explainLeft">默认网关:</label><label class="hank"><%NetparaGet("outGateway","net");%></label>
	    	<label class="explain">子网掩码:</label><label class="hank"><%NetparaGet("outMaskAddr","net");%></label>
	    </div>

    <div class="hankName"><label>报警设置</label></div>
	    <div class="content contTop">
	        <label class="explainLeft">报警服务器1 IP:</label><label class="hank"><%NetparaGet("AlarmServerIP1","net");%></label>
	        <!--<label class="explain">报警关联:</label><label class="hankWord eleHide" id="jsHankAlarmState"><alarmparaGet("alarmAccess","net");%></label>-->
	    </div>
        <div class="content">
	        <label class="explainLeft">报警服务器2 IP:</label><label class="hank"><%NetparaGet("AlarmServerIP2","net");%></label>
	    </div>
        <div class="content contBot">
	        <label class="explainLeft">报警服务器3 IP:</label><label class="hank"><%NetparaGet("AlarmServerIP3","net");%></label>
	    </div>
    
    <div class="hankName"><label>NTP 设置</label></div>
 	   <div class="content contTop contBot">
 	       <label class="explainLeft">NTP 服务器 :</label><label class="hank" id="jshankNTPIP"><%NTPGet("ntpip", "net");%></label>
<!-- 	       <label class="explain">状态:</label><label class="hankWord eleHide" id="jsHankNTPState"><\%NTPGet("ntpstate", "net");%></label>-->
	    </div>
    
    <div class="hankName" id="h264"><label>视频参数设置</label></div>
    	<img src="../images/nolist.gif" style="display:none" />
        <img src="../images/list.gif" style="display:none" />
	    <div class="h264para contTop"><img src="../images/list.gif" class="closepic" onclick="show(0)" /><label>&nbsp;公共参数:</label></div>
        	<div class="sonHank">
	        	<div class="content">
	            	<label class="sonexplain">亮度:</label><label class="hank"><%CameraGet("ImgBrightness", "net");%></label>
 		           	<label class="explain">对比度:</label><label class="hank"><%CameraGet("ImgContrast", "net");%></label>
 	           </div>
 	           <div class="content">
 		           	<label class="sonexplain">饱和度:</label><label  class="hank"><%CameraGet("ImgSaturation", "net");%></label>
 		           	<label class="explain">锐度:</label><label  class="hank"><%CameraGet("EdgeStrength", "net");%></label>
 	           </div>
            </div>
            
        <div class="h264para" style="margin-top:3px;"><img src="../images/list.gif" class="closepic" onclick="show(1)" /><label>&nbsp;主码流参数:</label></div>
        	<div class="sonHank">
 		       	<div class="content">
 		           	<label class="sonexplain">分辨率:</label><label class="hank eleHide" id="jsMainResol"><%videoparaGet("resolution", "net");%></label>
 		           	<label class="explain">帧率:</label><label class="hank"><%videoparaGet("framerate", "net");%></label>
 	           </div>
 	           <div class="content">
					<input type="hidden" id="bitRateControl" value='<%videoparaGet("BitRateControlSelect","net");%>'  />
					<label class="sonexplain">码率:</label><label class="hank eleHide" id="jsMainBitRate"><%videoparaGet("BitRate", "net");%></label>
					<label class="explain">I/P 率:</label><label class="hank"><%videoparaGet("IPRate", "net");%></label>
				</div>
				<div class="content" id="payloadContent">
						<input type="hidden" id="payloadType" value='<%videoparaGet("Payload", "net");%>' />
						<label class="sonexplain">编码格式:</label><label class="hank" id="jsMainPayload"></label>
				</div>
            </div>
            
        <div class="h264para" id="MinorStreamInfoLabel1" style="margin-top:3px;"><img src="../images/list.gif" class="closepic" onclick="show(2)" /><label>&nbsp;副码流参数:</label></div>
        	<div class="sonHank contBot" id="MinorStreamInfoLabel2">
	        	<div class="content">
	            	<label class="sonexplain">分辨率:</label><label class="hank eleHide" id="jsExtResol"><%ExtVideoparaGet("resolution", "net");%></label>
	            	<label class="explain">帧率:</label><label class="hank"><%ExtVideoparaGet("framerate", "net");%></label>
	            </div>
	            <div class="content">
					<input type="hidden" id="ExtBitRateControl" value='<%ExtVideoparaGet("BitRateControlSelect","net");%>' />
					<label class="sonexplain">码率:</label><label class="hank eleHide" id="jsExtBitRate"><%ExtVideoparaGet("BitRate", "net");%></label>
					<label class="explain">I/P 率:</label><label class="hank"><%ExtVideoparaGet("IPRate", "net");%></label>
				</div>
				<div class="content" id="extPayloadContent">
						<input type="hidden" id="extPayloadType" value='<%ExtVideoparaGet("Payload", "net");%>' />
						<label class="sonexplain">编码格式:</label><label class="hank" id="jsExtPayload"></label>
				</div>
           </div>
    
    <div class="hankName" id="MjpegInfoLabel1"><label>MJPEG 参数设置</label></div>
    	<div class="content contTop contBot" id="MjpegInfoLabel2">
        	<label class="explainLeft">分辨率:</label><label class="hank eleHide" id="jsMJPEGResol"><%mjpegparaGet("resolution", "net");%></label>
        	<label class="explain">帧率:</label><label class="hank"><%mjpegparaGet("frame", "net");%></label>
        </div>
</div>    
<!---->
<div class="hankClass">
	<div class="hankName"><label>时区设置</label></div>
    <div style="display:none">
    	<input id="timeZone" type="text" value='<%TimezoneGet("Tzone","net");%>' />
    	<input id="SummerMode" type="text" value='<%TimezoneGet("daylightenable","net");%>'  />
    </div>
    <br />
    <form class="clearSpace" name="时区" id="jsTimezoneForm" method="post" action="/form/TimezoneSet" target="hideFrame">
    	<input type="hidden" name="language" value="cn" />
    	<div class="content">
        	<label class="setExplain">时区选择:&nbsp;</label>
            <select class="selectLab" style="width: 450px" name="Tzone" id="jsTimeZone" >
            	<option value="0">(GMT-12:00) 日界线西</option>
          		<option value="1">(GMT-11:00) 中途岛，萨摩亚群岛</option>
          		<option value="2">(GMT-10:00) 夏威夷</option>
          		<option value="3">(GMT-09:00) 阿拉斯加</option>
          		<option value="4">(GMT-08:00) 蒂华纳，下加利福尼亚州，太平洋时间（美国和加拿大）</option>
          		<option value="5">(GMT-07:00) 奇瓦瓦，拉巴斯，马萨特兰，山地时间（美国和加拿大），亚利桑那</option>
          		<option value="6">(GMT-06:00) 瓜达拉哈拉，墨西哥城，中美洲</option>
          		<option value="7">(GMT-05:00) 波哥大，利马，里奥布郎库，东部时间（美国和加拿大），印地安那州（东部）</option>
          		<option value="8">(GMT-04:00) 加拉加斯，拉巴斯，圣地亚哥，马瑙斯</option>
          		<option value="9">(GMT-03:30) 纽芬兰</option>
          		<option value="10">(GMT-03:00) 巴西利亚，布宜诺斯艾利斯，乔治敦，格陵兰，蒙得维的亚</option>
          		<option value="11">(GMT-02:00) 中大西洋</option>
          		<option value="12">(GMT-01:00) 佛得角群岛，亚速尔群岛</option>
          		<option value="13">(GMT) 格林威治标准时间:都柏林，爱丁堡，伦敦，里斯本，卡萨布兰卡，罗维亚，雷克雅未克</option>
          		<option value="14">(GMT+01:00) 阿姆斯特丹，柏林，伯尔尼，罗马，斯德哥尔摩，贝尔格莱德，布拉迪斯拉发，布达佩斯，布鲁塞尔，哥本哈根，马德里，巴黎，萨拉热窝，斯科普里，华沙，萨格勒布，中非西部</option>
         		<option value="15">(GMT+02:00) 安曼，贝鲁特，哈拉雷，比勒陀利亚，赫尔辛基，基辅，里加，索非亚，塔林，开罗，明斯克，温得和克，雅典，布加勒斯特，伊斯坦布尔，耶路撒冷</option>
          		<option value="16">(GMT+03:00) 巴格达，第比利斯，科威特，利雅得，莫斯科，圣彼得堡，伏尔加格勒，内罗毕</option>
          		<option value="17">(GMT+03:30) 德黑兰</option>
          		<option value="18">(GMT+04:00) 阿布扎比，埃里温，巴库</option>
          		<option value="19">(GMT+04:30) 喀布尔</option>
         		<option value="20">(GMT+05:00) 叶卡捷琳堡，伊斯兰堡，卡拉奇，塔什干</option>
          		<option value="21">(GMT+05:30) 马德拉斯，加尔各答，孟买，新德里，斯里哈亚华登尼普拉</option>
          		<option value="22">(GMT+05:45) 加德曼都</option>
          		<option value="23">(GMT+06:00) 阿拉木图，新西伯利亚，阿斯塔纳，达卡</option>
          		<option value="24">(GMT+06:30) 仰光</option>
          		<option value="25">(GMT+07:00) 克拉斯诺亚尔斯克，曼谷，河内，雅加达</option>
          		<option value="26">(GMT+08:00) 北京，重庆，香港特别行政区，乌鲁木齐，吉隆坡，新加坡，台北，伊尔库茨克，乌兰巴图</option>
          		<option value="27">(GMT+09:00) 大坂，札幌，东京，汉城，雅库茨克</option>
         		<option value="28">(GMT+09:30) 阿德莱德，达尔文</option>
          		<option value="29">(GMT+10:00) 布里斯班，符拉迪沃斯托克，关岛，摩尔兹比港，霍巴特，詹培拉，摩尔本，悉尼</option>
          		<option value="30">(GMT+11:00) 马加丹，所罗门群岛</option>
          		<option value="31">(GMT+12:00) 奥克兰，惠灵顿，斐济，堪察加半岛，马绍尔群岛</option>
         		<option value="32">(GMT+13:00) 努库阿洛法</option>
           </select>
        </div>
        <div class="content" style="margin-top: 8px">
        	<label class="setExplain">夏令时:&nbsp;</label>
            <div class="radioSelect">
            	<input type="radio" name="daylightenable" id="jsSummerMode1" value="1" />
                <label for="jsSummerMode1">开启</label>
            </div>
			<div class="radioSelect">
            	<input type="radio" name="daylightenable" id="jsSummerMode0" value="0" />
                <label for="jsSummerMode0">关闭</label>
            </div>
        </div>    
        <div class="content contButton contBot" style="margin-left:50px">
             <input class="ButtonLeft" type="button" value="保存" onclick="timezoneSet()" />
      	   	 <input class="ButtonRight" type="button" value="取消" onclick="timezoneReset()" />   
        </div>
    </form>

	<div class="hankName"><label>NTP 设置</label></div>
    <br />
    <input id="NTPIP" type="hidden" value='<%NTPGet("ntpip", "net");%>' />
    <input id="synHourGet" type="hidden" value='<%NTPGet("synHour", "net");%>' />
    <input id="synMinGet" type="hidden" value='<%NTPGet("synMin", "net");%>' />
    <input id="synSecGet" type="hidden" value='<%NTPGet("synSec", "net");%>' />
    <input id="synIntervalGet" type="hidden" value='<%NTPGet("synInterval", "net");%>' />
    <input id="NTPEnableGet" type="hidden" value='<%NTPGet("ntpenable", "net");%>' />

    <form class="clearSpace" id="synNTPForm" method="post" action="/form/NTPSet">
    	<input type="hidden" name="flag" value="1" />
       <div class="content" style="margin-top: 8px;margin-left: 78px">
            <div class="radioSelect">
              <input type="radio" name="ntpenable" id="jsNTPEnable1" value="1" />
                <label for="jsNTPEnable1">开启</label>
            </div>
            <div class="radioSelect">
              <input type="radio" name="ntpenable" id="jsNTPEnable0" value="0" />
                <label for="jsNTPEnable0">关闭</label>
            </div>
        </div>    
        <div class="content" id="jsNTPserDiv" style="height: 24px;">
        	<label class="setExplain">NTP 服务器 :&nbsp;</label>
            <input class="showselect" name="ntpip" id="jsNTPIP" type="text" value="" style="margin-top:2px" />
        </div>
        <div class="content">
        	<label class="setExplain">同步时间:&nbsp;</label>
        	<input type="text" class="synTime" id="jsSynHour" name="synHour" maxlength="2"  /><label>&nbsp;:&nbsp;</label>
            <input type="text" class="synTime" id="jsSynMin" name="synMin" maxlength="2"  /><label>&nbsp;:&nbsp;</label>
            <input type="text" class="synTime" id="jsSynSec" name="synSec" maxlength="2"  />
        </div>
        <div class="content">
        	<label class="setExplain">同步间隔(小时):&nbsp;</label>
            <select id="jsSynInterval" name="synInterval" class="selectLab" style="width:43px;">
            	<option value="6">6</option>
                <option value="12">12</option>
                <option value="24">24</option>
            </select>
        </div>
        <div class="content contButton contBot" style="margin-left:50px">
             <input class="ButtonLeft" type="button" value="保存" onclick="synNTPsubmit()" />
       	   	 <input class="ButtonRight" type="button" value="取消" onclick="synNTPreset()"  />   
        </div>
    </form>
    
    <div class="hankName"><label>即时同步</label></div>
    <br />
    <form class="clearSpace" name="" id="PCSynForm" method="get" action="/form/CameraTimeSet" target="hideFrame">
    	<div class="content">
        	<label class="setExplain">设备时间:&nbsp;</label><label id="equiTime" style="margin-top:3px">&nbsp;</label>
        </div>
    	 <div class="content" id="jsPCtimeDiv" style="height: 24px;">
        	<label class="setExplain">本地 PC 时间:&nbsp;</label><label id="loctime" style="height:21px; float:left; font-size:14px; margin-top:3px">&nbsp;</label>
            <input type="hidden" name="localtime" id="jsPCUCTTime"  />
            <input type="hidden" name="Tzone" id="jsSynTzone" />
        </div>
        <div class="content contButton contBot" style="margin-left:50px">
             <input class="ButtonLeft" type="button" id="jsNTPSyn" value="NTP" onclick="timeSynNow('NTP')" />
             <input class="ButtonRight" type="button" value="本地" onclick="timeSynNow('PC')" />   
        </div>
    </form>
 </div>   
<!---->
<div class="hankClass">
    <div class="hankName"><label>软件升级</label></div>
    <br />
    <form class="clearSpace" id="updateForm" name="FileUpload" method="post" enctype="multipart/form-data" action="/form/upload" target="hideFrame">
    	<input type="hidden" name="language" value="cn" /><input type="hidden" name="type" id="jsUpdateType" value="" />
      <input type="hidden" name="reset" id="jsUpdateReset" value="0" />
        <div class="content" style="margin-left:0">
		    <input class="CAupload" type="file" id="jsUpdateFile" name="fileName" />
            <label name="jsUploadTip" style="font-size:13px; margin-top:2px">&nbsp;(请选择正确格式的升级文件)</label>
        </div>
        <div class="content" style="margin-top:10px">
            <label for="jsConfigkeep" style="vertical-align:middle; margin-left:40px;">保留配置文件:</label>
            <input id="jsConfigkeep" type="checkbox" value="0" style="float: left; margin-left:2px; vertical-align:middle; padding:2px" />
        </div>
        <div class="content contBot contButton">
            <input class="ButtonOnly" type="button" value="上传" onclick="fileUpload()" /> 
        </div>   
    </form>
    
    <div class="hankName"><label>恢复出厂设置</label></div>
    <br />
    <form class="clearSpace" id="recoverForm" method="post" action="/form/FatorySet" target="hideFrame">
    	<input type="hidden" name="language" value="cn" />
    	<div class="content">
	    	<label name="jsUploadTip" class="fileSelect">将配置恢复到出厂默认设置</label>
        </div>
        <div class="content" style="margin-top:10px">
            <label for="jsIPkeep" style="font-family:Tahoma, Geneva, sans-serif;vertical-align:middle; margin-left:40px;">保持IP不变:</label>
            <input id="jsIPkeep" type="checkbox" name="IPkeep" value="1" checked="checked" style="float: left; margin-left:2px; vertical-align:middle; padding:2px" />
        </div>
        <div class="content contBot contButton">
        	<input class="ButtonOnly" type="button" value="恢复设置" onclick="recoverSet()" />
        </div>
    </form>
    
    <div class="hankName"><label>系统重启</label></div>
    <br />
    <form class="clearSpace" id="rebootForm" method="post" action="/form/reboot" target="hideFrame">
    	<input type="hidden" name="language" value="cn" />
    	<div class="content">
        	<label name="jsUploadTip" class="fileSelect">重启完毕后页面将重新载入</label>
        </div>
        <div class="content contButton contBot">
        	<input class="ButtonOnly" type="button" value="重启" onclick="reboot()" />
        </div>
    </form>   
</div>	
</body>
</html>

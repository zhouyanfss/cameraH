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
<input type="hidden" id="PAGE_LANGUAGE" value="0" />
<input type="hidden" id="Hi3518E" value='<%videoparaGet("hi3518e", "net");%>' />
<input type="hidden" id="Hi3518EV200" value='<%videoparaGet("hi3518ev200", "net");%>' />
<input type="hidden" id="Hi3516CV300" value='<%videoparaGet("hi3516cv300", "net");%>' />
<iframe onload="iframeLoad()" id="hideFrame" name="hideFrame" style=" display:none"></iframe>
<div class="topMenu" style="min-width:280px">
	<ul style="width:280px">
    	<li class="choose" onclick="sysShow('hankClass',0)">System</li>
        <li class="choose" onclick="sysShow('hankClass',1)">Time</li>
        <li class="choose" onclick="sysShow('hankClass',2)">Advanced</li>
    </ul>
</div>
<div class="hankClass" id="firstPage">

	<div class="hankName"><label>Basic information</label></div>
	    <div class="content contTop">
	    	<label class="explainLeftEN">Version:</label><label class="hank"><%VersionGet("version","net");%></label>
 		   	<label class="explain">Time zone:</label><label class="hank eleHide" id="jsHankTimeZone"><%TimezoneGet("Tzone","net");%></label>
	    </div> 
        <div class="content contBot" style="width:1000px">
        	<label class="explainLeftEN">Product info:</label><label class="hank"><%SystemInfoGet("devicemodel","net");%> series</label>
			<label class="explain">SerialNum:</label><label class="hank"><%SystemInfoGet("serialnum","net");%></label>
        </div>
   
    <div class="hankName"><label>Network settings</label></div>
	    <div class="content contTop">
	    	<label class="explainLeftEN">MAC address:</label><label class="hank eleHide" id="jsSysHankMAC"><%NetparaGet("MACAddress", "net");%></label>
	    	<label class="explain">IP address:</label><label class="hank"><%NetparaGet("outIPAddr","net");%></label>
	    </div>
	    <div class="content contBot">
	    	<label class="explainLeftEN">Default gateway:</label><label class="hank"><%NetparaGet("outGateway","net");%></label>
	    	<label class="explain">Subnet mask:</label><label class="hank"><%NetparaGet("outMaskAddr","net");%></label>
	    </div>

    <div class="hankName"><label>Alarm settings</label></div>
	    <div class="content contTop">
	        <label class="explainLeftEN">Alarm server 1 IP:</label><label class="hank"><%NetparaGet("AlarmServerIP1","net");%></label>
	       <!-- <label class="explain">Alarm contact:</label><label class="hankWord eleHide" id="jsHankAlarmState"><alarmparaGet("alarmAccess","net");%></label>-->
	    </div>
         <div class="content">
	        <label class="explainLeftEN">Alarm server 2 IP:</label><label class="hank"><%NetparaGet("AlarmServerIP2","net");%></label>
	    </div>
        <div class="content contBot">
	        <label class="explainLeftEN">Alarm server 3 IP:</label><label class="hank"><%NetparaGet("AlarmServerIP3","net");%></label>
	    </div>
    
    <div class="hankName"><label>NTP settings</label></div>
 	   <div class="content contTop contBot">
 	       <label class="explainLeftEN">NTP server :</label><label class="hank" id="jshankNTPIP"><%NTPGet("ntpip", "net");%></label>
<!-- 	       <label class="explain">State:</label><label class="hankWord eleHide" id="jsHankNTPState"><\%NTPGet("ntpstate", "net");%></label>-->
	    </div>
    
    <div class="hankName" id="h264"><label>video settings</label></div>
    	<img src="../images/nolist.gif" style="display:none" />
        <img src="../images/list.gif" style="display:none" />
	    <div class="h264para contTop">
        	<img src="../images/list.gif" class="closepic" onclick="show(0)" />
            <label>Public video parameters:</label>
        </div>
        <div class="sonHank">
	        <div class="content">
	            <label class="sonexplain">Brightness:</label><label class="hank"><%CameraGet("ImgBrightness", "net");%></label>
 		        <label class="explain">Contrast:</label><label class="hank"><%CameraGet("ImgContrast", "net");%></label>
 	       </div>
 	       <div class="content">
 	        	<label class="sonexplain">Saturation:</label><label  class="hank"><%CameraGet("ImgSaturation", "net");%></label>
 	           	<label class="explain">Sharpness:</label><label  class="hank"><%CameraGet("EdgeStrength", "net");%></label>
          </div>
       </div>
            
        <div class="h264para" style="margin-top:3px;">
        	<img src="../images/list.gif" class="closepic" onclick="show(1)" />
            <label>Main stream parameters:</label>
        </div>
       	<div class="sonHank">
 	       	<div class="content">
 	           	<label class="sonexplain">Resolution:</label><label class="hank eleHide" id="jsMainResol"><%videoparaGet("resolution", "net");%></label>
 	           	<label class="explain">Frame rate:</label><label class="hank"><%videoparaGet("framerate", "net");%></label>
            </div>
            <div class="content">
            	<input type="hidden" id="bitRateControl" value='<%videoparaGet("BitRateControlSelect","net");%>'  />
      	     	<label class="sonexplain">Bit rate:</label><label class="hank eleHide" id="jsMainBitRate"><%videoparaGet("BitRate", "net");%></label>
        	  	<label class="explain">I/P rate:</label><label class="hank"><%videoparaGet("IPRate", "net");%></label>
            </div>
            <div class="content" id="payloadContent">
                    <input type="hidden" id="payloadType" value='<%videoparaGet("Payload", "net");%>' />
                    <label class="sonexplain">Encode type:</label><label class="hank" id="jsMainPayload"></label>
            </div>
        </div>
            
        <div class="h264para" id="MinorStreamInfoLabel1" style="margin-top:3px;">
        	<img src="../images/list.gif" class="closepic" onclick="show(2)" />
            <label>Sub stream parameters:</label>
        </div>
       	<div class="sonHank contBot" id="MinorStreamInfoLabel2">
	       	<div class="content">
	           	<label  class="sonexplain">Resolution:</label><label class="hank eleHide" id="jsExtResol"><%ExtVideoparaGet("resolution", "net");%></label>
	           	<label  class="explain">Frame rate:</label><label class="hank"><%ExtVideoparaGet("framerate", "net");%></label>
            </div>
            <div class="content">
            	<input type="hidden" id="ExtBitRateControl" value='<%ExtVideoparaGet("BitRateControlSelect","net");%>' />
            	<label class="sonexplain">Bit rate:</label><label class="hank eleHide" id="jsExtBitRate"><%ExtVideoparaGet("BitRate", "net");%></label>
	           	<label class="explain">I/P rate:</label><label class="hank"><%ExtVideoparaGet("IPRate", "net");%></label>
           </div>
           <div class="content" id="extPayloadContent">
                <input type="hidden" id="extPayloadType" value='<%ExtVideoparaGet("Payload", "net");%>' />
                <label class="sonexplain">Encode type:</label><label class="hank" id="jsExtPayload"></label>
            </div>
       </div>
    
    <div class="hankName" id="MjpegInfoLabel1"><label>MJPEG video settings</label></div>
    	<div class="content contTop contBot" id="MjpegInfoLabel2">
        	<label class="explainLeftEN">Resolution:</label><label class="hank eleHide" id="jsMJPEGResol"><%mjpegparaGet("resolution", "net");%></label>
        	<label class="explain">Frame rate:</label><label class="hank"><%mjpegparaGet("frame", "net");%></label>
        </div>
</div>    
<!---->
<div class="hankClass">
	<div class="hankName"><label>Time zone</label></div>
    <div style="display:none">
    	<input id="timeZone" type="text" value='<%TimezoneGet("Tzone","net");%>' />
    	<input id="SummerMode" type="text" value='<%TimezoneGet("daylightenable","net");%>'  />
    </div>
    <br />
    <form class="clearSpace" name="时区" id="jsTimezoneForm" method="post" action="/form/TimezoneSet" target="hideFrame">
    	<input type="hidden" name="language" value="cn" />
    	<div class="content">
        	<label class="setExplainEN">Time zone:&nbsp;</label>
            <select class="selectLab" style="width: 450px" name="Tzone" id="jsTimeZone" >
            	<option value="0">(GMT-12:00) International Date Line West</option>
          		<option value="1">(GMT-11:00) Midway Island, Samoa</option>
          		<option value="2">(GMT-10:00) Hawaii</option>
          		<option value="3">(GMT-09:00) Alaska</option>
          		<option value="4">(GMT-08:00) Pacific Time(US &amp; Canada); Tijuana</option>
          		<option value="5">(GMT-07:00) Arizona, Chihuahua, La Paz, Mazatlan, Mountain Time(US &amp; Canada)</option>
          		<option value="6">(GMT-06:00) Central America, Central Time(US &amp; Canada), Guadalajara, Mexico City, Monterrey, Saskatchewan</option>
          		<option value="7">(GMT-05:00) Bogota, Lima, Quito, Eastern Time(US &amp; Canada), Indiana(East)</option>
          		<option value="8">(GMT-04:00) Atlantic Time(Canada), Caracas, La Paz, Santiago</option>
          		<option value="9">(GMT-03:30) Newfoundland</option>
          		<option value="10">(GMT-03:00)Brasilia, Buenos Aires, Georgetown, Greenland</option>
          		<option value="11">(GMT-02:00) Mid-Atlantic</option>
          		<option value="12">(GMT-01:00) Azores, Cape Verde Is.</option>
          		<option value="13">(GMT) Casablanca, Monrovia, Greenwich Mean Time; Dublin, Edinburgh, Lisbon, London</option>
          		<option value="14">(GMT+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna, Belgrade, Bratislava, Budapest, Ljubljana, Prague, Brussels, Copenhagen, Madrid, Paris, Sarajevo, Skopje, Warsaw, Zagreb, West Central Africa</option>
         		<option value="15">(GMT+02:00) Athens, Beirut, Istanbul, Minsk, Bucharest, Cairo, Harare, Pretoria, Helsinki, Kyiv, Riga, Sofia, Tallinn, Vilnius, Jerusalem</option>
          		<option value="16">(GMT+03:00) Baghdad, Kuwait, Riyadh, Moscow, St. Petersburg, Volgograd, Nairobi</option>
          		<option value="17">(GMT+03:30) Tehran</option>
          		<option value="18">(GMT+04:00) Abu Dhabi, Muscat, Baku, Tbilisi, Yerevan</option>
          		<option value="19">(GMT+04:30) Kabul</option>
         		<option value="20">(GMT+05:00) Ekaterinburg, Islamabad, Karachi, Tashkent</option>
          		<option value="21">(GMT+05:30) Chennai, Kolkata, Mumbai, New Delhi</option>
          		<option value="22">(GMT+05:45) Kathmandu</option>
          		<option value="23">(GMT+06:00) Almaty, Novosibirsk, Astana, Dhaka, Sri Jayawardenepura</option>
          		<option value="24">(GMT+06:30) Rangoon</option>
          		<option value="25">(GMT+07:00) Bangkok, Hanoi, Jakarta, Krasnoyarsk</option>
          		<option value="26">(GMT+08:00) Beijing, Chongqing, Hong Kong, Urumqi, Irkutsk, Ulaan Bataar, Kuala Lumpur, Singapore, Perth, Taipei</option>
          		<option value="27">(GMT+09:00) Osaka, Sapporo, Tokyo, Seoul, Yakutsk</option>
         		<option value="28">(GMT+09:30) Adelaide, Darwin</option>
          		<option value="29">(GMT+10:00) Brisbane, Canberra, Melbourne, Sydney, Guam, Pot Moresby, Hobart, Vladivostok</option>
          		<option value="30">(GMT+11:00) Magadan, Solomon Is., New Caledonia</option>
          		<option value="31">(GMT+12:00) Auckland, Wellington, Fiji, Kamchatka, Marshall Is.</option>
         		<option value="32">(GMT+13:00) Nukualofa</option>
           </select>
        </div>
        <div class="content" style="margin-top: 8px">
        	<label class="setExplainEN">Daylight saving time:&nbsp;</label>
            <div class="radioSelectEN">
            	<input type="radio" name="daylightenable" id="jsSummerMode1" value="1" />
                <label for="jsSummerMode1">On</label>
            </div>
			<div class="radioSelect">
            	<input type="radio" name="daylightenable" id="jsSummerMode0" value="0" />
                <label for="jsSummerMode0">Off</label>
            </div>
        </div>    
        <div class="content contButton contBot" style="margin-left:50px">
             <input class="ButtonLeft" type="button" value="Save" onclick="timezoneSet()" />
      	   	 <input class="ButtonRight" type="button" value="Cancel" onclick="timezoneReset()" />   
        </div>
    </form>
<!--    <div class="hankName"><label>Synchronization mode</label></div>
    <br />
    <form class="clearSpace" name="" id="SynForm" method="post" action="/form/CameraTimeSet" target="hideFrame">
    	<input type="hidden" name="language" value="cn" />
    	<div class="content">
        	<input id="synFormat" type="hidden" value='<\%NTPGet("ntpstate", "net");%>' />
            <input id="NTPIP" type="hidden" value='<\%NTPGet("ntpip", "net");%>' />
        	<label class="setExplainEN">Time synchronize server:&nbsp;</label>
            <div class="radioSelectEN">
            	<input type="radio" name="ntpstate" id="jsSynFormat0" value="0" onclick="synModeChanged(this)" />
                <label for="jsSynFormat0">Local PC</label>
       		</div>
        	<div class="radioSelect" style="width:100px;">
            	<input type="radio" name="ntpstate" id="jsSynFormat1" value="1" onclick="synModeChanged(this)" />
                <label for="jsSynFormat1">NTP server</label>
            </div>
        </div>
        <div class="content">
        	<label class="setExplainEN">Device time:&nbsp;</label><label id="equiTime">&nbsp;</label>
        </div>
        <div class="content" id="jsPCtimeDiv" style="height: 22px;">
        	<label class="setExplainEN">Local PC time:&nbsp;</label><label id="loctime" style="height:21px; float:left; font-size:14px;">&nbsp;</label>
            <input type="hidden" name="localtime" id="jsPCUCTTime"  />
            <input type="hidden" name="Tzone" id="jsSynTzone" />
        </div>
        <div class="content" id="jsNTPserDiv" style="height: 22px;">
        	<label class="setExplainEN">NTP server IP:&nbsp;</label>
            <input class="showselect" name="ntpip" id="jsNTPIP" type="text" value="" />
        </div>
        <div class="content">
        	<label name="jsUploadTip" style="font-size:12px; margin-left: 40px; margin-top: 2px">(Note: Because of network delay, there might be a tiny gap between device time and actual time.)</label>
        </div>
        <div class="content contButton contBot" style="margin-left:50px">
             <input class="ButtonLeft" type="button" value="Save" onclick="synNTPsubmit('SynForm')" />
       	   	 <input class="ButtonRight" type="button" value="Cancel" onclick="synNTPreset()"  />   
        </div>
    </form>-->
    <div class="hankName"><label>NTP</label></div>
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
                <label for="jsNTPEnable1">On</label>
            </div>
            <div class="radioSelect">
              <input type="radio" name="ntpenable" id="jsNTPEnable0" value="0" />
                <label for="jsNTPEnable0">Off</label>
            </div>
      </div>
        <div class="content" id="jsNTPserDiv" style="height: 24px;">
        	<label class="setExplainEN">NTP server :&nbsp;</label>
            <input class="showselect" name="ntpip" id="jsNTPIP" type="text" value="" style="margin-top:2px" />
        </div>
        <div class="content">
        	<label class="setExplainEN">Sync time:&nbsp;</label>
        	<input type="text" class="synTime" id="jsSynHour" name="synHour" maxlength="2"  /><label>&nbsp;:&nbsp;</label>
            <input type="text" class="synTime" id="jsSynMin" name="synMin" maxlength="2"  /><label>&nbsp;:&nbsp;</label>
            <input type="text" class="synTime" id="jsSynSec" name="synSec" maxlength="2"  />
        </div>
        <div class="content">
        	<label class="setExplainEN">Sync interval(hours):&nbsp;</label>
            <select id="jsSynInterval" name="synInterval" class="selectLab" style="width:43px; margin-top:0;">
            	<option value="6">6</option>
                <option value="12">12</option>
                <option value="24">24</option>
            </select>
        </div>
        <div class="content contButton contBot" style="margin-left:50px">
             <input class="ButtonLeft" type="button" value="Save" onclick="synNTPsubmit()" />
       	   	 <input class="ButtonRight" type="button" value="Cancel" onclick="synNTPreset()"  />   
        </div>
    </form>
    
    <div class="hankName"><label>Sync now</label></div>
    <br />
    <form class="clearSpace" name="" id="PCSynForm" method="get" action="/form/CameraTimeSet" target="hideFrame">
    	<div class="content">
        	<label class="setExplainEN">Device time:&nbsp;</label><label id="equiTime" style="margin-top:2px">&nbsp;</label>
        </div>
    	 <div class="content" id="jsPCtimeDiv" style="height: 24px;">
        	<label class="setExplainEN">Local PC time:&nbsp;</label><label id="loctime" style="height:21px; float:left; font-size:14px; margin-top:2px">&nbsp;</label>
            <input type="hidden" name="localtime" id="jsPCUCTTime"  />
            <input type="hidden" name="Tzone" id="jsSynTzone" />
        </div>
        <div class="content contButton contBot" style="margin-left:50px">
             <input class="ButtonLeft" type="button" id="jsNTPSyn" value="NTP" onclick="timeSynNow('NTP')" />
             <input class="ButtonRight" type="button" value="PC" onclick="timeSynNow('PC')" />   
        </div>
    </form>
        
</div>
<!---->
<div class="hankClass">
    <div class="hankName"><label>Firmware upgrade</label></div>
    <br />
    <form class="clearSpace" id="updateForm" name="FileUpload" method="post" enctype="multipart/form-data" action="/form/upload" target="hideFrame">
    	<input type="hidden" name="language" value="cn" /><input type="hidden" name="type" id="jsUpdateType" value="" />
      <input type="hidden" name="reset" id="jsUpdateReset" value="0" />
        <div class="content" style="margin-left:0">
		    <input class="CAupload" type="file" id="jsUpdateFile" name="fileName"  />
            <label name="jsUploadTip" style="font-size:13px; margin-top:2px">&nbsp;(Please choose upgrade file.)</label>
        </div>
        <div class="content" style="margin-top:10px">
            <label for="jsConfigkeep" style="vertical-align:middle; margin-left:40px;">Keep current config unchanged:</label>
            <input id="jsConfigkeep" type="checkbox" value="0" style="float: left; margin-left:2px; vertical-align:middle; padding:2px" />
        </div>
        <div class="content contBot contButton">
            <input class="ButtonOnly" type="button" value="Submit" onclick="fileUpload()" /> 
        </div>   
    </form>
    
    <div class="hankName"><label>Factory settings</label></div>
    <br />
    <form class="clearSpace" id="recoverForm" method="post" action="/form/FatorySet" target="hideFrame">
    	<input type="hidden" name="language" value="cn" />
    	<div class="content">
	    	<label name="jsUploadTip" style="margin-left: 40px">Press the button to reset all the parameters to the factory default settings.</label>
        </div>
        <div class="content" style="margin-top:10px">
            <label for="jsIPkeep" style="font-family:Tahoma, Geneva, sans-serif;vertical-align:middle; margin-left:40px;">Keep current IP unchanged:</label>
            <input id="jsIPkeep" type="checkbox" name="IPkeep" value="1" checked="checked" style="float: left; margin-left:2px; vertical-align:middle; padding:2px" />
        </div>
        <div class="content contBot contButton">
        	<input class="ButtonOnly" type="button" value="Reset"  onclick="recoverSet()" />
        </div>
    </form>
    
    <div class="hankName"><label>Reboot</label></div>
    <br />
    <form class="clearSpace" id="rebootForm" method="post" action="/form/reboot" target="hideFrame">
    	<input type="hidden" name="language" value="en" />
    	<div class="content">
        	<label name="jsUploadTip" style="margin-left: 40px">Press the button to reboot the system, the window will reload after it.</label>
        </div>
        <div class="content contButton contBot">
        	<input class="ButtonOnly" type="button" value="Reboot" onclick="reboot()" />
        </div>
    </form>   
</div>	
</body>
</html>

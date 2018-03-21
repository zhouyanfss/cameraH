<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link type="text/css" rel="stylesheet" href="../css/sysInf.css" />
<script type="text/javascript" src="../javascript/jquery.js"></script>
<script type="text/javascript" src="../javascript/common.js"></script>
<script type="text/javascript" src="../javascript/network.js"></script>
<script type="text/javascript" src="../javascript/jquery.qrcode.js"></script>
<script type="text/javascript" >
window.onload = function(){
	networkInit();
	sysShow('hankClass',0);
	networkInit = null;
	try{
		document.execCommand('BackgroundImageCache', false, true);
    }catch(e){
	};
}
</script>
</head>

<body>
<input type="hidden" id="PAGE_LANGUAGE" value="0" />
<input type="hidden" id="SAMSUNG_MODULES" value='<%NetparaGet("SamsungModules","net");%>' />
<input type="hidden" id="Auth8021xModules" value='<%NetparaGet("Auth8021xModules","net");%>' />
<input type="hidden" id="SnmpModules" value='<%NetparaGet("SnmpModules","net");%>' />
<input type="hidden" id="PppoeModules" value='<%NetparaGet("PppoeModules","net");%>' />
<input type="hidden" id="Hi3518E" value='<%videoparaGet("hi3518e", "net");%>' />
<iframe onload="iframeLoad()" id="hideFrame" name="hideFrame" style="display:none"></iframe>

<div class="topMenu" style="	min-width: 830px;">
	<ul>
    	<li class="choose" onclick="sysShow('hankClass',0)">Network</li>
        <li class="choose" onclick="sysShow('hankClass',1)">FTP</li>
        <li class="choose" onclick="sysShow('hankClass',2)">SMTP</li>
        <li class="choose" onclick="sysShow('hankClass',3)" id="https_LI" style="display:none">HTTPS</li>
        <li class="choose" onclick="sysShow('hankClass',4)" id="digest_LI" style="display:none">Digest</li>
        <li class="choose" onclick="sysShow('hankClass',5)" id="filter_LI" style="display:none">IP Filter</li>
        <li class="choose" onclick="sysShow('hankClass',6)" id="8021x_LI" style="display:none">802.1X</li>
        <li class="choose" onclick="sysShow('hankClass',7)" id="snmp_LI" style="display:none">SNMP</li>
        <li class="choose" onclick="sysShow('hankClass',8)">QoS</li>
        <li class="choose" onclick="sysShow('hankClass',9)">IGMP</li>
        <li class="choose" onclick="sysShow('hankClass',10)" id="sip_LI" style="display:none">SIP</li>
        <li class="choose" onclick="sysShow('hankClass',11)" style="display:none">MDA</li>
        <li class="choose" onclick="sysShow('hankClass',12)">PORT</li>
        <li class="choose" onclick="sysShow('hankClass',13)">DDNS</li>
        <li class="choose" onclick="sysShow('hankClass',14)"id="sjkd_LI" style="display:none">MPLS</li>
		<li class="choose" onclick="sysShow('hankClass',15)" id="tutk_LI" style="display:none">TUTK</li>
        <li class="choose" onclick="sysShow('hankClass',16)" id="mobile_LI" style="display:none">Mobile</li>
		<li class="choose" onclick="sysShow('hankClass',17)" id="p2p_LI">P2P</li>
		<li class="choose" onclick="sysShow('hankClass',18)" id="el_LI" style="display:none">L-SU</li>
        <li class="choose" onclick="sysShow('hankClass',19)" id="proto_LI" style="display:block">Protocol</li>
    </ul>
</div>
<div class="hankClass" id="firstPage">
	<div class="hankName"><label>Network</label></div> 
    <br />
    <form class="clearSpace" name="网络" id="networkForm" method="post" action="/form/netparaCfg" target="hideFrame">
    	<input type="hidden" name="flag" value="1" />
        <input type="hidden" name="language" value="cn" />
         <div class="content">
        	<label class="setExplainEN" id="DHCPlab">DHCP:&nbsp;</label>
            <input type="hidden" id="DHCPenableGet" value='<%NetparaGet("DHCPenable","net");%>' />
            <div class="radioSelectEN">
            	<input type="radio" name="DHCPenable" id="jsDHCPenable1" value="1" onclick="DHCPchanged(1)" />
                <label for="jsDHCPenable1">On</label>
            </div>
            <div class="radioSelectEN">
            	<input type="radio" name="DHCPenable" id="jsDHCPenable0" value="0" onclick="DHCPchanged(0)" />
                <label for="jsDHCPenable0">Off</label>
            </div>
        </div>
        <input type="hidden" id="outIPAddrGet" value='<%NetparaGet("outIPAddr","net");%>' />
        <input type="hidden" id="outMaskAddrGet" value='<%NetparaGet("outMaskAddr","net");%>' />
        <input type="hidden" id="outGatewayGet" value='<%NetparaGet("outGateway","net");%>' />
        <input type="hidden" id="outDNSFirstServerGet" value='<%NetparaGet("outDNSFirstServer","net");%>' />
        <input type="hidden" id="outDNSSecondServerGet" value='<%NetparaGet("outDNSSecondServer","net");%>' />
	    <div class="content">
        	<label class="setExplainEN">IP address:&nbsp;</label>
            <input class="showselect" name="outIPAddr" id="jsIP" type="text" maxlength="15" />
        </div>
        <div class="content">
            <label class="setExplainEN">Subnet mask:&nbsp;</label>
            <input class="showselect" name="outMaskAddr" id="jsMaskAddr" type="text" maxlength="15" />
        </div>
        <div class="content">
            <label class="setExplainEN">Default gateway:&nbsp;</label>
            <input class="showselect" name="outGateway" id="jsGateway" type="text" maxlength="15" />
        </div>
        <div class="content">
            <label class="setExplainEN">Primary DNS server:&nbsp;</label>
            <input class="showselect" name="outDNSFirstServer" id="jsDNS0" type="text" maxlength="15" />
        </div>
        <div class="content">
            <label class="setExplainEN">Secondary DNS server:&nbsp;</label>
            <input class="showselect" name="outDNSSecondServer" id="jsDNS1" type="text" maxlength="15" />
        </div>
        <div class="content contButton contBot">
             <input class="ButtonLeft" type="button" value="Save" onclick="networkSubmit('networkForm')" /> 
      	   	 <input class="ButtonRight" type="button" value="Cancel" onclick="networkReset()" />   
        </div>   
    </form>
    <div class="hankName" id="WifiLabel" style="display:block"><label>Wifi</label></div>
    <br />
    <form class="clearSpace" id="WifiForm" style="display:block" method="post" action="/form/WifiCfg" target="hideFrame" >
		<input type="hidden" id="WifiChecking" value="0" />
    	<input type="hidden" name="flag" id="flag" value="0" />
        <input type="hidden" name="language" value="en" />
        <input type="hidden" id="WifiEnable_Get" value='<%WifiGet("WifiEnable", "net");%>' />
        <input type="hidden" id="WifiMode_Get" value='<%WifiGet("WifiMode", "net");%>' />
        <input type="hidden" id="WifiCurMode_Get" value='<%WifiGet("WifiCurMode", "net");%>' />
        <input type="hidden" id="WifiResource_Get" value='<%WifiGet("WifiResource", "net");%>' />
        <input type="hidden" id="WifiAPSupport_Get" value='<%WifiGet("WifiAPSupport", "net");%>' />
        <input type="hidden" id="Wifi8188_Get" value='<%WifiGet("Wifi8188", "net");%>' />
        <div class="content">
        	<label class="setExplain">Wifi:&nbsp;</label>
            <div class="radioSelect">
            	<input type="radio" name="WifiEnable" id="jsWifiOn" value="1" onclick="WifiEnableChanged()" />
                <label for="jsWifiOn">ON</label>
            </div>
            <div class="radioSelect">
            	<input type="radio" name="WifiEnable" id="jsWifiOff" value="0" onclick="WifiEnableChanged()" />
                <label for="jsWifiOff">OFF</label>
            </div>
        </div>
        <div class="content">
        	<label class="setExplain">Mode:&nbsp;</label>
            <div class="radioSelect">
            	<input type="radio" name="WifiMode" id="jsWifiModeSTA" value="1" onclick="WifiModeChanged()" />
                <label for="jsWifiModeSTA">STA</label>
            </div>
            <div class="radioSelect">
            	<input type="radio" name="WifiMode" id="jsWifiModeAP" value="0" onclick="WifiModeChanged()" />
                <label for="jsWifiModeAP">AP</label>
            </div>
        </div>
        <input type="hidden" id="WifiSSID_Get" value='<%WifiGet("WifiSSID","net");%>' />
        <input type="hidden" id="WifiAPSSID_Get" value='<%WifiGet("WifiAPSSID","net");%>' />
        <input type="hidden" id="WifiKey_Get" value='<%WifiGet("WifiKey","net");%>' />
        <input type="hidden" id="WifiChannel_Get" value='<%WifiGet("WifiChannel","net");%>' />
		<div id="divSTA" style="display:none;">
	        <div class="content">
	        	<label class="setExplain" id="jsWifiSSIDLab">SSID:&nbsp;</label>
	            <input class="showselect" name="WifiSSID" id="jsWifiSSID" type="text" maxlength="32" />
	        </div>
	        <div class="content">
	        	<label class="setExplain" id="jsWifiKeyLab">Key:&nbsp;</label>
	            <input class="showselect" name="WifiKey" id="jsWifiKey" maxlength="64" />
	        </div>
	        <div class="content">
	        	<label class="setExplain" id="jsWifiStatusLab">Status:&nbsp;</label>
	            <input id="WifiStatus_Get" type="hidden" value='<%WifiGet("WifiStatus","net");%>' />
					<label class="hank" id="jsWifiStatus1" style="display:none;width:75px">connected</label>
					<label class="hank" id="jsWifiStatus0" style="display:none;width:75px">unconnected</label>
	   				<label class="hank" id="jsWifiIP" style="display:none;width:200px">IP: none</label>
	        </div>
	        <div class="content contButton contBot">
	        	<input class="ButtonLeft" type="button" id="jsWifiConnect" value="Connect" onclick="WifiSubmit()" />
	       		<input class="ButtonRight" type="button" id="jsWifiStatus" value="Refresh" onclick="WifiStatus()" />
	        </div>
		</div>
		<div id="divAP" style="display:none;">
	        <div class="content">
	        	<label class="setExplain" id="jsWifiAPSSIDLab">APSSID:&nbsp;</label>
	            <input class="showselect" name="WifiAPSSID" id="jsWifiAPSSID" type="text" style="disabled:true"/>
	        </div>
	        <div class="content">
				<label class="setExplain" id="jsWifiChannelLab">Channel:&nbsp;</label>
				<select class="showselect" name="WifiChannel" id="jsWifiChannel" style="width:155px;height:20px">
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
					<option value="6">6</option>
					<option value="7">7</option>
					<option value="8">8</option>
					<option value="9">9</option>
					<option value="10">10</option>
					<option value="11">11</option>
					<option value="12">12</option>
					<option value="13">13</option>
				</select>
	        </div>
	        <div class="content contButton contBot">
				<input class="ButtonLeft" type="button" id="jsWifiAPSet" value="Set" onclick="WifiAPSubmit()"/>
	        </div>
		</div>
    </form>
	
     <br />  
      
    <form class="clearSpace" style="display:block" id="WifiHotspotForm" name="WifiHotspotForm" method="post" action="/form/WifiQuery" target="hideFrame">
        <div class="content" style="margin-left:80px;display:none">
        <textarea id="hotspotlist" name="hotspotlist" rows="4" cols="32" value='< %WifiQuery("WifiHotspot","net");%>'></textarea>
        </div>
        <div class="content">
	    	<label class="setExplain" id="jsWifiStatusLab">Wlan List:&nbsp;</label>
    		<select class="showselect" name="hotspotlistSelect" id="hotspotlistSelect" style="width:160px;height:20px" onchange="WifiSelect()">
        	</select>
        </div>
    	<div class="content contButton contBot">
		<input class="ButtonLeft" type="button" id="jsWifiHotspotSearch" value="Search" onclick="WifiQuerySubmit()" />
        </div>
    </form>
    
    <form class="clearSpace" id="PacketForm" style="display:block" method="post" action="/form/PacketCfg" target="hideFrame" >
    	<input type="hidden" name="flag" id="flag" value="0" />
        <input type="hidden" name="language" value="en" />
        <input type="hidden" id="WIFIBitrateControl_Get" value='<%PacketGet("WIFIBitrateControl", "net");%>' />
        <div class="content">
        	<label class="setExplain">Stream control：</label>
            <div class="radioSelect">
            	<input type="radio" name="WIFIBitrateControl" id="jsWIFIBitrateControlAuto" value="1" />
                <label for="jsWIFIBitrateControlAuto">Auto</label>
            </div>
            <div class="radioSelect">
            	<input type="radio" name="WIFIBitrateControl" id="jsWIFIBitrateControlManual" value="0" />
                <label for="jsWIFIBitrateControlManual">Manual</label>
            </div>
        </div>
        
        <div class="content contButton contBot">
			<input class="ButtonLeft" type="button" id="jsPacketSizeSet" value="Set" onclick="document.getElementById('PacketForm').submit()" />
        </div>
        
 	</form>
    
    <div class="hankName" id="PPPOElabel" style="display:none"><label>PPPOE</label></div>
    <br />
    <form class="clearSpace" id="PPPOEform" method="post" action="/form/netparaCfg" target="hideFrame" style="display:none">
    	<input type="hidden" name="flag" value="6" />
        <input type="hidden" name="language" value="cn" />
        <input type="hidden" id="PPPOEstate" value='<%NetparaGet("pppoe_enable", "net");%>' />
        <div class="content">
        	<label class="setExplainEN">State:&nbsp;</label>
            <div class="radioSelectEN">
            	<input type="radio" name="pppoe_enable" id="jsPPPOEuse1" value="1" onclick="pppoeChanged(1)" />
                <label for="jsPPPOEuse1">On</label>
            </div>
            <div class="radioSelectEN">
            	<input type="radio" name="pppoe_enable" id="jsPPPOEuse0" value="0" onclick="pppoeChanged(0)" />
                <label for="jsPPPOEuse0">Off</label>
            </div>
       </div>
        <input type="hidden" id="pppoe_nameGet" value='<%NetparaGet("pppoe_name","net");%>' />
        <input type="hidden" id="pppoe_passwdGet" value='<%NetparaGet("pppoe_passwd","net");%>' />
        <div class="content">
        	<label class="setExplainEN" id="jsPPPOEuserLab">User name:&nbsp;</label>
            <input class="showselect" name="pppoe_name" id="jsPPPOEuser" type="text" maxlength="30" />
        </div>
        <div class="content">
        	<label class="setExplainEN" id="jsPPPOEpassLab">Password:&nbsp;</label>
            <input class="showselect" name="pppoe_passwd" id="jsPPPOEpass" type="password" maxlength="20" />
        </div>
        <div class="content">
        	<label class="setExplainEN" id="jsPPPOEipLab">IP address:&nbsp;</label>
            <label class="showselect" id="jsPPPOEip"><%NetparaGet("pppoe_IP","net");%></label>
        </div>
        <div class="content contButton contBot">
        	<input class="ButtonLeft" type="button" value="Save" onclick="PPPOEsubmit()" />
            <input class="ButtonRight" type="button" value="Cancel" onclick="PPPOEreset()"  />
        </div>
    </form>

 	
    <div class="hankName" style="display:none"><label>SNMP</label></div>
    <br />
    <form class="clearSpace" name="network" id="SNMPform" method="post" action="/form/netparaCfg" target="hideFrame" style="display:none">
    	<input type="hidden" name="flag" value="5" />
        <input type="hidden" name="language" value="cn" />
        <input type="hidden" id="SNMPipGet" value='<%NetparaGet("SNMP_IP","net");%>' />
        <input type="hidden" id="SNMPintervalGet" value='<%NetparaGet("SNMP_interval","net");%>' />
    	<div class="content">
        	<label class="setExplainEN">Heartbeat server IP:&nbsp;</label>
            <input class="showselect" name="SNMP_IP" id="jsSNMPip" type="text" maxlength="15" />
        </div>
        <div class="content">
        	<label class="setExplainEN">Heartbeat interval:</label>
            <input name="SNMP_interval" id="jsSNMPinterval" type="text" maxlength="3" size="3" style="float:left" />
            <label class="setExplainEN" style="margin-left:0">&nbsp;sec.(1~300)</label>
        </div>
        <div class="content contButton contBot">
             <input class="ButtonLeft" type="button" value="Save" onclick="SNMPsubmit('SNMPform')" /> 
      	   	 <input class="ButtonRight" type="button" value="Cancel" onclick="SNMPreset()" />   
        </div>  
    </form>
	
</div>
<div class="hankClass">
	<div class="hankName"><label>FTP</label></div>
    <br />
    <form class="clearSpace" name="network" id="FTPform" method="post" action="/form/FTPparaCfg" target="hideFrame">
    	<input type="hidden" name="flag" value="0" />
        <input type="hidden" name="language" value="cn" />
        <input type="hidden" id="FTPserveripGet" value='<%FTPparaGet("serverip", "net");%>' />
        <input type="hidden" id="FTPusernameGet" value='<%FTPparaGet("username", "net");%>' />
        <input type="hidden" id="FTPpasswordGet" value='<%FTPparaGet("password", "net");%>' />
        <input type="hidden" id="FTPserverportGet" value='<%FTPparaGet("port", "net");%>' />
        <input type="hidden" id="FTPsnapcountGet" value='<%FTPparaGet("snapcount", "net");%>' />
        <input type="hidden" id="FTPsnapintervalGet" value='<%FTPparaGet("snapinterval", "net");%>' />
        <input type="hidden" id="FTPfilenameGet" value='<%FTPparaGet("filename", "net");%>' />
        <input type="hidden" id="FTPpathGet" value='<%FTPparaGet("path", "net");%>' />
 	   <div class="content">
            <label class="setExplainEN">Server :&nbsp;</label>
            <input class="showselect" name="serverip" id="jsFTPIP" type="text" maxlength="60" />
       </div>
       <div class="content">
            <label class="setExplainEN">Port :&nbsp;</label>
            <input class="showselect" style="width:80px" name="port" id="jsFTPport" type="text" maxlength="6" />
            <label>(1-65535)</label>
       </div>
       <div class="content">
            <label class="setExplainEN">User name:&nbsp;</label>
            <input class="showselect" name="username" id="jsFTPuser" type="text" maxlength="63" />
       </div>
       <div class="content">
            <label class="setExplainEN">Password:&nbsp;</label>
            <input class="showselect" name="password" id="jsFTPpass" type="password" maxlength="63" />
       </div>
        <div class="content">
            <label class="setExplainEN">Server Path :&nbsp;</label>
            <input class="showselect" name="path" id="jsFTPpath" type="text" maxlength="63" />
       </div>
       <div class="content">
            <label class="setExplainEN">FileName :&nbsp;</label>
            <input class="showselect" name="filename" id="jsFTPfilename" type="text" maxlength="63" />
       </div>
       <div class="content">
            <label class="setExplainEN">Snap Number :&nbsp;</label>
            <input class="showselect" name="snapcount" id="jsFTPcount" type="text" maxlength="6" />
       </div>
       <div class="content">
            <label class="setExplainEN">Snap Interval :&nbsp;</label>
            <input class="showselect" style="width:115px" name="snapinterval" id="jsFTPinterval" type="text" maxlength="4" />
            <label>&nbsp;s</label>
       </div>
       <div class="content contButton contBot">
             <input class="ButtonLeft" type="button" value="Save" onclick="FTPsubmit('FTPform')" /> 
      	   	 <input class="ButtonRight" type="button" value="Cancel" onclick="FTPreset()" />   
        </div>  
    </form>
</div>

<div class="hankClass">
	<div class="hankName"><label>SMTP</label></div>
    <br />
    <form class="clearSpace" name="network" id="SMTPform" method="post" action="/form/SMTPparaCfg" target="hideFrame">
    	<input type="hidden" name="flag" value="0" />
        <input type="hidden" name="language" value="cn" />
        <input type="hidden" id="SMTPserveripGet" value='<%SMTPparaGet("serverip", "net");%>' />
        <input type="hidden" id="SMTPfrommailGet" value='<%SMTPparaGet("frommail", "net");%>' />
        <input type="hidden" id="SMTPtomailGet" value='<%SMTPparaGet("tomail", "net");%>' />
        <input type="hidden" id="SMTPccmailGet" value='<%SMTPparaGet("ccmail", "net");%>' />
        <input type="hidden" id="SMTPusernameGet" value='<%SMTPparaGet("username", "net");%>' />
        <input type="hidden" id="SMTPpasswordGet" value='<%SMTPparaGet("password", "net");%>' />
        <input type="hidden" id="SMTPserverportGet" value='<%SMTPparaGet("serverport", "net");%>' />
        <input type="hidden" id="SMTPsnapshotGet" value='<%SMTPparaGet("snapshot", "net");%>' />
        <input type="hidden" id="SMTPsslportGet" value='<%SMTPparaGet("sslport", "net");%>' />
    	<div class="content">
            <label class="setExplainEN">Server :&nbsp;</label>
            <input class="showselect" name="serverip" id="jsSMTPIP" type="text" maxlength="31" />
       </div>
       <div class="content">
            <label class="setExplainEN">Port :&nbsp;</label>
            <input class="showselect" name="serverport" id="jsSMTPPort" type="text" maxlength="5" />
       </div>
        <div class="content">
            <input type="hidden" id="SMTPsslCheck" value='<%SMTPparaGet("usessl", "net");%>' />
            <label class="setExplainEN">SSL:&nbsp;</label>
            <div class="radioSelect">
                <input type="radio" name="sslAuth" id="jsSMTPsslCheck1" value="1" onclick="SMTPsslChecked(1)" />
                <label for="jsSMTPsslCheck1">On</label>
            </div>
            <div class="radioSelect">
                <input type="radio" name="sslAuth" id="jsSMTPsslCheck0" value="0" onclick="SMTPsslChecked(0)" />
                <label for="jsSMTPsslCheck0">Off</label>
            </div>
        </div>
        <div class="content">
            <label class="setExplainEN" id="jsSslPortLab">SSL Port:&nbsp;</label>
            <input class="showselect" name="sslport" id="jsSslPort" type="text" maxlength="5" />
        </div>
       <div class="content">
            <label class="setExplainEN">From:&nbsp;</label>
            <input class="showselect" name="frommail" id="jsAddresser" type="text" maxlength="127" />
       </div>
       <div class="content">
            <label class="setExplainEN">To:&nbsp;</label>
            <input class="showselect" name="tomail" id="jsAddressee" type="text" maxlength="127" />
       </div>
       <div class="content">
            <label class="setExplainEN">CC:&nbsp;</label>
            <input class="showselect" name="ccmail" id="jsCopyFor" type="text" maxlength="127" />
       </div>
        <div class="content">
        	<input type="hidden" id="SMTPidCheck" value='<%SMTPparaGet("Auth", "net");%>' />
        	<label class="setExplainEN">Authentication:&nbsp;</label>
            <div class="radioSelectEN">
            	<input type="radio" name="Auth" id="jsSMTPidCheck1" value="1" onclick="SMTPidChecked(1)" />
                <label for="jsSMTPidCheck1">On</label>
            </div>
            <div class="radioSelectEN">
            	<input type="radio" name="Auth" id="jsSMTPidCheck0" value="0" onclick="SMTPidChecked(0)" />
                <label for="jsSMTPidCheck0">Off</label>
            </div>
        </div>
		<div class="content">
            <label class="setExplainEN" id="jsSMTPuserLab">User name:&nbsp;</label>
            <input class="showselect" name="username" id="jsSMTPuserID" type="text" maxlength="63" />
       </div>
       <div class="content">
            <label class="setExplainEN" id="jsSMTPpassLab">Password:&nbsp;</label>
            <input class="showselect" name="password" id="jsSMTPuserPass" type="password" maxlength="63" />
      </div>
      <div class="content">
            <label class="setExplainEN">SnapShot:&nbsp;</label>
            <input name="snapshot_check" id="SnapShot" type="checkbox" value="1" checked="checked" />
            <input class="showselect" name="snapshot" id="jsSMTPSnapshot" style="display:none" type="text" maxlength="5" />
       </div>
       <div class="content contButton contBot">
              <input class="ButtonLeft" type="button" value="Save" onclick="SMTPsubmit('SMTPform')" /> 
     	   	 <input class="ButtonRight" type="button" value="Cancel" onclick="SMTPreset()"  />   
      </div>  
    </form>
</div>

<div class="hankClass">
    <div class="hankName"><label>CA certificate import</label></div>
    <br />
    <form class="clearSpace" id="SSLCAform" method="post" enctype="multipart/form-data" action="/form/uploadSSL" target="hideFrame">
    	<input type="hidden" name="type" value="pem" />
        <input type="hidden" name="language" value="cn" />
    	<div class="content">
    		<label class="setExplainEN">CA certificate:&nbsp;</label>
            <input class="fileUpCon" type="file" name="fileName" id="jsSSLCAfile" />
            <input class="uploadFile" type="button" id="jsSSLCAfileBot" value="Submit" onclick="PEMupload('jsSSLCAfile','SSLCAform')" />
        </div> 
    </form>
</div>

<div class="hankClass">
    <div class="hankName"><label>HTTP Digest Login Authentication</label></div>
    <br />
    <br />
    <form class="clearSpace" id="DigestAuthForm" method="post" action="/form/DigestAuthCfg" target="hideFrame">
        <input type="hidden" name="language" value="cn" />
        <div class="content contTop">
        	<label class="setExplain">Switch:&nbsp;</label>
            <input type="hidden" id="DigestAuthEnable_" value='<%DigestAuthGet("DigestAuthEnable","net");%>' />
            <div class="radioSelect">
            	<input type="radio" name="DigestAuthnable" id="DigestAuthon" value="1" onclick="DigestAuthsubmit()" />
                <label>ON</label>
            </div>
            <div class="radioSelect">
            	<input type="radio" name="DigestAuthEnable" id="DigestAuthoff" value="0" onclick="DigestAuthsubmit()" />
                <label>OFF</label>
            </div>
        </div>
    </form>
</div>


<div class="hankClass">
<div class="hankName"><label>IP Address Filter</label></div>
    <br />
    <form class="clearSpace" id="FilterForm" method="post" action="/form/FilterSet" target="hideFrame">
		<div class="content">
			<input type="hidden" name="FilterEnable_1" id="FilterEnable_1" value='<%FilterGet("FilterEnable1", "net");%>' />
			<input type="hidden" id="FilterMethod_1" value='<%FilterGet("FilterMethod1", "net");%>' />
        	<input type="checkbox" value="1" id="FilterEnable1" checked="checked" onclick="FilterStateChange(1)" style="float:left;" />
        	<label>&nbsp;&nbsp;&nbsp;&nbsp;Forbid IP:&nbsp;</label>
            <input name="FilterIPStart1" id="FilterIPStart1" type="text" maxlength="15" style="width:110px;float:left;" value='<%FilterGet("FilterIPStart1", "net");%>'/>
         	<label>&nbsp;&nbsp;-&nbsp;&nbsp;</label>
            <input name="FilterIPEnd1" id="FilterIPEnd1" type="text" maxlength="15" style="width:110px;float:left;" value='<%FilterGet("FilterIPEnd1", "net");%>'/>
         	<label>&nbsp;&nbsp;&nbsp;&nbsp;Forbid Method:&nbsp;</label>
            <select class="selectLab" name="FilterMethod1" id="FilterMethod1" style="width:180px;">
				<option value="1">Forbid Search</option>
				<option value="2">Forbid Access</option>
				<option value="3">Forbid Search & Access</option>
			</select>
		</div>
		<div class="content">
			<input type="hidden" name="FilterEnable_2" id="FilterEnable_2" value='<%FilterGet("FilterEnable2", "net");%>' />
			<input type="hidden" id="FilterMethod_2" value='<%FilterGet("FilterMethod2", "net");%>' />
        	<input type="checkbox" value="1" id="FilterEnable2" checked="checked" onclick="FilterStateChange(2)" style="float:left;" />
        	<label>&nbsp;&nbsp;&nbsp;&nbsp;Forbid IP:&nbsp;</label>
            <input name="FilterIPStart2" id="FilterIPStart2" type="text" maxlength="15" style="width:110px;float:left;" value='<%FilterGet("FilterIPStart2", "net");%>'/>
         	<label>&nbsp;&nbsp;-&nbsp;&nbsp;</label>
            <input name="FilterIPEnd2" id="FilterIPEnd2" type="text" maxlength="15" style="width:110px;float:left;" value='<%FilterGet("FilterIPEnd2", "net");%>'/>
         	<label>&nbsp;&nbsp;&nbsp;&nbsp;Forbid Method:&nbsp;</label>
            <select class="selectLab" name="FilterMethod2" id="FilterMethod2" style="width:180px;">
				<option value="1">Forbid Search</option>
				<option value="2">Forbid Access</option>
				<option value="3">Forbid Search & Access</option>
			</select>
		</div>
		<div class="content">
			<input type="hidden" name="FilterEnable_3" id="FilterEnable_3" value='<%FilterGet("FilterEnable3", "net");%>' />
			<input type="hidden" id="FilterMethod_3" value='<%FilterGet("FilterMethod3", "net");%>' />
        	<input type="checkbox" value="1" checked="checked" id="FilterEnable3" onclick="FilterStateChange(3)" style="float:left;" />
        	<label>&nbsp;&nbsp;&nbsp;&nbsp;Forbid IP:&nbsp;</label>
            <input name="FilterIPStart3" id="FilterIPStart3" type="text" maxlength="15" style="width:110px;float:left;" value='<%FilterGet("FilterIPStart3", "net");%>'/>
         	<label>&nbsp;&nbsp;-&nbsp;&nbsp;</label>
            <input name="FilterIPEnd3" id="FilterIPEnd3" type="text" maxlength="15" style="width:110px;float:left;" value='<%FilterGet("FilterIPEnd3", "net");%>'/>
         	<label>&nbsp;&nbsp;&nbsp;&nbsp;Forbid Method:&nbsp;</label>
            <select class="selectLab" name="FilterMethod3" id="FilterMethod3" style="width:180px;">
				<option value="1">Forbid Search</option>
				<option value="2">Forbid Access</option>
				<option value="3">Forbid Search & Access</option>
			</select>
		</div>
		<div class="content">
			<input type="hidden" name="FilterEnable_4" id="FilterEnable_4" value='<%FilterGet("FilterEnable4", "net");%>' />
			<input type="hidden" id="FilterMethod_4" value='<%FilterGet("FilterMethod4", "net");%>' />
        	<input type="checkbox" value="1" id="FilterEnable4" checked="checked" onclick="FilterStateChange(4)" style="float:left;" />
        	<label>&nbsp;&nbsp;&nbsp;&nbsp;Forbid IP:&nbsp;</label>
            <input name="FilterIPStart4" id="FilterIPStart4" type="text" maxlength="15" style="width:110px;float:left;" value='<%FilterGet("FilterIPStart4", "net");%>'/>
         	<label>&nbsp;&nbsp;-&nbsp;&nbsp;</label>
            <input name="FilterIPEnd4" id="FilterIPEnd4" type="text" maxlength="15" style="width:110px;float:left;" value='<%FilterGet("FilterIPEnd4", "net");%>'/>
         	<label>&nbsp;&nbsp;&nbsp;&nbsp;Forbid Method:&nbsp;</label>
            <select class="selectLab" name="FilterMethod4" id="FilterMethod4" style="width:180px;">
				<option value="1">Forbid Search</option>
				<option value="2">Forbid Access</option>
				<option value="3">Forbid Search & Access</option>
			</select>
		</div>
		<div class="content contButton contBot">
              <input class="ButtonLeft" type="button" value="保存" onclick="FilterSet()" /> 
        </div>  
    </form>
</div>

<div class="hankClass">
	<div class="hankName"><label>802.1X</label></div>
    <br />
    <form class="clearSpace" id="Form8021X" method="post" action="/form/Para8021XSet" target="hideFrame">
    	<input type="hidden" name="flag" value="0" />
        <input type="hidden" name="language" value="cn" />
        <div class="content contTop">
        	<input type="hidden" id="state8021" value='<%Para8021XGet("X8021Auth", "net");%>' />
            <label class="setExplainEN">Authentication:&nbsp;</label>
            <div class="radioSelectEN">
            	<input type="radio" name="X8021Auth" id="js8021used1" value="1" onclick="State8021Changed(1)" />
                <label for="js8021used1">On</label>
            </div>
            <div class="radioSelectEN">
            	<input type="radio" name="X8021Auth" id="js8021used0" value="0" onclick="State8021Changed(0)" />
                <label for="js8021used0">Off</label>
            </div>
        </div>
        <div class="content" id="js8021EAPhank">
        	<input type="hidden" id="EAPformat" value='<%Para8021XGet("methods", "net");%>' />
            <label class="setExplainEN" id="js8021ModeLab">EAP method:&nbsp;</label>
            	<select class="selectLab" name="methods" id="js8021EAPmode" onchange="EAPChanged()">
                	<option value="0">MD5</option>
                    <option value="1">TLS</option>
                    <option value="2">PEAP</option>
                </select>
        </div>
        <input type="hidden" id="p8021usernameGet" value='<%Para8021XGet("username", "net");%>' />
        <input type="hidden" id="p8021passwordGet" value='<%Para8021XGet("password", "net");%>' />
        <input type="hidden" id="p8021privatepasswordGet" value='<%Para8021XGet("privatepassword", "net");%>' />
        <div id="js8021hank" style="height:70px;">
        	<div class="content">
        		<label class="setExplainEN">User name:&nbsp;</label>
            	<input class="showselect" name="username" id="js8021user" type="text" maxlength="63" />
        	</div>
        	<div class="content" id="js8021passHank">
        		<label class="setExplainEN">Password:&nbsp;</label>
            	<input class="showselect" name="password" type="password" id="js8021pass" maxlength="63" />
        	</div>
            <div class="content" id="js8021priPassHank">
            	<label class="setExplainEN">Private key password:&nbsp;</label>
                <input class="showselect" name="privatepassword" type="password" id="js8021pripass" maxlength="63" />
            </div>
            <div class="content" id="js8021CAuse" style="height:25px">
            	<label class="setExplainEN">&nbsp;</label>
                <input type="hidden" id="js8021peapcaGet" value='<%Para8021XGet("peapcaenable", "net");%>' />
                <input type="checkbox" name="peapcaenable" id="js8021PEAPbox" value="1" style="float:left; vertical-align:middle; margin-top:1px" />
                <label id="PEAPCAlabel" style="font-size:13px; line-height: 20px; vertical-align:middle; margin-top:1px" for="js8021PEAPbox">Use CA certificate</label>
            </div>
        </div>
        <div class="content contBot contButton">
        	<input class="ButtonLeft" type="button" value="Save" onclick="f8021sumbit()" />
            <input class="ButtonRight" type="button" value="Cancel" onclick="f8021reset()" />
        </div>
    </form>
    <div class="hankName" id="js8021fileForm"><label>Certificate import</label></div>
    <br />
    <div id="js8021TLSfile">
	    <form class="clearSpace" id="FormTLSCA" method="post" action="/form/Para8021XSet" enctype="multipart/form-data" target="hideFrame">
        	<input type="hidden" name="flag" value="1" />
            <input type="hidden" name="format" />
        	<input type="hidden" name="language" value="cn" />
    		<div class="content contTop">
        		<label class="setExplainEN">CA certificate:&nbsp;</label>
            	<input class="fileUpCon" type="file" id="jsTLSCAfile" name="fileName" />
            	<input class="uploadFile" type="button" id="jsTLSCAfileBto" value="Submit" onclick="PEMupload('jsTLSCAfile','FormTLSCA')" />
        	</div>
    	</form>
        <form class="clearSpace" id="FormTLSuser" method="post" action="/form/Para8021XSet" enctype="multipart/form-data" target="hideFrame">
        	<input type="hidden" name="flag" value="2" />
            <input type="hidden" name="format" />
        	<input type="hidden" name="language" value="cn" />
        	<div class="content contTop">
            	<label class="setExplainEN">User certificate:&nbsp;</label>
                <input class="fileUpCon" type="file" id="jsTLSUserFile" name="fileName" />
                <input class="uploadFile" type="button" id="jsTLSUserFileBto" value="Submit" onclick="PEMupload('jsTLSUserFile','FormTLSuser')"  />
            </div>
        </form>
        <form class="clearSpace" id="FormTLSpass" method="post" action="/form/Para8021XSet" enctype="multipart/form-data" target="hideFrame">
        	<input type="hidden" name="flag" value="3" />
            <input type="hidden" name="format" />
        	<input type="hidden" name="language" value="cn" />
        	<div class="content contTop">
            	<label class="setExplainEN">Private key certificate:&nbsp;</label>
                <input class="fileUpCon" type="file" id="jsTLSPassFile" name="fileName" />
                <input class="uploadFile" type="button" id="jsTLSPassFileBto" value="Submit" onclick="PEMupload('jsTLSPassFile','FormTLSpass')" />
          </div>
        </form>
    </div>
    <div id="js8021PEAPfile">
    	<form class="clearSpace" id="FormPEAPCA" method="post" action="/form/Para8021XSet" enctype="multipart/form-data" target="hideFrame">
        	<input type="hidden" name="flag" value="5" />
            <input type="hidden" name="format" />
        	<input type="hidden" name="language" value="cn" />
        	<div class="content contTop">
            	<label class="setExplainEN">CA certificate:&nbsp;</label>
                <input class="fileUpCon" type="file" id="jsPEAPCAfile" name="fileName" />
                <input class="uploadFile" type="button" id="jsPEAPCAfileBto" value="Submit" onclick="PEMupload('jsPEAPCAfile','FormPEAPCA')" />
          </div>
        </form>
    </div>
</div>

<div class="hankClass">
	<div class="hankName"><label>SNMP</label></div>
    <br />
    <form class="clearSpace" name="network" id="SNMPform" method="post" action="/form/SNMPparaCfg" target="hideFrame">
        <input type="hidden" name="language" value="cn" />
        <input type="hidden" id="versionGet" value='<%SNMPparaGet("version", "net");%>' />
        <input type="hidden" id="read_communityGet" value='<%SNMPparaGet("read_community", "net");%>' />
        <input type="hidden" id="write_communityGet" value='<%SNMPparaGet("write_community", "net");%>' />
    	<div class="content">
            <label class="setExplain" style="width:150px">Enable SNMP :&nbsp;</label>
            <label>v1:</label>
            <input type="checkbox" value="0" name="version1" id="version1" onclick="SnmpVersionSet(1)" style="float:left;" />
            <label>&nbsp;&nbsp;v2c:</label>
            <input type="checkbox" value="0" name="version2" id="version2" onclick="SnmpVersionSet(2)" style="float:left;" />
            <label disabled="disabled">&nbsp;&nbsp;v3:</label>
            <input disabled="disabled" type="checkbox" value="0" name="version3" id="version3" onclick="SnmpVersionSet(3)" style="float:left;" />
       </div>
       <div class="content">
            <label class="setExplain" style="width:150px">Read Community:&nbsp;</label>
            <input class="showselect" name="read_community" id="jsread_community" type="text" maxlength="16" />
       </div>
       <div class="content">
            <label class="setExplain" style="width:150px">Write Community:&nbsp;</label>
            <input class="showselect" name="write_community" id="jswrite_community" type="text" maxlength="16" />
       </div>
       <div class="content contButton contBot">
              <input class="ButtonLeft" type="button" value="Save" onclick="submit()" /> 
     	   	 <input class="ButtonRight" type="button" value="Cancel" onclick="SnmpReset()"  />   
        </div>  
    </form>
</div>

<div class="hankClass">
	<div class="hankName"><label>QoS</label></div>
    <br />
    <form class="clearSpace" name="network" id="QOSform" method="post" action="/form/netparaCfg" target="hideFrame">
	    <div class="content">
        	<input type="hidden" name="flag" value="3" />
            <input type="hidden" name="language" value="cn" />
        	<input id="QOSmode" type="hidden" value='<%NetparaGet("QOS", "net");%>' />
        	<label class="setExplainEN">QoS option:&nbsp;</label><select class="selectLab" name="QOS" id="jsQOSmode">
            																	<option value="0">Normal service</option>
                                                                                <option value="1">High reliability</option>
                                                                                <option value="2">High throughput</option>
                                                                                <option value="3">Low latency</option>
                                                                              </select>
       </div>
       <div class="content contButton contBot">
             <input class="ButtonLeft" style="margin-left: 220px" type="button" value="Save"   onclick="QOSsubmit()" /> 
      	   	 <input class="ButtonRight" type="button" value="Cancel" onclick="QOSreset()"  />   
        </div>  
   </form>
</div>

<div class="hankClass">
	<div class="hankName"><label>IGMP</label></div>
    <br />
    <form class="clearSpace" name="network" id="IGMPform" method="post" action="/form/IGMPparaSet" target="hideFrame">
    	<div class="content">
        	<label class="setExplainEN">Stream type:&nbsp;</label>
            <select class="selectLab" name="IGMPTYPE" id="IGMPstream" onchange="IGMPstreamChanged()" >
            	<option value="0">Main Stream</option>
                <option value="1">Sub Stream</option>
                <option value="2">MJPEG</option>
           </select>
       </div>
       <div id="IGMP0">
            <input id="IGMP0State" type="hidden" value='<%IGMPparaGet("IGMPMajorEnable","net");%>' />
            <input id="IGMP0IP" type="hidden" value='<%IGMPparaGet("IGMPMajorIP","net");%>' />
            <input id="IGMP0Port" type="hidden" value='<%IGMPparaGet("IGMPMajorPort","net");%>' />
            <div class="content contTop">	
        	    <label class="setExplainEN">State:&nbsp;</label>
            	<div class="radioSelectEN">
            		<input type="radio" name="IGMPMajorEnable" id="jsIGMP0ON1" value="1" onclick="IGMPchanged(0,1)" />
                    <label for="jsIGMP0ON1">On</label>
          		</div>
    	        <div class="radioSelectEN">
        	    	<input type="radio" name="IGMPMajorEnable" id="jsIGMP0ON0" value="0" onclick="IGMPchanged(0,0)" />
                    <label for="jsIGMP0ON0">Off</label>
        	    </div>
      	 </div>
     	  <div class="content" id="jsIGMP0IPhank">
        	    <label class="setExplainEN">MultiCast IP address:&nbsp;</label>
            	<input class="showselect" name="IGMPMajorIP" id="jsIGMP0IP" type="text" maxlength="15" value="" />
    	   </div> 		
           <div class="content" id="jsIGMP0Porthank">
           		<label class="setExplainEN">RTP port:&nbsp;</label>
            	<input class="showselect" name="IGMPMajorPort" id="jsIGMP0Port" maxlength="5" type="text" value="" />
       		</div>
       </div>
       <div id="IGMP1" style="display:none">
            <input id="IGMP1State" type="hidden" value='<%IGMPparaGet("IGMPMinorEnable","net");%>' />
            <input id="IGMP1IP" type="hidden" value='<%IGMPparaGet("IGMPMinorIP","net");%>' />
            <input id="IGMP1Port" type="hidden" value='<%IGMPparaGet("IGMPMinorPort","net");%>' />
            <div class="content contTop">
        	    <label class="setExplainEN">State:&nbsp;</label>
            	<div class="radioSelectEN">
            		<input type="radio" name="IGMPMinorEnable" id="jsIGMP1ON1" value="1" onclick="IGMPchanged(1,1)" />
                    <label for="jsIGMP1ON1">On</label>
          		</div>
    	        <div class="radioSelectEN">
        	    	<input type="radio" name="IGMPMinorEnable" id="jsIGMP1ON0" value="0" onclick="IGMPchanged(1,0)" />
                    <label for="jsIGMP1ON0">Off</label>
        	    </div>
      	 </div>
     	  <div class="content" id="jsIGMP1IPhank">
        	    <label class="setExplainEN">MultiCast IP address:&nbsp;</label>
            	<input class="showselect" name="IGMPMinorIP" id="jsIGMP1IP" type="text" maxlength="15" value="" />
    	   </div> 		
           <div class="content" id="jsIGMP1Porthank">
           		<label class="setExplainEN">RTP port:&nbsp;</label>
            	<input class="showselect" name="IGMPMinorPort" id="jsIGMP1Port" maxlength="5" type="text" value="" />
       		</div>
       </div>
      <div id="IGMP2" style="display:none">
      		<input id="IGMP2State" type="hidden" value='<%IGMPparaGet("IGMPMjpegEnable","net");%>' />
            <input id="IGMP2IP" type="hidden" value='<%IGMPparaGet("IGMPMjpegIP","net");%>' />
            <input id="IGMP2Port" type="hidden" value='<%IGMPparaGet("IGMPMjpegPort","net");%>' />
            <div class="content contTop">
        	    <label class="setExplainEN">State:&nbsp;</label>
            	<div class="radioSelectEN">
            		<input type="radio" name="IGMPMjpegEnable" id="jsIGMP2ON1" value="1" onclick="IGMPchanged(2,1)" />
                    <label for="jsIGMP2ON1">On</label>
          		</div>
    	        <div class="radioSelectEN">
        	    	<input type="radio" name="IGMPMjpegEnable" id="jsIGMP2ON0" value="0" onclick="IGMPchanged(2,0)" />
                    <label for="jsIGMP2ON0">Off</label>
        	    </div>
      	 </div>
     	  <div class="content" id="jsIGMP2IPhank">
        	    <label class="setExplainEN">MultiCast IP address:&nbsp;</label>
            	<input class="showselect" name="IGMPMjpegIP" id="jsIGMP2IP" type="text" maxlength="15" />
    	   </div> 		
           <div class="content" id="jsIGMP2Porthank">
           		<label class="setExplainEN">RTP port:&nbsp;</label>
            	<input class="showselect" name="IGMPMjpegPort" id="jsIGMP2Port" maxlength="5" type="text" />
       		</div>
       </div>
       <div class="content contButton contBot">
             <input class="ButtonLeft" style="margin-left:220px" type="button" value="Save" onclick="IGMPsubmit('IGMPform')" /> 
      	   	 <input class="ButtonRight" type="button" value="Cancel" onclick="IGMPreset()"  />   
        </div>  
   </form>
</div>

<div class="hankClass">
	<div class="hankName"><label>SIP server</label></div>
    <br />
    <input type="hidden" id="SIP_Function_Usable" value='<%SIPServerGet("SIP_Function_Usable","net");%>'  />
	<form name="SIPForm" id="SIPForm" method="post" target="hideFrame" action="/form/SIPServerCfg">
    	<div class="content">
        	<label class="setExplainEN">SIP server IP:</label>
            <input class="sipInput" name="ServerIPAddress" type="text" id="jsSIPServerIPAddress" maxlength="15"  value='<%SIPServerGet("ServerIPAddress","net");%>'  />
        </div>
        <div class="content">
        	<label class="setExplainEN">Port:</label>
            <input class="sipInput" name="ServerPort" type="text" id="jsSIPServerPort" maxlength="10"  value='<%SIPServerGet("ServerPort","net");%>'  />
        </div>
        <div class="content">
        	<label class="setExplainEN">Server ID:</label>
            <input class="sipInput" name="ServerID" type="text" id="jsSIPServerID" maxlength="63" value='<%SIPServerGet("ServerID","net");%>'  />
        </div>
        <div class="content">
        	<label class="setExplainEN">Device ID:</label>
            <input class="sipInput" name="DevID" type="text" id="jsSIPDevID" maxlength="63" value='<%SIPServerGet("DevID","net");%>'  />
        </div>
        <div class="content">
        	<label class="setExplainEN">Alarm ID:</label>
            <input class="sipInput" name="AlmID" type="text" id="jsSIPAlmID" maxlength="63" value='<%SIPServerGet("AlmID","net");%>'  />
        </div>
        <div class="content">
        	<label class="setExplainEN">Register Interval:</label>
            <input class="sipInput" name="RegInterval" type="text" id="jsSIPRegInterval" maxlength="63" value='<%SIPServerGet("RegInterval","net");%>'  />
        </div>
        <div class="content">
        	<label class="setExplainEN">Heat beat Interval:</label>
            <input class="sipInput" name="HeartInterval" type="text" id="jsSIPHeartInterval" maxlength="63" value='<%SIPServerGet("HeartInterval","net");%>'  />
        </div>
        <div class="content">
        	<label class="setExplainEN">Auth UserName:</label>
            <input class="sipInput" name="AuthUserName" type="text" id="jsSIPAuthUserName" maxlength="63" value='<%SIPServerGet("AuthUserName","net");%>'  />
        </div>
        <div class="content">
        	<label class="setExplainEN">UserName:</label>
            <input class="sipInput" name="UserName" type="text" id="jsSIPUserName" maxlength="63" value='<%SIPServerGet("UserName","net");%>'  />
        </div>
        <div class="content">
        	<label class="setExplainEN">Password:</label>
            <input class="sipInput" name="Password" type="password" id="jsSIPPassword" maxlength="63" value='<%SIPServerGet("Password","net");%>'  />
        </div>
        <div class="content contButton contBot">
             <input class="ButtonLeft" style="margin-left:220px" type="button" value="Save" onclick="SIPsubmit()" /> 
      	   	 <input class="ButtonRight" type="button" value="Cancel" onclick="formSet('SIPForm',0)"  />   
        </div>  
    </form>
    <div class="hankName"><label>Position Information</label></div>
    <br />
    <form name="SIPPosForm" id="SIPPosForm" method="post" target="hideFrame" action="/form/SIPPosCfg">
    	<div class="content">
        	<label class="setExplainEN">Position name:</label>
            <input class="sipInput" name="Position" type="text" id="jsSIPPosition" maxlength="63"  value='<%SIPPosGet("Position","net");%>'  />
        </div>
        <div class="content">
        	<label class="setExplainEN">Longitude:</label>
            <input class="sipInput" name="Longitude" type="text" id="jsSIPLongitude" maxlength="20"  value='<%SIPPosGet("Longitude","net");%>'  />
        </div>
        <div class="content">
        	<label class="setExplainEN">Latitude:</label>
            <input class="sipInput" name="Latitude" type="text" id="jsSIPLatitude" maxlength="20" value='<%SIPPosGet("Latitude","net");%>'  />
        </div>
        <div class="content contButton contBot">
             <input class="ButtonLeft" style="margin-left:220px" type="button" value="Save" onclick="SIPPosSubmit()" /> 
      	   	 <input class="ButtonRight" type="button" value="Cancel" onclick="formSet('SIPPosForm',0)"  />   
        </div>  
    </form>
</div>

<div class="hankClass">
	<div class="hankName"><label>Motion detection alarm</label></div>
    <br />
    <form id="digifortForm" name="digifortForm" method="post" target="hideFrame" action="/form/DigifortparaSet" >
    	<input type="hidden" id="digifortEnableGet" value='<%DigifortparaGet("enable","net");%>' />
    	<div class="content">
            <label class="setExplainEN">State:</label>
            <div class="radioSelectEN">
                <input type="radio" name="enable" id="jsDigifortOn1" value="1" onclick="digifortState(1)" />
                <label for="jsDigifortOn1">On</label>
            </div>
            <div class="radioSelectEN">
                 <input type="radio" name="enable" id="jsDigifortOn0" value="0" onclick="digifortState(0)" />
                 <label for="jsDigifortOn0">Off</label>
            </div>
        </div>
    	<div class="content">
        	<label class="setExplainEN">Camera name:</label>
            <input class="showselect" type="text" name="cameraname" id="jsDGFTcameraname" maxlength="30" value='<%DigifortparaGet("cameraname","net");%>' />
        </div>
        <div class="content">
        	<label class="setExplainEN">User name:</label>
            <input class="showselect" type="text" name="username" id="jsDGFTusername" maxlength="30" value='<%DigifortparaGet("username","net");%>' />
        </div>
        <div class="content">
        	<label class="setExplainEN">Password:</label>
            <input class="showselect" type="password" name="password" id="jsDGFTpassword" maxlength="30" value='<%DigifortparaGet("password","net");%>' />
        </div>
        <div class="content">
        	<label class="setExplainEN">Server IP:</label>
            <input class="showselect" type="text" name="serverip" id="jsDGFTserverip" maxlength="15" value='<%DigifortparaGet("serverip","net");%>' />
        </div>
        <div class="content">
        	<label class="setExplainEN">Port No.:</label>
            <input class="showselect" type="text" name="port" id="jsDGFTport" maxlength="5" value='<%DigifortparaGet("port","net");%>' />
        </div>
        <div class="content contButton contBot">
             <input class="ButtonLeft" style="margin-left:220px" type="button" value="Save" onclick="digifortSubmit()" /> 
      	   	 <input class="ButtonRight" type="button" value="Cancel" onclick="formSet('digifortForm',0);digifortReset()"  />   
        </div>  
    </form>
</div>

<div class="hankClass">
<div class="hankName"><label>PORT</label></div>
		<br />
        <form  id="portForm" method="post" action="/form/NetPortSet" target="hideFrame">
	    <div class="content">
        	<label class="setExplain" >RTSP Port:</label>
            <input name="RtspPort" id="rtspPort" type="text" maxlength="6" value="<%NetPortGet("RtspPort","net");%>"/>
        </div>
        <div class="content">
            <label class="setExplain">Onvif Port:</label>
            <input name="OnvifPort" id="onvifPort" type="text" maxlength="6" value="<%NetPortGet("OnvifPort","net");%>"/>
			<!--<label class="setExplain">Onvif Port:</label><label>%NetPortGet("OnvifPort","net");%></label>-->
        </div>
        <div class="content">
            <label class="setExplain">Http Port:</label>
            <input name="HttpPort" id="httpPort" type="text" maxlength="6" value="<%NetPortGet("HttpPort","net");%>"/>
        </div>
        <div class="content">
            <label class="setExplain">Video Port:</label>
            <input name="VideoPort" id="videoPort" type="text" maxlength="6" value="<%NetPortGet("VideoPort","net");%>"/>
        </div>
        <div class="content">
            <label class="setExplain">Record Port:</label>
            <input name="RecordPort" id="recordPort" type="text" maxlength="6" value="<%NetPortGet("RecordPort","net");%>"/>
        </div>

        <div class="content contButton contBot">
             <input class="ButtonLeft" style="margin-left:220px" type="button" value="Save" onclick="PORTsubmit()" /> 
        </div>
		<div class="content">
		   <label style="margin-left:40px">Notes: Settings are invalid while the ports are repeat!</label>
           <br />
		   <label style="margin-left:40px">Please reboot the device and refresh the page after changing the ports.</label>
		</div>   
    </form>  
</div>

<div class="hankClass">
<div class="hankName"><label>DDNS</label></div>
    <br />
    <form class="clearSpace" id="DDNSform" method="post" action="/form/DDNSSet" target="hideFrame">
        <div class="content">
        	<input type="hidden" id="DDNSState" value='<%DDNSGet("DDNSEEnable", "net");%>' />
			<input type="hidden" id="DDNSM" value='<%DDNSGet("DDNSMethod", "net");%>' />
        	<label class="setExplainEN">DDNS Status:</label>
            <div class="radioSelectEN">
            	<input type="radio" name="DDNSEEnable" id="DDNSOn" value="1" onclick="DDNSStateChange()" />
                <label>On</label>
            </div>
            <div class="radioSelectEN">
            	<input type="radio" name="DDNSEEnable" id="DDNSOff" value="0" onclick="DDNSStateChange()" />
                <label>Off</label>
            </div>
        </div>
		<div class="content">
        	<label class="setExplainEN">Method:</label>
            <select class="selectLab" name="DDNSMethod" id="DDNSMethod">
            <!--	<option value="0">Peanut</option>
                <option value="1">Ezipupdate</option> 
               -->

 		<option value="0">CamAnyWhere</option>
        <option value="1">QDNS</option>
        <option value="2">DYNDNS</option>
        <option value="3">NO-IP</option>
           </select>
       </div>
       <div class="content">
            <label class="setExplainEN">Server Address:</label>
            <input class="showselect" name="HobcmsDomain" id="HobcmsDomain" type="text" maxlength="60" value="<%DDNSGet("HobcmsDomain", "net");%>" />
       </div>
       <div class="content">
            <label class="setExplainEN">Server Port:</label>
            <input name="HobcmsPort" id="HobcmsPort" type="text" maxlength="6" value="<%DDNSGet("HobcmsPort","net");%>"/>
        </div>

		<div class="content">
            <label class="setExplainEN" id="">UserName:</label>
            <input class="showselect" name="DDNSUserName" id="DDNSUserName" type="text" maxlength="20"
			value="<%DDNSGet("DDNSUserName", "net");%>"/>
       </div>
       <div class="content">
            <label class="setExplainEN" id="">Password:</label>
            <input class="showselect" name="DDNSPassword" id="DDNSPassword" type="password" maxlength="20"value="<%DDNSGet("DDNSPassword", "net");%>" />
       </div>
	   <div class="content">
            <label class="setExplainEN" id="">Domain:</label>
            <input class="showselect" name="DDNSDomain" id="DDNSDomain" type="text" maxlength="60" value="<%DDNSGet("DDNSDomain", "net");%>" />
       </div>
       <div class="content contButton contBot">
              <input class="ButtonLeft" type="button" value="Save" onclick="DDNSSet()" /> 
     	   	 <!--<input class="ButtonRight" type="button" value="Cancel" onclick=""  />   -->
        </div>  
    </form>
<!--
    <div class="hankName"><label>KaiCong Client</label></div>
    <br />
    <form class="clearSpace" id="kcDdnsForm" method="post" action="/form/kcDdnsSet" target="hideFrame">
        <div class="content">
        	<input type="hidden" id="kcDdnsEnable" value='<%kcDdnsGet("kcDdnsEnable", "net");%>' />
        	<label class="setExplainEN">State:</label>
            <div class="radioSelectEN">
            	<input type="radio" name="kcDdnsEnable" id="kcDdnsOn" value="1" onclick="kcDdnsStateChange()" />
                <label>Open</label>
            </div>
            <div class="radioSelectEN">
            	<input type="radio" name="kcDdnsEnable" id="kcDdnsOff" value="0" onclick="kcDdnsStateChange()" />
                <label>Close</label>
            </div>
        </div>
        <div class="content">
            <label class="setExplainEN">Username:</label>
            <input class="showselect" name="kcDdnsName" id="kcDdnsName" type="text" maxlength="32" value="<%kcDdnsGet("kcDdnsName", "net");%>" />
        </div>
       <div class="content">
            <label class="setExplainEN" id="">Password:</label>
            <input class="showselect" name="kcDdnsPassword" id="kcDdnsPassword" type="text" maxlength="32"value="<%kcDdnsGet("kcDdnsPassword", "net");%>" />
       </div>
       <div class="content contButton contBot">
              <input class="ButtonLeft" type="button" value="Save" onclick="kcDdnsSet()" /> 
        </div>  
    </form>
-->
</div>

<div class="hankClass">
	<div class="hankName"><label>MPLS</label></div>
    <br />
    <form name="sjkdForm" id="sjkdForm" method="post" target="hideFrame" action="/form/sjkdSet">
        <input type="hidden" name="sjkdEnable" id="jsSjkdEnable" value='<%sjkdGet("sjkdEnable","net");%>' />
    	<div class="content">
        	<label class="setExplain">Grp Server IP:</label>
            <input class="sipInput" name="sjkdGroupIP" type="text" id="jsSjkdGroupIP" maxlength="15" value='<%sjkdGet("sjkdServerGroupIP","net");%>' />
        </div>
        <div class="content">
        	<label class="setExplain">Prov Server IP:</label>
            <input class="sipInput" name="sjkdProcIP" type="text" id="jsSjkdProcIP" maxlength="63" value='<%sjkdGet("sjkdServerProcIP","net");%>' />
        </div>
        <div class="content">
        	<label class="setExplain">UPnP PORT:</label>
            <input class="sipInput" name="sjkdUpnpPort" type="text" id="jsSjkdUpnpPort" maxlength="15" value='<%sjkdGet("sjkdServerUpnpPort","net");%>' />
        </div>
        <div class="content">
        	<label class="setExplain">Dev ID:</label>
            <label><%sjkdGet("sjkdDevID","net");%></label>
        </div>
        <div class="content">
        	<label class="setExplain">Dev KEY:</label>
            <input class="sipInput" name="sjkdDevKey" type="text" id="jsSjkdDevKey" maxlength="15" value='<%sjkdGet("sjkdDevKey","net");%>' />
        </div>
        <div class="content contButton contBot">
             <input class="ButtonLeft" style="margin-left:220px" type="button" value="Save" onclick="sjkdSubmit()" /> 
      	   	 <!--<input class="ButtonRight" type="button" value="Cancel" onclick="formSet('sjkdForm',0)"  />   -->
        </div>  
    </form>
</div>

<div class="hankClass">
    <div class="hankName"><label>TUTK</label></div>
    <br />
    <form class="clearSpace" name="TUTK" id="TUTKForm" method="post" action="/form/TUTKCfg" target="hideFrame">
        <input type="hidden" name="language" value="cn" />
        <input type="hidden" id="TUTKUsableGet" value='<%TUTKGet("TUTKUsable","net");%>' />
        <div class="content contTop">
        	<label class="setExplain" id="TUTKlab">TUTK:&nbsp;</label>
            <input type="hidden" id="TUTKenableGet" value='<%TUTKGet("TUTKEnable","net");%>' />
            <div class="radioSelect">
<!--            	<input type="radio" name="TUTKEnable" id="TUTKon" value="1" onclick="TUTKStateChange()" />-->
            	<input type="radio" name="TUTKEnable" id="TUTKon" value="1" onclick="TUTKsubmit()" />
                <label>ON</label>
            </div>
            <div class="radioSelect">
<!--            	<input type="radio" name="TUTKEnable" id="TUTKoff" value="0" onclick="TUTKStateChange()" />-->
            	<input type="radio" name="TUTKEnable" id="TUTKoff" value="0" onclick="TUTKsubmit()" />
                <label>OFF</label>
            </div>
        </div>
	    <div class="content">
        	<label class="setExplain">UID:&nbsp;</label>
<!--            <input class="showselect" name="TUTKUidInput" id="TUTKUidInput" type="text" maxlength="20" value='< %TUTKGet("TUTKUid","net");%>'/>-->
				<label class="hank"><%TUTKGet("TUTKUid","net");%></label>
        </div>
	    <div class="content">
        	<label class="setExplain">Author Status:&nbsp;</label>
            <input id="TUTKAuthorizedGet" type="hidden" value='<%TUTKGet("TUTKAuthorized","net");%>' />
				<label class="hank" id="TUTKAuthorized1" style="display:none;">Authorized</label>
				<label class="hank" id="TUTKAuthorized0" style="display:none;">Not Authorized</label>
        </div>
	    <div class="content">
        	<label class="setExplain">Login Status:&nbsp;</label>
            <input id="TUTKStatusGet" type="hidden" value='<%TUTKGet("TUTKStatus","net");%>' />
				<label class="hank" id="TUTKStatus1" style="display:none;">Logged</label>
				<label class="hank" id="TUTKStatus0" style="display:none;">Not logged</label>
        </div>        
<!--        <div class="content contButton contBot">
        	<input class="ButtonLeft" type="button" value="Save" onclick="TUTKsubmit()" />
            <input class="ButtonRight" type="button" value="Cancel" onclick="TUTKreset()"  />
        </div>-->
    </form>
</div>

<div class="hankClass">
<div class="hankName"><label>Mobile</label></div>
    <br />
    <form class="clearSpace" id="Mobileform" method="post" action="/form/MobileSet" target="hideFrame">
        <input type="hidden" name="MobileCflag" id="MobileCflag" value='0' />
        <input type="hidden" id="MobileSupport_" value='<%MobileGet("MobileSupport", "net");%>' />
        <input type="hidden" id="MobileState_" value='<%MobileGet("MobileEnable", "net");%>' />
        <input type="hidden" id="MobileModle_" value='<%MobileGet("MobileModle", "net");%>' />
        <div class="content">
        	<label class="setExplain">FunctionSwitch:</label>
            <div class="radioSelect">
            	<input type="radio" name="MobileEnable" id="MobileOn" value="1" onclick="MobileStateChange()" />
                <label>On</label>
            </div>
            <div class="radioSelect">
            	<input type="radio" name="MobileEnable" id="MobileOff" value="0" onclick="MobileStateChange()" />
                <label>Off</label>
            </div>
        </div>
		<div class="content">
        	<label class="setExplain">NetModel:</label>
            <select class="selectLab" name="MobileModle" id="MobileModle" onchange="MobileModleChange()">
 				<option value="0">4G > 3G > 2G</option>
 				<option value="1">4G > 3G</option>
 				<option value="2">3G > 2G</option>
 				<option value="3">4G</option>
 				<option value="4">3G</option>
 				<option value="5">2G</option>
           </select>
       </div>
       <div class="content contButton contBot">
             <input class="ButtonLeft" type="button" value="Connect" style="margin-left:148px;" onclick="MobileConnect()" /> 
     	   	 <input class="ButtonRight" type="button" value="Disconnect" onclick="MobileDisconnect()"  />
        </div>
        <br />
        <div class="content">
        	<label class="setExplain">NetStatus:</label>
			<div id="MobileStatus"></div>
		</div>
        <div class="content contButton contBot">
     	   	 <input class="ButtonLeft" type="button" value="Refresh" style="margin-left:148px;" onclick="MobileRefresh()"  />
		</div>
    </form>
</div>

<div class="hankClass">
	<div class="hankName"><label>APP Configuration</label></div>
	<br />
	<div class="content contTop">
		<label class="setExplain">APP Select:</label>
		<select class="selectLab" name="APPSelect" id="APPSelect" onchange="APPSelectChange()">
	 		<option value="ppcn_div">P2P</option>
	 		<option value="ulu_div">CloudLens</option>
	 		<option value="glink_div" selected="selected">HiSee</option>
	    </select>
    </div>
    <br />
    <div id="ppcn_div" style="display:none">
    <div class="hankName"><label>P2P</label></div>
    <br />
    <form class="clearSpace" name="PPCN" id="PPCNForm" method="post" action="/form/PPCNCfg" target="hideFrame">
        <input type="hidden" name="language" value="cn" />
	        <div class="content">
        	<label class="setExplain" id="PPCNlab">P2P:&nbsp;</label>
            <input type="hidden" id="PPCNenableGet" value='<%PPCNGet("PPCNEnable","net");%>' />
            <input type="hidden" id="ppcn_id" value='<%PPCNGet("PPCNUid","net");%>' />
            <div class="radioSelect">
            	<input type="radio" name="PPCNEnable" id="PPCNon" value="1" onclick="PPCNsubmit()" />
                <label>ON</label>
            </div>
            <div class="radioSelect">
            	<input type="radio" name="PPCNEnable" id="PPCNoff" value="0" onclick="PPCNsubmit()" />
                <label>OFF</label>
            </div>
        </div>
	    <div class="content">
        	<label class="setExplain">ID:&nbsp;</label>
				<label class="hank"><%PPCNGet("PPCNUid","net");%></label>
        </div>
        <div id="qrcodeTable" style="float:left;margin-top: 20px;margin-left: 80px"></div>
    </form>
</div>
	<div id="ulu_div" style="display:none">
    <div class="hankName"><label>CloudLens</label></div>
    <br />
    <form class="clearSpace" name="ULU" id="ULUForm" method="post" action="/form/ULUCfg" target="hideFrame">
        <input type="hidden" name="language" value="cn" />
        <input type="hidden" name="ULUreset" id="ULUreset" value="0" />
	        <div class="content">
        	<label class="setExplain" id="ULUlab">P2P:&nbsp;</label>
            <input type="hidden" id="ULUenableGet" value='<%ULUGet("ULUEnable","net");%>' />
            <input type="hidden" id="ulu_id" value='<%ULUGet("ULUUid","net");%>' />
            <input type="hidden" id="PPCNUsable" value='<%PPCNGet("PPCNUsable","net");%>' />
            <div class="radioSelect">
            	<input type="radio" name="ULUEnable" id="ULUon" value="1" onclick="ULUsubmit()" />
                <label>ON</label>
            </div>
            <div class="radioSelect">
            	<input type="radio" name="ULUEnable" id="ULUoff" value="0" onclick="ULUsubmit()" />
                <label>OFF</label>
            </div>
        </div>
	    <div class="content" id="ULU_ID_DIV">
        	<label class="setExplain">ID:&nbsp;</label>
				<label class="hank"><%ULUGet("ULUUid","net");%></label>
        </div>
	    <div class="content" id="ULU_RESET_DIV">
        	<label class="setExplain">Reset:&nbsp;</label>
              <input class="ButtonLeft" style="margin-left:0px;" type="button" value="Reset" onclick="$('#ULUreset').val(1);ULUsubmit();" /> 
        </div>
        <div id="qrcodeTableULU" style="float:left;margin-top: 20px;margin-left: 80px"></div>
    </form>
</div>
	<div id="glink_div" style="display:block">
    <div class="hankName"><label>HiSee</label></div>
    <br />
    <form class="clearSpace" name="GLINK" id="GLINKForm" method="post" action="/form/GLINKCfg" target="hideFrame">
        <input type="hidden" name="language" value="cn" />
	        <div class="content">
        	<label class="setExplain" id="GLINKlab">P2P:&nbsp;</label>
            <input type="hidden" id="GLINKenable_" value='<%GLINKGet("GLINKenable","net");%>' />
            <input type="hidden" id="GLINKid_" value='<%GLINKGet("GLINKid","net");%>' />
            <input type="hidden" id="GLINKusable_" value='<%GLINKGet("GLINKusable","net");%>' />
           <div class="radioSelect">
            	<input type="radio" name="GLINKenable" id="GLINKon" value="1" onclick="GLINKsubmit()" />
                <label>ON</label>
            </div>
            <div class="radioSelect">
            	<input type="radio" name="GLINKenable" id="GLINKoff" value="0" onclick="GLINKsubmit()" />
                <label>OFF</label>
            </div>
        </div>
	    <div class="content" id="GLINK_ID_DIV">
        	<label class="setExplain">ID:&nbsp;</label>
			<label class="hank"><%GLINKGet("GLINKid","net");%></label>
        </div>
	    <div class="content" id="GLINK_STATUS_DIV">
        	<label class="setExplain">Status:&nbsp;</label>
			<label class="hank"><%GLINKGet("GLINKstatus","net");%></label>
        </div>
        <div id="qrcodeTableGLINK" style="float:left;margin-top: 20px;margin-left: 80px"></div>
	        <br />
        <div class="hankName"><label>Download mobile APP</label></div>
        <div class="content">
	        <div class="qrSection">
		        <div class="content" style="width:240px; margin-bottom:10px; margin-left:0px;">
                    <label style="float:none">Android:&nbsp;</label>
                </div>
		        <div id="qrcodeTableAndroidHisee"><img style="width:200px; height:200px" src="../images/hisee_android.png" /></div>
		    </div>
		    <div class="qrSection">
		        <div class="content" style="width:240px; margin-bottom:10px; margin-left:0px;">
                    <label style="float:none">IOS:&nbsp;</label>
                </div>
		        <div id="qrcodeTableIPhoneHisee"><img style="width:200px; height:200px" src="../images/hisee_ios_cn.png" /></div>
		    </div>
		</div>
    </form>
	</div>
</div>

<div class="hankClass">
    <div class="hankName"><label>L-SU</label></div>
    <br />
    <form class="clearSpace" name="EL" id="ELForm" method="post" action="/form/ELCfg" target="hideFrame">
        <input type="hidden" name="language" value="cn" />
        <div class="content contTop">
        	<label class="setExplain" id="ELlab">Switch:&nbsp;</label>
            <input type="hidden" id="ELusable_" value='<%ELGet("ELusable","net");%>' />
            <input type="hidden" id="ELenable_" value='<%ELGet("ELenable","net");%>' />
            <input type="hidden" id="ELstatus_" value='<%ELGet("ELstatus","net");%>' />
            <input type="hidden" id="ELid_" value='<%ELGet("ELid","net");%>' />
            <div class="radioSelect">
            	<input type="radio" name="ELenable" id="ELon" value="1" onclick="ELsubmit()" />
                <label>ON</label>
            </div>
            <div class="radioSelect">
            	<input type="radio" name="ELenable" id="ELoff" value="0" onclick="ELsubmit()" />
                <label>OFF</label>
            </div>
        </div>
	    <div class="content">
        	<label class="setExplain">Status:&nbsp;</label>
				<label class="hank" id="ELstatus"></label>
        </div>
	    <div class="content" id="EL_ID_DIV">
        	<label class="setExplain">ID:&nbsp;</label>
			<label class="hank" style="width:350px" id="ELid_label"></label>
        </div>
        <div id="qrcodeTableEL" style="float:left;margin-top: 20px;margin-left: 80px"></div>
    </form>
</div>
    
    <div class="hankClass">
    <div class="hankName"><label>Protocol</label></div>
    <br />
    <form class="clearSpace" name="Proto" id="ProtoForm" method="post" action="/form/ProtoCfg" target="hideFrame">
        <input type="hidden" id="ProtoName_" value='<%ProtoGet("ProtoName","net");%>' />
        <input type="hidden" id="ProtoEnable_" value='<%ProtoGet("ProtoEnable","net");%>' />
        <div id="Protodiv">
        </div>
        <div class="content contButton contBot">
             <input class="ButtonLeft" style="margin-left:220px" type="button" value="Save" onclick="PROTOsubmit()" /> 
       </div>
    </form>
</div>

</body>
</html>

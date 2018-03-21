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
<input type="hidden" id="PAGE_LANGUAGE" value="1" />
<input type="hidden" id="SAMSUNG_MODULES" value='<%NetparaGet("SamsungModules","net");%>' />
<input type="hidden" id="Auth8021xModules" value='<%NetparaGet("Auth8021xModules","net");%>' />
<input type="hidden" id="SnmpModules" value='<%NetparaGet("SnmpModules","net");%>' />
<input type="hidden" id="PppoeModules" value='<%NetparaGet("PppoeModules","net");%>' />
<input type="hidden" id="Hi3518E" value='<%videoparaGet("hi3518e", "net");%>' />
<iframe onload="iframeLoad()" id="hideFrame" name="hideFrame" style=" display:none"></iframe>

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
        <li class="choose" onclick="sysShow('hankClass',11)" style="display:none">互信互通</li>
        <li class="choose" onclick="sysShow('hankClass',12)">PORT</li>
        <li class="choose" onclick="sysShow('hankClass',13)">DDNS</li>
        <li class="choose" onclick="sysShow('hankClass',14)" id="sjkd_LI" style="display:none">MPLS</li>
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
        	<label class="setExplain" id="DHCPlab">DHCP:&nbsp;</label>
            <input type="hidden" id="DHCPenableGet" value='<%NetparaGet("DHCPenable","net");%>' />
            <div class="radioSelect">
            	<input type="radio" name="DHCPenable" id="jsDHCPenable1" value="1" onclick="DHCPchanged(1)" />
                <label for="jsDHCPenable1">开启</label>
            </div>
            <div class="radioSelect">
            	<input type="radio" name="DHCPenable" id="jsDHCPenable0" value="0" onclick="DHCPchanged(0)" />
                <label for="jsDHCPenable0">关闭</label>
            </div>
        </div>
        <input type="hidden" id="outIPAddrGet" value='<%NetparaGet("outIPAddr","net");%>' />
        <input type="hidden" id="outMaskAddrGet" value='<%NetparaGet("outMaskAddr","net");%>' />
        <input type="hidden" id="outGatewayGet" value='<%NetparaGet("outGateway","net");%>' />
        <input type="hidden" id="outDNSFirstServerGet" value='<%NetparaGet("outDNSFirstServer","net");%>' />
        <input type="hidden" id="outDNSSecondServerGet" value='<%NetparaGet("outDNSSecondServer","net");%>' />
	    <div class="content">
        	<label class="setExplain">IP 地址:&nbsp;</label>
            <input class="showselect" name="outIPAddr" id="jsIP" type="text" maxlength="15" />
        </div>
        <div class="content">
            <label class="setExplain">子网掩码:&nbsp;</label>
            <input class="showselect" name="outMaskAddr" id="jsMaskAddr" type="text" maxlength="15" />
        </div>
        <div class="content">
            <label class="setExplain">默认网关:&nbsp;</label>
            <input class="showselect" name="outGateway" id="jsGateway" type="text" maxlength="15" />
        </div>
        <div class="content">
            <label class="setExplain">首选DNS服务器:&nbsp;</label>
            <input class="showselect" name="outDNSFirstServer" id="jsDNS0" type="text" maxlength="15" />
        </div>
        <div class="content">
            <label class="setExplain">备用DNS服务器:&nbsp;</label>
            <input class="showselect" name="outDNSSecondServer" id="jsDNS1" type="text" maxlength="15" />
        </div>
        <div class="content contButton contBot">
             <input class="ButtonLeft" type="button" value="保存" onclick="networkSubmit('networkForm')" /> 
      	   	 <input class="ButtonRight" type="button" value="取消" onclick="networkReset()"/>   
        </div>   
    </form>

    <div class="hankName" id="WifiLabel" style="display:block"><label>Wifi</label></div>
    <br />
    <form class="clearSpace" id="WifiForm" style="display:block" method="post" action="/form/WifiCfg" target="hideFrame" >
		<input type="hidden" id="WifiChecking" value="0" />
    	<input type="hidden" name="flag" id="flag" value="0" />
        <input type="hidden" name="language" value="cn" />
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
                <label for="jsWifiOn">开启</label>
            </div>
            <div class="radioSelect">
            	<input type="radio" name="WifiEnable" id="jsWifiOff" value="0" onclick="WifiEnableChanged()" />
                <label for="jsWifiOff">关闭</label>
            </div>
        </div>
        <div class="content">
        	<label class="setExplain">模式:&nbsp;</label>
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
				<label class="setExplain" id="jsWifiKeyLab">密码:&nbsp;</label>
				<input class="showselect" name="WifiKey" id="jsWifiKey" maxlength="64" />
			</div>
			<div class="content">
				<label class="setExplain" id="jsWifiStatusLab">状态:&nbsp;</label>
				<input id="WifiStatus_Get" type="hidden" value='<%WifiGet("WifiStatus","net");%>' />
					<label class="hank" id="jsWifiStatus1" style="display:none;width:75px">已连接</label>
					<label class="hank" id="jsWifiStatus0" style="display:none;width:75px">未连接</label>
					<label class="hank" id="jsWifiIP" style="display:none;width:200px">IP: none</label>
			</div>
			<div class="content contButton contBot">
				<input class="ButtonLeft" type="button" id="jsWifiConnect" value="连接" onclick="WifiSubmit()" />
				<input class="ButtonRight" type="button" id="jsWifiStatus" value="刷新状态" onclick="WifiStatus()" />
			</div>
		</div>
		<div id="divAP" style="display:none;">
			<div class="content">
				<label class="setExplain" id="jsWifiAPSSIDLab">APSSID:&nbsp;</label>
				<input class="showselect" name="WifiAPSSID" id="jsWifiAPSSID" type="text" style="disabled:true"/>
			</div>
			<div class="content">
				<label class="setExplain" id="jsWifiChannelLab">信道:&nbsp;</label>
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
				<input class="ButtonLeft" type="button" id="jsWifiAPSet" value="设置" onclick="WifiAPSubmit()"/>
			</div>
		</div>
    </form>
        
      
     <br />  
      
    <form class="clearSpace" style="display:block" id="WifiHotspotForm" name="WifiHotspotForm" method="post" action="/form/WifiQuery" target="hideFrame">
        <div class="content" style="margin-left:80px;display:none">
        <textarea id="hotspotlist" name="hotspotlist" rows="4" cols="32" value='< %WifiQuery("WifiHotspot","net");%>'></textarea>
        </div>
        <div class="content">
	    	<label class="setExplain" id="jsWifiStatusLab">无线网络列表:&nbsp;</label>
    		<select class="showselect" name="hotspotlistSelect" id="hotspotlistSelect" style="width:160px;height:20px" onchange="WifiSelect()">
        	</select>
        </div>
    	<div class="content contButton contBot">
		<input class="ButtonLeft" type="button" id="jsWifiHotspotSearch" value="搜索" onclick="WifiQuerySubmit()" />
        </div>
    </form>
    
    <br />
    <form class="clearSpace" id="PacketForm" style="display:block" method="post" action="/form/PacketCfg" target="hideFrame" >
    	<input type="hidden" name="flag" id="flag" value="0" />
        <input type="hidden" name="language" value="cn" />
        <input type="hidden" id="WIFIBitrateControl_Get" value='<%PacketGet("WIFIBitrateControl", "net");%>' />
        <div class="content">
        	<label class="setExplain">码流控制：</label>
            <div class="radioSelect">
            	<input type="radio" name="WIFIBitrateControl" id="jsWIFIBitrateControlAuto" value="1" />
                <label for="jsWIFIBitrateControlAuto">自动</label>
            </div>
            <div class="radioSelect">
            	<input type="radio" name="WIFIBitrateControl" id="jsWIFIBitrateControlManual" value="0" />
                <label for="jsWIFIBitrateControlManual">手动</label>
            </div>
        </div>
        
        <div class="content contButton contBot">
			<input class="ButtonLeft" type="button" id="jsPacketSizeSet" value="设置" onclick="document.getElementById('PacketForm').submit()" />
        </div>
        
 	</form>
        
    
    
    <div class="hankName" id="PPPOElabel" style="display:none"><label>PPPOE</label></div>
    <br />
    <form class="clearSpace" id="PPPOEform" method="post" action="/form/netparaCfg" target="hideFrame" style="display:none">
    	<input type="hidden" name="flag" value="6" />
        <input type="hidden" name="language" value="cn" />
        <input type="hidden" id="PPPOEstate" value='<%NetparaGet("pppoe_enable", "net");%>' />
        <div class="content">
        	<label class="setExplain">状态:&nbsp;</label>
            <div class="radioSelect">
            	<input type="radio" name="pppoe_enable" id="jsPPPOEuse1" value="1" onclick="pppoeChanged(1)" />
                <label for="jsPPPOEuse1">开启</label>
            </div>
            <div class="radioSelect">
            	<input type="radio" name="pppoe_enable" id="jsPPPOEuse0" value="0" onclick="pppoeChanged(0)" />
                <label for="jsPPPOEuse0">关闭</label>
            </div>
        </div>
        <input type="hidden" id="pppoe_nameGet" value='<%NetparaGet("pppoe_name","net");%>' />
        <input type="hidden" id="pppoe_passwdGet" value='<%NetparaGet("pppoe_passwd","net");%>' />
        <div class="content">
        	<label class="setExplain" id="jsPPPOEuserLab">用户名:&nbsp;</label>
            <input class="showselect" name="pppoe_name" id="jsPPPOEuser" type="text" maxlength="30" />
        </div>
        <div class="content">
        	<label class="setExplain" id="jsPPPOEpassLab">密码:&nbsp;</label>
            <input class="showselect" name="pppoe_passwd" id="jsPPPOEpass" type="password" maxlength="20" />
        </div>
        <div class="content">
        	<label class="setExplain" id="jsPPPOEipLab">IP 地址:&nbsp;</label>
            <label class="showselect" id="jsPPPOEip" style="margin-top:3px"><%NetparaGet("pppoe_IP","net");%></label>
        </div>
        <div class="content contButton contBot">
        	<input class="ButtonLeft" type="button" value="保存" onclick="PPPOEsubmit()" />
            <input class="ButtonRight" type="button" value="取消" onclick="PPPOEreset()"  />
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
        	<label class="setExplain">心跳服务器 IP:&nbsp;</label>
            <input class="showselect" name="SNMP_IP" id="jsSNMPip" type="text" maxlength="15" />
        </div>
        <div class="content">
        	<label class="setExplain">心跳间隔:</label>
            <input name="SNMP_interval" id="jsSNMPinterval" type="text" maxlength="3" size="3" style="float:left" />
            <label class="setExplain" style="margin-left:0">&nbsp;秒(1~300)</label>
        </div>
        <div class="content contButton contBot">
             <input class="ButtonLeft" type="button" value="保存" onclick="SNMPsubmit('SNMPform')" /> 
      	   	 <input class="ButtonRight" type="button" value="取消" onclick="SNMPreset()" />   
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
            <label class="setExplain">服务器 :&nbsp;</label>
            <input class="showselect" name="serverip" id="jsFTPIP" type="text" maxlength="60" />
       </div>
       <div class="content">
            <label class="setExplain">端口 :&nbsp;</label>
            <input class="showselect" style="width:80px" name="port" id="jsFTPport" type="text" maxlength="8" />
            <label>(1-65535)</label>
       </div>
       <div class="content">
            <label class="setExplain">用户名:&nbsp;</label>
            <input class="showselect" name="username" id="jsFTPuser" type="text" maxlength="63" />
       </div>
       <div class="content">
            <label class="setExplain">密码:&nbsp;</label>
            <input class="showselect" name="password" id="jsFTPpass" type="password" maxlength="63" />
       </div>
       <div class="content">
            <label class="setExplain">上传目录 :&nbsp;</label>
            <input class="showselect" name="path" id="jsFTPpath" type="text" maxlength="63" />
       </div>
       <div class="content">
            <label class="setExplain">抓拍文件名 :&nbsp;</label>
            <input class="showselect" name="filename" id="jsFTPfilename" type="text" maxlength="63" />
       </div>
       <div class="content">
            <label class="setExplain">抓拍张数 :&nbsp;</label>
            <input class="showselect" name="snapcount" id="jsFTPcount" type="text" maxlength="4" />
       </div>
       <div class="content">
            <label class="setExplain">抓拍间隔 :&nbsp;</label>
            <input class="showselect" style="width:115px" name="snapinterval" id="jsFTPinterval" type="text" maxlength="4" />
            <label>&nbsp;秒</label>
       </div>
       <div class="content contButton contBot">
             <input class="ButtonLeft" type="button" value="保存" onclick="FTPsubmit('FTPform')" /> 
      	   	 <input class="ButtonRight" type="button" value="取消" onclick="FTPreset()" />   
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
            <label class="setExplain">服务器 :&nbsp;</label>
            <input class="showselect" name="serverip" id="jsSMTPIP" type="text" maxlength="31" />
       </div>
       <div class="content">
            <label class="setExplain">端口 :&nbsp;</label>
            <input class="showselect" name="serverport" id="jsSMTPPort" type="text" maxlength="5" />
       </div>
       <div class="content">
            <input type="hidden" id="SMTPsslCheck" value='<%SMTPparaGet("usessl", "net");%>' />
            <label class="setExplain">SSL:&nbsp;</label>
            <div class="radioSelect">
                <input type="radio" name="sslAuth" id="jsSMTPsslCheck1" value="1" onclick="SMTPsslChecked(1)" />
                <label for="jsSMTPsslCheck1">开启</label>
            </div>
            <div class="radioSelect">
                <input type="radio" name="sslAuth" id="jsSMTPsslCheck0" value="0" onclick="SMTPsslChecked(0)" />
                <label for="jsSMTPsslCheck0">关闭</label>
            </div>
        </div>
        <div class="content">
            <label class="setExplain" id="jsSslPortLab">SSL端口:&nbsp;</label>
            <input class="showselect" name="sslport" id="jsSslPort" type="text" maxlength="5" />
        </div>
        <div class="content">
            <label class="setExplain">发件人:&nbsp;</label>
            <input class="showselect" name="frommail" id="jsAddresser" type="text" maxlength="127" />
        </div>
       <div class="content">
            <label class="setExplain">收件人:&nbsp;</label>
            <input class="showselect" name="tomail" id="jsAddressee" type="text" maxlength="127" />
       </div>
       <div class="content">
            <label class="setExplain">抄送:&nbsp;</label>
            <input class="showselect" name="ccmail" id="jsCopyFor" type="text" maxlength="127" />
       </div>
        <div class="content">
        	<input type="hidden" id="SMTPidCheck" value='<%SMTPparaGet("Auth", "net");%>' />
        	<label class="setExplain">用户认证:&nbsp;</label>
            <div class="radioSelect">
            	<input type="radio" name="Auth" id="jsSMTPidCheck1" value="1" onclick="SMTPidChecked(1)" />
                <label for="jsSMTPidCheck1">开启</label>
            </div>
            <div class="radioSelect">
            	<input type="radio" name="Auth" id="jsSMTPidCheck0" value="0" onclick="SMTPidChecked(0)" />
                <label for="jsSMTPidCheck0">关闭</label>
            </div>
        </div>
		<div class="content">
            <label class="setExplain" id="jsSMTPuserLab">用户名:&nbsp;</label>
            <input class="showselect" name="username" id="jsSMTPuserID" type="text" maxlength="63" />
       </div>
       <div class="content">
            <label class="setExplain" id="jsSMTPpassLab">密码:&nbsp;</label>
            <input class="showselect" name="password" id="jsSMTPuserPass" type="password" maxlength="63" />
       </div>
       <div class="content">
            <label class="setExplain">发送图片:&nbsp;</label>
            <input name="snapshot_check" id="SnapShot" type="checkbox" value="1" checked="checked" />
            <input class="showselect" name="snapshot" id="jsSMTPSnapshot" style="display:none" type="text" maxlength="5" />
       </div>
       <div class="content contButton contBot">
              <input class="ButtonLeft" type="button" value="保存" onclick="SMTPsubmit('SMTPform')" /> 
     	   	 <input class="ButtonRight" type="button" value="取消" onclick="SMTPreset()"  />   
        </div>  
    </form>
</div>

<div class="hankClass">
    <div class="hankName"><label>CA 证书导入</label></div>
    <br />
    <form class="clearSpace" id="SSLCAform" method="post" enctype="multipart/form-data" action="/form/uploadSSL" target="hideFrame">
    	<input type="hidden" name="type" value="pem" />
        <input type="hidden" name="language" value="cn" />
    	<div class="content">
    		<label class="fileUpLab">CA 证书:&nbsp;</label>
            <input class="fileUpCon" type="file" name="fileName" id="jsSSLCAfile" />
            <input class="uploadFile" type="button" id="jsSSLCAfileBot" value="导入" onclick="PEMupload('jsSSLCAfile','SSLCAform')" />
        </div> 
    </form>
</div>

<div class="hankClass">
    <div class="hankName"><label>HTTP摘要认证</label></div>
    <br />
    <br />
    <form class="clearSpace" id="DigestAuthForm" method="post" action="/form/DigestAuthCfg" target="hideFrame">
        <input type="hidden" name="language" value="cn" />
        <div class="content contTop">
        	<label class="setExplain">功能开关:&nbsp;</label>
            <input type="hidden" id="DigestAuthEnable_" value='<%DigestAuthGet("DigestAuthEnable","net");%>' />
            <div class="radioSelect">
            	<input type="radio" name="DigestAuthEnable" id="DigestAuthon" value="1" onclick="DigestAuthsubmit()" />
                <label>开启</label>
            </div>
            <div class="radioSelect">
            	<input type="radio" name="DigestAuthEnable" id="DigestAuthoff" value="0" onclick="DigestAuthsubmit()" />
                <label>关闭</label>
            </div>
        </div>
    </form>
</div>

<div class="hankClass">
<div class="hankName"><label>IP地址过滤</label></div>
    <br />
    <form class="clearSpace" id="FilterForm" method="post" action="/form/FilterSet" target="hideFrame">
		<div class="content">
			<input type="hidden" name="FilterEnable_1" id="FilterEnable_1" value='<%FilterGet("FilterEnable1", "net");%>' />
			<input type="hidden" id="FilterMethod_1" value='<%FilterGet("FilterMethod1", "net");%>' />
        	<input type="checkbox" value="1" id="FilterEnable1" checked="checked" onclick="FilterStateChange(1)" style="float:left;" />
        	<label>&nbsp;&nbsp;&nbsp;&nbsp;禁止IP:&nbsp;</label>
            <input name="FilterIPStart1" id="FilterIPStart1" type="text" maxlength="15" style="width:110px;float:left;" value='<%FilterGet("FilterIPStart1", "net");%>'/>
         	<label>&nbsp;&nbsp;-&nbsp;&nbsp;</label>
            <input name="FilterIPEnd1" id="FilterIPEnd1" type="text" maxlength="15" style="width:110px;float:left;" value='<%FilterGet("FilterIPEnd1", "net");%>'/>
         	<label>&nbsp;&nbsp;&nbsp;&nbsp;禁止方式:&nbsp;</label>
            <select class="selectLab" name="FilterMethod1" id="FilterMethod1" style="width:130px;">
				<option value="1">禁止搜索</option>
				<option value="2">禁止访问</option>
				<option value="3">禁止搜索和访问</option>
			</select>
		</div>
		<div class="content">
			<input type="hidden" name="FilterEnable_2" id="FilterEnable_2" value='<%FilterGet("FilterEnable2", "net");%>' />
			<input type="hidden" id="FilterMethod_2" value='<%FilterGet("FilterMethod2", "net");%>' />
        	<input type="checkbox" value="1" id="FilterEnable2" checked="checked" onclick="FilterStateChange(2)" style="float:left;" />
        	<label>&nbsp;&nbsp;&nbsp;&nbsp;禁止IP:&nbsp;</label>
            <input name="FilterIPStart2" id="FilterIPStart2" type="text" maxlength="15" style="width:110px;float:left;" value='<%FilterGet("FilterIPStart2", "net");%>'/>
         	<label>&nbsp;&nbsp;-&nbsp;&nbsp;</label>
            <input name="FilterIPEnd2" id="FilterIPEnd2" type="text" maxlength="15" style="width:110px;float:left;" value='<%FilterGet("FilterIPEnd2", "net");%>'/>
         	<label>&nbsp;&nbsp;&nbsp;&nbsp;禁止方式:&nbsp;</label>
            <select class="selectLab" name="FilterMethod2" id="FilterMethod2" style="width:130px;">
				<option value="1">禁止搜索</option>
				<option value="2">禁止访问</option>
				<option value="3">禁止搜索和访问</option>
			</select>
		</div>
		<div class="content">
			<input type="hidden" name="FilterEnable_3" id="FilterEnable_3" value='<%FilterGet("FilterEnable3", "net");%>' />
			<input type="hidden" id="FilterMethod_3" value='<%FilterGet("FilterMethod3", "net");%>' />
        	<input type="checkbox" value="1" checked="checked" id="FilterEnable3" onclick="FilterStateChange(3)" style="float:left;" />
        	<label>&nbsp;&nbsp;&nbsp;&nbsp;禁止IP:&nbsp;</label>
            <input name="FilterIPStart3" id="FilterIPStart3" type="text" maxlength="15" style="width:110px;float:left;" value='<%FilterGet("FilterIPStart3", "net");%>'/>
         	<label>&nbsp;&nbsp;-&nbsp;&nbsp;</label>
            <input name="FilterIPEnd3" id="FilterIPEnd3" type="text" maxlength="15" style="width:110px;float:left;" value='<%FilterGet("FilterIPEnd3", "net");%>'/>
         	<label>&nbsp;&nbsp;&nbsp;&nbsp;禁止方式:&nbsp;</label>
            <select class="selectLab" name="FilterMethod3" id="FilterMethod3" style="width:130px;">
				<option value="1">禁止搜索</option>
				<option value="2">禁止访问</option>
				<option value="3">禁止搜索和访问</option>
			</select>
		</div>
		<div class="content">
			<input type="hidden" name="FilterEnable_4" id="FilterEnable_4" value='<%FilterGet("FilterEnable4", "net");%>' />
			<input type="hidden" id="FilterMethod_4" value='<%FilterGet("FilterMethod4", "net");%>' />
        	<input type="checkbox" value="1" id="FilterEnable4" checked="checked" onclick="FilterStateChange(4)" style="float:left;" />
        	<label>&nbsp;&nbsp;&nbsp;&nbsp;禁止IP:&nbsp;</label>
            <input name="FilterIPStart4" id="FilterIPStart4" type="text" maxlength="15" style="width:110px;float:left;" value='<%FilterGet("FilterIPStart4", "net");%>'/>
         	<label>&nbsp;&nbsp;-&nbsp;&nbsp;</label>
            <input name="FilterIPEnd4" id="FilterIPEnd4" type="text" maxlength="15" style="width:110px;float:left;" value='<%FilterGet("FilterIPEnd4", "net");%>'/>
         	<label>&nbsp;&nbsp;&nbsp;&nbsp;禁止方式:&nbsp;</label>
            <select class="selectLab" name="FilterMethod4" id="FilterMethod4" style="width:130px;">
				<option value="1">禁止搜索</option>
				<option value="2">禁止访问</option>
				<option value="3">禁止搜索和访问</option>
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
            <label class="setExplain">认证:&nbsp;</label>
            <div class="radioSelect">
            	<input type="radio" name="X8021Auth" id="js8021used1" value="1" onclick="State8021Changed(1)" />
                <label for="js8021used1">开启</label>
            </div>
            <div class="radioSelect">
            	<input type="radio" name="X8021Auth" id="js8021used0" value="0" onclick="State8021Changed(0)" />
                <label for="js8021used0">关闭</label>
            </div>
        </div>
        <div class="content" id="js8021EAPhank">
        	<input type="hidden" id="EAPformat" value='<%Para8021XGet("methods", "net");%>' />
            <label class="setExplain" id="js8021ModeLab">EAP方式:&nbsp;</label>
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
        		<label class="setExplain">用户名:&nbsp;</label>
            	<input class="showselect" name="username" id="js8021user" type="text" maxlength="63" />
        	</div>
        	<div class="content" id="js8021passHank">
        		<label class="setExplain">密码:&nbsp;</label>
            	<input class="showselect" name="password" type="password" id="js8021pass" maxlength="63" />
        	</div>
            <div class="content" id="js8021priPassHank">
            	<label class="setExplain">私钥密码:&nbsp;</label>
                <input class="showselect" name="privatepassword" type="password" id="js8021pripass" maxlength="63" />
            </div>
            <div class="content" id="js8021CAuse" style="height:25px">
            	<label class="setExplain">&nbsp;</label>
                <input type="hidden" id="js8021peapcaGet" value='<%Para8021XGet("peapcaenable", "net");%>' />
                <input type="checkbox" name="peapcaenable" id="js8021PEAPbox" value="1" style="float:left; vertical-align:middle; margin-top:1px" />
                <label id="PEAPCAlabel" style="font-size:13px; line-height: 20px; font-family:Tahoma, Geneva, sans-serif;vertical-align:middle; margin-top:1px" for="js8021PEAPbox">启用CA证书</label>
            </div>
        </div>
        <div class="content contBot contButton">
        	<input class="ButtonLeft" type="button" value="保存" onclick="f8021sumbit()" />
            <input class="ButtonRight" type="button" value="取消" onclick="f8021reset()" />
        </div>
    </form>
    <div class="hankName" id="js8021fileForm"><label>文件导入</label></div>
    <br />
    <div id="js8021TLSfile">
	    <form class="clearSpace" id="FormTLSCA" method="post" action="/form/Para8021XSet" enctype="multipart/form-data" target="hideFrame">
        	<input type="hidden" name="flag" value="1" />
            <input type="hidden" name="format" />
        	<input type="hidden" name="language" value="cn" />
    		<div class="content contTop">
        		<label class="fileUpLab">CA 证书:&nbsp;</label>
            	<input class="fileUpCon" type="file" id="jsTLSCAfile" name="fileName" />
            	<input class="uploadFile" type="button" id="jsTLSCAfileBto" value="导入" onclick="PEMupload('jsTLSCAfile','FormTLSCA')" />
        	</div>
    	</form>
        <form class="clearSpace" id="FormTLSuser" method="post" action="/form/Para8021XSet" enctype="multipart/form-data" target="hideFrame">
        	<input type="hidden" name="flag" value="2" />
            <input type="hidden" name="format" />
        	<input type="hidden" name="language" value="cn" />
        	<div class="content contTop">
            	<label class="fileUpLab">用户证书:&nbsp;</label>
                <input class="fileUpCon" type="file" id="jsTLSUserFile" name="fileName" />
                <input class="uploadFile" type="button" id="jsTLSUserFileBto" value="导入" onclick="PEMupload('jsTLSUserFile','FormTLSuser')"  />
            </div>
        </form>
        <form class="clearSpace" id="FormTLSpass" method="post" action="/form/Para8021XSet" enctype="multipart/form-data" target="hideFrame">
        	<input type="hidden" name="flag" value="3" />
            <input type="hidden" name="format" />
        	<input type="hidden" name="language" value="cn" />
        	<div class="content contTop">
            	<label class="fileUpLab">私钥密匙:&nbsp;</label>
                <input class="fileUpCon" type="file" id="jsTLSPassFile" name="fileName" />
                <input class="uploadFile" type="button" id="jsTLSPassFileBto" value="导入" onclick="PEMupload('jsTLSPassFile','FormTLSpass')" />
            </div>
        </form>
    </div>
    <div id="js8021PEAPfile">
    	<form class="clearSpace" id="FormPEAPCA" method="post" action="/form/Para8021XSet" enctype="multipart/form-data" target="hideFrame">
        	<input type="hidden" name="flag" value="5" />
            <input type="hidden" name="format" />
        	<input type="hidden" name="language" value="cn" />
        	<div class="content contTop">
            	<label class="fileUpLab">CA 证书:&nbsp;</label>
                <input class="fileUpCon" type="file" id="jsPEAPCAfile" name="fileName" />
                <input class="uploadFile" type="button" id="jsPEAPCAfileBto" value="导入" onclick="PEMupload('jsPEAPCAfile','FormPEAPCA')" />
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
            <label class="setExplain">开启SNMP :&nbsp;</label>
            <label>v1:</label>
            <input type="checkbox" value="0" name="version1" id="version1" onclick="SnmpVersionSet(1)" style="float:left;" />
            <label>&nbsp;&nbsp;v2c:</label>
            <input type="checkbox" value="0" name="version2" id="version2" onclick="SnmpVersionSet(2)" style="float:left;" />
            <label disabled="disabled">&nbsp;&nbsp;v3:</label>
            <input disabled="disabled" type="checkbox" value="0" name="version3" id="version3" onclick="SnmpVersionSet(3)" style="float:left;" />
       </div>
       <div class="content">
            <label class="setExplain">读共同体:&nbsp;</label>
            <input class="showselect" name="read_community" id="jsread_community" type="text" maxlength="16" />
       </div>
       <div class="content">
            <label class="setExplain">写共同体:&nbsp;</label>
            <input class="showselect" name="write_community" id="jswrite_community" type="text" maxlength="16" />
       </div>
       <div class="content contButton contBot">
              <input class="ButtonLeft" type="button" value="保存" onclick="submit()" /> 
     	   	 <input class="ButtonRight" type="button" value="取消" onclick="SnmpReset()"  />   
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
        	<label class="setExplain">QoS 选择:&nbsp;</label><select class="selectLab" name="QOS" id="jsQOSmode">
            																	<option value="0">标准服务</option>
                                                                                <option value="1">高可靠性</option>
                                                                                <option value="2">高吞吐量</option>
                                                                                <option value="3">低延时</option>
                                                                              </select>
       </div>
       <div class="content contButton contBot">
             <input class="ButtonLeft" style="margin-left: 220px" type="button" value="保存"  onclick="QOSsubmit()"/> 
      	   	 <input class="ButtonRight" type="button" value="取消" onclick="QOSreset()"  />   
        </div>  
   </form>
</div>

<div class="hankClass">
	<div class="hankName"><label>IGMP</label></div>
    <br />
    <form class="clearSpace" name="network" id="IGMPform" method="post" action="/form/IGMPparaSet" target="hideFrame">
    	<div class="content">
        	<label class="setExplain">码流类型:&nbsp;</label>
            <select class="selectLab" name="IGMPTYPE" id="IGMPstream" onchange="IGMPstreamChanged()" >
            	<option value="0">主码流</option>
                <option value="1">副码流</option>
                <option value="2">MJPEG</option>
           </select>
       </div>
       <div id="IGMP0">
            <input id="IGMP0State" type="hidden" value='<%IGMPparaGet("IGMPMajorEnable","net");%>' />
            <input id="IGMP0IP" type="hidden" value='<%IGMPparaGet("IGMPMajorIP","net");%>' />
            <input id="IGMP0Port" type="hidden" value='<%IGMPparaGet("IGMPMajorPort","net");%>' />
            <div class="content contTop">	
        	    <label class="setExplain">状态:&nbsp;</label>
            	<div class="radioSelect">
            		<input type="radio" name="IGMPMajorEnable" id="jsIGMP0ON1" value="1" onclick="IGMPchanged(0,1)" />
                    <label for="jsIGMP0ON1">开启</label>
          		</div>
    	        <div class="radioSelect">
        	    	<input type="radio" name="IGMPMajorEnable" id="jsIGMP0ON0" value="0" onclick="IGMPchanged(0,0)" />
                    <label for="jsIGMP0ON0">关闭</label>
        	    </div>
      	 </div>
     	  <div class="content" id="jsIGMP0IPhank">
        	    <label class="setExplain">组播 IP:&nbsp;</label>
            	<input class="showselect" name="IGMPMajorIP" id="jsIGMP0IP" type="text" maxlength="15" value="" />
    	   </div> 		
           <div class="content" id="jsIGMP0Porthank">
           		<label class="setExplain">RTP 端口:&nbsp;</label>
            	<input class="showselect" name="IGMPMajorPort" id="jsIGMP0Port" maxlength="5" type="text" value="" />
       		</div>
       </div>
       <div id="IGMP1" style="display:none">
            <input id="IGMP1State" type="hidden" value='<%IGMPparaGet("IGMPMinorEnable","net");%>' />
            <input id="IGMP1IP" type="hidden" value='<%IGMPparaGet("IGMPMinorIP","net");%>' />
            <input id="IGMP1Port" type="hidden" value='<%IGMPparaGet("IGMPMinorPort","net");%>' />
            <div class="content contTop">
        	    <label class="setExplain">状态:&nbsp;</label>
            	<div class="radioSelect">
            		<input type="radio" name="IGMPMinorEnable" id="jsIGMP1ON1" value="1" onclick="IGMPchanged(1,1)" />
                    <label for="jsIGMP1ON1">开启</label>
          		</div>
    	        <div class="radioSelect">
        	    	<input type="radio" name="IGMPMinorEnable" id="jsIGMP1ON0" value="0" onclick="IGMPchanged(1,0)" />
                    <label for="jsIGMP1ON0">关闭</label>
        	    </div>
      	 </div>
     	  <div class="content" id="jsIGMP1IPhank">
        	    <label class="setExplain">组播 IP:&nbsp;</label>
            	<input class="showselect" name="IGMPMinorIP" id="jsIGMP1IP" type="text" maxlength="15" value="" />
    	   </div> 		
           <div class="content" id="jsIGMP1Porthank">
           		<label class="setExplain">RTP 端口:&nbsp;</label>
            	<input class="showselect" name="IGMPMinorPort" id="jsIGMP1Port" maxlength="5" type="text" value="" />
       		</div>
       </div>
      <div id="IGMP2" style="display:none">
      		<input id="IGMP2State" type="hidden" value='<%IGMPparaGet("IGMPMjpegEnable","net");%>' />
            <input id="IGMP2IP" type="hidden" value='<%IGMPparaGet("IGMPMjpegIP","net");%>' />
            <input id="IGMP2Port" type="hidden" value='<%IGMPparaGet("IGMPMjpegPort","net");%>' />
            <div class="content contTop">
        	    <label class="setExplain">状态:&nbsp;</label>
            	<div class="radioSelect">
            		<input type="radio" name="IGMPMjpegEnable" id="jsIGMP2ON1" value="1" onclick="IGMPchanged(2,1)" />
                    <label for="jsIGMP2ON1">开启</label>
          		</div>
    	        <div class="radioSelect">
        	    	<input type="radio" name="IGMPMjpegEnable" id="jsIGMP2ON0" value="0" onclick="IGMPchanged(2,0)" />
                    <label for="jsIGMP2ON0">关闭</label>
        	    </div>
      	 </div>
     	  <div class="content" id="jsIGMP2IPhank">
        	    <label class="setExplain">组播 IP:&nbsp;</label>
            	<input class="showselect" name="IGMPMjpegIP" id="jsIGMP2IP" type="text" maxlength="15" />
    	   </div> 		
           <div class="content" id="jsIGMP2Porthank">
           		<label class="setExplain">RTP 端口:&nbsp;</label>
            	<input class="showselect" name="IGMPMjpegPort" id="jsIGMP2Port" maxlength="5" type="text" />
       		</div>
       </div>
       <div class="content contButton contBot">
             <input class="ButtonLeft" style="margin-left:220px" type="button" value="保存" onclick="IGMPsubmit('IGMPform')" /> 
      	   	 <input class="ButtonRight" type="button" value="取消" onclick="IGMPreset()"  />   
        </div>  
   </form>
</div>

<div class="hankClass">
	<div class="hankName"><label>SIP服务器</label></div>
    <br />
    <input type="hidden" id="SIP_Function_Usable" value='<%SIPServerGet("SIP_Function_Usable","net");%>'  />
	<form name="SIPForm" id="SIPForm" method="post" target="hideFrame" action="/form/SIPServerCfg">
    	<div class="content">
        	<label class="setExplain">SIP服务器IP:</label>
            <input class="sipInput" name="ServerIPAddress" type="text" id="jsSIPServerIPAddress" maxlength="15"  value='<%SIPServerGet("ServerIPAddress","net");%>'  />
        </div>
        <div class="content">
        	<label class="setExplain">端口号:</label>
            <input class="sipInput" name="ServerPort" type="text" id="jsSIPServerPort" maxlength="10"  value='<%SIPServerGet("ServerPort","net");%>'  />
        </div>
        <div class="content">
        	<label class="setExplain">服务器ID:</label>
            <input class="sipInput" name="ServerID" type="text" id="jsSIPServerID" maxlength="63" value='<%SIPServerGet("ServerID","net");%>'  />
        </div>
        <div class="content">
        	<label class="setExplain">设备ID:</label>
            <input class="sipInput" name="DevID" type="text" id="jsSIPDevID" maxlength="63" value='<%SIPServerGet("DevID","net");%>'  />
        </div>
        <div class="content">
        	<label class="setExplain">报警ID:</label>
            <input class="sipInput" name="AlmID" type="text" id="jsSIPAlmID" maxlength="63" value='<%SIPServerGet("AlmID","net");%>'  />
        </div>
        <div class="content">
        	<label class="setExplain">注册时间间隔:</label>
            <input class="sipInput" name="RegInterval" type="text" id="jsSIPRegInterval" maxlength="63" value='<%SIPServerGet("RegInterval","net");%>'  />
        </div>
        <div class="content">
        	<label class="setExplain">心跳时间间隔:</label>
            <input class="sipInput" name="HeartInterval" type="text" id="jsSIPHeartInterval" maxlength="63" value='<%SIPServerGet("HeartInterval","net");%>'  />
        </div>
        <div class="content">
        	<label class="setExplain">认证用户名:</label>
            <input class="sipInput" name="AuthUserName" type="text" id="jsSIPAuthUserName" maxlength="63" value='<%SIPServerGet("AuthUserName","net");%>'  />
        </div>
        <div class="content">
        	<label class="setExplain">用户名:</label>
            <input class="sipInput" name="UserName" type="text" id="jsSIPUserName" maxlength="63" value='<%SIPServerGet("UserName","net");%>'  />
        </div>
        <div class="content">
        	<label class="setExplain">密码:</label>
            <input class="sipInput" name="Password" type="password" id="jsSIPPassword" maxlength="63" value='<%SIPServerGet("Password","net");%>'  />
        </div>
        <div class="content contButton contBot">
             <input class="ButtonLeft" style="margin-left:220px" type="button" value="保存" onclick="SIPsubmit()" /> 
      	   	 <input class="ButtonRight" type="button" value="取消" onclick="formSet('SIPForm',0)"  />   
        </div>  
    </form>
    <div class="hankName"><label>位置信息</label></div>
    <br />
    <form name="SIPPosForm" id="SIPPosForm" method="post" target="hideFrame" action="/form/SIPPosCfg">
    	<div class="content">
        	<label class="setExplain">安装位置:</label>
            <input class="sipInput" name="Position" type="text" id="jsSIPPosition" maxlength="63"  value='<%SIPPosGet("Position","net");%>'  />
        </div>
        <div class="content">
        	<label class="setExplain">经度:</label>
            <input class="sipInput" name="Longitude" type="text" id="jsSIPLongitude" maxlength="20"  value='<%SIPPosGet("Longitude","net");%>'  />
        </div>
        <div class="content">
        	<label class="setExplain">纬度:</label>
            <input class="sipInput" name="Latitude" type="text" id="jsSIPLatitude" maxlength="20" value='<%SIPPosGet("Latitude","net");%>'  />
        </div>
        <div class="content contButton contBot">
             <input class="ButtonLeft" style="margin-left:220px" type="button" value="保存" onclick="SIPPosSubmit()" /> 
      	   	 <input class="ButtonRight" type="button" value="取消" onclick="formSet('SIPPosForm',0)"  />   
        </div>  
    </form>
</div>

<div class="hankClass">
	<div class="hankName"><label>互信互通</label></div>
    <br />
    <form name="hxhtForm" id="hxhtForm" method="post" target="hideFrame" action="/form/hxhtSet">
    	<div class="content">
        	<label class="setExplain">服务器 IP:</label>
            <input class="sipInput" name="hxhtServerIP" type="text" id="jsHxhtIP" maxlength="15" value='<%hxhtGet("hxhtServerIP","net");%>' />
        </div>
        <div class="content">
        	<label class="setExplain">设备 ID:</label>
            <input class="sipInput" name="hxhtDeviceID" type="text" id="jsHxhtDeviceID" maxlength="63" value='<%hxhtGet("hxhtDeviceID","net");%>' />
        </div>
        <div class="content contButton contBot">
             <input class="ButtonLeft" style="margin-left:220px" type="button" value="保存" onclick="hxhtSubmit()" /> 
      	   	 <input class="ButtonRight" type="button" value="取消" onclick="formSet('hxhtForm',0)"  />   
        </div>  
    </form>
</div>

<div class="hankClass">
<div class="hankName"><label>PORT</label></div>
		<br />
        <form  id="portForm" method="post" action="/form/NetPortSet" target="hideFrame">
	    <div class="content">
        	<label class="setExplain" >RTSP 端口:</label>
            <input name="RtspPort" id="rtspPort" type="text" maxlength="6" value="<%NetPortGet("RtspPort","net");%>"/>
        </div>
        <div class="content">
            <label class="setExplain">Onvif 端口:</label>
            <input name="OnvifPort" id="onvifPort" type="text" maxlength="6" value="<%NetPortGet("OnvifPort","net");%>"/>
			<!--<label class="setExplain">Onvif 端口:</label><label>%NetPortGet("OnvifPort","net");%></label>-->
        </div>
        <div class="content">
            <label class="setExplain">Http 端口:</label>
            <input name="HttpPort" id="httpPort" type="text" maxlength="6" value="<%NetPortGet("HttpPort","net");%>"/>
        </div>
        <div class="content">
            <label class="setExplain">视频 端口:</label>
            <input name="VideoPort" id="videoPort" type="text" maxlength="6" value="<%NetPortGet("VideoPort","net");%>"/>
        </div>
        <div class="content">
            <label class="setExplain">录像 端口:</label>
            <input name="RecordPort" id="recordPort" type="text" maxlength="6" value="<%NetPortGet("RecordPort","net");%>"/>
        </div>
        
        <div class="content contButton contBot">
             <input class="ButtonLeft" style="margin-left:220px" type="button" value="保存" onclick="PORTsubmit()" /> 
       </div>
		<div class="content">
		   <label style="margin-left:40px">请注意:各端口号有相同的情况时会设置不成功!</label>
           <br />
		   <label style="margin-left:40px">改变端口后，请重启设备，重启完成后，请刷新网页以生效!</label>
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
        	<label class="setExplain">DDNS状态:</label>
            <div class="radioSelect">
            	<input type="radio" name="DDNSEEnable" id="DDNSOn" value="1" onclick="DDNSStateChange()" />
                <label>开启</label>
            </div>
            <div class="radioSelect">
            	<input type="radio" name="DDNSEEnable" id="DDNSOff" value="0" onclick="DDNSStateChange()" />
                <label>关闭</label>
            </div>
        </div>
		<div class="content">
        	<label class="setExplain">方式:</label>
            <select class="selectLab" name="DDNSMethod" id="DDNSMethod">
          		<!--<option value="0">花生壳</option>
                <option value="1">希网</option>-->
 				<option value="0">CamAnyWhere</option>
                <option value="1">QDNS</option>
                <option value="2">DYNDNS</option>
                <option value="3">NO-IP</option>
           </select>
       </div>
       <div class="content">
            <label class="setExplain">服务器地址:</label>
            <input class="showselect" name="HobcmsDomain" id="HobcmsDomain" type="text" maxlength="60" value="<%DDNSGet("HobcmsDomain", "net");%>" />
       </div>
       <div class="content">
            <label class="setExplain">服务器端口:</label>
            <input name="HobcmsPort" id="HobcmsPort" type="text" maxlength="6" value="<%DDNSGet("HobcmsPort","net");%>"/>
        </div>
		<div class="content">
            <label class="setExplain" id="">用户名:</label>
            <input class="showselect" name="DDNSUserName" id="DDNSUserName" type="text" maxlength="20"
			value="<%DDNSGet("DDNSUserName", "net");%>"/>
       </div>
       <div class="content">
            <label class="setExplain" id="">密码:</label>
            <input class="showselect" name="DDNSPassword" id="DDNSPassword" type="password" maxlength="20"value="<%DDNSGet("DDNSPassword", "net");%>" />
       </div>
	   <div class="content">
            <label class="setExplain" id="">域名:</label>
            <input class="showselect" name="DDNSDomain" id="DDNSDomain" type="text" maxlength="60" value="<%DDNSGet("DDNSDomain", "net");%>" />
       </div>
       <div class="content contButton contBot">
              <input class="ButtonLeft" type="button" value="保存" onclick="DDNSSet()" /> 
     	   	 <!--<input class="ButtonRight" type="button" value="取消" onclick=""  />   -->
        </div>  
    </form>
 <!--
	<div class="hankName"><label>凯聪客户端</label></div>
    <br />
    <form class="clearSpace" id="kcDdnsForm" method="post" action="/form/kcDdnsSet" target="hideFrame">
        <div class="content">
        	<input type="hidden" id="kcDdnsEnable" value='<%kcDdnsGet("kcDdnsEnable", "net");%>' />
        	<label class="setExplain">状态:</label>
            <div class="radioSelect">
            	<input type="radio" name="kcDdnsEnable" id="kcDdnsOn" value="1" onclick="kcDdnsStateChange()" />
                <label>开启</label>
            </div>
            <div class="radioSelect">
            	<input type="radio" name="kcDdnsEnable" id="kcDdnsOff" value="0" onclick="kcDdnsStateChange()" />
                <label>关闭</label>
            </div>
        </div>
        <div class="content">
            <label class="setExplain">用户名:</label>
            <input class="showselect" name="kcDdnsName" id="kcDdnsName" type="text" maxlength="32" value="<%kcDdnsGet("kcDdnsName", "net");%>" />
        </div>
       <div class="content">
            <label class="setExplain" id="">密码:</label>
            <input class="showselect" name="kcDdnsPassword" id="kcDdnsPassword" type="text" maxlength="32"value="<%kcDdnsGet("kcDdnsPassword", "net");%>" />
       </div>
       <div class="content contButton contBot">
              <input class="ButtonLeft" type="button" value="保存" onclick="kcDdnsSet()" /> 
        </div>  
    </form>
-->
</div>

<div class="hankClass">
	<div class="hankName"><label>手机看店</label></div>
    <br />
    <form name="sjkdForm" id="sjkdForm" method="post" target="hideFrame" action="/form/sjkdSet">
        <input type="hidden" name="sjkdEnable" id="jsSjkdEnable" value='<%sjkdGet("sjkdEnable","net");%>' />
    	<div class="content">
        	<label class="setExplain">集团平台 IP:</label>
            <input class="sipInput" name="sjkdGroupIP" type="text" id="jsSjkdGroupIP" maxlength="15" value='<%sjkdGet("sjkdServerGroupIP","net");%>' />
        </div>
        <div class="content">
        	<label class="setExplain">省平台 IP:</label>
            <input class="sipInput" name="sjkdProcIP" type="text" id="jsSjkdProcIP" maxlength="15" value='<%sjkdGet("sjkdServerProcIP","net");%>' />
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
             <input class="ButtonLeft" style="margin-left:220px" type="button" value="保存" onclick="sjkdSubmit()" /> 
      	   	 <!--<input class="ButtonRight" type="button" value="取消" onclick="formSet('hxhtForm',0)"  />   -->
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
                <label>开启</label>
            </div>
            <div class="radioSelect">
<!--            	<input type="radio" name="TUTKEnable" id="TUTKoff" value="0" onclick="TUTKStateChange()" />-->
            	<input type="radio" name="TUTKEnable" id="TUTKoff" value="0" onclick="TUTKsubmit()" />
                <label>关闭</label>
            </div>
        </div>
	    <div class="content">
        	<label class="setExplain">UID:&nbsp;</label>
<!--            <input class="showselect" name="TUTKUidInput" id="TUTKUidInput" type="text" maxlength="20" value='< %TUTKGet("TUTKUid","net");%>'/>-->
				<label class="hank"><%TUTKGet("TUTKUid","net");%></label>
        </div>
	    <div class="content">
        	<label class="setExplain">注册状态:&nbsp;</label>
            <input id="TUTKAuthorizedGet" type="hidden" value='<%TUTKGet("TUTKAuthorized","net");%>' />
				<label class="hank" id="TUTKAuthorized1" style="display:none;">已注册</label>
				<label class="hank" id="TUTKAuthorized0" style="display:none;">未注册</label>
        </div>
	    <div class="content">
        	<label class="setExplain">登录状态:&nbsp;</label>
            <input id="TUTKStatusGet" type="hidden" value='<%TUTKGet("TUTKStatus","net");%>' />
				<label class="hank" id="TUTKStatus1" style="display:none;">已登录</label>
				<label class="hank" id="TUTKStatus0" style="display:none;">未登录</label>
        </div>        
<!--        <div class="content contButton contBot">
        	<input class="ButtonLeft" type="button" value="保存" onclick="TUTKsubmit()" />
            <input class="ButtonRight" type="button" value="取消" onclick="TUTKreset()"  />
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
        	<label class="setExplain">功能开关:</label>
            <div class="radioSelect">
            	<input type="radio" name="MobileEnable" id="MobileOn" value="1" onclick="MobileStateChange()" />
                <label>开启</label>
            </div>
            <div class="radioSelect">
            	<input type="radio" name="MobileEnable" id="MobileOff" value="0" onclick="MobileStateChange()" />
                <label>关闭</label>
            </div>
        </div>
		<div class="content">
        	<label class="setExplain">网络模式:</label>
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
             <input class="ButtonLeft" type="button" value="连接" style="margin-left:148px;" onclick="MobileConnect()" /> 
     	   	 <input class="ButtonRight" type="button" value="断开" onclick="MobileDisconnect()"  />
        </div>
        <br />
        <div class="content">
        	<label class="setExplain">网络状态:</label>
			<div id="MobileStatus"></div>
		</div>
        <div class="content contButton contBot">
     	   	 <input class="ButtonLeft" type="button" value="刷新" style="margin-left:148px;" onclick="MobileRefresh()"  />
		</div>
    </form>
</div>

<div class="hankClass">
	<div class="hankName"><label>手机APP</label></div>
	<br />
	<div class="content contTop">
		<label class="setExplain">APP类型:</label>
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
            <input type="hidden" id="PPCNUsable" value='<%PPCNGet("PPCNUsable","net");%>' />
            <div class="radioSelect">
            	<input type="radio" name="PPCNEnable" id="PPCNon" value="1" onclick="PPCNsubmit()" />
                <label>开启</label>
            </div>
            <div class="radioSelect">
            	<input type="radio" name="PPCNEnable" id="PPCNoff" value="0" onclick="PPCNsubmit()" />
                <label>关闭</label>
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
            <div class="radioSelect">
            	<input type="radio" name="ULUEnable" id="ULUon" value="1" onclick="ULUsubmit()" />
                <label>开启</label>
            </div>
            <div class="radioSelect">
            	<input type="radio" name="ULUEnable" id="ULUoff" value="0" onclick="ULUsubmit()" />
                <label>关闭</label>
            </div>
        </div>
	    <div class="content" id="ULU_ID_DIV">
        	<label class="setExplain">ID:&nbsp;</label>
				<label class="hank"><%ULUGet("ULUUid","net");%></label>
        </div>
	    <div class="content" id="ULU_RESET_DIV">
        	<label class="setExplain">复位解绑:&nbsp;</label>
              <input class="ButtonLeft" style="margin-left:0px;" type="button" value="复位" onclick="$('#ULUreset').val(1);ULUsubmit();" /> 
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
                <label>开启</label>
            </div>
            <div class="radioSelect">
            	<input type="radio" name="GLINKenable" id="GLINKoff" value="0" onclick="GLINKsubmit()" />
                <label>关闭</label>
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
        <div class="hankName"><label>下载手机APP</label></div>
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
        	<label class="setExplain" id="ELlab">开关:&nbsp;</label>
            <input type="hidden" id="ELusable_" value='<%ELGet("ELusable","net");%>' />
            <input type="hidden" id="ELenable_" value='<%ELGet("ELenable","net");%>' />
            <input type="hidden" id="ELstatus_" value='<%ELGet("ELstatus","net");%>' />
            <input type="hidden" id="ELid_" value='<%ELGet("ELid","net");%>' />
            <div class="radioSelect">
            	<input type="radio" name="ELenable" id="ELon" value="1" onclick="ELsubmit()" />
                <label>开启</label>
            </div>
            <div class="radioSelect">
            	<input type="radio" name="ELenable" id="ELoff" value="0" onclick="ELsubmit()" />
                <label>关闭</label>
            </div>
        </div>
	    <div class="content">
        	<label class="setExplain">状态:&nbsp;</label>
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
             <input class="ButtonLeft" style="margin-left:220px" type="button" value="保存" onclick="PROTOsubmit()" /> 
       </div>
    </form>
</div>

</body>
</html>

// JavaScript Document
var IPerror = ["Wrong IP address format. Correct format is xxx.xxx.xxx.xxx (xxx must be within 0~255)\n",
					  "IP地址格式错误：正确格式为xxx.xxx.xxx.xxx (xxx 0~255且不能全为0)\n"];
var IPerrorEX = ["Wrong IP address format. Correct format is xxx.xxx.xxx.xxx (xxx must be within 0~255)\n",
					  "IP地址格式错误：正确格式为xxx.xxx.xxx.xxx (xxx 0~255)\n"];
var userPassError=[{userEmpty:"Username cannot be empty!\n", passEmpty:"Password cannot be empty!\n",
								   userLimit:"Username length must be between 1 to 50.\n",passLimit:"Password length must be between 1 to 50.\n",
								   userSpecial:"Username contains illegal character(s)!\n",passSpecial:"Password contains illegal character(s)!\n"},
								{userEmpty:"用户名不能为空!\n", passEmpty:"密码不能为空!\n",
								   userLimit:"用户名长度应在1~50之间!\n",passLimit:"密码长度应在1~50之间!\n",
								   userSpecial:"用户名包含非法字符!\n",passSpecial:"密码包含非法字符!\n"}];
var CAerror = [{empty:"Please select a file!\n", wrong:"Please select a file of correct type!\n", large:"The selected file is too large!\n"},
						  {empty:"请选择文件!\n", wrong:"请选择正确格式的文件!", large:"选择的文件太大!\n"}];
var setResult = [{succeed:"Setting succeeded!\n", failed:"Setting failed!\n"},
						   {succeed:"设置成功.\n", failed:"设置失败!\n"}];
var gotoArray = ["System will switch to new IP.","系统将自动跳转至新的IP."]
var TUTKUIDError = ["UID error, it cannot be longer than 20 alphanumeric characters.","UID错误，请输入长度不超过20的数字和英文字母."]
var DIALOG = null;//全屏禁用的对话框
var QRCodetext = {
        render  : "table",
        text    : "PPCN",
        width  	: 200,
        height  : 200
    };
var chipID = top.topFrame.document.getElementById('chipIDGet').value;

function IPModeChanged(num){
		num = Boolean(num);
		$("#jsIP").attr( "disabled",num);
		$("#jsMaskAddr").attr( "disabled",num);
		$("#jsGateway").attr( "disabled",num);
		$("#jsDNS0").attr( "disabled",num);
		$("#jsDNS1").attr( "disabled",num);
}

function pppoeChanged(num){
		num = !Boolean(num);
		var inputUser = $("#jsPPPOEuser");
		var inputPass = $("#jsPPPOEpass");
		inputUser.attr( "disabled",num );
		inputPass.attr( "disabled",num );
		$("#jsPPPOEuserLab").attr( "disabled",num );
		$("#jsPPPOEpassLab").attr( "disabled",num );
		$("#jsPPPOEipLab").attr( "disabled",num );
		$("#jsPPPOEip").attr( "disabled",num );
		inputUser.css("cursor", num? "default": "auto");
		inputPass.css("cursor", num? "default": "auto");
}


function WifiInit()
{
	/*justin add for wifi test 2015.6.23*/
	$($("#WIFIBitrateControl_Get").val()=='1'?"#jsWIFIBitrateControlAuto":"#jsWIFIBitrateControlManual").attr("checked",true);


	if($("#WifiResource_Get").val()!='1')
	{
		$("#WifiLabel").hide();
		$("#WifiForm").hide();
		$("#WifiHotspotForm").hide();
		$("#PacketForm").hide();
		return;
	}
	$($("#WifiEnable_Get").val()=='1'?"#jsWifiOn":"#jsWifiOff").attr("checked",true);
	$($("#WifiMode_Get").val()=='1'?"#jsWifiModeSTA":"#jsWifiModeAP").attr("checked",true);
	$("#jsWifiSSID").val($("#WifiSSID_Get").val());
	$("#jsWifiKey").val($("#WifiKey_Get").val());

	$("#jsWifiAPSSID").val($("#WifiAPSSID_Get").val());
	$("#jsWifiChannel").val($("#WifiChannel_Get").val());

	$("#divAP,#divSTA").attr("disabled",$("#jsWifiOff").attr("checked")=="checked"?true:false);
	$("#jsWifiModeSTA,#jsWifiModeAP").attr("disabled",($("#WifiAPSupport_Get").val()=='1')&&($("#jsWifiOff").attr("checked")!="checked")?false:true);
	$("#WifiHotspotForm").attr("disabled",$("#jsWifiOff").attr("checked")=="checked"?true:false);

	if($("#jsWifiModeAP").attr("checked")=="checked")
	{
		document.getElementById("divAP").style.display = "block";
		document.getElementById("divSTA").style.display = "none";
		document.getElementById("WifiHotspotForm").style.display = "none";
		$("#jsWifiChannel,#jsWifiAPSet").attr("disabled",$("#jsWifiOff").attr("checked")=="checked"?true:false);
		$("#jsWifiAPSSID").attr("disabled",true);
		$("#jsWifiStatus0,#jsWifiStatus1,#jsWifiIP").hide();
	}
	else
	{
		document.getElementById("divAP").style.display = "none";
		document.getElementById("divSTA").style.display = "block";
		document.getElementById("WifiHotspotForm").style.display = "block";
		if($('#WifiStatus_Get').val()=='1')
		{
			$("#jsWifiStatus1").show();
			$("#jsWifiStatus0").hide();
		}
		else
		{
			$("#jsWifiStatus1").hide();
			$("#jsWifiStatus0").show();
		}
	}
	WifiStatus_ForInit();

	//setInterval("WifiStatus();",5000);
}
function WifiEnableChanged()
{
	$("#jsWifiModeSTA,#jsWifiModeAP").attr("disabled",($("#WifiAPSupport_Get").val()=='1')&&($("#jsWifiOff").attr("checked")!="checked")?false:true);
	$("#divAP,#divSTA").attr("disabled",$("#jsWifiOff").attr("checked")=="checked"?true:false);
	$("#WifiHotspotForm").attr("disabled",$("#jsWifiOff").attr("checked")=="checked"?true:false);
	$("#jsWifiChannel,#jsWifiAPSet").attr("disabled",($("#WifiAPSupport_Get").val()=='1')&&($("#jsWifiOff").attr("checked")!="checked")?false:true);
	$("#jsWifiAPSSID").attr("disabled",true);
	$("#flag").val(0);
	$('#WifiForm').submit();
	WifiStatus_ForInit();
}

function WifiModeChanged()
{
	if($("#jsWifiModeAP").attr("checked")=="checked")
	{
		document.getElementById("divAP").style.display = "block";
		document.getElementById("divSTA").style.display = "none";
		document.getElementById("WifiHotspotForm").style.display = "none";
		$("#jsWifiAPSSID").attr("disabled",true);
	}
	else
	{
		document.getElementById("divAP").style.display = "none";
		document.getElementById("divSTA").style.display = "block";
		document.getElementById("WifiHotspotForm").style.display = "block";
		if($('#WifiStatus_Get').val()=='1')
		{
			$("#jsWifiStatus1").show();
			$("#jsWifiStatus0").hide();
		}
		else
		{
			$("#jsWifiStatus1").hide();
			$("#jsWifiStatus0").show();
		}
	}
	$("#flag").val(2);
	$('#WifiForm').submit();

	if($("#Wifi8188_Get").val() != '1' && $("#jsWifiModeAP").attr("checked")=="checked" && $("#WifiCurMode_Get").val() != 0)
	{
		var dialog = DIALOG;
		dialog.show(50,["Setting succeeded,Please wait...  ","设置成功，请稍候...  "][LANGUAGE],'', function(){parent.mainFrame.document.location = ($("#PAGE_LANGUAGE").val() ? "networkC.asp?show=1" : "network.asp?show=1");});
	}
}

function WifiAPSubmit()
{
	$("#flag").val(3);
	$('#WifiForm').submit();
}

function WifiStatus_ForInit()
{
	  if($("#jsWifiModeAP").attr("checked")=="checked")
	  	return;
	  var ip;
	  $.ajax({
			url:"/form/WifiStatus",
			dataType:"text",
			success:function(data)
			{
				ip = data.toString();
				if(ip != "0.0.0.0" && ip != "")
				{
					$("#jsWifiStatus1").show();
					$("#jsWifiStatus0").hide();
					$("#jsWifiIP").show();
					$("#jsWifiIP").html("IP: "+ip);
				}
				else
				{
					$("jsWifiStatus1").hide();
					$("jsWifiStatus0").show();
					$("jsWifiIP").hide();
				}
			}
	  });
}
function WifiStatus()
{
	  var ip;
	  $.ajax({
			url:"/form/WifiStatus",
			dataType:"text",
			success:function(data)
			{
				ip = data.toString();
				if(ip != "0.0.0.0" && ip != "")
				{
					document.getElementById("jsWifiStatus1").style.display = "block";
					document.getElementById("jsWifiStatus0").style.display = "none";
					document.getElementById("jsWifiIP").style.display = "block";
					$("#jsWifiIP").html("IP: "+ip);
				}
				else
				{
					document.getElementById("jsWifiStatus1").style.display = "none";
					document.getElementById("jsWifiStatus0").style.display = "block";
					document.getElementById("jsWifiIP").style.display = "none";
				}
			}
	  });
	  WifiDelay(500);
}
function WifiSubmit(){
	if($("#jsWifiSSID").val() == "")
	{
		alert(["SSID cannot be empty !","SSID不能为空!"][LANGUAGE]);
		return;
	}
	if($("#Wifi8188_Get").val() != '1' && $("#WifiCurMode_Get").val() == 0)
	{
		if(!window.confirm(["Prog will restart to take effect","程序将重启以使设置生效"][LANGUAGE]))
			return;
	}
	$("#flag").val(1);
	$("#WifiForm").submit();
	if($("#Wifi8188_Get").val() != '1' && $("#WifiCurMode_Get").val() == 0)
	{
		var dialog = DIALOG;
		dialog.show(50,["Setting succeeded,Please wait...  ","设置成功，请稍候...  "][LANGUAGE],'', function(){parent.mainFrame.document.location = ($("#PAGE_LANGUAGE").val() ? "networkC.asp?show=1" : "network.asp?show=1");});
	}
	else
	{
		WifiDelay(5000);
	}
		
}
function WifiDelay(delay){
		$("#jsWifiConnect,#jsWifiStatus,#jsWifiHotspotSearch").attr("disabled",true);
		setTimeout("$('#jsWifiConnect,#jsWifiStatus,#jsWifiHotspotSearch').attr('disabled',false);",delay);
}

function WifiQuerySubmit(){
	ajaxPost("WifiHotspotForm",function(text){
		$("#hotspotlist").val(text.toString());
		var list = text.toString();
		var listArray = list.split('\n');
		$("#hotspotlistSelect").find("option").remove();
		for(var i = 0; i < listArray.length - 1; i++){
			$("#hotspotlistSelect").append("<option value = '" + listArray[i] +"'>" + listArray[i] + "</option>")
		}
		$('#jsWifiSSID').val($('#hotspotlistSelect').val());
								});
	WifiDelay(2000);
}

function WifiSelect(){
	//alert($('hotspotlistSelect').val());
	$('#jsWifiSSID').val($('#hotspotlistSelect').val());
}

function SMTPidChecked(num){
		num = !Boolean(num);
		var inputUser = $("#jsSMTPuserID");
		var inputPass = $("#jsSMTPuserPass");
		inputUser.attr( "disabled", num );
		inputPass.attr( "disabled", num );
		$("#jsSMTPuserLab").attr( "disabled", num );
		$("#jsSMTPpassLab").attr( "disabled", num );
		inputUser.css("cursor", num? "default": "auto");
		inputPass.css("cursor", num? "default": "auto");
}

function SMTPsslChecked(num){
		num = !Boolean(num);
		var inputPort = $("#jsSslPort");
		inputPort.attr( "disabled", num );
		$("jsSslPortLab").attr( "disabled", num );
		inputPort.css("cursor", num? "default": "auto");
}

function IGMPchanged(num,state){
		state = !Boolean(state);
		var inputIP = $("#jsIGMP"+num+"IP");
		var inputPort = $("#jsIGMP"+num+"Port");
		inputIP.attr( "disabled", state );
		inputPort.attr( "disabled", state );
		inputIP.prev().attr( "disabled", state );
		inputPort.prev().attr( "disabled", state );
		inputIP.css("cursor", state? "default": "auto");
		inputPort.css("cursor", state? "default": "auto");
}

function State8021Changed(num){	
		var disFlag = !Boolean(num);
		var cursor = disFlag? "default": "auto";
		var DOMobj = [$("#js8021EAPmode"),$("#js8021PEAPbox"),$("#jsTLSCAfile"),$("#jsTLSUserFile"),
								$("#jsTLSPassFile"),$("#jsPEAPCAfile"),$("#jsTLSCAfileBto"),$("#jsTLSUserFileBto"),
								$("#jsTLSPassFileBto"),$("#jsPEAPCAfileBto"),$("#PEAPCAlabel"),$("div[id^='js8021'][id$='hank'] label"),
								$("#js8021fileForm label"),$("#js8021TLSfile label"),$("#js8021PEAPfile label"),$("#js8021user"),
								$("#js8021pass"),$("#js8021pripass")];
		for(var i = 0; i < DOMobj.length; i++){
			DOMobj[i].attr( "disabled", disFlag );
			DOMobj[i].css("cursor", cursor);
		}
}

function networkInit(){
	LANGUAGE = parseInt($("#PAGE_LANGUAGE").val());
	if(parseInt($("#SAMSUNG_MODULES").val()) != 0)
	{
		$("#PPPOElabel,#PPPOEform,#https_LI,#digest_LI,#filter_LI,#8021x_LI,#snmp_LI").css("display", "block");
	}
	if(parseInt($("#Auth8021xModules").val()) != 0)
	{
		$("#8021x_LI").css("display", "block");
	}
	if(parseInt($("#SnmpModules").val()) != 0)
	{
		$("#snmp_LI").css("display", "block");
	}
	if(parseInt($("#PppoeModules").val()) != 0)
	{
		$("#PPPOElabel,#PPPOEform").css("display", "block");
	}
	if(parseInt($("#SIP_Function_Usable").val()) != 0)
	{
		$("#sip_LI").css("display", "block");
	}	
	if(parseInt($("#Hi3518E").val()) != 0)
	{
		$("#DDNSMethod").find("option[value='3']").remove();
	}

	if (chipID == 3) {
		$("#ulu_LI").css("display", "none");
	}
/********初始化各个选择项*********/
	networkReset();
	PPPOEreset();
	SNMPreset();
	$("#firstPage").css("display", "block");
	
	FTPreset();
	SMTPreset();
	f8021reset();
	QOSreset();
	IGMPreset();
	TUTKStateInit();
	PPCNStateInit();
	ULUStateInit();
	GLINKStateInit();
	ELStateInit();
	PROTOreset();

	formSet('SIPForm',1);
	formSet('SIPPosForm',1);
	formSet('hxhtForm',1);
	formSet('digifortForm',1);
	var tmp = parseInt($("#digifortEnableGet").val())? 1:0;
	$("#jsDigifortOn"+tmp).click();
	
	$($('#DDNSState').val()=='1'?'#DDNSOn':'#DDNSOff').attr('checked',true);
	DDNSStateChange();
	kcClientStateInit();
	$('#DDNSMethod').val($('#DDNSM').val());

	//$('#DDNSOn').attr("disabled",true);
	//$('#DDNSOff').attr("disabled",true);
	$('#kcDdnsOn').attr("disabled",true);
	$('#kcDdnsOff').attr("disabled",true);

	WifiInit();
	
	MobileInit();
	
	SnmpReset();
	
	$("#jsSIPServerPort").blur({point:0,min:1,max:100000},valCheck);
	$("#jsSIPRegInterval").blur({point:0,min:1,max:99999999},valCheck);
	$("#jsSIPHeartInterval").blur({point:0,min:1,max:99999999},valCheck);
	$("#jsSNMPinterval").blur({point:0,min:1,max:300},valCheck);
	
//	dataGet = $("#IGMPrate").attr("value");
//	$("#jsIGMPrate").attr("value",dataGet);
/***************************/
	if(!IsSuperUser()){
		disabledAll();
		$("#js8021fileForm label").attr("disabled", false);
		$("#jsPPPOEipLab").attr("disabled",true);
		$("#jsPPPOEip").attr("disabled",true);
		$("#DHCPlab").attr("disabled",true);
		$("#jsSNMPinterval").nextAll("label").attr("disabled",true);
	}
	$(document).contextmenu(function(){return false});//屏蔽右键
	(function(){
		DIALOG = new Dialog();
		if(DIALOG.error)
			setTimeout(arguments.callee,200);
	})();
	
	if(parseInt($("#jsSjkdEnable").val()) == 1)
		document.getElementById("sjkd_LI").style.display = "block";

//摘要认证初始化
	DigestAuthInit();
	
	IPFilterInit();
	if (chipID == 3) {
		$("#IGMPstream").find("option[value='2']").remove();
	}
}

function networkSubmit(formID){
	if($("#jsDHCPenable1:checked").val()){//DHCP开启
		ajaxPost(formID, function(text){
			var state = getState(text);
			if(!state){
				alert(setResult[LANGUAGE].failed);
			}else{
				$("#DHCPenableGet").val(1);
				if(window.confirm(setResult[LANGUAGE].succeed + ["Device must reboot for settings to take effect. Webpage will close after reboot.\nReboot now?\n","若要使设置生效,设备需要重启,重启完成后,网页自动关闭.\n现在重启?\n"][LANGUAGE])){
//					DIALOG = DIALOG? DIALOG: new Dialog();
					var dialog = DIALOG;
					var time = (new Date()).getTime();
					$.get("/form/reboot?_="+time);
					var dialogStr=["Please wait...  ","请稍候...  "];
					dialog.show(60,dialogStr[LANGUAGE],"", function(){top.close()});
				}
			}
		});
		return;
	}
	
	var flag = 0;
	var networkHank = new Object();
	networkHank = {
		IPaddr: IPcheck( $("#jsIP").val() ),
		maskAddr: IPcheck( $("#jsMaskAddr").val() ),
		gateway: IPcheck( $("#jsGateway").val() ),
		DNS0: IPcheck( $("#jsDNS0").val() ),
		DNS1: IPcheck( $("#jsDNS1").val() )
	}
	var alertArray = [{IP:"IP Address",
								 mask:"Subnet Mask",
								 gateway:"Gateway",
								 DNS0:"Primary DNS",
								 DNS1:"Secondary DNS"},
								{IP:"IP地址",
								mask:"子网掩码",
								gateway:"网关地址",
								DNS0:"首选DNS地址",
								DNS1:"备用DNS地址"
									}];
	var errorArray = ["Invalid format. Correct format is xxx.xxx.xxx.xxx (xxx must be within 0~255)\n",
								"格式错误：正确格式为xxx.xxx.xxx.xxx (xxx 0~255且不能全为0)\n"];
	var errorArrayEX = ["Invalid format. Correct format is xxx.xxx.xxx.xxx (xxx must be within 0~255)\n",
								"格式错误：正确格式为xxx.xxx.xxx.xxx (xxx 0~255)\n"];
	var IPinputError = ["Invalid format. Correct format is xxx.yyy.yyy.zzz (xxx must be within 1~223 and cannot be 127, yyy must be within 0~255, zzz must be within 0~254)\n",
								"格式错误：正确格式为xxx.yyy.yyy.zzz (xxx 1~223且不能为127, yyy 0~255，zzz 0~254)\n",];
	var maskError = ["Invalid format. The subnet mask must be contiguous.\n",
								"格式错误： 子网掩码必须是相邻的.\n"];
	with(networkHank){
		var alertString = '';
		if(0===IPaddr || ''===IPaddr || 1===IPaddr){
			alertString += alertArray[LANGUAGE].IP + errorArray[LANGUAGE];
			flag = 1;
		}else{
			var firstVal = parseInt(IPaddr);
			if(parseInt(IPaddr.split('.')[3]) >= 255) {
				alertString += alertArray[LANGUAGE].IP + IPinputError[LANGUAGE];
				flag = 1;
			} else if(0===firstVal || 127===firstVal || 223<firstVal) {
				alertString += alertArray[LANGUAGE].IP + IPinputError[LANGUAGE];
				flag = 1;
			}
		}
		if(0===maskAddr || ''===maskAddr || 1===maskAddr){
			alertString += alertArray[LANGUAGE].mask + errorArray[LANGUAGE];
			flag = 1;
		}else{
			var maskArray = maskAddr.split('.');
			var maskBit = 0;
			for(var i = 0; i < maskArray.length; i++){
				maskBit += maskBit*255+parseInt(maskArray[i],10);
			}
			maskBit = maskBit.toString(2);
			if(maskBit.length != 32 || maskBit.match(/01/g)){
				alertString += alertArray[LANGUAGE].mask + maskError[LANGUAGE];
				flag = 1;
			}
		}
		if(1===gateway){
			alertString += alertArray[LANGUAGE].gateway + errorArray[LANGUAGE];
			flag = 1;
		}
		if(1===DNS0){
			alertString += alertArray[LANGUAGE].DNS0 + errorArrayEX[LANGUAGE];
			flag = 1;
		}
		if(1===DNS1){
			alertString += alertArray[LANGUAGE].DNS1 + errorArrayEX[LANGUAGE];
			flag = 1;
		}	
	}
	with(networkHank){
		var errorMsg = ["Gateway and IP address must be in the same subnet.\n",
									"错误! IP地址和网关需在同一子网内.\n"];

		var ipArray = IPaddr.split('.');
		var ipInt = 0;
		for(var i = 0; i < ipArray.length; i++){
			ipInt = ipInt * 256 +parseInt(ipArray[i],10);
		}
		//alert(ipInt.toString(16));

		var maskArray = maskAddr.split('.');
		var maskInt = 0;
		for(var i = 0; i < maskArray.length; i++){
			maskInt = maskInt * 256 + parseInt(maskArray[i],10);
		}
		//alert(maskInt.toString(16));

		var gwArray = gateway.split('.');
		var gwInt = 0;
		for(var i = 0; i < gwArray.length; i++){
			gwInt = gwInt * 256 +parseInt(gwArray[i],10);
		}
		//alert(gwInt.toString(16));
		
		var ip_mask = ipInt & maskInt;
		var gw_mask = gwInt & maskInt;
		
		if(ip_mask != gw_mask)
		{
			flag = 1;
			alertString += errorMsg[LANGUAGE];
		}
		//alert("flag = "+flag);
	}

	if( 1 == flag){
		alert(alertString);
	}else{
		with(networkHank){
			$("#jsIP").val(IPaddr);
			$("#jsMaskAddr").val(maskAddr);
//			$("#jsGateway").attr("value",gateway);
//			$("#jsDNS0").attr("value",DNS0);
//			$("#jsDNS1").attr("value",DNS1);
		}
		ajaxPost(formID, function(text){
			var state = getState(text);
			if(!state){
				setTimeout("alert(setResult[LANGUAGE].failed)",500);
			}else{
				var paraSrc=["outIPAddrGet","outMaskAddrGet","outGatewayGet","outDNSFirstServerGet","outDNSSecondServerGet"];
				var paraShow=["jsIP","jsMaskAddr","jsGateway","jsDNS0","jsDNS1"];
				for(var i = 0; i < paraSrc.length; i++){
					$("#"+paraSrc[i]).val($("#"+paraShow[i]).val());
				}
				$("#DHCPenableGet").val(0);
				var IP_last = window.location.toString().match(/\d+\.\d+\.\d+\.\d+/).toString();
				var IP_now = responseGetVar(text,"outIPAddr");
				if(IP_last == IP_now){
					setTimeout("alert(setResult[LANGUAGE].succeed)",500);
				}else{
					setTimeout(function(){alert(setResult[LANGUAGE].succeed + gotoArray[LANGUAGE]),
						window.parent.location.href = window.location.href.match(/^[a-zA-Z]+\:\/\//) + IP_now;},500);
				}
			}
		});
	}
}

function networkReset(){
	var i,paraSrc,paraShow;
	$("#jsDHCPenable"+$("#DHCPenableGet").val()).click();
	paraSrc=["outIPAddrGet","outMaskAddrGet","outGatewayGet","outDNSFirstServerGet","outDNSSecondServerGet"];
	paraShow=["jsIP","jsMaskAddr","jsGateway","jsDNS0","jsDNS1"];
	for(i = 0; i < paraSrc.length; i++){
		$("#"+paraShow[i]).val($("#"+paraSrc[i]).val());
	}
}

function PPPOEsubmit(){
	if($("#jsPPPOEuse1:checked").val()){
		DIALOG.loading(1);
		var count = 0;
		$("#jsPPPOEuse1").val(1);
		var pppoeOpenFun=function(){ajaxPost("PPPOEform",function(text){
			if($("#jsPPPOEuse1").val() == 3){
				return;
			}
			var state = getState(text);
			var pppoeState = [{succeed:"Connection succeeded!",failed:"Connection failed!"},{succeed:"连接成功!",failed:"连接失败!"}];
			if(2 == state){
				count++;
				if(count != 5){
					$("#jsPPPOEuse1").val(2);
				}else if( window.confirm(["Connection timed out, continue to wait?\n","连接超时，继续等待?\n"][LANGUAGE])){
						count = 0;
				}else{
					$("#jsPPPOEuse1").val(3);
					DIALOG.loading(0);
				}
				pppoeOpenFun();
			}else if(1 == state){
				DIALOG.loading(0);
				var paraSrc=["pppoe_nameGet","pppoe_passwdGet"];
				var paraShow=["jsPPPOEuser","jsPPPOEpass"];
				for(var i = 0; i < paraSrc.length; i++){
					$("#"+paraSrc[i]).val($("#"+paraShow[i]).val());
				}
				$("#PPPOEstate").val(1);
//				alert(pppoeState[LANGUAGE].succeed);
			}else{
				DIALOG.loading(0);
				alert(pppoeState[LANGUAGE].failed);
			}
			var IPval = responseGetVar(text,"pppoe_IP");
			IPval = IPval? IPval: "";
			$("#jsPPPOEip").text(IPval);
		},null,15000);};
		pppoeOpenFun();
	}else{
			ajaxPost("PPPOEform",function(text){
				var IPval = responseGetVar(text,"pppoe_IP");
				IPval = IPval? IPval: "";
				$("#jsPPPOEip").text(IPval);
				var state = getState(text);
				if(state){
					$("#PPPOEstate").val(0);
				}
				alertRes(text);
			});
	}
/*	
	if( $("#jsPPPOEuse0:checked").val() ){
		ajaxPost("PPPOEform");
		return;
	}
	var flag = 0;
	var alertString = '';
	var inputLimit=[{user:"The length of name between 1 and 30 is available!",pass:"The length of password between 1 and 20 is available!"},
							  {user:"用户名长度应在1~30之间!",pass:"密码长度应在1~20之间!"}];
	dataGet = $("#jsPPPOEuser").val();
	var regExpInfo=/^([a-zA-Z0-9]||[-_.@~!#\$%\^\&\*\(\)\+\=\\\<\>\?\:\{\}\[\]\|\/]){1,50}$/;
	if(!dataGet){
		flag = 1;
		alertString += userPassError[LANGUAGE].userEmpty;
	}else if(30 < dataGet.length){
		flag = 1;
		alertString += inputLimit[LANGUAGE].user;
	}else if(!regExpInfo.exec(dataGet)){
		flag = 1;
		alertString += userPassError[LANGUAGE].userSpecial;
	}
	dataGet = $("#jsPPPOEpass").val();
	if(!dataGet){
		flag = 1;
		alertString += userPassError[LANGUAGE].passEmpty;
	}else if(20 < dataGet.length){
		flag = 1;
		alertString += inputLimit[LANGUAGE].pass;
	}else if(!regExpInfo.exec(dataGet)){
		flag = 1;
		alertString += userPassError[LANGUAGE].passSpecial;
	}
	
	if(flag){
		alert(alertString);
	}else{
		ajaxPost("PPPOEform");
	}*/
}

function PPPOEreset(){
	$("#jsPPPOEuse"+$("#PPPOEstate").val()).click();
	var paraSrc=["pppoe_nameGet","pppoe_passwdGet"];
	var paraShow=["jsPPPOEuser","jsPPPOEpass"];
	for(var i = 0; i < paraSrc.length; i++){
		$("#"+paraShow[i]).val($("#"+paraSrc[i]).val());
	}
}

function SNMPsubmit(snmpID){
//	snmpID = "#" + snmpID;
	var ip = IPcheck( $("#jsSNMPip").val() );
	if(1===ip || ""===ip){
		alert(IPerrorEX[LANGUAGE]);
	}else{
		ajaxPost(snmpID,function(text){
			var state = getState(text);
			if(state){
				$("#SNMPipGet").val($("#jsSNMPip").val());
				$("#SNMPintervalGet").val($("#jsSNMPinterval").val());
			}
			alertRes(text);
		});
	}
}
function SNMPreset(){
	$("#jsSNMPip").val($("#SNMPipGet").val());
	$("#jsSNMPinterval").val($("#SNMPintervalGet").val());
}

function FTPsubmit(formID){
	var alertStr='';
	var flag=0;
//	var regExpInfo=/^([a-zA-Z0-9][-_.]*){1,50}$/;
	/*
	var dataGet =IPcheck( $("#jsFTPIP").val() );
	if(1===dataGet || ''===dataGet ){
		flag = 1;
		alertStr += IPerrorEX[LANGUAGE];
	}
	*/
/*	dataGet = $("#jsFTPuser").val();
	if(!dataGet){
		flag = 1;
		alertStr += userPassError[LANGUAGE].userEmpty;
	}else if(50 < dataGet.length){
		flag = 1;
		alertStr += userPassError[LANGUAGE].userLimit;
	}else if(!regExpInfo.exec(dataGet)){
		flag = 1;
		alertStr += userPassError[LANGUAGE].userSpecial;
	}
	dataGet = $("#jsFTPpass").val();
	if(50 < dataGet.length){
		flag = 1;
		alertStr += userPassError[LANGUAGE].passLimit;
	}else if(dataGet && !regExpInfo.exec(dataGet)){
		flag = 1;
		alertStr += userPassError[LANGUAGE].passSpecial;
	}
	*/
	var numm; 
	var check_str = ["Please check if the Port,Snap Number and Snap Interval are positive integer !","请检查端口，抓拍张数，抓拍间隔是否为正整数!"];
	var alertPort = ["Invalided Port!Port must be between 1 to 65535!","端口设置非法!"];
	var alertMaxCount = ["Snap Number must be between 1 to 10!","抓拍张数不应大于10，但应不小于1"];
	var alertMaxInterval = ["Snap Interval must be between 0 to 15!","抓拍间隔不应大于15，但应不小于0"];
	if(isNaN($("#jsFTPport").val()) || isNaN($("#jsFTPcount").val()) || isNaN($("#jsFTPinterval").val()))
	{
		alert(check_str[LANGUAGE]);
		return false;
	}
	if(parseInt($("#jsFTPport").val())>65535 || parseInt($("#jsFTPport").val())<1)
	{
		alert(alertPort[LANGUAGE]);
		return false;
	}
	if(parseInt($("#jsFTPcount").val())>10 || parseInt($("#jsFTPcount").val())<1)
	{
		alert(alertMaxCount[LANGUAGE]);
		return false;
	}
	if(parseInt($("#jsFTPinterval").val())>15 || parseInt($("#jsFTPinterval").val())<0)
	{
		alert(alertMaxInterval[LANGUAGE]);
		return false;
	}
	if(flag){
		alert(alertStr);
	}else{
		ajaxPost(formID,function(text){
			var state = getState(text);
			if(state){
				var i,paraSrc,paraShow;
				paraSrc=["FTPserveripGet","FTPusernameGet","FTPpasswordGet","FTPserverportGet","FTPsnapcountGet","FTPsnapintervalGet","FTPfilenameGet","FTPpathGet"];
	    		paraShow=["jsFTPIP","jsFTPuser","jsFTPpass","jsFTPport","jsFTPcount","jsFTPinterval","jsFTPfilename","jsFTPpath"];
				for(i = 0; i < paraSrc.length; i++){
					$("#"+paraSrc[i]).val($("#"+paraShow[i]).val());
				}
			}
			alertRes(text);
		});
	}
}
function FTPreset(){
	var i,paraSrc,paraShow;
	paraSrc=["FTPserveripGet","FTPusernameGet","FTPpasswordGet","FTPserverportGet","FTPsnapcountGet","FTPsnapintervalGet","FTPfilenameGet","FTPpathGet"];
	paraShow=["jsFTPIP","jsFTPuser","jsFTPpass","jsFTPport","jsFTPcount","jsFTPinterval","jsFTPfilename","jsFTPpath"];
	for(i = 0; i < paraSrc.length; i++){
		$("#"+paraShow[i]).val($("#"+paraSrc[i]).val());
	}
}

function SMTPsubmit(SMTPid){
//	SMTPid = "#" + SMTPid;
	var emailError = [{fromEmpty:"Sender cannot be empty!\n", toEmpty:"Receiver cannot be empty!\n",
								  fromError:"Sender is invalid!\n", toError:"Receiver is invalid!\n",
								  ccError:"CC field is invalid!\n",
								  portError:"Port value should be 1 to 65535!\n"},
								{fromEmpty:"发件人不能为空!\n", toEmpty:"收件人不能为空!\n",
								  fromError:"发件人格式错误!\n", toError:"收件人格式错误!\n",
								  ccError:"抄送格式错误!\n",
								   portError:"端口号应为1到65535之间!\n"}];
	var flag = 0;
	var alertStr = '';
	//var dataGet = IPcheck( $("#jsSMTPIP").val() );
	var dataGet = $("#jsSMTPIP").val();
	if(1===dataGet || ''===dataGet){
		flag = 1;
		alertStr += IPerrorEX[LANGUAGE];
	}
	var reg = /^([a-zA-Z0-9_-])([ a-zA-Z0-9_\-\.]*)@([a-zA-Z0-9_-]+)((\.[a-zA-Z0-9_-]+)+)$/;
//	var regExpInfo=/^([a-zA-Z0-9][-_.]*){1,50}$/;
	dataGet = $("#jsAddresser").val();
	if(!dataGet){
		flag = 1;
		alertStr += emailError[LANGUAGE].fromEmpty;
	}else if(!reg.test(dataGet) ){
		flag = 1;
		alertStr += emailError[LANGUAGE].fromError;
	}
		
	dataGet = $("#jsAddressee").val();
	if(!dataGet){
		flag = 1;
		alertStr += emailError[LANGUAGE].toEmpty;
	}else if( !reg.test(dataGet) ){
		flag = 1;
		alertStr += emailError[LANGUAGE].toError;
	}
	
	dataGet = $("#jsCopyFor").val();
	if(dataGet && (!reg.test(dataGet)) ){
		flag = 1;
		alertStr += emailError[LANGUAGE].ccError;
	}
	if(isNaN($("#jsSMTPPort").val()) || isNaN($("#jsSslPort").val()))
	{
		flag = 1;
		alertStr += emailError[LANGUAGE].portError;
	}
	else
	{

		dataGet = parseInt($("#jsSMTPPort").val());
		var dataGet1 = parseInt($("#jsSslPort").val());
		if(dataGet<1 || dataGet>65535 || dataGet1<1 || dataGet1>65535)
		{
			flag = 1;
			alertStr += emailError[LANGUAGE].portError;
		}
	}
	
	if($("#SnapShot").attr("checked")==undefined)
	{
		$("#jsSMTPSnapshot").val(0);
	}
	else
	{
		$("#jsSMTPSnapshot").val(1);
	}
/*	if($("#jsSMTPidCheck1:checked").val()){
		dataGet = $("#jsSMTPuserID").val();
		if(!dataGet){
			flag = 1;
			alertStr += userPassError[LANGUAGE].userEmpty;
		}else if(50 < dataGet.length){
			flag = 1;
			alertStr += userPassError[LANGUAGE].userLimit;
		}else if(!regExpInfo.exec(dataGet)){
			flag = 1;
			alertStr += userPassError[LANGUAGE].userSpecial;
		}
		dataGet = $("#jsSMTPuserPass").val();
		if(!dataGet){
			flag = 1;
			alertStr += userPassError[LANGUAGE].passEmpty;
		}else if(50 < dataGet.length){
			flag = 1;
			alertStr += userPassError[LANGUAGE].passLimit;
		}else if(!regExpInfo.exec(dataGet)){
			flag = 1;
			alertStr += userPassError[LANGUAGE].passSpecial;
		}
	}
	*/
	if(flag){
		alert(alertStr);
	}else{
		var idCheck = $("#jsSMTPidCheck1:checked").val()? 1: 0;
		var sslCheck = $("#jsSMTPsslCheck1:checked").val()? 1: 0;
		ajaxPost(SMTPid,function(text){
			var state = getState(text);
			if(state){
				var i,paraSrc,paraShow;
				paraSrc=["SMTPserveripGet","SMTPfrommailGet","SMTPtomailGet","SMTPccmailGet","SMTPusernameGet","SMTPpasswordGet","SMTPserverportGet","SMTPsnapshotGet","SMTPsslportGet"];
				paraShow=["jsSMTPIP","jsAddresser","jsAddressee","jsCopyFor","jsSMTPuserID","jsSMTPuserPass","jsSMTPPort","jsSMTPSnapshot","jsSslPort"];
				for(i = 0; i < paraSrc.length; i++){
					$("#"+paraSrc[i]).val($("#"+paraShow[i]).val());
				}
				$("#SMTPidCheck").val(idCheck);
				$("#SMTPsslCheck").val(sslCheck);
			}
			alertRes(text);
		});
	}
	
}
function SMTPreset(){
	var i,paraSrc,paraShow;
	paraSrc=["SMTPserveripGet","SMTPfrommailGet","SMTPtomailGet","SMTPccmailGet","SMTPusernameGet","SMTPpasswordGet","SMTPserverportGet","SMTPsnapshotGet","SMTPsslportGet"];
	paraShow=["jsSMTPIP","jsAddresser","jsAddressee","jsCopyFor","jsSMTPuserID","jsSMTPuserPass","jsSMTPPort","jsSMTPSnapshot","jsSslPort"];
	for(i = 0; i < paraSrc.length; i++){
		$("#"+paraShow[i]).val($("#"+paraSrc[i]).val());
	}
	$("#jsSMTPidCheck"+parseInt($("#SMTPidCheck").val())).click();
	$("#jsSMTPsslCheck"+parseInt($("#SMTPsslCheck").val())).click();

	if('1' == $("#jsSMTPSnapshot").val())
	{
		$("#SnapShot:checkbox").attr("checked",true);
	}
	else
	{
		$("#SnapShot:checkbox").attr("checked",false);
	}
}

function PEMupload(fileID,formID){
//(cer|crt|pem|pfx|p12|p10|p7r|p7b)
	var fileType = $("#"+fileID).val();
	if(!fileType){
		alert(CAerror[LANGUAGE].empty);
		return;
	}
	if('jsSSLCAfile' == fileID){ //SSL
		if(!(fileType.match(/\.pem$/i))){
			alert(CAerror[LANGUAGE].wrong+'(.pem)\n');
			return;
		}
	}else if('jsTLSPassFile' == fileID){ //8021_私钥密匙
		if(!(fileType.match(/\.(pem|pfx|p12)$/i))){
			alert(CAerror[LANGUAGE].wrong + '(.pem|.p12|.pfx)\n');
			return;
		}
	}else{//8021_CA or User
		if(!(fileType.match(/\.(pem|cer)$/i))){
			alert(CAerror[LANGUAGE].wrong+'(.pem|.cer)\n');
			return;
		}
	}
	$("#"+formID+" input[name='format']").val(fileType.match(/\w+$/).toString().toLocaleLowerCase());
	iframeFun = iframeUploadRes;
//	DIALOG = DIALOG? DIALOG: new Dialog();
	var dialog = DIALOG;
	dialog.loading(1);
	$("#"+formID).submit();
}
function iframeUploadRes(){
	var ifarmeRes = $("#hideFrame").contents().find("html").html().toString();
	var flag = getState(ifarmeRes);
	var alertStrEN = {
		"s1":"Upgrade succeeded.",
		"s2":"Upgrade file is too large!",
		"s4":"Upgrade file error, please try again after verification."
		};
	var alertStrCN = {
		"s1":"导入成功.",
		"s2":"导入文件太大!",
		"s4":"文件操作出错,请检查后再试!"
		};
	var alertArray = [alertStrEN,alertStrCN];
	
	DIALOG.loading(0);
	alert(alertArray[LANGUAGE]["s"+flag.toString()]);
}

function IGMPstreamChanged(){
	var streamType = parseInt($("#IGMPstream").val());
	for(var i = 0; i < 3; i++){
		$("#IGMP"+i).css("display","none");
	}
	$("#IGMP"+streamType).css("display","block");
}

function EAPChanged(){
	var mode = $("#js8021EAPmode").val();
	var passDis,privDis,CAuseVis,uploadDis,TLSfileDis,PEPAfileDis;
	$("#js8021user").css("display","none");
	if('0' == mode){
		passDis = "block";
		privDis = "none";
		CAuseVis = "hidden";
		uploadDis = "none";
		TLSfileDis = "none";
		PEPAfileDis = "none";
	}else if('1' == mode){
		passDis = "none";
		privDis = "block";
		CAuseVis = "hidden";
		uploadDis = "block";
		TLSfileDis = "block";
		PEPAfileDis = "none";
	}else{
		passDis = "block";
		privDis = "none";
		CAuseVis = "visible";
		uploadDis = "block";
		TLSfileDis = "none";
		PEPAfileDis = "block";
	}
	$("#js8021user").css("display","block");
	$("#js8021passHank").css("display",passDis);
	$("#js8021priPassHank").css("display",privDis);
	$("#js8021CAuse").css("visibility",CAuseVis);
	$("#js8021fileForm").css("display",uploadDis);
	$("#js8021TLSfile").css("display",TLSfileDis);
	$("#js8021PEAPfile").css("display",PEPAfileDis);
}

function f8021sumbit(){
	ajaxPost("Form8021X",function(text){
		var state = getState(text);
		if(state){
			var i,paraSrc,paraShow;
			paraSrc=["p8021usernameGet","p8021passwordGet","p8021privatepasswordGet"];
			paraShow=["js8021user","js8021pass","js8021pripass"];
			for(i = 0; i < paraSrc.length; i++){
				$("#"+paraSrc[i]).val($("#"+paraShow[i]).val());
			}
			$("#EAPformat").val($("#js8021EAPmode").val());
			$("#js8021peapcaGet").val($("#js8021PEAPbox:checked").val()?1:0);
			$("#state8021").val($("#js8021used1:checked").val()?1:0);
		}
		alertRes(text);
	});
/*	var state = $("#js8021used1:checked").val();
	if(!state){
		ajaxPost("Form8021X");
		return;
	}
	var EAPmode = $("#js8021EAPmode").val();
	var regExpInfo=/^([a-zA-Z0-9][-_.]*){1,50}$/;
	var user, pass;
	var flag = 0;
	var alertStr = '';
	user = $("#js8021user").val();
	if("1"==EAPmode){
		pass = $("#js8021pripass").val();
	}else{
		pass = $("#js8021pass").val();
	}
	
	if(!user){
		flag = 1;
		alertStr += userPassError[LANGUAGE].userEmpty;
	}else if(50 < user.length){
		flag = 1;
		alertStr += userPassError[LANGUAGE].userLimit;
	}else if(!regExpInfo.exec(user)){
		flag = 1;
		alertStr += userPassError[LANGUAGE].userSpecial;
	}
	if(!pass){
		flag = 1;
		alertStr += userPassError[LANGUAGE].passEmpty;
	}else if(50 < pass.length){
		flag = 1;
		alertStr += userPassError[LANGUAGE].passLimit;
	}else if(!regExpInfo.exec(pass)){
		flag = 1;
		alertStr += userPassError[LANGUAGE].passSpecial;
	}
	
	if(flag){
		alert(alertStr);
	}else{
		ajaxPost("Form8021X");
	}*/
}

function f8021reset(){
	var i,paraSrc,paraShow;
	paraSrc=["p8021usernameGet","p8021passwordGet","p8021privatepasswordGet"];
	paraShow=["js8021user","js8021pass","js8021pripass"];
	for(i = 0; i < paraSrc.length; i++){
		$("#"+paraShow[i]).val($("#"+paraSrc[i]).val());
	}
	var dataGet = parseInt($("#EAPformat").val());
	$("#js8021EAPmode").val(dataGet);
	EAPChanged();
	dataGet = Boolean(parseInt($("#js8021peapcaGet").val()));
	$("#js8021PEAPbox").attr("checked", dataGet);
	dataGet = Boolean( parseInt($("#state8021").val()) );
	if(dataGet){
		$("#js8021used1").click();
	}else{
		$("#js8021used0").click();
	}
}

function PORTsubmit(){
	ajaxPost("portForm",function(text){
		var state = getState(text);
		alertRes(text);
	});
}

function PROTOsubmit(){
	var i;
	var proto_name = $("#ProtoName_").val().split(",");
	for(i=0; i<proto_name.length; i++) {
		var proto_check = $("#proto_check_" + proto_name[i]);
		var proto_input = $("#proto_" + proto_name[i]);
		if(proto_check.is(":checked"))
			proto_input.val(1);
		else
			proto_input.val(0);
	}
	ajaxPost("ProtoForm",function(text) {
			var state = getState(text);
			if(!state) {
				alertRes(text);
 			} else {
				var dialog = DIALOG;
				dialog.show(60,["Setting suceeded, please wait...  ","设置成功，请稍候...  "][LANGUAGE],'', function(){parent.mainFrame.document.location = (parseInt($("#PAGE_LANGUAGE").val()) ? "networkC.asp?show=17" : "network.asp?show=17");});
 			}
		});
}

function PROTOreset(){
	var i;
	var proto_name = $("#ProtoName_").val().split(",");
	var proto_enable = $("#ProtoEnable_").val().split(",");
	var parent = $("#Protodiv");

	for(i=0; i<proto_name.length; i++) {
		if(proto_name[i] == "")
			continue;
		var proto_div = $("<div class=\"content\"></div>");
		proto_div.appendTo(parent);

		var proto_lab = $("<label class=\"setExplain\">" + proto_name[i] + "</label>");
		proto_lab.appendTo(proto_div);

		var proto_check = $("<input id=\"proto_check_" + proto_name[i] + "\" type=\"checkbox\" checked=\"checked\" />");
		if(proto_enable[i] == '0')
			proto_check.attr("checked",false);
		proto_check.appendTo(proto_div);

		var proto_input = $("<input name=\"" + proto_name[i] + "\" id=\"proto_" + proto_name[i] +
		"\" type=\"hidden\" value=\"" + proto_enable[i] +"\"/>");
		proto_input.appendTo(proto_div);

	}
}

function QOSsubmit(){
	ajaxPost("QOSform",function(text){
		var state = getState(text);
		if(state){
			$("#QOSmode").val($("#jsQOSmode").val());
		}
		alertRes(text);
	});
}
function QOSreset(){
	$("#jsQOSmode").val($("#QOSmode").val());
}

function IGMPsubmit(IGMPid){
	var IPerrorEX = ["Invalid format. Correct format is xxx.xxx.xxx.xxx (224.0.1.0~239.255.255.255)\n",
					  "IP地址错误：正确格式为xxx.xxx.xxx.xxx (224.0.1.0~239.255.255.255)\n"];
	var flag = 0;
	var alertString = '';
	var streamType = $("#IGMPstream").val();
	var dataGet = $("#jsIGMP"+streamType+"ON1:checked").val();
	if(dataGet){
		dataGet = IPcheck( $("#jsIGMP"+streamType+"IP").val() );
		if(1===dataGet || ''===dataGet){
			flag = 1;
			alertString += IPerrorEX[LANGUAGE];
		}else{
			var IParray = dataGet.split("\.");
			for(var i = 0; i < IParray.length; i++)
				IParray[i] = parseInt(IParray[i],10);
			if(IParray[0] < 224 || IParray[0] > 239){
				flag = 1;
				alertString += IPerrorEX[LANGUAGE];
			}else if(IParray[0] == 224 && IParray[1] == 0 && IParray[2] < 1){
				flag = 1;
				alertString += IPerrorEX[LANGUAGE];
			}
		}
		dataGet = parseInt($("#jsIGMP"+streamType+"Port").val(),10);
		var RTPport = new Array();
		for(var i = 0; i < 3; i++){
			RTPport[i] = parseInt($("#IGMP"+i+"State").val())? $("#IGMP"+i+"Port").val():"null";
		}
		RTPport.splice(streamType,1);
		if(isNaN(dataGet) || dataGet < 1025 || dataGet > 65535){
			flag = 1;
			alertString += ["Invalid RTP port! (1025~65535)\n","RTP端口格式错误! (1025~65535)\n"][LANGUAGE];	
		}else if(dataGet%2!=0){
			flag=1;
			alertString += ["Invalid RTP port! RTP port must be an even number.\n","RTP端口输入错误!RTP端口号必须为偶数 (1025~65535)\n"][LANGUAGE];	
		}else if( (dataGet==RTPport[0]) || (dataGet==RTPport[1]) ){
			flag = 1;
			alertString += ["Invalid RTP port input! RTP ports of the three frames(main, sub and MJPEG)must be different.\n","RTP端口输入有误! 三个码流(主码流, 副码流, MJPEG)的RTP端口必须设置为不同的.\n"][LANGUAGE];
		}else{
			$("#jsIGMP"+streamType+"Port").val(dataGet);
		}
	}
	if(flag){
		alert(alertString);
	}else{
		ajaxPost(IGMPid,function(text){
			var state = getState(text);
			if(state){
				for(var i = 0; i < 3; i++){
					$("#IGMP"+i+"IP").val($("#jsIGMP"+i+"IP").val());
					$("#IGMP"+i+"Port").val($("#jsIGMP"+i+"Port").val());
					$("#IGMP"+i+"State").val($("#jsIGMP"+i+"ON1:checked").val()?1:0);
				}
				var dialog = DIALOG;
				dialog.show(30,["Please wait...  ","请稍候...  "][LANGUAGE],"",function(){alert(["Set successfully! ","设置成功!"][LANGUAGE])});
			}else{
				alertRes(text);
			}
		});
	}
}
function IGMPreset(){
	var dataGet;
	for(var i = 0; i < 3; i++){
		$("#jsIGMP"+i+"IP").val($("#IGMP"+i+"IP").val());
		$("#jsIGMP"+i+"Port").val($("#IGMP"+i+"Port").val());
		dataGet = Boolean( parseInt($("#IGMP"+i+"State").val()) );
		if(dataGet){
			$("#jsIGMP"+i+"ON1").click();
		}else{
			$("#jsIGMP"+i+"ON0").click();
		}
	}
}

function DHCPchanged(flag){
	flag = Boolean(flag);
	var DOMobj = [$("#jsIP"),$("#jsMaskAddr"),$("#jsGateway"),$("#jsDNS0"),$("#jsDNS1")];
	for(var i = 0; i < DOMobj.length; i++){
		DOMobj[i].attr("disabled",flag);
		DOMobj[i].css("cursor", flag?"default": "auto" );
	}
}

function SIPsubmit(){
	var SIPIP = $("#jsSIPServerIPAddress");
	var ip = IPcheck(SIPIP.val());
	var flag = 0, alertStr = "";
	if(1 == ip || ""===ip){
		flag = 1;
		alertStr += IPerrorEX[LANGUAGE];
	}else{
		ip = 0===ip? "0.0.0.0":ip;
		SIPIP.val(ip);
	}
	if(flag){
		alert(alertStr);
	}else{
		ajaxPost("SIPForm",function(text){
			alertRes(text);
			if(getState(text))
				formSet('SIPForm',1);
		});
	}
}
function formSet(formID,flag){
	var input = $("#"+formID).find("input[name][type!='radio'][type!='checkbox'][type!='hidden'][type!='button']");
	if(flag){
		input.each(function(){
            $(this).data("valLast",$(this).val());
        });
	}else{
		input.each(function(){
			$(this).val($(this).data("valLast"));
		});
	}
}

function SIPPosSubmit(){
	var posName = [{long:"Longitude",lat:"Latitude"},{long:"经度",lat:"纬度"}];
	var posErr = ["Invalid input!","输入错误!"];
	var posRange = {long:" (-180~180)\n",lat:" (-90~90)\n"};
	var flag = 0; alertStr = "";
	var posDOM = $("#jsSIPLongitude");
	var posVal = parseFloat(posDOM.val());
	if(isNaN(posVal) || (-180>posVal || 180<posVal)){
		flag = 1;
		alertStr += posName[LANGUAGE].long + posErr[LANGUAGE]+posRange.long;
	}else{
		posDOM.val(posVal.toFixed(2));
	}
	posDOM = $("#jsSIPLatitude");
	posVal = parseFloat(posDOM.val());
	if(isNaN(posVal) || (-90>posVal || 90<posVal)){
		flag = 1;
		alertStr += posName[LANGUAGE].lat + posErr[LANGUAGE]+posRange.lat;
	}else{
		posDOM.val(posVal.toFixed(2));
	}
	if(flag){
		alert(alertStr);
	}else{
		ajaxPost("SIPPosForm",function(text){
			alertRes(text);
			if(getState(text))
				formSet('SIPPosForm',1);
		});
	}
}
/***互信互通*************************************************/
function hxhtSubmit(){
	var hxhtIP = $("#jsHxhtIP");
	var ip = IPcheck(hxhtIP.val());
	var flag = 0, alertStr = "";
	if(1 == ip || ""===ip){
		flag = 1;
		alertStr += IPerrorEX[LANGUAGE];
	}else{
		ip = 0===ip? "0.0.0.0":ip;
		hxhtIP.val(ip);
	}
	if(flag){
		alert(alertStr);
	}else if(confirm("设置成功后, 系统将重启. \n继续?")){
		var dialog = DIALOG;
		dialog.loading(1);
		ajaxPost("hxhtForm",function(text){
			dialog.loading(0);
			if(getState(text)){
				formSet('hxhtForm',1);
				dialog.show(60,"请稍候... ","",function(){alert("设置成功!")});
			}else{
				alertRes(text);
			}
		});
	}
}
function sjkdSubmit(){
	var sjkdGIP = $("#jsSjkdGroupIP");
	var sjkdPIP = $("#jsSjkdProcIP");
	var ipG = IPcheck(sjkdGIP.val());
	var ipP = IPcheck(sjkdPIP.val());
	var flag = 0, alertStr = "";
	if(1 == ipG || ""===ipG){
		flag = 1;
		alertStr += IPerrorEX[LANGUAGE];
	}else{
		ipG = 0===ipG? "0.0.0.0":ipG;
		sjkdGIP.val(ipG);
	}
	if(1 == ipP || ""===ipP){
		flag = 1;
		alertStr += IPerrorEX[LANGUAGE];
	}else{
		ipP = 0===ipP? "0.0.0.0":ipP;
		sjkdPIP.val(ipP);
	}
	if(flag){
		alert(alertStr);
	}else{
		ajaxPost("sjkdForm",function(text){
			alertRes(text);
		});
	}
}
/*********************************************************/
/****digifort***********************************************/
function digifortSubmit(){
	var DOMip = $("#jsDGFTserverip");	
	var ipVal = IPcheck(DOMip.val());
	var flag = 0; alertStr = "";
	if(1===ipVal || ""===ipVal){
		flag = 1;
		alertStr += IPerrorEX[LANGUAGE];
	}else{
		ipVal = 0===ipVal? "0.0.0.0": ipVal;
		DOMip.val(ipVal);
	}
	var DOMport = $("#jsDGFTport");
	var portVal = parseInt(DOMport.val());
	portVal = isNaN(portVal)? 0:portVal;
	DOMport.val(portVal);
	if(flag){
		alert(alertStr);
	}else{
		ajaxPost("digifortForm",function(text){
			alertRes(text);
			if(getState(text))
				formSet('digifortForm',1);
				$("#digifortEnableGet").val($("input[id^='jsDigifortOn']:checked").val());
		});
	}
}
function digifortState(flag){
	var DOMform = $("#digifortForm");
	var input = DOMform.find("input[type!='hidden'][type!='radio'][type!='button']");
	var label = input.siblings("label");
	var state = flag? false: true;
	var cursor = flag? "auto":"default";
	input.attr("disabled",state).css("cursor", cursor);
	label.attr("disabled",state).css("cursor", cursor);
}
function digifortReset(){
	var state = parseInt($("#digifortEnableGet").val())? 1:0;
	$("#jsDigifortOn"+state).click();
}

function DDNSStateChange()
{
	$('#DDNSform :text,#DDNSform :password,#DDNSform select').attr('disabled',$('#DDNSOff').attr('checked')=='checked'?true:false);
}
function DDNSSet()
{
	if($('#DDNSUserName').val()==''||$('#DDNSPassword').val()==''||$('#DDNSDomain').val()=='')
	{
		alert(["Username, password, domain cannot be empty","用户名\密码\域名不能为空"][LANGUAGE]);
		return;
	}
	else 
	{
		ajaxPost("DDNSform",function(text){
			alertRes(text);
		});
	}
}

function kcDdnsStateChange()
{
	$('#kcDdnsForm :text,#kcDdnsForm :password').attr('disabled',$('#kcDdnsOff').attr('checked')=='checked'?true:false);
}
function kcDdnsSet()
{
	if($('#kcDdnsName').val()==''||$('#kcDdnsPassword').val()=='')
	{
		alert(["Username, password cannot be empty","用户名\密码不能为空"][LANGUAGE]);
		return;
	}
	else 
	{
		ajaxPost("kcDdnsForm",function(text){
			alertRes(text);
		});
	}
}
function kcClientStateInit()
{
	$($('#kcDdnsEnable').val()=='1'?'#kcDdnsOn':'#kcDdnsOff').attr('checked',true);
	kcDdnsStateChange();
}

function TUTKStateInit()
{
	if($("#TUTKUsableGet").val() == '1' || $('#TUTKenableGet').val()=='1')
		$("#tutk_LI").show();
	else
		$("#tutk_LI").hide();
	$($('#TUTKenableGet').val()=='1'?'#TUTKon':'#TUTKoff').attr('checked',true);
	if($('#TUTKAuthorizedGet').val()=='1')
	{
		document.getElementById("TUTKAuthorized1").style.display = "block";
		document.getElementById("TUTKAuthorized0").style.display = "none";
	}
	else
	{
		document.getElementById("TUTKAuthorized1").style.display = "none";
		document.getElementById("TUTKAuthorized0").style.display = "block";
	}
	if($('#TUTKStatusGet').val()=='1')
	{
		document.getElementById("TUTKStatus1").style.display = "block";
		document.getElementById("TUTKStatus0").style.display = "none";
	}
	else
	{
		document.getElementById("TUTKStatus1").style.display = "none";
		document.getElementById("TUTKStatus0").style.display = "block";
	}
//	TUTKStateChange();
}

//for user set uid on web
function TUTKStateChange()
{
    $('#TUTKForm :text').attr('disabled',$('#TUTKoff').attr('checked')=='checked'?true:false);
}
function TUTKsubmit(){
	var flag = 0;
	var uid = $("#TUTKUidInput").val();;
	var regExpInfo =/[^A-Za-z0-9]+$/;
	if($("#TUTKon:checked").val())
	{
		if((uid!=null))
		{
			if((regExpInfo.test(uid)))
			{
				flag = 1;
				alert(TUTKUIDError[LANGUAGE]);
			}
		}
	}
	
	if(0 == flag && $('#TUTKenableGet').val()!=$('#TUTKForm :radio:checked').val())
	{
		ajaxPost("TUTKForm",function(text){
			var state= getState(text);
			if(!state)
			{
				alertRes(text);
			}
			else
			{
				//if($('#TUTKenableGet').val()!=$('#TUTKForm :radio:checked').val())
				{
					var dialog = DIALOG;
					dialog.show(60,["Setting suceeded, please wait...  ","设置成功，请稍候...  "][LANGUAGE],'', function(){parent.mainFrame.document.location = ($("#PAGE_LANGUAGE").val() ? "networkC.asp?show=15" : "network.asp?show=15");});
					$('#TUTKenableGet').val($('#TUTKForm :radio:checked').val());
				}
				//else alertRes(text);
			}
		});
	}
	
}

function MobileInit()
{
	$($('#MobileState_').val()=='1'?'#MobileOn':'#MobileOff').attr('checked',true);
	$("#MobileModle").val($("#MobileModle_").val());
	$('#Mobileform :text,#Mobileform :password,#Mobileform select,#Mobileform :button').attr('disabled',$('#MobileOff').attr('checked')=='checked'?true:false);
	MobileRefresh();
	if(parseInt($("#MobileSupport_").val()) != 0)
		$("#mobile_LI").css("display","block");
}
function MobileStateChange()
{
	$('#MobileCflag').val(0);
	$('#Mobileform :text,#Mobileform :password,#Mobileform select,#Mobileform :button').attr('disabled',$('#MobileOff').attr('checked')=='checked'?true:false);
	$('#Mobileform').submit();
}
function MobileModleChange()
{
	$('#MobileCflag').val(1);
	$('#Mobileform').submit();
}
function MobileConnect()
{
	$('#MobileCflag').val(2);
	$('#Mobileform').submit();
}
function MobileDisconnect()
{
	$('#MobileCflag').val(3);
	$('#Mobileform').submit();
}
function MobileRefresh()
{
	  var test;
	  $.ajax({
			url:"/form/MobileRefresh",
			data:"lang="+$("#PAGE_LANGUAGE").val(),
			dataType:"text",
			success:function(data)
			{
				test = data.toString();
				$("#MobileStatus").html(test);
			}
	  });
}

function DigestAuthInit()
{
	$($('#DigestAuthEnable_').val()=='1'?'#DigestAuthon':'#DigestAuthoff').attr('checked',true);
}
function DigestAuthsubmit()
{
	$("#DigestAuthForm").submit();
}
function IPFilterInit()
{
	for(var i=1;i<=4;i++)
	{
		$('#FilterEnable'+i).attr('checked',$('#FilterEnable_'+i).val()=='1'?true:false);
		$('#FilterMethod'+i).val($('#FilterMethod_'+i).val());
		FilterStateChange(i);
	}
}
function FilterStateChange(num)
{
	$('#FilterMethod'+num+',#FilterIPStart'+num+',#FilterIPEnd'+num).attr('disabled',$('#FilterEnable'+num).attr('checked')?false:true);
}

function parseIP(ip)
{
	var ipArray = ip.split("\.");
	var value;
	var IPint = 0;
	for(var i=0; i<4; i++)
	{
		value = parseInt(ipArray[i],10);
		IPint += (value << ((3-i) * 8))
	}
	return (IPint>>>0);
}

function FilterSet()
{
	var ipcheck;
	var ipStart,ipEnd;
	var IPOrderEX = ["Start IP must be smaller than end IP !","起始IP须小于结束IP !"];
	
	for(var i=1;i<=4;i++)
	{
		$('#FilterEnable_'+i).val($('#FilterEnable'+i).attr('checked')?1:0);
		ipcheck = IPcheck( $("#FilterIPStart"+i).val() );
		if(1===ipcheck || ""===ipcheck)
		{
			alert(IPerrorEX[LANGUAGE]);
			return;
		}
		ipStart = parseIP( $("#FilterIPStart"+i).val() );
		ipcheck = IPcheck( $("#FilterIPEnd"+i).val() );
		if(1===ipcheck || ""===ipcheck)
		{
			alert(IPerrorEX[LANGUAGE]);
			return;
		}
		ipEnd = parseIP( $("#FilterIPEnd"+i).val() );
		if(ipStart > ipEnd)
		{
			alert(IPOrderEX[LANGUAGE]);
			return;
		}
	}
	$('#FilterForm').submit();
}

function SnmpReset()
{
	if($('#versionGet').val()==1)
	{
		$('#version1').attr('checked',true);
		$('#version2').attr('checked',false);
	}
	else if($('#versionGet').val()==2)
	{
		$('#version1').attr('checked',false);
		$('#version2').attr('checked',true);
	}
	if($('#versionGet').val()==3)
	{
		$('#version1').attr('checked',true);
		$('#version2').attr('checked',true);
	}
	$('#jsread_community').val($('#read_communityGet').val());
	$('#jswrite_community').val($('#write_communityGet').val());
	for(var i=1;i<3;i++)
		SnmpVersionSet(i);
}
function SnmpVersionSet(i)
{
	$('#version'+i).val($('#version'+i).attr('checked')?1:0);
}
function APPSelectChange()
{
	var arr= ["ppcn_div", "ulu_div", "glink_div"];
	for(i = arr.length; i--;) {
		if($('#APPSelect').val() == arr[i]) {
			$('#'+arr[i]).show();
		} else {
			$('#'+arr[i]).hide();
		}
	}
}
function PPCNStateInit()
{
	if($("#PPCNUsable").val() != '1' && $('#PPCNenableGet').val()!='1') {
		$("#PPCNon").attr("disabled", true);
		$("#PPCNoff").attr("disabled", true);
	}

	$($('#PPCNenableGet').val()=='1'?'#PPCNon':'#PPCNoff').attr('checked',true);
	QRCodetext.text = $("#ppcn_id").val().split(" ")[0];
    jQuery('#qrcodeTable').qrcode(QRCodetext);
}
function PPCNsubmit(){
	ajaxPost("PPCNForm",function(text){
		var state= getState(text);
		if(!state)
		{
			alertRes(text);
		}
		else
		{
			//if($('#TUTKenableGet').val()!=$('#TUTKForm :radio:checked').val())
			{
				var dialog = DIALOG;
				dialog.show(60,["Setting suceeded, please wait...  ","设置成功，请稍候...  "][LANGUAGE],'', function(){parent.mainFrame.document.location = ($("#PAGE_LANGUAGE").val() ? "networkC.asp?show=17" : "network.asp?show=17");});
				//$('#TUTKenableGet').val($('#TUTKForm :radio:checked').val());
			}
			//else alertRes(text);
		}
	});
}

function ULUStateInit()
{
	$($('#ULUenableGet').val()=='1'?'#ULUon':'#ULUoff').attr('checked',true);
	QRCodetext.text = $("#ulu_id").val().split(" ")[0];
	jQuery('#qrcodeTableULU').qrcode(QRCodetext);
	if($("#ulu_id").val()=='')
	{
		$('#qrcodeTableULU').hide();
		if($('#ULUenableGet').val()=='0')
			$('#ULU_ID_DIV').hide();
	}
	if($('#ULUenableGet').val()=='0')
		$('#ULU_RESET_DIV').hide();
}
function GLINKStateInit()
{
	if($('#GLINKusable_').val()=='0') {
		$("#GLINKon").attr("disabled", true);
		$("#GLINKoff").attr("disabled", true);
	}
	$($('#GLINKenable_').val()=='1'?'#GLINKon':'#GLINKoff').attr('checked',true);
	QRCodetext.text = $("#GLINKid_").val().split(" ")[0];
	jQuery('#qrcodeTableGLINK').qrcode(QRCodetext);
	if($("#GLINKid_").val()=='')
	{
		$('#qrcodeTableGLINK').hide();
		if($('#GLINKenable_').val()=='0')
			$('#GLINK_ID_DIV').hide();
	}
	if($('#GLINKenable_').val()=='0')
		$('#GLINK_STATUS_DIV').hide();
}
function ELStateInit()
{
	$($('#ELenable_').val()=='1'?'#ELon':'#ELoff').attr('checked',true);
	QRCodetext.text = $("#ELid_").val().split(" ")[0];
	jQuery('#qrcodeTableEL').qrcode(QRCodetext);
	if($("#ELid_").val()=='')
	{
		$('#EL_ID_DIV,#qrcodeTableEL').hide();
	}
	else
	{
		$("#ELid_label").text($("#ELid_").val());
	}
	if($('#ELstatus_').val()=='0')
	{
		$("#ELstatus").text(["Cannot connect to server","无法连接服务器"][LANGUAGE]);
	}
	else if($('#ELstatus_').val()=='1')
	{
		$("#ELstatus").text(["Invalid ID","非法ID"][LANGUAGE]);
	}
	else if($('#ELstatus_').val()=='2')
	{
		$("#ELstatus").text(["OK","在线"][LANGUAGE]);
	}
	if($('#ELusable_').val()=='1')
	{
		$("#el_LI").show();
		$("#ulu_LI").hide();
	}
}
function ULUsubmit(){
	if(parseInt($('#ULUreset').val()) == 1)
	{
		if(!window.confirm(["Device will reset binding users and it takes several seconds, confirm?","设备将清除用户绑定关系且这将视网络情况耗时几秒钟,确认?"][LANGUAGE]))
			return;

		ajaxPost("ULUForm",function(text){
			var state = getState(text);
			if(state)
				alert(["Reset Success !","解绑成功!"][LANGUAGE]);
			else
				alert(["Reset Fail!","解绑失败!"][LANGUAGE]);
		});

		$('#ULUreset').val(0);
		return;
	}
	ajaxPost("ULUForm",function(text){
		var state= getState(text);
		if(!state)
		{
			alertRes(text);
		}
		else
		{
			//if($('#TUTKenableGet').val()!=$('#TUTKForm :radio:checked').val())
			{
				var dialog = DIALOG;
				dialog.show(60,["Setting suceeded, please wait...  ","设置成功，请稍候...  "][LANGUAGE],'', function(){parent.mainFrame.document.location = (parseInt($("#PAGE_LANGUAGE").val()) ? "networkC.asp?show=17" : "network.asp?show=17");});
				//$('#TUTKenableGet').val($('#TUTKForm :radio:checked').val());
			}
			//else alertRes(text);
		}
	});
}

function GLINKsubmit(){
	ajaxPost("GLINKForm",function(text){
		var state= getState(text);
		if(!state)
		{
			alertRes(text);
		}
		else
		{
			{
				var dialog = DIALOG;
				dialog.show(60,["Setting suceeded, please wait...  ","设置成功，请稍候...  "][LANGUAGE],'', function(){parent.mainFrame.document.location = (parseInt($("#PAGE_LANGUAGE").val()) ? "networkC.asp?show=17" : "network.asp?show=17");});
			}
		}
	});
}

function ELsubmit(){
	ajaxPost("ELForm",function(text){
		var state= getState(text);
		if(!state)
		{
			alertRes(text);
		}
		else
		{
			//if($('#TUTKenableGet').val()!=$('#TUTKForm :radio:checked').val())
			{
				var dialog = DIALOG;
				dialog.show(60,["Setting suceeded, please wait...  ","设置成功，请稍候...  "][LANGUAGE],'', function(){parent.mainFrame.document.location = (parseInt($("#PAGE_LANGUAGE").val()) ? "networkC.asp?show=19" : "network.asp?show=18");});
				//$('#TUTKenableGet').val($('#TUTKForm :radio:checked').val());
			}
			//else alertRes(text);
		}
	});
}

/*********************************************************/
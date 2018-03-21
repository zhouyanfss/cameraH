var initStr = [{none:"None",preset:"Preset",pattern:"Pattern",autopan:"Auto-Pan",black:"Black",gray:"Gray",white:"White",red:"Red",green:"Green",blue:"Blue",cyan:"Cyan",yellow:"Yellow",magenta:"Magenta"},
					{none:"无",preset:"预置位",pattern:"花样扫描",autopan:"水平扫描",black:"黑色",gray:"灰色",white:"白色",red:"红色",green:"绿色",blue:"蓝色",cyan:"青色",yellow:"黄色",magenta:"洋红"}];
var deletRes = [{succeed:"Delete succeeded!",fail:"Delete failed!"},{succeed:"删除成功!",fail:"删除失败!"}];					
var LANGUAGE
//**********************init ptz function para**************************
function ytInit(){
	LANGUAGE =parseInt($("#PAGE_LANGUAGE").val());
	$(document).contextmenu(function(){return false});//屏蔽右键
	
	//var device =parseInt(parent.leftFrame.document.getElementById("DeviceID").value,10);	
	//init preset number
	var tempStr="";
	for(var i = 0; i < 255; i++){
		tempStr += "<option value='" + i + "'>" + (i+1) + "</option>";
	}
	$("#jsPresetNum").html(tempStr).change();
	
	tempStr = "";
	for(var i = 1; i < 256; i++){
		tempStr += "<option value='" + i + "'>" + i + "</option>";
	}
	$("#cameraAddr").html(tempStr);
	
	tempStr = "";
	for(var i = 1; i < 11; i++){
		tempStr += "<option value='" + i + "'>" + i + "</option>";
	}
	$("#jsAutopanSpd").html(tempStr);
	
	tempStr = "";
	for(var i = 0; i < 31; i++){
		tempStr += "<option value='" + i + "'>" + i + "s</option>";
	}
	$("#jsAutopanDelaytime").html(tempStr);
	$("#jsAutopanNum").change();
	
	$("#jsPatternNum").change();
	
	tempStr = "<option value='0'>" + initStr[LANGUAGE].none + "</option>";
	for(var i = 1; i < 33; i++){
		tempStr += "<option value='" + i + "'>" +  initStr[LANGUAGE].preset + i + "</option>";
	}
	for(var i = 33; i < 37; i++){
		tempStr += "<option value='" + i + "'>" +  initStr[LANGUAGE].pattern + (i-32) + "</option>";
	}
	for(var i = 37; i < 41; i++){
		tempStr += "<option value='" + i + "'>" +  initStr[LANGUAGE].autopan + (i-36) + "</option>";
	}
	$("#jsAutoBackAct").html(tempStr);
	$("select[id^=jsTourAction]").html(tempStr);
	
	var DOMobj = $("select[id^='jsTourDelay']");
	tempStr = "";
	for(var i = 0; i < 61; i++){
		tempStr += "<option value='" + i + "'>" + i + "</option>";
	}
	DOMobj.css({"width":"60px","margin-left":"10px"});
	DOMobj.html(tempStr);
	
	if(parseInt($("#patternShow").val()) == 1)
		$("#pattern_li").show();
	setTimeout("initPTZSpecialPara()",10);
	setTimeout("initHomeRtn()",10);
	//setTimeout("initMaskInfo()",10);
	setTimeout("normalUserDis()",200);
	
	var af_enable = $("#jsAFTestEn").val();
	if(af_enable == 1)
	{
		$("#afmanual_li").css("display", "block");
	}
}

function normalUserDis()
{
	if(!IsSuperUser())
	{
		disabledAll();
		$("label").prev().attr("disabled",true);
		$("div[class^='patrol']").attr("disabled",true);
		$("table[class^='genrlPrl2']").attr("disabled",true);
	}
}

function cfgInit(formID, staticID, text){
	var DOMstatic = $("#"+staticID);
	if( DOMstatic.val()!=responseGetVar(text,DOMstatic.attr("name")) ){
		return;
	}
	var DOMform = $("#"+formID);
	var DOMinput = DOMform.find("input[id!='"+staticID+"'][type!='radio'][type!='checkbox'][name]");
	var DOMradio = DOMform.find("input[id!='"+staticID+"'][type='radio'][name]");
	var DOMcheckbox = DOMform.find("input[id!='"+staticID+"'][type='checkbox'][name]");
	var DOMselect = DOMform.find("select[name]");
	var DOMarray = [DOMinput,DOMradio,DOMcheckbox,DOMselect];
	
	for(var i = 0; i < DOMarray.length; i++){
		for(var j = 0; j < DOMarray[i].length; j++){
			var DOMobj = DOMarray[i].eq(j);
			var objName = DOMobj.attr("name");
			var resVal = responseGetVar(text,objName);
			if(null != resVal){
				DOMobj.val(resVal);
			}
		}
	}
}

function ajaxHankGet(url,formID,staticID){
	var time = new Date();
	if($("#"+staticID).get(0).selectedIndex>=0)
	{
		var no = $("#"+staticID).get(0).selectedIndex;
		addcookie(staticID+"="+no);
	}
	$.ajax({type:'POST',url:url+"?_="+time.getTime(),data:$("#"+formID).serialize(),success:function(text){cfgInit(formID, staticID, text);},timeout:7000});
}

function protocolSubmit(){
	ajaxPost("linkParaForm");
}

//**************************preset*****************************
function presetSubmit(flag){
	var PresetExist = $("#jsPresetExist");
	$("#jsPresetFlag").val(flag);
	if(2 == flag){
		ajaxPost("posHankForm",function(){});
	}else if(3 == flag){
		ajaxPost("posHankForm",function(text){PresetExist.val(getState(text)? 1: 0);});
	}else if(4 == flag){
		if(PresetExist.val() == 1){
			ajaxPost("posHankForm",function(){});
		}else{
			alert(["Preset is not setup!","预置位未设置!"][LANGUAGE]);
		}
	}else if(5 == flag || 6 == flag){
		ajaxPost("posHankForm",function(text){
			if( getState(text) ){
				PresetExist.val(0); 
				alert(deletRes[LANGUAGE].succeed);
			}else{
				alert(deletRes[LANGUAGE].fail);
			}
			document.getElementById("jsPresetName").value="";
		});
	}
}
//***************************************************************

//*********************autopan***********************************
var timerIDAutoPan = null;

function autopanSubmit(flag){
	var player = document.getElementById("Player");
	$("#jsAutopanFlag").val(flag);
	if(2 == flag || 3 == flag || 4 == flag || 5 == flag){
		ajaxPost("autopanForm",function(){});
	}
	else if(6 == flag){
			$("#jsAutopanExist").val(1);
				$("#jsAutoPanStart").css("display","none");
				$("#jsAutoPanStop").css("display",'');
				$("#autopanForm").find("select[id^='jsAutopan']").attr("disabled",true);
				$("#autopanForm").find("input[id!='jsAutoPanS'][type='button']").attr("disabled",true);
				$("#jsAutoPanStop").attr("disabled",false);
				ajaxPost("autopanForm",function(){});
				player.SetPTZControlMode(2);
				player.EnableVectorControl(false);
				timerIDAutoPan = setTimeout("antopanEnd()",60000);
	}else if(7 == flag){
			$("#jsAutopanExist").val(2);
			$("#jsAutoPanStart").css("display",'');
			$("#jsAutoPanStop").css("display","none");
			$("#autopanForm").find("select[id^='jsAutopan']").attr("disabled",false);
			$("#autopanForm").find("input[id!='jsAutoPanS'][type='button']").attr("disabled",false);
			ajaxPost("autopanForm",function(){});
			player.EnableVectorControl(true);
			if(timerIDAutoPan){
				clearTimeout(timerIDAutoPan);
				timerIDAutoPan = null;
			}
	}else if(8 == flag){
		if($("#jsAutopanExist").val() == 2){
			ajaxPost("autopanForm",function(){});
		}else if($("#jsAutopanExist").val() == 0){
			alert(["Auto-pan is not setup!","水平扫描未设置!"][LANGUAGE]);
		}
		else {
			alert(["Auto-pan setup is incomplete!","水平扫描尚未设置完成!"][LANGUAGE]);
		}
	}else if(9 == flag || 10 == flag){
		ajaxPost("autopanForm",function(text){
			if( getState(text) ){
				$("#jsAutopanExist").val(0);
				alert(deletRes[LANGUAGE].succeed);
			}else{
				alert(deletRes[LANGUAGE].fail);
			}
		});
	}
}

function antopanEnd()
{
	var player = document.getElementById("Player");
	autopanSubmit(7);
	player.EnableVectorControl(true);
}
//**************************************************************

//***********************pattern********************************
function patternWebCtrlState(flagValue,bDisabled)
{
	var player = document.getElementById("Player");
	$("#jspatternExist").val(flagValue);
	$("#jsPatternStart").css("display",(bDisabled == true) ? "none" : "");
	$("#jsPatternStop").css("display",(bDisabled == true) ? "block" : "none");
	$("#patternForm").find("select[id^='jsPattern']").attr("disabled",bDisabled);
	$("#patternForm").find("input[id!='jsPatternS'][type='button']").attr("disabled",bDisabled);
	player.EnableVectorControl(!bDisabled);
}

function patternSubmit(flag){
	var player = document.getElementById("Player");
	$("#jspatternFlag").val(flag);
	if(2 == flag){
		ajaxPost("patternForm",function(){});
	}else if(3 == flag){
		patternWebCtrlState(1,true);
		$("#jsPatternStop").attr("disabled",false);
		player.SetPTZControlMode(2);
		ajaxPost("patternForm",function(){});
		setTimeout("StopSetPattern()",200);
	}else if(4 == flag){
		patternWebCtrlState(2,false);
		ajaxPost("patternForm",function(){});	
	}else if(5 == flag){
		
		if($("#jspatternExist").val() == 2){
			
			ajaxPost("patternForm",function(){});
		}else if($("#jspatternExist").val() == 0){
			alert(["Pattern is not setup!","花样扫描未设置!"][LANGUAGE]);
		}
		else{
			alert(["Pattern setup is incomplete!","花样扫描尚未设置完成!"][LANGUAGE]);
		}
	}else if(6 == flag || 7 == flag){
		ajaxPost("patternForm",function(text){
			if( getState(text) ){
				$("#jspatternExist").val(0);
				alert(deletRes[LANGUAGE].succeed);
			}else{
				alert(deletRes[LANGUAGE].fail);
			}
		});
	}
}

var xmlhttp= null;
var timerIDAlarm = null;
var reqTime = 500;
var preCode=0;
var ret = 0;
var count = 0;

function StopSetPattern()
{
	var ix,code=0,stateChange;//加stateChange主要是为了屏蔽IE9上视频闪烁的问题
	var player = document.getElementById("Player");

	try
	{
		$.ajax({url:"/form/patternAjax?patternNum="+$("#jsPatternNum").val(),
				cache:false,
				dataType:"text",
				success:function(data)
				{
						ix=data.indexOf("OK getpatternstatus=");
						if(ix>=0)
						{
							code=data.substring(ix+20,ix+21);
							code=parseInt(code);
							
							stateChange = (code == preCode ? 0 : 1);
							if(stateChange)
							{
								if(code==0)
								{
									patternWebCtrlState(2,false);
									ret = 1;
								}
							}
							else
							{
								if(count > 7200)//底层一直不返回状态给网页做超时处理
								{
									patternWebCtrlState(2,false);
									ret = 1;	
								}
							}
							preCode = code;
		 				 }					
					}
			   });
	}
	catch(e){}
	if(ret)
	{
		stopTimer();
		return;
	}
	count++;
	timerIDAlarm=setTimeout("StopSetPattern()",reqTime);		
}

function stopTimer()
{
	ret = 0;
	count = 0;
	if(timerIDAlarm)
	{
		clearTimeout(timerIDAlarm);
		timerIDAlarm = null;
	}
}
//*************************************************

//******************home return**********************
function initHomeRtn()
{
	$("#jsAutoBackTime").val($("#autoBackTimeGet").val());
	$("#jsAutoBackAct").val($("#autoBackActGet").val());
	$("#jsAutoBackPwOff").val($("#autoBackPwOffGet").val());
		
}

function loadAtpParas(){
	$("#jsTourNum").change();
}
//***************************

//**********************normal tour******************
function tourSubmit(flag){
	$("#jsTourFlag").val(flag);
	if(1 == flag){
		var tourSubmitValue1 = document.getElementById("jsPresetValue").value;
		if((tourSubmitValue1 <= 255) && (tourSubmitValue1 >= 1))
		{
			ajaxPost("tourForm",function(text){
			$("#jsTourExist").val(getState(text)? 1: 0);
			alertRes(text);
			});
		}else {
			document.getElementById("jsPresetValue").value ="";
			alert(["presetNum 1~255!","预置点设置1~255！"][LANGUAGE]);
			return;
		}
	}else/* if(0 == flag||2 == flag||3 == flag||4 == flag||5 == flag)*/{
		if($("#jsTourExist").val() == 1){
			ajaxPost("tourForm",function(text){if(getState(text) == 0) alert(["Failed to call tour!","调用预置点巡视失败!"][LANGUAGE]);},100);
			<!--ajaxPost("tourForm",function(){},100);-->
		}else{
			alert(["Normal tour is not setup!","常规巡视未设置!"][LANGUAGE]);
		}
	}
}

function afEvent(flag)
{
	//alert(flag);
	$("#afTestFlag").val(flag);	
	ajaxPost("afTestForm",function(text){if(getState(text) == 0) alert(["Failed to test!","测试失败!"][LANGUAGE]);},100);
}
//**************************************************

//***********************mask settings**************
function maskSubmit(flag){
	var player = document.getElementById("Player");
	$("#jsMaskFlag").val(flag);
	if(1 == flag)
	{
		if($("#jsmaskEnable").val() == 1)
		{
			$("#PrivacyForm").find("select[id!='jsmaskEnable']").attr("disabled",false);
			ajaxPost("PrivacyForm",function(){});  //revised by hbx 2012-9-10	
		}
		else
		{
			ajaxPost("PrivacyForm",function(){});
			$("#PrivacyForm").find("select[id!='jsmaskEnable']").attr("disabled",true);
		}
	}
	else if(2 == flag||4 == flag)
	{
		ajaxPost("PrivacyForm",function(){});
	}
	else if(5 == flag)
	{
		if($("#jsmaskEnable").val() == 1)
		{
			if($("#jsmaskStatus").val() == 1)
			{
				ajaxPost("PrivacyForm",function(){});
				$("#MaskCenter").css("display","block");
				$("#StartMask").css("display","none");
				$("#MaskOK").css("display","none");
				$("#ChooseCenter").css("display","block");
				$("#PrivacyForm").find("select[id^='jsmask']").attr("disabled",true);
				player.EnableVectorControl(true);
				player.SetPTZControlMode(2);
				player.EnableVectorControl(false);	
			}
			else
			{
				alert(["Please open mask number"+($("#jsmaskNo").val()),"请先打开"+($("#jsmaskNo").val())+"号隐私块"][LANGUAGE]);
			}
		}
		else
		{	
			alert(["Please enable mask first!","请先打开总开关"][LANGUAGE])
		}
	}
	else if(6 == flag)
	{
		ajaxPost("PrivacyForm",function(){});
		$("#MaskCenter").css("display","none");
		$("#StartMask").css("display","none");
		$("#MaskOK").css("display","block");
		$("#ChooseCenter").css("display","none");
		$("#SizeSet").css("display","block");	
	}
	else if(7 == flag)
	{
		ajaxPost("PrivacyForm",function(){});
		$("#MaskCenter").css("display","none");
		$("#StartMask").css("display","block");
		$("#MaskOK").css("display","none");
		$("#ChooseCenter").css("display","none");
		$("#SizeSet").css("display","none");
		$("#PrivacyForm").find("select[id^='jsmask']").attr("disabled",false);
		player.EnableVectorControl(true);
	}
}

function initMaskInfo()
{
	var i,tempStr="";
	
	var temp = parent.leftFrame.document.getElementById("jsCamInfo").value;	
	var camera_model = getCameraMode(temp,2,9);

	if((camera_model == "0000001")||(camera_model == "0000010")||(camera_model == "0000011")||(camera_model == "0000100")||(camera_model == "0000101")||(camera_model == "0000110"))
	{
		tempStr = "";
		tempStr += "<option value='0'>" + initStr[LANGUAGE].black + "</option>";
		tempStr += "<option value='1'>" + initStr[LANGUAGE].gray + "</option>";
		tempStr += "<option value='2'>" + initStr[LANGUAGE].white + "</option>";
		tempStr += "<option value='3'>" + initStr[LANGUAGE].red + "</option>";
		tempStr += "<option value='4'>" + initStr[LANGUAGE].green + "</option>";
		tempStr += "<option value='5'>" + initStr[LANGUAGE].blue + "</option>";
		tempStr += "<option value='6'>" + initStr[LANGUAGE].yellow + "</option>";
		tempStr += "<option value='7'>" + initStr[LANGUAGE].magenta + "</option>";
		$("#jsmaskColor").html(tempStr);

		tempStr = "";
		for(i=1;i<5;i++)
		{
			tempStr += "<option value='" + i + "'>" +  i + "</option>";
		}
	}
	else if(camera_model == "0100000")
	{
		tempStr = "";
		tempStr = "<option value='0'>" + initStr[LANGUAGE].black + "</option>";
		$("#jsmaskColor").html(tempStr);

		tempStr = "";
		for(i=1;i<16;i++)
		{
			tempStr += "<option value='" + i + "'>" +  i + "</option>";
		}
	}
	else
	{
		tempStr = "";
		tempStr += "<option value='0'>" + initStr[LANGUAGE].black + "</option>";
		for(var i=1;i<7;i++){
			tempStr += "<option value='" + i + "'>" + initStr[LANGUAGE].gray + "i" + "</option>";
		}
		tempStr += "<option value='7'>" + initStr[LANGUAGE].white + "</option>";
		tempStr += "<option value='8'>" + initStr[LANGUAGE].red + "</option>";
		tempStr += "<option value='9'>" + initStr[LANGUAGE].green + "</option>";
		tempStr += "<option value='10'>" + initStr[LANGUAGE].blue + "</option>";
		tempStr += "<option value='11'>" + initStr[LANGUAGE].cyan + "</option>";
		tempStr += "<option value='12'>" + initStr[LANGUAGE].yellow + "</option>";
		tempStr += "<option value='13'>" + initStr[LANGUAGE].magenta + "</option>";
		$("#jsmaskColor").html(tempStr);

		tempStr = "";
		for(i=1;i<25;i++)
		{
			tempStr += "<option value='" + i + "'>" +  i + "</option>";
		}
	}
	$("#jsmaskNo").html(tempStr);
	$("#jsmaskNo")[0].selectedIndex = 0;
	
	setTimeout("initMaskPara()",100);
}

function initMaskPara()
{
	$("#jsmaskEnable").val($("#maskEnable_ws").val());
	$("#jsmaskColor").val($("#maskColor_ws").val());
	$("#jsmaskStatus").val($("#maskStatus_ws").val());
	initMaskState();
}
function initMaskState()
{
	$("#PrivacyForm").find("select[id!='jsmaskEnable']").attr("disabled",$("#jsmaskEnable").val() == 1?false:true);
	if(!IsSuperUser())
	{
		disabledAll();
	}
	
}
function maskPosition()
{
	$("#jsMaskFlag1").val(9);
	$("#PrivacyForm1").submit();
}
//**********************************************

//************special function ********************
function SpecialFuncSubmit(flag)
{
	$("#jsSpecialFuncFlag").val(flag);
	if(flag == 2)
	{
		LaserEnable_select();
	}
	else if(flag == 6)
	{
		IRLampEnable_select();	
	}	
	$("#SpecialFuncForm").submit();
}

function initLaserPara()
{
	$("#jsLaserEnable").val($("#LaserEnable_ws").val());
	LaserEnable_select();
	$("#jsLaserSentivity").val($("#LaserSentivity_ws").val());	
}

function LaserEnable_select()
{
	if($("#jsLaserEnable").val()==2)
	{
		$("#jsLaserSentivity").attr("disabled",false);
	}
	else
	{
		$("#jsLaserSentivity").attr("disabled",true);
	}
	if($("#jsLaserEnable").val()==1)
	{
		$("#SpecialFuncForm").find("input[id^='jsLaserLight']").attr("disabled",false);
	}
	else
	{
		$("#SpecialFuncForm").find("input[id^='jsLaserLight']").attr("disabled",true);
	}
}

function initIRLampPara()
{
	$("#jsIRLampEnable").val($("#IRLampEnable_ws").val());
	IRLampEnable_select();
	$("#jsIRLampSentivity").val($("#IRLampSentivity_ws").val());	
}

function IRLampEnable_select()
{
	if($("#jsIRLampEnable").val()==2)
	{
		$("#jsIRLampSentivity").attr("disabled",false);
	}
	else
	{
		$("#jsIRLampSentivity").attr("disabled",true);
	}
}
//***************************************

//************special Function**************
function ptzSpecialSubmit(flag)
{
	$("#PTZSpecialFlag").val(flag);
	$("#ptzSpecialForm").submit();
	if(parseInt(flag) == 5)
	{
		var dialog = new Dialog();
		var dialogStr=["Please wait...  ","请稍候...  "];
		$("#videoWin").hide();
		dialog.show(45,dialogStr[Language],"", function(){location.reload(true);});
	}
}

function initPTZSpecialPara()
{
	$("#cameraAddr").val($("#cameraAddr_ws").val());
	$("#protocol").val($("#protocol_ws").val());
	$("#baudRate").val($("#baudRate_ws").val());
	$("#protocol3D").val($("#protocol3D_ws").val());
	$("#rs485transEnable").val($("#rs485transEnable_ws").val());
	$("#userMode").val($("#userMode_ws").val());

	//$("#workMode").val($("#workMode_ws").val());
	//$("#tiltWorkMode").val($("#tiltWorkMode_ws").val());
	
	//$("#protocol").attr("disabled",true);
//	if($("#CtrlbyhardFlag_ws").val()==1)
//	{
//		$("#cameraAddr").attr("disabled",true);
//	}
//	else if($("#CtrlbyhardFlag_ws").val()==2)
//	{
//		$("#baudRate").attr("disabled",true);
//	}
//	else if($("#CtrlbyhardFlag_ws").val()==3)
//	{
//		$("#baudRate").attr("disabled",true);
//		$("#cameraAddr").attr("disabled",true);
//	}
//	else
//	{
//		$("#cameraAddr").attr("disabled",false);
//		$("#baudRate").attr("disabled",false);
//	}
}

function initPTZPowerModePara()
{
	$("#powerMode").val($("#powerMode_ws").val());
}

function runPlayer(){
	try{
		var player = document.getElementById("Player");
		//var ipAddr =window.location.toString().match(/\d+\.\d+\.\d+\.\d+/);
		var ipAddr =window.location.hostname;
		player.RunPlayEx(ipAddr.toString(),0,"0.0.0.0",2,90,0,"admin","admin");
	}catch(e){
		setTimeout(arguments.callee,500);
	}
	player.EnableVectorControl(true);
}

/* justin add for BSD start 2013.9.14 */
function callAtp()
{
	$("#jsAutopanFlag").val(2);
	$("#autopanForm").submit();
}

function callPtn()
{
	$("#jspatternFlag").val(3);
	$("#patternForm").submit();
}

/* justin add for BSD end 2013.9.14 */

function PTZAjaxPost(formID,formPara,hander,waitSec){
	var formObj = "string"==(typeof formID)? $("#"+formID) : $(formID);
	var hander = "function" == (typeof hander)?  hander: alertRes;
	var waitSec = "number" == (typeof waitSec)? waitSec: 50000;
	var time = new Date();
	$.ajax({type:'POST',url:formObj.attr("action")+"?_="+time.getTime(),data:formPara,dataType:"text",success:hander,timeout:waitSec});
}
function rs485trans_recv()
{
	PTZAjaxPost("rs485recvForm","",function(data){$("#recvtext").val(data.toString());});
}
function rs485trans_send()
{
	$("#rs485transForm").submit();
	setTimeout("rs485trans_recv()",200);
	//rs485trans_recv();
}
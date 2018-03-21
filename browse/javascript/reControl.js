var DevStatus=[{state1:"Normal",state0:"Disconnected"},{state1:"正常",state0:"断开"}];
var WriteProtected=[{state1:"On",state0:"Off"},{state1:"开",state0:"关"}];
var DIALOG = null;
function reControlInit(){
	LANGUAGE = parseInt($("#PAGE_LANGUAGE").val());
	var idArray = ["SDMode","SDStart","NLostRecord","SDStreamType"];
	var dataGet,tmp;
	for(var i = 0; i < idArray.length; i++){
		dataGet = $("#"+idArray[i]+"Get").val();
		$("#"+idArray[i]+dataGet).click();
	}
	if(parseInt($("#Hi3519").val()) == 0 && parseInt($("#Hi3516A").val()) == 0 && parseInt($("#Hi3518EV200").val()) != 2 && parseInt($("#Hi3516C").val()) == 0)
	{
		$("#SDStreamType0,#SDStreamType1").attr("disabled",true);
	}
	dataGet = $("#DevStatusGet").val();
	$("#DevStatus").text(DevStatus[LANGUAGE]['state'+dataGet]);
	$("#SDMount"+dataGet).css("display","inline");
	$("#SDMount"+(1-dataGet)).css("display","none");
	dataGet = $("#WriteProtectedGet").val();
	$("#WriteProtected").text(WriteProtected[LANGUAGE]['state'+dataGet]);
	dataGet = parseInt($("#usedSpace").text());
	$("#usedSpace").text(spaceVal(dataGet));
	dataGet = parseInt($("#totalSpace").text());
	$("#totalSpace").text(spaceVal(dataGet));

	$("#SDControlDiv").css("display","block");
	sysShow('hankClass',0);
	if(!IsSuperUser()){
		disabledAll();
	}
	$(document).contextmenu(function(){return false});
	if($("#UsdUsb").val() == "1")
	{
		$("#jsSDfull").html(LANGUAGE==1?"U盘录满:":"U-Disk Full:");
		$("#jsSDStatus").html(LANGUAGE==1?"U盘状态:":"U-Disk Status:");
		$("#jsSDOperation").html(LANGUAGE==1?"U盘操作:":"U-Disk Operation:");
	}
}

function spaceVal(val){
	var dataGet, tmp;
	dataGet = parseInt(val);
	dataGet = isNaN(dataGet)? 0:dataGet;
	if(dataGet > 1048576){
		tmp = dataGet%1048576;
		dataGet = dataGet/1048576;
		dataGet = tmp?dataGet.toFixed(2):dataGet;
		dataGet += "GB";
	}else if(dataGet > 1024){
		tmp = dataGet%1024;
		dataGet = dataGet/1024;
		dataGet = tmp?dataGet.toFixed(2):dataGet;
		dataGet += "MB";
	}else{
		dataGet += "KB";
	}
	return dataGet;
}

function fSDSet(){
	ajaxPost("SDControlForm");
}

function fSDState(text){
	var dataGet = responseGetVar(text,"DevStatus");
	$("#DevStatus").text(DevStatus[LANGUAGE]['state'+dataGet]);
	dataGet = responseGetVar(text,"WriteProtected");
	$("#WriteProtected").text(WriteProtected[LANGUAGE]['state'+dataGet]);
	dataGet = parseInt(responseGetVar(text,"UsedSpace"));
	$("#usedSpace").text(spaceVal(dataGet));
	dataGet = parseInt(responseGetVar(text,"TotalSize"));
	$("#totalSpace").text(spaceVal(dataGet));
}

function fSDControl(flag){
	var formatDmd = ["Unmount SD card before formatting.","格式化前须卸载SD Card."];
	var formatCfm = ["Formatting SD card will delete all data.\nContinue?","格式化会删除所有数据.\n确定要格式化SD Card吗?"];
	var unmountCfm = ["Are you sure to unmount SD card? Unmounting it will stop recording.","确定卸载SD Card吗？确定，则SD Card停止录像!"];
	var resultStr0 = [{succeed:"Unmount succeeded!",failed:"Unmount failed!"},{succeed:"卸载成功!",failed:"卸载失败!"}];
	var resultStr1 = [{succeed:"Mount succeeded!",failed:"Mount failed!"},{succeed:"挂载成功!",failed:"挂载失败!"}];
	var resultMount = [resultStr0,resultStr1];
	var resultFormat = [{succeed:"Format succeeded!",failed:"Format failed!"},{succeed:"格式化成功!",failed:"格式化失败!"}];
/*	var dialogStr=["Please wait...","请稍候..."];
	var dialogSec = ["",""];
	var refreshHander = function(){window.location.reload(true)};*/
	if(1==flag || (0==flag)){
		if(1==flag || confirm(unmountCfm[LANGUAGE])){
			DIALOG = DIALOG? DIALOG:new Dialog();
			DIALOG.loading(1);
			var waitTime = 25000;
			$("#SDCtrlFlag").val(2);
			$("#SDMountPara").val(flag);
			ajaxPost("SDDeviceForm",function(text){
				DIALOG.loading(0);
/*				DIALOG.show(5,dialogStr[LANGUAGE],dialogSec[LANGUAGE],refreshHander);*/
				var state = getState(text);
				if(state){
					$("#SDMount"+flag).css("display","inline");
					$("#SDMount"+(1-flag)).css("display","none");
					fSDState(text);
					alert(resultMount[flag][LANGUAGE]["succeed"]);
				}else{
					alert(resultMount[flag][LANGUAGE]["failed"]);
				}
			},function(){DIALOG.loading(0);alertError();},waitTime);
		}
	}else if(2 == flag){
		if($("#SDMount1:visible").val()){
			alert(formatDmd[LANGUAGE]);
		}else if(confirm(formatCfm[LANGUAGE])){
			$("#SDCtrlFlag").val(3);
			DIALOG = DIALOG? DIALOG:new Dialog();
			DIALOG.loading(1);
			var waitTime = 25000;
			ajaxPost("SDDeviceForm",function(text){
				var state = getState(text);
				DIALOG.loading(0);
/*				DIALOG.show(15,dialogStr[LANGUAGE],dialogSec[LANGUAGE],refreshHander);*/
				if(state){
					$("#SDMount0").css("display","inline");
					$("#SDMount1").css("display","none");
					fSDState(text);
					alert(resultFormat[LANGUAGE]["succeed"]);
				}else{
					alert(resultFormat[LANGUAGE]["failed"]);
				}
			},function(){DIALOG.loading(0);alertError();},waitTime);
		}
	}
}


function replayerInit()
{
	try{
//		alert($("#httpPort").val()+ " " +$("#rtspPort").val());
		var srcIP=location.hostname;
		document.getElementById("replay").InitPlayModule(2);
		//document.getElementById("replay").SetLoginParam(srcIP,'admin','admin');		//justin changed 2013.6.27
		//document.getElementById("replay").SetLoginParamEx(srcIP,'admin','admin',$("#httpPort").val(),$("#rtspPort").val());		//2014.04.12
		document.getElementById("replay").SetLoginParamEx2(srcIP,'admin','admin',$("#httpPort").val(),$("#rtspPort").val(),$("#recordPort").val());
	}
	catch(err)
	{
		setTimeout(arguments.callee,800);
	}
}

function replayerLang()
{	
	try{
		document.getElementById("replay").SetLanguage(0);
	}
	catch(err)
	{
		
	}
}
function stopPlay()
{	
	try{
		document.getElementById("replay").StopPlayback();
	}
	catch(err)
	{
		
	}
}


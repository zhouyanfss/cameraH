// JavaScript Document
var TIME_ZONE = [
	{
	t0: "GMT-12:00",
	t1: "GMT-11:00",
    t2: "GMT-10:00",
    t3: "GMT-09:00",
    t4: "GMT-08:00",
	t5: "GMT-07:00",
	t6: "GMT-06:00",
	t7: "GMT-05:00",
	t8: "GMT-04:00",
	t9: "GMT-03:30",
	t10: "GMT-03:00",
	t11: "GMT-02:00",
	t12: "GMT-01:00",
	t13: "GMT",
	t14: "GMT+01:00",
	t15: "GMT+02:00",
	t16: "GMT+03:00",
	t17: "GMT+03:30",
	t18: "GMT+04:00",
	t19: "GMT+04:30",
	t20: "GMT+05:00",
	t21: "GMT+05:30",
	t22: "GMT+05:45",
	t23: "GMT+06:00",
	t24: "GMT+06:30",
	t25: "GMT+07:00",
	t26: "GMT+08:00",
	t27: "GMT+09:00",
	t28: "GMT+09:30",
	t29: "GMT+10:00",
	t30: "GMT+11:00",
	t31: "GMT+12:00",
	t32: "GMT+13:00"
	},
	{
	t0: "GMT-12:00",
	t1: "GMT-11:00",
    t2: "GMT-10:00",
    t3: "GMT-09:00",
    t4: "GMT-08:00",
	t5: "GMT-07:00",
	t6: "GMT-06:00",
	t7: "GMT-05:00",
	t8: "GMT-04:00",
	t9: "GMT-03:30",
	t10: "GMT-03:00",
	t11: "GMT-02:00",
	t12: "GMT-01:00",
	t13: "GMT",
	t14: "GMT+01:00",
	t15: "GMT+02:00",
	t16: "GMT+03:00",
	t17: "GMT+03:30",
	t18: "GMT+04:00",
	t19: "GMT+04:30",
	t20: "GMT+05:00",
	t21: "GMT+05:30",
	t22: "GMT+05:45",
	t23: "GMT+06:00",
	t24: "GMT+06:30",
	t25: "GMT+07:00",
	t26: "GMT+08:00",
	t27: "GMT+09:00",
	t28: "GMT+09:30",
	t29: "GMT+10:00",
	t30: "GMT+11:00",
	t31: "GMT+12:00",
	t32: "GMT+13:00"
	}];
//时区对应关系
var TIME_DIFF={
	"-720": 0, "-660": 1, "-600": 2, "-540": 3, "-480": 4, "-420": 5,  "-360": 6,
	"-300": 7, "-240": 8, "-210": 9, "-180": 10, "-120": 11, "-60": 12, "0": 13,
	"60": 14,  "120": 15,  "180": 16, "210": 17, "240": 18, "270": 19, "300": 20, 
	"330": 21, "345": 22, "360": 23, "390": 24, "420": 25, "480": 26, "540": 27, 
	"570": 28, "600": 29, "660": 30, "720": 31, "780": 32
};

var SWITCH_STATE = [{s0: "Disable",s1: "Enable"},{s0: "禁用",s1: "开启"}];
var ALARM_CONT = [{c0: "Network relay",c1: "Local relay"},{c0: "网络关联",c1: "本地关联"}];
var typeError = [{empty:"Please select a file!\n", wrong:"Please select a file of correct type!\n", large:"Selected file is too large!\n"},
							   {empty:"请选择文件!\n", wrong:"请选择正确格式的文件!\n", large:"选择的文件太大!\n"}];
var MACHINE_TIME = 0;//设备时间，单位为毫秒
var DIALOG = null;//全屏禁用的对话框
var gTimeGetID = 0;
var chipID = top.topFrame.document.getElementById('chipIDGet').value;

/*formName定义的form地址，如“/form/getTime”，funHander为处理函数，包含一个参数，即请求成功后返回的字符*/
function ajaxGetData(formName,funHander){
	var time = new Date();
	$.get(formName.toString()+"?_="+time.getTime(),{},funHander, "text");
}

function show(num){
	var imag = $('.closepic');
	var menu = $('.sonHank');

	if(menu[num].style.display != "none"){
		menu[num].style.display = "none";
		imag[num].src = "../images/nolist.gif";
	}
	else{
		menu[num].style.display = "";
		imag[num].src = "../images/list.gif";
	}
}

function timeShow(locTimeID,eqTimeID){
		var pcTime = new Date();
		var pcTimems = pcTime.getTime();
		var eqTime = new Date(MACHINE_TIME);
		var getTimeString=function(dateObj,TZorUTC){
			if(TZorUTC){
				var year = dateObj.getFullYear();
				var month = dateObj.getMonth()+1;
				var day = dateObj.getDate();
				var hour = dateObj.getHours();
				var mins = dateObj.getMinutes();
				var secs = dateObj.getSeconds();
			}else{
				var year = dateObj.getUTCFullYear();
				var month = dateObj.getUTCMonth()+1;
				var day = dateObj.getUTCDate();
				var hour = dateObj.getUTCHours();
				var mins = dateObj.getUTCMinutes();
				var secs = dateObj.getUTCSeconds();
			}
			month = 10>month? "0"+month : month;
			day 	   = 10>day     ? "0"+day     : day;
			hour    = 10>hour   ? "0"+hour    : hour;
			mins    = 10>mins  ? "0"+mins   : mins;
			secs    = 10>secs   ? "0"+secs    : secs;
			return year+"-"+month+"-"+day+"  "+hour+":"+mins+":"+secs;
		}
		$("#"+locTimeID).text(getTimeString(pcTime, 1));
		$("#"+eqTimeID).text(getTimeString(eqTime, 0));
		MACHINE_TIME += 1000;
}

/*function synModeChanged(obj){
	num = !Boolean(parseInt($(obj).val()));
	$("#jsNTPIP").attr( "disabled",num );
	if(num){
		$("#jsNTPserDiv").css("display", "none");
		$("#jsPCtimeDiv").css("display", "inline-block");
		$(obj.form).attr("action", "/form/CameraTimeSet");
	}else{
		$("#jsNTPserDiv").css("display", "inline-block");
		$("#jsPCtimeDiv").css("display", "none");
		$(obj.form).attr("action", "/form/NTPSet");
	}	
}*/

function udateTimeDif(text){
	var camTime = text.match(/\-*\d+/);
	if(camTime)
		MACHINE_TIME=parseInt(camTime,10);
}

function sysSetInit(){
	var dataGet, domObj, dataShow, temp;
	//页面语言初始化
	LANGUAGE = parseInt($("#PAGE_LANGUAGE").val());
	var deviceID = top.topFrame.document.getElementById('deviceIDGet').value;
	var devicdInt = parseInt(deviceID);

	if(parseInt($("#Hi3518E").val()) == 1 || chipID == 3)
		$("#MjpegInfoLabel1,#MjpegInfoLabel2").hide();
	else if(parseInt($("#Hi3518EV200").val()) == 3)
		$("#MinorStreamInfoLabel1,#MinorStreamInfoLabel2,#MjpegInfoLabel1,#MjpegInfoLabel2").hide();
	
	/*系统设置页时区显示*/
	domObj = $("#jsHankTimeZone");
	dataGet = domObj.text();
	domObj.text(TIME_ZONE[LANGUAGE]['t'+dataGet]);
	domObj.css("visibility", "inherit");	
	
	/*MAC地址变大写*/
	domObj = $("#jsSysHankMAC");
	dataGet = domObj.text();
	domObj.text(dataGet.toLocaleUpperCase());
	domObj.css("visibility", "inherit");	
	
	/*报警关联显示*/
	/*domObj = $("#jsHankAlarmState");
	dataGet = domObj.text();
	domObj.text(ALARM_CONT[LANGUAGE]['c'+dataGet]);
	domObj.css("visibility", "inherit");*/
	
	/*NTP状态显示*/
/*	domObj = $("#jsHankNTPState");
	dataGet = domObj.text();
	domObj.text(SWITCH_STATE[LANGUAGE]['s'+dataGet]);
	domObj.css("visibility", "inherit");*/
	if(parseInt($("#Hi3518EV200").val()) == 0 && parseInt($("#Hi3516CV300").val()) == 0) {
		$("#payloadContent").hide();
		$("#extPayloadContent").hide();
	}
	var payloadtext = parseInt($("#payloadType").val())?"H.265":"H.264";
	if(parseInt($("#bitRateControl").val()) == 0) {
		payloadtext += "+";
	}
	$("#jsMainPayload").text(payloadtext);

	var extpayloadtext = parseInt($("#extPayloadType").val())?"H.265":"H.264";
	if(parseInt($("#ExtBitRateControl").val()) == 0) {
		extpayloadtext += "+";
	}
	$("#jsExtPayload").text(extpayloadtext);

	var resolution = {"10":"1920x1080", "14":"1280x1024", "8":"1280x960", "5":"1280x720", "26":"1024x768", "31":"2304x1296", "32":"2592x1520", "33":"2592x1944","12":"2048x1536", 
				  "27":"800x600", "16":"720x576", "17":"720x480", "6":"640x480","2":"352x288", "25":"352x240", "24":"480x360","28":"320x240","1":"176x144","30":"1920x540", "34":"3840x2160"};
	var bitRateControl = ["VBR(upper limit: ","可变码率(上限: "];
	var videoState = ["Closed","关闭"];
	/*主码流参数显示*/
	domObj = $("#jsMainResol");//分辨率
	dataGet = domObj.text();
	domObj.text(resolution[dataGet]);
	domObj.css("visibility", "inherit");

	domObj = $("#jsMainBitRate");//码率
	dataGet = parseInt(domObj.text()/1000) + "Kbps";
	temp = $("#bitRateControl").val();
	dataGet = parseInt(temp)? dataGet: (bitRateControl[LANGUAGE]+dataGet+")");
	domObj.text(dataGet);
	domObj.css("visibility", "inherit");
	
	/*副码流参数显示*/
	domObj = $("#jsExtResol");//分辨率
	dataGet = domObj.text();
	domObj.text("0"==dataGet? videoState[LANGUAGE]: resolution[dataGet]);
	domObj.css("visibility", "inherit");

	domObj = $("#jsExtBitRate");//码率
	temp = domObj.text();
//	if( 7 > temp.length){
		dataGet = parseInt(temp/1000) + "Kbps";
//	}else{
//		dataGet = temp.replace(/\d{6}$/,'') + "M";
//	}
	temp = $("#ExtBitRateControl").val();
	dataGet = parseInt(temp)? dataGet: (bitRateControl[LANGUAGE]+dataGet+")");
	domObj.text(dataGet);
	domObj.css("visibility", "inherit");
	
	/*MJPEG参数显示*/
	domObj = $("#jsMJPEGResol");//分辨率
	dataGet = domObj.text();
	domObj.text("0"==dataGet? videoState[LANGUAGE]: resolution[dataGet]);
	domObj.css("visibility", "inherit");
	
	$("#firstPage").css("display", "block");
	
	dataGet = $("#timeZone").val();
	$("#jsTimeZone").val(dataGet);
	
	dataGet = Boolean( parseInt($("#SummerMode").val()) );
	if(dataGet){
		$("#jsSummerMode1").attr( "checked", true);
	}else{
		$("#jsSummerMode0").attr( "checked", true);
	}
	
//	dataGet = $("#synFormat").val().match(/\d{1}/);
//	$("#jsSynFormat"+dataGet).click();
	synNTPreset();
	focusSet("jsSynHour",23);
	focusSet("jsSynMin",59);
	focusSet("jsSynSec",59);
	
/*	var deviceID = getCookie("dev");
	if(deviceID && deviceID.match(/^([0-389])$/)){
		$("#domeUpDiv").css("display","block");
	}*/
	
	if(!IsSuperUser()){
		disabledAll();
		$(".setExplain").attr("disabled", true);
		$(".setExplainEN").attr("disabled", true);
		$("#equiTime").attr("disabled", true);
		$("#loctime").attr("disabled", true);
		$("label[name='jsUploadTip']").attr("disabled", true);
		
	}
	
	ajaxGetData("/cgi/GetCameraTime",function(text){udateTimeDif(text);timeShow("loctime","equiTime");});
	gTimeGetID = setInterval(function(){
		ajaxGetData("/cgi/GetCameraTime",udateTimeDif)},60000);
	
	$(document).contextmenu(function(){return false});//屏蔽右键
	setTimeout(function(){
		DIALOG = new Dialog();
		if(DIALOG.error)
			setTimeout(arguments.callee,200);
	},300);
	setInterval(function(){timeShow("loctime","equiTime");},1000);
}

function focusSet(id,maxVal){
	var DOMobj = $("#"+id);
	DOMobj.focus(function(){
		$(document).mousewheel(function(ev, delta, deltaX, deltaY){
			var val = parseInt(DOMobj.val(),10);
			val = isNaN(val)? 0: val;
			val += delta;
			val = val > maxVal? 0: val;
			val = val < 0? maxVal: val;
			val = val < 10? "0"+val: val;
			DOMobj.val(val);
			return false;
		});
	});
	DOMobj.blur(function(){
		var DOMobj = $(this);
		var val = parseInt(DOMobj.val(),10);
		val = isNaN(val)? 0: val;
		val = val > maxVal? maxVal: val;
		val = val < 0? 0: val;
		val = val < 10? "0"+val: val;
		DOMobj.val(val);
		$(document).unbind("mousewheel");
	});
}

function timezoneSet(){
	ajaxPost("jsTimezoneForm", function(text){
		var TIME_ZONE_SET = [{succeed:"Timezone setting succeeded!", failed:"Timezone setting failed!"},{succeed:"时区设置成功！", failed:"时区设置失败"}];
		var state = getState(text);
		if(state){
			var temp = $("#jsTimeZone").val();
			$("#jsHankTimeZone").text(TIME_ZONE[LANGUAGE]['t'+temp]);
			alert(TIME_ZONE_SET[LANGUAGE].succeed);
			$("#timeZone").val($("#jsTimeZone").val());
			$("#SummerMode").val($("input[name='daylightenable']:checked").val());
			ajaxGetData("/cgi/GetCameraTime",udateTimeDif);
		}else{
			alert(TIME_ZONE_SET[LANGUAGE].failed);
		}
	});
}

function synNTPsubmit(){
	/*
	var dataGet = IPcheck( $("#jsNTPIP").val() );
	if(0===dataGet  || ''===dataGet || 1===dataGet){
		var errorArray = ["Invalid IP. Correct format is xxx.xxx.xxx.xxx (xxx must be within 0~255)\n",
									"IP地址格式错误：正确格式为xxx.xxx.xxx.xxx (xxx 0~255且不能全为0)\n"];
		alert(errorArray[LANGUAGE]);
	}else{
	*/
		var dataGet = $("#jsNTPIP").val();
		ajaxPost("synNTPForm", function(text){
			$("#jshankNTPIP").text(dataGet);
			$("#jsHankNTPState").text(SWITCH_STATE[LANGUAGE]["s1"]);
			var stateArray=[{succeed:"NTP setting succeeded!", failed:"NTP setting failed!"},
						   {succeed:"NTP设置成功!", failed:"NTP设置失败!"}];
			var state = getState(text);
			var alertStr = '';
			if(state){
				alertStr = stateArray[LANGUAGE].succeed;
				$("#NTPIP").val($("#jsNTPIP").val());
				$("#synHourGet").val($("#jsSynHour").val());
				$("#synMinGet").val($("#jsSynMin").val());
				$("#synSecGet").val($("#jsSynSec").val());
				$("#synIntervalGet").val($("#jsSynInterval").val());
				if ($("#jsNTPEnable1").prop("checked")) {
   					$("#jsNTPSyn").attr("disabled", false);
				}else{
					$("#jsNTPSyn").attr("disabled", true);
				}
			}else{
				alertStr = stateArray[LANGUAGE].failed;
			}
			alert(alertStr);
			ajaxGetData("/cgi/GetCameraTime",udateTimeDif);
		});
	/*
	}
	*/
}

function timeSynNow(type){
	var requestUrl = type == "NTP" ? "/form/NTPSet": "/form/CameraTimeSet";
	var pcTime = new Date();
	var timezone = parseInt(- pcTime.getTimezoneOffset());
	var Tzone = TIME_DIFF[timezone.toString()];
	$.ajax({type:'GET',url:requestUrl+"?flag=2&Tzone="+Tzone+"&localtime="+pcTime.getTime(),dataType:"text",timeout:10000,error:alertError,success:function(text){
		var stateArray = [{succeed:"Time sync succeeded!", failed:"Time sync failed!"},
									{succeed:"时间同步成功!", failed:"时间同步失败!"}];
		var state = getState(text);	
		if(state){
			if("PC" == type){
				$("#jsSummerMode0").click();
				$("#jsHankTimeZone").text(TIME_ZONE[LANGUAGE]["t"+Tzone]);
				$("#jsTimeZone").val(Tzone);
			}
			alert(stateArray[LANGUAGE].succeed);
		}else{
			alert(stateArray[LANGUAGE].failed);
		}
		ajaxGetData("/cgi/GetCameraTime",udateTimeDif);
	}});
}

function timeSYNC(){
	var pcTime = new Date();
	var timezone = parseInt(- pcTime.getTimezoneOffset());
	var Tzone = TIME_DIFF[timezone.toString()];
	$.ajax({type:'POST',url:"/form/CameraTimeInit",data:"flag=2&Tzone="+Tzone+"&localtime="+pcTime.getTime()});
}

function fileUpload(){
	var flag = 0;
	var alertStr = '';
	var filePath = $("#jsUpdateFile").val();
	var fileTypeDOM = $("#jsUpdateType");
	if(!filePath){
		flag = 1;
		alertStr += typeError[LANGUAGE].empty;
	}else{
		var pathLowerCase = filePath.toLocaleLowerCase();
		var typeAllow = [".ifu", ".ifw", "macaddr.txt", "deviceid.txt", "sn.txt", "audio.dat", ".bin", ".png", ".ifc", ".lib", ".uid", ".pid", ".tid", ".eid",".elinfo","logo.gif","whitelist.txt",".did"];
		var fileType = ["ifu", "ifw", "mac", "deviceid", "sn", "audio", "bin", "png", "ifc", "lib", "uid", "pid","tid","eid","elinfo","gif","wlst","did"];
		for(var i = 0; i < typeAllow.length; i++){
			if(pathLowerCase.lastIndexOf(typeAllow[i]) !=-1){
				break;
			}
		}
		if( i == typeAllow.length){
			flag = 1;
			alertStr += typeError[LANGUAGE].wrong;
		}else{
			fileTypeDOM.val(fileType[i]);
		}
	}
	
	if($("#jsConfigkeep").is(":checked")){
		$("#jsUpdateReset").val(1);
	}
	var maxSize = 10*1024*1024;
	var maxSize_E = 7*1024*1024;
	var  browserCfg = {};  
    var ua = window.navigator.userAgent;  
    if (ua.indexOf("MSIE")>=1){  
        browserCfg.ie = true;  
    }else if(ua.indexOf("Firefox")>=1){  
        browserCfg.firefox = true;  
    }else if(ua.indexOf("Chrome")>=1){  
        browserCfg.chrome = true;  
    }  

	try{
		var obj_file = document.getElementById("jsUpdateFile"); 
		var fSize = 0;  
        if(browserCfg.firefox || browserCfg.chrome ){  
            fSize = obj_file.files[0].size;  
        }else if(browserCfg.ie){  
            var fso=new ActiveXObject("Scripting.FileSystemObject"); 
			var fObj = fso.GetFile(filePath);
            fSize = fObj.size;
        } 
       
		if(fSize > maxSize && !flag){
			flag = 1;
			alertStr += typeError[LANGUAGE].large;
		}
		if(parseInt($("#Hi3518E").val()) == 1)
		{
			if(fSize > maxSize_E && !flag){
				flag = 1;
				alertStr += typeError[LANGUAGE].large;
			}
		}

	}catch(e){};
	
	if(flag){
		alert(alertStr);
	}else if(fileTypeDOM.val()=="mac" || confirm(["System will reboot after this operation.\nPlease donot close or refresh the webpage.\nContinue?\n","操作完成后，系统将重启。\n上传过程中请勿关闭或刷新网页。\n继续?\n"][LANGUAGE])){
//		DIALOG = DIALOG? DIALOG: new Dialog();
		var dialog = DIALOG;
		dialog.loading(1);
//		top.frames[0].document.getElementById("lanSelect").style.visibility="hidden";
		iframeFun = iframeSoftUp;
		if(fileTypeDOM.val()=="ifu" || fileTypeDOM.val()=="ifw"){
			$.post('/form/killAppForm',function(text){
					var state = getState(text);
					if(state){
						setTimeout("$('#updateForm').submit();",2000);
					}
									   },'text');
		}
		else{
			$("#updateForm").submit();
		}
	}
}

function timezoneReset(){
	$("#jsTimeZone").val($("#timeZone").val());
	if(parseInt($("#SummerMode").val())){
		$("#jsSummerMode1").attr("checked", true);
	}else{
		$("#jsSummerMode0").attr("checked", true);
	}
}

function synNTPreset(){
	var timeVal = function(id){
		var val = parseInt($("#"+id).val(),10);
		val = val < 10? "0"+val: val;
		return val;
	}
	$("#jsNTPIP").val($("#NTPIP").val());
	$("#jsSynHour").val(timeVal("synHourGet"));
	$("#jsSynMin").val(timeVal("synMinGet"));
	$("#jsSynSec").val(timeVal("synSecGet"));
	$("#jsSynInterval").val($("#synIntervalGet").val());

	if(parseInt($("#NTPEnableGet").val())){
		$("#jsNTPEnable1").attr("checked", true);
		$("#jsNTPSyn").attr("disabled", false);
	}else{
		$("#jsNTPEnable0").attr("checked", true);
		$("#jsNTPSyn").attr("disabled", true);
	}
	timeVal = null;
}

function recoverSet(){
	var confirmStr=["This operation will restore all settings (except IP address) to factory default.\nContinue?\n",
							  "此操作会将所有设置(不包括IP)恢复到出厂默认状态.\n继续?\n"];
	var confirmStrIP=["This operation will restore all settings (including IP address) to factory default.\nContinue?\n",
								 "此操作会将所有设置(包括IP)恢复到出厂默认状态.\n继续?\n"];
	var str = confirmStrIP[LANGUAGE];
	var hander = function(){top.close()};
	var dialogStr=["Please wait...","请稍候..."];
	var dialogSec = ["",""];
	if('1' == $("#jsIPkeep:checked").val()){
			str = confirmStr[LANGUAGE];
			hander = function(){
				var location = top.window.location.toString().match(/^\w+\:\/\/\d+\.\d+\.\d+\.\d+\//);
				top.window.location=location.toString();
				};
	}
	if(window.confirm(str)){
//		DIALOG = DIALOG? DIALOG: new Dialog();
		top.frames[0].window.OnUnload();
		clearInterval(gTimeGetID);
		var dialog = DIALOG;
		var id = getCookie("dev");
		if (chipID == 3) {
			var diaologSec=30;
		}else{
			var diaologSec=100;
		}
		dialog.show(diaologSec,dialogStr[LANGUAGE],dialogSec[LANGUAGE],hander );
		$("#recoverForm").submit();
	}
}

function reboot(flag, hander){
	if (chipID == 3) {
		var confirmStr=["This operation takes 30 seconds.\nContinue?\n","此操作需要30秒。\n继续?\n"];
	}else{
		var confirmStr=["This operation takes 120 seconds.\nContinue?\n","此操作需要120秒。\n继续?\n"];
	}
	var dialogStr=["Please wait...","请稍候..."];
	var dialogSec = ["",""];
	var handerFun = "function" == (typeof hander)? hander: function(){
			var location = top.window.location.toString().match(/^\w+\:\/\/\d+\.\d+\.\d+\.\d+\//);
			if(location == null)
				location = top.window.location.toString().match(/^\w+\:\/\/\d+\.\d+\.\d+\.\d+\:+\d+\//);
			top.window.location=location.toString();};
			
	if(flag || window.confirm(confirmStr[LANGUAGE])){
//		DIALOG = DIALOG? DIALOG: new Dialog();
		var dialog = DIALOG;
		ajaxGet("rebootForm",function(){},function(){});
		if (chipID == 3) {
		dialog.show(30,dialogStr[LANGUAGE],dialogSec[LANGUAGE], handerFun);
		}else{
			dialog.show(120,dialogStr[LANGUAGE],dialogSec[LANGUAGE], handerFun);
		}
	}
}

function iframeSoftUp(){
	
	var ifarmeRes = $("#hideFrame").contents().find("html").html().toString();
	var flag = getState(ifarmeRes);
	var dialogStr=["Please wait...","请稍候..."];
	var dialogSec = ["",""];
	var dialog = DIALOG;
	var waitSec = 90;
	var dialogShowFlag = 1;
	var refreshHander =  function(){
		var location = top.window.location.toString().match(/^\w+\:\/\/\d+\.\d+\.\d+\.\d+\//);
		top.window.location=location.toString();
	};
	var updatTypeDOM = $("#jsUpdateType");
	var type = updatTypeDOM.val();
	dialog.loading(0);
//	top.frames[0].document.getElementById("lanSelect").style.visibility="visible";
	var alertStrCN={ "s0":"无法获取球地址或球协议",
							    "s1":"软件升级完毕,如果要运行新的程序,请重新启动系统!\n现在重启?\n",
							    "s2":"升级文件大小超过限制!",
								"s3":"PTZ设置错误",
								"s4":"文件操作出现错误,请检查后再试!",
								"s5":"升级超时",
								"s6":"升级成功",
								"s7":"文件传输失败",
								"s8":"建立连接失败",
								"s9":"无法打开升级文件",
								"s10":"文件类型与设备类型不匹配",
								"s11":"白名单文件请使用UTF-8编码"};
	var alertStrEN={    "s0":"Failed to get address or protocol.",
								  "s1":"Upgrade completed, please reboot for upgrade to take effect!\n",
								  "s2":"Upgrade file size exceed limit!",
								  "s3":"PTZ setting error",
								  "s4":"Upgrade file error, please try again after verification!",
								  "s5":"Upgrade timed out.",
								  "s6":"Upgrade succeeded.",
								  "s7":"Failed to transmit file",
								  "s8":"Failed to establish connection",
								  "s9":"Failed to open upgrade file",
								  "s10":"Device type is not supported",
								  "s11":"The whitelist.txt file must be utf-8 encoding!"};
	var alertArray=[alertStrEN,alertStrCN];
	if(1 == flag){
		if("mac"==type){
			if(!confirm(alertArray[LANGUAGE]["s"+1])){
				updatTypeDOM.data("lastType","mac");
				return;
			}else{
				updatTypeDOM.removeData("lastType");
			}
		}
		if("mac"==type || "mac"==updatTypeDOM.data("lastType")){
			waitSec = 90;
		}else if("ifu"==type){
			waitSec = 160;
		}
		else if("deviceid"==type){
			waitSec = 80;
		}
		if (chipID == 3) {
			waitSec = 30;
		}
		ajaxGet("rebootForm",function(){},function(){});
	}else if(6 == flag){
		if("bin"==type){
			waitSec = 120;
			refreshHander = function(){
				$.get("/form/GetXmodemStatus?"+(new Date()).getTime(),function(text){
					var result = getState(text);
					alert(alertArray[LANGUAGE]["s"+result]);
				});
			};
		}else{
			refreshHander = function(){
				alert(alertArray[LANGUAGE]["s"+flag]);
			}
		}
	}else{
		dialogShowFlag = 0;
		alert(alertArray[LANGUAGE]["s"+flag]);
	}
	
	if(dialogShowFlag){
		dialog.show(waitSec,dialogStr[LANGUAGE],dialogSec[LANGUAGE], refreshHander);
	}
}
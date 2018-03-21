// JavaScript Document
var jsVideoNow = "none";
var jsVideoList = "none";
var player = null;
var draggingLine = 0;
var draggingRect = 0;
var line_counting = 1;
var plate_recognition = 1;
var target_checking = 1;
var line_got = 0;
var plate_got = 0;
var target_got = 0;
var LANGUAGE;

function refreshPlayer(){
	var iframeWin = document.getElementById("jsVedioIframe").contentWindow || document.frames["jsVedioIframe"];
	player = iframeWin.document.getElementById("Player");
	if(!player){
		setTimeout("refreshPlayer();", 100);
	}
	else
	{
		player.SetPTZControlMode(0);
		player.EnableVectorControl(false);
	}
}

function videoShow(num){
	num = parseInt(num);
	if(num == jsVideoList){
		return;
	}
	var hankType = $('.videoClass');
	var liChoose = $('.choose');
	hankType.css("display", "none");
	liChoose.css({"border-bottom":"1px #F9F6F6 solid","background-color": ""});
	hankType.eq(num).css("display", "block");
	liChoose.eq(num).css({"border-bottom":"1px #BBB solid","background-color": COLOR});
	
	jsVideoNow = 0;
	jsVideoList = num;
	
	
	if(num == 3)
	{
		setTimeout("player.StopDrawIce();ICEDtcaPushStop();ICEHcntDrawEnable(0);ICEClbrEnable(1);ICEClbrInit();", 200);
		setTimeout("ICEClbrInit();", 700);
	}
	else if(num == 4)
	{
		ICEClbrEnable(0);
		setTimeout("ICEDtcaRuleEventSelect();", 100);
		setTimeout("ICEDtcaPush();", 100);
	}
	else if(num == 5)
	{
		ICEClbrEnable(0);
		setTimeout("ICEHcntDrawEnable(1);", 100);
		setTimeout("ICEHcntInit();", 100);
		//开始统计人数推送
		setTimeout("ICEDtcaPushStart(1);", 100);
	}
	else {
		ICEClbrEnable(0);	
	}
}

function Line_GetNum()
{
	  var num;
	  $.ajax({
			url:"/form/Line_GetNum",
			dataType:"text",
			success:function(data)
			{
				num = data.toString();
				$("#intel_line_num").html(num);
				if(num == "-1")
				{
					//$("#line_counting").hide();
					line_counting = 0;
				}
				else
				{
					$("#intel_line_num").html(num);
				}
				line_got = 1;
			}
	  });
}

function Line_ClearNum()
{
	  $.ajax({
			url:"/form/Line_ClearNum",
			dataType:"text",
			success:function(data){}
	  });
}

function Line_SendNum()
{
	  $.ajax({
			url:"/form/Line_SendNum",
			dataType:"text",
			success:function(data){}
	  });
}

function VLPR_INIT()
{
	$("#IPG_Params1,#IPG_Params2,#IPG_Label1").hide();
	PlateArea_Init();
	if(parseInt($("#SnapOn").val()) == 1)
		$("#SnapOnCheck").attr("checked",true);
	else
		$("#SnapOnCheck").attr("checked",false);

	var AlarmMode=parseInt($("#AlarmMode").val());
	if(AlarmMode&0x1)
		$("#AL_GPIO").attr("checked",true);
	else
		$("#AL_GPIO").attr("checked",false);
	if(AlarmMode&0x2)
		$("#AL_UART").attr("checked",true);
	else
		$("#AL_UART").attr("checked",false);
	if(AlarmMode&0x4)
		$("#AL_VIDEO").attr("checked",true);
	else
		$("#AL_VIDEO").attr("checked",false);
	if(AlarmMode&0x8)
		$("#AL_NET").attr("checked",true);
	else
		$("#AL_NET").attr("checked",false);
				
	$("#LedMode").val($("#LedMode_").val());
	var Ntime=parseInt($("#LedNightTime").val());
	var Tstart_H=(Ntime>>24)&0xff;
	var Tstart_M=(Ntime>>16)&0xff;
	var Tend_H=(Ntime>>8)&0xff;
	var Tend_M=(Ntime>>0)&0xff;
	$("#Tstart_H").val(Tstart_H.toString().length==1?"0"+Tstart_H.toString():Tstart_H.toString());
	$("#Tstart_M").val(Tstart_M.toString().length==1?"0"+Tstart_M.toString():Tstart_M.toString());
	$("#Tend_H").val(Tend_H.toString().length==1?"0"+Tend_H.toString():Tend_H.toString());
	$("#Tend_M").val(Tend_M.toString().length==1?"0"+Tend_M.toString():Tend_M.toString());
	$("#LedLightMode").val($("#LedLightMode_").val());
	form_widget_amount_slider('LedLum_Slider',document.getElementById('LedLum'),120,0,100,"");

	$("#TfSave").val($("#TfSave_").val());
	$("#AlarmOut").val($("#AlarmOut_").val());
	$("#Direction").val($("#Direction_").val());
	$("#UartMode").val($("#UartMode_").val());
	$("#UartBaudrate").val($("#UartBaudrate_").val());
	$("#PlatePriorcity").val($("#PlatePriorcity_").val());
	VLPR_UartMode_Select();
}

function VLPR_UartMode_Select()
{
	if($("#UartMode").val() == "1")
		$("#uart_transfer").show();
	else
		$("#uart_transfer").hide();
}

function VLPR_UartTransfer()
{
	var regExpInfo=/^[a-fA-F0-9]*$/;
	var string = $("#TextContent").val();
	if(string.length == 0){
		return;
	}
	if($("#TextMode").val() == "1")
	{
		if(!regExpInfo.exec(string)){
			alert(["Please Insert Valid Hex Value!","请输入合法的十六进制值!"][LANGUAGE]);
			return;
		}
	}
	$.ajax({
		type: "POST",
		url:"/cgi/vlpr_set",
		data: "Group=VlprUartTransfer&TextMode="+$("#TextMode").val()+"&TextContent="+$("#TextContent").val()
	});
}

function videoShow_Init()
{
	var intell_ID = ["","line_counting","plate_recognition","target_checking","clbr","icedtca","icehcnt"];
	var ICEtype = parseInt($("#ICEtype").val());
	//alert(ICEtype);
	/*
	if(line_got == 0 || plate_got == 0 || target_got == 0)
	{
		setTimeout("videoShow_Init()",100);
		return;
	}
	*/
	/*if(ICEtype == 1 || ICEtype == 5){
		$("#"+intell_ID[1]).show();
		$("#"+intell_ID[2]).hide();
		$("#"+intell_ID[3]).hide();
		//justin add here
		$("#"+intell_ID[4]).hide();
		$("#"+intell_ID[5]).hide();
		
		if(ICEtype == 5)
			$("#Dir_Area").hide();
		if(ICEtype == 1)
		{
			$("#clbr_line1").hide();
			$("#clbr_line2").hide();
			$("#clbr_line3").hide();
		}
		videoShow(0);
		setInterval("Line_GetNum();",1000);
	}*/
	if(ICEtype == 1 || ICEtype == 5){
		$("#"+intell_ID[1]).hide();
		$("#"+intell_ID[2]).hide();
		$("#"+intell_ID[3]).hide();
		//justin add here
		$("#"+intell_ID[4]).show();
		$("#"+intell_ID[5]).hide();
		
		
		
		if(ICEtype == 5)
		{
			$("#"+intell_ID[6]).show();
			$("#Dir_Area").hide();
			$("#divLine4").css("display", "none");
		}
			
		if(ICEtype == 1)
		{
			$("#"+intell_ID[6]).hide();
			$("#clbr_line1").hide();
			$("#clbr_line2").hide();
			$("#clbr_line3").hide();
		}
		
		//alert("videoShow_Init");
		videoShow(3);
		//setInterval("Line_GetNum();",1000);
	}
	else if(ICEtype == 2)
	{
		$("#"+intell_ID[1]).hide();
		$("#"+intell_ID[2]).show();
		$("#"+intell_ID[3]).hide();
		if(parseInt($("#VLPR").val()) == 1)
		{
			VLPR_INIT();
		}
		else
		{
			$("#VLPR_Params1,#VLPR_Params2,#VLPR_Params3").hide();
		}
		//justin add here
		$("#"+intell_ID[4]).hide();
		$("#"+intell_ID[5]).hide();
		$("#"+intell_ID[6]).hide();
		videoShow(1);
		setInterval("Plate_GetNum();",1000);
	}
	else if(ICEtype == 3 || ICEtype == 4)
	{
		$("#"+intell_ID[1]).hide();
		$("#"+intell_ID[2]).hide();
		$("#"+intell_ID[3]).hide();
		$("#"+intell_ID[4]).show();	//justin add here
		$("#"+intell_ID[5]).show();
		$("#"+intell_ID[6]).hide();
		videoShow(3);
		if(parseInt($("#VinRes960p").val()) == 1)
		{
			var Alert = ["To enable intellegent function, please set all encoder stream less than 960p and reboot the camera!","若要使用智能算法,请将各码流分辨率设置为小于960p,并重启摄像机!"];
			$("#jsIvmdEnable1").attr("disabled",true);
			$("#jsIvmdEnable0").attr("disabled",true);
			$("#for960p").html(Alert[LANGUAGE]);
		}
		setInterval("Target_GetNum();",1000);
	}
}

function Intelligent_Init()
{
	//videoChanged("mainVideoForm", 1);
	LANGUAGE = parseInt($("#PAGE_LANGUAGE").val());
	var iframeObj = $("#jsVedioIframe");
	if(navigator.userAgent.indexOf("Safari") != -1 && navigator.userAgent.indexOf("Chrome") == -1)
		iframeObj.attr( "src", "../video/videoSetPage_sf.htm?video=0" );
	else if(navigator.userAgent.indexOf("Chrome") == -1 && navigator.userAgent.indexOf("Firefox") == -1)
		iframeObj.attr( "src", "../video/videoSetPage.htm?video=0" );
	else
		iframeObj.attr( "src", "../video/videoSetPage_ff.htm?video=0" );
	jsVideoNow = 0;
	//player.SetRequestEx(0, 0);

	if(parseInt($("#jsLDirUL").val()) == 1)
		$("#jsDirectionUpLeft").attr("checked",true);
	else
		$("#jsDirectionUpLeft").attr("checked",false);
	if(parseInt($("#jsLDirDR").val()) == 1)
		$("#jsDirectionDownRight").attr("checked",true);
	else
		$("#jsDirectionDownRight").attr("checked",false);

	if(parseInt($("#IvmdEnable_").val()) == 1)
		$("#jsIvmdEnable1").attr("checked",true);
	else
		$("#jsIvmdEnable0").attr("checked",true);
		
	if(parseInt($("#PtzMovingSwitch").val()) == 1)
		$("#PTZmovingOn").attr("checked",true);
	else
		$("#PTZmovingOff").attr("checked",true);
	if(parseInt($("#Hi3516A").val()) == 0)
		$("#PTZmovingDiv").hide();
/*
	Line_GetNum();
	Plate_GetNum();
	Target_GetNum();
	setTimeout("videoShow_Init()",100);
*/
	videoShow_Init();
}

function CrossLineDrag(){
	if(draggingLine == 1)
		return;
	draggingLine = 1;
	player.BeginNewLine();
}

function draglineOperateLimit(){
	player.EnableFullScreen(false);
}


function IntellineSubmit(){
	if(!$("#jsCrossLineDrag").attr("disabled") && !$("#jsTargetAreaDrag").attr("disabled")){
		//return;
	}
/*
	var areaLine = 	{
						startx:Math.round(player.GetLineStartX()/2.7),
						starty:Math.round(player.GetLineStartY()/2.7),
						endx:Math.round(player.GetLineEndX()/4.8),
						endy:Math.round(player.GetLineEndY()/4.8)
					};
	with(areaLine){
		startx = startx<  0  ?  0 : startx;
		starty = starty> 100 ? 100: starty;
		endx   =   endx<  0  ?  0 : endx;
		endy   =   endy> 100 ? 100: endy;
		
		//endx = endx < startx ? startx : endx;
		//endy = endy < starty ? starty : endy;
	}
	$("#jsLineStartX").val(areaLine.startx);
	$("#jsLineStartY").val(areaLine.starty);
	$("#jsLineEndX").val(areaLine.endx);
	$("#jsLineEndY").val(areaLine.endy);
	player.EndNewLine(1);
	draggingLine = 0;


	var areaPara = 	{
						top:Math.round(player.GetMotionRectTop()/2.7),
						bottom:Math.round(player.GetMotionRectBottom()/2.7),
						left:Math.round(player.GetMotionRectLeft()/4.8),
						right:Math.round(player.GetMotionRectRight()/4.8)
					};
	with(areaPara){
		top    =	  top<0   ?  0 : top;
		bottom = bottom>100   ? 100: bottom;
		left   =	  left<0  ?  0 : left;
		right  =  right>100   ? 100: right;
		
		bottom = bottom < top ? top: bottom;
		right  = right < left ? left: right;
	}
	var asize = (bottom - top) * (right - left);
	$("#jsAreaSize").val(asize);
	player.EndNewMotionRect(1);
	draggingRect = 0;
*/
	if(Boolean($("#jsDirectionUpLeft").attr("checked")))
		$("#jsLDirUL").val(1);
	else
		$("#jsLDirUL").val(0);
	if(Boolean($("#jsDirectionDownRight").attr("checked")))
		$("#jsLDirDR").val(1);
	else
		$("#jsLDirDR").val(0);

	$("#IntellLineForm").submit();
}

function TargetAreaDrag(){
	if(draggingRect == 1)
		return;
	draggingRect = 1;
	player.BeginNewMotionRect(1);
}

function dragTargetOperateLimit(){
	player.EnableFullScreen(false);
}

function PlateArea_Init()
{
	//setTimeout(function(){PlateAreaAdd()},1000);
	PlateAreaAdd();
	PlateOperateRes();
	//setTimeout(function(){PlateAreaAdd()},1000);
}
function checkNum(num){
		var num = parseInt(num);
		return isNaN(num)? 0 : num;
}
function PlateAreaAdd(){
	try{
		try{
			player.SetPTZControlMode(0);
			player.EnableVectorControl(false);
		}catch(e){};
		var areaPara = {
								top : Math.round(checkNum($("#PlateTop").val())*2.7),
								bottom: Math.round(checkNum($("#PlateBottom").val())*2.7),
								left: Math.round(checkNum($("#PlateLeft").val())*4.8),
								right: Math.round(checkNum($("#PlateRight").val())*4.8)
							};
		//alert(areaPara.top+" "+areaPara.bottom+" "+areaPara.left+" "+areaPara.right);
		if( (areaPara.bottom-areaPara.top)>0 && (areaPara.right-areaPara.left)>0 ){
			player.AddMotionRect(areaPara.left,areaPara.top,areaPara.right,areaPara.bottom,0); 
			player.BeginNewMotionRect(0);
			var Text = ["Area","Area"];
			player.ShowMotionRectOSD(0,Text[LANGUAGE]);
			player.SetActiveMotionRect(0);
			player.EndNewMotionRect(1);
		}
	}catch(e){setTimeout(function(){PlateAreaAdd()},1000);};
}
function PlateAreaDrag(){
	player.BeginNewMotionRect(0);
	var Text = ["Area","Area"];
	player.ShowMotionRectOSD(0,Text[LANGUAGE]);
	player.SetActiveMotionRect(0);
}
function PlateOperateLimit(){
	$("#PlateDrag").attr("disabled",true);
	$("#PlateSub,#PlateRes").attr("disabled",false);
	draggingRect = 1;
	player.EnableFullScreen(false);
}
function PlateAreaGet(){
	var areaPara = {
								top:Math.round(player.GetMotionRectTop(0)/2.7),
								bottom:Math.round(player.GetMotionRectBottom(0)/2.7),
								left:Math.round(player.GetMotionRectLeft(0)/4.8),
								right:Math.round(player.GetMotionRectRight(0)/4.8)
				   };
	with(areaPara){
		top = top < 0 ? 0 : top;
		bottom = bottom > 100 ? 100 : bottom;
		left = left	< 0 ? 0 : left;
		right 	= right > 100 ? 100 : right;
		
		bottom = bottom < top ? top: bottom;
		right = right < left ? left: right;
	}
	$("#PlateTop").val(areaPara.top);
	$("#PlateBottom").val(areaPara.bottom);
	$("#PlateLeft").val(areaPara.left);
	$("#PlateRight").val(areaPara.right);
	player.EndNewMotionRect(1);
}
function PlateOperateRes(){
	try{
		player.EnableFullScreen(true);
	}catch(e){};
	//motionAreaEnable(i,"init");
	$("#PlateDrag").attr("disabled",false);
	$("#PlateSub,#PlateRes").attr("disabled",true);
	draggingRect = 0;
}
function PlateAreaReset(){
	//DragObj.value("jsSens"+areaNum, sensValue);
	//$("#jsMotion"+areaNum+"Sens").val(sensValue);
	//$("#jsMotion"+areaNum+"SensLabel").text(sensValue);
	//$("#jsMotion"+areaNum+"Name").val($("#jsMotion"+areaNum+"Nback").val());
	player.EndNewMotionRect(1);
	player.DeleteMotionRect(0);
	PlateAreaAdd();
}

var cur_num = "null";
function Plate_GetNum()
{
	  var num;
	  $.ajax({
			url:"/form/Plate_GetNum",
			dataType:"text",
			success:function(data)
			{
				num = data.toString();
				if(cur_num != num){
					cur_num = num;
					for(var i = 3; i >= 0; i--){
						var j = i + 1;
						$("#intel_plate_num"+j.toString()).html($("#intel_plate_num"+i.toString()).html().toString());
					}
				}
				//$("#intel_plate_num0").html(num);
				if(num == "none")
				{
					//alert(num);
					//$("#plate_recognition").hide();
					plate_recognition = 0;
				}
				else
				{
					$("#intel_plate_num0").html(num);
				}
				plate_got = 1;
			}
	  });
}

function IntelplateAlarm()
{
	$("#ManualAlarm").val(1);
	$("#IntellPlateForm").submit();
	$("#ManualAlarm").val(0);
}

function IntelplateSubmit(){
	if(parseInt($("#VLPR").val()) == 1)
	{
		var VinWidth = parseInt($("#jsPlate_InWidth").val());
		var VinHeight = parseInt($("#jsPlate_InHeight").val());
		if(VinWidth<176 || VinWidth>1920 || VinHeight<144 || VinHeight>1080)
		{
			alert(["Vin Size 176x144~1920x1080","图像尺寸范围176x144~1920x1080"][LANGUAGE]);
			return;
		}
		var PlateConfidence = parseInt($("#PlateConfidence").val());
		if(PlateConfidence<10 || PlateConfidence>20)
		{
			alert(["Plate confidence must be int 10~20","车牌置信度阈值10~20"][LANGUAGE]);
			return;
		}
		var AlarmInterval = parseInt($("#AlarmInterval").val());
		if(AlarmInterval<1 || AlarmInterval>15)
		{
			alert(["AlarmInterval 1~15s","报警间隔1~15秒"][LANGUAGE]);
			return;
		}
		var AlarmServerIp = IPcheck( $("#jsServerIp").val() );
		if(''===AlarmServerIp || 1===AlarmServerIp){
			alert(["Please enter right IP address","请输入正确的IP地址"][LANGUAGE]);
			return;
		}
		if(AlarmInterval<1 || AlarmInterval>15)
		{
			alert(["AlarmInterval 1~15s","报警间隔1~15秒"][LANGUAGE]);
			return;
		}
		if(Boolean($("#SnapOnCheck").attr("checked")))
			$("#SnapOn").val(1);
		else
			$("#SnapOn").val(0);
		var AlarmMode=0;
		if(Boolean($("#AL_GPIO").attr("checked")))
			AlarmMode |= 0x1;
		if(Boolean($("#AL_UART").attr("checked")))
			AlarmMode |= 0x2;
		if(Boolean($("#AL_VIDEO").attr("checked")))
			AlarmMode |= 0x4;
		if(Boolean($("#AL_NET").attr("checked")))
			AlarmMode |= 0x8;
		$("#AlarmMode").val(AlarmMode);
	
		var Tstart_H=parseInt($("#Tstart_H").val(), 10);
		if(Tstart_H > 23 || Tstart_H < 12)
		{
			alert(["Night start 12:00~24:00","夜间起始时间12:00~24:00"][LANGUAGE]);
			return;
		}
		var Tstart_M=parseInt($("#Tstart_M").val(), 10);
		if(Tstart_M > 59 || Tstart_M < 0)
		{
			alert(["Night start 12:00~24:00","夜间起始时间12:00~24:00"][LANGUAGE]);
			return;
		}
		var Tend_H=parseInt($("#Tend_H").val(), 10);
		if(Tend_H > 12 || Tend_H < 0)
		{
			alert(["Night end 0:00~12:00","夜间终止时间0:00~12:00"][LANGUAGE]);
			return;
		}
		var Tend_M=parseInt($("#Tend_M").val(), 10);
		if(Tend_M > 59 || Tend_M < 0)
		{
			alert(["Night end 0:00~12:00","夜间终止时间0:00~12:00"][LANGUAGE]);
			return;
		}
		if(Tstart_H*60+Tstart_M < Tend_H*60+Tend_M)
		{
			alert(["Night starttime should be later than endtime!","夜间起始时间需晚于终止时间!"][LANGUAGE]);
			return;
		}
		var LedNightTime = (Tstart_H<<24)+(Tstart_M<<16)+(Tend_H<<8)+(Tend_M<<0);
		$("#LedNightTime").val(LedNightTime);
		if(draggingRect == 1)
		{
			PlateAreaGet();
			PlateOperateRes();
		}
	}

	$("#IntellPlateForm").submit();
}

function IntelligentReset(type){
	if(parseInt($("#VLPR").val()) != 1)
	{
		if(!confirm(["Camera will reboot, continue?","重启将设备，继续?"][LANGUAGE]))
			return;
	}
	$.ajax({
		url:"/form/IntelligentReset",
		data:"flag="+type,
		dataType:"text",
		success:function(data){}
	});
	if(parseInt($("#VLPR").val()) != 1)
	{
		var dialog = new Dialog();
		var dialogStr=["Please wait...  ","请稍候...  "];
		$("#jsVedioIframe").hide();
		dialog.show(100,dialogStr[LANGUAGE],"", function(){location.reload(true);});
	}
	else
	{
		setTimeout("location.reload(true);",2000);
	}
}

function Target_GetNum()
{
	  var num;
	  $.ajax({
			url:"/form/Target_GetNum",
			dataType:"text",
			success:function(data)
			{
				num = data.toString();
				//$("#intel_target_num").html(num);
				if(num == "-1")
				{
					//$("#target_checking").hide();
					target_checking = 0;
				}
				else
				{
					$("#intel_target_num").html(num);
				}
				target_got = 1;
			}
	  });
}

function IntelTargetSubmit(){
	$("#IntellTargetForm").submit();
}

/*justin add for IEC*/
function ICEClbrInit()
{
	var linenum;
	var ICEtype = parseInt($("#ICEtype").val());
	
	//alert("ice clbr init ICEtype is " + ICEtype);
	
	if(ICEtype == 4)
	{
		linenum = 5;
	}
	else if(ICEtype == 5)
	{
		linenum = 4;	
	}
	else
	{
		linenum = 5;	
	}
	
	//alert("linenum is "+ linenum);

	/*justin add for ICE*/
	for(var i=1; i<linenum; i++)
	{

		if(parseInt($("#jsCLBR"+i.toString()+"Dir").val()) == 1)
		{
			$("#jsCLBR"+i.toString()+"Dir1").attr("checked", true);	
			$("#jsCLBR"+i.toString()+"Dir0").attr("checked", false);		
			//alert("here is 1");
			
		}
		else {
			$("#jsCLBR"+i.toString()+"Dir1").attr("checked", false);	
			$("#jsCLBR"+i.toString()+"Dir0").attr("checked", true);	
			//alert("here is 0");	
		}
		
		ICEClbrSetDisplay(i);
		
	}
}

function ICEClbrSetDisplay(linenum)
{
	var Xs = Math.round(parseInt($("#jsCLBR"+linenum+"Xs").val())*4.8);
	var Ys = Math.round(parseInt($("#jsCLBR"+linenum+"Ys").val())*2.7);
	var Xe = Math.round(parseInt($("#jsCLBR"+linenum+"Xe").val())*4.8);
	var Ye = Math.round(parseInt($("#jsCLBR"+linenum+"Ye").val())*2.7);
	
	var dir = $("#jsCLBR"+linenum+"Dir").val();

	player.SetDepthIceParam(linenum-1,dir,Xs,Ys,Xe,Ye);
}

function ICEClbrLineDrag(linenum)
{	
	$("#jsCLBR"+linenum+"Drag").attr("disabled", true);
	
	var dir = $("#jsCLBR"+linenum+"Dir").val();
	//alert("dir is "+ dir);
	
	//绘图使能
	player.EnableDepthIce(true);
	player.SetDepthIceParam(linenum-1,dir,0,0,0,0);
}

function ICEClbrLineGet(linenum)
{
	if(!Boolean($("#jsCLBR"+linenum+"Drag").attr("disabled")))
	{
		return;	
	}
	
	//alert("ICEClbrLineGet");
	
	//var Xs = Math.round(parseInt($("#jsHcntBaselineStartX").val())*4.8);
	//Math.round(parseInt(player.GetHumanNumIceLineX(0))/4.8);
	
	var Xs = Math.round(parseInt(player.GetDepthIceLineX(linenum-1,0))/4.8);
	var Ys = Math.round(parseInt(player.GetDepthIceLineY(linenum-1,0))/2.7);
	var Xe = Math.round(parseInt(player.GetDepthIceLineX(linenum-1,1))/4.8);
	var Ye = Math.round(parseInt(player.GetDepthIceLineY(linenum-1,1))/2.7);
	
	$("#jsCLBR"+linenum+"Xs").val(Xs);
	$("#jsCLBR"+linenum+"Xe").val(Xe);
	$("#jsCLBR"+linenum+"Ys").val(Ys);
	$("#jsCLBR"+linenum+"Ye").val(Ye);
	
	//alert("EnableDepthIce false");
	
	//禁止绘图
	player.EnableDepthIce(false);
}

function ICEClbrLineSubmit(linenum)
{
	if(linenum < 7)
	{
		$("#jsCLBR"+linenum+"Drag").attr("disabled", false);
		
		/*if($("#jsCLBR"+linenum+"Dir1:checked").val())
		{
			$("#jsCLBR"+linenum+"Dir").val(1);
		}
		else {
			$("#jsCLBR"+linenum+"Dir").val(0);	
		}*/
		
		$("#CLBRForm"+linenum).submit();
	}
	else {
		$("#jsClbrFlag").val(linenum);	
		$("#CLBRForm").submit();
	}
	
	
}

function ICEClbrLineReset(linenum)
{
	if(!Boolean($("#jsCLBR"+linenum+"Drag").attr("disabled")))
	{
		return;
	}
	
	$("#jsCLBR"+linenum+"Drag").attr("disabled", false);
	
	ICEClbrSetDisplay(linenum);
	
	//禁止绘图
	player.EnableDepthIce(false);
}

function ICEClbrDirSet(linenum, state)
{
	//alert("state is "+ state);
	if(state == 1)
	{
		$("#jsCLBR"+linenum.toString()+"Dir1").attr("checked", true);
		$("#jsCLBR"+linenum.toString()+"Dir0").attr("checked", false);
		
		$("#jsCLBR"+linenum+"Dir").val(1);
	}
	else {
		$("#jsCLBR"+linenum.toString()+"Dir1").attr("checked", false);
		$("#jsCLBR"+linenum.toString()+"Dir0").attr("checked", true);
				
		$("#jsCLBR"+linenum+"Dir").val(0);
	}
}

function ICEDtcaRuleEnable(state)
{
	var num_used;
	var pointx = new Array(8);
	var pointy = new Array(8);
	var arryDtcaID = ["","Perimeter","TripWire","MTripWire","Loter","Converse","ObjLeft"];
	var index = $("#IceDtcaRuleEventSelect").val();
	
	//$("#js"+arryDtcaID[index]+"RuleEnable").val(state);
	
	if(state == 1)
	{
		
		
		$("#objleft").attr("disabled", false);
		$("#ICEDTCAParam").attr("disabled", false);
		
		
		
		/*规则开启则开启绘图显示*/
		if(index == 1)
		{
			num_used = parseInt($("#jsPerimeterPonitNum").val());
			
			for(var i=0; i<num_used; i++)
			{
				pointx[i] = Math.round(parseInt($("#jsPerimeterPonitX"+(i+1).toString()).val())*4.8);	
				pointy[i] = Math.round(parseInt($("#jsPerimeterPonitY"+(i+1).toString()).val())*2.7);	
			}
			
			/*传给控件参数并开启显示*/
			player.StartDrawIce(index, 0);
			player.SetIceAreaParam(num_used,pointx[0],pointy[0],pointx[1],pointy[1],pointx[2],pointy[2],pointx[3],pointy[3],pointx[4],pointy[4],pointx[5],pointy[5],pointx[6],pointy[6],pointx[7],pointy[7]);
		}
		else if(index == 2)
		{
			var Xs = Math.round(parseInt($("#jsTripWirePonitX1").val())*4.8);
			var Ys = Math.round(parseInt($("#jsTripWirePonitY1").val())*2.7);
			var Xe = Math.round(parseInt($("#jsTripWirePonitX2").val())*4.8);
			var Ye = Math.round(parseInt($("#jsTripWirePonitY2").val())*2.7);
			var minor_type = $("#jsTripWireCheckbox").val();
			
			/*传给控件参数并开启显示*/
			player.StartDrawIce(index, minor_type);
			player.SetTripwireParam(Xs, Ys, Xe, Ye);
			
		}
		else if(index == 3)
		{
			pointx[0] = Math.round(parseInt($("#jsMTripWirePonitX11").val())*4.8);	
			pointy[0] = Math.round(parseInt($("#jsMTripWirePonitY11").val())*2.7);
			pointx[1] = Math.round(parseInt($("#jsMTripWirePonitX12").val())*4.8);	
			pointy[1] = Math.round(parseInt($("#jsMTripWirePonitY12").val())*2.7);
			pointx[2] = Math.round(parseInt($("#jsMTripWirePonitX21").val())*4.8);	
			pointy[2] = Math.round(parseInt($("#jsMTripWirePonitY21").val())*2.7);
			pointx[3] = Math.round(parseInt($("#jsMTripWirePonitX22").val())*4.8);	
			pointy[3] = Math.round(parseInt($("#jsMTripWirePonitY22").val())*2.7);
			
			/*传给控件参数并开启显示*/
			player.StartDrawIce(index, 0);
			player.SetMtripwireParam(pointx[0],pointy[0],pointx[1],pointy[1],pointx[2],pointy[2],pointx[3],pointy[3]);
		}
		else if(index == 4)
		{
			num_used = parseInt($("#jsLoterPonitNum").val());
			for(var i=0; i<num_used; i++)
			{
				pointx[i] = Math.round(parseInt($("#jsLoterPonitX"+(i+1).toString()).val())*4.8);	
				pointy[i] = Math.round(parseInt($("#jsLoterPonitY"+(i+1).toString()).val())*2.7);	
			}
			
			/*传给控件参数并开启显示*/
			player.StartDrawIce(index, 0);
			player.SetIceAreaParam(num_used,pointx[0],pointy[0],pointx[1],pointy[1],pointx[2],pointy[2],pointx[3],pointy[3],pointx[4],pointy[4],pointx[5],pointy[5],pointx[6],pointy[6],pointx[7],pointy[7]);
		}
		else if(index == 5)
		{
			num_used = parseInt($("#jsConversePonitNum").val());
			for(var i=0; i<num_used; i++)
			{
				pointx[i] = Math.round(parseInt($("#jsConversePonitX"+(i+1).toString()).val())*4.8);	
				pointy[i] = Math.round(parseInt($("#jsConversePonitY"+(i+1).toString()).val())*2.7);	
			}
			
			var pxs = Math.round(parseInt($("#jsConverseDirXs").val())*4.8);
			var pys = Math.round(parseInt($("#jsConverseDirYs").val())*2.7);
			var pxe = Math.round(parseInt($("#jsConverseDirXe").val())*4.8);
			var pye = Math.round(parseInt($("#jsConverseDirYe").val())*2.7);
			
			/*传给控件参数并开启显示*/
			player.StartDrawIce(index, 0);
			player.SetConverseParam(pxs,pys,pxe,pye,num_used,pointx[0],pointy[0],pointx[1],pointy[1],pointx[2],pointy[2],pointx[3],pointy[3],pointx[4],pointy[4],pointx[5],pointy[5],pointx[6],pointy[6],pointx[7],pointy[7]);
		}
		else if(index == 6)
		{
			num_used = parseInt($("#jsObjLeftPonitNum").val());
			
			for(var i=0; i<num_used; i++)
			{
				pointx[i] = Math.round(parseInt($("#jsObjLeftPonitX"+(i+1).toString()).val())*4.8);	
				pointy[i] = Math.round(parseInt($("#jsObjLeftPonitY"+(i+1).toString()).val())*2.7);	
			}
			
			/*传给控件参数并开启显示*/
			player.StartDrawIce(index, 0);
			player.SetIceAreaParam(num_used,pointx[0],pointy[0],pointx[1],pointy[1],pointx[2],pointy[2],pointx[3],pointy[3],pointx[4],pointy[4],pointx[5],pointy[5],pointx[6],pointy[6],pointx[7],pointy[7]);
		}
		
	} 
	else {
		$("#ICEDTCAParam").attr("disabled", true);	
		$("#objleft").attr("disabled", true);
		
		/*关闭绘图显示*/
		player.StopDrawIce();
	}
}

function ICEDtcaRuleEventSelect()
{
	var ruleEnable;
	var num_used;
	var pointx = new Array(8);
	var pointy = new Array(8);
	var arryDtcaID = ["","Perimeter","TripWire","MTripWire","Loter","Converse","ObjLeft"];
	
	var index = $("#IceDtcaRuleEventSelect").val();
	
	/*参数赋值*/
	$("#DTCAFlag").val(index);
	$("#jsDTCARuleName").val($("#js"+arryDtcaID[index]+"RuleName").val());
	
	/*物品遗留*/
	$("#objleft").css("display","none");
	if(index == 6)
	{
		/*屏蔽其他参数选项*/
		$("#tripwire").css("display", "none");
		$("#mtripwire").css("display", "none");
		$("#loter").css("display", "none");
		$("#commonParam").css("display", "none");
		
		$("#objleft").css("display","block");
		
		$("#jsDTCAActive1").attr("checked", false);
		$("#jsDTCAActive0").attr("checked", false);
		
		/*关闭绘图功能*/
		player.StopDrawIce();
		
		ruleEnable = $("#js"+arryDtcaID[index]+"RuleEnable").val();
		if(ruleEnable == 1)
		{
			$("#ICEDTCAParam").attr("disabled", false);	
			$("#objleft").attr("disabled", false);
			$("#jsDTCAActive1").attr("checked", true);
			
			num_used = parseInt($("#jsObjLeftPonitNum").val());
			
			for(var i=0; i<num_used; i++)
			{
				pointx[i] = Math.round(parseInt($("#jsObjLeftPonitX"+(i+1).toString()).val())*4.8);	
				pointy[i] = Math.round(parseInt($("#jsObjLeftPonitY"+(i+1).toString()).val())*2.7);	
			}
			
			/*传给控件参数并开启显示*/
			player.StartDrawIce(index, 0);
			player.SetIceAreaParam(num_used,pointx[0],pointy[0],pointx[1],pointy[1],pointx[2],pointy[2],pointx[3],pointy[3],pointx[4],pointy[4],pointx[5],pointy[5],pointx[6],pointy[6],pointx[7],pointy[7]);
		} else {
			$("#ICEDTCAParam").attr("disabled", true);	
			$("#objleft").attr("disabled", true);
			$("#jsDTCAActive0").attr("checked", true);
		}
		
		return;
	}
	
	
	$("#commonParam").css("display", "block");
	
	/*限定目标类型*/
	$("#jsObjectType0").attr("checked", false);
	$("#jsObjectType1").attr("checked", false);
	$("#jsObjectType2").attr("checked", false);
	
	var state = $("#js"+arryDtcaID[index]+"ObjType").val();
	$("#jsObjectType"+state).attr("checked", true);
	
	if($("#js"+arryDtcaID[index]+"ObjLimit").val() == 1)
	{
		$("#jsObjTypeCheckbox").attr("checked", true);
		$("#ObjectTypeLimit").attr("disabled", false);
	}
	else {
		$("#jsObjTypeCheckbox").attr("checked", false);
		$("#ObjectTypeLimit").attr("disabled", true);
	}
	
	/*限定目标大小*/
	$("#jsObjectMinSize").val($("#js"+arryDtcaID[index]+"ObjMinSize").val());
	$("#jsObjectMaxSize").val($("#js"+arryDtcaID[index]+"ObjMaxSize").val());
	state = $("#js"+arryDtcaID[index]+"ObjSizeLimit").val();
	if(state == 1)
	{
		$("#jsObjSizeCheckbox").attr("checked", true);
	}
	else {
		$("#jsObjSizeCheckbox").attr("checked", false);
	}
	
	/*参数显示*/
	$("#tripwire").css("display", "none");
	$("#mtripwire").css("display", "none");	
	$("#loter").css("display", "none");
	
	if(index == 2)
	{
		if($("#jsTripWireCheckbox").val() == 1)
		{
			$("#jsTripWireCheckbox").attr("checked", true);
		}
		else {
			$("#jsTripWireCheckbox").attr("checked", false);
		}
		$("#tripwire").css("display", "block");
	}
	else if(index == 3)
	{
		$("#mtripwire").css("display", "block");	
	}
	else if(index == 4)
	{
		$("#loter").css("display", "block");
		var value = $("#jsLoterPathCheckbox").val();
		if($("#jsLoterPathCheckbox").val() == 1)
		{
			$("#jsLoterPathCheckbox").attr("checked", true);
		}
		else {
			$("#jsLoterPathCheckbox").attr("checked", false);	
		}
	}
	
	$("#jsDTCAActive1").attr("checked", false);
	$("#jsDTCAActive0").attr("checked", false);
	
	/*关闭绘图功能*/
	player.StopDrawIce();
	
	ruleEnable = $("#js"+arryDtcaID[index]+"RuleEnable").val();
	if(ruleEnable == 1)
	{
		$("#jsDTCAActive1").attr("checked", true);
		$("#ICEDTCAParam").attr("disabled", false);	
		
		/*规则开启则开启绘图显示*/
		if(index == 1)
		{
			num_used = parseInt($("#jsPerimeterPonitNum").val());
			
			for(var i=0; i<num_used; i++)
			{
				pointx[i] = Math.round(parseInt($("#jsPerimeterPonitX"+(i+1).toString()).val())*4.8);	
				pointy[i] = Math.round(parseInt($("#jsPerimeterPonitY"+(i+1).toString()).val())*2.7);	
			}
			
			/*传给控件参数并开启显示*/
			player.StartDrawIce(index, 0);
			player.SetIceAreaParam(num_used,pointx[0],pointy[0],pointx[1],pointy[1],pointx[2],pointy[2],pointx[3],pointy[3],pointx[4],pointy[4],pointx[5],pointy[5],pointx[6],pointy[6],pointx[7],pointy[7]);
		}
		else if(index == 2)
		{
			var Xs = Math.round(parseInt($("#jsTripWirePonitX1").val())*4.8);
			var Ys = Math.round(parseInt($("#jsTripWirePonitY1").val())*2.7);
			var Xe = Math.round(parseInt($("#jsTripWirePonitX2").val())*4.8);
			var Ye = Math.round(parseInt($("#jsTripWirePonitY2").val())*2.7);
			var minor_type = $("#jsTripWireCheckbox").val();
			
			/*传给控件参数并开启显示*/
			player.StartDrawIce(index, minor_type);
			player.SetTripwireParam(Xs, Ys, Xe, Ye);
			
		}
		else if(index == 3)
		{
			pointx[0] = Math.round(parseInt($("#jsMTripWirePonitX11").val())*4.8);	
			pointy[0] = Math.round(parseInt($("#jsMTripWirePonitY11").val())*2.7);
			pointx[1] = Math.round(parseInt($("#jsMTripWirePonitX12").val())*4.8);	
			pointy[1] = Math.round(parseInt($("#jsMTripWirePonitY12").val())*2.7);
			pointx[2] = Math.round(parseInt($("#jsMTripWirePonitX21").val())*4.8);	
			pointy[2] = Math.round(parseInt($("#jsMTripWirePonitY21").val())*2.7);
			pointx[3] = Math.round(parseInt($("#jsMTripWirePonitX22").val())*4.8);	
			pointy[3] = Math.round(parseInt($("#jsMTripWirePonitY22").val())*2.7);
			
			
			/*传给控件参数并开启显示*/
			player.StartDrawIce(index, 0);
			player.SetMtripwireParam(pointx[0],pointy[0],pointx[1],pointy[1],pointx[2],pointy[2],pointx[3],pointy[3]);
		}
		else if(index == 4)
		{
			num_used = parseInt($("#jsLoterPonitNum").val());
			for(var i=0; i<num_used; i++)
			{
				pointx[i] = Math.round(parseInt($("#jsLoterPonitX"+(i+1).toString()).val())*4.8);	
				pointy[i] = Math.round(parseInt($("#jsLoterPonitY"+(i+1).toString()).val())*2.7);	
			}
			
			/*传给控件参数并开启显示*/
			player.StartDrawIce(index, 0);
			player.SetIceAreaParam(num_used,pointx[0],pointy[0],pointx[1],pointy[1],pointx[2],pointy[2],pointx[3],pointy[3],pointx[4],pointy[4],pointx[5],pointy[5],pointx[6],pointy[6],pointx[7],pointy[7]);
		}
		else if(index == 5)
		{
			num_used = parseInt($("#jsConversePonitNum").val());
			for(var i=0; i<num_used; i++)
			{
				pointx[i] = Math.round(parseInt($("#jsConversePonitX"+(i+1).toString()).val())*4.8);	
				pointy[i] = Math.round(parseInt($("#jsConversePonitY"+(i+1).toString()).val())*2.7);	
			}
			
			var pxs = Math.round(parseInt($("#jsConverseDirXs").val())*4.8);
			var pys = Math.round(parseInt($("#jsConverseDirYs").val())*2.7);
			var pxe = Math.round(parseInt($("#jsConverseDirXe").val())*4.8);
			var pye = Math.round(parseInt($("#jsConverseDirYe").val())*2.7);
			
			/*传给控件参数并开启显示*/
			player.StartDrawIce(index, 0);
			player.SetConverseParam(pxs,pys,pxe,pye,num_used,pointx[0],pointy[0],pointx[1],pointy[1],pointx[2],pointy[2],pointx[3],pointy[3],pointx[4],pointy[4],pointx[5],pointy[5],pointx[6],pointy[6],pointx[7],pointy[7]);
		}
	}
	else {
		$("#jsDTCAActive0").attr("checked", true);
		$("#ICEDTCAParam").attr("disabled", true);	
	}
}

function ICEDtcaTripWireDDirSwitch()
{
	var majorType = 2;
	var minorType;
	
	if(Boolean($("#jsTripWireCheckbox").attr("checked")))
	{
		minorType = 1;
		//$("#jsTripWireCheckbox").val(1);	
	}
	else 
	{
		minorType = 0;
		//$("#jsTripWireCheckbox").val(0);	
	}
	
	/*关闭绘图显示*/
	player.StopDrawIce();
	
	var Xs = Math.round(parseInt($("#jsTripWirePonitX1").val())*4.8);
	var Ys = Math.round(parseInt($("#jsTripWirePonitY1").val())*2.7);
	var Xe = Math.round(parseInt($("#jsTripWirePonitX2").val())*4.8);
	var Ye = Math.round(parseInt($("#jsTripWirePonitY2").val())*2.7);
			
	/*传给控件参数并开启显示*/
	player.StartDrawIce(majorType, minorType);
	player.SetTripwireParam(Xs, Ys, Xe, Ye);
}


function ICEDtcaObjTypeChecked()
{
	var arryDtcaID = ["","Perimeter","TripWire","MTripWire","Loter","Converse"];
	var dtcaRuleEvent = $("#IceDtcaRuleEventSelect").val();
	
	obj = $("#jsObjTypeCheckbox");
	var state = Boolean(obj.attr("checked"));
	
	if(state)
	{
		$("#ObjectTypeLimit").attr("disabled", false);
		//$("#js"+arryDtcaID[dtcaRuleEvent]+"ObjLimit").val(1);
	}
	else {
		$("#ObjectTypeLimit").attr("disabled", true);	
		//$("#js"+arryDtcaID[dtcaRuleEvent]+"ObjLimit").val(0);
	}
}

function ICEDtcaObjTypeSet(type)
{
	for(var i=0; i<3; i++)
	{
		$("#jsObjectType"+i.toString()).attr("checked", false);	
	}
	
	$("#jsObjectType"+type.toString()).attr("checked", true);
}

function ICEDtcaObjSizeChecked()
{
	var arryDtcaID = ["","Perimeter","TripWire","MTripWire","Loter","Converse"];
	var dtcaRuleEvent = $("#IceDtcaRuleEventSelect").val();
	
	obj = $("#jsObjSizeCheckbox");
	var state = Boolean(obj.attr("checked"));
	
	
	if(state)
	{
		$("#ObjectSizeLimit").attr("disabled", false);
		$("#js"+arryDtcaID[dtcaRuleEvent]+"ObjSizeLimit").val(1);
	}
	else {
		
		$("#ObjectSizeLimit").attr("disabled", true);	
		$("#js"+arryDtcaID[dtcaRuleEvent]+"ObjSizeLimit").val(0);
	}
}

function ICEDtcaPushStart(flag)
{
	player.StartIceAlarmPush(flag);		
}

function ICEDtcaPushStop()
{
	player.StopIceAlarmPush();	
}

function ICEDtcaPush()
{
	var flag = 0;
	var iEnable = new Array(5);
	var arryDtcaID = ["","Perimeter","TripWire","MTripWire","Loter","Converse","ObjLeft"];
	
	for(var i=0; i<6; i++)
	{
		iEnable[i] = $("#js"+arryDtcaID[i+1]+"RuleEnable").val();
		if(iEnable[i] == 1)
		{
			flag = 1;
			break;	
		}
	}
	
	
	if(flag == 1)
	{
		setTimeout("ICEDtcaPushStart(0);", 100);
	}
	else {
		setTimeout("ICEDtcaPushStop();", 100);
	}
}

function ICEDtcaReset()
{
	if(!window.confirm(["Prog will reset to take effect","程序将重启以使设置生效"][LANGUAGE]))
	{
		return;
	}
		
	$("#DTCAFlag").val(8);
	$("#DTCAForm").submit();
}

function ICEDtcaSubmit()
{
	var ruleEnable;
	var arryDtcaID = ["","Perimeter","TripWire","MTripWire","Loter","Converse","ObjLeft"];
	
	var index = $("#IceDtcaRuleEventSelect").val();

	if(Boolean($("#PTZmovingOn").attr("checked")))
		$("#PtzMovingSwitch").val(1);
	else
		$("#PtzMovingSwitch").val(0);
	
	/*规则开关*/
	if(Boolean($("#jsDTCAActive1").attr("checked")))
	{
		$("#js"+arryDtcaID[index]+"RuleEnable").val(1);
		
		/*规则名称*/
		$("#js"+arryDtcaID[index]+"RuleName").val($("#jsDTCARuleName").val());
		
		if(index == 6)
		{
			var point_num;
			var point_x = new Array(8);
			var point_y = new Array(8);
		
			point_num = parseInt(player.GetIceAreaPtVaild(6));
			$("#jsObjLeftPonitNum").val(point_num);
		
			for(var i=1; i<=point_num; i++)
			{
				$("#jsObjLeftPonitX"+i.toString()).val(Math.round(parseInt(player.GetIceAreaPtX(6, i-1))/4.8));	
				$("#jsObjLeftPonitY"+i.toString()).val(Math.round(parseInt(player.GetIceAreaPtY(6, i-1))/2.7));	
			}
			
			/*参数改变需要重新配置算法库*/	
			ICEDtcaPushStop();
	
			/*检测是否开启位置推送*/
			setTimeout("ICEDtcaPush();", 3000);

			$("#DTCAForm").submit();
		
			return;	
		}
		
		/*限定目标类型*/
		if(Boolean($("#jsObjTypeCheckbox").attr("checked")))
		{
			$("#js"+arryDtcaID[index]+"ObjLimit").val(1);
		}
		else {
			$("#js"+arryDtcaID[index]+"ObjLimit").val(0);	
		}
	
		for(var i=0; i<3; i++)
		{
			if(Boolean($("#jsObjectType"+i.toString()).attr("checked")))
			{
				$("#js"+arryDtcaID[index]+"ObjType").val(i);	
				break;
			}
		}
	
		/*限定目标尺寸*/
		if(Boolean($("#jsObjSizeCheckbox").attr("checked")))
		{
			$("#js"+arryDtcaID[index]+"ObjSizeLimit").val(1);
		}
		else {
			$("#js"+arryDtcaID[index]+"ObjSizeLimit").val(0);	
		}
	
		$("#js"+arryDtcaID[index]+"ObjMinSize").val($("#jsObjectMinSize").val());
		$("#js"+arryDtcaID[index]+"ObjMaxSize").val($("#jsObjectMaxSize").val());
	
		/*其他*/
		if(Boolean($("#jsLoterPathCheckbox").attr("checked")))
		{
			$("#jsLoterPathCheckbox").val(1);
		}
		else {
			$("#jsLoterPathCheckbox").val(0);	
		}
	
		/*获取坐标*/
		var num_used;
		var pointx = new Array(8);
		var pointy = new Array(8);
		if(index == 1)
		{
			//player.GetIceAreaParam(num_used,pointx[0],pointy[0],pointx[1],pointy[1],pointx[2],pointy[2],pointx[3],pointy[3],pointx[4],pointy[4],pointx[5],pointy[5],pointx[6],pointy[6],pointx[7],pointy[7]);	
			num_used = parseInt(player.GetIceAreaPtVaild(1));
			$("#jsPerimeterPonitNum").val(num_used);
		
			for(var i=1; i<=num_used; i++)
			{
				$("#jsPerimeterPonitX"+i.toString()).val(Math.round(parseInt(player.GetIceAreaPtX(1, i-1))/4.8));	
				$("#jsPerimeterPonitY"+i.toString()).val(Math.round(parseInt(player.GetIceAreaPtY(1, i-1))/2.7));	
			}
		}
		else if(index == 2)
		{
			var Xs;
			var Ys;
			var Xe;
			var Ye;
		
			//player.GetTripwireParam(Xs, Ys, Xe, Ye);	
			$("#jsTripWirePonitX1").val(Math.round(parseInt(player.GetIceLineX(2, 0, 0))/4.8));
			$("#jsTripWirePonitY1").val(Math.round(parseInt(player.GetIceLineY(2, 0, 0))/2.7));
			$("#jsTripWirePonitX2").val(Math.round(parseInt(player.GetIceLineX(2, 0, 1))/4.8));
			$("#jsTripWirePonitY2").val(Math.round(parseInt(player.GetIceLineY(2, 0, 1))/2.7));
			
			if(Boolean($("#jsTripWireCheckbox").attr("checked")))
			{
				$("#jsTripWireCheckbox").val(1);		
			}
			else {
				$("#jsTripWireCheckbox").val(0);	
			}
		}
		else if(index == 3)
		{
			//player.GetMtripwireParam(pointx[0],pointy[0],pointx[1],pointy[1],pointx[2],pointy[2],pointx[3],pointy[3]);	
			$("#jsMTripWirePonitX11").val(Math.round(parseInt(player.GetIceLineX(3, 0, 0))/4.8));
			$("#jsMTripWirePonitY11").val(Math.round(parseInt(player.GetIceLineY(3, 0, 0))/2.7));
			$("#jsMTripWirePonitX12").val(Math.round(parseInt(player.GetIceLineX(3, 0, 1))/4.8));
			$("#jsMTripWirePonitY12").val(Math.round(parseInt(player.GetIceLineY(3, 0, 1))/2.7));
			$("#jsMTripWirePonitX21").val(Math.round(parseInt(player.GetIceLineX(3, 1, 0))/4.8));
			$("#jsMTripWirePonitY21").val(Math.round(parseInt(player.GetIceLineY(3, 1, 0))/2.7));
			$("#jsMTripWirePonitX22").val(Math.round(parseInt(player.GetIceLineX(3, 1, 1))/4.8));
			$("#jsMTripWirePonitY22").val(Math.round(parseInt(player.GetIceLineY(3, 1, 1))/2.7));
		}
		else if(index == 4)
		{
			//player.GetIceAreaParam(num_used,pointx[0],pointy[0],pointx[1],pointy[1],pointx[2],pointy[2],pointx[3],pointy[3],pointx[4],pointy[4],pointx[5],pointy[5],pointx[6],pointy[6],pointx[7],pointy[7]);
			num_used = parseInt(player.GetIceAreaPtVaild(4));
			$("#jsLoterPonitNum").val(num_used);
			
			for(var i=1; i<=num_used; i++)
			{
				$("#jsLoterPonitX"+i.toString()).val(Math.round(parseInt(player.GetIceAreaPtX(4, i-1))/4.8));
				$("#jsLoterPonitY"+i.toString()).val(Math.round(parseInt(player.GetIceAreaPtY(4, i-1))/2.7));
			}
		}
		else if(index == 5)
		{
			var pxs;
			var pys;
			var pxe;
			var pye;
			//player.GetConverseParam(pxs,pys,pxe,pye,num_used,pointx[0],pointy[0],pointx[1],pointy[1],pointx[2],pointy[2],pointx[3],pointy[3],pointx[4],pointy[4],pointx[5],pointy[5],pointx[6],pointy[6],pointx[7],pointy[7]);
			$("#jsConverseDirXs").val(Math.round(parseInt(player.GetIceLineX(5, 0, 0))/4.8));
			$("#jsConverseDirYs").val(Math.round(parseInt(player.GetIceLineY(5, 0, 0))/2.7));
			$("#jsConverseDirXe").val(Math.round(parseInt(player.GetIceLineX(5, 0, 1))/4.8));
			$("#jsConverseDirYe").val(Math.round(parseInt(player.GetIceLineY(5, 0, 1))/2.7));
			
			num_used = parseInt(player.GetIceAreaPtVaild(5));
		
			$("#jsConversePonitNum").val(num_used);
			for(var i=1; i<=num_used; i++)
			{
				$("#jsConversePonitX"+i.toString()).val(Math.round(parseInt(player.GetIceAreaPtX(5, i-1))/4.8));
				$("#jsConversePonitY"+i.toString()).val(Math.round(parseInt(player.GetIceAreaPtY(5, i-1))/2.7));
			}
		}
		
	} 
	else {
		$("#js"+arryDtcaID[index]+"RuleEnable").val(0);	
	}


	/*参数改变需要重新配置算法库*/	
	ICEDtcaPushStop();
	
	/*检测是否开启位置推送*/
	setTimeout("ICEDtcaPush();", 3000);

	$("#DTCAForm").submit();
}

/*=================== hcnt ===================*/
function ICEHcntDrawEnable(enable)
{
	if(enable == 1)
	{
		player.StartHumanNumDrawIce();
	}
	else {
		player.StopHumanNumDrawIce();	
	}	
}

function ICEHcntSetDisplay()
{
	var startX = Math.round(parseInt($("#jsHcntBaselineStartX").val())*4.8);
	var startY = Math.round(parseInt($("#jsHcntBaselineStartY").val())*2.7);
	var endX = Math.round(parseInt($("#jsHcntBaselineEndX").val())*4.8);
	var endY = Math.round(parseInt($("#jsHcntBaselineEndY").val())*2.7);
	
	player.SetHumanNumIceParam(startX,startY,endX,endY);	
}


function ICEHcntInit()
{
	if($("#jsHcntClbrCheckbox").val() == 1)
	{
		$("#jsHcntClbrCheckbox").attr("checked", true);
	}
	else {
		$("#jsHcntClbrCheckbox").attr("checked", false);	
	}
	
	//调用控件接口将基线坐标传给控件
	ICEHcntSetDisplay();
}
	
function ICEHcntBaselineDraw()
{
	//调用控件接口start
	$("#jsHcntBaselineDraw").attr("disabled", true);	
	$("#divHcntSetButton").attr("disabled", true);
	//使能绘图
	player.EnableHumanNumIce(true);
}

function ICEHcntBaselineDrawOk()
{
	if(!Boolean($("#jsHcntBaselineDraw").attr("disabled")))
	{
		return;	
	}
	
	$("#jsHcntBaselineDraw").attr("disabled", false);	
	$("#divHcntSetButton").attr("disabled", false);
	
	var startX = Math.round(parseInt(player.GetHumanNumIceLineX(0))/4.8);
	var startY = Math.round(parseInt(player.GetHumanNumIceLineY(0))/2.7);
	var endX = Math.round(parseInt(player.GetHumanNumIceLineX(1))/4.8);
	var endY = Math.round(parseInt(player.GetHumanNumIceLineY(1))/2.7);
	
	$("#jsHcntBaselineStartX").val(startX);
	$("#jsHcntBaselineStartY").val(startY);
	$("#jsHcntBaselineEndX").val(endX);
	$("#jsHcntBaselineEndY").val(endY);
	
	//禁止绘图
	player.EnableHumanNumIce(false);
}

function ICEHcntBaselineCancel()
{
	if(!Boolean($("#jsHcntBaselineDraw").attr("disabled")))
	{
		return;	
	}
	
	$("#jsHcntBaselineDraw").attr("disabled", false);	
	$("#divHcntSetButton").attr("disabled", false);
	
	//禁止绘图
	player.EnableHumanNumIce(false);
	
	ICEHcntSetDisplay();
}

function ICEHcntClbrChecked()
{
	if(Boolean($("#jsHcntClbrCheckbox").attr("checked")))
	{
		$("#jsHcntClbrCheckbox").val(1);
	} else {
		$("#jsHcntClbrCheckbox").val(0);	
	}
}

function ICEHcntSubmit(state)
{
	$("#jsHCNTFlag").val(state);
	
	$("#jsHCNTForm").submit();
}

/*============================ clbr ================================*/
function ICEClbrEnable(enable)
{
	try{
		if(enable == 1)	
		{
			player.StartDepthDrawIce();
		}
		else {
			player.StopDepthDrawIce();	
		}
	}catch(e){}
}

function FdtSubmit()
{
	$("#FdtForm").submit();
}


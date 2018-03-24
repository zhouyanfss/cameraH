// JavaScript Document
var jsVideoNow = "none";
var jsVideoList = "none";
var player = null;
var DragObj = null;
var OSDtimeout = 0;
var ActiveObj = null;
var ActiveTimeout = null;
var alarmAreaShowID = 0;
var resolution_old = 5;
var ext_resolution_old = 29;
var dialog_waiting = 0;
var emode_old=5;
var major_payload;
var minor_payload;
var resizeTimer = null;
$(window).on('resize', function () {
        if (resizeTimer) {
            clearTimeout(resizeTimer)
        }
        resizeTimer = setTimeout(function(){
			window_resize();
        }, 100);
    }
);

function window_resize(){
	window.scroll(0,0);
	if($(window).height()< 400)
	{
		$(".topMenu:first").css({"position":"absolute","z-index":"2"});
		$(".videoWindow:first").css({"position":"absolute"});
	}
	else
	{
		$(".topMenu:first").css({"position":"fixed","z-index":"2"});
		$(".videoWindow:first").css({"position":"fixed","z-index":"1"});
	}
}

function refreshPlayer(){
	var iframeWin = document.getElementById("jsVedioIframe").contentWindow || document.frames["jsVedioIframe"];
	player = iframeWin.document.getElementById("Player");
	if(!player){
		setTimeout(arguments.callee, 100);
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
	liChoose.css({"background-color": ""});
	hankType.eq(num).css("display", "block");
	liChoose.eq(num).css({"background-color": "#e9e6e6"});
	
	if( 2 == jsVideoNow)
	{
		videoChanged('mainVideoForm', 0);
		player = null;
		jsVideoNow = 2;
		if(2 == num || 3 == num)
		{
			if(navigator.userAgent.indexOf("Safari") != -1 && navigator.userAgent.indexOf("Chrome") == -1)
				$("#jsVedioIframe").attr( "src", "../video/videoSetPage_sf.htm?video=" + num);
			else if(navigator.userAgent.indexOf("Chrome") == -1 && navigator.userAgent.indexOf("Firefox") == -1)
				$("#jsVedioIframe").attr( "src", "../video/videoSetPage.htm?video=" + num);
			else
				$("#jsVedioIframe").attr( "src", "../video/videoSetPage_ff.htm?video=" + num);
		}
		else
		{
			if(navigator.userAgent.indexOf("Safari") != -1 && navigator.userAgent.indexOf("Chrome") == -1)
				$("#jsVedioIframe").attr( "src", "../video/videoSetPage_sf.htm?video=0");
			else if(navigator.userAgent.indexOf("Chrome") == -1 && navigator.userAgent.indexOf("Firefox") == -1)
				$("#jsVedioIframe").attr( "src", "../video/videoSetPage.htm?video=0");
			else
				$("#jsVedioIframe").attr( "src", "../video/videoSetPage_ff.htm?video=0");
		}
	}
	else if( 1 == jsVideoNow)
	{
		videoChanged('mainVideoForm', 1);
		jsVideoNow = 1;
	}

	if(2 == jsVideoList)
	{
		try{
			player.StopShowHikMtnRct();	
		}catch(e){};
	}
	if( 3 == jsVideoList)
	{
		try{
			player.ShowPSRect(0);
			for(var i = 1; i < 5; i++)
			{
				if( $("#jsPrivacy"+i+"Res:enabled").attr("id") )
					privacyAreaReset(i);
			}
			privacyOperateRes();
			try{player.EnableVectorControl(true);}catch(e){};
		}catch(e){};
	}	
	else if( 4 == jsVideoList)
	{
		try{
			player.ShowMotionDetect(0);
			for(var i = 1; i < 5; i++){
				if( $("#jsRoi"+i+"Res:enabled").attr("id") )
					roiAreaReset(i);
			}
			roiOperateRes();
			try{player.EnableVectorControl(true);}catch(e){};
		}catch(e){};
	}	
	
	if( 2 == num)
	{	
		if(jsVideoNow != 0)
		{
			setTimeout(function(){
				try{
					player.StartShowHikMtnRct();
					player.GetHikMtnRct();
				}catch(e){};
			},500);
		}
		else
		{
			try{
				player.StartShowHikMtnRct();
				player.GetHikMtnRct();
			}catch(e){};
		}
		$(function(){
		});
	}
	else if( 3 == num)
	{
		try{player.ShowPSRect(1);player.EnableVectorControl(false);}catch(e){};
	}
	else if( 4 == num)
	{
		try{player.EnableVectorControl(false);}catch(e){};
		if(jsVideoNow != 0)
		{
			setTimeout(function(){
				try{player.EnableVectorControl(false);}catch(e){};
				for( var i = 1; i < 5; i++ ){
					if($("#jsRoi"+i+"Checkbox").attr("checked"))
					{
						roiAreaAdd(i);
					}
				}
			},500);
		}
		else
		{
			for( var i = 1; i < 5; i++ ){
				if($("#jsRoi"+i+"Checkbox").attr("checked"))
					roiAreaAdd(i);
			}
		}
		try{player.ShowMotionDetect(1);}catch(e){};
	}
	
	jsVideoNow = 0;
	jsVideoList = num;

	window.scroll(0,0);
	/*if( 2 == jsVideoNow)
	{
		videoChanged('mainVideoForm', 0);
		player = null;
		jsVideoNow = 0;
		if( (2==num)||(3==num) )
		{
			if(navigator.userAgent.indexOf("Safari") != -1 && navigator.userAgent.indexOf("Chrome") == -1)
				$("#jsVedioIframe").attr( "src", "../video/videoSetPage_sf.htm?video=" + num);
			else if(navigator.userAgent.indexOf("Chrome") == -1 && navigator.userAgent.indexOf("Firefox") == -1)
				$("#jsVedioIframe").attr( "src", "../video/videoSetPage.htm?video=" + num);
			else
				$("#jsVedioIframe").attr( "src", "../video/videoSetPage_ff.htm?video=" + num);
		}
		else
		{
			if(navigator.userAgent.indexOf("Safari") != -1 && navigator.userAgent.indexOf("Chrome") == -1)
				$("#jsVedioIframe").attr( "src", "../video/videoSetPage_sf.htm?video=0");
			else if(navigator.userAgent.indexOf("Chrome") == -1 && navigator.userAgent.indexOf("Firefox") == -1)
				$("#jsVedioIframe").attr( "src", "../video/videoSetPage.htm?video=0");
			else
				$("#jsVedioIframe").attr( "src", "../video/videoSetPage_ff.htm?video=0");
		}
	}
	else
	{
		if( 1 == jsVideoNow)
		{
			videoChanged('mainVideoForm', 1);
			jsVideoNow = 1;
		}
		if( 2 == num)
		{
			if(parseInt($("#motionSwitchGet").val())){
				var showMotionArea = 
						function(){
							try{
								for( var i = 1; i < 5; i++ ){
									if($("#jsMotion"+i+"Checkbox").attr("checked"))
										motionAreaAdd(i);
								};
								player.ShowMotionDetect(1);
							//justin add 2013.5.31
							player.SetPTZControlMode(0);
							player.EnableVectorControl(false);
							}catch(e){};
						};
				setTimeout(function(){
					showMotionArea();
					alarmAreaShowID=setInterval(alarmAreaShow,500);
				},parseInt(300*jsVideoNow));
			}
		}
		else if( 2 == jsVideoList)
		{
			try{
				player.ShowMotionDetect(0);
				for(var i = 1; i < 5; i++){
					if( $("#jsMotion"+i+"Res:enabled").attr("id") )
						motionAreaReset(i);
				}
				motionOperateRes();
				player.EnableVectorControl(true);	//justin add 2013.5.31
				player.SetPTZControlMode(1);
			}catch(e){};
		}
		
		if( 3 == num)
		{
			try{player.ShowPSRect(1);player.EnableVectorControl(false);}catch(e){};
		}
		else if( 3 == jsVideoList)
		{
			try{
				player.ShowPSRect(0);
				for(var i = 1; i < 5; i++){
					if( $("#jsPrivacy"+i+"Res:enabled").attr("id") )
						privacyAreaReset(i);
				}
				privacyOperateRes();
				player.EnableVectorControl(true);	//justin add 2013.5.31
			}catch(e){};
		}
	}
	
	jsVideoNow = 0;
	if(2 == num)
	{
		getMotionActive();
	}
	else if(2 == jsVideoList)
	{
		clearTimeout(ActiveTimeout);
	}
	
	jsVideoList = num;
	if(2 != num)
	{
		clearInterval(alarmAreaShowID);
	}
	
	if(num == 6)
	{
		player.StartShowHikMtnRct();
		player.GetHikMtnRct();	
	}
	else {
		player.StopShowHikMtnRct();	
	}*/
	
}

function EmodeCheck()
{
	if($("#EmodeControl").val() == '4')
		$("#PanelEPTZ_Cfg").show();
	else
		$("#PanelEPTZ_Cfg").hide();

	if($("#ExtEmodeControl").val() == '4')
		$("#ExtPanelEPTZ_Cfg").show();
	else
		$("#ExtPanelEPTZ_Cfg").hide();
}

function CheckFramerate()
{
	return;
	if(parseInt($("#Hi3518E").val()) == 1)
	{
		$("#jsFrameRate").find("option[value='30']").remove();
		$("#jsExtFrameRate").find("option").remove();
		if($("#jsExtResolution").val() == "6")
		{
			$("#jsExtFrameRate").append("<option value='5'>5</option>");
			$("#jsExtFrameRate").append("<option value='3'>3</option>");
		}
		else if($("#jsExtResolution").val() == "2" || $("#jsExtResolution").val() == "28" || $("#jsExtResolution").val() == "24")
		{
			$("#jsExtFrameRate").append("<option value='20'>20</option>");
			$("#jsExtFrameRate").append("<option value='15'>15</option>");
			$("#jsExtFrameRate").append("<option value='10'>10</option>");
			$("#jsExtFrameRate").append("<option value='5'>5</option>");
			$("#jsExtFrameRate").append("<option value='3'>3</option>");
		}
		else
		{
			$("#jsExtFrameRate").append("<option value='25'>25</option>");
			$("#jsExtFrameRate").append("<option value='20'>20</option>");
			$("#jsExtFrameRate").append("<option value='15'>15</option>");
			$("#jsExtFrameRate").append("<option value='10'>10</option>");
			$("#jsExtFrameRate").append("<option value='5'>5</option>");
			$("#jsExtFrameRate").append("<option value='3'>3</option>");
		}
	}
}

function videoInit(){
	var devDiscription = getCookie("BSDdev");
	var deviceID = top.topFrame.document.getElementById('deviceIDGet').value;
	var devicdInt = parseInt(deviceID);
	var res_fake = parseInt($("#res_fake").val());
	var res_limit = parseInt($("#res_limit").val());
	LANGUAGE = parseInt($("#PAGE_LANGUAGE").val());
	window_resize();
	if($("#motionSwitchGet").val() == 1){
		$("div[class^='ptzDiv']").css("opacity",0.6).find("select").attr("disabled",true);
		$(".divTransparent").css("visibility","visible");
	}
	var dataGet;
	//var deviceID = getCookie("dev");
	var deviceID = top.topFrame.document.getElementById('deviceIDGet').value;
	var devicdInt = parseInt(deviceID);
	var chipID = top.topFrame.document.getElementById('chipIDGet').value;
	if(parseInt(chipID) == 1)
	{
		$(".gokehide").hide();
		$("#jsFrameRate").find("option[value='30']").remove();
		$("#jsExtFrameRate").find("option[value='30']").remove();
		$("#jsExtResolution").find("option[value='1']").remove();
		$("#jsMJPEGframeRate").find("option[value='30']").remove();
		$("#jsAudioFormat").find("option[value='4']").remove();
	}
	else if(parseInt(chipID) == 2)
	{
		$(".mstarhide").hide();
		$("#PayloadSelect,#ExtPayloadSelect").show();
		$("#jsResolution").find("option[value='8']").remove();
		$("#jsResolution").find("option[value='16']").remove();
		$("#jsResolution").find("option[value='17']").remove();
		$("#jsResolution").find("option[value='6']").remove();
		$("#jsExtResolution").find("option[value='24']").remove();
		$("#jsExtResolution").find("option[value='2']").remove();
		$("#jsExtResolution").find("option[value='28']").remove();
		$("#jsExtResolution").find("option[value='1']").remove();
		$("#jsExtResolution").find("option[value='0']").remove();
		
	}
	else if(parseInt(chipID) == 3)
	{
		$("#jsResolution").find("option[value='16']").remove();
		$("#jsResolution").find("option[value='17']").remove();
		$("#jsResolution").find("option[value='6']").remove();
		$("#jsExtResolution").find("option[value='1']").remove();
		$("#jsExtResolution").find("option[value='0']").remove();
		$("#jsMJPEGresolution").find("option[value='8']").remove();
		$("#jsMJPEGresolution").find("option[value='0']").remove();
		$("#jsAudioFormat").find("option[value='3']").remove();
		$("#jsAudioFormat").find("option[value='4']").remove();
		$("#MJPEGform").hide();
		$("#Multiple_Osd,#Multiple_size").hide();
		if (devicdInt == 133) {
			$("#jsResolution").find("option[value='8']").remove();
		}
	}

	if(parseInt($("#SHDBType").val()) == 0)
	{
		$("#jsExtResolution").find("option[value='16']").remove();
		$("#jsExtResolution").find("option[value='17']").remove();
	}

	//For Mjpeg: Only AR0130 has 960P 
	if(devicdInt != 150 && devicdInt != 151 && devicdInt != 140 && devicdInt != 141)
	{
		$("#jsMJPEGresolution").find("option[value='8']").remove();
	}
	//For Major: If not 2.0M sensor, remove 1080P
	if(devicdInt < 158)
	{
		if(res_fake < 4)
		{
			$("#jsResolution").find("option[value='33']").remove();
			$("#jsMJPEGresolution").find("option[value='33']").remove();
		}
		if(res_fake < 3)
		{
			$("#jsResolution").find("option[value='32']").remove();
			$("#jsMJPEGresolution").find("option[value='32']").remove();
		}
		if(res_fake < 2)
		{
			$("#jsResolution").find("option[value='31']").remove();
			$("#jsMJPEGresolution").find("option[value='31']").remove();
			$("#jsResolution").find("option[value='12']").remove();
			$("#jsMJPEGresolution").find("option[value='12']").remove();
		}
		if(res_fake < 1)
		{
			$("#jsResolution").find("option[value='10']").remove();
			$("#jsMJPEGresolution").find("option[value='10']").remove();
		}
		//For Major: If not 1.3M sensor, remove 960P
		/*if(devicdInt != 148 && devicdInt != 149 && devicdInt != 150 && devicdInt != 151 && devicdInt != 140 && devicdInt != 141 && devicdInt != 142 && devicdInt != 143 && devicdInt != 146 && devicdInt != 147)
		{
			$("#jsResolution").find("option[value='8']").remove();
		}
		if(parseInt($("#Hi3518E").val()) == 1 && (devicdInt == 152 || devicdInt == 153 || devicdInt == 156 || devicdInt == 157))
		{
			$("#jsResolution").find("option[value='8']").remove();
		}*/
		if(devicdInt == 152 || devicdInt == 153 || devicdInt == 156 || devicdInt == 157 || devicdInt == 136 || devicdInt == 137 || devicdInt == 134 || devicdInt == 135)
		{
			$("#jsResolution").find("option[value='8']").remove();
		}
	}
	else if(devicdInt == 208)
	{
		$("#jsResolution").find("option[value='33']").remove();
		$("#jsResolution").find("option[value='12']").remove();
		$("#jsResolution").find("option[value='16']").remove();
		$("#jsResolution").find("option[value='17']").remove();
		$("#jsResolution").find("option[value='6']").remove();
	}
	else if(devicdInt == 206)
	{
		$("#jsResolution").find("option[value='33']").remove();
		$("#jsResolution").find("option[value='32']").remove();
		$("#jsResolution").find("option[value='31']").remove();
		$("#jsResolution").find("option[value='16']").remove();
		$("#jsResolution").find("option[value='17']").remove();
		$("#jsResolution").find("option[value='6']").remove();
	}
	else if(devicdInt < 206 || devicdInt > 239)	// if not 3M or 5M remove
	{	

		if(res_fake < 4)
		{
			$("#jsResolution").find("option[value='33']").remove();
			$("#jsMJPEGresolution").find("option[value='33']").remove();
		}
		if(res_fake < 3)
		{
			$("#jsResolution").find("option[value='32']").remove();
			$("#jsMJPEGresolution").find("option[value='32']").remove();
		}
		if(res_fake < 2)
		{
			$("#jsResolution").find("option[value='31']").remove();
			$("#jsMJPEGresolution").find("option[value='31']").remove();
			$("#jsResolution").find("option[value='12']").remove();
			$("#jsMJPEGresolution").find("option[value='12']").remove();
		}
		if(res_limit == 1 && res_fake < 1)
		{
			$("#jsResolution").find("option[value='10']").remove();
		}
	}
	
	//贝斯得3518EV200 0803虚假帧率
	if(devDiscription == '1')
	{
		if(parseInt($("#Hi3518EV200").val()) == 1 && devicdInt == 176)
		{
			$("#jsFrameRate").find("option[value='30']").remove();
			$("#jsFrameRate").find("option[value='20']").remove();	
			$("#jsExtFrameRate").find("option[value='30']").remove();
			$("#jsExtFrameRate").find("option[value='20']").remove();	
		}
	}

	if(parseInt($("#Hi3518EV200").val()) == 3)
	{
		if(devicdInt < 206 && devicdInt >= 158)
		{
			$("#jsResolution").find("option[value='10']").remove();
			$("#jsResolution").find("option[value='8']").remove();
		}
	}
	
	if(parseInt($("#Hi3518EV200").val()) == 1 || parseInt($("#Hi3518EV200").val()) == 2)
	{
		if(devicdInt == 150 || devicdInt == 151 || devicdInt == 140 || devicdInt == 141 || devicdInt == 126 || devicdInt == 127)
		{
			$("#jsMJPEGresolution").find("option[value='8']").remove();
		}
	}

	if(parseInt($("#area_check").val()) != 1 && parseInt($("#Hi3516A").val()) == 0 && devicdInt !=240 && devicdInt !=241 && parseInt($("#Hi3518EV200").val()) != 2)
	{
		$("#jsMJPEGresolution").find("option[value='10']").remove();
	}
	if(parseInt($("#Hi3516A").val()) == 0 || (devicdInt >= 206 && devicdInt < 240))
	{
		$("#jsMJPEGframeRate").find("option[value='30']").remove();
		$("#jsMJPEGframeRate").find("option[value='25']").remove();
		$("#jsMJPEGframeRate").find("option[value='20']").remove();
		$("#jsMJPEGframeRate").find("option[value='15']").remove();
		$("#jsMJPEGframeRate").find("option[value='10']").remove();
	}
	if(devicdInt == 240 || devicdInt == 241)
	{
		$("#jsMJPEGresolution").find("option[value='0']").remove();
	}
	if(parseInt($("#Hi3518E").val()) == 1)
	{
		if($("#WifiResource_Get").val()!='0' && $("#WifiKit_Get").val()=='0')
		{
			$("#jsExtResolution").find("option[value='6']").remove();
			$("#jsExtResolution").find("option[value='24']").remove();
		}
		$("#jsResolution").find("option[value='16']").remove();
		$("#jsResolution").find("option[value='17']").remove();
	}
	
	//IMX385
	if(parseInt($("#Hi3516A").val()) == 0 && devicdInt == 184) 
	{
		$(".hisihide").hide();
	}
	
	//justin add for 4k
	if(devicdInt == 222 || devicdInt == 224 || devicdInt == 226)
	{
		$(".hisihide").hide();
		$("#PayloadSelect,#ExtPayloadSelect").show();
		$("#jsResolution").find("option[value='5']").remove();
		$("#jsResolution").find("option[value='6']").remove();
		$("#jsResolution").find("option[value='8']").remove();
		$("#jsResolution").find("option[value='16']").remove();
		$("#jsResolution").find("option[value='17']").remove();
	}
	else 
	{
		$("#jsResolution").find("option[value='34']").remove();
		$("#jsExtResolution").find("option[value='5']").remove();
		$("#jsMJPEGresolution").find("option[value='34']").remove();
	}
	
	CheckFramerate();
	if(parseInt($("#Full60fps").val()) == 1)
	{
		$("#jsFrameRate").prepend("<option value='40'>40</option>");
		$("#jsFrameRate").prepend("<option value='50'>50</option>");
		if(parseInt($("#PFR_").val()) == 60)
			$("#jsFrameRate").prepend("<option value='60'>60</option>");
		$("#jsExtFrameRate").prepend("<option value='40'>40</option>");
		$("#jsExtFrameRate").prepend("<option value='50'>50</option>");
		if(parseInt($("#PFR_").val()) == 60)
			$("#jsExtFrameRate").prepend("<option value='60'>60</option>");
		setTimeout('$("#jsFrameRate").val($("#frameRate").val());',10);
		setTimeout('$("#jsExtFrameRate").val($("#ExtFrameRate").val());',10);
	}

/*主码流当前设置参数*/	
	$("#jsResolution").val($('#resolution').val());
	//贝斯得3518EV200 0803虚假帧率
	if(devDiscription == '1')
	{
		if(parseInt($("#Hi3518EV200").val()) == 1 && devicdInt == 176 && parseInt($('#frameRate').val()) == 15)
		{
			$("#jsFrameRate").val(25);
		}
		else {
			$("#jsFrameRate").val($('#frameRate').val());	
		}
	}
	else {
		$("#jsFrameRate").val($('#frameRate').val());
	}
	if(parseInt($("#Hi3518EV200").val()) != 0)
	{
		$("#maxStreamLimit2").show();
		$("maxStreamLimit_2").show();
		$("#maxStreamLimit_1").remove();
		$("#maxStreamLimit1").remove();
		$("#jsBitRateTop").val(parseInt($('#bitRateTop').val()/1000));
		$('#bitRateTop').val($("#jsBitRateTop").val());
	}
	else
	{
		$("#maxStreamLimit1").show();
		$("#maxStreamLimit_1").show();
		$("#maxStreamLimit2").remove();
		$("#maxStreamLimit_2").remove();
		$("#jsBitRateTop").val(parseInt($('#bitRateTop').val()/1000));
		$('#bitRateTop').val($("#jsBitRateTop").val());
	}

	$("#jsBitRateControl").val($('#bitRateControl').val());
	$("#jsIPrate").val($('#IPrate').val());
	$("#Payload").val($('#Payload_').val());
	major_payload = $('#Payload_').val();
	$("#jsQuality").val($('#Quality').val());
	if($('#bitRateControl').val() != 0)
	{
		$('#jsQuality').disabled = true;
	}
	frameRateLimit();
	resolution_old = parseInt($('#resolution').val());
	if(devicdInt == 240 || devicdInt == 241)//PCD
	{
		emode_old = $("#Emode").val();
	
		$("#EmodeControl").val($("#Emode").val());
		$("#PanelEPTZ_HPan").val($("#EptzH").val());
		$("#PanelEPTZ_VPan").val($("#EptzV").val());
		$("#PanelEPTZ_Tilt").val($("#EptzT").val());
		$("#PanelEPTZ_Zoom").val($("#EptzZ").val());
	}
/******************************************/

/*副码流当前设置参数*/
	$("#jsExtResolution").val($("#ExtResolution").val());
	//贝斯得3518EV200 0803虚假帧率
	if(devDiscription == '1')
	{
		if(parseInt($("#Hi3518EV200").val()) == 1 && devicdInt == 176 && parseInt($('#ExtFrameRate').val()) == 15)
		{
			$("#jsExtFrameRate").val(25);
		}
		else {
			$("#jsExtFrameRate").val($('#ExtFrameRate').val());	
		}
	}
	else {
		$("#jsExtFrameRate").val($('#ExtFrameRate').val());
	}
	$("#jsExtBitRateControl").val($("#ExtBitRateControl").val());
	$("#jsExtBitRateTop").val(parseInt($("#ExtBitRateTop").val()/1000));
	$("#ExtBitRateTop").val($("#jsExtBitRateTop").val());
	$("#jsExtIPrate").val($("#ExtIPrate").val());
	$("#ExtPayload").val($('#ExtPayload_').val());
	minor_payload = $('#ExtPayload_').val();
	$("#jsExtQuality").val($('#ExtQuality').val());
	if($('#ExtBitRateControl').val() != 0)
	{
		$('#jsExtQuality').disabled = true;
	}
	ext_resolution_old = parseInt($('#ExtResolution').val());

	if(parseInt($("#Hi3516A").val()) != 0 || parseInt($("#Hi3516CV300").val()) != 0 || parseInt($("#Hi3519").val()) != 0)
	{
		$("#PayloadSelect,#ExtPayloadSelect").show();
	}
	
	if(devicdInt == 240 || devicdInt == 241)//PCD
	{
		$("#ExtEmodeControl").val($("#ExtEmode").val());
		$("#ExtPanelEPTZ_HPan").val($("#ExtEptzH").val());
		$("#ExtPanelEPTZ_VPan").val($("#ExtEptzV").val());
		$("#ExtPanelEPTZ_Tilt").val($("#ExtEptzT").val());
		$("#ExtPanelEPTZ_Zoom").val($("#ExtEptzZ").val());
		EmodeCheck();
	}
/*************************************/

/*MJPEG当前设置参数*/
	$("#jsMJPEGresolution").val($('#MJPEGresolution').val());
	$("#jsMJPEGframeRate").val($('#MJPEGframeRate').val());
	$("#jsMJPEGQuality").val($('#MJPEGQuality').val());
/********************/

	if(parseInt($("#Hi3518E").val()) == 1)
		$("#MJPEGform").hide();
	else if(parseInt($("#Hi3518EV200").val()) == 3)
		$("#MJPEGform,#extVideoForm").hide();
		
	$("#firstPage").css("display", "block");
	
/*视频播放初始化**********/
	videoChanged("mainVideoForm", 1);
/*************************/

/*****OSD*************/
	for( var i = 1; i < 6; i++ ){
		dataGet = Boolean( parseInt($("#Text"+i.toString()+"OSDEnable").val()) );
		if( dataGet){
			$("#jsText"+i.toString()+"OSDstate1").attr( "checked",true);
		}else{
			$("#jsText"+i.toString()+"OSDstate0").attr( "checked",true);
		}
		$("#jsOSD"+i.toString()+"Size").val($("#OSD"+i.toString()+"SizeGet").val());
		textOSDchanged(i,dataGet);
		$("#OSD"+i.toString()+"Text").keyup();
		//if(i < 3)
		{
			var DOMtext = $("#OSD"+i+"Text");
			dateGet = DOMtext.val().replace(/[ ]$/, '').replace(/[ ]$/, '').replace(/[ ]$/, '');
			DOMtext.val(dateGet);
		}
	}
	for( i = 1; i < 5; i++){
		DOMtext = $("#jsMotion"+i+"Name");
		dateGet = DOMtext.val().replace(/[ ]$/, '').replace(/[ ]$/, '').replace(/[ ]$/, '');
		DOMtext.val(dateGet);
		DOMtext = $("#jsPrivacy"+i+"Name");
		dateGet = DOMtext.val().replace(/[ ]$/, '').replace(/[ ]$/, '').replace(/[ ]$/, '');
		DOMtext.val(dateGet);
	}
	
	dateGet = Boolean( parseInt($("#MultipleOSDEnable").val()) );
	if( dateGet){
		$("#jsMultipleOSDstate1").attr( "checked",true);
	}else{
		$("#jsMultipleOSDstate0").attr( "checked",true);
	}
	$("#jsMultipleOSDSize").val($("#MultipleSizeGet").val());
	MultipleOSDchanged(dateGet);
	$("input[type='text'][id$='OSDx']").bind("blur", function(){osdXYcheck(this)});
	$("input[type='text'][id$='OSDy']").bind("blur", function(){osdXYcheck(this)});

	dateGet = Boolean( parseInt($("#TimeOSDEnable").val()) );
	if( dateGet){
		$("#jsTimeOSDstate1").attr( "checked",true);
	}else{
		$("#jsTimeOSDstate0").attr( "checked",true);
	}
	$("#jsDTimeOSDSize").val($("#DTimeSizeGet").val());
	timeOSDchanged(dateGet);
	$("input[type='text'][id$='OSDx']").bind("blur", function(){osdXYcheck(this)});
	$("input[type='text'][id$='OSDy']").bind("blur", function(){osdXYcheck(this)});

	if($("#Multiple_enable").val() == 1){
		$("#Multiple_Osd").hide();
		$("#Multiple_size").hide();
	}
	
/***************************/

/*移动侦测******************/
	/*DragObj = new Slider();
	for(var i = 1; i < 5; i++){
		dataGet = Boolean( parseInt($("#jsMotion" + i.toString() + "Active").val()) );
		var checkBox = $("#jsMotion"+i+"Checkbox");
		if(dataGet){
			checkBox.attr("checked", true);
		}
		var sensValue = $("#jsMotion"+i+"Sens").val();
		$("#jsMotion"+i+"Sback").val(sensValue );
		$("#jsMotion"+i+"Nback").val($("#jsMotion"+i+"Name").val());
		$("#jsMotion"+i+"SensLabel").text(sensValue);
		DragObj.value("jsSens"+i, 100-sensValue); //由于底层传输过来的为CGI统一的值，即100表示最不灵敏，所以此处取反来显示
		motionAreaEnable(i,"init");
	}
	dataGet = $("div[class^='areaSetContain']");
	dataGet.eq(0).click(function(){player.SetActiveMotionRect(0);});
	dataGet.eq(1).click(function(){player.SetActiveMotionRect(1);});
	dataGet.eq(2).click(function(){player.SetActiveMotionRect(2);});
	dataGet.eq(3).click(function(){player.SetActiveMotionRect(3);});
	for(var i = 1; i < 5; i++){
		$("#jsMotion"+i+"Sub").click(function(){return false;});
	}
	dataGet = Boolean( parseInt($("#motionSwitchGet").val()) );
	if(!dataGet){//移动侦测总开关关闭
		var DOMdiv = $(".areaSet").slice(0,4);
		DOMdiv.find("input").attr("disabled", true);
		DOMdiv.find("label").attr("disabled", true);
		for(var i = 1; i < 5; i++){
			DragObj.state("jsSens"+i, false);
		}
	}*/
	
	DragObj = new Slider();
	if(parseInt($("#jsMDEnable").val()) == 1)
	{
		$("#jsMDCheckbox").attr("checked", true);	
	}
	else {
		$("#jsMDCheckbox").attr("checked", false);		
	}
	
	var sensitivity = $("#jsMotion5Sens").val();
	
	/*$("#jsMotion5Sback").val(sensitivity);*/
	$("#jsMotion5SensLabel").text(sensitivity);
	
	DragObj.state("jsSens5", true);
	DragObj.value("jsSens5", 100-sensitivity); //由于底层传输过来的为CGI统一的值，即100表示最不灵敏，所以此处取反来显

	
/*隐私区域*************/
	for(var i = 1; i < 5; i++){
		var dataGet = Boolean( parseInt($("#jsPrivacy" + i.toString() + "Active").val()) );
		var checkBox = $("#jsPrivacy"+i+"Checkbox");
		if(dataGet){
			checkBox.attr("checked", true);
		}
		$("#jsPrivacy"+i+"Sback").val($("#jsPrivacy"+i+"Sens").val());
		$("#jsPrivacy"+i+"Nback").val($("#jsPrivacy"+i+"Name").val());
		privacyAreaEnable(i,"init");
	}
	dataGet = Boolean( parseInt($("#privacySwitchGet").val()) );
	if(!dataGet){//隐私区域总开关关闭
		var DOMdiv = $(".areaSet").slice(4,8);
		DOMdiv.find("input").attr("disabled", true);
		DOMdiv.find("label").attr("disabled", true);
	}

/*感兴趣区域*************/
	if(parseInt($("#Hi3516A").val()) == 0) {
		$("#roi_LI").hide();
	} else {
		$("#roi_LI").show();
	for(var i = 1; i < 5; i++){
		var dataGet = Boolean( parseInt($("#jsRoi" + i.toString() + "Active").val()) );
		var checkBox = $("#jsRoi"+i+"Checkbox");
		if(dataGet){
			checkBox.attr("checked", true);
		}
		$("#jsRoi"+i+"Level").val($("#jsRoi"+i+"Level_").val());
		roiAreaEnable(i,"init");
		}
	}
	
	
/*保存类型***********/
	$("#jsImageType").val($("#ImageTypeGet").val());
	$("#jsVideoType").val($("#VideoTypeGet").val());
	$("#jsShotPath").keydown(function(){return false;});
	$("#jsRecordPath").keydown(function(){return false;});
	
/**音频开关*****************/
	$("#jsAudioOnOff").val($("#AudioSwitch").val());
	$("#jsAudioFormat").val($("#AudioType").val());
	$("#jsAudioInput").val($("#AudioINPUT_").val());
	
	if(parseInt($("#Hi3518EV200").val()) != 0 || parseInt($("#Hi3518E").val()) != 0){
		$("#jsAudioFormat").find("option[value='4']").remove();
	}

	if(!IsSuperUser()){
		disabledAll();
		$("label[class^='OSDcontain']").attr("disabled", true);
		$(".areaName").attr("disabled", true);
		$(".motionSenstive").attr("disabled", true);
		$(".sensLabel").attr("disabled", true);
		$(".audioParaClass label").attr("disabled", true);
		$("div[class^='videoSetList'] label").attr("disabled", true);
		$(".sensExplain").attr("disabled", true);
		$("label[class^='ptzSelectLab']").attr("disabled", false);
		$("select[class^='ptzRowSelect']").attr("disabled", false);
		for(var i = 1; i < 5; i++){
			DragObj.state("jsSens"+i, false);
		}
	}
	//绑定1080p/30帧时提示及处理函数
	var limitNote = function(){
		if(0 && $("#jsResolution").val() == "10" && $("#jsFrameRate").val() == "30"){
			$("#limitNoteLab").show();
			$("#recordNoteLab").hide();
		}else{
			$("#limitNoteLab").hide();
			$("#jsExtResolution").change();
		}
	}
	$("#jsResolution").change(limitNote);
	$("#jsFrameRate").change(limitNote);
	$("#jsExtResolution").change(recordNote).change();
	//$("#jsExtFrameRate").val($("#ExtFrameRate").val());
	$("#jsMJPEGresolution").change(function(){
		if($("#jsExtVideo:disabled").val()){
			var resObj = $("#jsMJPEGresolution");
			var frtObj = $("#jsMJPEGframeRate");
			var resVal = parseInt(resObj.val());
			var frtVal =  parseInt(frtObj.val());
		}
		});
	$("#jsMJPEGresolution").change();
	
	//为了取消回格键造成视频框返回之前状态
	$(document).keydown(function(ev){
        	if("text" != $(ev.target).attr("type") && 8==ev.keyCode){
				return false;
			}
    });
	$(document).contextmenu(function(){return false});//屏蔽右键
	videoShow(0);
	jsVideoNow = 0.9;
	try{
		document.execCommand('BackgroundImageCache', false, true);
    }catch(e){
	};
}

function videoInit_Media(){
}

function videoInit_Rec(){
}

function BitRateSelect(formID){
	if("mainVideoForm" == formID){
		if($("#jsBitRateControl").val() != 0)
			$("#jsQuality").attr("disabled",true);
		else
			$("#jsQuality").attr("disabled",false);
	}else if("extVideoForm" == formID){
		if($("#jsExtBitRateControl").val() != 0)
			$("#jsExtQuality").attr("disabled",true);
		else
			$("#jsExtQuality").attr("disabled",false);
	}
}

function videoSet(formID){
	$("#jsBitRateTopActr").val($("#jsBitRateTop").val()*1000);
	$("#jsExtBitRateTopActr").val($("#jsExtBitRateTop").val()*1000);
	var waitTime = 40;
	var chipID = top.topFrame.document.getElementById('chipIDGet').value;
	var deviceID = top.topFrame.document.getElementById('deviceIDGet').value;
	var devicdInt = parseInt(deviceID);
	var flag = 0, extflag = 0;
	var refreshflag = 0;
	var play_mode = 0;
	if("mainVideoForm" == formID){
		if($("#Payload").val() != major_payload)
		{
			refreshflag = 1;
			major_payload = $("#Payload").val();
			play_mode = 0;
			if(parseInt($("#Hi3516CV300").val()) == 2) {
				waitTime = 20;
				flag = 1;
			}
		}
	}else if("extVideoForm" == formID){
		if($("#ExtPayload").val() != minor_payload)
		{
			refreshflag = 1;
			minor_payload = $("#ExtPayload").val();
			play_mode = 1;
			if(parseInt($("#Hi3516CV300").val()) == 2) {
				waitTime = 20;
				extflag = 1;
			}
		}
	}
	if("mainVideoForm" == formID){
		if(parseInt($("#Hi3518EV200").val()) == 3)
		{
			if(parseInt($("#jsResolution").val()) != resolution_old && (parseInt($("#jsResolution").val()) == 5 || resolution_old == 5))
			{
				waitTime = 45;
				flag = 1;
			}
		}
		else if(parseInt($("#Hi3518EV200").val()) == 1)
		{
			if(parseInt($("#jsResolution").val()) != resolution_old && (parseInt($("#jsResolution").val()) == 10 || resolution_old == 10 || parseInt($("#jsResolution").val()) == 8 || resolution_old == 8))
			{
				waitTime = 35;
				flag = 1;
			}
		}
		if(devicdInt == 240 || devicdInt == 241)
		{
			if(emode_old != $('#EmodeControl').val() && (emode_old >= 8 || $('#EmodeControl').val() >= 8)
				&& (parseInt(emode_old)+parseInt($('#EmodeControl').val())) !=21)	
			{
				flag = 0;
			}
		}
		else if(devicdInt == 150 || devicdInt == 151 || devicdInt == 140 || devicdInt == 141 || devicdInt == 138 || devicdInt == 139 || devicdInt == 142 || devicdInt == 143 || devicdInt == 146 || devicdInt == 147 || devicdInt == 126 || devicdInt == 127)
		{
			waitTime = 30;
			if(parseInt($("#Hi3518E").val()) == 1)
			{
				if((parseInt($("#jsResolution").val()) != 8) && (resolution_old == 8))
				{
					flag = 1;
				}
				else if((parseInt($("#jsResolution").val()) == 8) && (resolution_old != 8))
				{
					flag = 1;	
				}
				else
				{	
					flag = 0;
				}
			}
			else
			{
				if(parseInt($("#jsResolution").val()) == 8  && parseInt($("#VinRes960p").val()) != 1)
				{
					flag = 1;
				}
			}	
		}
		if(res_fake > 0 && devicdInt < 158)
		{
			if(((parseInt($("#jsResolution").val()) != 33) && (resolution_old == 8)) || ((parseInt($("#jsResolution").val()) != 8) && (resolution_old == 33)))
			{
				flag = 1;
			}
		}
	}else if("extVideoForm" == formID){
		flag = 0;
		if (chipID == 3) {
			if(parseInt($("#jsExtResolution").val()) != ext_resolution_old && $("#WifiKit_Get").val()=='0')
			{
				waitTime = 20;
				flag = 1;
			}
		} else if(parseInt($("#Hi3516CV300").val()) == 2) {
			flag = extflag;
		}
	}else{
		if(parseInt($("#jsMJPEGresolution").val()) == 8  && parseInt($("#VinRes960p").val()) != 1)
		{
			flag = 1;
		}
	}
	if(chipID == 1){//goke
		flag = 0;
	}else if (chipID == 3) {
		if(parseInt($("#jsResolution").val()) != resolution_old && $("#WifiKit_Get").val()=='0')
		{
			waitTime = 20;
			flag = 1;
		}
	}
	//resolution_old = parseInt($("#jsResolution").val());
/*
	if(flag == 1){
		if(!confirm(["Change resolution will make camera reboot, continue?","切换分辨率将重启设备，继续?"][LANGUAGE]))
			return;
	}
*/
	ajaxGet(formID,function(text){
		var result = getState(text);
		var mainVideoSrc=["resolution","frameRate","bitRateControl","bitRateTop","IPrate","Quality"];
		var mainVideoSet=["jsResolution","jsFrameRate","jsBitRateControl","jsBitRateTop","jsIPrate","jsQuality"];
		var extVideoSrc=["ExtResolution","ExtFrameRate","ExtBitRateControl","ExtBitRateTop","ExtIPrate","ExtQuality"];
		var extVideoSet=["jsExtResolution","jsExtFrameRate","jsExtBitRateControl","jsExtBitRateTop","jsExtIPrate","jsExtQuality"];
		var MJPEGSrc=["MJPEGresolution","MJPEGframeRate","MJPEGQuality"];
		var MJPEGSet=["jsMJPEGresolution","jsMJPEGframeRate","jsMJPEGQuality"];
		var src=new Array();
		var set=new Array();
		if("mainVideoForm" == formID){
			src = mainVideoSrc;
			set = mainVideoSet;
		}else if("extVideoForm" == formID){
			src = extVideoSrc;
			set = extVideoSet;
		}else{
			src = MJPEGSrc;
			set = MJPEGSet;
		}
		if(!result){
			alert(["Setting failed!","设置失败"][LANGUAGE]);
			for(var i=0; i<src.length; i++){
				$("#"+set[i]).val($("#"+src[i]).val());
			}
		}else{
			for(var i=0; i<src.length; i++){
				$("#"+src[i]).val($("#"+set[i]).val());
			}
		}
	},function(){},20000);
	if(flag == 1){
		var dialog = new Dialog();
		var dialogStr=["Rebooting,Please wait...  ","正在重启，请稍候...  "];
		$("#jsVedioIframe").hide();
		dialog_waiting = 1;
		dialog.show(waitTime,dialogStr[LANGUAGE],"", function(){location.reload(true);});
	}
	if(refreshflag == 1){
		try{
			var url = $("#jsVedioIframe").attr("src").split("?");
			var src = url[0]+"?video="+play_mode;
			$("#jsVedioIframe").attr("src",src);
		}catch(e){
			setTimeout("location.reload(true);",1000);
		}
		
	}
}

function input_size(par,index) { 
	var max = 36; 

	if (par.value.length <= max) 
	var str = max - par.value.length; 
	document.getElementById("OsdRemainLabel"+index.toString()).innerHTML = str.toString(); 
} 

function saveNotice() {
    alert(["Save Successful","保存成功"][LANGUAGE]);
}

function textOSDchanged(target, num){
	target = parseInt(target);
	num = !Boolean(num);
	var inputStr = $("#OSD"+target+"Text");
	var inputX = $("#jsText"+target+"OSDx");
	var inputY = $("#jsText"+target+"OSDy");
	var inputSize = $("#jsOSD"+target+"Size");
	var inputWordCount = $("#word"+target+"Count");
	inputStr.attr( "disabled", num );
	inputX.attr( "disabled", num );
	inputY.attr( "disabled", num );
	inputSize.attr("disabled",num);
	inputWordCount.attr("disabled",num);
	$("#jsText"+target+"OSDxyLab").attr("disabled", num);
	$("#jsText"+target+"OSDstrLab").attr("disabled", num);
	inputStr.css("cursor",num? "default": "auto");
	inputX.css("cursor",num? "default": "auto");
	inputY.css("cursor",num? "default": "auto");
	inputSize.css("cursor",num? "default": "auto");
}

function MultipleOSDchanged(num){
	num = !Boolean(num);
	var inputX = $("#jsMultipleOSDx");
	var inputY = $("#jsMultipleOSDy");
	var inputSize = $("#jsMultipleOSDSize");
	inputX.attr( "disabled", num);
	inputY.attr( "disabled", num);
	inputSize.attr( "disabled", num);
	$("#jsMultipleOSDxyLab").attr( "disabled", num);
	inputX.css("cursor",num? "default": "auto");
	inputY.css("cursor",num? "default": "auto");
	inputSize.css("cursor",num? "default": "auto");
}

function timeOSDchanged(num){
	num = !Boolean(num);
	var inputX = $("#jsTimeOSDx");
	var inputY = $("#jsTimeOSDy");
	var inputSize = $("#jsDTimeOSDSize");
	inputX.attr( "disabled", num);
	inputY.attr( "disabled", num);
	inputSize.attr( "disabled", num);
	$("#jsTimeOSDxyLab").attr( "disabled", num);
	inputX.css("cursor",num? "default": "auto");
	inputY.css("cursor",num? "default": "auto");
	inputSize.css("cursor",num? "default": "auto");
}

function OBJfocus(inputID,labelID,length){
	OSDtimeout = setInterval(function(){lenCheck(inputID,labelID,length)}, 100);
}
function OBJblur(inputID,labelID,length){
	clearTimeout(OSDtimeout);
}

function lenCheck(inputID,labelID,length){
	if($("#"+inputID).val().strlen() > length)
		$("#"+labelID).css("visibility","inherit");
	else
		$("#"+labelID).css("visibility","hidden");
}

function videoChanged(vedioID, flag){
	var mainVideo = {
								formID: "mainVideoForm",
								selectTap: $("#mainVideoForm div > select"),
								inputTap : $("#mainVideoForm div input[name!='ie6need']"),
								radioTap: $("#jsMainVideo"),
								label: $("#mainVideoForm div[class^='videoSetList'] label")
							};
	var extVideo = {
								formID: "extVideoForm",
								selectTap: $("#extVideoForm div > select"),
								inputTap: $("#extVideoForm div input[name!='ie6need']"),
								radioTap: $("#jsExtVideo"),
								label: $("#extVideoForm div[class^='videoSetList'] label")
							};
	var mjpegPara = {
								formID: "MJPEGform",
								selectTap: $("#MJPEGform div > select"),
								inputTap: $("#MJPEGform div input[name!='ie6need']"),
								radioTap: $("#jsMJPEGvideo"),
								label: $("#MJPEGform div[class^='videoSetList'] label")
							};
	var vedioArray = [mainVideo, extVideo, mjpegPara];
	for( var i = 0; i < vedioArray.length; i++){
		var j = vedioArray[i];
		var s = j.selectTap;
		var t = j.inputTap;
		var q= j.radioTap;  
		var p = j.label;
		if( vedioID == j.formID ){		
			if( parseInt(jsVideoNow) == i ){
				continue;
			}
			s.attr("disabled", false);
			t.attr("disabled", false);
			p.attr("disabled", false);
			q.attr("checked", true);
			if(j.formID == "mainVideoForm"){
				if($('#bitRateControl').val() != 0)
					$("#jsQuality").attr("disabled",true);
			}
			else if(j.formID == "extVideoForm"){
				if($('#ExtBitRateControl').val() != 0)
					$("#jsExtQuality").attr("disabled",true);
			}
			if(flag){
				var iframeObj = $("#jsVedioIframe");
//				iframeObj.css("display","none");
				if( (2 != jsVideoNow) && (2 == i) ){
					var ipAddr =window.location.host;
					iframeObj.attr("src", "http://" + ipAddr + "/browse/mjpeg/mjpegSetPage.htm" );
				}else if( 2 == jsVideoNow ){
					if(navigator.userAgent.indexOf("Safari") != -1 && navigator.userAgent.indexOf("Chrome") == -1)
						iframeObj.attr( "src", "../video/videoSetPage_sf.htm?video=" + i );
					else if(navigator.userAgent.indexOf("Chrome") == -1 && navigator.userAgent.indexOf("Firefox") == -1)
						iframeObj.attr( "src", "../video/videoSetPage.htm?video=" + i );
					else
						iframeObj.attr( "src", "../video/videoSetPage_ff.htm?video=" + i );
				}else if(player){
//					iframeObj.css("display","block");
					player.SetRequestEx(0, i);
				}else{
					if(navigator.userAgent.indexOf("Safari") != -1 && navigator.userAgent.indexOf("Chrome") == -1)
						iframeObj.attr( "src", "../video/videoSetPage_sf.htm?video=" + i );
					else if(navigator.userAgent.indexOf("Chrome") == -1 && navigator.userAgent.indexOf("Firefox") == -1)
						iframeObj.attr( "src", "../video/videoSetPage.htm?video=" + i );
					else
						iframeObj.attr( "src", "../video/videoSetPage_ff.htm?video=" + i );
				}
			}
			jsVideoNow = i;
		}else{
			s.attr("disabled", true);
			t.attr("disabled", true);
			p.attr("disabled", true);
			q.attr("checked", false);
		}
	}	
}

function motionAreaChanged(area, num){
	num = !Boolean(num);
	var obj1 = $(area).parent().children("input[type!='radio'][name!='language'][name!='flag']");
	var obj2 = $(area).nextAll("div").children("input[type!='radio']");
	obj1.attr("disabled", num);
	obj1.css("cursor", num? "default" : "pointer");
	obj2.attr("disabled", num);
	obj2.css("cursor", num? "default" : "text");
	
	if(num){
//		var iframeWin = document.getElementById("jsVedioIframe").contentWindow || document.frames["jsVedioIframe"];
//		var player = iframeWin.document.getElementById("Player");
		var winNum = parseInt($(area).attr("id").match(/\d+/)) - 1;
		if($(area).nextAll("input[id*='jsMotion'][id$='Keep']:visible").css("display") ){
			player.EndNewMotionRect(1);
			var dragButton = $(area).nextAll("input[id*='jsMotion'][id$='Drag']:hidden").css("display","");
			var saveButton = $(area).nextAll("input[id*='jsMotion'][id$='Keep']:visible").css("display","none");
		}
		player.DeleteMotionRect(winNum);
	}else{
		$(area).nextAll("input[id^='jsMotion'][id$='Drag']").click();
		$(area).nextAll("input[id^='jsMotion'][id$='Keep']").click();
	}	
}

function privacyAreaChanged(area, num){
	num = !Boolean(num);
	var obj1 = $(area).parent().children("input[type!='radio'][name!='language'][name!='flag']");
	var obj2 = $(area).nextAll("div").children("input[type!='radio']");
	obj1.attr("disabled", num);
	obj1.css("cursor", num? "default" : "pointer");
	obj2.attr("disabled", num);
	obj2.css("cursor", num? "default" : "text");
	
	if(num){
		var winNum = parseInt($(area).attr("id").match(/\d+/)) - 1;
		if($(area).nextAll("input[id*='jsPrivacy'][id$='Keep']:visible").css("display") ){
			player.EndNewPrivateSection(1);
			var dragButton = $(area).nextAll("input[id*='jsPrivacy'][id$='Drag']:hidden").css("display","");
			var saveButton = $(area).nextAll("input[id*='jsPrivacy'][id$='Keep']:visible").css("display","none");
		}
		player.DeletePSRect(winNum);
	}else{
		$(area).nextAll("input[id^='jsPrivacy'][id$='Drag']").click();
		$(area).nextAll("input[id^='jsPrivacy'][id$='Keep']").click();
	}
}

function ParaChanged(obj){
	var jsCheckbox = $(obj).parent().prev();
	jsCheckbox.attr("checked", true);
}

function selectAll(name, bool){
	bool = Boolean(bool);
	name = "input[name=" + "'" + name.toString() + "'" + "]";
	$(name).attr( "checked",bool );
}

function osdSubmit(formID){
	formID = "#" + formID;
	var dataGet = {
								id: '',
								x: '',
								y: '',
								locationX: '',
								locationY: '',
								flag: '',
								alertString: ''
							}
	for(var j = 1; j < 6; j++){
		if( $("#jsText"+j+"OSDstate1:checked").val() ){
			with(dataGet){
				x = "#jsText" + j.toString() + "OSDx";
				y = "#jsText" + j.toString() + "OSDy";
				locationX = parseInt( $(x).val(), 10 )%100;
				locationY = parseInt( $(y).val(), 10 )%100;
				locationX = isNaN(locationX)? 0 : locationX;
				locationY = isNaN(locationY)? 0 : locationY;
				if( isNaN(locationX) || isNaN(locationY) ){
					flag = 1;
					alertString += "文本" + j.toString() + "坐标格式错误：正确格式为0~99的整数\n";
				}else{
					$(x).val( locationX );
					$(y).val( locationY );
				}
			}
		}
	}
	if( $("#sMultipleOSDstate1:checked").val() ){
		with(dataGet){
			x = "#jsMultipleOSDx";
			y = "#jsMultipleOSDy";
			locationX = parseInt( $(x).val(), 10 )%100;
			locationY = parseInt( $(y).val(), 10 )%100;
			if( isNaN(locationX) || isNaN(locationY) ){
				flag = 1;
				alertString += "倍数坐标格式错误：正确格式为0~99的整数\n";
			}else{
				$(x).val( locationX );
				$(y).val( locationY );
			}
		}
	}
	if( $("#jsTimeOSDstate1:checked").val() ){
		with(dataGet){
			x = "#jsTimeOSDx";
			y = "#jsTimeOSDy";
			locationX = parseInt( $(x).val(), 10 )%100;
			locationY = parseInt( $(y).val(), 10 )%100;
			if( isNaN(locationX) || isNaN(locationY) ){
				flag = 1;
				alertString += "时间坐标格式错误：正确格式为0~99的整数\n";
			}else{
				$(x).val( locationX );
				$(y).val( locationY );
			}
		}
	}

	if(dataGet.flag){
		alert(dataGet.alertString);
		return;
	}else{
		$(formID).submit();
	}
}

function checkNum(num){
		var num = parseInt(num);
		return isNaN(num)? 0 : num;
}

function osdXYcheck(obj,ev){
	var inputObj = $(obj);
	var val = parseInt(inputObj.val(),10);
	val = isNaN(val)? 0: val;
	val = Math.max(val,0);
	val = Math.min(val,99);
	inputObj.val(val);
}

function getShotPath(){
	if(player.SetSnapShotOption()){
		var path = player.GetSnapShotPath();
//		var type = player.GetSnapType();
		$("#jsShotPath").val(path);
//		$("#jsImageType").val(type);
	}
}
function getRecordPath(){
	if(player.SetRecordOption()){
		var path = player.GetRecordPath();
//		var type = player.GetRecordType();
		$("#jsRecordPath").val(path);
//		$("#jsVideoType").val(type);
	}
}
function pathSubmit(formID){
	var pathNull = ["Path can't be null!\n","路径不能为空!\n"];
	var photoLength = ["The length of photo saving path is over limit!\n","抓拍路径长度过限!\n"];
	var videoLength = ["The length of video saving path is over limit!\n","录像路径长度过限!\n"];
	var shotPath = $("#jsShotPath").val();
	var recordPath = $("#jsRecordPath").val();
	var blankReg = /^\s*$/;
	if( shotPath.match(blankReg) || recordPath.match(blankReg) ){
		alert(pathNull[LANGUAGE]);
		return;
	}
	var alertFlag = 0;
	var alertString = '';
	if(299 < shotPath.strlen()){
		alertFlag = 1;
		alertString += photoLength[LANGUAGE];
	}
	if(299 < recordPath.strlen()){
		alertFlag = 1;
		alertString += videoLength[LANGUAGE];
	}
	
	if(1 == alertFlag){
		alert(alertString);
		return;
	}else{
		parent.topFrame.document.getElementById('imagePath').value = shotPath;
		parent.topFrame.document.getElementById('videoPath').value = recordPath;
		parent.topFrame.document.getElementById('imageType').value = $("#jsImageType").val();;
		parent.topFrame.document.getElementById('videoType').value = $("#jsVideoType").val();;
		$("#jsPathSetFlag").val(1);
		ajaxPost(formID,function(text){
			var state = getState(text);
			if(state){
				$("#jsPathSetFlag").val(2);
				ajaxPost(formID);
			}else{
				alert(["Setting failed!","设置失败!"][LANGUAGE]);
			}
			});
	}
}

function motionAreaEnable(areaNum,bool){
	obj = $("#jsMotion"+areaNum+"Checkbox");
	var state = Boolean(obj.attr("checked"));
	var inputObj = $("input[id^='jsMotion" + areaNum + "']");
	var labelObj = $("label[id^='jsMotion" + areaNum + "']");
	inputObj.attr("disabled", !state);
	inputObj.css("cursor",state? "auto" : "default");
	labelObj.attr("disabled", !state);
	$("#jsMotion"+areaNum+"Lab").attr("disabled", false);
	$("label[class^='sensExplain']").eq(areaNum-1).attr("disabled", !state);
	DragObj.state("jsSens"+areaNum, state);
	if(!state){
		$("#jsMotion"+areaNum+"Active").val(0);
		$("#jsMotion"+areaNum+"Active").attr("disabled", false);
	}else{
		$("#jsMotion"+areaNum+"Active").val(1);
	}
	obj.attr("disabled", false);
	if(!bool){
		if(state){
			motionAreaAdd(areaNum);
		}else{
			player.DeleteMotionRect(areaNum-1);
		}
		$("#MotionForm"+areaNum).submit();
		player.SetActiveMotionRect(areaNum-1);
	}
}

function privacyAreaEnable(areaNum,bool){
	obj = $("#jsPrivacy"+areaNum+"Checkbox");
	var state = Boolean(obj.attr("checked"));
	var inputObj = $("input[id^='jsPrivacy"+areaNum+"']");
	var labelObj = $("label[id^='jsPrivacy"+areaNum+"']");
	inputObj.attr("disabled", !state);
	inputObj.css("cursor", state? "auto" : "default");
	labelObj.attr("disabled", !state);
	$("#jsPrivacy"+areaNum+"Lab").attr("disabled", false);
	if(!state){
		$("#jsPrivacy"+areaNum+"Active").val(0);
		$("#jsPrivacy"+areaNum+"Active").attr("disabled", false);
	}else{
		$("#jsPrivacy"+areaNum+"Active").val(1);
	}
	obj.attr("disabled", false);
	if(!bool){
		$("#PrivacyForm"+areaNum).submit();
	}
}

function roiAreaEnable(areaNum,bool){
	obj = $("#jsRoi"+areaNum+"Checkbox");
	var state = Boolean(obj.attr("checked"));
	var inputObj = $("input[id^='jsRoi"+areaNum+"']");
	var selectObj = $("select[id^='jsRoi"+areaNum+"']");
	var labelObj = $("label[id^='jsRoi"+areaNum+"']");
	inputObj.attr("disabled", !state);
	inputObj.css("cursor", state? "auto" : "default");
	selectObj.attr("disabled", !state);
	labelObj.attr("disabled", !state);
	$("#jsRoi"+areaNum+"Lab").attr("disabled", false);
	if(!state){
		$("#jsRoi"+areaNum+"Active").val(0);
		$("#jsRoi"+areaNum+"Active").attr("disabled", false);
	}else{
		$("#jsRoi"+areaNum+"Active").val(1);
	}
	obj.attr("disabled", false);
	if(!bool){
		if(state){
			roiAreaAdd(areaNum);
		}else{
			player.DeleteMotionRect(areaNum-1);
		}
		$("#RoiForm"+areaNum).submit();
		player.SetActiveMotionRect(areaNum-1);
	}
}

function motionAreaAdd(areaNum){
	try{
		var areaPara = {
								top : Math.round(checkNum($("#jsMotion" + areaNum + "Top").val())*2.7),
								bottom: Math.round(checkNum($("#jsMotion" + areaNum + "Bottom").val())*2.7),
								left: Math.round(checkNum($("#jsMotion" + areaNum + "Left").val())*4.8),
								right: Math.round(checkNum($("#jsMotion"+ areaNum + "Right").val())*4.8)
							};
		if( (areaPara.bottom-areaPara.top)>0 && (areaPara.right-areaPara.left)>0 ){
			player.AddMotionRect(areaPara.left,areaPara.top,areaPara.right,areaPara.bottom,areaNum-1); 
			player.ShowMotionRectOSD(areaNum-1,areaNum.toString());
		}
	}catch(e){setTimeout(function(){motionAreaAdd(areaNum)},1000);};
}

function get_zoom()
{
	var zoom = 1;
	try{
		zoom = detectZoom.zoom();
	}catch(e){};
	return zoom;
}

function privacyAreaAdd(areaNum){
	var zoom = get_zoom();
	try{
		var areaPara = {
								top : Math.round(checkNum($("#jsPrivacy" + areaNum + "Top").val())*zoom),
								bottom: Math.round(checkNum($("#jsPrivacy" + areaNum + "Bottom").val())*zoom),
								left: Math.round(checkNum($("#jsPrivacy" + areaNum + "Left").val())*zoom),
								right: Math.round(checkNum($("#jsPrivacy"+ areaNum + "Right").val())*zoom)
							};
//		player.ShowPSRect(1);
		var chipID = top.topFrame.document.getElementById('chipIDGet').value;
			if (chipID == 3) {
					var MirrorV = $("#MVR_").val();
					var MirrorH = $("#MHR_").val();

					with(areaPara){
					var height = bottom-top;
					var width = right -left;
					if(MirrorH  == 1){
						left = 480*zoom - left - width;
						right = left + width;
					}
					if(MirrorV == 1){
						top = 270*zoom - top - height;
						bottom = top+height;
					}

				}
		}
		if( (areaPara.bottom-areaPara.top)>0 && (areaPara.right-areaPara.left)>0 ){
			player.AddPSRect(areaPara.left,areaPara.top,areaPara.right,areaPara.bottom,areaNum-1); 
		}
	}catch(e){setTimeout(function(){privacyAreaAdd(areaNum)},1000);};
}

function roiAreaAdd(areaNum){
	var zoom = get_zoom();
	try{
		try{
			player.SetPTZControlMode(0);
			player.EnableVectorControl(false);
		}catch(e){};
		var areaPara = {
								top : Math.round(checkNum($("#jsRoi" + areaNum + "Top").val())*2.7*zoom),
								bottom: Math.round(checkNum($("#jsRoi" + areaNum + "Bottom").val())*2.7*zoom),
								left: Math.round(checkNum($("#jsRoi" + areaNum + "Left").val())*4.8*zoom),
								right: Math.round(checkNum($("#jsRoi"+ areaNum + "Right").val())*4.8*zoom)
							};
		if( (areaPara.bottom-areaPara.top)>0 && (areaPara.right-areaPara.left)>0 ){
			player.AddMotionRect(areaPara.left,areaPara.top,areaPara.right,areaPara.bottom,areaNum-1); 
			player.BeginNewMotionRect(areaNum-1);
			player.ShowMotionRectOSD(areaNum-1,areaNum.toString());
			player.SetActiveMotionRect(areaNum-1);
			player.EndNewMotionRect(1);
		}
	}catch(e){setTimeout(function(){roiAreaAdd(areaNum)},1000);};
}

function motionAreaDrag(areaNum){
	player.BeginNewMotionRect(areaNum-1);
	player.ShowMotionRectOSD(areaNum-1,areaNum.toString());
//	player.SetActiveMotionRect(areaNum-1);
}

function roiAreaDrag(areaNum){
	player.BeginNewMotionRect(areaNum-1);
	player.ShowMotionRectOSD(areaNum-1,areaNum.toString());
//	player.SetActiveMotionRect(areaNum-1);
}

function privacyAreaDrag(areaNum){
	player.BeginNewPrivateSection(areaNum-1);
//	player.SetActivePSRect(areaNum-1);
}

function motionAreaGet(areaNum){
	if(!$("#jsMotion"+areaNum+"Drag").attr("disabled")){
		return;
	}
	var winNum = parseInt(areaNum) -1;
	var areaPara = {
								top:Math.round(player.GetMotionRectTop(winNum)/2.7),
								bottom:Math.round(player.GetMotionRectBottom(winNum)/2.7),
								left:Math.round(player.GetMotionRectLeft(winNum)/4.8),
								right:Math.round(player.GetMotionRectRight(winNum)/4.8)
							};
	with(areaPara){
		top 		= top		<    0? 0 : top;
		bottom = bottom >100? 100 : bottom;
		left 		= left		<    0? 0 : left;
		right 	= right		>100? 100 : right;
		
		bottom = bottom < top ? top: bottom;
		right = right < left ? left: right;
	}
	$("#jsMotion" + areaNum + "Top").val(areaPara.top);
	$("#jsMotion" + areaNum + "Bottom").val(areaPara.bottom);
	$("#jsMotion" + areaNum + "Left").val(areaPara.left);
	$("#jsMotion" + areaNum + "Right").val(areaPara.right);
	player.EndNewMotionRect(1);
}

function roiAreaGet(areaNum){
	if(!$("#jsRoi"+areaNum+"Drag").attr("disabled")){
		return;
	}
	var winNum = parseInt(areaNum) -1;

	var zoom = get_zoom();
	var areaPara = {
								top:Math.round(player.GetMotionRectTop(winNum)/2.7/zoom),
								bottom:Math.round(player.GetMotionRectBottom(winNum)/2.7/zoom),
								left:Math.round(player.GetMotionRectLeft(winNum)/4.8/zoom),
								right:Math.round(player.GetMotionRectRight(winNum)/4.8/zoom)
							};
	with(areaPara){
		top 		= top		<    0? 0 : top;
		bottom = bottom >100? 100 : bottom;
		left 		= left		<    0? 0 : left;
		right 	= right		>100? 100 : right;
		
		bottom = bottom < top ? top: bottom;
		right = right < left ? left: right;
	}
	$("#jsRoi" + areaNum + "Top").val(areaPara.top);
	$("#jsRoi" + areaNum + "Bottom").val(areaPara.bottom);
	$("#jsRoi" + areaNum + "Left").val(areaPara.left);
	$("#jsRoi" + areaNum + "Right").val(areaPara.right);
	player.EndNewMotionRect(1);
}

function privacyAreaGet(areaNum){
	if(!$("#jsPrivacy"+areaNum+"Drag").attr("disabled")){
		return;
	}
	var winNum = parseInt(areaNum) -1;
	var zoom = get_zoom();
	var areaPara = {
								top:Math.round(player.GetPSRectTop(winNum)/zoom),
								bottom:Math.round(player.GetPSRectBottom(winNum)/zoom),
								left:Math.round(player.GetPSRectLeft(winNum)/zoom),
								right:Math.round(player.GetPSRectRight(winNum)/zoom)
							};
	with(areaPara){
		top 		= top		<    0? 0 : top;
		bottom = bottom >270? 270 : bottom;
		left 		= left		<    0? 0 : left;
		right 	= right		>480? 480 : right;
		
		bottom = bottom < top ? top: bottom;
		right = right < left ? left: right;
	}
	var chipID = top.topFrame.document.getElementById('chipIDGet').value;
	if (chipID == 3) {
			var MirrorV = $("#MVR_").val();
			var MirrorH = $("#MHR_").val();

			with(areaPara){
			var height = bottom-top;
			var width = right -left;
			if(MirrorH == 1){
				left = 480 - left - width;
				right = left + width;
			}
			if(MirrorV == 1){
				top = 270 - top - height;
				bottom = top+height;
			}

		}
	}
	$("#jsPrivacy" + areaNum + "Top").val(areaPara.top);
	$("#jsPrivacy" + areaNum + "Bottom").val(areaPara.bottom);
	$("#jsPrivacy" + areaNum + "Left").val(areaPara.left);
	$("#jsPrivacy" + areaNum + "Right").val(areaPara.right);
	player.EndNewPrivateSection(1);
	player.DeletePSRect(winNum);
}

function motionAreaSub(areaNum){
	$("#jsMotion"+areaNum+"Sback").val($("#jsMotion"+areaNum+"Sens").val());
	$("#jsMotion"+areaNum+"Nback").val($("#jsMotion"+areaNum+"Name").val());
	$("#MotionForm"+areaNum).submit();
}

function roiAreaSub(areaNum){
	$("#RoiForm"+areaNum).submit();
}

function privacyAreaSub(areaNum){
	$("#jsPrivacy"+areaNum+"Nback").val($("#jsPrivacy"+areaNum+"Name").val());
	$("#PrivacyForm"+areaNum).submit();
}

function motionAreaReset(areaNum){
	var sensValue = $("#jsMotion"+areaNum+"Sback").val();
	DragObj.value("jsSens"+areaNum, sensValue);
	$("#jsMotion"+areaNum+"Sens").val(sensValue);
	$("#jsMotion"+areaNum+"SensLabel").text(sensValue);
	$("#jsMotion"+areaNum+"Name").val($("#jsMotion"+areaNum+"Nback").val());
	if($("#jsMotion"+areaNum+"Drag").attr("disabled")){
		player.EndNewMotionRect(1);
		player.DeleteMotionRect(areaNum-1);
		motionAreaAdd(areaNum);
	}
}

function roiAreaReset(areaNum){
	var levelValue = $("#jsRoi"+areaNum+"Level_").val();
	$("#jsRoi"+areaNum+"Level").val(levelValue);
	if($("#jsRoi"+areaNum+"Drag").attr("disabled")){
		player.EndNewMotionRect(1);
		player.DeleteMotionRect(areaNum-1);
		roiAreaAdd(areaNum);
	}
}

function privacyAreaReset(areaNum){
	areaNum = parseInt(areaNum);
	$("#jsPrivacy"+areaNum+"Name").val($("#jsPrivacy"+areaNum+"Nback").val());
	if($("#jsPrivacy"+areaNum+"Drag").attr("disabled")){
		player.DeletePSRect(areaNum-1);
		player.EndNewPrivateSection(1);
//	privacyAreaAdd(areaNum);
	}
}

function motionOperateLimit(areaNum){
	player.EnableFullScreen(false);
	$("input[id^='jsMotion']:visible").attr("disabled", true);
	$("label[id^='jsMotion']:visible").attr("disabled", true);
	for(var i = 1; i < 5; i++){
		DragObj.state("jsSens"+i, false);
	}
	DragObj.state("jsSens"+areaNum, true);
	$("#jsMotion"+areaNum+"Sub").attr("disabled", false);
	$("#jsMotion"+areaNum+"Res").attr("disabled", false);
	$("#jsMotion"+areaNum+"Name").attr("disabled", false);
	$("label[id^='jsMotion"+areaNum+"']:visible").attr("disabled", false);
	$("#jsMotion"+areaNum+"Lab").attr("disabled", true);
}

function roiOperateLimit(areaNum){
	player.EnableFullScreen(false);
	$("input[id^='jsRoi']:visible").attr("disabled", true);
	$("label[id^='jsRoi']:visible").attr("disabled", true);
	for(var i = 1; i < 5; i++){
		//DragObj.state("jsSens"+i, false);
	}
	//DragObj.state("jsSens"+areaNum, true);
	$("#jsRoi"+areaNum+"Sub").attr("disabled", false);
	$("#jsRoi"+areaNum+"Res").attr("disabled", false);
	$("label[id^='jsRoi"+areaNum+"']:visible").attr("disabled", false);
	$("#jsRoi"+areaNum+"Lab").attr("disabled", true);
}

function privacyOperateLimit(areaNum){
	player.EnableFullScreen(false);
	$("input[id^='jsPrivacy']:visible").attr("disabled", true);
	$("label[id^='jsPrivacy']:visible").attr("disabled", true);
	$("#jsPrivacy"+areaNum+"Sub").attr("disabled", false);
	$("#jsPrivacy"+areaNum+"Res").attr("disabled", false);
	$("#jsPrivacy"+areaNum+"Name").attr("disabled", false);
	$("label[id^='jsPrivacy"+areaNum+"']:visible").attr("disabled", false);
	$("#jsPrivacy"+areaNum+"Lab").attr("disabled", true);
}

function motionOperateRes(){
	player.EnableFullScreen(true);
	var checkbox = $(".areaSetName input[id^='jsMotion']:enabled").length;
	var cancel = $(".areaSetBottom input[id^='jsMotion']:enabled").length;
	if(checkbox || cancel){
		for(var i = 1; i < 5; i++){
			motionAreaEnable(i,"init");
			$("#jsMotion"+i+"Lab").attr("disabled", false);
		}
	}
}

function roiOperateRes(){
	player.EnableFullScreen(true);
	var checkbox = $(".areaSetName input[id^='jsRoi']:enabled").length;
	var cancel = $(".areaSetBottom input[id^='jsRoi']:enabled").length;
	if(checkbox || cancel){
		for(var i = 1; i < 5; i++){
			roiAreaEnable(i,"init");
			$("#jsRoi"+i+"Lab").attr("disabled", false);
		}
	}
}

function privacyOperateRes(){
	player.EnableFullScreen(true);
	var checkbox = $(".areaSetName input[id^='jsPrivacy']:enabled").length;
	var cancel = $(".areaSetBottom input[id^='jsPrivacy']:enabled").length;
	if(checkbox || cancel){
		for(var i = 1; i < 5; i++){
			privacyAreaEnable(i,"init");
			$("#jsPrivacy"+i+"Lab").attr("disabled", false);
		}
	}
}

function frameRateLimit(){
	var frameRate = $("#jsFrameRate").val();
	var resolution = $("#jsResolution").val();
	if(0 && 30 == frameRate && 10 == resolution){
		$("#jsExtVideo").attr("disabled", true);
		$("#videoTypeExt").attr("disabled", true);
		$("#jsExtResolution").val(0);
		$("#jsMJPEGresolution").change();
	}else{
		$("#jsExtVideo").attr("disabled", false);
		$("#videoTypeExt").attr("disabled", false);
	}
	return false;
}

function refreshweb_Major()
{
	if(dialog_waiting == 1)
	{
		dialog_waiting = 0;
		return;
	}
	var resolution_new= $("#jsResolution").val();
	if(resolution_old != resolution_new)
	{
		window.location.reload();
	}
	resolution_old = resolution_new;
}
function refreshweb_Minor()
{
	/*
	var ext_resolution_new= $("#jsExtResolution").val();
	if(ext_resolution_old != ext_resolution_new)
	{
		window.location.reload();
		$("#jsExtVideo").click();
	}
	ext_resolution_old = ext_resolution_new;
	*/
}
function getMotionActive(){
	try{
		var activeNum = player.GetMotionActiveIndex();
		ActiveObj = ActiveObj == null? $("div[class^='areaSetContain']"): ActiveObj;
		if(-1 != activeNum){
			for(var i = 0; i < 4; i++){
				i == activeNum?ActiveObj.eq(i).css("background-color",COLOR)
										:ActiveObj.eq(i).css("background-color","transparent");
			}
		}else{
			ActiveObj.css("background-color","transparent");
		}
	}catch(e){};
	ActiveTimeout = setTimeout(arguments.callee, 200);
}

function alarmAreaShow(){
	var state = getCookie("alarmArea");
	state = state? state.split("&"):[0,0,0,0];
	var checkbox = $(".areaSetName input[id^='jsMotion']:enabled").length;
	var cancel = $(".areaSetBottom input[id^='jsMotion']:enabled").length;
	var flag = checkbox || cancel;
	for(var i = 0; i < 4; i++){
		if($("#jsMotion"+(i+1)+"Checkbox:enabled").val() || !flag){
			player.MotionRectTwinkle(i,parseInt(state[i]));
		}else{
			player.MotionRectTwinkle(i,0);
		}
	}
}

function bitRateCheck(valMin,valMax,target){
	var DOMobj = $(target);
	var val = DOMobj.val();
	val = val.replace(/\D+/g,'');
	val = parseInt(val,10);
	val = isNaN(val)? valMin: val;
	val = val > valMax? valMax: val;
	val = val < valMin? valMin: val;
	DOMobj.val(val);
}

function recordNote(){
	var resolution = $(this).val();
	if("0"==resolution && $("#limitNoteLab:hidden").length){
		$("#recordNoteLab").show();
	}else{
		$("#recordNoteLab").hide();
	}
}

/**
 * flag=0:clear motion scope
 * flag=1:drag motion scope
 */
function MDScopeAction(flag)
{
	if(parseInt(flag) == 0)
	{
		if(!window.confirm(["Are you sure to clear all the scope?","是否清除所画区域？"][LANGUAGE]))
			return;
		player.ClearHikMtnRct();
	}
	else 
	{
		player.StartDrawHikMtnRct();
	}
}

function MDScopeSave()
{
	var stat = Boolean($("#jsMDCheckbox").attr("checked"));
	if(stat)	
	{
		$("#jsMDEnable").val(1);	
	}
	else {
		$("#jsMDEnable").val(0);
	}
	
	/*$("#jsMotion5Sback").val($("#jsMotion5Sens").val());*/
	setTimeout("player.SaveHikMtnRct();", 400);
	
	$("#jsMDScopeForm").submit();
}

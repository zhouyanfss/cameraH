// JavaScript Document
//ISP init
var Language;
function initISP()
{	
	if($("#motionSwitchGet").val() == 1){
		$("div[class^='ptzDiv']").css("opacity",0.6).find("select").attr("disabled",true);
		$(".divTransparent").css("visibility","visible");
	}
	var id = getCookie("dev");
	$("#jsICRcfg").hide().find("select").attr("disabled",true);//2013-08-01 default
	$("#jsICRmodeCfg").css("display","none").find("select").attr("disabled",true);
	if(checkID(id,["140","141","150","151","152","153","158","159","160","161"])){//2013-06-21 
		$("#jsInfrared").show();
	}
	
	$("#topMenu").css("visibility","visible");//显示顶栏
	
	basic_init();
	wb_init();
	AE_init();
	divShow(0);
	modeInit();
	var preventEvent = function(){return false;};
	document.body.oncontextmenu = preventEvent;
	document.body.ondragstart = preventEvent;
	document.body.onselectstart = preventEvent;
	Language = document.getElementById("PAGE_LANGUAGE").value;
	if(parseInt($("#Hi3518E").val()) == 1)
	{
		//$("#LDCForm").hide();		//mpp2 is ok
	}

	var chipID = top.topFrame.document.getElementById('chipIDGet').value;
	if(parseInt(chipID) == 1)
	{
		$(".gokehide").hide();
		$(".gokedisable").attr("disabled",true);
		$("#WBMode_Select").find("option[value='2']").remove();
		$("#WBMode_Select").find("option[value='3']").remove();
		$("#WBMode_Select").find("option[value='4']").remove();
		$("#WBMode_Select").find("option[value='5']").remove();
		$("#WBMode_Select").find("option[value='6']").remove();
		$("#IRmode").find("option[value='4']").remove();
		$("#slowshutter").find("option[value='8']").remove();
		$("#slowshutter").find("option[value='5']").remove();
		$("#slowshutter").find("option[value='3']").remove();
		$("#slowshutter").find("option[value='2']").remove();
		$("#slowshutter").find("option[value='1']").remove();
	}
	else if(parseInt(chipID) == 2)
	{
		$(".mstarhide").hide();
		$(".mstardisable").attr("disabled",true);
		$("#IRmode").find("option[value='4']").remove();
	}
	else if(parseInt(chipID) == 3)
	{

		$("#IRmode").find("option[value='4']").remove();
		$("#LDCForm,#DigitalWDRSwitchRadio,#WDRLevelForm").hide();
		$("#GammaForm,#BLC_SET").hide();
		$("#ExpForm,#HLCForm,#ExpFrom").hide();
		$("#mcAESetForm").children().hide();
		$("#scene_div").show();
	}
}

function setRadiobutton(theSelectElement, searchValue)
{
    for (var i = 0; i < theSelectElement.length; i++) 
	{          
       if (theSelectElement[i].value == searchValue) 
	   {
          theSelectElement[i].checked = true;
	  	  return;
       }
    }
}

function setSelectlist(theSelectElement, searchValue)
{
    for (var i = 0; i < theSelectElement.options.length; i++)
	{          
       if (theSelectElement.options[i].value == searchValue) 
	   {
          theSelectElement.options[i].selected = true;
	  	  return;
       }
    }
}

function basic_init()
{

	if(document.getElementById("PFR_").value == 60)//50Hz
	{
		document.getElementById("Power_Frequency_Radio_Off").checked = true;
		document.getElementById('Similate_Out_Lable').innerHTML = 'NTSC';
		
	}
	else
	{
		
		document.getElementById("Power_Frequency_Radio_On").checked = true;
		document.getElementById('Similate_Out_Lable').innerHTML = 'PAL';
	}
	
	//MirrorV
	setRadiobutton(document.getElementsByName("MVR"), document.getElementById("MVR_").value);

	//MirrorH
	setRadiobutton(document.getElementsByName("MHR"), document.getElementById("MHR_").value);
	setRadiobutton(document.getElementsByName("BLC"), document.getElementById("BLC_").value);
	setRadiobutton(document.getElementsByName("WDR"), document.getElementById("WDR_").value);
	//setRadiobutton(document.getElementsByName("WDRmode"), document.getElementById("WDRmode_").value);
	$('#WDR_Select').val($('#WDR_HFR_MODE_').val());

	var deviceID = top.topFrame.document.getElementById('deviceIDGet').value;
	var devicdInt = parseInt(deviceID);

	if(parseInt($("#Hi3516A").val()) != 0)
	{
		$("#WDRForm").show();
		if(devicdInt != 162 && devicdInt != 163 && devicdInt != 168 && devicdInt != 169 && devicdInt != 174 && devicdInt != 175 && devicdInt != 184 && devicdInt != 186)
		{
			$("#WDRForm").attr("disabled",true);
		}
		if(parseInt($("#Hi3516A").val()) == 2)
		{
			$("#WDR_Select option[value='1']").remove();
		}
		if(parseInt($("#WDR_HFR_MODE_").val()) == 2)
		{
			$("#DigitalWDRSwitchRadio,#WDRLevelForm").attr("disabled",true);
		}
	}
	
	//Anti False
	setRadiobutton(document.getElementsByName("AFC"), document.getElementById("AFC_").value);
	setRadiobutton(document.getElementsByName("AFG"), document.getElementById("AFG_").value);
	setRadiobutton(document.getElementsByName("LSC"), document.getElementById("LSC_").value);
	setRadiobutton(document.getElementsByName("LDC"), document.getElementById("LDC_").value);
	setRadiobutton(document.getElementsByName("DIS"), document.getElementById("DIS_").value);
	//setRadiobutton(document.getElementsByName("Lobby"), document.getElementById("Lobby_").value);
	//setRadiobutton(document.getElementsByName("Rotate"), document.getElementById("Rotate_").value);
	$('#WDRLEVEL').val($('#WDRLEVEL_').val());
	$('#Gamma').val($('#Gamma_').val());
	if(parseInt($("#Hi3516A").val()) != 0)
	{
		var deviceID = top.topFrame.document.getElementById('deviceIDGet').value;
		var devicdInt = parseInt(deviceID);
		if(devicdInt >= 208 && devicdInt < 240)
		{
			$("#LDC_Radio_On,#LDC_Radio_Off").attr("disabled",true);
		}
	}
	$('#LDCLevel').val($('#LDCLevel_').val());

	if(parseInt($("#Hi3518E").val()) != 0 || parseInt($("#Hi3518EV200").val()) != 0)
	{
		$("#LDC_Radio_On, #LDC_Radio_Off").attr("disabled",true);
		slidergray(19,0);
	}
}

function WDR_Selected_Func()
{
	var dialog = new Dialog();
	var dialogStr=["Please wait...  ","请稍候...  "];
	if(document.getElementById("WDR_Select").value == document.getElementById("WDR_HFR_MODE_").value)
		return;
	/*
	var theSelectElement = document.getElementsByName("WDRmode");
    for (var i = 0; i < theSelectElement.length; i++) 
	{          
       if(theSelectElement[i].checked == true) 
	   {
			if(theSelectElement[i].value == document.getElementById("WDRmode_").value)
				return;
			break;
       }
    }
	*/
	document.getElementById('WDRForm').submit();
	try{
		document.getElementById("Player").StopPlay();
	}catch(e){};
	$("#Player").hide();
	dialog.show(35,dialogStr[Language],"", function(){location.reload(true);});
}

function AE_init()
{
	$('#AEMode_Select').val($('#AEMode_Select_').val());
	if(parseInt($("#AEMode_Select").val()) == 1)
		slidergray(17,0);
	else
		slidergray(17,1);
	AEModeSelect_init();
	IRmode_init();
	//$('#Iris_select').val($('#Iris_select_').val());
	$('#maxAE_Select').val($('#maxAE_Select_').val());

	$('#scene_Select').val($('#scene_Select_').val());
	
	$('#slowshutter').val($('#slowshutter_').val());

	$('#C2B_Switch_Select').val($('#C2B_Switch_Select_').val());
	
	$('#IRC_Time').val($('#IRC_Time_').val());
	
	$('#colormode').val($('#colormode_').val());
	$('#HLC').val($('#HLC_').val());
	$('#EXP').val($('#EXP_').val());
	
	if(parseInt($("#Hi3516A").val()) == 0 && parseInt($("#Hi3518EV200").val()) == 0)
	{
		$("#HLC").find("option[value='4']").remove()
	}

	window_resize();
	player = document.getElementById("Player");
	try{player.EnableVectorControl(false);}catch(e){};
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




function wb_init()
{	
	//Auto, Manual, IncandescentLight, CoolWhiteFluorescentLight, SunLight, Cloudy, SunShade
	setSelectlist(document.getElementById("WBMode_Select"), document.getElementById("WBM_").value);
	WB_Mode_SelectSet_init();
}

//*******************end ISP init***************************************

var shutterspeed50= new Array("1/8000","1/6000","1/4000","1/2000","1/1000","1/500","1/250","1/200","1/150","1/100","1/50","1/25","1/20","1/15","1/10","1/8","1/5","1/3","1/2","1");
var shutterspeed60= new Array("1/8000","1/6000","1/4000","1/2000","1/1000","1/500","1/300","1/240","1/180","1/120","1/60","1/30","1/20","1/15","1/10","1/8","1/5","1/3","1/2","1");

function Power_Frequency_Checked()
{
	var objs = document.getElementsByName("PFR"); 		

	for(var i=0;i<objs.length;i++)   
	{   
	  if(objs[i].checked)   
	  {   
	    if(objs[i].value=="50") 
	    {   
			document.getElementById('Similate_Out_Lable').innerHTML = 'PAL';
			document.getElementById('formatType').value = 'P';
						
			changeArray(15,shutterspeed50);

			document.getElementById("ShutterSpeedText").value = shutterspeed50[document.mcAESetForm.ShutterSpeed.value];
				
	    }   
	    if(objs[i].value=="60")  
	    {   
			document.getElementById('Similate_Out_Lable').innerHTML = 'NTSC';
			document.getElementById('formatType').value = 'N';
			changeArray(15,shutterspeed60);

			document.getElementById("ShutterSpeedText").value = shutterspeed60[document.mcAESetForm.ShutterSpeed.value];
	    }   
	  }
	 }
	 $('#mcBasicCMDSetForm').submit();
}

function WB_Mode_SelectSet()
{
	if(document.getElementById("WBMode_Select").selectedIndex != 1)
	{
		slidergray(13,0);
		slidergray(14,0);
	}
	else
	{
		slidergray(13,1);
		slidergray(14,1);		
	}		
	$('#mcWBSetForm').submit();
}

function WB_Mode_SelectSet_init()
{
	if(document.getElementById("WBMode_Select").selectedIndex != 1)
	{
		slidergray(13,0);
		slidergray(14,0);
	}
	else
	{
		slidergray(13,1);
		slidergray(14,1);		
	}		
}

//******************AE SET************************************************************
function AEModeSelect()
{
	var AEmode = document.getElementById("AEMode_Select").value;
	switch(AEmode)
	{
		case '0':
			document.getElementById('maxAE_Select').disabled = false;
			document.getElementById('scene_Select').disabled = false;
			document.getElementById('slowshutter').disabled = false;
			slidergray(15,0);
			slidergray(16,0);
			slidergray(17,1);
			break;
		case '1':
			document.getElementById('maxAE_Select').disabled = true;
			document.getElementById('scene_Select').disabled = true;
			document.getElementById('slowshutter').disabled = true;
			slidergray(15,1);
			slidergray(16,1);
			slidergray(17,0);
			break;
		case '2':
			document.getElementById('maxAE_Select').disabled = false;
			document.getElementById('scene_Select').disabled = true;
			document.getElementById('slowshutter').disabled = true;
			slidergray(15,1);
			slidergray(16,0);
			slidergray(17,1);
			break;	
		default:
			document.getElementById('maxAE_Select').disabled = false;
			document.getElementById('scene_Select').disabled = false;
			document.getElementById('slowshutter').disabled = false;
			slidergray(15,1);
			slidergray(16,0);
			slidergray(17,1);
			break;
	}	
	document.getElementById('mcAESetForm').submit();
}

function AEModeSelect_init()
{
	var AEmode = document.getElementById("AEMode_Select").value;
	switch(AEmode)
	{
		case '0':
			document.getElementById('maxAE_Select').disabled = false;
			document.getElementById('scene_Select').disabled = false;
			document.getElementById('slowshutter').disabled = false;
			slidergray(15,0);
			slidergray(16,0);
			break;
		case '1':
			document.getElementById('maxAE_Select').disabled = true;
			document.getElementById('scene_Select').disabled = true;
			document.getElementById('slowshutter').disabled = true;
			slidergray(15,1);
			slidergray(16,1);
			break;
		case '2':
			document.getElementById('maxAE_Select').disabled = false;
			document.getElementById('scene_Select').disabled = true;
			document.getElementById('slowshutter').disabled = true;
			slidergray(15,1);
			slidergray(16,0);
			break;	
		default:
			document.getElementById('maxAE_Select').disabled = false;
			document.getElementById('scene_Select').disabled = false;
			slidergray(15,1);
			slidergray(16,0);
			break;
	}	
	//document.getElementById('mcAESetForm').submit();
}

function IRmode_init()
{
	var mode = document.getElementById("IRmode").value;
	if(mode == '4')
	{
		$('#colorblackthr').show();
		$('#blackcolorthr').show();
	}
	else
	{
		$('#colorblackthr').hide();
		$('#blackcolorthr').hide();
	}
}

function IRmode_Select()
{
	var IRmode = document.getElementById("IRmode").value;
	if(IRmode == '4')
	{
		$('#colorblackthr').show();
		$('#blackcolorthr').show();
	}
	else
	{
		$('#colorblackthr').hide();
		$('#blackcolorthr').hide();
	}
	$('#IRSetForm').submit();
}

function optionsClear(object)
{
	var length = object.options.length;
	for(var i=length-1;i>=0;i--){
		object.options.remove(i);
	}
}




function factorySet()
{
	var dialog = new Dialog();
	var dialogStr=["Please wait...  ","请稍候...  "];
	var firmStr = ["Are you sure to reset all parameters in camera settings page to factory default?","确定要将摄像机页面的所有参数都恢复成出厂默认值吗?"];
	if(window.confirm(firmStr[Language]))
	{
		document.mcCustomSetForm.submit();
		var deviceID = top.topFrame.document.getElementById('deviceIDGet').value;
		var devicdInt = parseInt(deviceID);
		var wdrSelect = parseInt(document.getElementById("WDR_Select").value);
		if(wdrSelect == 2 || parseInt($("#ICEtype").val()) == 2 || (wdrSelect == 1 && (devicdInt == 168 || devicdInt == 169)))
		{
			try{
				document.getElementById("Player").StopPlay();
			}catch(e){};
			$("#Player").hide();
			dialog.show(35,dialogStr[Language],"", function(){location.reload(true);});
		}
		else
		{
			$("#factorySetBtn").attr("disabled",true)
			window.setTimeout('location.reload()',5000); 
		}
	}
	else
		event.returnValue=false;
}
//*****************************mode**********************************************//

function modulatType()
{	
	//ajaxmodecall();
	$("input[name = 'modeSwitch']").each(function(i){
		
		if(i == 0 && this.checked == true)
		{
			
			$("#modeDiv").hide();
			$("#imageDiv").show();	
		}
		if(i == 1 && this.checked == true)	
		{
			$("#imageDiv").hide();
			$("#modeDiv").show();		
		}
		$('#modeEnableForm').submit()
	});
}

function modulatType_init()
{	
	//ajaxmodecall();
	$("input[name = 'modeSwitch']").each(function(i){
		
		if(i == 0 && this.checked == true)
		{
			
			$("#modeDiv").hide();
			$("#imageDiv").show();	
		}
		if(i == 1 && this.checked == true)	
		{
			$("#imageDiv").hide();
			$("#modeDiv").show();		
		}
		//$('#modeEnableForm').submit()
	});
}


//*********************************add by ljf 2012.5.16*****************************/
function divShow(index)
{
	var divId = "cameraDiv" + index;
	var li = $(".choose");
	
	li.css({"border-bottom":"1px #F9F6F6 solid","background-color": ""});
	li.eq(index).css({"background-color": "#d6e8ff"});
	  
	$("div[id^= 'cameraDiv']").hide();
	$("div[id="+divId +"]").show();	
	
	window.scroll(0,0);
	if(index == 1)
		HLC_reset(1);
	else
		HLC_reset(0);
}

var modeCall = new Array();
function ajaxmodecall()
{
	 var i,hour,sec,compareT = -1,disableflag = 0;
	 var deviceTime = new Date();
	 
	
	  $.ajax({
			url:"/cgi/GetCameraTime",
			cache:false,
			dataType:"text",
			success:function(data)
			{	
				deviceTime.setTime(parseInt(data));
				hour = deviceTime.getUTCHours();
				sec = deviceTime.getUTCMinutes();	
				compareT = hour * 60 + sec; 
			}
	  });
	   
	setTimeout(function(){$.ajax({url:"/cgi/modeCallStatus",
		  cache:false,
		  dataType:"text",
		  success:function(data)
		  {
				var arr = data.split("\n");	
				for(i = 0; i < 6; i++)
				{
					 modeCall[i] = arr[i].split("\\"); 
				}

				for(i = 0 ; i < 6 ; i++)
				{
					if(modeCall[i][5] == 1)
					{
						if(timeRegion(modeCall[i],compareT))
						{
							disableflag = 1;
							gDisabled(true);
							break;
						}

					}
				}
				if(disableflag == 0)
				{
					gDisabled(false);	
				}			
		  }
	 });},600);
	 
}


function timeRegion(arr,time)
{
	var startT = (parseInt(arr[0]) * 60 + parseInt(arr[1])) ;
	var endT = (parseInt(arr[2]) * 60 + parseInt(arr[3])) ;
	if(time < endT && (time >= startT) )
		return true;
	else
		return false;
	
}


function gDisabled(flag)
{
	var msg = ["Cannot set general video parameters when mode is being called.","正在调用模式，不能进行常规视频参数设置"];
	var msgIR = ["Cannot set IR mode parameters when mode is being called.","正在调用模式，不能进行红外模式参数设置"];
	if(flag)
	{
		for(var i = 1 ; i < 7 ; i++)
		{
			slidergray(i,0);	
		}
		$("#gSave").attr("disabled",true);
		$("#msgDiv").html(msg[Language]).css("display","block");
		$("#msgIRDiv").html(msgIR[Language]).css("display","block");
		$("#IRmode").attr("disabled",true);
		$("#C2B_Switch_Select").attr("disabled",true);
		$("#C2B_Switch_Select").prev("label").attr("disabled",true);
	}
	else
	{
		for(var i = 1 ; i < 7 ; i++)
		{
			slidergray(i,1);	
		}
		$("#gSave").attr("disabled",false);
		$("#msgDiv").css("display","none");
		$("#msgIRDiv").css("display","none");
		$("#IRmode").attr("disabled",false);
		$("#C2B_Switch_Select").attr("disabled",false);
		$("#C2B_Switch_Select").prev("label").attr("disabled",false);	
	}
}

//**********************init**************************************************************



var fiveParms = new Array(6);
var checkMode = new Array();


function arrayInit()
{
	for(i = 0;i < 6; i++)
	{
		fiveParms[i]={"bright":$("#imgB"+i+'_').val(), "sharp":$("#edgeS"+i+'_').val(),"hue":$("#imgH"+i+'_').val(),"contrast":$("#imgC"+i+'_').val(), "saturation":$("#imgS"+i+'_').val(),"denoise":$("#imgD"+i+'_').val(),"C2B":$("#modeC2B"+i+'_').val(),"IRmode":$("#modeC2B"+i+'_').val()}
	}	
}



function readcookie(cookiestring) 
{ 
	var mycookie = document.cookie;
	pos = mycookie.indexOf(cookiestring,0);
	if(pos==-1)
		return false;
	else 
		return true;
} 


function isSU()
{
	if(readcookie("SU")) return 1;
	else if(readcookie("NU")) return 2;
	else return 0;
}

function modeInit()
{
	
	endTimeCanSelect();
	modeEnableInit();
	timeInit();
	onInit();
	selectInit();
	
	arrayInit();
	
	modeSelectInit()
	nameTextInit();
	modeC2BInit();
	
	
	if(isSU() == 1)
		ajaxmodecall();
}

function endTimeCanSelect()//结束时间的文本框里的内容可选；
{
	var i,objH,objM;
	
	for(var i = 0; i < 6; i++)
	{
		objH = document.getElementById('endH' + i);	
		objM = document.getElementById('endM' + i);	
		objH.onselectstart = function(){event.cancelBubble = true};
		objM.onselectstart = function(){event.cancelBubble = true};
	}
}


function modeEnableInit()
{
 	if(document.getElementById('modeEnable').value == 1)
	{
		document.getElementById("modeSwitchOn").checked = true;
	}
	else
		document.getElementById("modeSwitchOff").checked = true;
	
	modulatType_init();
	
}

function selectInit()
{
	
	for(var i = 0; i < 6; i++)
	{
		
		var object = document.getElementById('ms'+i);	
	
		document.getElementById("ms" + i).options.length=0;
		for(var j = 0; j < 6; j++)
		{
			var nameStr = document.getElementById('name'+j+'_').value;
			object.options.add(new Option(nameStr,j)); 
		}
		document.getElementById("ms" + i).selectedIndex = document.getElementById("ms" + i+'_').value;
	}
}

//去掉非数字字符，并返回10进制数字
function trim(str){
	return parseInt((str.replace(/\D/g,''))==''?'0':str,10);
}

function timeInit()
{
	var j = -1;
	$("form[id='modeSetForm'] input[type='text']").attr("maxlength","2");
	for(var i = 0; i <6; i++)
	{	
		document.getElementById('startH'+i).value	= trim(document.getElementById('startH'+i+'_').value);
		document.getElementById('startM'+i).value	= trim(document.getElementById('startM'+i+'_').value);
		document.getElementById('endH'+i).value	= trim(document.getElementById('endH'+i+'_').value);
		document.getElementById('endM'+i).value	= trim(document.getElementById('endM'+i+'_').value);
		if(trim(document.getElementById('endH'+i).value) == 24) 
			j = i+1;
	}
	if(j != -1)
	{
		for(j;j<6;j++)
		{
			
				$("#endM" + j ).attr("disabled",true);
				$("#endH" + j ).attr("disabled",true);
				$("#mc"+j).attr("disabled",true);
				$("#ms"+j).attr("disabled",true);	
		}
	}
}

function onInit()
{
	for(var i = 0; i <6; i++)
	{
		if(document.getElementById('mcVal'+i+'_').value == 1)
		{
			document.getElementById('mc'+i).checked = true;
			document.getElementById('mcVal'+i).value = 1;
			
		}
		else
		{
			document.getElementById('mc'+i).checked = false;
			document.getElementById('mcVal'+i).value = 0;
		}
	}
}

function modeSelectInit()
{
	var object = document.getElementById('mode_select');	
	object.options.length=0;
	for(var j = 0; j < 6; j++)
	{
		// /var nameStr = document.getElementById('name'+j+'_').value;
		var nameStr = "mode"+(j+1);
		object.options.add(new Option(nameStr,j)); 
	}
}

function nameTextInit()
{
	var i = document.getElementById("mode_select").selectedIndex;
	//document.getElementById("mode_text").value = document.getElementById("mode_select").options[i].text;	
	document.getElementById("mode_text").value = document.getElementById('name'+i+'_').value;
	
}

function modeC2BInit()
{
	$("#C2B_Switch_Select_M").val($("#modeC2B0_").val());
	$("#IRmode_M").val($("#modeC2B0_").val());
}

//***********************function**************************************************************


function recommandValue(index)
{
		
		document.getElementById('mode_text').value = document.getElementById('rname'+index+'_').value;
		$("#C2B_Switch_Select_M").val($('#rmodeC2B'+index+'_').val());
		$("#IRmode_M").val($('#rmodeC2B'+index+'_').val());
		sliderSetValue(7,document.getElementById('rimgB'+index+'_').value);
		sliderSetValue(8,document.getElementById('redgeS'+index+'_').value);
		sliderSetValue(9,document.getElementById('rimgH'+index+'_').value);
		sliderSetValue(10,document.getElementById('rimgC'+index+'_').value);
		sliderSetValue(11,document.getElementById('rimgS'+index+'_').value);
		sliderSetValue(12,document.getElementById('rimgD'+index+'_').value);		
}



function recommand()
{
	var index = document.getElementById("mode_select").selectedIndex;
	
	recommandValue(index);
	
}

function videoparaSubmit()
{
	$("#modeEnableForm").submit();	
	setTimeout(function(){$("#sliderForm").submit();},400);
}


function nameCheckC()
{
	var zIndex = -1;
	var regExpInfo=/(\/)|(\\)/;	//(\s)|
	var obj = document.getElementById('mode_text');
	var i = document.getElementById('mode_select').selectedIndex;
	var nameStr = obj.value;
	var errorStr = [{"null":"Mode name can not be empty.","bigLength":"Mode name must be smaller than 11 characters.","specialCharacters":"Mode name contains illegal characters. "},{"null":"模式名称不能为空！","bigLength":"模式名称长度不能超过10个字符!","specialCharacters":"模式名称包含特殊字符!"}];
	if(nameStr == '')
	{
		alert(errorStr[Language]['null']);
		return false;
	}
	if(nameStr.length > 10)
	{
		alert(errorStr[Language]['bigLength']);
		obj.value = document.getElementById("mode_select").options[i].text;
		return false;
	}
	zIndex = nameStr.search(regExpInfo);
	if (zIndex != -1) 
	{
		alert(errorStr[Language]['specialCharacters']);
		obj.value = document.getElementById("mode_select").options[i].text;
		return false;
	}
	else
		return true;
	
	
}


function arrayValue(i)
{
	fiveParms[i]['bright'] = $("#ImgBrightness_M").val();
	fiveParms[i]['sharp'] = $("#EdgeStrength_M").val();
	fiveParms[i]['hue'] = $("#ImgHue_M").val();
	fiveParms[i]['contrast'] = $("#ImgContrast_M").val();
	fiveParms[i]['saturation'] = $("#ImgSaturation_M").val();
	fiveParms[i]['denoise'] = $("#ImgDenoise_M").val();
	fiveParms[i]['C2B'] = $("#C2B_Switch_Select_M").val();
	fiveParms[i]['IRmode']=$('#IRmode_M').val();
}



function recommandSubmit()
{
	if(nameCheckC())
	{
		document.getElementById("modeEditForm").submit();
		//mode_select fresh
		var txtVal = document.getElementById("mode_text").value;
		var objSelect = document.getElementById("mode_select");
		var selectIndex = objSelect.selectedIndex;
		//objSelect.options[objSelect.selectedIndex] = new Option( txtVal,objSelect.selectedIndex); 
		objSelect.selectedIndex = selectIndex;
		arrayValue(selectIndex);
		// 6 selects fresh
		for(var i = 0; i < 6; i++)
		{
			var objSelectSet = document.getElementById("ms"+i);
			var selectIndexSet = objSelectSet.selectedIndex;
			//objSelectSet.options[objSelect.selectedIndex] = new Option( txtVal,objSelect.selectedIndex); 	
			objSelectSet.selectedIndex = selectIndexSet;
			
		}
	}
}

function modeEditCancel()
{
	var i = document.getElementById('mode_select').selectedIndex;
	//document.getElementById('mode_text').value = document.getElementById("mode_select").options[i].text;
	document.getElementById('mode_text').value = document.getElementById('name'+i+'_').value;
	$("#C2B_Switch_Select_M").val(fiveParms[i]['C2B']);
	$("#IRmode_M").val($("#modeC2B"+i+"_").val());
	sliderSetValue(7,fiveParms[i]['bright']);
	sliderSetValue(8,fiveParms[i]['sharp']);
	sliderSetValue(9,fiveParms[i]['hue']);	
	sliderSetValue(10,fiveParms[i]['contrast']);
	sliderSetValue(11,fiveParms[i]['saturation']);
	sliderSetValue(12,fiveParms[i]['denoise']);
}


function modeChange()
{
	
	var i = document.getElementById("mode_select").selectedIndex;
	//document.getElementById("mode_text").value = document.getElementById("mode_select").options[i].text;
	document.getElementById('mode_text').value = document.getElementById('name'+i+'_').value;
//	$("#C2B_Switch_Select_M").val($("#modeC2B"+i+"_").val());
    $("#IRmode_M").val($("#modeC2B"+i+"_").val());
	$("#C2B_Switch_Select_M").val(fiveParms[i]["C2B"]);
	sliderSetValue(7,fiveParms[i]['bright']);
	sliderSetValue(8,fiveParms[i]['sharp']);
	sliderSetValue(9,fiveParms[i]['hue']);	
	sliderSetValue(10,fiveParms[i]['contrast']);
	sliderSetValue(11,fiveParms[i]['saturation']);
	sliderSetValue(12,fiveParms[i]['denoise']);
	
}

function linkH(i)
{
	var j = i - 1;
	if(checkH(j))
		document.getElementById("startH"+i).value = document.getElementById("endH"+j).value;
}
function linkM(i)
{
	var j = i - 1;
	if(checkM(j))
		document.getElementById("startM"+i).value = document.getElementById("endM"+j).value;
}


var forbid = function(){this.blur();}

function checkH(i)
{
	var rgExp = new RegExp(/^(\d{1}|0\d{1}|1\d{1}|2[0-4])$/);
	var timeH = document.getElementById("endH"+i).value;
	var errorStr = ["Input invalid! The hour must be between 0 to 24.","输入错误，小时可填写0至24."];
	if(rgExp.test(timeH))
	{
		
		if(timeH == 24)
		{
			var j = i + 1;
			$("#endM" + i).val(0).focus(forbid);//让该文本框无法使用
			for(j; j< 6; j++)
			{
				$("#startH" + j).val("0");
				$("#startM" + j).val("0");
				$("#endM" + j ).val("0").attr("disabled",true);
				$("#endH" + j ).val("0").attr("disabled",true);

				$("#mc"+j).attr({checked:false,disabled:true});
				$("#mcVal" + j).val("0");
				$("#ms"+j).attr("disabled",true);
			}

			return false;
		}
		else
		{
			
			if($("#endH"+i+'_').val() == 24 && $("#endH"+i).val() != 24 || $("#endH"+(i+1)).attr("disabled") == "disabled")
			{
				$("input:disabled").attr("disabled",false);
				$("select:disabled").attr("disabled",false);
				$("#endM" + i).unbind("focus",forbid);
			}
			return true;
		}
	}
	else 
	{	
		alert(errorStr[Language]);
		document.getElementById("endH"+i).value = 0;
		return false;
	}
}

function checkLastH(i)
{
	var rgExp = new RegExp(/^(\d{1}|0\d{1}|1\d{1}|2[0-4])$/);
	var timeH = document.getElementById("endH"+i).value;
	var errorStr = ["Input invalid! The hour must be between 0 to 24.","输入错误，小时可填写0至24."];
	if(rgExp.test(timeH))
	{
		
		if(timeH == 24)
		{
			var j = i + 1;
			$("#endM" + i).val(0).focus(forbid);//让该文本框无法使
			return false;
		}
		else
		{
			if($("#endH"+i).val() != 24 || $("#endH"+(i+1)).attr("disabled") == "disabled")
			{
				$("input:disabled").attr("disabled",false);
				$("#endM" + i).unbind("focus",forbid);
			}
			return true;
		}
	}
	else
	{
		alert(errorStr[Language]);
		document.getElementById("endH"+i).value = 0;
		return false;
		
	}
}

function checkM(i)
{
	var rgExp = new RegExp(/^(\d{1}|[0-5]\d{1})$/);
	var timeM = document.getElementById("endM"+i).value;
	var errorStr = ["Input invalid! The minute must be between 0 to 59.","输入错误，分钟可填写0至59."];
	if(rgExp.test(timeM))
		return true;
	else
		{
			alert(errorStr[Language]);
			document.getElementById("endM"+i).value = 0;
			return false;
		}
}


function compareTime(i)
{
	var startT = parseInt(document.getElementById("startH"+i).value,10) * 60 + parseInt(document.getElementById("startM"+i).value,10);
	var endT = parseInt(document.getElementById("endH"+i).value,10) * 60 + parseInt(document.getElementById("endM"+i).value,10);
	var errorStr = ["Start time must be earlier than end time. Please input/reset again!","结束时间必须大于开始时间,请重新输入."];
	if(endT <= startT)
	{
		alert(errorStr[Language]);
		var j = i<5 ? i + 1 : 5;
		document.getElementById("endH"+i).value = 0;
		document.getElementById("endM"+i).value = 0;
		document.getElementById("startH"+j).value = 0;
		document.getElementById("startM"+j).value = 0;
		return false;
	}
	else
		return true;
}

function modeEnableSwitch(i)
{
	if(document.getElementById('mc'+i).checked == true)
	{
		if(compareTime(i))
		{
			document.getElementById('mcVal'+i).value = 1;
		}
		else
		{
			document.getElementById('mcVal'+i).value = 0;
			document.getElementById('mc'+i).checked = false;
		}
	}
	else
		document.getElementById('mcVal'+i).value = 0;
}


function checkOverlap(ar)
{
	var errorStr = ["Time periods cannot overlap,set mode times again.","您启用的模式时间段有重叠，请重新设置模式调用时间"];
	var FLAG = false;
	OUTERMOST:  for(var i = 1; i < ar.length; i++) 
				{
					for(var j = 0; j < i; j++) 
					{
						if ((ar[i][0] > ar[j][0] && ar[i][0] < ar[j][1]) || (ar[i][0] <= ar[j][0]&&ar[i][1] >= ar[j][1]) ||( ar[i][0]>=ar[j][0]&&ar[i][1]<=ar[j][1]) || (ar[i][0] < ar[j][0] && ar[i][1]>ar[j][0])) 
						{
							FLAG = true;
							break OUTERMOST;
						}
					}
				}
	if (FLAG)
	{
		alert(errorStr[Language]);
		//$("form[name='modeSetForm'] input[type='checkbox']:checked").attr("checked",false);
		failSubmitInit();
		return false;
	}
	else 
		return true;
}

function failSubmitInit()
{
	var i,j;
	for(i=0; i<6;i++)
	{
		$("#startH"+i).val(parseInt(modeCall[i][0]),10);
		$("#startM"+i).val(parseInt(modeCall[i][1]),10);
		$("#endH"+i).val(parseInt(modeCall[i][2]),10);
		$("#endM"+i).val(parseInt(modeCall[i][3]),10);
		document.getElementById("ms" + i).selectedIndex = parseInt(modeCall[i][4],10);		
		//$("#ms"+i).val(modeCall[i][4]);
		parseInt(modeCall[i][5]) == 1 ? $("#mc"+i).attr("checked",true):$("#mc"+i).attr("checked",false);
	}
}

function modeSubmit()
{
	var i, num = 0,j=0;
	for(i = 0; i<6; i++)
	{
		if(document.getElementById('mc'+i).checked == true)
		{
			
			if(!compareTime(i))
			{
				num++;
				return;
			}
			
			checkMode[j] = [parseInt($("#startH" + i).val(),10) * 60 + parseInt($("#startM" + i).val(),10), parseInt($("#endH" + i).val(),10) * 60 + parseInt($("#endM" + i).val(),10)];
			j++;
		}
		
	}
	if(num == 0 && checkOverlap(checkMode))
	{
		document.getElementById('modeSetForm').submit();
		setTimeout("ajaxmodecall()",1000);
	}
	checkMode.length = 0;

}


//*************************时间选择*****************************************
function getWheelDelta(event) 
{
        if (event.wheelDelta){
            return event.wheelDelta;
        } else {
            return -event.detail * 40;
        }
}

function wheelChangeH()
{

		document.onmousewheel = function()
		{
			var obj = document.activeElement;
			var curVal = parseInt(obj.value,10);
			var delta =getWheelDelta(event);
			event.cancelBubble = true;
			event.returnValue=false;
			if (delta > 0) {
				if(obj.value < 24)
					obj.value = curVal + 1;
			} else{
				if(obj.value > 0)
				obj.value = curVal - 1;
			}
		};
}

function wheelChangeM()
{

		document.onmousewheel = function()
		{
			var obj = document.activeElement;
			var curVal = parseInt(obj.value,10);
			var delta =getWheelDelta(event);
			event.cancelBubble = true;
			event.returnValue=false;
			if(delta > 0){
				if(obj.value < 59)
					obj.value = curVal + 1;
			} else{
				if(obj.value > 0)
				obj.value = curVal - 1;
			}
		};
}

function prevent()
{
     document.onmousewheel = function(){
	 	event.returnValue = true;
		event.cancelBubble = false;
	 }

}

function HLC_reset(enable)
{
    var value = $("#HLC").val();

    if(value == 3)
    	$("#jsareaexposure").show();
    else
    	$("#jsareaexposure").hide();

    if(value == 3 && enable){
		try{player.EnableVectorControl(false);}catch(e){};
			for( var i = 1; i < 5; i++ ){
				if($("#jsRoi"+i+"Checkbox").attr("checked"))
					roiAreaAdd(i);
			}
			player.ShowMotionDetect(1);
	}
	else
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
}


function HLC_change()
{
	var enable = ($("#HLC").val() == 3);
	document.getElementById('HLCForm').submit();
	HLC_reset(enable);
	//if(enable)
		//window.scroll(0,195);
}
// JavaScript Document
var reObj1=reObj2=reObj3=null;
var screenLine = false;
var stateCheckTimer = null;
$(function(){
	var Language = $("#PAGE_LANGUAGE").val();
	/*
	reObj1 = reg({
		target:"#AF",
		w:88,
		h:34,
		minusImg:["../images/auto_focus_near.gif","../images/auto_focus_near_.gif"],
		plusImg:["../images/auto_focus_far.gif","../images/auto_focus_far_.gif"],
		minusAlt:["wide","广角聚焦"],
		plusAlt:["telescope","望远聚焦"],
		state:true,
		lan:Language,
		mdMinusPara:"AFflg=1&AFcontrol=1",
		mdPlusPara:"AFflg=1&AFcontrol=2"
		
	});
	reObj2 = reg({
		target:"#MZ",
		w:88,
		h:34,
		minusImg:["../images/PTZimage/zoom_out.gif","../images/PTZimage/zoom_out_.gif"],
		plusImg:["../images/PTZimage/zoom_in.gif","../images/PTZimage/zoom_in_.gif"],
		minusAlt:["wide","广角"],
		plusAlt:["telescope","望远"],
		state:true,
		lan:Language,
		mdMinusPara:"AFflg=1&AFcontrol=3",
		mdPlusPara:"AFflg=1&AFcontrol=4"
	});
	reObj3 = reg({
		target:"#MF",
		w:88,
		h:34,
		minusImg:["../images/PTZimage/focus_near.gif","../images/PTZimage/focus_near_.gif"],
		plusImg:["../images/PTZimage/focus_far.gif","../images/PTZimage/focus_far_.gif"],
		minusAlt:["near","近端"],
		plusAlt:["far","远端"],
		state:true,
		lan:Language,
		mdMinusPara:"AFflg=1&AFcontrol=5",
		mdPlusPara:"AFflg=1&AFcontrol=6"
	});*/
		
	$("#AFassistant").val() == "1" ? $("#lineSwitchBu").val(["Hide guides","隐藏辅助线"][Language]): $("#lineSwitchBu").val(["Show guides","显示辅助线"][Language]);	
	
	$("#presetSelect").val($("#presetSelectGet").val());
	
//IR
	$('#IRmode').val($("#IRmode_").val());
	$('#IRenable').val($("#IRenable_").val());
	$('#IRdelay').val($("#IRdelay_").val());
	$('#PowerMode').val($("#PowerMode_").val());
	
	//$('#PowerValue').val($("#PowerValue_").val());	
	//form_widget_amount_slider('Slider_PowerValue',document.getElementById('PowerValue'),120,1,99,"");
	
	//PMChange();
	
	if(isSU() == 2)
	{
		slidergray(17,0);
		stateFun(reObj1,0);
		stateFun(reObj2,0);
		stateFun(reObj3,0);
	}
	
});

function PMChange()
{
	if($('#PowerMode').val()=="2")
		slidergray(17,1);
	else
		slidergray(17,0);
}

function divShowAF(index)
{
	var player = document.getElementById("Player");
	var divId = "cameraDiv" + index;
	var li = $(".choose");
	
	li.css({"border-bottom":"1px #F9F6F6 solid","background-color": ""});
	li.eq(index).css({"border-bottom":"1px #BBB solid","background-color": "#BBB"});
	  
	$("div[id^= 'cameraDiv']").hide();
	$("div[id="+divId +"]").show();
	if(index != 3){
		player.EnableFocusToolBar(false);
	}
	if(screenLine)
	{
		screenLine = false;
		player.EnableSetAFArea(false, false);	
	}
	
	if(index == 3 && isSU() != 2)
	{
		screenLine = true;
		$("#AFradio").click();
		parseInt($("#AFassistant").val()) ? player.EnableSetAFArea(true, true) : player.EnableSetAFArea(true, false);
		player.EnableFocusToolBar(true);
		
		player.attachEvent("AFAreaEvent",function(i){
			var para = "AFflg=3&AFarea="+i;	
			
			if(stateCheckTimer != null)
					clearTimeout(stateCheckTimer);
			
			AFAjaxPost("AFSetForm",para,function(){	
						stopFfun(false);
						checkState();
				});	
			});
			
//	auto af and menual af when full screen 		
		player.attachEvent("FocusSetEvent",function(i,j){
			var para = ["AFflg=1&AFcontrol=3","AFflg=1&AFcontrol=4","AFflg=1&AFcontrol=5","AFflg=1&AFcontrol=6","AFflg=1&AFcontrol=7"];
				if( j == 1)
					AFAjaxPost("AFSetForm",para[i-1],function(){});
				else if(j==0)
				{
					if(i==1 || i==2)
						stopFfun(false);
					AFAjaxPost("AFSetForm",para[4],function(){
						if(i==1 || i==2)
							checkState();	
					});
				}
		});	
					
	}
	
}


function reg(re)
{
	var mdFlag = false;
	var AFflag = false;
	var continueSubmit = null;
	var minusImg = re.minusImg;
	var plusImg = re.plusImg;
	var minusAltText = re.minusAlt[re.lan];
	var plusAltText = re.plusAlt[re.lan];
	var step = 1,i;
	
	var target = (typeof re.target == 'string' ? $(re.target) : re.target);
	
	var numText = $("<input type='text' style='width:50px;position:absolute;left:36px; display:none' />");
	var minusDiv = document.createElement('DIV');
		minusDiv.style.width ='34px';
		minusDiv.style.height ='34px';
		minusDiv.style.position = 'absolute';
		minusDiv.style.left ='0px';
		minusDiv.style.cursor = 'pointer';
		
		
	var plusDiv = document.createElement('DIV');
		plusDiv.style.width ='34px';
		plusDiv.style.height ='34px';
		plusDiv.style.position = 'absolute';
		plusDiv.style.right ='0px';
		plusDiv.style.cursor = 'pointer';
			
	
	target.css({position:"relative",height:re.h,width:re.w});	
	target.append(minusDiv).append(plusDiv).append(numText);
		
	var minusPic = new Array(re.minusImg.length);
	
	    for(i = 0; i < re.minusImg.length; i++)
        {
            var ii = new Image();
            ii.src = re.minusImg[i];
			ii.style.cursor = 'pointer';
			ii.galleryImg = "no";
			ii.alt = minusAltText;
			ii.title = minusAltText; 
			ii.style.height = "34px";
			ii.style.width = "34px";
            minusPic[i] = ii;
        } 
	var plusPic = new Array(re.plusImg.length); 	
		for(i = 0; i < re.plusImg.length; i++)
        {
            var ii = new Image();
            ii.src = re.plusImg[i];
			ii.style.cursor = 'pointer';
			ii.galleryImg = "no";
			ii.alt = plusAltText;
			ii.title = plusAltText;
			ii.style.height = "34px";
			ii.style.width = "34px";
            plusPic[i] = ii;
        } 
		

	function loadpic(tar,pic)
	{
		tar.empty();
		tar.append(pic); 
		tar.first().bind("dragstart", function() { return false; });
	}
	
	var minusDivObj = $(minusDiv);
	var plusDivObj = $(plusDiv);
	
	loadpic(minusDivObj,minusPic[0]);
	loadpic(plusDivObj,plusPic[0]);
		
		
	var stopfun = function(e){
		if(re.state)
		{
			mdFlag = false;
			numText.val("stop");
			loadpic(minusDivObj,minusPic[0]);
			loadpic(plusDivObj,plusPic[0]);
			$(document).unbind("mouseup mouseleave",stopfun);	
			
			if(re.target=="#AF") 
				stopFfun(false);
			var para = "AFflg=1&AFcontrol=7";
			AFAjaxPost("AFSetForm",para,function(){
					if(re.target=="#AF")
						checkState();	
			}); 

		}
	};
	

	
	var plusSubmitCode = function (){
			if(mdFlag)
			{
				numText.val("in" + step++);
				AFAjaxPost("AFSetForm",re.mdPlusPara,function(){});
			}
		};
	
	var minusSubmitCode = function (){
			if(mdFlag)
			{
				numText.val("out" + step++);
				AFAjaxPost("AFSetForm",re.mdMinusPara,function(){});
			}
		};
	
	minusDivObj.bind("mousedown",function(e){
			if(leftKeyDown(e)&&re.state)
			{
				
				mdFlag = true;
				step = 1;
				loadpic(minusDivObj,minusPic[1]);
				minusSubmitCode();
				$(document).bind("mouseup mouseleave",stopfun);
				e.preventDefault();
				

			}
		});
	plusDivObj.bind("mousedown",function(e){
			if(leftKeyDown(e)&&re.state)
			{
				mdFlag = true;
				step = 1;
				loadpic(plusDivObj,plusPic[1]);
				
				plusSubmitCode();
				$(document).bind("mouseup mouseleave",stopfun);			
				e.preventDefault();
				
			}
		});
		
		return re;
}


function checkState()
{
	$.ajax({
	  url:"/form/AFget",
	  cache:false,
	  dataType:"text",
	  success:function(text)
	  {	
		if(getState(text))
		{
			stopFfun(true);
			return;
		}
		else
			stateCheckTimer = setTimeout("checkState()",1000);
	  }
   });
}



function stateFun(re,flag)
{
	var imgObj = $(re.target).find("img");
	flag ? imgObj.css({cursor: "pointer", opacity: 1}):imgObj.css({cursor: "default", opacity: 0.6});
	re.state = flag;
}
			
function leftKeyDown(e)
{
  var e = window.event || e;
  var value = e.button;
  if(value == 2 || value ==3)
	  return false;
  else
	 return true;	
}

function getState(text){
	var state = text.toString().match(/\$STATE\$=\d+/i);
	state = null==state? false : parseInt(state[0].match(/\d+/),10);
	return state;
}
function AFAjaxPost(formID,formPara,hander,waitSec){
	var formObj = "string"==(typeof formID)? $("#"+formID) : $(formID);
	var hander = "function" == (typeof hander)?  hander: alertRes;
	var waitSec = "number" == (typeof waitSec)? waitSec: 50000;
	var time = new Date();
	$.ajax({type:'POST',url:formObj.attr("action")+"?_="+time.getTime(),data:formPara,dataType:"text",success:hander,timeout:waitSec});
}


var AFObj = {
	lineSwich:function(){
			var player = document.getElementById("Player");
			if($("#AFassistant").val() == "1")
			{ 
				$("#AFassistant").val(0);
				$("#lineSwitchBu").val(["Show guides","显示辅助线"][Language]); 
				player.EnableSetAFArea(true, false);
			}
			else
			{ 
				$("#AFassistant").val(1);
				$("#lineSwitchBu").val(["Hide guides","隐藏辅助线"][Language]); 
				player.EnableSetAFArea(true, true);
			}
			var para = "AFflg=4&AFassistant="+ $("#AFassistant").val();	
			AFAjaxPost("AFSetForm",para,function(text){});	
		},
	
	stopFocus:function(){
			var para = "AFflg=1&AFcontrol=8";
			AFAjaxPost("AFSetForm",para,function(){});
			$("#stopF").attr("disabled",true);	
		},
	selectOnchange:function(){
			if(parseInt($("#presetSelect").val()) > 3)
				$("#savePs").attr("disabled",false);
			else
				$("#savePs").attr("disabled",true);	
		},
	psCall:function(){
			var para = "AFflg=2&AFfunction="+$("#presetSelect").val();
			AFAjaxPost("AFSetForm",para,function(text){
				if(getState(text))
					AFAjaxPost("AFSetForm","AFflg=5",function(data){
							if(getState(data))
							{
								stopFfun(false);
								checkState();
							}
						});
				},200000);
		},
	userPsSet:function(){
			var para = "AFflg=2&AFfunction="+(parseInt($("#presetSelect").val())+2);
			AFAjaxPost("AFSetForm",para,function(){});
		},
	resetEngin:function(){
			if(window.confirm(["This feature reduces motor accuracy, it is recommended only when autofocus is blurry.\nContinue?","该功能会降低电机精度，建议自动聚焦不清时使用.\n继续?"][Language]))
			{
			
				var para = "AFflg=2&AFfunction=8";
				var player = document.getElementById("Player");
				AFdisabledAll(true);
				$("#AFassistant").val() == "1" ? player.EnableSetAFArea(false,true) : player.EnableSetAFArea(false,false);

				AFAjaxPost("AFSetForm",para,function(text){
				if(getState(text))
					resetCheck();
				},150000);	
			}
			else
				event.returnValue=false;
		}
	};
	


function focusMode(i)
{
		if(i==0)//auto
		{
			stateFun(reObj1,true);
			stateFun(reObj2,false);
			stateFun(reObj3,false);
			
			$("#manualFocus").hide();
			$("#autoFocus").show();
		}
		else if(i==1)//manual
		{
			stateFun(reObj1,false);
			stateFun(reObj2,true);
			stateFun(reObj3,true);
				
			$("#autoFocus").hide();	
			$("#manualFocus").show();
//			(function(){
//				var player = document.getElementById("Player");
//				try{
//					player.EnableSetAFArea(false, false);	
//				}catch(e){setTimeout(arguments.callee,200);};
//			})();
		}	
}

function resetCheck()
{
	$.ajax({
					url:"/form/AFget",
					cache:false,
					dataType:"text",
					success:function(data)
					{	
						if(getState(data))
						{
							stopFfun(false);					  
							AFAjaxPost("AFSetForm","AFflg=5",function(data){if(getState(data))parent.mainFrame.document.location = ($("#PAGE_LANGUAGE").val() ? "cameraSetC.asp?skip=1" : "cameraSetC.asp?skip=1");});
						}
						else
							setTimeout("resetCheck();",800);
					}
			});
}

function stopFfun(flag)//false:stopF button enable true:unenable
{
	var player = document.getElementById("Player");
	if(flag)
	{
		//AFdisabledAll(false);
		
		$("#AFSetForm").find("input").attr("disabled",false);
		$("#AFSetForm").find("select").attr("disabled",false);
		$("#AFSetForm").find("label").attr("disabled",false);
		
		$("#stopF").attr("disabled",true);
		
		if(parseInt($("#presetSelect").val()) < 4)
			$("#savePs").attr("disabled",true);
		
		if($("#MFradio").is(":checked"))
		{
//			player.EnableSetAFArea(false, false);
			//$("#lineSwitchBu").prev("label").andSelf().attr("disabled",true);
			stateFun(reObj2,true);
			stateFun(reObj3,true);
		}
		else
		{
//			parseInt($("#AFassistant").val()) ? player.EnableSetAFArea(true, true) : player.EnableSetAFArea(true, false);
			
			stateFun(reObj1,true);
		}
	}
	else
	{
		AFdisabledAll(true);
		//player.EnableSetAFArea(false, false);
		$("#stopF").attr("disabled",false);
	}
}
	
function AFdisabledAll(flag)//true:不可用，false:可用
{
	$("#AFSetForm").find("input").attr("disabled",flag);
	$("#AFSetForm").find("select").attr("disabled",flag);
	$("#AFSetForm").find("label").attr("disabled",flag);
	stateFun(reObj1,!flag);
	stateFun(reObj2,!flag);
	stateFun(reObj3,!flag);	
}



// JavaScript Document

var Language;
$(document).ready(function(){
	//addplayercookie("dev",9);
	$(document).bind("contextmenu",function(){return false;}); 
	$(document).bind("selectstart",function(){return false;});
	Language = $("#PAGE_LANGUAGE").val();
	getCameraTime();
	leftStyle();
	picInit();
//	recordEvent();侦听函数不写这里主要是在主副码流切换时，控件已不是同一个控件，但侦听函数还是同一个侦听函数，导致副码流在开启了录像后再关闭录像时侦听不起作用
	M_P_init();
	InitMode();

	if(parseInt($("#Hi3518E").val()) == 1)
	{
		$("#BitSelect").find("option[value='2']").remove();
	}
	else if(parseInt($("#Hi3518EV200").val()) == 3)
	{
		$("#BitSelect").find("option[value='1']").remove();
		$("#BitSelect").find("option[value='2']").remove();
	}

	realAjaxModeCall();
	M_P_init = null;
	ytFunctionInit();
	var chipID = top.topFrame.document.getElementById('chipIDGet').value;
	if(parseInt(chipID) == 3)//isvp
	{
		$("#BitSelect").find("option[value='2']").remove();
	}
});
window.onbeforeunload = function(){
	killTimer();
	delcookie('player');
}

function InitMode()
{
	if(document.getElementById('colorMode') != null)
	{
		$("#videoColorSelect").val(parseInt($("#colorMode").val()));
	}
	$("#playModeSelect").val();
	setTimeout("playMode()",3000);
	//var player = parent.mainFrame.videomainFrame.document.getElementById("Player");
	//player.SetPlaySmoothLevel(1, 0);
}

function colorMode()
{
	var mode = parseInt($("#videoColorSelect").val());
	$.ajax({
		type: "POST",
		url:"/form/CameraSet",
		data: "flag=6&colormode="+mode
	});
}

//*******************get time*************************************
var infoTimerObj = null;
var modeObj = null;
var UpdateTimeCnt = 0;
var datestimes = 0;

function getCameraTime()
{

	try{
		$.ajax({
				  url:"/cgi/GetCameraTime",
				  cache:false,
				  dataType:"text",
				  success:function(data)
				  {	
					  datestimes = parseInt(data);
					  infoTimerObj = setInterval(addSec,1000);
				  }
			   });
	}
	catch(e)
	{	
		if(infoTimerObj) 
			clearInterval(infoTimerObj);
		setTimeout(arguments.callee,200);	
	}
	
}

function killTimer()
{
	if(infoTimerObj) 
		clearInterval(infoTimerObj);
	if(modeObj)
		clearTimeout(modeObj);
}
//******************************ajax above*****************************************************

function addSec()
{
	var timeArr = new Array(3),dateArr = new Array(3);
	var deviceTime = new Date();
	datestimes = datestimes + 1000;
	
	deviceTime.setTime(datestimes);
	timeArr[0] = deviceTime.getUTCHours();
	timeArr[1] = deviceTime.getUTCMinutes();
	timeArr[2] = deviceTime.getUTCSeconds();
	
	dateArr[0] = deviceTime.getUTCFullYear();
	dateArr[1] = deviceTime.getUTCMonth()+1;
	dateArr[2] = deviceTime.getUTCDate();
	
	if(timeArr[2] < 10) timeArr[2] = "0" + timeArr[2];
	if(timeArr[1] < 10) timeArr[1] = "0" + timeArr[1];	
	if(timeArr[0] < 10) timeArr[0] = "0" + timeArr[0];	
	if(dateArr[2] < 10) dateArr[2] = "0" + dateArr[2];	
	if(dateArr[1] < 10) dateArr[1] = "0" + dateArr[1];	
	
//	document.getElementById('CameraTime').value= timeArr.join(" : ");
//	document.getElementById('CameraDate').value= dateArr.join(" - ");
	$("#CameraDate").text(dateArr.join("-"));
	$("#CameraTime").text(timeArr.join(":"));
	
	UpdateTimeCnt++;	
	
	if(UpdateTimeCnt >= 100)
	{		
		UpdateTimeCnt=0;
		if(infoTimerObj) 
			clearInterval(infoTimerObj);
		setTimeout(getCameraTime,200);	
	}
}

//******************time above******************************************************
function realAjaxModeCall()
{			 

	 	var i,k,hour,sec,compareT,t=0;
	 	var deviceTime = new Date();
	 	var modeCall = new Array();
		var callArray = new Array();
		var nextCallIndex = new RegExp("^[0-5]");
	 	var modeText = [{"calling":"The calling mode is","nextcall":"The next mode will be called at"},
	 				    {"calling":"正在调用模式","nextcall":"下一个模式调用时间为"}];
			
		
		
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
				
		setTimeout(function()
		{
			$.ajax({url:"/cgi/modeCallStatus",
			  cache:false,
			  dataType:"text",
			  
			  success:function(data)
			  {
					$("#modeHank").empty();
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
								var j = parseInt(modeCall[i][4]);
								
								$("#modeHank").append("<div id='modetext' style='margin-top:2px; '></div>");
								$("#modetext").html(modeText[Language]['calling'] + modeCall[j][6]);
								//break;
							}
							
							callArray[t] = i;
							t = t + 1;
	
						}
							
					}
	
					k = nextModeCall(modeCall, callArray,compareT);
					if(nextCallIndex.test(k))
					{
						
						k = parseInt(k);
						modeCall[k][0] = $.trim(modeCall[k][0]);
						modeCall[k][1] = $.trim(modeCall[k][1]);
						modeCall[k][0] = (parseInt(modeCall[k][0]) < 10) ? ("0"+modeCall[k][0]) : modeCall[k][0];
						modeCall[k][1] = (parseInt(modeCall[k][1]) < 10) ? ("0"+modeCall[k][1]) : modeCall[k][1];
						
						$("#modeHank").append("<div id='nextModetext' style='margin-top:2px;'></div>");
						$("#nextModetext").html(modeText[Language]['nextcall'] + ' ' + modeCall[k][0] + ' : '+ modeCall[k][1]);
						
					}
					
			
			  }
		   });
		},500);

		modeObj = setTimeout("realAjaxModeCall();",60000);
		
}

function nextModeCall(modeArr, callArr,nowTime)
{
	var i,j,index,nextmode;
	var equalFlag = true;
	var T = new Array();
	var len = callArr.length;
	for(i = 0; i < len; i++)
	{
		j = callArr[i];
		T[i] = parseInt(modeArr[j][0]) * 60 + parseInt(modeArr[j][1]);	
		if(nowTime == T[i])
			equalFlag = false;	
	}
	if(equalFlag)
		T[len] = nowTime;

	var sortNumber = function(a, b)
	{
		return a - b;
	}
	T.sort(sortNumber);
	
	index = jQuery.inArray(nowTime, T);
	
	nextmode = (index == T.length -1) ? 0 : (index + 1);

	for(i = 0; i < len; i++)
	{
		j = callArr[i];
		if(T[nextmode] == parseInt(modeArr[j][0]) * 60 + parseInt(modeArr[j][1]))
		{
			return j.toString();
		}
	}
}

function timeRegion(arr,time)
{
	var startT = (parseInt(arr[0]) * 60 + parseInt(arr[1])) ;
	var endT = (parseInt(arr[2]) * 60 + parseInt(arr[3])) ;
	if(time < endT && time >= startT )
		return true;
	else
		return false;
	
}


//******************end mode******************************************************
function showList(DivId)
{
  
  var obj = document.getElementById(DivId);
  var objDiv = document.getElementById(DivId + "_div");
  var objImg = document.getElementById(DivId + "_img");
  if(objDiv.style.display =='none')
  {
		
  	objDiv.style.display = '';
	objImg.src = "../images/bit_up.gif";
  }
  else
  {
    objDiv.style.display = 'none';
	objImg.src = "../images/bit_down.gif";
  }		
}

function leftStyle()
{
	 var id = getCookie("dev");
	// if(id.match(/^[89]$/))
	if(checkID(id,["87"]))
	 {
		document.getElementById("pNod1_img").src = document.getElementById("pNod2_img").src =document.getElementById("pNod4_img").src ="../images/bit_down.gif"
		
		$("#pNod1_div").css("display","none"); 
		$("#pNod2_div").css("display","none"); 
		$("#pNod4_div").css("display","none"); 
		
		$("#motinDiv").show();
		$("#privacyDiv").show(); 
	}
	var devDiscription = getCookie("BSDdev");
	if(parseInt($("#patternShow").val()) == 1)
	{
		$("#livePatternForm").show();
		$("#jsflip").hide();
	}
	else if(devDiscription=='1')
	{
		$("#livePatternForm").hide();
		$("#jsflip").show();
	}
}

//**************************videoSizeSet ***********************************************
 
var W,H;//player 的高和宽做为全局变量

function getRes(i)
{
	var res;
	var resStr = {"10":"1920x1080","14":"1280x1024","8":"1280x960","5":"1280x720","26":"1024x768","27":"800x600","24":"480x360","28":"320x240","12":"2048x1536",
				"16":"720x576","17":"720x480","6":"640x480","2":"352x288","25":"352x240","0":"1280x1024","1":"176x144","30":"1920x540","31":"2304x1296", "32":"2592x1520", "33":"2592x1944", "34":"3840x2160"};
	
	i = i.match(/^\d{1,2}/);
	if(i == null)
		i = "14";
	i = i.toString();
	res = resStr[i].split("x");
	W = res[0];
	H = res[1];
}


function compareh264()
{
	var player = parent.mainFrame.videomainFrame.document.getElementById("Player");
	var WW = parent.mainFrame.videomainFrame.document.documentElement.clientWidth, WH = parent.mainFrame.videomainFrame.document.documentElement.clientHeight;
	var ratio = WW/WH;
	
	if(ratio >= W/H)
	{
		if(WH>0)
		{
			player.height = WH -4;
			player.width = Math.floor(WH*W/H);
		}
		else
		{
			player.height = 1;
			player.width = 1;
		}	
	}
	else
	{
		
		if(WW >0)
		{
			player.height = Math.floor(WW*H/W);
			player.width = WW;	
		}
		else
		{
			player.height = 1;
			player.width = 1;
		}
	}
}

function h264VideoSizeSet()
{
	var obj = parent.mainFrame.videomainFrame.document.getElementById("Player");
	
	switch(document.getElementById('videoSizeSelect').value)
	{
		case '0':
			obj.height = H;
			obj.width = W;
			break;
		case '1':
			obj.height = H *0.5;
			obj.width = W *0.5;
			break;
		case '2':
			obj.height = Math.floor(H *0.25);
			obj.width = Math.floor(W *0.25);
			break;
		case '3':
			compareh264();
			break;
		case '4':
			{
				obj.height = parent.mainFrame.videomainFrame.document.documentElement.clientHeight -4;
				obj.width = parent.mainFrame.videomainFrame.document.documentElement.clientWidth;
			}

			break;
	}
}

function compareMjpet()//自适应时W H到底取哪个
{
	var ratio = (parent.mainFrame.document.body.clientWidth - 8)/parent.mainFrame.document.body.clientHeight;	
	var	image1 = parent.mainFrame.videomainFrame.document.getElementById('myImg1');
	var image2 = parent.mainFrame.videomainFrame.document.getElementById('myImg2');
	
	if(ratio > W/H)
	{
			if(parent.mainFrame.document.body.clientHeight > 0)
			{
				image1.width = Math.floor((parent.mainFrame.document.body.clientHeight)*W/H); image1.height = parent.mainFrame.document.body.clientHeight;
				image2.width = Math.floor((parent.mainFrame.document.body.clientHeight)*W/H); image2.height = parent.mainFrame.document.body.clientHeight;
			}
			else
			{
				image1.width = 1; image1.height = 1;
				image2.width = 1; image2.height = 1;
			}
	}
	else
	{
		if(parent.mainFrame.document.body.clientHeight-8 > 0)
		{
			image1.width = parent.mainFrame.document.body.clientWidth-8; image1.height = Math.floor((parent.mainFrame.document.body.clientWidth-8)*H/W);
			image2.width = parent.mainFrame.document.body.clientWidth-8; image2.height = Math.floor((parent.mainFrame.document.body.clientWidth-8)*H/W);
		}
		else
		{
				image1.width = 1; image1.height = 1;
				image2.width = 1; image2.height = 1;	
		}	
	}
}

function mjpegVideoSizeSet()
{
	var image1 = parent.mainFrame.videomainFrame.document.getElementById('myImg1');
	var image2 = parent.mainFrame.videomainFrame.document.getElementById('myImg2');
	
	switch(document.getElementById('videoSizeSelect').value)
	{
		case '0':
			image1.width = W; image1.height = H;
			image2.width = W; image2.height = H;
			break;
		case '1':
			image1.width = W * 0.5; image1.height = H * 0.5;
			image2.width = W * 0.5; image2.height = H * 0.5;
			break;
		case '2':
			image1.width =Math.floor(W * 0.25); image1.height = Math.floor(H * 0.25);
			image2.width = Math.floor(W * 0.25); image2.height = Math.floor(H * 0.25);
			break;
		case '3':
			compareMjpet();
			break;
		case '4':
			image1.width = parent.mainFrame.document.body.clientWidth - 8; image1.height =parent.mainFrame.document.body.clientHeight;
			image2.width = parent.mainFrame.document.body.clientWidth - 8; image2.height =parent.mainFrame.document.body.clientHeight;
			break;
	}
}


//max W,H取值
function maxWH()
{
	var rMax = document.getElementById('resMax').value;
	getRes(rMax);
}

function minWH()
{
	var rMin = document.getElementById('resMin').value;
	getRes(rMin);
}

function MjpegWH()
{
	var rMjpeg = document.getElementById('resMjpeg').value;
	getRes(rMjpeg);
}


function videoSizeSet()
{
	switch(document.getElementById('BitSelect').value)
	{
		case '0':
			maxWH();
			h264VideoSizeSet();
			break;
		case '1':	
			minWH();
			h264VideoSizeSet();
			break;
		case '2':
			MjpegWH();
			mjpegVideoSizeSet();
			break;
		default:
			maxWH();
			h264VideoSizeSet();
			break;
	}
}

function MM_preloadImages() { //v3.0
 var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
   var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
   if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function isImagehtm()
{
	var key = parent.mainFrame.document.location.href;
	if((key != null) &&(key.indexOf("image.htm",0) != -1))
	{	
		parent.mainFrame.document.getElementById('btnStop').click();	
		return true;	
	}	
	return false;	
}

function Am_goMJPEGC() 
{ 
	parent.mainFrame.videomainFrame.document.location.replace("/browse/mjpeg/image.htm");
}

function funGoMJPEGC()
{
	if(isImagehtm())
		setTimeout("Am_goMJPEGC()", 1000);
	else
		Am_goMJPEGC();			
}
function mainframeload()
{
	var dataObj = new Date();
	parent.mainFrame.videomainFrame.document.location.replace("/browse/video/video.asp" + "?_=" + dataObj.getTime());
}


var videoType = 0   //0:h264,1:mjpeg
function BitSet()
{	
	//alert(document.GraphicForm.GraphicModeSelect.value);
	document.getElementById('videoSizeSelect').selectedIndex = 3;
	switch(document.getElementById('BitSelect').value){
		case "0"://major
			H264Style();
			addplayercookie("player","hkvisionMax");
			mainframeload();
			break;
		case "1"://minor
			H264Style();
			addplayercookie("player","hkvisionMin");
			mainframeload();
			break;
		case "2"://mjpeg
			MjpegStyle();
			addplayercookie("player","hkvisionMjpeg");
			funGoMJPEGC();
			break;
		default:
			MaxStyle();
			break;
	}
}

function H264Style()
{
	if(videoType)
	{	
		$("#mjpegSnap").css('display','none');
		$("#h264Snap").css('display','inline');
		$("div[class='imgMask']").css('z-index',-5);
		$("#playModeSelect").prev().andSelf().attr("disabled",false);
		videoType = 0;	
	}		
	if($("#startR").css("display") == "none")
	{
		$("#stopR").hide();
		$("#startR").show();
	}
	parent.topFrame.document.getElementById("h264Snap").style.display = "inline";
	parent.topFrame.document.getElementById("mjpegSnap").style.display  = "none";
	//parent.topFrame.document.getElementById("startR").style.display = "inline";
	//$("#startR").attr("disabled",false);	
	setTimeout("playMode()",3000);
}

function MjpegStyle()
{	
	$("#h264Snap").css('display','none');
	$("#mjpegSnap").css('display','inline');
	if($("#startR").css('display')=='none')
	{
		$("#stopR").css('display','none');
		$("#startR").css('display','inline');	
	}
	$("div[class='imgMask']").css('z-index',5);
	$("#playModeSelect").prev().andSelf().attr("disabled",true);
	videoType = 1;
	parent.topFrame.document.getElementById("h264Snap").style.display = "none";
	parent.topFrame.document.getElementById("mjpegSnap").style.display  = "inline";
	//parent.topFrame.document.getElementById("startR").style.display = "none";
	//$("#startR").attr("disabled",true);	
	//$("span[class='imgMask']").mousedown(function(){event.cancelBubble=true;})
}

function playMode()
{
	if($("#BitSelect").val() == '2') //MJPEG直接返回
		return;
	try{
			var player = parent.mainFrame.videomainFrame.document.getElementById("Player");
			var mode = parseInt($("#playModeSelect").val());
			if(mode == 0 || mode == 1)
			{
				player.SetPlaySmoothLevel(mode, 0);
			}
			addplayercookie("playMode",mode);
		}
	catch(e){
			setTimeout("playMode()",3000);
		}
}

function audioInit()
{
	//return;//Elroy
	var bOut = getCookie("audioout");
	var bIn = getCookie("audioin");
	if(bOut == 1)
	{
		$("#out_off").hide();
		$("#out_on").show();
		//parent.topFrame.document.getElementById("out_on").style.display = "none";
		//parent.topFrame.document.getElementById("out_off").style.display = "inline";
	}
	else
	{
		$("#out_on").hide();
		$("#out_off").show();
		//parent.topFrame.document.getElementById("out_off").style.display = "none";
		//parent.topFrame.document.getElementById("out_on").style.display = "inline";
	}
	if(bIn == 1)
	{
		$("#in_off").hide();
		$("#in_on").show();
		//parent.topFrame.document.getElementById("out_on").style.display = "none";
		//parent.topFrame.document.getElementById("out_off").style.display = "inline";
	}
	else
	{
		$("#in_on").hide();
		$("#in_off").show();
		//parent.topFrame.document.getElementById("out_off").style.display = "none";
		//parent.topFrame.document.getElementById("out_on").style.display = "inline";
	}
}

function AOut(flag)//0:off 1:on
{
	if(flag)
	{
		$("#out_off").hide();
		$("#out_on").show();
		//parent.topFrame.document.getElementById("out_on").style.display = "none";
		//parent.topFrame.document.getElementById("out_off").style.display = "inline";
	}
	else
	{
		$("#out_on").hide();
		$("#out_off").show();
		//parent.topFrame.document.getElementById("out_off").style.display = "none";
		//parent.topFrame.document.getElementById("out_on").style.display = "inline";
	}
	parent.mainFrame.videomainFrame.Player.SetAudioRx(flag,0);
	addAudiocookie("audioout="+flag.toString());
}

function AIn(flag)//0:off 1:on
{
	if(flag)
	{
		  try{
			  if(parseInt($("#audioType").val()) == 2)
				parent.mainFrame.videomainFrame.Player.SetAudioTxEncoderType(8);
			  else
				parent.mainFrame.videomainFrame.Player.SetAudioTxEncoderType(1);
		  }catch(e){};
		  var openOut = parent.mainFrame.videomainFrame.Player.SetAudioTx(flag);
		  //openOut = 1;
		  switch(openOut)
		  {
			case -1:
				alert(["Plug in intercom.","请插入对讲设备."][Language]);
				return; 
			case 0:
				alert(["Audio input is occupied.","音频输入被占用."][Language]);
			  	return;
			default: 
			  $("#in_off").hide();
			  $("#in_on").show();
			//parent.topFrame.document.getElementById("in_on").style.display = "none";
			//parent.topFrame.document.getElementById("in_off").style.display = "inline";
			  break;  
		  }
	}
	else
	{	
		parent.mainFrame.videomainFrame.Player.SetAudioTx(flag);		
		$("#in_on").hide();
		$("#in_off").show();
		//parent.topFrame.document.getElementById("in_off").style.display = "none";
		//parent.topFrame.document.getElementById("in_on").style.display = "inline";
	}	
	addAudiocookie("audioin="+flag.toString());
}


function addAudiocookie(cookiename)
{
	document.cookie = cookiename + ";path=/";
}

function startRecord()
{
		var path = document.getElementById("videoPath").value;
		var type = document.getElementById("videoType").value;
		var player = parent.mainFrame.videomainFrame.Player;
		var flag = player.SetRecordPath(path,parseInt(type));
		if(!flag)
		{
			var defaultPath = player.GetRecordPath();
			document.getElementById("videoPath").value = defaultPath;
			$.ajax({
				type: "POST",
				url:"/form/IVPathSet",
				data: "flag=2&videopath="+defaultPath+"&videoType="+type
			});
		}			
	    parent.mainFrame.videomainFrame.Player.StartRecord();
		parent.topFrame.document.getElementById("startR").style.display = "none";
		parent.topFrame.document.getElementById("stopR").style.display  = "inline";

}

function stopRecord()
{
	try{
		parent.mainFrame.videomainFrame.Player.StopRecord();
	}catch(e){};
	parent.topFrame.document.getElementById("startR").style.display = "inline";
	parent.topFrame.document.getElementById("stopR").style.display  = "none";
}

function startZoom()
{
	try{
	    parent.mainFrame.videomainFrame.Player.SetDigitalZoom(1);
	}catch(e){};
	parent.topFrame.document.getElementById("startZ").style.display = "none";
	parent.topFrame.document.getElementById("stopZ").style.display  = "inline";
	addAudiocookie("zoom_status=1");
}

function stopZoom()
{
	try{
		parent.mainFrame.videomainFrame.Player.SetDigitalZoom(0);
	}catch(e){};
	parent.topFrame.document.getElementById("startZ").style.display = "inline";
	parent.topFrame.document.getElementById("stopZ").style.display  = "none";
	addAudiocookie("zoom_status=0");
}

function openVideoDir()
{

		var path = document.getElementById("videoPath").value;
	//	if(checkPath(path))
		{
			parent.mainFrame.videomainFrame.Player.OpenSpecifyFolder(path);
		}
}

function hoverpic(id,hpic,pic)
{
	$(id).hover(function(){this.src = hpic},function(){this.src = pic});
	$(id).bind("click",function(){this.src = pic;});
}

function picInit()
{
	//alert("Good In picInit");
	MM_preloadImages('../images/bar_0.gif','../images/bit_up.gif','../images/bit_down.gif','../images/snap.gif','../images/snap_.gif','../images/path.gif','../images/path_.gif','../images/record.gif','../images/record_.gif','../images/record_off.gif','../images/record_off_.gif','../images/audio_out.gif','../images/audio_out_.gif','../images/audio_out_off.gif','../images/audio_out_off_.gif','../images/audio_in.gif','../images/audio_in_.gif','../images/audio_in_off.gif','../images/audio_in_off_.gif');
	audioInit();

	$(".imgMask").css("opacity",0.3);//采用JQ的CSS添加半透明效果可以屏蔽IE浏览器对半透明处理的结果
	
	hoverpic("#h264Snap img","../images/snap_.gif","../images/snap.gif");
	hoverpic("#mjpegSnap img","../images/snap_.gif","../images/snap.gif");
	
	hoverpic("#snapOpen","../images/path_.gif","../images/path.gif");
	
	hoverpic("#startP","../images/record_.gif","../images/record.gif");
	hoverpic("#stopP","../images/record_off_.gif","../images/record_off.gif");
	
	hoverpic("#startZP","../images/dzoom_.gif","../images/dzoom.gif");
	hoverpic("#stopZP","../images/dzoom_off_.gif","../images/dzoom_off.gif");
	
	hoverpic("#recordOpen","../images/path_.gif","../images/path.gif");
	
	hoverpic("#out_on","../images/audio_out_.gif","../images/audio_out.gif");
	hoverpic("#out_off","../images/audio_out_off_.gif","../images/audio_out_off.gif");
	
	
	hoverpic("#in_on","../images/audio_in_.gif","../images/audio_in.gif");
	hoverpic("#in_off","../images/audio_in_off_.gif","../images/audio_in_off.gif");
	
	hoverpic("#motion_on","../images/motion_on_.gif","../images/motion_on.gif");
	hoverpic("#motion_off","../images/motion_off_.gif","../images/motion_off.gif");
	
	hoverpic("#privacy_on","../images/privacy_on_.gif","../images/privacy_on.gif");
	hoverpic("#privacy_off","../images/privacy_off_.gif","../images/privacy_off.gif");
	
}

function setSnapShot()//ctrl + s fullscreen snap
{
		var type = document.getElementById("imageType").value;
		var player = parent.mainFrame.videomainFrame.Player;
		var flag = player.SetSnapShotPath(document.getElementById("imagePath").value,parseInt(type));
		if(!flag)
		{
			var defaultPath = player.GetSnapShotPath();
			document.getElementById("imagePath").value = defaultPath;
			$.ajax({
				type: "POST",
				url:"/form/IVPathSet",
				data: "flag=1&imagepath="+defaultPath+"&imageType="+type
			});
		}
		parent.mainFrame.videomainFrame.Player.SnapShot();
}


function openImgDir()
{
	var path = document.getElementById("imagePath").value;
	parent.mainFrame.videomainFrame.Player.OpenSpecifyFolder(path);
}
/*************************************************************************************
 * motion and privacy
 ************************************************************************************/
function M_P_init(){
	if(isSU() != 1){
		$("#jsMotionMask").css({"opacity":0.3,"visibility":"visible"});
		$("#jsPrivacyMask").css({"opacity":0.3,"visibility":"visible"});
	}
	var motionSwitch = $("#motionSwitchGet").val();
	var privacySwitch = $("#privacySwitchGet").val();
	if(1 ==  motionSwitch){
		$("#motion_on").hide();
		$("#motion_off").show();
		$("div[class^='ptzDiv']").css("opacity",0.6).find("select").attr("disabled",true);
		$(".divTransparent").css("visibility","visible");
	}
	if(1 == privacySwitch){
		$("#privacy_on").hide();
		$("#privacy_off").show();
	}
}
/********************************************/
function MSwitch(flag)
{
	if(flag)
	{
		$("#motion_on").hide();
		$("#motion_off").show();
		$(".ptzDiv").css("opacity",0.6).find("select").attr("disabled",true);
		$(".divTransparent").css("visibility","visible");
	}	
	else
	{
		$("#motion_off").hide();
		$("#motion_on").show();
		$(".ptzDiv").css("opacity",1).find("select").attr("disabled",false);
		$(".divTransparent").css("visibility","hidden");
	}
	var url = "/form/Setalarmpara?flag=5&MotionSwitch="+flag+"&_="+(new Date()).getTime();
	$.get(url);
}

function PSwitch(flag)
{
	if(flag)
	{
		$("#privacy_on").hide();
		$("#privacy_off").show();
	}	
	else
	{
		$("#privacy_off").hide();
		$("#privacy_on").show();
	}
	var url = "/form/PrivacySet?flag=5&PrivacySwitch="+flag+"&_="+(new Date()).getTime();
	$.get(url);
}

function isSU()
{
	if(readcookie("SU")) return 1;
	else if(readcookie("NU")) return 2;
	else return 0;
}
function userStyle()
{
	var domInput = $("form input");
	var domSelect = $("form select");
	var domLabel = $("form label");
	var domCheck = $("form check");
	var tdText = $("td:parent");
	
	domInput.attr("disabled", true);
	domSelect.attr("disabled", true);
	domLabel.attr("disabled",true);
	domCheck.attr("disabled",true);
	tdText.attr("disabled",true);
}


function nomalUserInit()
{
	var u=isSU();
	if(u==2)
	{
		userStyle();
	}
}

function frequercyCheck(){
	if("0" == $("#wiperFreGet").val()){
		setTimeout(function(){
			$("#jsWiper").val(0);
		},8000);
	}
}
//*****************yuntai****************************************
function ytFunctionInit()
{
//	var id = getCookie("dev");
//	if(id=='V1492N' || id=='V6010'|| id=='V6011'|| id=='V6012'||id=='V6013'||id=='V6014'||id=='V6015'||id=='V6016'||id=='V6017')
//		$("#ptz").show();
//alert($("#panSpeedGet").val() + $("#tiltSpeedGet").val() + $("#focusSpeedGet").val() + $("#zoomSpeedGet").val());
	$("#jsPanSpeed").val($("#panSpeedGet").val());
	$("#jsTiltSpeed").val($("#tiltSpeedGet").val());
	
	$("#jsFocusSpeed").val($("#focusSpeedGet").val());
	$("#jsZoomSpeed").val($("#zoomSpeedGet").val());
	
	if($("#focusSwitchGet").val() == '1')
	{
		$("#jsFocusSwitch").attr('checked',true)	
	}
	else 
	{
		$("#jsFocusSwitch").attr('checked',false)		
	}
	
//	$("#jsWiper").val($("#wiperGet").val());
//	$("#jsDefog").val($("#defogGet").val());
}

function callPst()
{
	//if($("#jsDetectEnable").val()==0)
	{
		//var PresetExist = $("#jslivePresetExist").val();
		var PresetExist = 1;
		if(PresetExist == 1)
		{
			$("#jslivePresetFlag").val(4);
			ajaxPost("livePosHankForm",function(){});
			//document.getElementById('livePosInfForm').submit();	
		}
		else
		{
			alert(["Preset is not setup!","预置位未设置!"][Language]);
		}
	}
}
/* justin add for bsd start 2013.9.13 */
function setPst()
{
	$("#jslivePresetExist").val(1);
	$("#jslivePresetFlag").val(3);
	ajaxPost("livePosHankForm",function(){});
}

function clearPst()
{
	$("#jslivePresetExist").val(0);
	$("#jslivePresetFlag").val(5);
	ajaxPost("livePosHankForm",function(){});
}
/* justin add for bsd end 2013.9.13 */
function callAutopan()
{
	//if($("#jsDetectEnable").val()==0)
	{
		var AutopanExist = $("#jsliveAutopanExist").val();
		if(AutopanExist == 2)
		{
			$("#jsliveAutopanFlag").val(8);
			ajaxPost("liveAutopanForm",function(){});
			//document.getElementById('liveAutopanForm').submit();	
		}
		else if(AutopanExist == 0)
		{
			alert(["Auto-pan is not setup!","水平扫描未设置!"][Language]);
		}
	}
}
function callPtn()
{
	//if($("#jsDetectEnable").val()==0)
	{
		var PatternExist = $("#jslivePatternExist").val();
		if(PatternExist == 2)
		{	
			$("#jslivePatternFlag").val(5);
			ajaxPost("livePatternForm",function(){});
			//document.getElementById('livePatternForm').submit();
		}
		else if(PatternExist == 0)
		{
			alert(["Pattern is not setup!","花样扫描未设置!"][Language]);
		}
	}
}
function callTour()
{
	//if($("#jsDetectEnable").val()==0)
	{
		$("#jsliveTourFlag").val(2);
		if($("#jsliveTourExist").val() == 1)
		{
			ajaxPost("liveTourForm",function(){});
			//document.getElementById('liveTourForm').submit();
		}
		else
		{
			alert(["Normal tour is not setup!","常规巡视未设置!"][Language]);
		}
	}
}
/* justin add for BSD start 2013.9.13 */
function CallAtpPtn(flag)
{
	$("#autoscanflag").val(flag);
	$("#jscommand").val(1);
	$("#jsYunTaiForm").submit();
}
/* justin add for BSD end 2013.9.13 */
function CallAutoScan()
{
	$("#autoscanflag").val(83);
	$("#jscommand").val(83);
	$("#jsYunTaiForm").submit();
}
function SetFlip180()
{
	$("#autoscanflag").val(80);
	$("#jscommand").val(80);
	$("#jsYunTaiForm").submit();
}
function stop()
{	
	$("#jscommand").val(0);
	$("#jsYunTaiForm").submit();	
}
//justin add
function specialFunSet(flag)
{
	$("#jsflag").val(flag);
	$("#jsspecialFuncForm").submit();
}
function initPTZFunction()
{
	if(!IsSuperUser())
	{
		//$("form[action^='/form/setPTZCfg']").attr("action","/user/setPTZCfg");
		//$("form[action^='/form/Setalarmpara']").attr("action","/user/Setalarmpara");
		//$("form[action^='/form/DomeMaskParaCfg']").attr("action","/user/DomeMaskParaCfg");
		//$("form[action^='/form/setSpecialFunc']").attr("action","/user/setSpecialFunc");
		$("form[action^='/form/presetSet']").attr("action","/user/presetSet");
		$("form[action^='/form/autopanSet']").attr("action","/user/autopanSet");
		$("form[action^='/form/patternSet']").attr("action","/user/patternSet");
		$("form[action^='/form/tourSet']").attr("action","/user/tourSet");
		//$("form[action^='/form/setYunTaiCfg']").attr("action","/user/setYunTaiCfg");
	}
}

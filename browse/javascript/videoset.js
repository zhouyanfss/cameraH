var timecount = 1;
var w = 5;
var h = 5;
var resFlag = true;//主要是考虑到播放器的长和宽还没有根据videoset.asp上的分辨率来取得w，h，就进行了播放器的视频播放 ；
				   //分辨率不直接从改video.asp上取，主要是考虑到一台设备已修改分辨率到底层，另一台设备在没有刷新实时浏览页面时切换视频大小时有突然的变化
				   
				   

$(document).ready(function(){
	
	$(".btnArea").hover(function(){
		//$(".btnArea").not($(this)).children("div").hide();
		//var eleChild = $(this).children("div");
		
		$(this).children("div").show();
	},function(){
		
		$(this).children("div").hide();
	});
	
	
	$(".unitDiv,.btnArea").hover(function(){
		$(this).css({
			"border":"1px solid #1c1c1c",
			"padding":"1px",
		});
	},function(){
		$(this).css({
			"border":"none",
			"padding":"2px",
		});
	});
	
})

function vedioParaChange(btnid)
{
	top.rightFrame.document.getElementById(btnid).value = document.getElementById(btnid).value;
	top.rightFrame.document.getElementById(btnid).onchange();
}
				   
function splitIP()
{
	var ref =location.host.match(/\d+\.\d+\.\d+\.\d+/);
	return ref;
}

function runPlay()
{
	//var ref = splitIP();
	var ref =window.location.hostname;
	var port=parseInt(top.topFrame.document.getElementById('videoPort').value)||90;		
	try{
			var player = document.getElementById("Player");
			if(getCookie("player") == "hkvisionMin")
				player.RunPlayEx(ref.toString(),0,"0.0.0.0",2,port,1,"admin","admin");
			else
				player.RunPlayEx(ref.toString(),0,"0.0.0.0",2,port,0,"admin","admin");
			getCookie("playMode") == "1" ? player.SetPlaySmoothLevel(1, 0) : player.SetPlaySmoothLevel(0, 0);
			
	}
	catch(e){
		if(navigator.userAgent.indexOf("Chrome") == -1 && navigator.userAgent.indexOf("Firefox") == -1)
			setTimeout("runPlay()",10);	
	}
}

function Unload()
{
	try{
	document.getElementById("Player").StopPlay();
	}catch(e){}
}

function videoGetRes(i)
{
	var res;
	var resStr = {"10":"1920x1080","14":"1280x1024","8":"1280x960","5":"1280x720","26":"1024x768","27":"800x600","24":"480x360","28":"320x240","12":"2048x1536",
				"16":"720x576","17":"720x480","6":"640x480","2":"352x288","25":"352x240","0":"1280x1024","1":"176x144","30":"1920x540","31":"2304x1296", "32":"2592x1520", "33":"2592x1944",
				"34":"3840x2160"};
	
	i = i.match(/^\d{1,2}/);
	if(i == null)
		i = "14";
	i = i.toString();
	res = resStr[i].split("x");
	w = res[0];
	h = res[1];
	//alert(w +" uu "+ h );
}
function maxWH()
{
	try{
			//var rMax = document.getElementById("resMax").value;
			var rMax = top.rightFrame.document.getElementById("resMax").value;
			//alert(rMax)
			videoGetRes(rMax);
			resFlag = false;

	}
	catch(e){resFlag = true;}
}

function minWH()
{
	try{
	//var rMin = document.getElementById("resMin").value;
	var rMin = top.rightFrame.document.getElementById("resMin").value;
	videoGetRes(rMin);
	resFlag = false;
	}
	catch(e){resFlag = true;}
}


function compareh264()
{
	var WW = document.documentElement.clientWidth, WH = document.documentElement.clientHeight -32;
	var ratio = WW/WH;
	var player = document.getElementById("Player");
	var bottomDiv=document.getElementById("videoBottom");
	if(ratio >= w/h)
	{
		if(WH >0)
		{
			player.height =WH;
			player.width = Math.floor(WH *w/h);
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
			player.height = Math.floor(WW *h/w);
			player.width = WW;
		}
		else
		{
			player.height = 1;
			player.width = 1;
		}
	}
	bottomDiv.style.width = player.width + "px";
}


function setAudioIn_inVideo()
{
	try{
		
	var player= document.getElementById("Player");
	var flag;
	player.SetSamplesPS(8000);
	var bIn = getCookie("audioin");
	switch(bIn){
		case "0": //off
			player.SetAudioTx(0);
			break;
		case "1": //on
			flag = player.SetAudioTx(1);
			if(flag == 1)
			{	
				parent.parent.rightFrame.document.getElementById("in_on").style.display = "none";
				parent.parent.rightFrame.document.getElementById("in_off").style.display = "inline";
			}
			else
			{
				parent.parent.rightFrame.document.getElementById("in_off").style.display = "none";
				parent.parent.rightFrame.document.getElementById("in_on").style.display = "inline";
			}
			break;
		default:
			player.SetAudioTx(0);
			break;		
	}
	}catch(e){
		setTimeout("setAudioIn_inVideo();",100);
		}
}

function setAudioOut_inVideo()
{
	try{
			var player= document.getElementById("Player");
			player.SetSamplesPS(8000);
	
			var bIn = getCookie("audioout");
			switch(bIn){
			case "0": //off
				player.SetAudioRx(0,0);
				break;
			case "1": //on
				player.SetAudioRx(1,0);
				break;
			default:
				player.SetAudioRx(0,0);
				break;		
		}
	}catch(e){setTimeout("setAudioOut_inVideo();",100);}
}
function set_height_width()
{
	var player = getCookie("player");
	if(player == "hkvisionMin")
		minWH();
	else
		maxWH();

	if(resFlag)
		setTimeout("set_height_width();",50);
	else
	{
		compareh264();
		setTimeout("runPlay()",1000);
		recordEvent();
		setTimeout("setAudioIn_inVideo()",200);
		setTimeout("setAudioOut_inVideo()",400);
	}
}

function set_height_width_camera()
{
	try{
		//var ref = splitIP();
		var ref =window.location.hostname;
		var player = document.getElementById("Player");
		var port=parseInt(top.topFrame.document.getElementById('videoPort').value)||90;		
		player.width = 480;
		player.height = 270;
		player.RunPlayEx(ref.toString(),0,"0.0.0.0",2,port,0,"admin","admin");
		getCookie("playMode") == "1" ? player.SetPlaySmoothLevel(1, 0) : player.SetPlaySmoothLevel(0, 0);
	}
	catch(e){
		setTimeout(arguments.callee,200);
		}
}


function recordEvent()
{
	try{
		var player = document.getElementById("Player");
		player.attachEvent("RecordingEvent",function(rflag){
				if(rflag)
				{
					parent.parent.rightFrame.document.getElementById("startR").style.display = "none";
					parent.parent.rightFrame.document.getElementById("stopR").style.display  = "inline";
				}
				else
				{
					parent.parent.rightFrame.document.getElementById("stopR").style.display = "none";
					parent.parent.rightFrame.document.getElementById("startR").style.display = "inline";
				}
				
			});
		}
	catch(e){
		setTimeout(arguments.callee,500);
		}

}

function startZoom()
{
	try{
	    parent.videomainFrame.Player.SetDigitalZoom(1);
	}catch(e){};
	$("#startZ").hide();
	$("#stopZ").show();
	addAudiocookie("zoom_status=1");
}

function addAudiocookie(cookiename)
{
	document.cookie = cookiename + ";path=/";
}

//start 从videosave搬过来的方法
function startRecord()
{
		var path = document.getElementById("videoPath").value;
		var type = document.getElementById("videoType").value;
		var player = parent.videomainFrame.Player;
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
	    parent.videomainFrame.Player.StartRecord();
		$("#startR").hide();
		$("#stopR").show();
}

function stopRecord()
{
	try{
		parent.videomainFrame.Player.StopRecord();
	}catch(e){};
	$("#stopR").hide();
	$("#startR").show();
}

function startZoom()
{
	try{
	    parent.videomainFrame.Player.SetDigitalZoom(1);
	}catch(e){};
	
	$("#startZ").hide();
	$("#stopZ").show();
	addAudiocookie("zoom_status=1");
}

function stopZoom()
{
	try{
		parent.videomainFrame.Player.SetDigitalZoom(0);
	}catch(e){};
	$("#stopZ").hide();
	$("#startZ").show();
	addAudiocookie("zoom_status=0");
}

function setSnapShot()//ctrl + s fullscreen snap
{
		var type = document.getElementById("imageType").value;
		var player = parent.videomainFrame.Player;
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
		parent.videomainFrame.Player.SnapShot();
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
	parent.videomainFrame.Player.SetAudioRx(flag,0);
	addAudiocookie("audioout="+flag.toString());
}

function AIn(flag)//0:off 1:on
{
	if(flag)
	{
		  try{
			  if(parseInt($("#audioType").val()) == 2)
				parent.videomainFrame.Player.SetAudioTxEncoderType(8);
			  else
				parent.videomainFrame.Player.SetAudioTxEncoderType(1);
		  }catch(e){};
		  var openOut = parent.videomainFrame.Player.SetAudioTx(flag);
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
		parent.videomainFrame.Player.SetAudioTx(flag);		
		$("#in_on").hide();
		$("#in_off").show();
		//parent.topFrame.document.getElementById("in_off").style.display = "none";
		//parent.topFrame.document.getElementById("in_on").style.display = "inline";
	}	
	addAudiocookie("audioin="+flag.toString());
}

function openVideoDir()
{

		var path = document.getElementById("videoPath").value;
	//	if(checkPath(path))
		{
			parent.videomainFrame.Player.OpenSpecifyFolder(path);
		}
}

function openImgDir()
{
	var path = document.getElementById("imagePath").value;
	parent.videomainFrame.Player.OpenSpecifyFolder(path);
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
		$("#mjpegSnap").hide();
		$("#h264Snap").show();
		$("div[class='imgMask']").css('z-index',-5);
		$("#playModeSelect").prev().andSelf().attr("disabled",false);
		videoType = 0;	
	}		
	if(!$("#startR").is(":visible"))
	{
		$("#stopR").hide();
		$("#startR").show();
	}
	//document.getElementById("h264Snap").style.display = "inline";
	//document.getElementById("mjpegSnap").style.display  = "none";
	//parent.topFrame.document.getElementById("startR").style.display = "inline";
	//$("#startR").attr("disabled",false);	
	setTimeout("playMode()",3000);
}

function MjpegStyle()
{	
	$("#h264Snap").hide();
	$("#mjpegSnap").show();
	if(!$("#startR").is(":visible"))
	{
		$("#stopR").hide();
		$("#startR").show();	
	}
	$("div[class='imgMask']").css('z-index',5);
	$("#playModeSelect").prev().andSelf().attr("disabled",true);
	videoType = 1;
	//parent.topFrame.document.getElementById("h264Snap").style.display = "none";
	//parent.topFrame.document.getElementById("mjpegSnap").style.display  = "inline";
	//parent.topFrame.document.getElementById("startR").style.display = "none";
	//$("#startR").attr("disabled",true);	
	//$("span[class='imgMask']").mousedown(function(){event.cancelBubble=true;})
}

function mainframeload()
{
	var dataObj = new Date();
	document.location.replace("/browse/video/video.asp" + "?_=" + dataObj.getTime());
}
function isImagehtm()
{
	var key = parent.document.location.href;
	if((key != null) &&(key.indexOf("image.asp",0) != -1))
	{	
		document.getElementById('btnStop').click();	
		return true;	
	}	
	return false;	
}

function Am_goMJPEGC() 
{ 
	document.location.replace("/browse/mjpeg/image.asp");
}

function funGoMJPEGC()
{
	if(isImagehtm())
		setTimeout("Am_goMJPEGC()", 1000);
	else
		Am_goMJPEGC();			
}

function playMode()
{
	if($("#BitSelect").val() == '2') //MJPEG直接返回
		return;
	try{
			var player = parent.videomainFrame.document.getElementById("Player");
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
//end 从videosave搬过来的方法
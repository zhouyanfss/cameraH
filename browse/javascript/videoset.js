var timecount = 1;
var w = 5;
var h = 5;
var resFlag = true;//主要是考虑到播放器的长和宽还没有根据videoset.asp上的分辨率来取得w，h，就进行了播放器的视频播放 ；
				   //分辨率不直接从改video.asp上取，主要是考虑到一台设备已修改分辨率到底层，另一台设备在没有刷新实时浏览页面时切换视频大小时有突然的变化

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
			var rMax = top.leftFrame.document.getElementById("resMax").value;
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
	var rMin = top.leftFrame.document.getElementById("resMin").value;
	videoGetRes(rMin);
	resFlag = false;
	}
	catch(e){resFlag = true;}
}


function compareh264()
{
	var WW = document.documentElement.clientWidth, WH = document.documentElement.clientHeight;
	var ratio = WW/WH;
	var player = document.getElementById("Player");
	if(ratio >= w/h)
	{
		if(WH >0)
		{
			player.height =WH - 4;
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
				parent.parent.leftFrame.document.getElementById("in_on").style.display = "none";
				parent.parent.leftFrame.document.getElementById("in_off").style.display = "inline";
			}
			else
			{
				parent.parent.leftFrame.document.getElementById("in_off").style.display = "none";
				parent.parent.leftFrame.document.getElementById("in_on").style.display = "inline";
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
					parent.parent.leftFrame.document.getElementById("startR").style.display = "none";
					parent.parent.leftFrame.document.getElementById("stopR").style.display  = "inline";
				}
				else
				{
					parent.parent.leftFrame.document.getElementById("stopR").style.display = "none";
					parent.parent.leftFrame.document.getElementById("startR").style.display = "inline";
				}
				
			});
		}
	catch(e){
		setTimeout(arguments.callee,500);
		}

}
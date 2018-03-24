var xmlhttp= null;
var timerIDAlarm = null;
var reqTime = 2000;
var preCode=0;


function topOnload()
{
	addcookie("dev="+document.getElementById("deviceIDGet").value);//更新deviceid信息
	topPic();
	addplayercookie("player","hkvisionMax");
	var prevent = function(){return false;};
	document.body.oncontextmenu = prevent;
	document.body.ondragstart = prevent;
	document.body.onselectstart = prevent;
	
	StartAlarmWorker();
	timeSYNC();
	/*
	$("#in_off").attr("disabled",true);	
	$("#out_off").attr("disabled",true);	
	*///Elroy
}

function topPic()
{
	var picRelate={
		p150:"IR_camera",
		p151:"IR_miniDome",
		p152:"IR_camera",
		p153:"IR_miniDome",
		p158:"IR_camera",
		p159:"IR_camera",
		p160:"IR_miniDome",
		p161:"IR_miniDome"
	};
	var id = parseInt(getCookie("dev"),10);//此文件关于ID判断的有2处
//	var index = Math.floor(id/2);
	var deviceType = picRelate["p"+id];
	if(deviceType){
		var pic = "../images/hkvision_"+deviceType+".gif";
		$(".logoPic").css("background","url(" + pic +") no-repeat");
	}
}

function StartAlarmWorker()
{
	return ;
	var ix,code=0,stateChange;//加stateChange主要是为了屏蔽IE9上视频闪烁的问题
	try
	{
		//txt=$.ajax({url:"/cgi/getAlarmStatus"}).responseText;
		$.ajax({url:"/cgi/getAlarmStatus",
				cache:false,
				dataType:"text",
				timeout:reqTime*2,
				success:function(data)
				{
						ix=data.indexOf("OK getalarmstatus=");
						var state = data.indexOf("alarmArea=");
						if(state>=0){
							code = data.substring(state+10,state+17);
							addcookie("alarmArea="+code);
						}
						if(ix>=0)
						{
							code=data.substring(ix+18,ix+19);
							code=parseInt(code);
							stateChange = code == preCode ? 0 : 1;
							if(stateChange)
							{
								if(code==1)
								{
									$("#img1").hide();
									$("#img2").show();
								}
								else
								{
									$("#img2").hide();
									$("#img1").show();
								}
							}
							preCode = code;
		 				 }					
					}
			   });

	}
	catch(e){}
	timerIDAlarm=setTimeout(arguments.callee,reqTime);		
}

function OnUnload()
{	
	clearTimeout(timerIDAlarm);
}


//*******************************************************************************************


function backsetting(page1,page2)
{
	var dataObj = new Date();
	top.leftFrame.document.location.replace("/browse/" + page1 + "?_="+dataObj.getTime());
	top.mainFrame.document.location.replace("/browse/settings/" + page2 + "?_="+dataObj.getTime());
	
}



function backlive(page)
{
	var dataObj = new Date();
	top.rightFrame.document.location.replace("/browse/video/"+ page + "?_=" +dataObj.getTime());
	top.mainFrame.document.location.replace("/browse/video/videoindex.asp"+ "?_=" + dataObj.getTime());
}



/********************public**************************/

function setDownStyle()
{
	//// document.getElementById('li1').style.backgroundImage = "url(../images/topbutton1.gif)";
	//// document.getElementById('li0').style.backgroundImage = "url(../images/topbutton0.gif)";
	
	// document.getElementById('li1').style.backgroundColor = "#505050";	
	// document.getElementById('li1').style.color = "#ffffff";
	
	// document.getElementById('li0').style.backgroundColor = "#cfcece";
	// document.getElementById('li0').style.color = "#000000";
	
	$(".topmenu ul li").removeClass("selected");
	$("#li1").addClass("selected");
}

function realScanDownStyle()
{
/* 	// document.getElementById('li0').style.backgroundImage = "url(../images/topbutton1.gif)";
	// document.getElementById('li1').style.backgroundImage = "url(../images/topbutton0.gif)";
	
	document.getElementById('li0').style.backgroundColor = "#505050";	
	document.getElementById('li0').style.color = "#ffffff";
	
	document.getElementById('li1').style.backgroundColor = "#cfcece";
	document.getElementById('li1').style.color = "#000000"; */
		$(".topmenu ul li").removeClass("selected");
	$("#li0").addClass("selected");
	
}
function leftFrameNarrow()
{
	parent.document.getElementById("main").cols = "260,*,0";
}

function leftFrameBroad()
{
	parent.document.getElementById("main").cols = "0,*,280";	
}

function lanSelectDisappear()
{	
	document.getElementById('lanSelect').style.display = 'none';
}
function lanSelectOn()
{	
	document.getElementById('lanSelect').style.display = 'inline';
}
/*20130107 add*/
function butSelectDisappear()
{	
	if(document.getElementById('butSelect')){
		document.getElementById('butSelect').style.display = 'none';
	}
	
}

function butSelectOn()
{	
if(document.getElementById('butSelect'))
	document.getElementById('butSelect').style.display = 'inline';
}
/*justin add 2013.5.7*/
function recordSelectOn()
{
	//by zhouyan
	//document.getElementById('startR').style.display = 'block';
}
/********************EN***************************/
function set(page1,page2)
{
	setDownStyle();
	lanSelectDisappear();
	butSelectDisappear();
	leftFrameNarrow();
	try{
		backsetting(page1,page2);
	}
	catch(e){setTimeout(arguments.callee,200);}
}
//add by zhouyan for TopMenu replayBtn at 2018/3/5
function replay(page)
{
	$(".topmenu ul li").removeClass("selected");
	$("#li2").addClass("selected");
	
	parent.document.getElementById("main").cols = "0,*,0";	
	try{
		var dataObj = new Date();
		top.mainFrame.document.location.replace("/browse/settings/" + page + "?_="+dataObj.getTime());
	}
	catch(e)
	{setTimeout(arguments.callee,200);}

}

function realScan(page)
{
	addplayercookie("player","hkvisionMax");
	realScanDownStyle();
	lanSelectOn();
	butSelectOn();
	leftFrameBroad();
	recordSelectOn();	//new added by justin 2013.5.7
	
	try{
		backlive(page);	
	}
	catch(e)
	{setTimeout(arguments.callee,200);}

}


/********************languge change***************************/
function lanChange()
{
	var i = document.getElementById('lanSelect').selectedIndex;
	switch(i)
	{
		case 0:
			document.location.replace("/browse/top/roottop.asp");
			realScan('videoset.asp')
			break;
		case 1:
			document.location.replace("/browse/top/roottopC.asp");
			realScan('videosetC.asp')
			break;
		default:
			break;
	}
}

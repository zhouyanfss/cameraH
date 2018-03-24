<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>VideoIndex</title>
<script type="text/JavaScript" src="../javascript/cookie.js"></script>
<script language="JavaScript" type="text/JavaScript">

var W,H;
var constBottomHeight = 32;
function getRes(i)
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
	W = res[0];
	H = res[1];
}
function maxWH()
{
	var rMax = parent.rightFrame.document.getElementById('resMax').value;
	getRes(rMax);
}


function minWH()
{
	var rMin = parent.rightFrame.document.getElementById('resMin').value;
	getRes(rMin);
}


function MjpegWH()
{
	var rMjpeg = parent.rightFrame.document.getElementById('resMjpeg').value;
	getRes(rMjpeg);
}

function resizeBottom(type)
{
	var width;
	if(type == "object")
	{
		width = parent.mainFrame.videomainFrame.Player.width;
	}
	else
	{
		width = parent.mainFrame.videomainFrame.document.getElementById('myImg2').width;
	}
	
	parent.mainFrame.videomainFrame.document.getElementById("videoBottom").style.width  = width+"px";
}

window.onresize = function adaptwindow(){
try
{	
	var sizeselect = parent.rightFrame.document.getElementById('videoSizeSelect').value;
	var videotype = parent.rightFrame.document.getElementById('BitSelect').value;

	switch(videotype)
	{
		case '2'://mjpeg
			MjpegWH();
			if(sizeselect == 3)
			{
				compareMjpet();
			}

			if(sizeselect == 4)
			{
				parent.mainFrame.videomainFrame.document.getElementById('myImg1').width = parent.parent.mainFrame.document.documentElement.clientWidth - 8;
				parent.mainFrame.videomainFrame.document.getElementById('myImg1').height = parent.parent.mainFrame.document.documentElement.clientHeight -constBottomHeight;
				parent.mainFrame.videomainFrame.document.getElementById('myImg2').width = parent.parent.mainFrame.document.documentElement.clientWidth - 8;
				parent.mainFrame.videomainFrame.document.getElementById('myImg2').height = parent.parent.mainFrame.document.documentElement.clientHeight -constBottomHeight;
			}
			
			
			setTimeout("resizeBottom('mjpeg')",200);
			
			break;
		case '1'://minor
			if(typeof(parent.mainFrame.videomainFrame.Player) == "object")
			{
				minWH();
				if(sizeselect == 3)
				{
					compare();
				}
		
				if(sizeselect == 4)
				{
					fullScreen();
				}
			}
			
			setTimeout("resizeBottom('object')",200);
			break;
		default:
			if(typeof(parent.mainFrame.videomainFrame.Player) == "object")
			{
				maxWH();
				if(sizeselect == 3)
				{
					compare();
				}
		
				if(sizeselect == 4)
				{
					fullScreen();
				}
			}
			
			setTimeout("resizeBottom('object')",200);
			break;
			
	}
	return;
}	
catch(e){setTimeout("adaptwindow()",500);}
}


function fullScreen()
{
			var obj = parent.mainFrame.videomainFrame.Player;
			obj.height = parent.mainFrame.videomainFrame.document.documentElement.clientHeight - 4 -constBottomHeight;
			obj.width = parent.mainFrame.videomainFrame.document.documentElement.clientWidth;
			
			
}

function compare()
{
	var ratio = parent.mainFrame.videomainFrame.document.documentElement.clientWidth/(parent.mainFrame.videomainFrame.document.documentElement.clientHeight -constBottomHeight);
	var obj = parent.mainFrame.videomainFrame.Player;
	
	if(ratio >=  W/H)
	{
		if(parent.mainFrame.videomainFrame.document.documentElement.clientHeight >0)
		{

				obj.height = parent.mainFrame.videomainFrame.document.documentElement.clientHeight -constBottomHeight;
				obj.width = Math.floor((parent.mainFrame.videomainFrame.document.documentElement.clientHeight )*W/H);
		}
		else
		{
			obj.height = 1;
			obj.width = 1;
		}	
	}
	else
	{
		if(parent.mainFrame.videomainFrame.document.documentElement.clientWidth>0)
		{

				obj.height = Math.floor((parent.mainFrame.videomainFrame.document.documentElement.clientWidth)*H/W);
				obj.width = parent.mainFrame.videomainFrame.document.documentElement.clientWidth;	
		}
		else
		{
			obj.height = 1;
			obj.width = 1;
		}
	}
}

function compareMjpet()
{
	var ratio = (parent.mainFrame.document.body.clientWidth - 8)/parent.mainFrame.document.body.clientHeight;	
	var image1 = parent.mainFrame.videomainFrame.document.getElementById('myImg1');
	var image2 = parent.mainFrame.videomainFrame.document.getElementById('myImg2');
	var mainAreaHeight = parent.mainFrame.document.body.clientHeight -constBottomHeight;
	if(ratio > W/H)
	{
			if(parent.mainFrame.document.body.clientHeight > 0)
			{
				image1.width = Math.floor((mainAreaHeight)*W/H); image1.height = mainAreaHeight;
				image2.width = Math.floor((mainAreaHeight)*W/H); image2.height = mainAreaHeight;
			}
			else
			{
				image1.width = 1; image1.height = 1;
				image2.width = 1; image2.height = 1;
			}
	}
	else
	{
		if(parent.mainFrame.document.body.clientWidth - 8 > 0)
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

</script>
</head>
<frameset rows="*" cols="*,8" framespacing="0" frameborder="no" border="0" name="mid" id="mid">
  <frame src="video.asp" name="videomainFrame" id="videomainFrame" />
  <frame src="spread.asp" name="spreadFrame" id="spreadFrame" scrolling="NO" noresize/>
</frameset>
<noframes>
	<body>
	</body>
</noframes>
</html>

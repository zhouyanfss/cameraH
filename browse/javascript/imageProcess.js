var image1, image2, myImage;
var timer, imageSrc, count;
var key, isStopped, host;
var pro="http:";
var isFirefox=navigator.userAgent.indexOf("Firefox")
var lang = 	navigator.language||navigator.systemLanguage;

var constBottomHeight = 32;

function initLan()
{
	var Language = 1;
	try{
		if(parent.parent.topFrame.lanSelect.value == '0'){
		  Language = 0;
		}else{
		  Language = 1;
		}
	}catch(e){
	    
	}
	//if(lang.toLowerCase()!="zh-cn")
	if(Language==0)
	{
		$(".selectButton img,.btnArea").each(function(){
			if($(this).attr("_title"))
			{
				$(this).attr("title",$(this).attr("_title"))
			}
		});
		
		$(".btnArea select option").each(function(){
			if($(this).attr("_enlan"))
			{
				$(this).text($(this).attr("_enlan"))
			}
		});
	}
}

function init(hostv, imageId1, imageId2)
{
//	try{
//		pro = location.protocol;
//	}catch(e){pro="http:";}
	
	image1 =  document.getElementById(imageId1);
	image2 = document.getElementById(imageId2);
	isStopped = false;
	//count = 10;
	count = 10;
	key = (new Date()).getTime();
	host= hostv;
	imageSrc = pro + "//" + host + "/jpgmulreq/1/image.jpg?key=" + key + "&lq="; 	
	
	var interval = 70;
	image1.onload = function(){
		//image2.style.display = "none";
		//image1.style.display = "";
		if(isFirefox > 0){
			image1.style.zIndex =10;
		}
		else{
			image2.style.display = "none";
			image1.style.display = "";
		}
		myImage = image2;
		if(!isStopped)
			timer = setTimeout("request()", interval);
			
	//	var tb = document.getElementById('mytbl');
	//	tb.height = image1.offsetHeight+18;
	};	
	image1.onerror = function(){
		window.status = ("download error");
		if(!isStopped)
			timer = setTimeout("request()", 5000);	
	};	
	image1.onabort = function(){
		window.status = "download abort";
		timer = null;
	};
	image1.src = "../images/hkvision_mjpeg.gif";
	
	image2.onload = function(){
		//image1.style.display = "none";
		//image2.style.display = "";
		if(isFirefox > 0){
			image1.style.zIndex =-1;
		}else{
			image1.style.display = "none";
			image2.style.display = "";
		}
		myImage = image1;		
		if(!isStopped)
			timer = setTimeout("request()", interval);	
	};	
	image2.onerror = function(){
		window.status = ("download error");
		if(!isStopped)
			timer = setTimeout("request()", 5000);	
	};	
	image2.onabort = function(){
		window.status = ("download abort");
		timer = null;
	};
	
	myImage = image2;
	timer = setTimeout("request()", 100);
}

function request()
{
//	if(count > 69)
//		count = 10;
	count = count==3000 ? 10 : ++count;
	//myImage.src = imageSrc + count++;
	myImage.src = imageSrc + count;
	window.status = " ";
}

function stopRequest()
{
	isStopped = true;
	closeCon();
	//setTimeout("closeCon()", 400);
	if(timer != null)
		clearTimeout(timer);
}

function restart()
{
	isStopped = false;
	key = (new Date()).getTime();
	imageSrc = pro + "//" + host + "/jpgmulreq/1/image.jpg?key=" + key + "&lq="; 	
	timer = setTimeout("request()", 100);
}

function closeCon()
{
	try{
		var	sURL = pro + "//" + host + "/jpgmulreq/1/image.jpg?close=true&key=" + key + "&" + (new Date()).getTime();	
		var xmlHttp = createXmlHttpRequestObject();
		xmlHttp.open("GET", sURL, true); 
		xmlHttp.setRequestHeader("Connection", "close");	
		xmlHttp.send();
	}catch(e){}
}

function createXmlHttpRequestObject() 
{
   var xmlHttp;
   try
   {
     xmlHttp = new XMLHttpRequest();
   }
   catch(e)
   {
     var XmlHttpVersions = new Array("MSXML2.XMLHTTP.6.0",
                                     "MSXML2.XMLHTTP.5.0",
                                     "MSXML2.XMLHTTP.4.0",
                                     "MSXML2.XMLHTTP.3.0",
                                     "MSXML2.XMLHTTP",
                                     "Microsoft.XMLHTTP");
     for (var i=0; i<XmlHttpVersions.length && !xmlHttp; i++) 
     {
       try 
       { 
         xmlHttp = new ActiveXObject(XmlHttpVersions[i]);
       } 
       catch (e) {}//{//alert("mjpeg error");}
     }
   }
   if (!xmlHttp)
     alert("Error creating the XMLHttpRequest object.");
   else 
     return xmlHttp;
}

function showImage()
{	
		var w=750;
		var h=635
		var l=0;  
		var t=0;  
		var IP = location.host;
		window.open("http://"+IP+"/browse/mjpeg/shot.htm", "Title", "Toolbar=no,scrollbars=yes,Location=no,Direction=no,Resizeable=no,Width=" 
					  + w + " ,Height=" + h + ",top=" + t +",left=" + l);  
		stopRequest();
}

function fun()
{
	var IP = location.host;
	init(IP, "myImg1", "myImg2");
	
}


function initMjpegVideosize()
{	
	if(isFirefox > 0)
	{	
		$("#myImg1").css("position","absolute");
		$("#myImg2").css("position","relative");
	}
	
	image1 = document.getElementById('myImg1');
	image2 = document.getElementById('myImg2');
	var tmpRes = top.rightFrame.document.getElementById('resMjpeg').value;
	var W, H;
	switch(tmpRes)
	{

		case "10":
			W = 1920;
			H = 1080;
			break;	
		case "14":
			W = 1280;
			H = 1024;
			break;
		case "5":
			W = 1280;
			H = 720;
			break;
		case "17":
			W = 720;
			H = 480;
			break;
		default:
			W = 1280;
			H = 1024;
			break;
	}
	
	var ratio = (parent.document.body.clientWidth - 8)/parent.document.body.clientHeight;	
	if(ratio > W/H)
	{
			if(parent.document.body.clientHeight > 0)
			{
				image1.width = Math.round((parent.document.body.clientHeight)*W/H); image1.height = parent.document.body.clientHeight -constBottomHeight;
				image2.width = Math.round((parent.document.body.clientHeight)*W/H); image2.height = parent.document.body.clientHeight -constBottomHeight;

			}
			else
			{
				image1.width = 1; image1.height = 1;
				image2.width = 1; image2.height = 1;
			}
	}
	else
	{
		if(parent.document.body.clientWidth-8 > 0)
		{
			image1.width = document.body.clientWidth-8; image1.height = Math.round((document.body.clientWidth-8)*H/W);
			image2.width = document.body.clientWidth-8; image2.height = Math.round((document.body.clientWidth-8)*H/W);
		}
		else
		{
				image1.width = 1; image1.height = 1;
				image2.width = 1; image2.height = 1;	
		}	
	}
	if(isFirefox > 0){
		var left = (parent.document.body.clientWidth - image1.width)/2;
		image1.style.left = left;
	}
	
	var bottomDiv=document.getElementById("videoBottom");
	bottomDiv.style.width = image2.width + "px";
}

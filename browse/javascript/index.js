/* JavaScript Document*/
//window.addEvent("domready",function(){})
window.onload=function(){initPage();return;}

window.onresize=function(){resize();}
var lanset;
var username = ["User Name:","用户名:"];
var password = ["PassWord","密 码:"];
var langeuage = ["Langeuage","语言"];
var login = ["Login","登   录"];
var cancel = ["Cancel","取 消"];
var lan_ch = ["Chinese","中文"];
var lan_en = ["English","英文"];
var passwd_rem = ["Remember Me","记住密码"];
var ocx_down = ["please download and install the ActiveX.","点击此处下载控件，安装时请关闭浏览器"];
var back_img =["images/logon.png","images/logon.png"];
var login_error = ["The username or password error,please try again!","用户名或密码错误！"];
var imagefloag = 0,pztfloag = 0;
var HEADER_MENUS_ITEM=110;
var b_INIT_MENUS_LIVEVIEW=!1, b_INIT_MENUS_SETTING=!1, b_INIT_REPLAY_PAGE=!1, b_INIT_ONRESIZE=!1;
var timeProcess_RESIZE;
var sNowURLName = "local";
var Sys={},ua=navigator.userAgent.toLowerCase(),s;
(s=ua.match(/msie ([\d.]+)/))?Sys.ie=s[1]:(s=ua.match(/firefox\/([\d.]+)/))?Sys.firefox=s[1]:(s=ua.match(/chrome\/([\d.]+)/))?Sys.chrome=s[1]:(s=ua.match(/opera.([\d.]+)/))?Sys.opera=s[1]:(s=ua.match(/version\/([\d.]+).*safari/))&&(Sys.safari=s[1]);

function initPage(){
	try{
		parent.moveTo(0,0); parent.resizeTo(screen.width,screen.height-30); parent.focus();
	}catch(e){}
	initLanguage();
	$("#username").val("admin");
	$("#password").focus();$("#password").select();
	if(readcookie("pass_rem"))
	{
		var pass_rem = parseInt(getCookie("pass_rem"));
		if(pass_rem == 1)
			$("#password").val(getCookie("rem_password"));
	}
	else{
		setcookie("pass_rem",1);
		$("#password").val("admin");
	}
	$("#rem_value").val(parseInt(getCookie("pass_rem")));

	if($("#rem_value").val() == '0'){
		$("#rem_check").css("backgroundImage","url()");
	}
	else{
		$("#rem_check").css("backgroundImage","url(images/check.png)");
	}
	return true;
}
function initLanguage(){

	var syslan = (navigator.language || navigator.browserLanguage).toLowerCase();//得到浏览器所用的语言
	//alert(syslan.toLowerCase());
	 if(!readcookie("lanSelect"))
	{
		if(syslan.toLowerCase() == "zh-cn")
			lanset=1;
		else
			lanset=0;
		setcookie("lanSelect",lanset);
	}
	else
		lanset = parseInt(getCookie("lanSelect"));


	//$("#lg").css("background-image","url("+back_img[lanset]+")");
	$("#liUserName").text(username[lanset]);
	$("#liPassword").text(password[lanset]);
	$("#lilanguage").text(langeuage[lanset]);
	$("#b_login").text(login[lanset]);
	$("#b_cancel_l").text(cancel[lanset]);
	$("#check_label").text(passwd_rem[lanset]);
	$("#liOCX").text(ocx_down[lanset]);
	var lang_select=document.getElementById('languagechoose');
	lang_select.selectedIndex=lanset;
	lang_select.options[0].text=lan_en[lanset];
	lang_select.options[1].text=lan_ch[lanset];
	return true;
}
function lanChange()
{
	var i = document.getElementById('languagechoose').selectedIndex;
	switch(i)
	{
		case 0:
			setcookie("lanSelect",0);
			break;
		case 1:
			setcookie("lanSelect",1);
			break;
		default:
			break;
	}
	initLanguage();
}
function resize(){
	
	var a, b;
	//var myos = appInfo();
	a = document.documentElement.clientWidth - 200;
	b = document.documentElement.clientHeight;
	if(a < 1000) a = 1000;
	if(b < 600) b = 600;
	return  true;
}
function getlevel(text){
	var level = text.toString().match(/\$LEVEL\$=\d+/i);
	level = null==level? false : parseInt(level[0].match(/\d+/),10);
	return level;
}
function loginweb()
{
	setcookie("rem_password",$("#password").val());
	$.post("/form/UserLogin",{"name":$("#username").val(),"password":$("#password").val()},function(text){
		var state = getState(text);
		
		if(state){
					var level = getlevel(text);
					if(level)
						addcookie("SU="+$("#username").val());
					else
						addcookie("NU="+$("#username").val());
					document.location.replace("/browse/main.asp");
				}
		else
			alert(login_error[lanset]);
	},'text');

	
}

function setcookie(cookiestring, value)   
{   
  var Days = 30;
  var exp = new Date(); 
  exp.setTime(exp.getTime() + Days*24*60*60*1000);
 
  document.cookie = cookiestring + "=" + escape(value)+ ";expires=" + exp.toGMTString()+ ";path=/";   
}

function setFullScreen()
{


}

function setStreamType(type)
{	
	parent.leftFrame.document.getElementById('BitSelect').selectedIndex = type;
	parent.leftFrame.document.getElementById('videoSizeSelect').selectedIndex = 3;
	switch(parent.leftFrame.document.getElementById('BitSelect').value){
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

function rem_change()
{
	if($("#rem_value").val() == '0'){
		$("#rem_check").css("backgroundImage","url()");
		$("#rem_value").val(1);
	}
	else{
		$("#rem_check").css("backgroundImage","url(images/check.png)");
		$("#rem_value").val(0);
	}

	setcookie("pass_rem",1-parseInt($("#rem_value").val()));
}

function activeX_down() 
{
	if(parseInt($("#HAS_IPC_AX").val()) == 1)
		window.location.href='video/IPC_AX.exe';
	else{
		if(lanset == 1)
			window.location.href='video/download.asp';
		else
			window.location.href='http://pan.baidu.com/s/1gd6LYt9'
	}
}
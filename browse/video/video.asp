<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Video</title>
<script type="text/javascript" src="../javascript/jquery.js"></script>
<script type="text/javascript" src="../javascript/cookie.js"></script>
<script type="text/javascript" src="../javascript/videoset.js"></script>
<script type="text/javascript" src="../javascript/top.js"></script>
<script type="text/javascript">
function Click(){window.event.returnValue=false;}
document.oncontextmenu=Click; 
window.onbeforeunload = Unload;
window.onresize = win_resize;
var Language = 0;
var IPC_AX_exist = 0;
function win_resize(){
	var add_height = document.documentElement.clientHeight -4;
	var add_heitht_div = (document.documentElement.clientHeight -4)/2 - 50;
	$("#down_exe").height(add_height);
	$("#down_exe").css("text-align","center");
	$("#text_lan").css("padding-top",add_heitht_div);
}
function getPlayer() {
	return document.getElementById("Player");
}

function loadexe()
{
	//document.hideframe.location.href='IPC_AX.exe';	
}

function reload()
{
	document.hideframe.location.href='index.asp';	
}

function loadAtten(){
	var player = document.getElementById("Player");
	/*
	if(player.object == null && !(navigator.userAgent.indexOf("Safari") != -1 && navigator.userAgent.indexOf("Chrome") == -1))
	{
		$("#down_exe").show();
		$("#mpg4Ocx").hide();
		$("#down_exe").css("background-color","#B2B2B2");
	}
	else
	{
		$("#down_exe").hide();
		$("#mpg4Ocx").show();
		$("#down_exe").css("background-color","#F9F6F6");
	}
	*/
	if(!(navigator.userAgent.indexOf("Safari") != -1 && navigator.userAgent.indexOf("Chrome") == -1))
	{
		try{
			player.StopPlay();
			$("#down_exe").hide();
			$("#mpg4Ocx").show();
			$("#down_exe").css("background-color","#F9F6F6");
			IPC_AX_exist = 1;
		}
		catch(e){
			$("#down_exe").show();
			$("#mpg4Ocx").hide();
			$("#down_exe").css("background-color","#B2B2B2");
		}
	}
	else
	{
		$("#down_exe").hide();
		$("#mpg4Ocx").show();
		$("#down_exe").css("background-color","#F9F6F6");
	}
}

function HankP(){ 
  try{
    if(parent.parent.topFrame.lanSelect.value == '0'){
      Language = 0;
    }else{
      Language = 1;
    }
  }catch(e)
  {
    var lang = 	navigator.language||navigator.systemLanguage;
	if(lang.toLowerCase() == "zh-cn")
		Language = 1;
	else
		Language = 0;
  }
	if(Language==1)
	{
		$("#firefox_text").html("<h4>首次使用网页请下载<a href='ffactivex-setup-r39.exe'>FFActiveX工具</a>并安装，并下载<a href='axhost.r39.xpi'>ActiveX Hosting 插件</a>拖到Firefox浏览器中进行安装</h4>");
		$("#chrome_text").html("<h3>首次使用网页请下载<a href='ffactivex-setup-r39.exe'>FFActiveX工具</a>并安装，并下载<a href='chrome.r39.crx'>ActiveX Hosting 插件</a>拖到Chrome浏览器中进行安装</h3>");
		if($("#HAS_IPC_AX").val() == "1")
			$("#text_lan").html("<h3><br>点此<a href='IPC_AX.exe' onclick='loadexe()'><font size='5'>下载控件</font></a>，安装成功后请<a href='#' onclick='window.location.reload();'><font size='5'>刷新页面</font></a>。</h3>");
		else
			$("#text_lan").html("<h3><br>点此<a href='download.asp' onclick='loadexe()'><font size='5'>下载控件</font></a>，安装成功后请<a href='#' onclick='window.location.reload();'><font size='5'>刷新页面</font></a>。</h3>");
	}
	else
	{
		$("#firefox_text").html("<h3>If it's first time you open the browser, please download and install <a href='ffactivex-setup-r39.exe'>FFActiveX Tools</a>, and then download and drag<a href='axhost.r39.xpi'>ActiveX Hosting Plugin</a>to Firefox to install</h3>");
		$("#chrome_text").html("<h3>If it's first time you open the browser, please download and install <a href='ffactivex-setup-r39.exe'>FFActiveX Tools</a>, and then download and drag<a href='chrome.r39.crx'>ActiveX Hosting Plugin</a>to Chrome to install</h3>");
		if($("#HAS_IPC_AX").val() == "1")
			$("#text_lan").html("<h3><br>click here<a href='IPC_AX.exe' onclick='loadexe()'><font size='5'>download control</font></a>.After install the control, <a href='#' onclick='window.location.reload();'><font size='5'>refresh the page</font></a> please.</h3>");
		else
			$("#text_lan").html("<h3><br>click here<a href='https://1drv.ms/u/s!AvEAxOp0F01Ua3MNUvLCVJeDyf0' target='_blank' onclick='loadexe()'><font size='5'>download control</font></a>.After install the control, <a href='#' onclick='window.location.reload();'><font size='5'>refresh the page</font></a> please.</h3>");
	}
	if(navigator.userAgent.indexOf("Chrome") != -1)
	{
		$("#chrome_text").show();
	}
	else
	{
		$("#chrome_text").hide();
	}
	if(navigator.userAgent.indexOf("Firefox") != -1)
	{
		$("#firefox_text").show();
	}
	else
	{
		$("#firefox_text").hide();
	}
}
function Audio_Init()
{
	var bOut = getCookie("audioout");
	var bIn = getCookie("audioin");
	var bZoom = getCookie("zoom_status");
	var player = document.getElementById("Player");
	//alert(bOut+","+bIn);
	if(bOut == 1)
	{
		player.SetAudioRx(1,0);
	}
	if(bIn == 1)
	{
		player.SetAudioTx(1);
	}
	if(bZoom == 1)
	{
		player.SetDigitalZoom(1);
	}
}
function compare_version()
{
	var ocx_version = "2.4.13.10";		
	var ocx_version_265 = "2.4.13.10";	
	
	var hi3519_board = parseInt($("#Hi3519").val());
	if(hi3519_board)
	{
		ocx_version = "2.4.14.0";
		ocx_version_265 = "2.4.14.0";
	}

	try{
		var player = document.getElementById("Player");
		var version_old = player.GetOcxVersion().split('.');
		
		var hi3516a_board = parseInt($("#Hi3516A").val());
		var version_new = ocx_version.split('.');
		if(hi3516a_board)
			version_new = ocx_version_265.split('.');
	
		for (var i = 0; i < 4; i++) {
			if (parseInt(version_new[i]) > parseInt(version_old[i])) {
				ocx_update_confirm();
				break;
			}
		}
	}catch(e){
			if(IPC_AX_exist == 1)
				ocx_update_confirm();
	}
}
function ocx_update_confirm(){
	var confirmStr=["The new version of ActiveX is available,are you sure to update?\nThe web browser must be closed during the installing!",
				"检测到控件有新版本，是否升级?\n新控件安装过程中请关闭浏览器!\n"];
	var ocx_show_once = parent.parent.topFrame.document.getElementById('OCX_ONCE').value;
	if(parseInt(ocx_show_once) == 1){
		if(window.confirm(confirmStr[Language])){
			if(parseInt($("#HAS_IPC_AX").val()) == 1)
				window.location.href='IPC_AX.exe';
			else{
				if(Language == 1)
					window.location.href='download.asp';
				else
					window.open( "https://1drv.ms/u/s!AvEAxOp0F01Ua3MNUvLCVJeDyf0","_blank");
			}
		}
		parent.parent.topFrame.document.getElementById('OCX_ONCE').value=0;
	}
}
</script>
</head>
<body ondrag="return false" onload="set_height_width();loadAtten();HankP();compare_version();" style="margin:0;padding:0;background-color:#F9F6F6; ">
<input type="hidden" id="HAS_IPC_AX" value='<%SystemInfoGet("has_IPC_AX", "net");%>' />
<input type="hidden" id="Hi3516A" value='<%videoparaGet("hi3516a", "net");%>' />
<input type="hidden" id="Hi3519" value='<%videoparaGet("hi3519", "net");%>' />
<iframe id="hideframe" name="hideframe" style="display: none;"></iframe>
<div id="down_exe" style="display:none;">
	<div id="firefox_text"></div>
	<div id="chrome_text"></div>
	<div id="text_lan" style="color:red;"></div>
</div>
<div align="center" id="mpg4Ocx">
	<script type="text/javascript" language="javascript" src="../javascript/browseEm.js"></script>
    <!--<div align="center" id="Player" style="background-color:#3CC"></div>-->
</div>
<script type="text/javascript">
	setTimeout("Audio_Init()",3000);
</script>
</body>
</html>

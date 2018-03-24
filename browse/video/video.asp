<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Video</title>
<link href="../css/video.css" rel="stylesheet" type="text/css">
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
		
		$(".selectButton img").each(function(){
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
	    //by zhouyan for debug
		//if(window.confirm(confirmStr[Language])){
		//	if(parseInt($("#HAS_IPC_AX").val()) == 1)
		//		window.location.href='IPC_AX.exe';
		//	else{
		//		if(Language == 1)
		//			window.location.href='download.asp';
		//		else
		//			window.open( "https://1drv.ms/u/s!AvEAxOp0F01Ua3MNUvLCVJeDyf0","_blank");
		//	}
		//}
		parent.parent.topFrame.document.getElementById('OCX_ONCE').value=0;
	}
}
</script>
</head>
<body ondrag="return false" onload="set_height_width();loadAtten();HankP();compare_version();" style="margin:0;padding:0;background-color:#aaaaaa; ">
<input type="hidden" id="HAS_IPC_AX" value='<%SystemInfoGet("has_IPC_AX", "net");%>' />
<input type="hidden" id="Hi3516A" value='<%videoparaGet("hi3516a", "net");%>' />
<input type="hidden" id="Hi3519" value='<%videoparaGet("hi3519", "net");%>' />
<input type="hidden" name="resMax" id="resMax"   value="<%videoparaGet("resolution","net");%>" > 
<input type="hidden" name="resMin" id="resMin"   value="<%ExtVideoparaGet("resolution","net");%>" > 
<input type="hidden" name="resMjpeg" id="resMjpeg"  value="<%mjpegparaGet("resolution","net");%>" >
<input type="hidden" name="imagePath" id="imagePath"  value="<%IVPathGet("imagepath","net");%>" />
<input type="hidden" name="videoPath" id="videoPath"  value="<%IVPathGet("videopath","net");%>" />
<input type="hidden" name="imageType" id="imageType" value='<%IVPathGet("imageType","net");%>' />
<input type="hidden" name="videoType" id="videoType" value='<%IVPathGet("videoType","net");%>'/>
<input type="hidden" name="audioType" id="audioType" value='<%audioparaGet("AudioFormat","net");%>' />

<iframe id="hideframe" name="hideframe" style="display: none;"></iframe>
<div id="down_exe" style="display:none;">
	<div id="firefox_text"></div>
	<div id="chrome_text"></div>
	<div id="text_lan" style="color:red;"></div>
</div>
<div align="center" id="mpg4Ocx" style=" background-color:#c9c6c6; position:relative;z-index:-1;">
	<script type="text/javascript" language="javascript" src="../javascript/browseEm.js"></script>
    <!--<div align="center" id="Player" style="background-color:#3CC"></div>-->
</div>
<div style="height:30px; display:block; margin:auto;width:100%;background-color:#c9c6c6; border-top:2px solid #999999;">
	   
	<div id="videoBottom" style="height:30px; display:block; margin:auto; position:relative;">
		<div class="btnArea" style="background:url(../images/bfms.png) no-repeat 0px 5px;">
			<div class="selectArea">
				<select name="BitSelect" id="BitSelect" style="height:50px; width:80px;" onChange="vedioParaChange('BitSelect');" class="videoSet_select" multiple="multiple" size="3">
					<option value="0" _enlan="Main stream">主码流</option>
					<option value="1" _enlan="Sub stream">副码流</option>
					<option value="2" _enlan="MJPEG">MJPEG</option>
				</select>
				<iframe id="iframe1" src="about:blank" frameBorder="0" marginHeight="0" marginWidth="0" style="position:absolute; visibility:inherit; top:0px;left:0px;width:80px; height:50px;z-index:-1; filter:alpha(opacity=0);"></iframe>

			</div>
		</div>
		<div class="btnArea" style="background:url(../images/spdx.png) no-repeat 0px 5px; ">
			<div class="selectArea">
				<select name="videoSizeSelect" id="videoSizeSelect" style="height:90px; width:60px;"  class="videoSet_select" onChange="vedioParaChange('videoSizeSelect');" multiple="multiple" size="5">
				  <option value="0">1 x</option>
				  <option value="1">1/2 x</option>
				  <option value="2">1/4 x</option>
				  <option value="3" selected="selected" _enlan="Auto">自适应</option>
				  <option value="4" _enlan="Full">完全</option>
				</select>
				<iframe id="iframe1" src="about:blank" frameBorder="0" marginHeight="0" marginWidth="0" style="position:absolute; visibility:inherit; top:0px;left:0px;width:60px; height:90px;z-index:-1; filter:alpha(opacity=0);"></iframe>

			</div>
		</div>
		<div class="btnArea" style="background:url(../images/splx.png) no-repeat 0px 5px;">
			<div  class="selectArea">
				<select id="playModeSelect" class="videoSet_select"  style="height:34px; width:60px;" onChange="vedioParaChange('playModeSelect');" multiple="multiple" size="2">
				  <option value="0" _enlan="Live">实时</option>
				  <option value="1" _enlan="Smooth">流畅</option>
				</select>
				<iframe id="iframe1" src="about:blank" frameBorder="0" marginHeight="0" marginWidth="0" style="position:absolute; visibility:inherit; top:0px;left:0px;width:60px; height:34px;z-index:-1; filter:alpha(opacity=0);"></iframe>

			</div>
		</div>
		<div class="btnArea" style="background:url(../images/txsc.png) no-repeat 0px 5px;">
			<div class="selectArea">
				<select name="videoColorSelect" id="videoColorSelect" style="height:50px; width:60px;" class="videoSet_select" onChange="vedioParaChange('videoColorSelect');" multiple="multiple" size="3">
				  <option value="0" _enlan="Fresh">鲜艳</option>
				  <option value="1" _enlan="Standard">标准</option>
				  <option value="2" _enlan="Cold">冷色调</option>
				</select>
				<iframe id="iframe1" src="about:blank" frameBorder="0" marginHeight="0" marginWidth="0" style="position:absolute; visibility:inherit; top:0px;left:0px;width:60px; height:50px;z-index:-1; filter:alpha(opacity=0);"></iframe>

			</div>
		</div>
		<!--
		<div id="btnArea" style="position:absolute;bottom:37px; z-index:1000;">

			<div class="rowDiv">
				<label class="videoSizeTest_cn1">视频类型</label>
				<select name="BitSelect" id="BitSelect" style="height:50px;" class="videoSet_select" onChange="BitSet();" multiple="multiple" size="3">
					<option value="0">主码流</option>
					<option value="1">副码流</option>
					<option value="2">MJPEG</option>
				</select>
			</div>
			
			<div class="rowDiv">
				<label class="videoSizeTest_cn1">视频大小</label>
				<select name="videoSizeSelect" id="videoSizeSelect" class="videoSet_select" onChange="videoSizeSet();">
				  <option value="0">1 x</option>
				  <option value="1">1/2 x</option>
				  <option value="2">1/4 x</option>
				  <option value="3" selected="selected">自适应</option>
				  <option value="4">完全</option>
				</select>
			</div>
			<div class="rowDiv">
				<label class="videoSizeTest_cn1">播放模式</label>
				<select id="playModeSelect" class="videoSet_select" onChange="playMode();">
				  <option value="0">实时</option>
				  <option value="1">流畅</option>
				</select>
			</div>
			
			<div class="rowDiv">
				<label class="videoSizeTest_cn1">图像色彩</label>
				<select name="videoColorSelect" id="videoColorSelect" class="videoSet_select" onChange="colorMode();">
				  <option value="0">鲜艳</option>
				  <option value="1">标准</option>
				  <option value="2">冷色调</option>
				</select>
			</div>
			
		<iframe id="iframe1" src="about:blank" frameBorder="0" marginHeight="0" marginWidth="0" style="position:absolute; visibility:inherit; top:0px;left:0px;width:120px; height:120px;z-index:-1; filter:alpha(opacity=0);"></iframe>
		</div>
-->
		<div class="selectButton" id="butSelect">
			<div class="unitDivZoom unitDiv">
				<div id="startZ"> 
					<img name="startZP" id="startZP" onclick="startZoom();" src="../images/dzoom.png"  _title="Digital zoom" title="电子放大" >
					<div class="imgMask"></div>			
				</div>	
				<div id="stopZ"  style="display:none;  position:relative;"> 
					<img name="stopZP" id="stopZP" onclick="stopZoom();"  src="../images/dzoom_off.png"  _title="Stop" title="停止" >
					<div class="imgMask"></div>	
			  </div>
			</div>
			<div class="unitDivCamera unitDiv">
				<div id="h264Snap" onclick="setSnapShot();"  _test=1> 
					<img name="SnapShotSet" id="SnapShotSet" src="../images/snap.png"  _title="Snap" title="快照" >			
				</div>
				<div id="mjpegSnap" onclick="showImage();" _test=1 style="display:none"> 
					<img name="SnapShotSet" id="SnapShotSetMjpeg" src="../images/snap.png"  _title="Snap" title="快照" >	
				</div>		
			</div>
			<div class="unitDivCaPath unitDiv" style="display:none;">
					<img id="snapOpen" onclick="openImgDir();" src="../images/path.gif"  _title="Open path" title="打开快拍存储路径">
					<div class="imgMask"></div>	
			</div>
			<div class="unitDivRecord unitDiv">
				<div id="startR"> 
					<img name="startP" id="startP" onclick="startRecord();" src="../images/record_off.png" _title="Start record" title="开始录像" >
					<div class="imgMask"></div>			
				</div>	
				<div id="stopR"  style="display:none;  position:relative;"> 
					<img name="stopP" id="stopP" onclick="stopRecord();"  src="../images/record.png" _title="Stop record" title="停止录像" >
					<div class="imgMask"></div>	
			  </div>
			</div>
			<div class="unitDivOut unitDiv">
					<img name="out_on" id="out_on" onclick="AOut(0);" style="display:none"  src="../images/audio_out.png" _title="Audio out off" title="关闭音频输出">
					<img name="out_off" id="out_off"   onclick="AOut(1);" src="../images/audio_out_off.png" _title="Audio out on" title="开启音频输出">
					<div class="imgMask"></div>
			</div>
			<div class="unitDivRePath unitDiv" style="display:none;">
					<img id="recordOpen" onclick="openVideoDir();" src="../images/path.gif" _title="Open path" title="打开录像存储路径">
					<div class="imgMask"></div>
			</div>
			<div class="unitDivIn unitDiv">
					<img name="in_on" id="in_on" onclick="AIn(0);" style="display:none"  src="../images/audio_in.png"  _title="Audio in off" title="关闭音频输入">
					<img name="in_off" id="in_off"  onclick="AIn(1);"  src="../images/audio_in_off.png" _title="Audio in on" title="开启音频输入">
					<div class="imgMask"></div>	
			</div>



			<div class="unitDivMov" id="motinDiv" style="display:none">
				<input type="hidden" id="motionSwitchGet" value='<%Getalarmpara("MotionSwitch","net");%>' />
				<img id="motion_on" onclick="MSwitch(1);" src="../images/motion_on.gif" _title="Open motion" title="开启移动侦测" />
				<img id="motion_off"  onclick="MSwitch(0);" style="display:none"  src="../images/motion_off.gif" _title="Close motion" title="关闭移动侦测" />
				<div class="imgMask"></div>	
			</div>	
			<div class="unitDivPri" id="privacyDiv" style="display:none">
				<input type="hidden" id="privacySwitchGet" value='<%PrivacyGet("PrivacySwitch","net");%>' />
				<img id="privacy_on" onclick="PSwitch(1);" src="../images/privacy_on.gif" _title="Open privacy" title="开启隐私区域" />
				<img id="privacy_off"  onclick="PSwitch(0);" style="display:none"  src="../images/privacy_off.gif" _title="Close privacy" title="关闭隐私区域" />
				<div class="imgMask"></div>	
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	setTimeout("Audio_Init()",3000);
</script>
</body>
</html>
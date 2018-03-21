<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Firmware Upgrade</title>
<style type="text/css">
html{
	overflow:scroll;
}
body{
	font-size:13px;
	font-family:Verdana, Tahoma, sans-serif;
}
.main{
	margin:auto;
	width:700px;
	height:660px;
}
.topExplain{
	width:100%;
	height:50px;
}
.topExplain label{
	font-weight:bold;
	line-height:25px;
}
.topLine{
	width:100%;
	border-top:2px solid #BBB;
}
.topLine div{
	width:180px;
	height:4px;
	margin:0;
	background-color:#BBB;
	overflow:hidden;
}
fieldset{
	width:660px;
	margin-left:17px;
}
legend{
	font-weight:bold;
}
.sysInf{
	width:100%;
	height:20px;
	padding-top:6px;
}
.sysInf label{
	display:inline-block;
	width:300px;
	margin-left:30px;
	float:left;
}
form{
	margin-top:5px;
	display:block;
	padding:0;
	float:left;
}
.fileType{
	margin-left:30px;
	display:inline-block;
	width:80px;
}
.filePath{
	width:400px;
}
.Note{
	width:600px;
	margin-top:10px;
	padding-left:30px;
	display:block;
	float:left;
}
#cloudDiv{
	width:100%;
	height:90px;
	background-color:#FFF;
	position:absolute;
	top:0;
	left:0;
	filter:alpha(opacity=60);
	opacity:0.6;
	display:none;
}
.button{
	display:block;
	margin-left:480px;
	margin-top:0px;
	height:30px;
	width:70px;
}
</style>
<script type="text/javascript">
var uploadLast=null;
var timeID = 0;
var ingSign = 1;
function typeCheck(fileID,labelID){
	var filePath = document.getElementById(fileID).value;
	var val = 0;
	var reg = new RegExp("\."+labelID+"$","i");
	if("" == filePath){
		val = 1;
	}else if(!filePath.match(reg)){
		val = 2;
	}
	document.getElementById(labelID).style.color = val? "#F00" : "";
	return val;
}
function upload(){
	var kerFilePath = document.getElementById("kernelFile");
	var fsFilePath = document.getElementById("rootfsFile");
	var ifuFilePath = document.getElementById("ifuFile");
	var kerLabel = document.getElementById("ker");
	var fsLabel = document.getElementById("fs");
	var ifuLabel = document.getElementById("ifu");
	
	var val1 = typeCheck('kernelFile','ker');
	var val2 = typeCheck('rootfsFile','fs');
	var val3 = typeCheck('ifuFile','ifu');
	if(1 == val1){
		alert("Please select a local file. (*.ker)");
		kerFilePath.focus();
		return;
	}else if(2 == val1){
		alert("Please check the type of updating file. (*.ker)");
		kerFilePath.focus();
		return;
	}
	if(1 == val2){
		alert("Please select a local file. (*.fs)");
		fsFilePath.focus();
		return;
	}else if(2 == val2){
		alert("Please check the type of updating file. (*.fs)");
		fsiFilePath.focus();
		return;
	}
	if(1 == val3){
		alert("Please select a local file. (*.ifu)");
		ifuFilePath.focus();
		return;
	}else if(2 == val3){
		alert("Please check the type of updating file. (*.ifu)");
		ifuFilePath.focus();
		return;
	}
	var confirmStr="This will stop all services(video, e.g.) provided by the\nunderlying device, and try to upgrade the on-board firmware.\nSince this operation is highly dangerous and may\nmake the device unusable or even cause severe damage to it,\nyou are strongly advised not to do so when not absolutely necessary.\nAre you sure to continue?\n";
	if(!confirm(confirmStr)){
		return;
	};
	document.getElementById("uploadBto").disabled = true;
	document.getElementById("cloudDiv").style.display = "block";
	uploadLast = "ker";
	document.getElementById("attenDiv").style.visibility = "visible";
	document.getElementById("statusDiv").style.visibility = "visible";
	setInnerText("ingFile","Kernel");
	statusShow("ingShow",1);
	document.getElementById("kerForm").submit();
}
function setInnerText(dom,text){
	dom = typeof dom == "string"? document.getElementById(dom): dom;
	if(typeof dom.textContent == "string"){
			dom.textContent = text;
		}else{
			dom.innerText = text;
		}
}
function statusShow(labelID,flag){
	document.getElementById(labelID).style.color = "";
	var ingFun = function(){
		var text = "";
		ingSign = ingSign>20? 1 : ingSign;
		for(var i = 0; i < ingSign; i++){
			text += ">";
		}
		setInnerText(labelID,text);
		ingSign++;
	}
	if(flag){
		clearInterval(timeID);
		timeID = setInterval(ingFun,100);
	}else{
		clearInterval(timeID);
		ingSign = 1;
		setInnerText(labelID,"");
	}
}

function getState(text){
	var state = text.toString().match(/\$STATE\$=\d+/i);
	state = null==state? false : parseInt(state[0].match(/\d+/),10);
	return state;
}
function responseGetVar(response,name){
	var dataStr = response.toString();
	var reg = new RegExp("(\\s|\\b)"+name+"=[^ \f\n\r\t\v]*");
	var matchRes = dataStr.match(reg);
	if(matchRes){
		reg = new RegExp("(\\s|\\b)"+name+"=");
		return matchRes[0].replace(reg,'').toString();
	}else{
		return null;
	}
}
function iframeLoad(){
	if(!uploadLast || "reboot" == uploadLast){
		return;
	}
	var elem = document.getElementById("hideFrame");
	elem = elem.contentDocument || elem.contentWindow.document;
	elem = (typeof elem.documentElement.textContent=="string")?elem.documentElement.textContent: elem.documentElement.innerText;
	if("log" == uploadLast){//获取日志
		uploadLast = null;
		var logName = responseGetVar(elem,"fileName");
		statusShow("ingShowLog",0);
		document.getElementById("statusLog").style.visibility = "hidden";
		document.getElementById("logButton").disabled = false;
		if(logName){
			document.getElementById("hideFrame").src = "/"+logName;
		}
		return;
	}
	var state = getState(elem);
	if(1!=state){
		var alertStr = "";
		switch(state){
			case 2:
				alertStr = "The update file is too large!";
				break;
			case 4:
				alertStr = "Error file operation, please check it and try it again!";
				break;
			default:
				alertStr = "update failed!";
		}
		alert(alertStr+" (*."+uploadLast+")");
		statusShow("ingShow",0);
		document.getElementById(uploadLast).style.color = "#F00";
		document.getElementById("ingShow").style.color = "#F00";
		setInnerText("ingShow",alertStr);
		document.getElementById("uploadBto").disabled = false;
		document.getElementById("cloudDiv").style.display = "none";
		return;
	}
	if("ker" == uploadLast){
		uploadLast = "fs";
		setInnerText("ingFile","Rootfs");
		document.getElementById("fsForm").submit();
	}else if("fs" == uploadLast){
		uploadLast = "ifu";
		setInnerText("ingFile","IFU");
		document.getElementById("ifuForm").submit();
	}else if("ifu" == uploadLast){
		uploadLast = "reboot";
		setInnerText("ingFile","Reboot");
		document.getElementById("hideFrame").src = "/form/bootForm?_"+(new Date()).getTime();
		waitSec(140);
	}
}
function waitSec(sec){
	if(0==sec){
		statusShow("ingShow",0);
		document.getElementById("statusDiv").style.visibility = "hidden";
		document.getElementById("jsSec").style.visibility = "hidden";
		alert("update succeed!");
		document.getElementById("uploadBto").disabled = false;
		document.getElementById("cloudDiv").style.display = "none";
		var href = window.location.href.replace(/\?.*$/g,'');
		window.location = href + "?_=" + (new Date()).getTime();
	}else{
		setInnerText("jsSec",sec--);
		var hander=arguments.callee;
		setTimeout(function(){hander(sec)},1000);
	}
}
function getLog(){
	uploadLast = "log";
	document.getElementById("statusLog").style.visibility = "visible";
	document.getElementById("logButton").disabled = true;
	statusShow("ingShowLog",1);
	document.getElementById("logForm").submit();
}
function resetToFactory(){
    if(window.confirm('Warning:This operation will reset all pamameters and program to factory settings,\nyou are strongly advised not to do so when not absolutely necessary.\nAre you sure to reset to factory settings?')){
	document.getElementById("uploadBto").disabled = true;
	document.getElementById("FactorySet").disabled = true;
	document.getElementById("factoryAttention").style.display = "block";
	 waitFactory(140,'factorySetting')
	document.getElementById("factoryForm").submit();
	}
}
function waitFactory(sec,labelID){
	if(0==sec){
		var href = window.location.href.replace(/\?.*$/g,'');
		window.location = href + "?_=" + (new Date()).getTime();
	}else{
		document.getElementById(labelID).innerHTML=sec--;
		var hander=arguments.callee;
		setTimeout(function(){hander(sec,labelID)},1000);
	}
}
</script>
</head>
<body>
	<iframe onload="iframeLoad()" id="hideFrame" name="hideFrame" style="display:none"></iframe>
	<div class="main">
    	<div class="topExplain">
        	<label>Firmware Upgrade</label>
            <div class="topLine">
            	<div></div>
            </div>
        </div>
        
        <div style="width:100%; border:1px #BBB solid; padding-top:15px">
        	<fieldset>
            	<legend>System Information</legend>
                <div class="sysHank">
                	<label>Kernel:&nbsp;&nbsp;<%getFirmVer("kernel", "net");%></label>
                    <label>Rootfs:&nbsp;&nbsp;<%getFirmVer("rootfs", "net");%></label>
                </div>
            </fieldset>
            <div style="width:100%; height:20px; display:block">&nbsp;</div>
            <fieldset>
            	<legend>Select and Upgrade</legend>
                <div style="width:100%; height:90px;display:block; float:left; position:relative;">
                    <form id="kerForm" method="post" enctype="multipart/form-data" action="/form/writeFlashForm" target="hideFrame" style="margin-top:10px">
                        <input type="hidden" name="type" value="ker" />
                        <label class="fileType">Kernel:</label>
                        <input class="filePath" id="kernelFile" type="file" name="file" />
                        <label id="ker">(*.ker)</label>
                    </form>
                    <form id="fsForm" method="post" enctype="multipart/form-data" action="/form/upldFlashForm" target="hideFrame">
                        <input type="hidden" name="type" value="fs" />
                        <label class="fileType">Rootfs:</label>
                        <input class="filePath" id="rootfsFile" type="file" name="file" />
                        <label id="fs">(*.fs)</label>
                    </form>
                    <form id="ifuForm" method="post" enctype="multipart/form-data" action="/form/upldAppForm" target="hideFrame">
                        <input type="hidden" name="type" value="ifu" />
                        <label class="fileType">IFU:</label>
                        <input class="filePath" id="ifuFile" type="file" name="file" />
                        <label id="ifu">(*.ifu)</label>
                    </form>
                    <div id="cloudDiv"></div>
                </div>
                <div style="width:100%;display:block;float:left;">
                    <i class="Note">
                        Firmware upgrade is very rarely needed, and will stop all normal device services(video, e.g.), make it unusable or even cause severe damage to it, you are strongly advised not to do so when not absolutely necessary. When having to, make sure you have properly arranged all your applications related to this  
    device, so they will continue smoothly when it become avaliable again. When doing this, make sure you have the right data file and have a second check before you do so, and be patient. 
                    </i>
                    <input id="uploadBto" type="button" class="button" value="Upload" onclick="upload()" />
                    <div id="attenDiv" style="margin-top:20px; margin-left:30px; visibility:hidden">
                        <strong style="width:80px; display:inline-block">Attention:</strong>
                        <strong>This operation will take several seconds, please wait...</strong>
                        <strong id="jsSec" style="color:#F00"></strong>
                    </div>
                    <div id="statusDiv" style="margin-top:5px; margin-left:30px; visibility:hidden">
                        <strong style="width:80px; display:inline-block">Status:</strong>
                        <strong id="ingFile" style="width:60px; display:inline-block;"></strong>
                        <label id="ingShow"></label>
                    </div>
                </div>
            </fieldset>
            <div style="width:100%; height:20px; display:block">&nbsp;</div>
            <fieldset style=" display:none;">
            	<legend>Log File</legend>
                <div style="width:100%;display:block; float:left;">
                	<form id="logForm" method="post" action="/form/exportLog" target="hideFrame">
                    	<input type="hidden" name="tarflag" value="1" />
                        <input id="logButton" type="button" class="button" value="Export" onclick="getLog()" />
                    </form>
                </div>
                <div style="width:100%;display:block;float:left;">
                	<div id="statusLog" style="margin-top:5px; margin-left:30px; visibility:hidden">
                        <strong style="width:80px; display:inline-block">Status:</strong>
                        <strong style="width:60px; display:inline-block;">tar</strong>
                        <label id="ingShowLog"></label>
                    </div>
                </div>
            </fieldset>
           
			<fieldset>
			  <legend>HardwareFactorySet</legend>
			  <form  id="factoryForm" method="post" action="/form/HardwareFactorySet" target="hideFrame">
			  <div class="sysHank">
			    <label style="width:450px;">Press the button to reset to factory settings.</label>
				
			  <input type="button" id="FactorySet" value="FactorySet" onclick="resetToFactory()"/>
			  </div></br>
			  <div class="sysHank" id="factoryAttention" style="display:none">
			    <strong style="margin-left:30px;">Attention:This operation will take several seconds, please wait...</strong>
                <strong id="factorySetting" style="color:#F00"></strong>
			  </div>
			  </form>
			  
                        
                    
			</fieldset>
			</br>
        </div>
    </div>
</body>
</html>

// JavaScript Document
if(navigator.userAgent.indexOf("Safari") != -1 && navigator.userAgent.indexOf("Chrome") == -1)
{
	document.write('<object classid="clsid:02BF25D5-8C17-4B23-BC80-D3488ABDDC6B" codebase="http://www.apple.com/qtactivex/qtplugin.cab">');
	document.write('<embed id="Player" src="#" qtsrc="rtsp://');
	document.write(window.location.hostname);
	document.write(':');
	document.write(top.topFrame.document.getElementById('rtspPort').value.toString()||'554');
	if(getCookie("player") == "hkvisionMin")
		document.write('/1/h264minor');
	else
		document.write('/1/h264major');
	document.write('" type="video/quicktime" scale="tofit" width="480" height="270" autoplay="true" controller="false" pluginspage="http://www.apple.com/quicktime/download/"></embed>');
	document.write('</object>');
}
else
{
	if(navigator.userAgent.indexOf("Chrome") == -1 && navigator.userAgent.indexOf("Firefox") == -1)
		document.write('<OBJECT id="Player" width="5" height="5" border="0" classid="clsid:BF55C34E-FB1B-4FAF-8C1D-82C5265D87D9" codebase="../video/IPC_PlayerAX.cab#version=2,0,0,7" standby="Waiting..." viewastext>');
	else
		document.write('<OBJECT id="Player" type="application/x-itst-activex" width="5" height="5" border="0" clsid="{BF55C34E-FB1B-4FAF-8C1D-82C5265D87D9}" progid="../video/IPC_PlayerAX.cab#version=2,0,0,7" standby="Waiting..." viewastext>');
	document.write('<PARAM NAME="_Version" VALUE="65536">');
	document.write('<PARAM NAME="_ExtentX" VALUE="19050">');
	document.write('<PARAM NAME="_ExtentY" VALUE="12700">');
	document.write('<PARAM NAME="_StockProps" VALUE="0">');
	document.write('</OBJECT>');
}

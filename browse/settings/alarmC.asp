<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>报警设置</title>
<link href="../css/part.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../javascript/jquery.js"></script>
<script type="text/javascript" src="../javascript/cookie.js"></script>
<script type="text/javascript" src="../javascript/alarmaccess.js"></script>

</head>
<body onLoad="alarmOnload();initSetBt();">
<input type="hidden" id="PAGE_LANGUAGE" value="1" />
<input type="hidden" name="alarminnum" id="alarminnum" value="<%alarmparaGet("alarminnum","net");%>" />
<input type="hidden" name="alarmoutnum" id="alarmoutnum" value="<%alarmparaGet("alarmoutnum","net");%>" />
<input type="hidden" id="ICEtype" value='<%IntellegentGet("ICEtype","net");%>' />
<input type="hidden" id="CARD_TYPE" value='<%SystemInfoGet("CARD_TYPE","net");%>' />
<iframe id="hideFrame" name="hideFrame" style="display:none ;"></iframe>

<div class="alarmName" style="margin-top:1px;"><label>报警配置</label></div>
<div class="alarmContent" style="height:216px" >
<div class="alarmDiv">
	<!--<form action="/form/alarmparaCfg" method="post" name="alarmAccessForm" target="hideFrame" id="alarmAccessForm">-->
	<form name="alarmAccessForm" id="alarmAccessForm" target="hideFrame" method="post" action="/form/alarmparaCfg">
	<div id="alarmIn1" class="alarmUnitDiv">
		<div>
			<input type="text" style="display:none;" name="alarmin1" id="alarmin1" value="<%alarmparaGet("alarmin1","net");%>" />
			<label>I/O&nbsp;输入1:</label><input type="hidden" name="flag" value="1" />
		</div>
		<select name="Alarmin1Select" id="Alarmin1Select" class="alarmSelect" onchange="alarmAccessFormSubmit();">
			<option value="0">接地</option>
            <option value="1">开路</option>
		</select>
	</div>
	
	<div id="alarmIn2" class="alarmUnitDiv">
		<div>
			<input type="text" style="display:none;" name="alarmin2" id="alarmin2" value="<%alarmparaGet("alarmin2","net");%>" />
			<label>I/O&nbsp;输入2:</label>
		</div>
		<select name="Alarmin2Select" id="Alarmin2Select"  class="alarmSelect" onchange="alarmAccessFormSubmit();">
              <option value="1">开路</option>
              <option value="0">接地</option>
        </select>
	</div>
	
	<div class="alarmUnitDiv">
		<div>
			<input type="text" style="display:none;" name="alarmAccess" id="alarmAccess" value="<%alarmparaGet("alarmAccess","net");%>" />
			<label>报警输出关联:</label>
		</div>
		<select name="AlarmAccessSelect" id="AlarmAccessSelect" class="alarmSelect" onchange="ContactSet();alarmAccessFormSubmit();">
			<option value="0">网络关联</option>
            <option value="1">本地关联</option>
		</select>
	</div>
	
	<div class="alarmUnitDiv" id="pirDIV">
			<input type="hidden" name="pirMD1_" id="pirMD1_" value="<%alarmparaGet("pirMD1","net");%>" />
			<input type="hidden" name="pirMD2_" id="pirMD2_" value="<%alarmparaGet("pirMD2","net");%>" />
			<input type="hidden" name="pirMD3_" id="pirMD3_" value="<%alarmparaGet("pirMD3","net");%>" />
			<input type="hidden" name="pirMD4_" id="pirMD4_" value="<%alarmparaGet("pirMD4","net");%>" />
		<div>
			<label id="pirLable">PIR关联移动侦测区域</label>
		</div>
		<div>
			1<input type="checkbox" name="pirMD1" id="pirMD1" value="0" onclick="alarmAccessFormSubmit();"/>
			2<input type="checkbox" name="pirMD2" id="pirMD2" value="0" onclick="alarmAccessFormSubmit();"/>
			3<input type="checkbox" name="pirMD3" id="pirMD3" value="0" onclick="alarmAccessFormSubmit();"/>
			4<input type="checkbox" name="pirMD4" id="pirMD4" value="0" onclick="alarmAccessFormSubmit();"/>
		</div>
	</div>
	</form>

	
	<form name="AlarmIPForm" id="AlarmIPForm" method="post" target="hideFrame" action="/form/netparaCfg">
	<div class="alarmUnitDiv">
		<div>
			<label>报警服务器1&nbsp;IP:</label>
			<input name="flag" type="hidden" value="4" />
		</div>
		<input name="AlarmServerIP1" id="AlarmServerIP1" type="text"  class="alarmText1" value='<%NetparaGet("AlarmServerIP1","net");%>'  onChange="ipcheck(this)"/>
	</div>
	
	<div class="alarmUnitDiv">
		<div>
			<label>报警服务器2&nbsp;IP:</label>
		</div>
		<input name="AlarmServerIP2" id="AlarmServerIP2" type="text" class="alarmText1" value='<%NetparaGet("AlarmServerIP2","net");%>' onChange="ipcheck(this)"/>	
	</div>
	
		<div class="alarmUnitDiv">
		<div>
			<label>报警服务器3&nbsp;IP:</label>
		</div>
		<input name="AlarmServerIP3" id="AlarmServerIP3" type="text" class="alarmText1" value='<%NetparaGet("AlarmServerIP3","net");%>'  onChange="ipcheck(this)"/>
	</div>
	<input type="button" class="ButtonSet" value=" 保存 " onclick="alarmParaSetSubmit();"/>
	</form>
  </div>
</div>

<div class="alarmName"><label>报警关联</label></div>
<form name="AlarmForm" target="hideFrame" method="post" action="/form/alarmparaCfg">
<div class="alarmContent" style="height:300px">
<div class="alarmDiv">
<table id="AlarmOutTable" align="center" cellpadding="0" cellspacing="0" class="alarmTable" style="visibility:hidden">		  
		  <input type="hidden" name="flag" value="2" />
		  <input type="hidden" id="SDModeGetAlarm" value="<%SDGet("DevStatus","net");%>"/>
          <input type="hidden" id="SDAlarmGet" value="1"/><!--<\%SDGet("SDAlarm","net");%>-->
		  <input type="hidden" id="UsdUsb" value='<%SDGet("USB","net");%>' />
		   <tr id="outTr">
			<td width="104">&nbsp;</td>
			<td width="73">&nbsp;I/O&nbsp;输出1</td>
			<td width="72">I/O输出2</td>
			<td width="67">邮件</td>
			<td width="75" id="jsSDalarm">SD卡存储</td>
			<td width="69">FTP</td>
			<td width="69">TCP</td>
			<td width="72">音频</td>
			<td width="70">全选</td>
		   </tr>	  
		  
		  <tr id="trIn1">
			<td>&nbsp;I/O&nbsp;输入1<%alarmparaGet("Access1","net");%></td>
			<td><input type="checkbox" id="cbIn1Out1" value="0"/></td>
			<td><input type="checkbox" id="cbIn1Out2"  value="0"/></td>
			<td><input type="checkbox" id="cbIn1Mail"  value="0"/></td>
			<td><input type="checkbox" id="cbIn1Save"  value="0"/></td>
			<td><input type="checkbox" id="cbIn1FTP"  value="0"/></td>
			<td><input type="checkbox" id="cbIn1TCP"  value="0"/></td>
			<td><input type="checkbox" id="cbIn1Audio"  value="0"/></td>
			<td><input type="checkbox" id="cbIn1" class="checkall" value="0" /></td>
		  </tr>
		 
		  <tr id="trIn2">
			<td>&nbsp;I/O&nbsp;输入2<%alarmparaGet("Access2","net");%></td>
			<td><input type="checkbox" id="cbIn2Out1"  value="0"/></td>
			<td><input type="checkbox" id="cbIn2Out2" value="0"/></td>
			<td><input type="checkbox" id="cbIn2Mail"  value="0"/></td>
			<td><input type="checkbox" id="cbIn2Save"  value="0"/></td>
			<td><input type="checkbox" id="cbIn2FTP"  value="0"/></td>
			<td><input type="checkbox" id="cbIn2TCP"  value="0"/></td>
			<td><input type="checkbox" id="cbIn2Audio"  value="0"/></td>
			<td><input type="checkbox" id="cbIn2" value="0" class="checkall" /></td>
		  </tr>
		  
		  <tr>
			<td>&nbsp;移动区域<%alarmparaGet("mAccess1","net");%></td>
			<td><input type="checkbox" id="cbArea1Out1"  value="0"/></td>
			<td><input type="checkbox" id="cbArea1Out2"  value="0"/></td>
			<td><input type="checkbox" id="cbArea1Mail"  value="0"/></td>
			<td><input type="checkbox" id="cbArea1Save"  value="0"/></td>
			<td><input type="checkbox" id="cbArea1FTP"  value="0"/></td>
			<td><input type="checkbox" id="cbArea1TCP"  value="0"/></td>
			<td><input type="checkbox" id="cbArea1Audio"   value="0"/></td>
			<td><input type="checkbox" id="cbM1" value="0" class="checkall" /></td>
		  </tr>
		  
		  <tr style="display:none">
			<td>&nbsp;移动区域2<%alarmparaGet("mAccess2","net");%></td>
			<td><input type="checkbox" id="cbArea2Out1"  value="0"/></td>
			<td><input type="checkbox" id="cbArea2Out2"  value="0"/></td>
			<td><input type="checkbox" id="cbArea2Mail" value="0"/></td>
			<td><input type="checkbox" id="cbArea2Save" value="0"/></td>
			<td><input type="checkbox" id="cbArea2FTP"  value="0"/></td>
			<td><input type="checkbox" id="cbArea2TCP"  value="0"/></td>
			<td><input type="checkbox" id="cbArea2Audio"  value="0"/></td>
			<td><input type="checkbox" id="cbM2" value="0" class="checkall" /></td>
  		  </tr>
		  
		  <tr style="display:none">
			<td>&nbsp;移动区域3<%alarmparaGet("mAccess3","net");%></td>
			<td><input type="checkbox" id="cbArea3Out1" value="0"/></td>
			<td><input type="checkbox" id="cbArea3Out2"  value="0"/></td>
			<td><input type="checkbox" id="cbArea3Mail" value="0"/></td>
			<td><input type="checkbox" id="cbArea3Save" value="0"/></td>
			<td><input type="checkbox" id="cbArea3FTP" value="0"/></td>
			<td><input type="checkbox" id="cbArea3TCP" value="0"/></td>
			<td><input type="checkbox" id="cbArea3Audio"  value="0"/></td>
			<td><input type="checkbox" id="cbM3" value="0" class="checkall" /></td>
  		  </tr>		 
		 
		  <tr style="display:none">
			<td>&nbsp;移动区域4<%alarmparaGet("mAccess4","net");%></td>
			<td><input type="checkbox" id="cbArea4Out1"  value="0"/></td>
			<td><input type="checkbox" id="cbArea4Out2"  value="0"/></td>
			<td><input type="checkbox" id="cbArea4Mail"  value="0"/></td>
			<td><input type="checkbox" id="cbArea4Save"  value="0"/></td>
			<td><input type="checkbox" id="cbArea4FTP"  value="0"/></td>
			<td><input type="checkbox" id="cbArea4TCP"  value="0"/></td>
			<td><input type="checkbox" id="cbArea4Audio"   value="0"/></td>
			<td><input type="checkbox" id="cbM4" value="0" class="checkall" /></td>
  		  </tr>
          
		  <tr id="Intell">
			<td>&nbsp;智能入侵检测<%alarmparaGet("mAccess5","net");%></td>
			<td><input type="checkbox" id="cbArea5Out1"  value="0"/></td>
			<td><input type="checkbox" id="cbArea5Out2"  value="0"/></td>
			<td><input type="checkbox" id="cbArea5Mail"  value="0"/></td>
			<td><input type="checkbox" id="cbArea5Save"  value="0"/></td>
			<td><input type="checkbox" id="cbArea5FTP"  value="0"/></td>
			<td><input type="checkbox" id="cbArea5TCP"  value="0"/></td>
			<td><input type="checkbox" id="cbArea5Audio"   value="0"/></td>
			<td><input type="checkbox" id="cbM5" value="0" class="checkall" /></td>
  		  </tr>
          
          <tr id="SDOut">
			<td>&nbsp;SD卡拔出<%alarmparaGet("SDAccess","net");%></td>
			<td><input type="checkbox" id="cbSDOut1"  value="0"/></td>
			<td><input type="checkbox" id="cbSDOut2"  value="0"/></td>
			<td><input type="checkbox" id="cbSDMail"  value="0"/></td>
			<td><input type="checkbox" id="cbSDSave"  value="0" disabled="disabled" style="display:none"/>-</td>
			<td><input type="checkbox" id="cbSDFTP"  value="0"/></td>
			<td><input type="checkbox" id="cbSDTCP"  value="0"/></td>
			<td><input type="checkbox" id="cbSDAudio"   value="0"/></td>
			<td><input type="checkbox" id="cbSD" value="0" class="checkall" /></td>
  		  </tr>
          
          <tr id="netdown">
			<td>&nbsp;网络掉线<%alarmparaGet("NetlostAccess","net");%></td>
			<td><input type="checkbox" id="cbNetOut1"  value="0"/></td>
			<td><input type="checkbox" id="cbNetOut2"  value="0"/></td>
			<td><input type="checkbox" id="cbNetMail"  value="0" disabled="disabled" style="display:none"/>-</td>
			<td><input type="checkbox" id="cbNetSave"  value="0"/></td>
			<td><input type="checkbox" id="cbNetFTP"  value="0" disabled="disabled" style="display:none"/>-</td>
			<td><input type="checkbox" id="cbNetTCP"  value="0" disabled="disabled" style="display:none"/>-</td>
			<td><input type="checkbox" id="cbNetAudio"   value="0"/></td>
			<td><input type="checkbox" id="cbNet" value="0" class="checkall" /></td>
  		  </tr>
  </table>
  <input id="setAlarm" type="submit" class="ButtonSet" value=" 保存 "/>
  </div>

</div>
</form>


<div class="alarmName"><label>报警日程</label></div>
<form name="AlarmCalendarForm" id="AlarmCalendarForm" target="hideFrame" method="post" action="/form/alarmparaCfg">
<div class="alarmContent" style="height:270px; margin-bottom:15px;">
<div class="alarmDiv">
<table id="CalendarTable" align="center" cellpadding="0" cellspacing="0" class="alarmTable">
  	
	<input type="hidden" name="flag" value="3"/>
 	<tr>
		<td width="104"><%alarmparaGet("AlarmCalendarParm","net");%></td>
		<td width="258">开始</td>
		<td width="258">结束</td>
	</tr>
	
	<tr>
		<td><input name="cbCa0" type="hidden" id="cbCa0" value="" />
		 &nbsp;<input name="ccbCa0" type="checkbox" id="ccbCa0" onclick="checkCalender(0);" />星期日</td>
		<td><input name="start0H" id="start0H" type="text" class="alarmText2"  value=""/>&nbsp;:&nbsp;<input name="start0M" id="start0M" type="text" class="alarmText2" value=""/></td> 
		<td><input name="end0H" id="end0H" type="text" class="alarmText2" value=""/>&nbsp;:&nbsp;<input name="end0M" id="end0M" type="text" class="alarmText2" value=""/></td>
	</tr>

	<tr>
		<td><input name="cbCa1" id="cbCa1" type="hidden" value="" />
		&nbsp;<input name="ccbCa1" type="checkbox" id="ccbCa1" onclick="checkCalender(1);" />星期一</td>
		<td><input name="start1H" id="start1H" type="text" class="alarmText2" value=""/>&nbsp;:&nbsp;<input name="start1M" id="start1M" type="text" class="alarmText2" value=""/></td> 
		<td><input name="end1H" id="end1H" type="text" class="alarmText2" value=""/>&nbsp;:&nbsp;<input name="end1M" id="end1M" type="text" class="alarmText2" value="" /></td>
	</tr>
	
	<tr>
		<td><input name="cbCa2" type="hidden" id="cbCa2" value="" />
		&nbsp;<input name="ccbCa2" type="checkbox" id="ccbCa2" onclick="checkCalender(2);" />星期二</td>
		<td><input name="start2H" id="start2H" type="text" class="alarmText2" value=""/>&nbsp;:&nbsp;<input name="start2M" id="start2M" type="text" class="alarmText2" value=""/></td> 
		<td><input name="end2H" id="end2H" type="text" class="alarmText2" value=""/>&nbsp;:&nbsp;<input name="end2M" id="end2M" type="text" class="alarmText2" value=""/></td>
	</tr>
	
	<tr>
		<td><input name="cbCa3" type="hidden" id="cbCa3" value="" />
		&nbsp;<input name="ccbCa3" type="checkbox" id="ccbCa3"  onclick="checkCalender(3);" />星期三</td>
		<td><input name="start3H" id="start3H" type="text" class="alarmText2" value=""/>&nbsp;:&nbsp;<input name="start3M" id="start3M" type="text" class="alarmText2" value=""/></td> 
		<td><input name="end3H" id="end3H" type="text" class="alarmText2" value=""/>&nbsp;:&nbsp;<input name="end3M" id="end3M" type="text" class="alarmText2" value=""/></td>
	</tr>
	
	<tr>
		<td><input name="cbCa4" type="hidden" id="cbCa4" value="" />
		&nbsp;<input name="ccbCa4" type="checkbox" id="ccbCa4"  onclick="checkCalender(4);" />星期四</td>
		<td><input name="start4H" id="start4H" type="text" class="alarmText2" value=""/>&nbsp;:&nbsp;<input name="start4M" id="start4M" type="text" class="alarmText2" value=""/></td> 
		<td><input name="end4H" id="end4H" type="text" class="alarmText2" value=""/>&nbsp;:&nbsp;<input name="end4M" id="end4M" type="text" class="alarmText2" value=""/></td>
	</tr>
	
	<tr>
		<td><input name="cbCa5" type="hidden" id="cbCa5" value="" />
		&nbsp;<input name="ccbCa5" type="checkbox" id="ccbCa5"  onclick="checkCalender(5);" />星期五</td>
		<td><input name="start5H" id="start5H" type="text" class="alarmText2" value=""/>&nbsp;:&nbsp;<input name="start5M" id="start5M" type="text" class="alarmText2" value=""/></td> 
		<td><input name="end5H" id="end5H" type="text" class="alarmText2" value=""/>&nbsp;:&nbsp;<input name="end5M" id="end5M" type="text" class="alarmText2" value=""/></td>
	</tr>
	
	<tr>
		<td><input name="cbCa6" type="hidden" id="cbCa6" value="" />
		&nbsp;<input name="ccbCa6" type="checkbox" id="ccbCa6" onclick="checkCalender(6);" />星期六</td>
		<td><input name="start6H" id="start6H" type="text" class="alarmText2" value=""/>&nbsp;:&nbsp;<input name="start6M" id="start6M" type="text" class="alarmText2" value=""/></td> 
		<td><input name="end6H" id="end6H" type="text" class="alarmText2" value=""/>&nbsp;:&nbsp;<input name="end6M" id="end6M" type="text" class="alarmText2" value=""/></td>
	</tr>
	
	<tr>
		<td><input name="cbCa7" type="hidden" id="cbCa7" value="" />
		&nbsp;<input name="ccbCa7" type="checkbox" id="ccbCa7" onclick="checkCalender(7);checkEveryDay();" />每&nbsp; &nbsp;天</td>
		<td><input name="start7H" id="start7H" type="text" class="alarmText2" value=""/>&nbsp;:&nbsp;<input name="start7M" id="start7M" type="text" class="alarmText2" value=""/></td> 
		<td><input name="end7H" id="end7H" type="text" class="alarmText2" value=""/>&nbsp;:&nbsp;<input name="end7M" id="end7M" type="text" class="alarmText2" value=""/></td>
	</tr>
  </table>
  <input type="button" class="ButtonSet" value="保存" onclick="setAlarmCalendar();" />
  </div>
  
</div>
</form>

</body>
</html>


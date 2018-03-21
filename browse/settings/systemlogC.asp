<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>systemlog</title>
<script type="text/javascript" src="../javascript/jquery.js"></script>
<script language="javascript" src="../javascript/page.js"></script>
<link href="../css/part.css" rel="stylesheet" type="text/css">
<style type="text/css">

body,td,th {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size:14px;
}

a:link {
	color: #000000;
}
a:visited {
	color: #000000;
}
a:hover {
	color: #666666;
}
</style>

</head>
<body onload="logIndex();option();initDivlog();">
<iframe id="hideFrame" name="hideFrame" style="display: none;"></iframe>

<table width="950" border="0" cellpadding="0" cellspacing="0" class="table2" align="center">
  <tbody>
    <tr align="center">
      <td width="120" height="25" class="td2"><strong>日期</strong></td>
	  <td width="120" class="td2"><strong>时间</strong></td>
	  <td width="710" class="td2"><strong>日志信息</strong></td>
    </tr>
  </tbody>
</table>
<table width="950" border="0" align="center" cellpadding="0" cellspacing="0">
<tr id="noLogs" style="display:none;"><td align="center" height="25">暂无日志信息</td></tr>
  <tr>
	<td><%SysLogGetList();%></td>
  </tr>
</table>
  
<table width="950" border="0" align="center" cellpadding="0" cellspacing="0"> 
<form id="logForm" name="logForm" method="get" target="hideFrame" action="/form/delLogCfg">
<input type="hidden" name="language" value="cn"/>
<input type="hidden" name="delflag" value="0"/>
  <tr>
	<td height="20" colspan="9">&nbsp;</td>
  </tr>
  <tr id="trPage" style="display:none">
	<td width="143" height="20" align="right">&nbsp;</td>
	<td width="68" align="center" style="cursor:pointer"><img src="../images/back_01.gif" alt="首页" onclick="page('first')" /></td>
	<td width="60" align="center" style="cursor:pointer"><img src="../images/back_02.gif" alt="上一页" onclick="page('up')" /></td>
	<td width="147" align="center">第
		<label id="Page" style="color:red"></label>
		/
		<label id="AllPages"></label>
		页
	</td>
	<td width="64" align="center" style="cursor:pointer"><img src="../images/next_02.gif" alt="下一页" onclick="page('down')" /></td>
	<td width="47" align="center" style="cursor:pointer"><img src="../images/next_01.gif" alt="末页" onclick="page('last')" /></td>
	<td width="79" align="right">跳转&nbsp;</td>
	<td width="90"><font>
	  <select id="Num" style="width:45px;" onchange="pagegoto()">
	  </select></font></td>	 
	<td width="252"><div id="divlog" onclick="dellog();" style="cursor:pointer;">
	<table cellpadding="0" cellspacing="0"><tr><td width="20"><img src="../images/dellog.gif"/></td><td width="66">清空日志</td>
	</tr></table>
	</div></td>
  </tr>
 </form>
</table>
</body>
</html>

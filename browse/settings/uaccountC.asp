<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>用户管理</title>
<link href="../css/part.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../javascript/jquery.js"></script>
<script type="text/javascript" src="../javascript/user.js"></script>
</head>
<body>
<input type="hidden" id="PAGE_LANGUAGE" value="1" />
<form name="form1">

<table width="950" cellpadding="0" cellspacing="0" class="table2" align="center">

	<tr align="center">
		<td width="354" height="33" class="td2">用户名</td>
	  <td width="594" height="33" class="td2"><%NormalUserC("nomalName");%></td>
	</tr>
	
	<tr align="center">
		<td height="33" class="td2">权限</td>
		<td class="td2"><img src="../images/normal.gif" alt="普通用户"/></td>
	</tr>
	
	<tr align="center">
		<td height="33" class="td2">操作</td>
		<td class="td2"><a href= "#" onclick="linkURL();" ><img src="../images/edit.gif" alt="编辑"/></a></td>
	</tr>
</table>
</form>

</body>
</html>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>添加用户</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="../css/part.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../javascript/jquery.js"></script>
<script type="text/javascript" src="../javascript/user.js"></script>
</head>

<body onLoad="document.form1.name.focus();">
<input type="hidden" id="PAGE_LANGUAGE" value="0" />
<form name="form1" id="addUserForm" action="/form/AddUser">
	<div class="userDiv">
	  <div>
			<label class="userLab">User name:</label>
		    <input type="text" name="name" tabindex="1" class="userText" />
	  </div>
  	  <div>
			<label class="userLab">Password:</label>
			<input style="ime-mode:disabled" type="password" name="password1" tabindex="2" class="userText" />
  	  </div>
	  <div>
			<label class="userLab">Confirm password:</label>
		    <input style="ime-mode:disabled" type="password" name="password2" tabindex="3" class="userText" />
	  </div>
		<div>
			<input name="addSet" type="button" class="ButtonSet" style="margin-left:360px;" tabindex=5 onclick="addUserOk();" value="OK" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		  <input type="button" class="ButtonSet" tabindex="6" onClick="addUserCancel();" value="Cancel">
		</div>
	</div>
</form>
</body>
</html>
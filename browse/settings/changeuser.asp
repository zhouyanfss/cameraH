<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="../css/part.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../javascript/jquery.js"></script>
<script type="text/javascript" src="../javascript/user.js"></script>
</head>
<body onLoad="changeUserInit();document.form1.password.focus();">
<input type="hidden" id="PAGE_LANGUAGE" value="0" />
<form name="form1" action="/user/SaveUser">

<div class="userDiv">
	  <div>
			<label class="userLab">User name:</label>
			<input name="user" type="hidden" value="" />
		    <input type="text" name="name1" tabindex="1" class="userText" readonly="true" />
	  </div>
  	  <div>
			<label class="userLab">Old password:</label>
			<input style="ime-mode:disabled" type="password" name="password" id="password" tabindex="2" class="userText" />
  	  </div>
	  <div>
			<label class="userLab">New password:</label>
			<input style="ime-mode:disabled" type="password" name="password1" tabindex="3" class="userText" />
  	  </div>
	  <div>
			<label class="userLab">Confirm password:</label>
		    <input style="ime-mode:disabled" type="password" name="password2" tabindex="4" class="userText" />
	  </div>
	  <div>
	  <input name="changeSet" id="changeSet" style="margin-left:360px;" type="submit" class="ButtonSet" tabindex="6" onClick="changeUserOk();" value=" OK ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="submit" class="ButtonSet" tabindex="7" onClick="goBackURL();return false;" value=" Cancel ">
	  </div>
</div>
</form>
</body>
</html>
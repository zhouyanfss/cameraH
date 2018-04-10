<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--meta http-equiv="Content-Type" content="text/html; charset=utf-8" /-->
<meta http-equiv="X-UA-Compatible" content="IE=9; IE=8; IE=7; IE=EDGE">
<link href="css/logon.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="javascript/jquery.js"></script>  
<script type="text/JavaScript" src="javascript/cookie.js"></script>
<script type="text/JavaScript" src="javascript/common.js"></script>
<script type="text/JavaScript" src="javascript/index.js"></script>
<title>HD Camera</title>
<style type="text/css">
</style>
<script type="text/JavaScript">

</script>
</head>
<body>
<div id="lg_out">
  <div id="login">
    <div id="lg">
		<div class="logincon">
			<form name="loginForm" id="loginForm" target="hideFrame" method="post" action="/form/UserLogin">
			<ul>
			  <li class="titlelog" id="liUserName" >username</li>
			  <li class="tvalue"><input id="username" name="name" type="text" maxlength="32" onFocus="this.select();" onMouseOver="this.focus();" /></li>
			</ul>
			<ul>
			  <li class="titlelog" id="liPassword" ></li>
			  <li class="tvalue">
				  <input id="password" name="password" type="password" maxlength="32" onFocus="this.select();" onMouseOver="this.focus();" />
				  <!--input type="hidden" value="0" 	id="ftppassword"  	name="ftppassword" value ="YWRtaW4"/>
			  </li-->
			 
			</ul>
			</form>
			<!--<ul >
			  <li class="titlelog" id="lilanguage" style="display: none"></li>
			  <li class="tvalue mainpagelanguage">
			  		<select name="languagechoose" class="select" id="languagechoose" onChange="lanChange()" style="width:90px; min-width:80px;">
						<option id="lanen" value="0">英文</option>
						<option id="lanch" value="1">中文</option>
					</select>  
			  </li>
			</ul>
			<div class="lg_con_in">
			  <div class="lg_con_in_1"><a id="b_login" href="javascript:loginweb();"></a>
			  <a id="b_cancel_l"  href="javascript:window.close();"></a></div>
			</div-->
			<input type="hidden" id="rem_value" value="1" />
			<input type="hidden" id="HAS_IPC_AX" value='<%SystemInfoGet("has_IPC_AX", "net");%>' />
			<!--<div class="check">
			<div class="div_check" id="rem_check" onclick="rem_change();"></div>
			<label for="rem_check" id="check_label" style="margin-left:15px">记住密码</label>
			<a id="aOCX"style="margin-left:45px" onclick="activeX_down();">下载控件</a>
			</div>
			<div class="div_logon" id="div_logon" onclick="loginweb();">
				<label id="b_login"></label>
			</div>
			<div class="logon_close" onclick="javascript:window.close();"></div>	
			-->
			<div class="lg_con_in">
			  <div class="lg_con_in_1"><a id="b_login" href="javascript:;"  onclick="loginweb();">登录</a><a id="b_cancel_l" href="javascript:;"  onclick="javascript:window.close();">取消</a></div>
			</div>		
			<div id="liOCX" _t="123" onclick="activeX_down();"></div>					     
		</div> 
	</div>
  </div>
</div>
</body>
</html>


/*****************************************************************************************
 * add users check 
 *****************************************************************************************/
var LANGUAGE;
$(function(){LANGUAGE = $("#PAGE_LANGUAGE").val();prventFun();});

function chklenpw(string)
{
	//password length:5-20
	//var regExpInfo=/^([a-zA-Z0-9]|[._]){1,20}$/;	
	var regExpInfo=/^([a-zA-Z0-9]|[~`!@#$%^&*()-_=+\[\]{};:'",.<>?\/\\\|]){1,20}$/;	
	if(string.length == 0){
		return -1;
	}
	if(string.length<5 || string.length>20){
		return -3;
	}
	if(!regExpInfo.exec(string))
	{
		return -2;
	}
}
function chklenpw_new(string)
{
	//password length:8-20
	var regExpInfo=/^([a-zA-Z0-9]|[~`!@#$%^&*()-_=+\[\]{};:'",.<>?\/\\\|]){1,20}$/;	
	if(string.length == 0){
		return -1;
	}
	if(string.length<8 || string.length>20){
		return -3;
	}
	if(!regExpInfo.exec(string))
	{
		return -2;
	}
}
function chklenname(string)
{
	//name length:1-30
	var regExpInfo=/^([a-zA-Z0-9]|[._]){1,30}$/;	
	if(string.length == 0){
		return -1;
	}
	if(string.length<1 || string.length>30){
		return -3;
	}
	if(!regExpInfo.exec(string))
	{
		return -2;
	}
}

function readcookie(cookiestring) 
{ 
	var mycookie = document.cookie;
	pos = mycookie.indexOf(cookiestring,0);
	if(pos==-1)
		return false;
	else 
		return true;
}

function isSU()
{
	if(readcookie("SU")) return 1;
	else if(readcookie("NU")) return 2;
	else return 0;
}


function GetUser(cookStr){
	var loginUser = "";
	var mycookie = document.cookie;
	tmp = mycookie.split(";");
	for(i=0;i<tmp.length;i++){
		if((tmp[i].indexOf(cookStr,0)) != -1){
			names = tmp[i].split("=");
			loginUser = names[1];
			break;
		}
	}
	return loginUser;
}

function prventFun()
{
	var prevent = function(){return false;};
	document.documentElement.oncontextmenu = prevent;
	document.body.ondragstart = prevent;
	document.body.onselectstart = prevent;
}

//**********function in changeuser*************************

function fcheckpass()
{
	var result1 = chklenpw(document.form1.password.value);
	var result2 = chklenpw_new(document.form1.password1.value);
	var result3 = chklenpw_new(document.form1.password2.value);
	if(result1 == -2){
		alert(["Old password contains special character(s)!","旧密码包含特殊字符."][LANGUAGE]);
		document.form1.password.value = "";
		document.form1.password.focus();
		return false;
	}
	if(result2 == -2){
		alert(["New password contains special character(s)!","新密码包含特殊字符!"][LANGUAGE]);
		document.form1.password1.value = "";
		document.form1.password2.value = "";
		document.form1.password1.focus();
		return false;
	}
	if(result3 == -2){
		alert(["Confirmation password contains special character(s)!","确认密码包含特殊字符!"][LANGUAGE]);
		document.form1.password2.value = "";
		document.form1.password2.focus();
		return false;
	}
	if(result1 == -3){
		alert(["Old password length must be between 5 to 20 characters.","旧密码长度在5到20之间合法!"][LANGUAGE]);
		document.form1.password.value = "";
		document.form1.password.focus();
		return false;
	}
	if(result2 == -3){
		alert(["New password length must be between 8 to 20 characters.","新密码长度在8到20之间合法!"][LANGUAGE]);
		document.form1.password1.value = "";
		document.form1.password2.value = "";
		document.form1.password1.focus();
		return false;
	}
	if(result3 == -3){
		alert(["Confirmation password length must be between 8 to 20 characters.","确认密码长度在8到20之间合法!"][LANGUAGE]);
		document.form1.password2.value = "";
		document.form1.password2.focus();
		return false;
	}
	return true;
}
function changeUserOk()
{
	if(document.form1.password.value=="")
	{
		alert(["Old password cannot be empty.","旧密码不能为空."][LANGUAGE]);
		event.returnValue=false;
		return;
	}
	if(document.form1.password1.value=="")
	{
		alert(["New password cannot be empty.","新密码不能为空."][LANGUAGE]);
		event.returnValue=false;
		return;
	}
	if(!fcheckpass())
	{
		event.returnValue=false;
		return;
	}
	if(document.form1.password1.value != document.form1.password2.value)
	{
		alert(["Passwords do not match.","两次输入的密码不一致."][LANGUAGE]);
		event.returnValue=false;
		document.form1.password1.value="";
		document.form1.password2.value=""
		return;
	}
	document.form1.changeSet.disabled = true;	
	userAjaxPost(form1,function(text){
			var code = parseInt(text.match(/\d+/),10);

			if(code == 9)
			{
				alert(["Password was successfully updated.","密码修改成功."][LANGUAGE]);
				goBackURL();
				return;
			}
			else if(code == 3)
			{
				alert(["Old password is incorrect, please re-enter.","旧密码输入错误，请重新输入."][LANGUAGE]);
				$("#password").val("");
				$("#changeSet").attr("disabled",false);
				goBackURL2();
				return;
			}
		});
		
}

function goBackURL2()
{
	var u = isSU();
	if(LANGUAGE==1)
	{
		document.location = u == 1 ? "/browse/settings/changeuserC.asp?user="+GetUser("SU=") : "/browse/settings/changeuserC.asp?user=" + GetUser("NU=");	
	}
	else
		document.location = u == 1 ? "/browse/settings/changeuser.asp?user="+GetUser("SU=") : "/browse/settings/changeuser.asp?user=" + GetUser("NU=");
	
}

function goBackURL()
{
	var u = isSU();
	if(LANGUAGE==1)
	{
		document.location = u == 1 ? "/browse/settings/accountC.asp?user="+GetUser("SU=") : "/browse/settings/uaccountC.asp?user=" + GetUser("NU=");	
	}
	else
		document.location = u == 1 ? "/browse/settings/account.asp?user="+GetUser("SU=") : "/browse/settings/uaccount.asp?user=" + GetUser("NU=");
	
}


function userAjaxPost(formID,hander,waitSec){
	var formObj = "string"==(typeof formID)? $("#"+formID) : $(formID);
	var formPara = formObj.serialize();
	var hander = "function" == (typeof hander)?  hander: alertRes;
	var waitSec = "number" == (typeof waitSec)? waitSec: 10000;
	var time = new Date();
	$.ajax({type:'POST',url:formObj.attr("action")+"?_="+time.getTime(),data:formPara,dataType:"text",success:hander,timeout:waitSec});
}


function changeUserInit()
{
	var hrefstr,pos,curUser;		
	hrefstr=window.location.href;
	pos=hrefstr.indexOf("user=");
	if(pos == -1)
		return;
	else
	{
		curUser = hrefstr.slice(pos+5);
		document.form1.name1.value = document.form1.user.value = curUser;
	}

}


//**********function in account*************************
function deleteUser(arg)
{
	if((window.confirm(["Are you sure to delete this user?","确定删除此用户吗?"][LANGUAGE])))
	{
		document.form1.deluser.value=arg;
		//window.document.form1.submit();
		userAjaxPost(delUserForm,function(text){
			var code = parseInt(text.match(/\d+/),10);
			if(code == 8)
				alert(["Operation failed.","操作失败."][LANGUAGE]);
			else if(code == 0)
			{
				parent.mainFrame.document.location = LANGUAGE == 1 ? "accountC.asp?user="+GetUser("SU=") : "account.asp?user="+GetUser("SU=");
			}
		});
		return;
	}
	else
		event.returnValue=false;
}

//**********function in uaccount*************************
function linkURL()
{
	parent.mainFrame.document.location = LANGUAGE == 1 ? 'changeuserC.asp?user=' + GetUser("NU=") :'changeuser.asp?user=' + GetUser("NU=");
}

//**********function in adduser*************************
function checkname()
{
	var result = chklenname(document.form1.name.value);
	if(result == -1){
		alert(["Please enter username.","请输入用户名."][LANGUAGE]);
		window.form1.name.focus();
        return false;
	}
	if(result == -2){
		alert(["Username contains special character(s).","用户名包含特殊字符."][LANGUAGE]);
		document.form1.name.value = "";
		document.form1.name.focus();
        return false;
	}
	if(result == -3){
		alert(["Username length must be between 1 to 30 characters!","用户名长度在1到30之间合法!"][LANGUAGE]);
		document.form1.name.value = "";
		document.form1.name.focus();
        return false;
	}
    return true;
}
function checkpass(sign)
{
	var result ="";
	if(sign == 1)
		result = chklenpw_new(document.form1.password1.value);
	else if(sign == 2)
		result = chklenpw_new(document.form1.password2.value);
	if(result == -1){
		alert(["Please enter password.","请输入密码."][LANGUAGE]);
        return false;
	}
	if(result == -2){
		alert(["Password contains special character(s).","密码包含特殊字符."][LANGUAGE]);
		document.form1.password1.value = "";
		document.form1.password2.value = "";
        return false;
	}
	if(result == -3){
		alert(["Password length must be between 8 to 20 characters.","密码长度在8到20之间合法."][LANGUAGE]);
		document.form1.password1.value = "";
		document.form1.password2.value = "";
        return false;
	}
	return true;
}


function addUserOk()
{
	if(checkname()&& checkpass(1)&&checkpass(2))
	{
		if(document.form1.password1.value != document.form1.password2.value)
		{
			alert(["Passwords do not match.","两次输入的密码不一致."][LANGUAGE]);
			document.form1.password1.value="";
			document.form1.password2.value=""
			document.form1.password1.focus();
			return;
		}
		else
		{
			//document.form1.submit();	
			document.form1.addSet.disabled="disabled";
			userAjaxPost(addUserForm,function(text){
				var code = parseInt(text.match(/\d+/),10);
				if(code=="0")
					parent.mainFrame.document.location = LANGUAGE == 1 ?  "accountC.asp?user="+GetUser("SU="):"account.asp?user="+GetUser("SU=");
				else if(code==1)
				{
					alert(["Sorry, this username is taken.","对不起，此用户名已存在."][LANGUAGE]);
					document.form1.addSet.disabled = "";	
					return;
				}
				else if(code==2)
				{
					alert(["Number of users cannot exceed 7.","用户最多不能超过7个."][LANGUAGE]);
					document.form1.addSet.disabled = "";	
					return;
				}
				else if(code==3)
				{
					alert(["Operation failed.","操作失败."][LANGUAGE]);
					document.form1.addSet.disabled = "";	
					return;
				}						
			});
		}
	}
}

function addUserCancel()
{
	$(".userText").val("");
	parent.mainFrame.document.location = LANGUAGE == 1 ?"accountC.asp?user="+GetUser("SU="):"account.asp?user="+GetUser("SU=");
	return false;
}
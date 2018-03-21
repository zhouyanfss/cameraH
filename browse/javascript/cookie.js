// JavaScript Document

function MM_preloadImages() { //v3.0
 var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
   var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
   if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function addcookie(cookiestring)
{
	document.cookie = cookiestring + ";path=/";
}
function delcookie(cookiestring)
{
	var expireDate = new Date();
	expireDate.setTime(expireDate.getTime() - 1);
	document.cookie = cookiestring + "=0;expires=" + expireDate.toGMTString() + ";path=/";
}
function readcookie(cookiestring) 
{ 
	var mycookie = document.cookie;
	pos = mycookie.indexOf(cookiestring,0);
	if(pos==-1)
		return false;
	else return true;
} 
function getCookie(cookiestring)
{
	var res = "";
	var mycookie = document.cookie;
	tmp = mycookie.split(";");
	for(i=0;i<tmp.length;i++){
		if((tmp[i].indexOf(cookiestring,0)) != -1){
			array = tmp[i].split("=");
			res = array[1];
		}
	}
	return res;
}

function addplayercookie(cookieName,cookieVal)
{
	//document.cookie = "player=" + cookiename + "; path=/";
	document.cookie = cookieName + "=" + cookieVal + "; path=/";
}



/**************************EN*************************************/
function isSU()
{
	if(readcookie("SU")) return 1;
	else if(readcookie("NU")) return 2;
	else return 0;
}

var u = isSU();

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

function initSetBt()
{
	if(u == 2)
		disabledAll();
}

function disabledAll()
{
	var domInput = $("form input[type!='hidden']");
	var domSelect = $("form select");
	var domLabel = $("form label");
	var domCheck = $("form check");
	var tdText = $("td:parent");
	
	domInput.attr("disabled", true);
	domSelect.attr("disabled", true);
	domLabel.attr("disabled",true);
	domCheck.attr("disabled",true);
	tdText.attr("disabled",true);
	
}


function cameraSliderDisabled()
{
	if(u == 2)
	{
		for(var i = 1; i < 17; i++)
		{
			
			slidergray(i,0);
		}
	}
}



function checkID(id,idArray)
{
	var i,j = 0;
	var len = idArray.length;
	for(i = 0 ;i < len ; i++)
	{
		if(id == idArray[i])
			return true;
		else
			j++;	
	}
	if(j == len )
		return false;	
}

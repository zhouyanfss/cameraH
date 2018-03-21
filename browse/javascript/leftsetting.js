
function check_ICE()
{
	var devDiscription = getCookie("ICEtype");

	if(devDiscription != '' && devDiscription != '0')
		document.getElementById("li6").style.display = "block";
	else
		document.getElementById("li6").style.display = "block";
}


function LeftSetOnload()
{
	var id = getCookie("dev");
	
	check_ICE();
	onChange(1);
	var prevent = function(){return false;};
	document.body.oncontextmenu = prevent;
	document.body.ondragstart = prevent;
	document.body.onselectstart = prevent;
}

function onChange(i)
{
	$(".leftul li").css("background-image","");
	$("#li"+i).css("background-image","url(images/bar_1.gif)");
}

function loadRef(myURL)
{
	var dataObj = new Date();
	parent.mainFrame.document.location.replace("/browse/settings/"+myURL+"?_="+dataObj.getTime());
} 


/*Justin add start 2013.12.4*/
function loadPtzPageC()
{
	var devDiscription = getCookie("BSDdev");

	if(devDiscription=='1')
	{
		loadRef('ptzSetC_bsd.asp');
	}	
	else	
	{
		loadRef('ptzSetC.asp');
	}	
}

function loadPtzPageE()
{
	var devDiscription = getCookie("BSDdev");

	if(devDiscription=='1')
	{
		loadRef('ptzSet_bsd.asp');
	}	
	else	
	{
		loadRef('ptzSet.asp');
	}		
}
/*Justin add end 2013.12.4*/
function accountC(){
	var dataObj = new Date();
	if(u==2)
	{
	  	parent.mainFrame.document.location.replace("/browse/settings/uaccountC.asp?user="+GetUser("NU=")+"&_="+dataObj.getTime());
	}
	else
	{
		parent.mainFrame.document.location.replace("/browse/settings/accountC.asp?user="+GetUser("SU=")+"&_="+dataObj.getTime());
	}
}
function account(){
	var dataObj = new Date();
	if(u==2)
	{
		parent.mainFrame.document.location.replace("/browse/settings/uaccount.asp?user="+GetUser("NU=")+"&_="+dataObj.getTime());
	}
	else
	{
		parent.mainFrame.document.location.replace("/browse/settings/account.asp?user="+GetUser("SU=")+"&_="+dataObj.getTime());
	}
}

/*function loadCameraSet(language){
	var id = getCookie("dev");
	var url="cameraSet" + language;
	if(checkID(id,["129","130","127","128","121","122"])){
		url += "_af";
	}
	url += ".asp";
	loadRef(url);
}*/


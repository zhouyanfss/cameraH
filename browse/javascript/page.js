// JavaScript Document
var Language = top.topFrame.document.getElementById("lanSelect").selectedIndex;

function logIndex()
{
	var allpage=parseInt(document.getElementById("allpage").value);
	var TmpLogNum = parseInt(document.getElementById("TmpLogNum").value);
	//document.getElementById("Page").innerText=document.getElementById("pagenum").value;
	//document.getElementById("AllPages").innerText=document.getElementById("allpage").value;
	$("#Page").text($("#pagenum").val());
	$("#AllPages").text($("#allpage").val());
	if(document.getElementById("TmpLogNum").value != 0)
	{
		document.getElementById("log1").style.display="";
		for(i=2;i<=allpage;i++){
		document.getElementById("log"+i).style.display="none";
		} 
		document.getElementById("trPage").style.display="";
		document.getElementById("noLogs").style.display="none";
	}
	else{
		//document.getElementById("trPage").style.display="none";
		document.getElementById("noLogs").style.display="";
		return;
	}
}
function pagegoto(){
	var num=parseInt(document.getElementById("Num").value);
	var allpage=parseInt(document.getElementById("allpage").value);
	for(i=1;i<=allpage;i++){
		if(num==i)
		document.getElementById("log"+i).style.display="";
		else
		document.getElementById("log"+i).style.display="none";
		}
		document.getElementById("Page").innerText=num;
}
function page(obj){
//var num=parseInt(document.getElementById("Page").innerText);
var num = parseInt($("#Page").text());
var allpage=parseInt(document.getElementById("allpage").value);
var up;
    if(obj=='first'){
	up=1;}
	if(obj=='last'){
	up=allpage;}
	if(obj=='up')
	{	
		up=num-1;
		if(up<=0)
		return;
	}
	if(obj=='down') {
		up=num+1;
		if(up>allpage)
		return;
	}

	for(i=1;i<=allpage;i++){
	document.getElementById("log"+i).style.display="none";
	}
	document.getElementById("log"+up).style.display="";
	//document.getElementById("Page").innerText=up;
	$("#Page").text(up.toString());
	document.logForm.Num.selectedIndex=up-1;
}

function option(){
	var allpage=parseInt(document.getElementById("allpage").value);
	for(i=1;i<=allpage;i++)
	{ 
		document.getElementById("Num").options.add(new Option(i,i)); 
	}
} 

/***********************delete log*****************************/
function DeleteLog()
{
	SendHttp("/form/getDelLogInfo",false,Senddellog);
}
function Senddellog()
{
	if(xmlhttp.readyState==4){
		if(xmlhttp.status==200){
			try{
				var txt=xmlhttp.responseText;
				if(txt == "")return;
				if(txt.length == 0)return;
				if(txt.indexOf("OK getdelloginfo=")!=-1)
				{
					var txts=txt.split("=");
					if(txts.length!=2)
					{return;}
					var getdelloginfo=txts[1];
					if(getdelloginfo == 1)
					{
						var allpage=parseInt(document.getElementById("allpage").value);
						document.getElementById("log1").style.display="none";
						for(i=2;i<=allpage;i++){document.getElementById("log"+i).style.display="none";} 
						document.getElementById("trPage").style.display="none";
						document.getElementById("noLogs").style.display="";
					}
				}
			}catch(e){};
		}
	}
}



//***************************************将中英文日志页面的函数挪至这 2012.3.20 LJF**********************************************
function dellog()
{
	confirStr = ["Are you sure to delete system logs?","确定删除吗?"];
	if((window.confirm(confirStr[Language])))
	{
		document.logForm.delflag.value = 1;	
		//DeleteLog();
		document.logForm.submit();
		setTimeout("location.reload(true)",1000);	
		return;	
	}
	else
		event.returnValue=false;
}


//***************************************

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


function initDivlog()
{
	var prevent = function(){return false;};
	document.documentElement.oncontextmenu = prevent;
	document.body.ondragstart = prevent;
	document.body.onselectstart = prevent;
	if(isSU() == 2)
		document.getElementById('divlog').style.display = "none";
}


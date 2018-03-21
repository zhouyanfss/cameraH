var Language;
function alarmOnload()
{
	var prevent = function(){return false;};
	document.body.oncontextmenu = prevent;
	document.body.ondragstart = prevent;
	alarmHidden();
	AlarmIndex();
	initAlarmaccess();
	AlarmCalendarInit();
	
}

function initCheckAll()
{
	$("#AlarmOutTable tr:gt(0)").each(function(){
	 	var i,objHidden,objCheck;
		var parent = $(this);
		for(i = 0; i<6; i++)
		{
			 if(parent.find("input[type='hidden']:eq("+i+")").val()==1)
			 	parent.find(":checkbox:eq("+i+")").attr("checked",true);
		}
		
		var obj = parent.find("input[id^='cb'][class!='checkall']:checkbox:visible:enabled");
	    if(obj.filter(':checked').length == obj.length)
		{ 
			parent.find('.checkall').attr("checked",true);
		}
		else
		{ 
			parent.find('.checkall').attr("checked",false);
		}
	});
}

function initAlarmaccess()
{

 Language = $("#PAGE_LANGUAGE").val();
 var id = getCookie("dev");
 
	if($("#UsdUsb").val() == "1")
	{
		$("#jsSDalarm").html(Language=="1"?"U盘录像":"U-Disk");
	}

	//sd 卡模式为关闭时，SD卡存储灰掉
	
	if($("#SDModeGetAlarm").val()!="1" || $("#SDAlarmGet").val() != "1"){
		var tdDOM = $("#AlarmOutTable tr td:nth-child(5)");
		tdDOM.children(":checkbox").attr("disabled",true);
	}
	
	//if(id.match(/^[89]$/))//IO OUT1 头两个被选中后四个不选中并被灰掉
	if(checkID(id,["87"]))
	{
		//$("#AlarmOutTable tr td:nth-child(2)").children().attr("checked",false);
		$("input[id^='cbIn'][id*='Out1']").attr("checked",true);
		$("input[id^='cbArea'][id*='Out1']").attr("checked",false);
		
		$("#AlarmOutTable tr td:nth-child(2)").attr("disabled",true);
		//$("#AlarmOutTable tr td:nth-child(1)").children("input[type='hidden']:eq(0)").val(1);	
	}

	$("#AlarmOutTable tr:gt(0)").each(function(){
	 	var i,objHidden,objCheck;
		var parent = $(this);
		for(i = 0; i<6; i++)
		{
			 if(parent.find("input[type='hidden']:eq("+i+")").val()==1)
			 	parent.find(":checkbox:eq("+i+")").attr("checked",true);
		}
		
		var obj = parent.find("input[id^='cb'][class!='checkall']:checkbox:visible:enabled");
	    if(obj.filter(':checked').length == obj.length)
		{ 
			parent.find('.checkall').attr("checked",true);
		}
	});
	
 //checkall click
 $(".checkall").click(function(){
		//if(id.match(/^[89]$/))//全选时对OUT1不起作用
		var thisObj = $(this);
		if(checkID(id,["87"]))
		{
			thisObj.parent().parent().children("td:gt(1)").children().attr('checked',thisObj.is(':checked')); 
		}
		else{
			var checkboxDOM = thisObj.parent().prevAll().children(":checkbox").filter(":visible");
			checkboxDOM.filter(":enabled").attr('checked',thisObj.is(':checked')); 
			checkboxDOM.filter(":disabled").attr('checked',false);
		}
	 });
 // every checkbox unchecked lead to checkall unchecked
 $("#AlarmOutTable :checkbox[id^='cb'][class!='checkall']").click(function(){
	 if(!this.checked)
	 	$(this).parent().parent().find('.checkall').attr('checked',false);
  });
 
 $("#setAlarm").click(function(){
	 $("#AlarmOutTable :checkbox[id^='cb'][class!='checkall']").each(function(){
		 var thisDOM = $(this);
		(thisDOM.is(":checked") && (!thisDOM.attr("disabled")))? thisDOM.parent().parent().find("input[type='hidden']:eq("+(thisDOM.parent().index()-1)+")").val(1):thisDOM.parent().parent().find("input[type='hidden']:eq("+(thisDOM.parent().index()-1)+")").val(0);		 
		});
		setTimeout(function(){alert(["Alarm setting succeeded","报警关联设置成功."][Language]);},0);
	 });

}


function netLocalCheck(flag)//IO out1 ,IO out2 and select all colouns disabled or not , true:net false:local  
{
	$("input[id^='cbIn'][id*='Out']").attr({"disabled":flag,"checked":false});
	$("input[id^='cbArea'][id*='Out']").attr({"disabled":flag,"checked":false});
	$("input[id^='cbSD'][id*='Out']").attr({"disabled":flag,"checked":false});
	$("input[id^='cbNet'][id*='Out']").attr({"disabled":flag,"checked":false});
	if(!flag){
		$(".checkall:checked:visible").attr("checked",false);
	}
}

function AlarmIndex()
{
	/*
	var id = getCookie("dev");
	//if(id.match(/^[89]$/))
	if(checkID(id,["87"]))
	{
		$("#Alarmin1Select option[value='0']").remove();
		$("#Alarmin2Select option[value='0']").remove();
	}
	else
	{
		$("#Alarmin1Select").val($("#alarmin1").val());
		$("#Alarmin2Select").val($("#alarmin2").val());
	}
	*/
	$("#Alarmin1Select").val($("#alarmin1").val());
	$("#Alarmin2Select").val($("#alarmin2").val());
	if($("#alarminnum").val() < 2)
		$("#alarmIn2").hide();
	if($("#alarminnum").val() < 1)
		$("#alarmIn1").hide();
	$("#AlarmAccessSelect").val($("#alarmAccess").val());
	$("#alarmAccess").val() == "0" ? netLocalCheck(true) : netLocalCheck(false);
	for(var i = 1;i<5;i++)
	{
		$("#pirMD"+i.toString()).attr("checked",$("#pirMD"+i.toString()+"_").val() == 1?true:false);
	}

	if($("#CARD_TYPE").val() != "11")
		$("#pirDIV").hide();
	else
		$("#alarmIn2").hide();
}



function ContactSet()
{
	$("#AlarmAccessSelect").val() == "0" ? netLocalCheck(true) : netLocalCheck(false);
}


function alarmHidden()
{
	var tdDOM = $("#outTr>td");
	var outTrTd = tdDOM.length-1;
	
	/*
	$("#AlarmOutTable tr td:nth-child(5)").hide();//hidden SD
	outTrTd--;
	*/
	$("#AlarmOutTable tr td:nth-child(8)").hide();//hidden audio
	outTrTd--;
	if($("#alarmoutnum").val() < 2)
	{
		$("#AlarmOutTable tr td:nth-child(3)").hide();//hidden Out2
		outTrTd--;
	}
	if($("#alarmoutnum").val() < 1)
	{
		$("#AlarmOutTable tr td:nth-child(2)").hide();//hidden Out1
		outTrTd--;
	}
	//$("#trIn1,#trIn2,#SDOut,#netdown").hide();//hidden In1 In2 sdOut
	$("#SDOut,#netdown").hide();//hidden sdOut netout
	if($("#alarminnum").val() < 2)
		$("#trIn2").hide();
	if($("#alarminnum").val() < 1)
		$("#trIn1").hide();

	var ICEtype = parseInt($("#ICEtype").val());
	if(ICEtype != 3 && ICEtype != 4)
		$("#Intell").hide();


	var width = parseInt((480-tdDOM.eq(0).width())/outTrTd);
	for(var i = 1; i < tdDOM.length; i++){
		tdDOM.eq(i).width(width);	
	}
	$("#AlarmOutTable").css("visibility","visible");
	$("table tr td:nth-child(1)").css("text-align","left");
	
}


//*******************add by ljf 2011.11.30 alarm calendar**************************
function checkCalender(k)
{
	var inputArray=["start"+k+"H","start"+k+"M","end"+ k + "H","end"+ k + "M"];
	if(document.getElementById("ccbCa"+k).checked == true)
	{

//		document.getElementById("start"+k+"H").readOnly = false;
//		document.getElementById("start"+k+"M").readOnly = false;
//		document.getElementById("end"+ k + "H").readOnly = false;
//		document.getElementById("end"+ k + "M").readOnly = false;

		document.getElementById("cbCa"+k).value = 1;
		for(var i = 0; i < inputArray.length; i++){
			$("#"+inputArray[i]).attr("readonly",false).css("cursor","auto").unbind("focus");
		}
	}
	else
	{
//		document.getElementById("start"+k+"H").readOnly = true;
//		document.getElementById("start"+k+"M").readOnly = true;
//		document.getElementById("end"+ k + "H").readOnly = true;
//		document.getElementById("end"+ k + "M").readOnly = true;
		document.getElementById("cbCa"+k).value = 0;
		for(var i = 0; i < inputArray.length; i++){
			$("#"+inputArray[i]).attr("readonly",true).css("cursor","default").bind("focus",function(){$(this).blur()});
		}
	}
	
}

function checkEveryDay()
{
	if(document.getElementById("ccbCa7").checked == true)
	{
		for(var k = 0;k<7;k++)
		{	
			var inputArray=["start"+k+"H","start"+k+"M","end"+ k + "H","end"+ k + "M"];
			for(var i = 0; i < inputArray.length; i++){
				$("#"+inputArray[i]).attr("readonly",true).css("cursor","default").bind("focus",function(){$(this).blur()});
			}
			document.getElementById("ccbCa"+k).disabled = true;
//			document.getElementById("start"+k+"H").readOnly = true;
//			document.getElementById("start"+k+"M").readOnly = true;
//			document.getElementById("end"+ k + "H").readOnly = true;
//			document.getElementById("end"+ k + "M").readOnly = true;
			
		}
		document.getElementById("cbCa"+7).value = 1;
	}
	else
	{
		for(var k = 0;k<7;k++)
		{	
			var inputArray=["start"+k+"H","start"+k+"M","end"+ k + "H","end"+ k + "M"];
			document.getElementById("ccbCa"+k).disabled = false;
			if(document.getElementById("ccbCa"+k).checked == true)
			{
				for(var i = 0; i < inputArray.length; i++){
					$("#"+inputArray[i]).attr("readonly",false).css("cursor","auto").unbind("focus");
				}
//				document.getElementById("start"+k+"H").readOnly = false;
//				document.getElementById("start"+k+"M").readOnly = false;
//				document.getElementById("end"+ k + "H").readOnly = false;
//				document.getElementById("end"+ k + "M").readOnly = false;
			}
			else
			{
				for(var i = 0; i < inputArray.length; i++){
					$("#"+inputArray[i]).attr("readonly",true).css("cursor","default").bind("focus",function(){$(this).blur()});
				}
//				document.getElementById("start"+k+"H").readOnly = true;
//				document.getElementById("start"+k+"M").readOnly = true;
//				document.getElementById("end"+ k + "H").readOnly = true;
//				document.getElementById("end"+ k + "M").readOnly = true;
			}
		}
		document.getElementById("cbCa"+7).value = 0;
	}
}



function isNumber(s)
{  
    if(s != 0)
	{
		var regu = "^[1-9][0-9]*$"; 
	}
	else
	{
		var regu = "^[0]{1}$";
	}
	var re = new RegExp(regu); 
	if(s.search(re) != -1)
	{ 
		return true; 
	} 
	else 
	{ 
		return false; 
	}
}

function CheckCaH(strSource){ 

		var tmpstr, strCheckNum;
		var alertStr = [{"null":"The time value cannot be empty!",
					    "valideNum":"Input number is invalid,please enter valid number.",
						"smaller":"Hour must be no smaller than 0.",
						"bigger":"Hour must be no larger than 24.",
						"num":"Input number."
						},
						{"null":"请输入时间值,不能为空值.",
					    "valideNum":"输入有效数字.",
						"smaller":"小时时间值应大于或等于0.",
						"bigger":"小时时间值应小于或等于24.",
						"num":"输入数字."
						}
					   ];	
		tmpstr = strSource.replace(/(^[\s]*)|([\s]*$)|/g, "");
		strCheckNum = tmpstr + "";
		 if(strCheckNum.indexOf("0",0)==0&&(parseInt(strCheckNum.slice(1,strCheckNum.length))<=9)&&(parseInt(strCheckNum.slice(1,strCheckNum.length))>=0)){
			strCheckNum=strCheckNum.slice(1,strCheckNum.length);
			strSource=strCheckNum;
		    }
		if(strCheckNum.length < 1) {
			alert(alertStr[Language]['null']);
			return false;
			}
		
		else if(!isNumber(strCheckNum)){
			alert(alertStr[Language]['valideNum']);
			return false;
			}
		else if(parseInt(strCheckNum) < 0)	{
			alert(alertStr[Language]['smaller']);
			return false;
			}
		else if(parseInt(strCheckNum) >24)	{
			alert(alertStr[Language]['bigger']);
			return false;
			}
		else  if(parseFloat(strCheckNum) > parseInt(strCheckNum)){
			alert(alertStr[Language]['num']);
			return false;
			}
		else
		return true;	
}
function CheckCaM(strSource){ 

		var tmpstr, strCheckNum;
		var alertStr = [
						{"null":"The time value cannot be empty.",
						"valideNum":"Input number is invalid,please enter valid number.",
						"smaller":"Minute must be no smaller than 0.",
						"bigger":"Minute must be no larger than 24.",
						"num":"Input number."
						},
						{"null":"请输入时间值,不能为空值.",
						"valideNum":"输入有效数字.",
						"smaller":"分钟时间值应大于或等于0.",
						"bigger":"分钟时间值应小于60.",
						"num":"输入数字."
						}
					   ];	
		tmpstr = strSource.replace(/(^[\s]*)|([\s]*$)/g, "");
		strCheckNum = tmpstr + "";
		if((strCheckNum.indexOf("0",0)==0)&&(parseInt(strCheckNum.slice(1,strCheckNum.length))<=9)&&(parseInt(strCheckNum.slice(1,strCheckNum.length))>=0)){
			strCheckNum=strCheckNum.slice(1,strCheckNum.length);
			strSource=strCheckNum;
		    }
		if(strCheckNum.length < 1) {
			alert(alertStr[Language]['null']);
			return false;
			}
		else if(!isNumber(strCheckNum)){
			alert(alertStr[Language]['valideNum']);
			return false;
			}
		else if(parseInt(strCheckNum) < 0)	{
			alert(alertStr[Language]['smaller']);
			return false;
			}
		else if(parseInt(strCheckNum) >=60)	{
			alert(alertStr[Language]['bigger']);
			return false;
			}
		else  if(parseFloat(strCheckNum) > parseInt(strCheckNum)){
			alert(alertStr[Language]['num']);
			return false;
			}
		else
			return true;	
}




function CheckCaStartTime(k)
{
	if(CheckCaH(document.getElementById("start"+k+"H").value)&&CheckCaM(document.getElementById("start"+k+"M").value))
	{
 			return true;
	}
	else 
	{
		document.getElementById("start"+k+"H").value = "";
		document.getElementById("start"+k+"M").value = "";
		return false;	
	}
	
}

function CheckCaEndTime(k)
{
	if(CheckCaH(document.getElementById("end"+k+"H").value)&&CheckCaM(document.getElementById("end"+k+"M").value))
	{
			return true;
	}
	else
	{
		document.getElementById("end"+k+"M").value = "";
		document.getElementById("end"+k+"H").value = "";
		return false;
	}
}



function CheckCaCompare(k)
{
	var str = ["The end time must bigger than start time,please input again.","启用项的结束时间要大于开始时间，请重新输."];
	if(CheckCaStartTime(k)&&CheckCaEndTime(k))
	{
		var strSourceHs,strSourceMs,tmpstrHs,tmpstrMs,strCheckNumHs,strCheckNumMs;	
		strSourceHs=document.getElementById("start"+k+"H").value;
		strSourceMs=document.getElementById("start"+k+"M").value;
		tmpstrHs = strSourceHs.replace(/(^[\s]*)|([\s]*$)/g, "");
		tmpstrMs = strSourceMs.replace(/(^[\s]*)|([\s]*$)/g, "");
		strCheckNumHs = tmpstrHs + "";
		strCheckNumMs = tmpstrMs + "";
		var strSourceHe,strSourceMe,tmpstrHe,tmpstrMe,strCheckNumHe,strCheckNumMe;	
		strSourceHe=document.getElementById("end"+k+"H").value;
		strSourceMe=document.getElementById("end"+k+"M").value;
		tmpstrHe = strSourceHe.replace(/(^[\s]*)|([\s]*$)/g, "");
		tmpstrMe = strSourceMe.replace(/(^[\s]*)|([\s]*$)/g, "");
		strCheckNumHe = tmpstrHe + "";
		strCheckNumMe = tmpstrMe + "";
		if((strCheckNumHs.indexOf("0",0)==0)&&(parseInt(strCheckNumHs.slice(1,strCheckNumHs.length))<=9)&&(parseInt(strCheckNumHs.slice(1,strCheckNumHs.length))>=0)){
			strCheckNumHs=strCheckNumHs.slice(1,strCheckNumHs.length);
			
		    }
				if((strCheckNumMs.indexOf("0",0)==0)&&(parseInt(strCheckNumMs.slice(1,strCheckNumMs.length))<=9)&&(parseInt(strCheckNumMs.slice(1,strCheckNumMs.length))>=0)){
			strCheckNumMs=strCheckNumMs.slice(1,strCheckNumMs.length);
			
		    }
			if((strCheckNumHe.indexOf("0",0)==0)&&(parseInt(strCheckNumHe.slice(1,strCheckNumHe.length))<=9)&&(parseInt(strCheckNumHe.slice(1,strCheckNumHe.length))>=0)){
			strCheckNumHe=strCheckNumHe.slice(1,strCheckNumHe.length);
			
		    }
				if((strCheckNumMe.indexOf("0",0)==0)&&(parseInt(strCheckNumMe.slice(1,strCheckNumMe.length))<=9)&&(parseInt(strCheckNumMe.slice(1,strCheckNumMe.length))>=0)){
			strCheckNumMe=strCheckNumMe.slice(1,strCheckNumMe.length);
			
		    }
			//alert(strCheckNumHs);
		if(parseInt(strCheckNumHe) > parseInt(strCheckNumHs))
		{
			return true;
		}
		else if((parseInt(strCheckNumHe) == parseInt(strCheckNumHs))&&(parseInt(strCheckNumMe) > parseInt(strCheckNumMs)))
		{
			return true;	
		}
		else 
		{	
			alert(str[Language]);
			document.getElementById("end"+k+"H").value ="";
			document.getElementById("end"+k+"M").value="";
			return false;
		}

	}
	else
		return false;
}
function setAlarmCalendar()
{
	var alertStr = ["Alarm schedule setting succeeded.","报警日程设置成功."];
	var submitFlag = false;
	var i,j=0,m=0;
	if(document.getElementById("ccbCa7").checked)
	{
		if(CheckCaCompare(7))
		{
			document.getElementById('AlarmCalendarForm').submit();	
			alert(alertStr[Language]);
		}
	}
	else
	{
		for(i = 0; i < 7; i++)
		{
			if(document.getElementById("ccbCa"+i).checked)
			{
				j++;
				if(CheckCaCompare(i))
					m++;
				else
					return;
			}
		}
		if(j==m)
		{
			document.getElementById('AlarmCalendarForm').submit();	
			alert(alertStr[Language]);	
		}
	}
	
	for(var k=0;k<=7;k++)
	{
		var strSourceH,strSourceM,tmpstrH,tmpstrM,strCheckNumH,strCheckNumM;	
		strSourceH=document.getElementById("end"+k+"H").value;
		strSourceM=document.getElementById("end"+k+"M").value;
		tmpstrH = strSourceH.replace(/(^[\s]*)|([\s]*$)/g, "");
		tmpstrM = strSourceM.replace(/(^[\s]*)|([\s]*$)/g, "");
		strCheckNumH = tmpstrH + "";
		strCheckNumM = tmpstrM + "";
		
		if((strCheckNumH.indexOf("0",0)==0)&&(parseInt(strCheckNumH.slice(1,strCheckNumH.length))<=9)&&(parseInt(strCheckNumH.slice(1,strCheckNumH.length))>=0)){
			strCheckNumH=strCheckNumH.slice(1,strCheckNumH.length);
			
		    }
				if((strCheckNumM.indexOf("0",0)==0)&&(parseInt(strCheckNumM.slice(1,strCheckNumM.length))<=9)&&(parseInt(strCheckNumM.slice(1,strCheckNumM.length))>=0)){
			strCheckNumM=strCheckNumM.slice(1,strCheckNumM.length);
			
		    }
			if((parseInt(strCheckNumH)>=0)&&(parseInt(strCheckNumH)<=9)&&(strCheckNumH.length==1))strCheckNumH="0"+strCheckNumH;
			if((parseInt(strCheckNumM)>=0)&&(parseInt(strCheckNumM)<=9)&&(strCheckNumM.length==1))strCheckNumM="0"+strCheckNumM;
		document.getElementById("end"+k+"H").value=strCheckNumH;
		document.getElementById("end"+k+"M").value=strCheckNumM;
	}
	for(var k=0;k<=7;k++)
	{
		//var strSourceH,strSourceM,tmpstrH,tmpstrH,strCheckNumH,strCheckNumM;	
		strSourceH=document.getElementById("start"+k+"H").value;
		strSourceM=document.getElementById("start"+k+"M").value;
		tmpstrH = strSourceH.replace(/(^[\s]*)|([\s]*$)/g, "");
		tmpstrM = strSourceM.replace(/(^[\s]*)|([\s]*$)/g, "");
		strCheckNumH = tmpstrH + "";
		strCheckNumM = tmpstrM + "";
		
		if((strCheckNumH.indexOf("0",0)==0)&&(parseInt(strCheckNumH.slice(1,strCheckNumH.length))<=9)&&(parseInt(strCheckNumH.slice(1,strCheckNumH.length))>=0)){
			strCheckNumH=strCheckNumH.slice(1,strCheckNumH.length);
			
		    }
				if((strCheckNumM.indexOf("0",0)==0)&&(parseInt(strCheckNumM.slice(1,strCheckNumM.length))<=9)&&(parseInt(strCheckNumM.slice(1,strCheckNumM.length))>=0)){
			strCheckNumM=strCheckNumM.slice(1,strCheckNumM.length);
			
		    }
			if((parseInt(strCheckNumH)>=0)&&(parseInt(strCheckNumH)<=9)&&(strCheckNumH.length==1))strCheckNumH="0"+strCheckNumH;
			if((parseInt(strCheckNumM)>=0)&&(parseInt(strCheckNumM)<=9)&&(strCheckNumM.length==1))strCheckNumM="0"+strCheckNumM;
		document.getElementById("start"+k+"H").value=strCheckNumH;
		document.getElementById("start"+k+"M").value=strCheckNumM;
	}

}



function AlarmCalendarInit()
{

	for(var i = 0; i<8; i++)
	{
		if(document.getElementById("cbCa" + i+ "_").value == 1)
		{
			document.getElementById("ccbCa" + i).checked = true;
		}
		else
			document.getElementById("ccbCa" + i).checked = false;
		if((document.getElementById("start" + i + "H" + "_").value+"").length==1)
		document.getElementById("start" + i + "H").value = "0"+document.getElementById("start" + i + "H" + "_").value ;
		else
		document.getElementById("start" + i + "H").value = document.getElementById("start" + i + "H" + "_").value ;
		if((document.getElementById("start" + i + "M" + "_").value+"").length==1)
		document.getElementById("start" + i + "M").value = "0"+document.getElementById("start" + i + "M" + "_").value ;
		else
		document.getElementById("start" + i + "M").value = document.getElementById("start" + i + "M" + "_").value ;
		if((document.getElementById("end" + i + "H" + "_").value+"").length==1)
		document.getElementById("end" + i + "H").value = "0"+document.getElementById("end" + i + "H" + "_").value;
		else
		document.getElementById("end" + i + "H").value = document.getElementById("end" + i + "H" + "_").value;
		if((document.getElementById("end" + i + "M" + "_").value+"").length==1)
		document.getElementById("end" + i + "M").value = "0"+document.getElementById("end" + i + "M" + "_").value;
		else
		document.getElementById("end" + i + "M").value = document.getElementById("end" + i + "M" + "_").value;
		
		checkCalender(i);

	}
	
	checkEveryDay();
	
	$("#CalendarTable input[type='text']").attr("maxlength","2");
	$("#CalendarTable input[class='alarmText2'][id$='H']").bind("blur",function(){
			if($(this).val()=="24")
			{
				$(this).parent().children("input[class='alarmText2'][id$='M']").val("00").attr("readOnly",true);	
			}
			else
			{
				$(this).parent().children("input[class='alarmText2'][id$='M']").attr("readOnly",false);
			}
			
		});

}


//end of 2011.7.4
//*************end add Calendar************************************

//*************把ALARM.ASP中的函数挪到这里 2012.3.19************************************

function ipcheck(obj)
{
	var ipaddr = obj.value;
	var str = [{"null":"Input cannot be empty.",
			    "styleError":"Invalid input! IP address format is \'xxx.xxx.xxx.xxx\'.",
				"inputError":"IP address is invalid, please enter valid numbers.",
				"biger":"Invalid input! Each decimal number must be smaller than 255."
				},
				{"null":"输入不能为空.",
			    "styleError":"输入错误! IP地址格式为 'xxx.xxx.xxx.xxx'.",
				"inputError":"IP地址输入错误, 输入有效数字.",
				"biger":"输入错误!IP地址的任何部分不能大于255."		
				}];
	if(ipaddr == ""){
		alert(str[Language]['null']);
		return false;
	}		
	var values = ipaddr.split(".");
	if(values.length != 4){
		alert(str[Language]['styleError']);
		obj.value = "";
		return false;
	}
	for(i=0; i<values.length; i++){
		if(!isNumber(values[i])){
			alert(str[Language]['inputError']);
			obj.value = "";
			return false;
		}
		if(parseInt(values[i])<0 || parseInt(values[i])>255){
			alert(str[Language]['biger']);
			obj.value = "";
			return false;
		}
	}	
	return true;
}


function SetAlarmIP()
{	 
	var str = [{"fail":"Server IP cannot be empty.","success":"Alarm setting succeeded."},
			   {"fail":"服务器IP不能为空.","success":"报警配置设置成功."}];
	if(document.AlarmIPForm.AlarmServerIP1.value == "" || document.AlarmIPForm.AlarmServerIP2.value == ""||document.AlarmIPForm.AlarmServerIP2.value == "")
	{
		alert(str[Language]['fail']);
	}	 
	else 
	{	
		document.getElementById('AlarmIPForm').submit();
		alert(str[Language]['success']);		 
	}	  
}
function alarmAccessFormSubmit()
{
	for(var i = 1;i<5;i++)
	{
		$("#pirMD"+i.toString()).val($("#pirMD"+i.toString()).attr("checked") == "checked"?1:0);
	}
	document.getElementById('alarmAccessForm').submit();
}
function alarmParaSetSubmit()
{
	//alarmAccessFormSubmit();
	SetAlarmIP();
}


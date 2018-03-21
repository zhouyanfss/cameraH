var iframeFun = function(){};
var LANGUAGE = 0;//页面语言,0：英文；1：中文
var COLOR = "#CFDFEF";
/*********首栏切换******************/
function sysShow(className,num){
	var hankType = $("."+className);
	var liChoose = $("li[class^='choose']");

	hankType.css({"display":"none"});
	hankType.eq(num).css("display","block");
	liChoose.css({"border-bottom":"1px #F9F9F9 solid","background-color": ""});
	liChoose.eq(num).css({"border-bottom":"1px #BBB solid","background-color": COLOR});
}


/*******IP地址检测*******************/
function IPcheck(ip){
	var IPval = "";
	if(typeof ip != "string"){
		return 1;
	}else if(ip.match(/^\s*$/)){
		return "";
	}
	var ipArray = ip.split("\.");
	var allZero = true;
	var mistake = false;
	if(4 != ipArray.length){
		mistake = true;
	}else{
		var value;
		for( i=0; i<4; i++){
//			ipArray[i] = ipArray[i].replace(/\D/g,'');
			value = parseInt(ipArray[i],10);
			if(ipArray[i].match(/\D/g) || ''==ipArray[i] || 255<value){
				mistake = true;
				break;
			}else{
				 if(0!=value){
					allZero = false;
				 }
				 IPval += (value)+".";
			}
		}
	}
	if(mistake) return 1;
	else if(allZero) return 0;
	else return IPval.replace(/\.$/,'');
}

/*************************************************/
function getState(text){
	var state = text.toString().match(/\$STATE\$=\d+/i);
	state = null==state? false : parseInt(state[0].match(/\d+/),10);
	return state;
}

function alertRes(text){
	var StateArray = [{succeed: "Setting succeeded!\n", fail: "Setting failed!\n"},
										{succeed: "设置成功！", fail: "设置失败!"}];
		var state = getState(text);
		var alserString = '';
		if(state){
			alertString = StateArray[LANGUAGE].succeed;
		}else{
			alertString = StateArray[LANGUAGE].fail;
		}
		alert(alertString);
}

function alertError(){
	alert(["Request error, check network status.\n","请求出错, 请检查网络状态.\n"][LANGUAGE]);
}

function ajaxPost(formID, hander,errorFun,waitSec){
	var formObj = "string"==(typeof formID)? $("#"+formID) : $(formID);
	var formPara = formObj.serialize();
	var hander = "function" == (typeof hander)?  hander: alertRes;
	var errorFun = "function" == (typeof errorFun)?  errorFun: alertError;
	var waitSec = "number" == (typeof waitSec)? waitSec: 10000;
	var time = new Date();
	$.ajax({type:'POST',url:formObj.attr("action")+"?_="+time.getTime(),data:formPara,dataType:"text",success:hander,timeout:waitSec,error:errorFun});
}

function ajaxGet(formID, hander,errorFun,waitSec){
	var formObj = "string"==(typeof formID)? $("#"+formID) : $(formID);
	var formPara = formObj.serialize();
	var hander = "function" == (typeof hander)?  hander: alertRes;
	var errorFun = "function" == (typeof errorFun)?  errorFun: alertError;
	var waitSec = "number" == (typeof waitSec)? waitSec: 10000;
	var time = new Date();
	$.ajax({type:'GET',url:formObj.attr("action"),cache:false,data:formPara,dataType:"text",success:hander,timeout:waitSec,error:errorFun});
}

function getCookie(name){
	var cookieHank = document.cookie;
	var cookieName = encodeURIComponent(name) + "=";
	var cookieStart = cookieHank.indexOf(cookieName);
	var cookieValue = null;
	
	if(cookieStart > -1){
		var cookieEnd = cookieHank.indexOf(";", cookieStart);
		if(cookieEnd == -1){
			cookieEnd = cookieHank.length;
		}
		cookieValue = decodeURIComponent(cookieHank.substring(cookieStart + cookieName.length, cookieEnd));
	}
	return cookieValue;
}

function IsSuperUser(){
	if(getCookie("SU")){
		return true;
	}else{
		return false;
	}
}

function disabledAll(){
	var domInput = $("input[type!='hidden']");
	var domSelect = $("select");
	var radioLabel = domInput.filter("[type='radio']").next("label");
	var boxLabel = domInput.filter("[type='checkbox']").next("label");
	var expLabel = domInput.prev("label");
	var selLabel = domSelect.prev("label");
	var expRadio = radioLabel.parent().prev("label");
	domInput.attr("disabled", true);
	domSelect.attr("disabled", true);
	radioLabel.attr("disabled", true);
	boxLabel.attr("disabled", true);
	expLabel.attr("disabled", true);
	selLabel.attr("disabled", true);
	expRadio.attr("disabled", true);
	domInput.css("cursor", "default");
	domSelect.css("cursor", "default");
}

//获取字符所占的byte值
String.prototype.strlen = function(){
	var length = 0;
	var code = 0;
	var str = this;
	var codeLen = 0;
	for(var i = 0; i < str.length; i++){
		code = str.charCodeAt(i);
		if(0x80 > code){
			codeLen = 1;
		}else if(0x800 > code){
			codeLen = 2;
		}else if(0x10000 > code){
			codeLen = 3;
		}else{
			codeLen = 4;
		}
		length += codeLen;
	}
	return length;
}

function iframeLoad(){
	iframeFun();
	iframeFun = function(){};
}


function Dialog(){
	this.error=false;
	try{
		this.topDiv = $(top.frames[0].document.createElement("div"));
		this.leftDiv = $(top.frames[1].document.createElement("div"));
		var winHeight = parseInt($(top.frames[0].window).height());
		var docHeight = parseInt($(top.frames[0].document).height());
		var height = Math.max(winHeight,docHeight);
		this.topDiv.css({"width":"100%", "height":height+"px", "position":"absolute", "top":"0", "left":"0", "z-index":"99", "opacity":"0.5","background-color":"#999"});
		winHeight = parseInt($(top.frames[1].window).height());
		docHeight = parseInt($(top.frames[1].document).height());
		height = Math.max(winHeight,docHeight);
		var winWidth = parseInt($(top.frames[1].window).width());
		var docWidth = parseInt($(top.frames[1].document).width());
		var width = Math.max(winWidth,docWidth);
		this.leftDiv.css({"width":width+"px", "height":height+"px", "position":"absolute", "top":"0", "left":"0", "z-index":"99","opacity":"0.5","background-color":"#999"});
		
		this.selfDiv = $("<div style='width:100%; height:100%;position:absolute; top:0;left:0; z-index:99; background-color:#999;display:block;'>&nbsp;</div>");
		this.selfDiv.css("opacity",0.5);
		this.loadDiv = $("<div style='width:150px; height:50px;background-color:#fff;position:absolute;top:10px;z-index:100;'></div>");
		this.loadDiv.css("opacity",0.8);
		this.loadDiv.append($("<img src='../images/dialog_loading.gif' style='margin-top:10px;margin-left:60px;' />"));
		this.messDiv = $("<div style='width:250px; height:80px; position:absolute;top:10px;background-color:#fff;z-index:100;border:2px #999 solid;text-align:center;'></div>");
//	this.str1Lab = $("<label style='margin-top:30px;margin-left:60px;display:inline-block'></label>");
//	this.str2Lab = $("<label style='margin-top:30px;margin-left:5px;display:inline-block'>&nbsp;&nbsp;</label>");
		this.str3Lab = $("<label style='margin-top:30px;display:inline-block;'></label>");
	
//	this.messDiv.append(this.str1Lab);
//	this.messDiv.append(this.str2Lab);
		this.messDiv.append(this.str3Lab);
	}catch(e){error=true;};
}

Dialog.prototype = {
	resizeFlag: 0,
	show: function(sec,messF,messB, hander){
		var hander = "function" == (typeof hander)? hander: function(){};
		try{
			var winHeight = parseInt($(top.frames[1].window).height());
			var docHeight = parseInt($(top.frames[1].document).height());
			var height = Math.max(winHeight,docHeight);
			this.leftDiv.css("height", height+"px");
			var winWidth = parseInt($(top.frames[0].window).width());
			var docWidth = parseInt($(top.frames[0].document).width());
			var width =  Math.max(winWidth,docWidth);
			this.topDiv.css("width",width+"px");
			$(top.frames[0].document.body).append(this.topDiv);
			$(top.frames[1].document.body).append(this.leftDiv);
			$(top.frames[0].window.document.getElementsByTagName("html")).css("overflow","hidden");
			$(top.frames[1].window.document.getElementsByTagName("html")).css("overflow","hidden");
		}catch(e){};
		$("html").css("overflow","hidden");
		var winHeight = parseInt($(window).height());
		var docHeight = parseInt($(document).height());
		var height = Math.max(winHeight,docHeight);
		var winWidth = parseInt($(window).width());
		var docWidth = parseInt($(document).width());
		var width = Math.max(winWidth,docWidth);
		this.selfDiv.css({"height": height+"px","width": width+"px"});
		$(document.body).append(this.selfDiv);
		var condition = this;
		sec=parseInt(sec);
		var bindFun = function(){condition.winResize(condition)};
		$(window).bind("resize", bindFun );
		this.waitSec(sec, messF, messB, function(){
				hander();
				condition.selfDiv.remove();
				$(window).unbind("resize", bindFun);
				try{
					condition.topDiv.remove();
					condition.leftDiv.remove();
				}catch(e){};
		});
	},
	loading:function(bool){
		if(!bool){
			this.loadDiv.remove();
			this.selfDiv.remove();
			$("html").css("overflow",'');
			$(window).unbind("resize", bindFun);
			try{
				this.topDiv.remove();
				this.leftDiv.remove();
				$(top.frames[0].window.document.getElementsByTagName("html")).css("overflow",'');
				$(top.frames[1].window.document.getElementsByTagName("html")).css("overflow",'');
			}catch(e){};
		}else{
			document.body.scrollIntoView();
			try{
				var winHeight = parseInt($(top.frames[1].window).height());
				var docHeight = parseInt($(top.frames[1].document).height());
				var height = Math.max(winHeight,docHeight);
				this.leftDiv.css("height", height+"px");
				var winWidth = parseInt($(top.frames[0].window).width());
				var docWidth = parseInt($(top.frames[0].document).width());
				var width = Math.max(winWidth,docWidth);
				this.topDiv.css("width",width+"px");
				$(top.frames[0].document.body).append(this.topDiv);
				$(top.frames[1].document.body).append(this.leftDiv);
				$(top.frames[0].window.document.getElementsByTagName("html")).css("overflow","hidden");
				$(top.frames[1].window.document.getElementsByTagName("html")).css("overflow","hidden");
			}catch(e){};
			$("html").css("overflow","hidden");
			var winHeight = parseInt($(window).height());
			var docHeight = parseInt($(document).height());
			var height = Math.max(winHeight,docHeight);
			var winWidth = parseInt($(window).width());
			var docWidth = parseInt($(document).width());
			var width = Math.max(winWidth,docWidth);
			this.selfDiv.css({"height": height+"px","width": width+"px"});
			this.messDivPos();
			$(document.body).append(this.selfDiv);
			$(document.body).append(this.loadDiv);
			var condition = this;
			var bindFun = function(){condition.winResize(condition)};
			$(window).bind("resize", bindFun);
		}
	},
	
	winResize: function(condtion){
		if(condtion.resizeFlag){
			return;
		};
		condtion.resizeFlag = 1;
			try{
				setTimeout(function(){
					condtion.topDiv.css({"display":"none"});
					condtion.leftDiv.css({"display":"none"});
					var winHeight = parseInt($(top.frames[1].window).height());
					var docHeight = parseInt($(top.frames[1].document).height());
					var height = Math.max(winHeight,docHeight);
					condtion.leftDiv.css({"height": height+"px","display":"block"});
					var winWidth = parseInt($(top.frames[0].window).width());
					var docWidth = parseInt($(top.frames[0].document).width());
					var width = Math.max(winWidth,docWidth);
					condtion.topDiv.css({"width":width+"px","display":"block"});},0);
			}catch(e){};
			setTimeout(function(){
				condtion.selfDiv.css("display","none");
				var winHeight = parseInt($(window).height());
				var docHeight = parseInt($(document).height());
				var height = Math.max(winHeight,docHeight);
				var winWidth = parseInt($(window).width());
				var docWidth = parseInt($(document).width());
				var width = Math.max(winWidth,docWidth);
				condtion.selfDiv.css({"height": height+"px","width": width+"px","display":"block"});
				condtion.messDivPos();
				condtion.resizeFlag = 0;},1);
		},
	
	messDivPos: function(){
		var leftPos = parseInt(($(window).width().toString().replace(/\D+/g,'')-this.messDiv.css("width").toString().replace(/\D+/g,''))/2)-150;
		var topPos = parseInt(($(window).height().toString().replace(/\D+/g,'')-this.messDiv.css("height").toString().replace(/\D+/g,''))/2)-70;
		this.messDiv.css({"left":leftPos>0? leftPos+"px": 0,"top":topPos>0? topPos+"px":0});
		this.loadDiv.css({"left":leftPos>0? leftPos+"px": 0,"top":topPos>0? topPos+"px":0});
	},
	
	waitSec: function(sec, messF, messB, hander){
		this.messDivPos();
		var hander = "function"==(typeof hander)? hander: function(){};
//		this.str1Lab.text(messF);
		document.body.scrollIntoView();
		$(document.body).append(this.messDiv);
		var condition = this;
		var timeoutID;
		function begin(){
			if(sec){
				condition.str3Lab.text(messF+sec+messB);
				sec--;
			}else{
				clearInterval(timeoutID);
				condition.messDiv.remove();
				hander();
				$("html").css("overflow",'');
				try{
					$(top.frames[0].window.document.getElementsByTagName("html")).css("overflow",'');
					$(top.frames[1].window.document.getElementsByTagName("html")).css("overflow",'');
				}catch(e){};
			}
		};
		begin();
		timeoutID = setInterval(begin,1000);
	}
}

function responseGetVar(response,name){
	if(!response){
		return null;
	}
	var dataStr = response.toString();
	var reg = new RegExp("(\\s||\\b)"+name+"\\s*=.*(\\b||\\s)");
	var matchRes = dataStr.match(reg);
	if(matchRes){
		reg = new RegExp("(\\s||\\b)"+name+"\\s*=");
		return matchRes[0].replace(reg,'').toString();
	}else{
		return null;
	}
}

function valCheck(event){
	var point = parseInt(event.data.point);
	point = isNaN(point)? 0: point;
	var valMin = event.data.min;
	var valMax = event.data.max;
	var DOMobj = $(this);
	var val = DOMobj.val();
	val = val.replace(/[^0-9.-]/g,'');
	if(0 == point){
		val = parseInt(val,10);
	}else{
		val = parseFloat(val).toFixed(point);
	}
	val = isNaN(val)? valMin: val;
	val = val > valMax? valMax: val;
	val = val < valMin? valMin: val;
	DOMobj.val(val);
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

//mousewheel
(function(a){function d(b){var c=b||window.event,d=[].slice.call(arguments,1),e=0,f=!0,g=0,h=0;return b=a.event.fix(c),b.type="mousewheel",c.wheelDelta&&(e=c.wheelDelta/120),c.detail&&(e=-c.detail/3),h=e,c.axis!==undefined&&c.axis===c.HORIZONTAL_AXIS&&(h=0,g=-1*e),c.wheelDeltaY!==undefined&&(h=c.wheelDeltaY/120),c.wheelDeltaX!==undefined&&(g=-1*c.wheelDeltaX/120),d.unshift(b,e,g,h),(a.event.dispatch||a.event.handle).apply(this,d)}var b=["DOMMouseScroll","mousewheel"];if(a.event.fixHooks)for(var c=b.length;c;)a.event.fixHooks[b[--c]]=a.event.mouseHooks;a.event.special.mousewheel={setup:function(){if(this.addEventListener)for(var a=b.length;a;)this.addEventListener(b[--a],d,!1);else this.onmousewheel=d},teardown:function(){if(this.removeEventListener)for(var a=b.length;a;)this.removeEventListener(b[--a],d,!1);else this.onmousewheel=null}},a.fn.extend({mousewheel:function(a){return a?this.bind("mousewheel",a):this.trigger("mousewheel")},unmousewheel:function(a){return this.unbind("mousewheel",a)}})})(jQuery);
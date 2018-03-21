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

function Slider(){
	this.imgMinus = new Image();
	this.imgPlus = new Image();
	this.imgSlider = new Image();
}

Slider.prototype = {
	sliderArray : new Array(),
	target : null,
	timeout : null,
	dragID: 0,
	/************************/
	imgSet: function(obj){
		if(obj.imgMinus){
			this.imgMinus.src = obj.imgMinus;
			this.imgPlus.src = obj.imgPlus;
			this.imgSlider.src = obj.imgSlider;
		}else{
			this.imgMinus.src = arguments[0];
			this.imgPlus.src = arguments[1];
			this.imgSlider.src = arguments[2];
		}
	},
	/************************/
	value : function(divID,value){
		var value = parseInt(value);
		var length = this.sliderArray.length;
		var obj, temp;
		for(var i = 0; i < length; i++){
			temp = this.sliderArray[i];
			if(divID==temp.divID){obj=temp; break;}
		}
		if(obj){
			if(isNaN(value)){
				return obj.value;
			}
			value = value<obj.Nmin? obj.Nmin: value;
			value = value>obj.Nmax? obj.Nmax: value;
			obj.inputObj.val(value);
			obj.labelObj.text(value);
			obj.value = value;
			var pos = parseInt( (value-obj.Nmin)*obj.sliderRge/(obj.Nmax-obj.Nmin) );
			temp = obj.slider.style.display;
			obj.slider.style.display="inline";
			obj.slider.style.left= 18+pos+"px";
			obj.slider.style.display=temp;
			temp = obj.front.style.display;
			obj.front.style.display = "inline";
			obj.front.style.width = pos+obj.offset+"px";
			obj.front.style.display = temp;
		}
	},
	/************************/
	sliderMove: function(targetObj, ev){
			var offset = ev.pageX - targetObj.line.offset().left-targetObj.offset;
			var rgeMax = targetObj.sliderRge;
			offset = offset<0? 0: offset;
			offset = offset>rgeMax? rgeMax: offset;
			targetObj.slider.style.left= offset+18+"px";
			targetObj.front.style.width = offset+targetObj.offset+"px";
			var value = parseInt(offset*targetObj.step) + targetObj.Nmin;
			setTimeout(function(){targetObj.inputObj.val(value);},10);
			targetObj.labelObj.text(value);
			targetObj.value = value;
			return value;
		},
		
	creat: function(divID, inputID, labelID, Nmin, Nmax, hander){
		var targetDiv = $("#"+divID);
		if(!targetDiv.attr("id")){
			alert("Please check the target id!");
			return;
		}
		targetDiv.empty();
		var temp = this.sliderArray;
		for(var i=0, j=temp.length; i < j; i++){
			if(divID==temp[i].divID){
				temp.splice(i, 1);
				break;
			}
		}
		var imgMinus = $("<img style='width:18px;height:18px;position:absolute;left:0;cursor:pointer;' />");
		imgMinus.attr("src",this.imgMinus.src);
		var imgPlus = $("<img style='width:18px;height:18px;position:absolute;cursor:pointer;' />");
		imgPlus.attr("src",this.imgPlus.src);
		var imgClarity = $("<img style='height:4px;position:absolute;top:6px;left:18px;cursor:pointer;z-index:2' />");
		imgClarity.css("opacity",0);
		imgClarity.attr("src",this.imgSlider.src);
		var imgSlider = document.createElement("img");
		$.extend(imgSlider.style, {width:'9px', height:'13px',position:'absolute',top:'3px',left:'18px',cursor:'pointer',zIndex:'3'});
		imgSlider.src=this.imgSlider.src;
		
		var container = $('<div style="width:100%;overflow:hidden;height:19px;border:0;padding:0;position:relative"></div>');
		var background = $('<div style="height:3px;overflow:hidden;background-color:#DCDCDC;position:absolute;left:18px;top:6px;border-top:1px #9d9c99 solid;cursor:pointer;z-index:0"></div>');
		var front = document.createElement("div");
		$.extend(front.style, {width:0,height:'3px',overflow:'hidden',backgroundColor:'#696969',position:'absolute',left:'18px',top:'7px',cursor:'pointer',zIndex:1});
		
		var temp, centerWidth, sliderWidth;
		if( (temp=parseInt(targetDiv.width())) && temp > (imgMinus.width()+imgPlus.width()) ){
			/**/;
		}else{
			temp = 100 + imgMinus.width() + imgPlus.width();
			targetDiv.css("width", temp+"px");
		}
		imgPlus.css("left",temp - imgPlus.width() + "px");
		centerWidth = parseInt(temp) - 2*parseInt(imgPlus.css("width").replace(/\D/g,''));
		imgClarity.css("width", centerWidth+"px");
		background.css("width", centerWidth+"px");
		sliderWidth = imgSlider.style.width.replace(/\D/g,'');
		
		container.prepend(imgMinus);
		container.prepend(imgPlus);
		container.prepend(imgClarity);
		container.prepend(imgSlider);
		container.prepend(background);
		container.prepend(front);
		targetDiv.prepend(container);
		targetDiv.contextmenu(function(){return false});
		
		var inputObj = document.getElementById(inputID);
		inputObj = null==inputObj? $("<input />"): $(inputObj);
		var labelObj = document.getElementById(labelID);
		labelObj = null==labelObj? $("<label></label>"): $(labelObj);
		var Nmin = Nmin? Nmin: 0;
		var Nmax = Nmax? Nmax: 100;
		if(Nmin==Nmax){Nmax=Nmax+1};
		if(Nmin > Nmax){var temp=Nmin; Nmin=Nmax; Nmax=temp};
		
		var dragObj = {
			divID: divID,
			Nmin: Nmin,
			Nmax: Nmax,
			value: Nmin,
			inputObj: inputObj,
			labelObj: labelObj,
			background: background,
			front: front,
			minus: imgMinus,
			plus: imgPlus,
			line: imgClarity,
			slider: imgSlider,
			sliderRge: centerWidth - sliderWidth,
			step: ((Nmax - Nmin)/(centerWidth - sliderWidth)).toFixed(3),
			offset: parseInt(sliderWidth/2),
			hander: ( "function"==(typeof hander) )? hander: function(){},
			enable: true
			};
		temp = this.sliderArray.length;
		this.sliderArray[temp] = dragObj;
		temp = this.sliderArray[temp];
		var condition = this;
		$(temp.minus).mousedown(function(ev) {
			var value = temp.value;
            if( (!temp.enable)||(value<=temp.Nmin) ){
				return;
			}
			var timeout = 50;
			if( "object"==(typeof ev) ){ev.preventDefault(); timeout = 500;};
			condition.value(temp.divID, value-1);
			temp.hander(temp.value);
			condition.timeout = setTimeout(arguments.callee, timeout);
        	});
		$(temp.plus).mousedown(function(ev){
			var value = temp.value;
			if( (!temp.enable)||(value>=temp.Nmax) ){
				return;
			}
			var timeout = 50;
			if( "object"==(typeof ev) ){ev.preventDefault(); timeout = 500;};
            condition.value(temp.divID, value+1);
			temp.hander(temp.value);
			condition.timeout = setTimeout(arguments.callee, timeout);
        	});
		$(temp.minus).mousemove(function(ev){ev.preventDefault();});
		$(temp.plus).mousemove(function(ev){ev.preventDefault();});
		$(temp.line).mousemove(function(ev){ev.preventDefault();});
		$(temp.minus).mouseup(function(ev){clearTimeout(condition.timeout);});
		$(temp.plus).mouseup(function(ev){clearTimeout(condition.timeout);});
		$(temp.minus).mouseout(function(ev){clearTimeout(condition.timeout);});
		$(temp.plus).mouseout(function(ev){clearTimeout(condition.timeout);});
		
		$(temp.line).mousedown(function(ev){
			if(!temp.enable){return;};
			condition.target = temp;
			ev.preventDefault();
			condition.sliderMove(temp, ev);
			temp.hander(temp.value);
        	});
		$(temp.line).mouseup(function(ev){condition.target = null;});
		$(temp.line).mousemove(function(ev){
			if(condition.target != temp ){
				ev.preventDefault();
				return;
			}
			clearTimeout(condition.dragID);
			condition.dragID = setTimeout(function(){
				var valueLast = temp.value;
				if(valueLast != condition.sliderMove(temp, ev)){
					temp.hander(temp.value);
				};},0);
			return false;
		});
		$(temp.slider).mousedown(function(ev){
			if(!temp.enable){return;};
			condition.target = temp;
			ev.preventDefault();
			condition.sliderMove(temp, ev);
			temp.hander(temp.value);
        	});
		$(temp.slider).mouseup(function(ev){condition.target = null;});
		$(temp.slider).mousemove(function(ev){
			if( condition.target != temp ){
				ev.preventDefault();
				return;
			}
			clearTimeout(condition.dragID);
			condition.dragID = setTimeout(function(){
				var valueLast = temp.value;
				if(valueLast != condition.sliderMove(temp, ev)){
					temp.hander(temp.value);
				};},0);
			return false;
		});
		
		if(1 == condition.sliderArray.length){
			$(document).mousemove(function(ev){
				var dragObj = condition.target;
				if( !dragObj){
//					ev.preventDefault();
					return;
				}
				clearTimeout(condition.dragID);
				condition.dragID = setTimeout(function(){
					var valueLast = dragObj.value;
					if(valueLast != condition.sliderMove(dragObj, ev)){
					dragObj.hander(dragObj.value);
					};},0);
				return false;
			});
			$(document).mouseup(function(ev){
				condition.target = null;
				clearTimeout(condition.timeout);
			});
		}
	},
	/************************/
	state: function(divID, flag){
		var targetObj;
		var objArray = this.sliderArray;
		for(var i=0, j=objArray.length; i<j; i++){
			if(divID==objArray[i].divID){
				targetObj = objArray[i];
				break;
			}
		}
		if(targetObj){
			if("undefined" == (typeof flag)){
				return targetObj.enable;
			}else{
				var ObjCss;
				if(flag){
					ObjCss={cursor: "pointer", opacity: 1};
					targetObj.line.css("cursor", "pointer");
					targetObj.inputObj.attr("disabled", false);
					targetObj.labelObj.attr("disabled", false);
				}else{
					ObjCss={cursor: "default", opacity: 0.6};
					targetObj.line.css("cursor", "default");
					targetObj.inputObj.attr("disabled", true);
					targetObj.labelObj.attr("disabled", true);
				}
				targetObj.minus.css(ObjCss);
				targetObj.plus.css(ObjCss);
				$(targetObj.slider).css(ObjCss);
				targetObj.background.css(ObjCss);
				$(targetObj.front).css(ObjCss);
				targetObj.enable = Boolean(flag);
			}
		}
	}
};
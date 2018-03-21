
var form_widget_amount_slider_handle = '../images/slider_handle.gif';
var form_widget_amount_slider_minus_handle = '../images/minus.gif';
var form_widget_amount_slider_plus_handle = '../images/plus.gif';
var slider_handle_image_obj = false;
var sliderObjectArray = new Array();
var slider_counter = 0;
var slideInProgress = false;
var handle_start_x;
var event_start_x;
var currentSliderIndex;
var sliderHandleWidth = 9;
var minusHandleWidth = 18;
var start_value;
var currObj = null;	// 鼠标点击的对象
var timerObj = null;	// 定时器对象
var downflag = false;   //判断鼠标有没有被按下超过500ms 
var stop;               //setTimeout 500ms的ID


function form_widget_cancel_event()
{
	return false;		
}

function getImageSliderHeight()
{
	if(!slider_handle_image_obj)
	{
		slider_handle_image_obj = new Image();
		slider_handle_image_obj.src = form_widget_amount_slider_handle;
	}
	if(slider_handle_image_obj.width>0)
	{
		return;
	}
	else
	{
		setTimeout('getImageSliderHeight()', 50);
	}
}

function onValueChanged(theIndex)
{
	if(sliderObjectArray[theIndex]['onchangeAction'])
	{
		eval(sliderObjectArray[theIndex]['onchangeAction']);
	}
}

function positionSliderImage(theIndex)
{	
	var theValue = sliderObjectArray[theIndex]['formTarget'].value;
	if(sliderObjectArray[theIndex]['nextformTarget'])
	{
		var nexttheValue = sliderObjectArray[theIndex]['nextformTarget'].value;
	}
	
	if(!theValue.match(/^[0-9]*$/g))
	//if(!theValue.match(/^(^-?\d+$)$/g))
	{
	    theValue = sliderObjectArray[theIndex]['min'] + '';
	}
	
	if(theValue / 1 > sliderObjectArray[theIndex]['max'])
	{
	    theValue = sliderObjectArray[theIndex]['max'];
		if(sliderObjectArray[theIndex]['nextformTarget'])
		{
			nexttheValue = sliderObjectArray[theIndex]['correspondingArray'][theValue];
		}
	}
	
	if(theValue / 1 < sliderObjectArray[theIndex]['min'])
	{
	    theValue = sliderObjectArray[theIndex]['min'];
		if(sliderObjectArray[theIndex]['nextformTarget'])
		{
			nexttheValue = sliderObjectArray[theIndex]['correspondingArray'][theValue];
		}
	}
	
	sliderObjectArray[theIndex]['formTarget'].value = theValue;
	if(sliderObjectArray[theIndex]['nextformTarget'])
	{
		sliderObjectArray[theIndex]['nextformTarget'].value = nexttheValue;
	}
	
	var handleImg = document.getElementById('slider_handle' + theIndex);
	
	var ratio = sliderObjectArray[theIndex]['width'] / (sliderObjectArray[theIndex]['max'] - sliderObjectArray[theIndex]['min']);
	
	var currentValue = sliderObjectArray[theIndex]['formTarget'].value - sliderObjectArray[theIndex]['min'];	
		
	handleImg.style.left = Math.round(currentValue * ratio) + minusHandleWidth + 'px';
	
	$("#slider_slider_red" + theIndex).css("width",Math.round(currentValue * ratio));//初始化时滑块在中间时左侧为红
}

function onTextChanged()
{
    theIndex = this.getAttribute('sliderIndex');
    positionSliderImage(theIndex);
    onValueChanged(theIndex);
}

function onKeyDown()
{
	if (event.keyCode==13)
	{
		event.keyCode=9;
	}
}

///////////////////////////////////////////   
function onBlur()
{
	theIndex = this.getAttribute('sliderIndex');
	var num = sliderObjectArray[theIndex]['formTarget'].value;
	if(isDigit(num))
	{
		s = parseInt(num);
		if((s <sliderObjectArray[theIndex]['min']) || (s >sliderObjectArray[theIndex]['max']))
		{
			sliderObjectArray[theIndex]['formTarget'].value = sliderObjectArray[theIndex]['min'];
			return;	
		}	
	}
	else
	{
		sliderObjectArray[theIndex]['formTarget'].value = sliderObjectArray[theIndex]['min'];
		return;	
	}	
	
	
}
   
function isDigit(s)
{
	var patrn=/^[0-9]{1,20}$/;
	//var patrn=/^(^-?\d+$)$/;
	if (!patrn.exec(s)) return false
	return true
}

  
   
////////////////////////////////////////  

function adjustFormValue(theIndex)
{
	if(!sliderObjectArray[theIndex]['state']) return;
	var handleImg = document.getElementById('slider_handle' + theIndex);	
	var ratio = sliderObjectArray[theIndex]['width'] / (sliderObjectArray[theIndex]['max']-sliderObjectArray[theIndex]['min']);
	var currentPos = handleImg.style.left.replace('px','') - minusHandleWidth;
	sliderObjectArray[theIndex]['formTarget'].value = Math.round(currentPos / ratio) + sliderObjectArray[theIndex]['min'];
	if(sliderObjectArray[theIndex]['nextformTarget'])
	{
		sliderObjectArray[theIndex]['nextformTarget'].value =sliderObjectArray[theIndex]['correspondingArray'][sliderObjectArray[theIndex]['formTarget'].value];
		
	}
}

// 鼠标抬起或鼠标离开
function mouseUp()
{
	
	if(!downflag)
	{
		clearTimeout(stop);	
	}
	else
	{
		if(timerObj) 
		{
			clearInterval(timerObj);	
			timerObj = null;
		}
	}
	currObj = null;
	theIndex = this.id.replace(/[^\d]/g,'');
	onValueChanged(theIndex);	// 执行数值更改后的动作
}
// 定时到
function timeOut(delta)
{
	if(currObj)
	{
		theIndex = currObj.id.replace(/[^\d]/g,'');
    	theValue = parseInt(sliderObjectArray[theIndex]['formTarget'].value);
    	if(delta > 0) // 点击的是加号
    	{
    		if(theValue < sliderObjectArray[theIndex]['max'])
    		{
       			sliderObjectArray[theIndex]['formTarget'].value = theValue + delta;
				if(sliderObjectArray[theIndex]['nextformTarget'])
				{
					sliderObjectArray[theIndex]['nextformTarget'].value =sliderObjectArray[theIndex]['correspondingArray'][sliderObjectArray[theIndex]['formTarget'].value];
			}
       			positionSliderImage(theIndex);
   			}
   			else
    		{
    			clearInterval(timerObj);
    			timerObj = null;
    			currObj = null;
    		}
    	}
    	else if(delta < 0) // 点击的是减号
    	{
    		if(theValue > sliderObjectArray[theIndex]['min'])
   			{
        		sliderObjectArray[theIndex]['formTarget'].value = theValue + delta;
				if(sliderObjectArray[theIndex]['nextformTarget'])
				{
					sliderObjectArray[theIndex]['nextformTarget'].value =sliderObjectArray[theIndex]['correspondingArray'][sliderObjectArray[theIndex]['formTarget'].value];
				}
        		positionSliderImage(theIndex);
    		}
    		else 
    		{
    			clearInterval(timerObj);
    			timerObj = null;
    			currObj = null;
   			}
    	}
	}
}

function minusClicked()
{
    theIndex = this.id.replace(/[^\d]/g,'');
	if(!sliderObjectArray[theIndex]['state']) return;
    theValue = parseInt(sliderObjectArray[theIndex]['formTarget'].value);
    if(theValue > sliderObjectArray[theIndex]['min'])
    {
        sliderObjectArray[theIndex]['formTarget'].value = theValue - 1;
		if(sliderObjectArray[theIndex]['nextformTarget'])
		{
			sliderObjectArray[theIndex]['nextformTarget'].value =sliderObjectArray[theIndex]['correspondingArray'][sliderObjectArray[theIndex]['formTarget'].value];
		}
        positionSliderImage(theIndex);
        currObj = this;
		//setTimeout("minusFastTimer()",500);//若第一次按下时间超过500ms,就加速
		downflag = false;
        stop = setTimeout(function(){downflag = true;timerObj = setInterval("timeOut(-1)", 50); } ,500);
    }
}
function plusClicked()
{
    theIndex = this.id.replace(/[^\d]/g,'');
	if(!sliderObjectArray[theIndex]['state']) return;
    theValue = parseInt(sliderObjectArray[theIndex]['formTarget'].value);
    if(theValue < sliderObjectArray[theIndex]['max'])
    {
       	sliderObjectArray[theIndex]['formTarget'].value = theValue + 1;
		if(sliderObjectArray[theIndex]['nextformTarget'])
		{
			sliderObjectArray[theIndex]['nextformTarget'].value =sliderObjectArray[theIndex]['correspondingArray'][sliderObjectArray[theIndex]['formTarget'].value];
		}
       	positionSliderImage(theIndex);
       	currObj = this;
		//setTimeout("plusFastTimer()",500);
		downflag = false;
		stop = setTimeout(function(){downflag = true;timerObj = setInterval("timeOut(1)", 50); } ,500);
    }
}


//function minusClicked()
//{
//    theIndex = this.id.replace(/[^\d]/g,'');
//	if(!sliderObjectArray[theIndex]['state']) return;
//    theValue = parseInt(sliderObjectArray[theIndex]['formTarget'].value);
//    if(theValue > sliderObjectArray[theIndex]['min'])
//    {
//        sliderObjectArray[theIndex]['formTarget'].value = theValue - 1;
//		if(sliderObjectArray[theIndex]['nextformTarget'])
//		{
//			sliderObjectArray[theIndex]['nextformTarget'].value =sliderObjectArray[theIndex]['correspondingArray'][sliderObjectArray[theIndex]['formTarget'].value];
//		}
//        positionSliderImage(theIndex);
//        onValueChanged(theIndex);
//    }
//}
//
//function plusClicked()
//{
//    theIndex = this.id.replace(/[^\d]/g,'');
//	if(!sliderObjectArray[theIndex]['state']) return;
//    theValue = parseInt(sliderObjectArray[theIndex]['formTarget'].value);
//    if(theValue < sliderObjectArray[theIndex]['max'])
//    {
//        sliderObjectArray[theIndex]['formTarget'].value = theValue + 1;
//		if(sliderObjectArray[theIndex]['nextformTarget'])
//		{
//			sliderObjectArray[theIndex]['nextformTarget'].value =sliderObjectArray[theIndex]['correspondingArray'][sliderObjectArray[theIndex]['formTarget'].value];
//		}
//        positionSliderImage(theIndex);
//        onValueChanged(theIndex);
//    }
//}

function getOffset(e)
{
	var target = e.target;
	if (target.offsetLeft == undefined)
	{
		target = target.parentNode;
	}
	var pageCoord = getPageCoord(target);
	var eventCoord =
	{ 
		x: window.pageXOffset + e.clientX,
		y: window.pageYOffset + e.clientY
	};
	var offset =
	{
		offsetX: eventCoord.x - pageCoord.x,
		offsetY: eventCoord.y - pageCoord.y
	};
	return offset;
}
function getPageCoord(element) 
{
	var coord = {x: 0, y: 0};
	while (element)
	{
		coord.x += element.offsetLeft;
		coord.y += element.offsetTop;
		element = element.offsetParent;
	}
	return coord;
}

function getpos(e)
{
	var e=window.event || e;
	//var e = arguments[0]|| window.event;
	var posX=(e.offsetX==undefined) ? getOffset(e).offsetX : e.offsetX ;
	return posX;
}


lineClicked = function (event)
{ 
    var e = event || window.event;
    theIndex = this.id.replace(/[^\d]/g,'');
	if(!sliderObjectArray[theIndex]['state']) return;
    var handleImg = document.getElementById('slider_handle' + theIndex);	
    var ratio = sliderObjectArray[theIndex]['width'] / (sliderObjectArray[theIndex]['max']-sliderObjectArray[theIndex]['min']);
    if(isDigit(e.offsetX))
		var pos = e.offsetX - 4;  //firfox can not sustain offsetX;
	else
		var pos =getpos(e) -4;
    if(pos > sliderObjectArray[theIndex]['width']) pos = sliderObjectArray[theIndex]['width'];
    if(pos < 0) pos = 0;
    handleImg.style.left = pos + minusHandleWidth + 'px';
	//$("#slider_handle" + theIndex).css('left',pos + minusHandleWidth);
	$("#slider_slider_red" + theIndex).css("width",pos);
	
    sliderObjectArray[theIndex]['formTarget'].value = Math.round(pos / ratio) + sliderObjectArray[theIndex]['min'];
	if(sliderObjectArray[theIndex]['nextformTarget'])
	{
		sliderObjectArray[theIndex]['nextformTarget'].value =sliderObjectArray[theIndex]['correspondingArray'][sliderObjectArray[theIndex]['formTarget'].value];
	}
	//positionSliderImage(theIndex);
    onValueChanged(theIndex);
}
	
initMoveSlider = function(event)
{
	var ev = window.event || event;
	slideInProgress = true;
	event_start_x = ev.clientX;
	handle_start_x = this.style.left.replace('px','');
	currentSliderIndex = this.id.replace(/[^\d]/g,'');
	if(!sliderObjectArray[currentSliderIndex]['state']) return;
	start_value = sliderObjectArray[currentSliderIndex]['formTarget'].value;
	return false;
}

startMoveSlider = function(event)
{
    if(!slideInProgress) return;	
	e = event || window.event;	
	var leftPos = handle_start_x/1 + e.clientX/1 - event_start_x - minusHandleWidth;
	if(leftPos<0)leftPos = 0;
	if(leftPos/1>sliderObjectArray[currentSliderIndex]['width'])leftPos = sliderObjectArray[currentSliderIndex]['width'];
	if(!sliderObjectArray[currentSliderIndex]['state']) return;
	document.getElementById('slider_handle' + currentSliderIndex).style.left = leftPos + minusHandleWidth + 'px';
	adjustFormValue(currentSliderIndex);
	$("#slider_slider_red" + currentSliderIndex).css("width",leftPos);//移动鼠标左侧跟着变红
}

function stopMoveSlider()
{
	if(slideInProgress && sliderObjectArray[currentSliderIndex]['formTarget'].value != start_value)
	{
	    onValueChanged(currentSliderIndex);
	}
	slideInProgress = false;
}

function form_widget_amount_slider(targetElId,formTarget,width,min,max,onchangeAction,nextformTarget,correspondingArray)
{
	if(!slider_handle_image_obj)
	{
		getImageSliderHeight();		
	}
			
	slider_counter = slider_counter +1;
	sliderObjectArray[slider_counter] = new Array();
	sliderObjectArray[slider_counter] = {"width":width - sliderHandleWidth - minusHandleWidth ,"min":min,"max":max,"formTarget":formTarget,"onchangeAction":onchangeAction,"nextformTarget":nextformTarget,"correspondingArray":correspondingArray,"state":1};
	
	formTarget.setAttribute('sliderIndex',slider_counter);
	formTarget.onchange = onTextChanged;
	formTarget.onkeydown = onKeyDown;
	formTarget.onblur = onBlur;
	var parentObj = document.createElement('DIV');

	
	parentObj.style.height = '12px';	// The height of the image
	parentObj.style.position = 'relative';
	parentObj.id = 'slider_container' + slider_counter;
	document.getElementById(targetElId).appendChild(parentObj);
	
	var handleMinus = document.createElement('IMG');
	handleMinus.style.position = 'absolute';
	handleMinus.style.left = '0px';
	handleMinus.style.height = minusHandleWidth +'px';
	handleMinus.style.width = minusHandleWidth+'px';		
	handleMinus.style.cursor = 'pointer';
	handleMinus.src = form_widget_amount_slider_minus_handle;
	handleMinus.id = 'slider_minus_handle' + slider_counter;
	handleMinus.onmousedown = minusClicked;
	handleMinus.onmouseup = mouseUp;	// 鼠标抬起动作
	//handleMinus.onmouseleave = mouseUp;	// 鼠标离开动作
	//handleMinus.ondragleave = mouseUp;	// 鼠标离开动作
	parentObj.appendChild(handleMinus);
	
	var obj = document.createElement('DIV');
	obj.className = 'form_widget_amount_slider';
	obj.innerHTML = '<span></span>';
	obj.style.width = width - minusHandleWidth -2 + 'px';
	obj.id = 'slider_slider' + slider_counter;
	obj.style.position = 'absolute';
	obj.style.left = minusHandleWidth +'px';
	//obj.style.bottom = '2px';
	obj.style.bottom = '1px';
	obj.style.cursor = 'pointer';
	obj.onmousedown = lineClicked;
	parentObj.appendChild(obj);
	
	var objred = document.createElement('DIV');
	objred.className = 'form_widget_amount_slider_red';
	objred.innerHTML = '<span></span>';
	objred.style.width =0+'px';
	objred.id = 'slider_slider_red' + slider_counter;
	objred.style.position = 'absolute';
	objred.style.left = minusHandleWidth + 'px';
	/*objred.style.bottom = '2px';*/
	objred.style.cursor = 'pointer';
	objred.onmousedown = lineClicked;
	objred.style.zIndex = 3;
	parentObj.appendChild(objred);
	
	var handlePlus = document.createElement('IMG');
	handlePlus.style.position = 'absolute';
	handlePlus.style.left = width + 'px';
	handlePlus.style.height = minusHandleWidth +'px';
	handlePlus.style.width = minusHandleWidth +'px';	
	handlePlus.style.cursor = 'pointer';
	handlePlus.src = form_widget_amount_slider_plus_handle;
	handlePlus.id = 'slider_plus_handle' + slider_counter;
	handlePlus.onmousedown = plusClicked;
	handlePlus.onmouseup = mouseUp;
	//handlePlus.onmouseleave = mouseUp;
	//handlePlus.ondragleave = mouseUp;
	parentObj.appendChild(handlePlus);
	
	var handleImg = document.createElement('IMG');
	handleImg.style.position = 'absolute';
	handleImg.style.left = '0px';
	handleImg.style.bottom = '-3px';
	//handleImg.style.bottom = '-2px';
	handleImg.style.height = '13px';
	handleImg.style.zIndex = 5;
	handleImg.src = slider_handle_image_obj.src;
	handleImg.id = 'slider_handle' + slider_counter;
	handleImg.onmousedown = initMoveSlider;
	
	
//	var objOver = document.createElement('DIV');
//	objOver.className = 'form_cover_slider_layer';
//	objOver.style.width = width + minusHandleWidth + 'px';
//	objOver.id = 'slider_slider_over' + slider_counter;
//	objOver.style.zIndex = 50;
//	objOver.style.visibility = 'hidden';
//	parentObj.appendChild(objOver);
	
	parentObj.style.width = obj.offsetWidth + 'px';
	
	if(document.body.onmouseup)
	{
		if(document.body.onmouseup.toString().indexOf('stopMoveSlider') == -1)
		{
			alert('You already have an onmouseup event assigned to the body tag');
		}
	}
	else
	{
		document.body.onmouseup = stopMoveSlider;	
		document.body.onmousemove = startMoveSlider;	
	}
	
	handleImg.ondragstart = form_widget_cancel_event;
	parentObj.appendChild(handleImg);
	positionSliderImage(slider_counter);
	
//	return objOver;
}

function sliderSetValue(index,setvalue)
{
	 sliderObjectArray[index]['formTarget'].value = setvalue;
	 positionSliderImage(index);
			
}



function slidergray(index,state)//0:灰 1可用
{
	if(state)
	{
		var cssSet = {cursor: "pointer", opacity: 1};//filter: "alpha(opacity=100,style=0)",
	}
	else
	{
		var cssSet = {cursor: "default", opacity:0.6};//filter: "alpha(opacity=60,style=0) gray",
	}
		
	$("#slider_minus_handle" + index).css(cssSet);
	$("#slider_plus_handle" + index).css(cssSet);
	$("#slider_handle" + index).css(cssSet);
	$("#slider_slider" + index).css(cssSet);
	$("#slider_slider_red" + index).css(cssSet);
	sliderObjectArray[index]['state'] = state;
}


function changeMinMax(index,min,max)//改变大小值
{
	sliderObjectArray[index]['min'] = min; 
	sliderObjectArray[index]['max'] = max; 
}

function changeArray(index,corrosponse)//改变对应数组
{
	sliderObjectArray[index]['correspondingArray']= corrosponse;	
}


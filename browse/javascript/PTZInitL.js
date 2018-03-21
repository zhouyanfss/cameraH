// JavaScript Document
var lan = $("#PAGE_LANGUAGE").val();
$.fn.jQueryPie
  (
	  {
		  target: '#pie',
		  pics: ["../images/PTZimage/p0.gif", "../images/PTZimage/p1.gif", "../images/PTZimage/p2.gif", "../images/PTZimage/p3.gif", "../images/PTZimage/p4.gif", "../images/PTZimage/p5.gif", "../images/PTZimage/p6.gif", "../images/PTZimage/p7.gif", "../images/PTZimage/p8.gif"], 
		  codeVal: [4,7,1,6,3,5,2,8],  
		  ox: 65,
		  oy: 64,
		  rMin: 16,
		  rMax: 63,
		  imgH: 126,
		  imgW:126,
		  onChanging: function(currCode)
		  {  
			  $("#command").val(currCode);
			  $("#PTZForm").submit();
		  }, 
		  onStop: function(curr) 
		  {  
			  $("#command").val(0);
			  $("#PTZForm").submit();
		  } 
	  }
  ); 
  
var buStop = function(){$("#command").val(0);$("#PTZForm").submit();};
function mdSubmit(val){$("#command").val(val);$("#PTZForm").submit();}
$.fn.controlButton({
	target: '#irisClose',
	imgH: 34,
	imgW:34,
	pics: ["../images/PTZimage/Iris_close.gif","../images/PTZimage/Iris_close_.gif"],
	language : lan,
	alt: ["Iris Close","光圈关闭"],
	mdfunc: function(){mdSubmit(10);},
	mupfunc: buStop
});
$.fn.controlButton({
	target: '#irisOpen',
	imgH: 34,
	imgW:34,
	pics: ["../images/PTZimage/Iris_open.gif","../images/PTZimage/Iris_open_.gif"],
	language : lan,
	alt: ["Iris Open","光圈开启"],
	mdfunc: function(){mdSubmit(9);},
	mupfunc: buStop
});
$.fn.controlButton({
	target: '#focusNear',
	imgH: 34,
	imgW:34,
	pics: ["../images/PTZimage/focus_near.gif","../images/PTZimage/focus_near_.gif"],
	language : lan,
	alt: ["Focus Near","近端聚焦"],
	mdfunc: function(){mdSubmit(11);},
	mupfunc: buStop
});

$.fn.controlButton({
	target: '#focusFar',
	imgH: 34,
	imgW:34,
	pics: ["../images/PTZimage/focus_far.gif","../images/PTZimage/focus_far_.gif"],
	language : lan,
	alt: ["Focus Far","远端聚焦"],
	mdfunc: function(){mdSubmit(12);},
	mupfunc: buStop
});

$.fn.controlButton({
	target: '#zoomOut',
	imgH: 34,
	imgW:34,
	pics: ["../images/PTZimage/zoom_out.gif","../images/PTZimage/zoom_out_.gif"],
	language : lan,
	alt: ["Zoom out","缩小"],
	mdfunc: function(){mdSubmit(14);},
	mupfunc: buStop
});

$.fn.controlButton({
	target: '#zoomIn',
	imgH: 34,
	imgW:34,
	pics: ["../images/PTZimage/zoom_in.gif","../images/PTZimage/zoom_in_.gif"],
	language : lan,
	alt: ["Zoom in","放大"],
	mdfunc: function(){mdSubmit(13);},
	mupfunc: buStop
});

//******************yuntai ****************************
function submitFun(code,domID,transID,formID)
{
	$("form[id="+formID+"] input[name='command']").val(code);
	$("form[id="+formID+"] input[id="+transID+"]").val($("#"+domID).val());
	$("#"+formID).submit();
}

/* justin add start 2013.7.4 */
function cbsubmitFun(code,domID,transID,formID)
{
	$("form[id="+formID+"] input[name='command']").val(code);
	var cbtemp = $("#"+domID).is(':checked')?1:0;
	$("form[id="+formID+"] input[id="+transID+"]").val(cbtemp);
	$("#"+formID).submit();
}

$('#jsrelatedWaitTime').val($('#relatedTimeGet').val());
if($('#relatedFocusGet').val()=='1'){
	$('#jsrelatedFocus').attr('checked',true);
}else{
	$('#jsrelatedWaitTime').attr('disabled',true);
}
/* justin add end 2013.7.4 */
$("#jsPanSpeed").val($("#panSpeedGet").val());
$("#jsTiltSpeed").val($("#tiltSpeedGet").val());
$("#jsFocusSpeed").val($("#focusSpeedGet").val());
$("#jsZoomSpeed").val($("#zoomSpeedGet").val());


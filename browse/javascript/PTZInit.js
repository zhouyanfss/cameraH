// JavaScript Document
getCookie("playMode") == "1" ? $("#playModeSelect").val(1) : $("#playModeSelect").val(0);

var lan = $("#PAGE_LANGUAGE").val();
$.fn.jQueryPie
  (
	  {
		  target: '#pie',
		  pics: ["../images/PTZimage/p0.png", "../images/PTZimage/p1.png", "../images/PTZimage/p2.png", "../images/PTZimage/p3.png", "../images/PTZimage/p4.png", "../images/PTZimage/p5.png", "../images/PTZimage/p6.png", "../images/PTZimage/p7.png", "../images/PTZimage/p8.png"], 
		  codeVal: [4,7,1,6,3,5,2,8],  
		  ox: 78,
		  oy: 78,
		  rMin: 20,
		  rMax: 78,
		  imgH: 156,
		  imgW: 156,
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
//justin add 3013.5.31
$.fn.controlButton({
	target: '#irisClose',	
	imgH: 41,
	imgW:42,
	pics: ["../images/PTZimage/Iris_close.gif","../images/PTZimage/Iris_close_.gif"],
	language : lan,
	alt: ["Close Iris","关光圈"],
	title: ["Iris Closed","关光圈"],
	mdfunc: function(){$("#command").val(10);$("#PTZForm").submit();},
	mupfunc: buStop
});

$.fn.controlButton({
	target: '#irisOpen',
	imgH: 41,
	imgW:42,
	pics: ["../images/PTZimage/Iris_open.gif","../images/PTZimage/Iris_open_.gif"],
	language : lan,
	alt: ["Open Iris","开光圈"],
	title: ["Iris Open","开光圈"],
	mdfunc: function(){$("#command").val(9);$("#PTZForm").submit();},
	mupfunc: buStop
});

$.fn.controlButton({
	target: '#focusNear',
	imgH: 41,
	imgW:42,
	pics: ["../images/PTZimage/focus_near.gif","../images/PTZimage/focus_near_.gif"],
	language : lan,
	alt: ["Focus Near","近端聚焦"],
	mdfunc: function(){mdSubmit(11);},
	mupfunc: buStop
});

$.fn.controlButton({
	target: '#focusFar',
	imgH: 41,
	imgW:42,
	pics: ["../images/PTZimage/focus_far.gif","../images/PTZimage/focus_far_.gif"],
	language : lan,
	alt: ["Focus Far","远端聚焦"],
	mdfunc: function(){mdSubmit(12);},
	mupfunc: buStop
});

$.fn.controlButton({
	target: '#zoomOut',
	imgH: 41,
	imgW:42,
	pics: ["../images/PTZimage/zoom_out.gif","../images/PTZimage/zoom_out_.gif"],
	language : lan,
	alt: ["Zoom out","缩小"],
	mdfunc: function(){mdSubmit(14);},
	mupfunc: buStop
});

$.fn.controlButton({
	target: '#zoomIn',
	imgH: 41,
	imgW:42,
	pics: ["../images/PTZimage/zoom_in.gif","../images/PTZimage/zoom_in_.gif"],
	language : lan,
	alt: ["Zoom in","放大"],
	mdfunc: function(){mdSubmit(13);},
	mupfunc: buStop
});

//********** yuntai function justin add 2013.6.22*************************
var tempStr;
for(var i = 0; i < 255; i++){
		tempStr += "<option value='" + i + "'>" + (i+1) + "</option>";
	}
	$("#jsLivePresetNo").html(tempStr).change();
	
tempStr="";
for(var i = 0; i < 4; i++){
		tempStr += "<option value='" + i + "'>" + (i+1) + "</option>";
	}
	$("#jsLiveAutopanNo").html(tempStr).change();
	$("#jslivePatternNum").html(tempStr).change();
	
	
tempStr="";
for(var i = 0; i < 3; i++){
		tempStr += "<option value='" + i + "'>" + (i+1) + "</option>";
	}
	$("#jsliveTourNum").html(tempStr).change();


/* justin add start 2013.7.4 */
function submitFun(code,domID,transID,formID)
{
	$("form[id="+formID+"] input[name='command']").val(code);
	$("form[id="+formID+"] input[id="+transID+"]").val($("#"+domID).val());
	$("#"+formID).submit();
}
function cbsubmitFun(code,domID,transID,formID)
{
	$("form[id="+formID+"] input[name='command']").val(code);
	var cbtemp = $("#"+domID).is(':checked')?1:0;
	$("form[id="+formID+"] input[id="+transID+"]").val(cbtemp);
	$("#"+formID).submit();
}
/* justin add end 2013.7.4 */
/*  
$.fn.jQueryMenu
  (
	  {
		  target: '#menu',
		  pics: ["../images/MENUimage/m0.gif", "../images/MENUimage/m1.gif", "../images/MENUimage/m2.gif", "../images/MENUimage/m3.gif", "../images/MENUimage/m4.gif", "../images/MENUimage/m5.gif", "../images/MENUimage/m6.gif", "../images/MENUimage/m7.gif", "../images/MENUimage/m8.gif", "../images/MENUimage/m9.gif"], 
		  codeVal: [2,0,3,0,4,1,5,0,6],  
		  ox: 78,
		  oy: 78,
		  rMin: 20,
		  rMax: 78,
		  imgH: 156,
		  imgW: 156,
		  onChanging: function(currCode)
		  {  
			  $("#menuCommand").val(currCode);
			  $("#MenuForm").submit();
		  }, 
		  onStop: function(curr) 
		  {  
			  $("#menuCommand").val(0);
			  $("#MenuForm").submit();
		  } 
	  }
  ); 
  
function menuStop(val){$("#menuCommand").val(val);$("#MenuForm").submit();}
function menuSubmit(val){$("#menuCommand").val(val);$("#MenuForm").submit();}

$.fn.menuButton({
	target: '#mFocusNear',
	imgH: 41,
	imgW:42,
	pics: ["../images/MENUimage/m_focus_near.gif","../images/MENUimage/m_focus_near_.gif"],
	language : lan,
	alt: ["Near","近端聚焦"],
	menudfunc: function(){menuSubmit(8);},
	menuupfunc: function(){menuStop(10);}
});

$.fn.menuButton({
	target: '#mFocusFar',
	imgH: 41,
	imgW:42,
	pics: ["../images/MENUimage/m_focus_far.gif","../images/MENUimage/m_focus_far_.gif"],
	language : lan,
	alt: ["Far","远端聚焦"],
	menudfunc: function(){menuSubmit(9);},
	menuupfunc: function(){menuStop(10);}
});

$.fn.menuButton({
	target: '#mZoomOut',
	imgH: 41,
	imgW:42,
	pics: ["../images/MENUimage/m_zoom_out.gif","../images/MENUimage/m_zoom_out_.gif"],
	language : lan,
	alt: ["Zoom out","缩小"],
	menudfunc: function(){menuSubmit(11);},
	menuupfunc: function(){menuStop(13);}
});

$.fn.menuButton({
	target: '#mZoomIn',
	imgH: 41,
	imgW:42,
	pics: ["../images/MENUimage/m_zoom_in.gif","../images/MENUimage/m_zoom_in_.gif"],
	language : lan,
	alt: ["Zoom in","放大"],
	menudfunc: function(){menuSubmit(12);},
	menuupfunc: function(){menuStop(13);}
});
*/
function menusubmitFun(code,domID,transID,formID)
{
	$("form[id="+formID+"] input[name='menuCommand']").val(code);
	var cbtemp = $("#"+domID).is(':checked')?1:0;
	$("form[id="+formID+"] input[id="+transID+"]").val(cbtemp);
	$("#"+formID).submit();
}
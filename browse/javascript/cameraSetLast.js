// JavaScript Document

imageSlider();	
WBSlider();
AESlider();
gainSlider();
ExpSlider();
WDRLevelSlider();
LDCLevelSlider();
color2bwthrSlider();
bw2colorthrSlider();

function imageSlider()
{
	
	$('#ImgBrightness_G').val($('#ImgBrightness_G_').val());
	$('#ImgContrast_G').val($('#ImgContrast_G_').val());
	$('#ImgHue_G').val($('#ImgHue_G_').val());
	$('#ImgSaturation_G').val($('#ImgSaturation_G_').val());
	$('#EdgeStrength_G').val($('#EdgeStrength_G_').val());
	$('#ImgDenoise_G').val($('#ImgDenoise_G_').val());
	
	$('#ImgBrightness_M').val($('#imgB0_').val());
	$('#ImgContrast_M').val($('#imgC0_').val());
	$('#ImgHue_M').val($('#imgH0_').val());
	$('#ImgSaturation_M').val($('#imgS0_').val());
	$('#EdgeStrength_M').val($('#edgeS0_').val());
	$('#ImgDenoise_M').val($('#imgD0_').val());
	
	form_widget_amount_slider('RBrightSlider_G',document.getElementById('ImgBrightness_G'),120,0,255,"document.getElementById('sliderForm').submit()");
	form_widget_amount_slider('RSharpSlider_G',document.getElementById('EdgeStrength_G'),120,0,255,"document.getElementById('sliderForm').submit()");
	form_widget_amount_slider('RHueSlider_G',document.getElementById('ImgHue_G'),120,0,255,"document.getElementById('sliderForm').submit()");
	form_widget_amount_slider('RContrastSlider_G',document.getElementById('ImgContrast_G'),120,0,255,"document.getElementById('sliderForm').submit()");
	form_widget_amount_slider('RSatuationSlider_G',document.getElementById('ImgSaturation_G'),120,0,255,"document.getElementById('sliderForm').submit()");
	form_widget_amount_slider('RDenoiseSlider_G',document.getElementById('ImgDenoise_G'),120,0,255,"document.getElementById('sliderForm').submit()");
	
	form_widget_amount_slider('RBrightSlider_M',document.getElementById('ImgBrightness_M'),120,0,255,"document.getElementById('sliderForm').submit()");
	form_widget_amount_slider('RSharpSlider_M',document.getElementById('EdgeStrength_M'),120,0,255,"document.getElementById('sliderForm').submit()");
	form_widget_amount_slider('RHueSlider_M',document.getElementById('ImgHue_M'),120,0,255,"document.getElementById('sliderForm').submit()");
	form_widget_amount_slider('RContrastSlider_M',document.getElementById('ImgContrast_M'),120,0,255,"document.getElementById('sliderForm').submit()");
	form_widget_amount_slider('RSatuationSlider_M',document.getElementById('ImgSaturation_M'),120,0,255,"document.getElementById('sliderForm').submit()");
	form_widget_amount_slider('RDenoiseSlider_M',document.getElementById('ImgDenoise_M'),120,0,255,"document.getElementById('sliderForm').submit()");	
}

function ExpSlider()
{
	$('#EXP').val($('#EXP_').val());
	form_widget_amount_slider('ExpCompensation',document.getElementById('EXP'),100,0,255,"document.getElementById('ExpForm').submit()");
}

function WDRLevelSlider()
{
	$('#WDRLEVEL').val($('#WDRLEVEL_').val());
	form_widget_amount_slider('DWDRLevel',document.getElementById('WDRLEVEL'),110,0,255,"document.getElementById('WDRLevelForm').submit()");
}

function LDCLevelSlider()
{
	$('#LDCLevel').val($('#LDCLevel_').val());
	form_widget_amount_slider('DLDCLevel',document.getElementById('LDCLevel'),110,0,255,"document.getElementById('LDCLevelForm').submit()");
}

function color2bwthrSlider()
{
	$('#c2bwthr').val($('#c2bwthr_').val());
	form_widget_amount_slider('Color2BwThr',document.getElementById('c2bwthr'),100,0,255,"document.getElementById('IRSetForm').submit()");
}

function bw2colorthrSlider()
{
	$('#bw2cthr').val($('#bw2cthr_').val());
	form_widget_amount_slider('Bw2ColorThr',document.getElementById('bw2cthr'),100,0,255,"document.getElementById('IRSetForm').submit()");
}

function WBSlider()
{

	document.mcWBSetForm.WhiteBalanceRedGain.value = document.mcWBSetForm.WBRG_.value;
	document.mcWBSetForm.WhiteBalanceBlueGain.value = document.mcWBSetForm.WBBG_.value;
		
	form_widget_amount_slider('Slider_RedGain',document.mcWBSetForm.WhiteBalanceRedGain,120,0,255,"document.getElementById('mcWBSetForm').submit()");
	form_widget_amount_slider('Slider_BlueGain',document.mcWBSetForm.WhiteBalanceBlueGain,120,0,255,"document.getElementById('mcWBSetForm').submit()");
}

function AESlider()
{
	var shutterspeed50= new Array("1/8000","1/6000","1/4000","1/2000","1/1000","1/500","1/250","1/200","1/150","1/100","1/50","1/25","1/20","1/15","1/10","1/8","1/5","1/3","1/2","1");
	
	var shutterspeed60= new Array("1/8000","1/6000","1/4000","1/2000","1/1000","1/500","1/300","1/240","1/180","1/120","1/60","1/30","1/20","1/15","1/10","1/8","1/5","1/3","1/2","1");

	document.mcAESetForm.ShutterSpeed.value = document.mcAESetForm.ShutterSpeed_.value;//index:15
	form_widget_amount_slider('Slider_ShutterSpeed50',document.mcAESetForm.ShutterSpeed,110,0,19,"document.getElementById('mcAESetForm').submit();",document.mcAESetForm.ShutterSpeedText,shutterspeed50);
	
	if(document.getElementById("PFR_").value == 60)
	{
		document.mcAESetForm.ShutterSpeedText.value = shutterspeed60[document.mcAESetForm.ShutterSpeed.value];
		changeArray(15,shutterspeed60);
	}
	else
	{
		
		//if(document.getElementById("mainFrameRate").value == 30 || document.getElementById("minFrameRate").value == 30)
		//	changeMinMax(15,1,7);
		document.mcAESetForm.ShutterSpeedText.value = shutterspeed50[document.mcAESetForm.ShutterSpeed.value];
		sliderSetValue(15,document.mcAESetForm.ShutterSpeed_.value);
	}
}

function gainSlider()
{
	var gainvalue = new Array("1X","2X","4X","8X","16X","32X","64X");
	document.mcAESetForm.AEGain.value = document.mcAESetForm.AEGain_.value;
	document.mcAESetForm.AEGainText.value = gainvalue[document.mcAESetForm.AEGain.value];
	form_widget_amount_slider('Slider_AEGain',document.mcAESetForm.AEGain,110,0,6,"document.getElementById('mcAESetForm').submit()",document.mcAESetForm.AEGainText,gainvalue);	
}

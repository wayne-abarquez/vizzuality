<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd" >
<html>

<head>

	<link rel="stylesheet" href="css/blueprint/screen.css" type="text/css" media="screen, projection">
	<link rel="stylesheet" href="css/layout.css" type="text/css" media="screen, projection">	
	<link rel="stylesheet" href="css/typo.css" type="text/css" media="screen, projection">	
	<link rel="stylesheet" href="css/blueprint/print.css" type="text/css" media="print">
</head>

<body>

<div class="container">
	<div class="span-24 header">
		<div class="span-24 last headerImage">
		</div>
		<!--<div class="span-7 logoContainer"> 
		</div>
		<div class="span-11 prepend-6 last menuContainer" style="textAlign: right">
			<ul class="menu">
				<li class="active"><a href="#" class="active">EXPLORE</a></li>
				<li><a href="about.html">ABOUT</a></li>
			</ul>
			<img src="img/logos.jpg" style="float: right"/>
		</div>-->
		<div class="span-24 widgetContainer" id="wgc">
			<div class="span-24" id="widget" style="height:500px;">
			<h1>This site requieres Flash to run</h1>
			<p><a href="http://www.adobe.com/go/getflashplayer"><img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" /></a></p>
			</div>
		</div>
		<div class="span-24 separator">
		</div>
		<div class="span-24 minus10">
			<h2>FEATURED SPECIES ON GROMS</h2>
			<div class="span-6">
				<a href="javascript:openSpecies(1012)"><img src="img/featured/1.jpg" class="imgBiggest"/></a>
			</div>
			<div class="span-6">
				<a href="javascript:openSpecies(1598)"><img src="img/featured/2.jpg" class="imgBiggest"/></a>
			</div>
			<div class="span-6">
				<a href="javascript:openSpecies(116)"><img src="img/featured/3.jpg" class="imgBiggest"/></a>
			</div>
			<div class="span-6 last">
				<a href="javascript:openSpecies(3281)"><img src="img/featured/4.jpg" class="imgBiggest"/></a>
			</div>					
		</div>
		<div class="span-24 footerContainer">
			<p>Global Registry of Migratory Species. All rights reserved. 2009. | <a href="#" class="footerLink">feedback</a>  |  <a href="#" class="footerLink">contact us</a></p>
		</div>

	</div>
</div>

<script type="text/javascript" src="js/swfobject.js"></script>
<script type="text/javascript" src="swfaddress/swfaddress.js"></script>
<script language="javascript" src="js/Tween.js"></script>
<script language="javascript" src="js/Sequence.js"></script>
{literal}
<script type="text/javascript"> 
	// <![CDATA[
	function gup( name ) {
	  name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
	  var regexS = "[\\?&]"+name+"=([^&#]*)";
	  var regex = new RegExp( regexS );
	  var results = regex.exec( window.location.href );
	  if( results == null )
	    return "";
		return results[1];
	}	
		
    function expandHeight() { 
       document.getElementById('widget').style.height="601px";
       document.getElementById('swf').style.height="569px";
       document.getElementById('wgc').style.backgroundImage='url(img/bkgWidget2.jpg)';
    }   
    function contractHeight() { 
       document.getElementById('widget').style.height="500px";
       document.getElementById('swf').style.height="469px";
       document.getElementById('wgc').style.backgroundImage='url(img/bkgWidget.jpg)';
    }        		
		
	var so = new SWFObject("GROMS2.swf", "swf", "935", "469", "9"); 
	so.addParam("allowFullScreen", "true");
	so.addParam("allowScriptAccess", "always");
	so.addVariable("swf", "");
	so.addVariable("data_server_endpoint", '{/literal}{$smarty.const.DATA_URL}{literal}');
	so.addVariable("gmap_key", '{/literal}{$smarty.const.GMAP_KEY}{literal}');
	so.addVariable("geoserverEndPoint", "{/literal}{$smarty.const.GEOSERVER_URL}{literal}");
	so.addVariable("wmsProxy", "{/literal}{$smarty.const.WMS_PROXY}{literal}");	
	so.addVariable("hide_header",'true');
	so.write("widget");
	   	
	function openSpecies(id) {
		document.getElementById('swf').openSpecies(id);
	}   	
	   	
	// ]]>
</script>
{/literal}

</body>
</html>
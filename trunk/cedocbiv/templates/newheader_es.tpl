<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd" >
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>CeDocBiV</title>
	
	<link rel="stylesheet" href="/css/blueprint/grid.css" type="text/css" media="screen, projection">
	<link rel="stylesheet" href="/css/blueprint/screen.css" type="text/css" media="screen, projection">
	<link rel="stylesheet" href="/css/blueprint/print.css" type="text/css" media="print">
    <link rel="stylesheet" href="/css/newstyle.css" type="text/css">
    
    <!-- tabs -->
    <link rel="stylesheet" href="/css/example.css" TYPE="text/css" MEDIA="screen">
	
	{literal}
	<script type="text/javascript">
		function idiomaload(){
			
			var selIndex = document.frmName.idioma.selectedIndex;
			var newlang = document.frmName.idioma.options[selIndex].value;			
			
			
			if(gup('lang')=="") {
				if((window.location).toString().indexOf("?")>0) {
					window.location = window.location + "&lang="+newlang;
				} else {
					window.location = window.location + "?lang="+newlang;
				}
				
			} else {
				window.location = (window.location).toString().replace("lang="+gup('lang'),"lang="+newlang);
			}

		}
		
		function gup( name )
		{
		  name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
		  var regexS = "[\\?&]"+name+"=([^&#]*)";
		  var regex = new RegExp( regexS );
		  var results = regex.exec( window.location.href );
		  if( results == null )
		    return "";
		  else
		    return results[1];
		}		
	</script>
	{/literal}

</head>

<body>

<div class="container">

<div class="header">
	<div class="span-1 logo"></div>
	<div class="span-1 headerTitle"><p><span class="color1">Centro de Documentaci&oacute;n</span><span class="color2"> de </span> <span class="color3">Biodiversidad Vegetal</span></p></div>
	<div class="span-1 comboIdioma">
		<form name="frmName">
		<select id="idioma" onchange="idiomaload()">
			<option value="cat" {if $smarty.session.lang eq "cat"}selected{/if}>Catalá</option>
			<option value="es" {if $smarty.session.lang eq "es"}selected{/if}>Español</option>
			<option value="en" {if $smarty.session.lang eq "en"}selected{/if}>English</option>
		</select>
		</form>
	</div>
</div>		



<?php /* Smarty version 2.6.26, created on 2009-12-04 01:02:17
         compiled from newheader_en.tpl */ ?>
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
	
	<?php echo '
	<script type="text/javascript">
		function idiomaload(){
			
			var selIndex = document.frmName.idioma.selectedIndex;
			var newlang = document.frmName.idioma.options[selIndex].value;			
			
			
			if(gup(\'lang\')=="") {
				if((window.location).toString().indexOf("?")>0) {
					window.location = window.location + "&lang="+newlang;
				} else {
					window.location = window.location + "?lang="+newlang;
				}
				
			} else {
				window.location = (window.location).toString().replace("lang="+gup(\'lang\'),"lang="+newlang);
			}

		}
		
		function gup( name )
		{
		  name = name.replace(/[\\[]/,"\\\\\\[").replace(/[\\]]/,"\\\\\\]");
		  var regexS = "[\\\\?&]"+name+"=([^&#]*)";
		  var regex = new RegExp( regexS );
		  var results = regex.exec( window.location.href );
		  if( results == null )
		    return "";
		  else
		    return results[1];
		}		
	</script>
	'; ?>


</head>

<body>

<div class="container">

<div class="header">
	<div class="span-1 logo"></div>  
	<div class="span-1 headerTitle"><p><span class="color1">Documentation Center</span><span class="color2"> of </span> <span class="color3">Plant Biodiversity</span></p></div>
	<div class="span-1 comboIdioma">
		<form name="frmName">
		<select id="idioma" onchange="idiomaload()">
			<option value="cat" <?php if ($_SESSION['lang'] == 'cat'): ?>selected<?php endif; ?>>Catalá</option>
			<option value="es" <?php if ($_SESSION['lang'] == 'es'): ?>selected<?php endif; ?>>Español</option>
			<option value="en" <?php if ($_SESSION['lang'] == 'en'): ?>selected<?php endif; ?>>English</option>
		</select>
		</form>
	</div>
</div>		


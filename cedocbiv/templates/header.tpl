<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd" >
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<title>CeDocBiV</title>
	
	<link rel="stylesheet" href="css/blueprint/src/grid.css" type="text/css" media="screen, projection">
	<link rel="stylesheet" href="css/blueprint/screen.css" type="text/css" media="screen, projection">
	<link rel="stylesheet" href="css/blueprint/print.css" type="text/css" media="print">
    <link rel="stylesheet" href="css/style.css" type="text/css">
    
    <!-- tabs -->
    <link rel="stylesheet" href="css/example.css" TYPE="text/css" MEDIA="screen">
	
	{literal}<script type="text/javascript" src="js/jquery-1.3.2.js"></script>{/literal}

	{literal}
	<script type="text/javascript">
		function idiomaload(idioma){
			
			if(gup('lang')=="") {
				if((window.location).toString().indexOf("?")>0) {
					window.location = window.location + "&lang="+idioma;
				} else {
					window.location = window.location + "?lang="+idioma;
				}
				
			} else {
				window.location = (window.location).toString().replace("lang="+gup('lang'),"lang="+idioma);
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
	<div class="containerHeader">
		<!-- <a href="index.php"><div class="span-1 last logo"></div></a> -->
		<div class="span-1 last idioma">
			<span>
				<div class="span-1 banderaEn" onclick="idiomaload('en')"></div>
				<div class="span-1 banderaEs" onclick="idiomaload('es')"></div>
				<div class="span-1 banderaCat" onclick="idiomaload('cat')"></div>
			</span>		
		</div>
	</div>

	<div class="headerTitle">
		<a href="http://www.bib.ub.edu/cedocbiv/"><p><span class="color1">{$smarty.const.TITLE_HEADER_1}</span><span class="color2"> {$smarty.const.TITLE_HEADER_2} </span> <span class="color3">{$smarty.const.TITLE_HEADER_3}</span></p></a>
	</div>
</div>			



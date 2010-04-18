<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd" >
<HTML xmlns="http://www.w3.org/1999/xhtml" xml:lang="es" lang="es">
	<HEAD>
		<META http-equiv="Content-Type" content="text/html; charset=utf-8"/>
		<META name="keywords" content=""/>	
		<META name="author" content=""/>
		<META name="description" content=""/>            
        	
		<TITLE>gastopublico.es</TITLE>
	
		<LINK rel="favicon" href="../images/favicon.ico" >
	  <LINK rel="stylesheet" href="../stylesheets/layout.css" type="text/css" />
	

		<!--[if lt IE 7]>
		<link type='text/css' href='../stylesheets/layout_ie.css' rel='stylesheet' media='screen' />
		<![endif]-->	

		<SCRIPT type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=true"></SCRIPT>
		<SCRIPT type="text/javascript" src="http://www.google.com/jsapi"></SCRIPT> 
		<SCRIPT type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></SCRIPT>
		<SCRIPT type="text/javascript" src="../javascripts/jquery.input_prompt.js"></SCRIPT>
		<SCRIPT type="text/javascript" src="../javascripts/highcharts.js"></SCRIPT>
		<SCRIPT type="text/javascript" src="../javascripts/jquery.sparkline.min.js"></SCRIPT>
		<SCRIPT type="text/javascript" src="../javascripts/Fluster2ProjectionOverlay.js"></SCRIPT>
		<SCRIPT type="text/javascript" src="../javascripts/Fluster2ClusterMarker.js"></SCRIPT>
		<SCRIPT type="text/javascript" src="../javascripts/Fluster2Cluster.js"></SCRIPT>
		<SCRIPT type="text/javascript" src="../javascripts/Fluster2.js"></SCRIPT>
		<SCRIPT type="text/javascript" src="../javascripts/application.js"></SCRIPT>
		<SCRIPT type="text/javascript" src="../javascripts/jquery.scrollTo.js"></SCRIPT>

	</HEAD>

	<BODY>
		<div class="outer_layout_gray">
			<div class="header">
				<p class="logo"><a href="../">gastopublico.es</a></p>
				<!-- <p class="facebook">Identifícate con facebook</p> -->
			</div>
		</div>
		<div class="outer_layout_green">
			<div class="menu">
				{if $section == 'about'}
					<img src="../images/green_arrow.png" style="margin:0 0 0 154px" alt="green arrow"/>
				{else}
					<img src="../images/green_arrow.png" alt="green arrow"/>
				{/if}
				
				<ul>
					<li>
						{if $section == 'home'}						
							<a href="../home/">obras</a>
						{else}
							<a href="../home/" class="option">obras</a>
						{/if}
					</li>
					<li><a href="#" class="disabled">suministros</a></li>
					<li>
						{if $section == 'about'}
							<a href="../sobre/">sobre</a>
						{else}
							<a href="../sobre/" class="option">sobre</a>
						{/if}
					</li>
				</ul>
				{if $messageHome == 'localizated'}
					<p>¿es tu municipio <a>{$city}</a>?</p>
				{else}
					<form action="#">
						<input type="text" name="search" value="" />
						<input type="submit" value="" />
					</form>
				{/if}
			</div>
		</div>
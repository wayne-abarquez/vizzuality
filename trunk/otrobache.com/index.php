<?php

require_once("services/OtroBache.php");

$serv = new OtroBache();
$numBaches = $serv->getNumBaches();
$lastbaches = $serv->getLastBaches();

?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd" >
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta name="keywords" content="bache, carretera, arreglar, ayuntamiento, socabón">	
		<meta name="description" content="OtroBache.com">	
		<meta name="author" content="otrobache.com">
	
		<title>Otrobache.com - Reporta el tuyo!</title>
	
		<link rel="shortcut icon" href="/images/favicon.ico">
	  <link rel="stylesheet" href="/stylesheets/layout.css" type="text/css">

		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
    <script type="text/javascript" src="http://maps.google.com/maps?gwt=1&amp;file=api&amp;sensor=false&amp;v=2.x&amp;key=ABQIAAAAtDJGVn6RztUmxjnX5hMzjRRw3KWZ-x9A2HylNheByWtToULKzxSlnf4JpCGuPalF_xWQj_zXFJuCfw"></script>
    <script type="text/javascript" src="/javascript/jquery.scrollTo.js"></script>
		<script type="text/javascript" src="/javascript/init.js"></script>	
	</head>

	<body onload="initialize()" onunload="GUnload()">
		<div id="header">
			<p><a href="http://www.elpais.com/articulo/madrid/capital/bache/elpepiespmad/20100227elpmad_1/Tes" target="_blank">Un artículo de El País</a> nos impulsó a hacer esto. En madrid se realizan mas de 90 denuncia al día, sobre los socabones de la capital. Por desgracia estos datos no son públicos, y por eso queremos saber dónde y cuantos realmente hay</p>
		</div>
		
		<div id="content">
			<div id="map_canvas"></div>
			<img class="otrobache" src="../images/otrobache.png" />
			<p><span>más de <?php echo($numBaches)?> baches reportados, <a href="#" id="report_bache_map">reporta otro</a></span></p>
		</div>
		
		<div id="container">
			<div class="title">
				<h3>últimos baches reportados</h3>
				<a href="#" id="open_report">reportar un bache</a>
			</div>
			<div class="report_map">
				<a id="plus"></a>
				<a id="minus"></a>
				<span class="add">
					<form action="#" onsubmit="showAddress(this.address.value); return false">
					<input type="text" value="calle, número, localidad,..." name="address"/>
					<input type="submit" value="" />
				</span>
				<h2>Introduce la dirección en texto ó situa el bache de manera manual en el mapa</h2>
				<div id="second_map"></div>
				<p>Si tu bache ya ha sido reportardo, no te preocupes, actualizaremos su estado</p>
				<a class="report_button" id="report_bache_a"></a>
			</div>
			
			<div class="baches">
				<ul>
				    <?php
				    $count=1;
				    foreach($lastbaches as $bache) {
				        $addr=explode("|",$bache['address']);
				        if($count%3 ==1) {
				            $cl='class="first"';
				        }
				        if($count%3 ==0) {
				            $cl='class="last"';
				        }			
				        if($count%3 ==2) {
				            $cl='';
				        }				        	        
				    ?>
					<li <?php echo($cl)?>>
						<div>
							<p class="ago">reportado <strong id="num<?php echo($count)?>"><?php echo($bache['count()'])?></strong> veces</p>
							<p class="location"><?php echo($addr[0])?></p>
							<p class="number">cerca del <?php echo($addr[1])?></p>
							<p class="city"><span><?php echo($addr[2])?></span></p>
						</div>
						<a id="rep<?php echo($count)?>" onClick="confirmBache(<?php echo($bache['lat'])?>,<?php echo($bache['lon'])?>,<?php echo($count)?>)"></a>
					</li>
					<?php
				        $count++;
			        }
				    
				    ?>
				</ul>
			</div>

			
			<p>
				<a class="view_more" href="#">ver más baches</a>
			</p>
			<p class="report">
				<a class="report" href="#" id="report_bache_button">o reporta uno nuevo</a>
			</p>
		</div>
		
		<div id="footer">
			<div class="iphone">
					<div class="data">
					<h2>¿Has visto nuestra aplicación iPhone?</h2>
					<p>Descarga nuestra aplicación gratuita en tu iPhone para
						reportar los baches de madrid a medida que los vas
						descubriendo.</p>
					<a href="#"></a>
				</div>
			</div>
			<p><u>otrobache.com</u> es un proyecto de <a href="http://www.vizzuality.com" target="_blank">vizzuality</a>. No nos hacemos responsables de la veracidad de los datos</p>
		</div>
	</body>
</html>
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
        <script type="text/javascript" src="http://maps.google.com/maps?gwt=1&amp;file=api&amp;sensor=false&amp;v=2.x&amp;key=ABQIAAAAtDJGVn6RztUmxjnX5hMzjRRw3KWZ-x9A2HylNheByWtToULKzxSlnf4JpCGuPalF_xWQj_zXFJuCfw">
    <script type="text/javascript" src="/javascript/init.js"></script>	
    <script type="text/javascript">
		
		
		function initialize() {
			var second_map_height = $('div#container div.report_map').height();
			$('div#container div.report_map').height(0);
			$('#open_report').click (function(ev) {
				ev.preventDefault();
				ev.stopPropagation();
				if ($(this).html()=='reportar un bache') {
					$(this).html('ocultar reporte');
					$('div#container div.report_map').css('padding-bottom','17px');
					$('div#container div.report_map').css('border-bottom','1px solid #c2c2c2');
					$('div#container div.report_map').stop().animate({
					    height: second_map_height
					  }, 500);
				} else {
					$(this).html('reportar un bache');
					$('div#container div.report_map').stop().animate({
					    height: 0
					  }, 500,function() {
							$('div#container div.report_map').css('padding-bottom','0');
							$('div#container div.report_map').css('border-bottom','none');
					});
				}
			});
			      
			if (GBrowserIsCompatible()) {

          var options = {

          onIdleCallback : function() { alert("search control is idle");},
          onGenerateMarkerHtmlCallback : function(marker, div, result) { div.innerHTML = "<input type='button' value='Anadir este bache' />"; return div; },
          searchFormHint : "busca direccion"
          };      

        var map = new GMap2(document.getElementById("map_canvas"),{googleBarOptions: options});
				var map2 = new GMap2(document.getElementById("second_map"));
				
        map.setCenter(new google.maps.LatLng(40.4392758681028,-3.7121450901031494),12);
				map2.setCenter(new google.maps.LatLng(40.4392758681028,-3.7121450901031494),12);
				
        var l = new GLayer("ft:136993");
        l.setParameter("h", "true");
        l.setParameter("s", "select+address+from+136993");

        map.addOverlay(l);
        //map.setUIToDefault();
        map.enableScrollWheelZoom();
        map.addControl(new GMapTypeControl());
        //map.addControl(new GLargeMapControl());
        //map.setUIToDefault();


        //map.enableGoogleBar();

      }
    }
    
    
    function confirmBache(lat,lon,id) {
        //http://localhost/
        $.ajax({ url: "amfphp/json.php/OtroBache.reportBache/"+lat+"/"+lon+"/web/1/1/null", context: document.body, success: function(){
                //$("#rep"+id).text("reportado");
                $("#rep"+id).addClass("done");
              }});
    }
    </script>	
	</head>

	<body onload="initialize()" onunload="GUnload()">
		<div id="header">
			<p><a href="#">Un artículo de El País</a> nos impulsó a hacer esto. En madrid se realizan mas de 90 denuncia al día, sobre los socabones de la capital. Por desgracia estos datos no son públicos, y por eso queremos saber dónde y cuantos realmente hay</p>
		</div>
		
		<div id="content">
			<div id="map_canvas"></div>
			<img class="otrobache" src="../images/otrobache.png" />
			<p><span>más de <?php echo($numBaches)?> baches reportados, <a href="#">reporta uno</a></span></p>
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
					<input type="text" value="calle, número, localidad,..."/>
					<a class="add_new"></a>
				</span>
				<h2>Introduce la dirección en texto ó situa el bache de manera manual en el mapa</h2>
				<div id="second_map"></div>
				<p>Si tu bache ya ha sido reportardo, no te preocupes, actualizaremos su estado</p>
				<a class="report_button"></a>
			</div>
			
			<div class="baches">
				<ul>
				    <?php
				    $count=0;
				    foreach($lastbaches as $bache) {
				        $addr=explode("|",$bache['address']);
				        if($count%3 ==1) {
				            $cl='class="first"';
				        }
				        if($count%3 ==0) {
				            $cl='class="last"';
				        }				        
				    ?>
					<li <?php echo($cl)?>>
						<div>
							<p class="ago">reportado el <?php echo($bache['reported_date'])?> desde <?php echo($bache['reported_by'])?></p>
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
				<a class="report" href="#">o reporta uno nuevo</a>
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
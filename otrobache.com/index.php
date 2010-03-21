<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd" >
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta name="keywords" content="bache,carretera, arreglar, ayuntamiento, socabón">	
		<meta name="description" content="OtroBache.com">	
		<meta name="author" content="otrobache.com">
	
		<title>Otrobache.com - Reporta el tuyo!</title>
	
		<link rel="shortcut icon" href="/images/favicon.ico">
	  <link rel="stylesheet" href="/stylesheets/layout.css" type="text/css">

		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
        <script type="text/javascript" src="http://maps.google.com/maps?gwt=1&amp;file=api&amp;sensor=false&amp;v=2.x&amp;key=ABQIAAAAtDJGVn6RztUmxjnX5hMzjRQbotjeVUwZe96Bn7L2MEyZ6pftAxRtcuen6T4sYnXsSUQ0C78UJslfeA">
    <script type="text/javascript" src="/javascript/init.js"></script>	
    <script type="text/javascript">
    function initialize() {
      if (GBrowserIsCompatible()) {

          var options = {

          onIdleCallback : function() { alert("search control is idle");},
          onGenerateMarkerHtmlCallback : function(marker, div, result) { div.innerHTML = "<input type='button' value='Anadir este bache' />"; return div; },
          searchFormHint : "busca direccion"
          };      

        var map = new GMap2(document.getElementById("map_canvas"),{googleBarOptions: options});
        map.setCenter(new google.maps.LatLng(40.4392758681028,-3.7121450901031494),12);
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
    </script>	
	</head>

	<body onload="initialize()" onunload="GUnload()">
		<div id="header">
			<p><a href="#">Un artículo de El País</a> nos impulsó a hacer esto. En madrid se realizan mas de 90 denuncia al día, sobre los socabones de la capital. Por desgracia estos datos no son públicos, y por eso queremos saber dónde y cuantos realmente hay</p>
		</div>
		
		<div id="content">
			<div id="map_canvas"></div>
			<img class="otrobache" src="../images/otrobache.png" />
			<p><span>más de 567.123 baches reportados, <a href="#">reporta uno</a></span></p>
		</div>
		
		<div id="container">
			<div class="title">
				<h3>últimos baches reportados</h3>
				<a href="#">reportar un bache</a>
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
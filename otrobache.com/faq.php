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
	
		<!-- IE 6 "fixes" -->
		<!--[if lt IE 7]>
		<link type='text/css' href='css/layout_ie.css' rel='stylesheet' media='screen' />
		<![endif]-->	
	</head>

	<body>
		
		<div id="header">
			<div>
				<p><a href="http://www.elpais.com/articulo/madrid/capital/bache/elpepiespmad/20100227elpmad_1/Tes" target="_blank">Un artículo de El País</a> nos impulsó a hacer esto. En madrid se realizan mas de 90 denuncias al día, sobre los socabones de la capital. Por desgracia estos datos no son públicos, y por eso queremos saber dónde y cuantos realmente hay</p>
				<img src="../images/header_arrow.png" class="header_arrow" />
			</div>
		</div>
		
		<div id="container_faq">
			<div class="faq">
				<div class="question">
					<p>¿Cómo nace otrobache.com?</p>
				</div>
				<div class="answer">
					<p>Nos gusta experimentar y llevar ideas a cabo. Nos interesa el e-government y el movimiento opendata. Nos gusta utilizar lo que internet ofrece y hacer pequeñas aplicaciones y mashups que implementen nuevas tecnologías.</p>
					<p>Así nace el proyecto.</p>
				</div>
			</div>
			
			<div class="faq">
				<div class="question">
					<p>¿Qué se considera un bache?</p>
				</div>
				<div class="answer">
					<p>Para nosotros un bache es cualquier irregularidad en el terreno, que se supone, debe ser llano, y no lo es.</p>
					<p>	
					Guardamos los baches en la base de datos hasta <b>3 meses</b> (tiempo medio que el Ayto. de Madrid asegura tardar en arreglarlos) <b>desde la última vez que se reporta.</b> Si se reportan varios baches en un radio menor a 15 metros, los agruparemos en uno mismo - por simplificación</p>
				</div>
			</div>	

			<div class="faq">
					<div class="question">
						<p>¿Qué aspiraciones tiene el proyecto?</p>
					</div>
					<div class="answer">
						<p>Constituir una fuente de datos transparente y actualizada sobre el estado actual de la vía pública y ser el germen del posible open311.org español.</p>
					</div>
			</div>
			
			<div class="faq">
					<div class="question">
						<p>Y...¿Qué tiene de nuevo?</p>
					</div>
					<div class="answer">
						<p>La utilización de <a href="http://tables.googlelabs.com/">google Fusion Tables</a>  y la creación de una API (será accesible en breve) para posibilitar la utilización de los datos desde aplicaciones de terceros. Además, la creación de aplicaciones para Android, iPhone y Blackberry para facilitar el crecimiento y la mejora de los datos sobre baches.</p>
					</div>
			</div>
			<div class="faq">
					<div class="question">
						<p>¿Quién esta detrás del proyecto?</p>
					</div>
					<div class="answer">
						<p>otrobache.com es un proyecto creado por <a href="http://www.vizzuality.com" target="_blank">vizzuality.</a></p>
					</div>
			</div>
						
			
		
		</div>
		
		<div id="footer">
				
			<p>otrobache.com es un proyecto de <a href="http://www.vizzuality.com">vizzuality</a>. No nos hacemos responsables de la veracidad de los datos | <a href="/" class="faq">HOME</a> |
				<a class="twitter" href="http://twitter.com/home?status=http://otrobache.com"></a>
				<a class="facebook" href="http://www.facebook.com/share.php?u=http://otrobache.com"></a>
				<a class="del" href="http://del.icio.us/post?title=&url=http://otrobache.com"></a>					
				<a class="digg" href="http://digg.com/submit?phase=2&url=http://otrobache.com"></a>
			</p>
					
		</div>
		<script type="text/javascript">
		  var uservoiceOptions = {
		    key: 'otrobache',
		    host: 'otrobache.uservoice.com', 
		    forum: '47265',
		    alignment: 'left',
		    background_color:'#333333', 
		    text_color: 'white',
		    hover_color: '#ff9900',
		    lang: 'es',
		    showTab: true
		  };
		  function _loadUserVoice() {
		    var s = document.createElement('script');
		    s.src = ("https:" == document.location.protocol ? "https://" : "http://") + "uservoice.com/javascripts/widgets/tab.js";
		    document.getElementsByTagName('head')[0].appendChild(s);
		  }
		  _loadSuper = window.onload;
		  window.onload = (typeof window.onload != 'function') ? _loadUserVoice : function() { _loadSuper(); _loadUserVoice(); };
		</script>
		
	</body>
	
	<script type="text/javascript">
	var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
	document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
	</script>
	<script type="text/javascript">
	try {
	var pageTracker = _gat._getTracker("UA-15393779-1");
	pageTracker._trackPageview();
	} catch(err) {}</script>
	

</html>
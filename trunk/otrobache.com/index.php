<?php

require_once("services/OtroBache.php");

$serv = new OtroBache();



if(isset($_REQUEST['locality'])) {
    $locality=$_REQUEST['locality'];
    $coords = $serv->getLocalityCoords($locality);
    $localityName=$coords["name"];
    $bbox=$coords['bbox'];
    $swLat=$bbox['south'];
    $swLon=$bbox['west'];
    $neLat=$bbox['north'];
    $neLon=$bbox['east'];    
    $numBaches = $serv->getNumBaches(strtolower($localityName));
    //$numBachesLocality = $serv->getNumBaches(strtolower($locality));
    $lastbaches = $serv->getLastBaches(strtolower($localityName));
    $cities = array();
    $url=urlencode("http://otrobache.com/en/".$locality);
} else {
    $loc=$serv->visitorLocation();

    
    //redirect to the city
    //header( 'Location: http://otrobache.com/en/'.$loc['city'] ) ;
    //die();
    
    $latCenter = $loc['lat'];
    $lonCenter = $loc['lon']; 
    $swLat=35.639441068973916;
    $swLon=-18.9404296875;
    $neLat=47.84265762816538;
    $neLon=11.77734375;
    $locality=null;
    $localityName="España";
    $numBaches = $serv->getNumBaches();
    $lastbaches = $serv->getLastBaches();    
    $cities = $serv->getCities();
    $url=urlencode("http://otrobache.com/");
}


function shortenText($text,$num=25) { 
    if(strlen($text)>$num) {
       // Change to the number of characters you want to display 
       $chars = $num; 
       $text = $text." "; 
       $text = substr($text,0,$chars); 
       $text = substr($text,0,strrpos($text,' ')); 
       $text = $text."...";        
    }
    return $text; 
}

?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd" >
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta name="keywords" content="bache, carretera, arreglar, ayuntamiento, socabón">	
		
		
		<meta name="author" content="otrobache.com">
		
		<?php if(isset($_REQUEST['address'])) {?>
		<meta name="title" content="Nuevo bache en <?php echo($_REQUEST['address']) ?>" />
        <meta name="description" content="¿No estas harto de los baches en tu ciudad? Mira este en <?php echo($_REQUEST['address']) ?> y reporta el tuyo." />
        <link rel="image_src" href="http://maps.google.com/maps/api/staticmap?size=130x110&sensor=false&markers=size:mid|color:red|<?php echo(urlencode($_REQUEST['address'])) ?>" />
        <?php } else { ?>
    		<meta name="description" content="OtroBache es una iniciativa para reportar los baches en tu ciudad. Busca en el mapa la direccion y envia el bache. Pronto podras realizar a traves de tu Iphone, Android o Blackberry.">            
        <?php } ?>
	
		<title>Otrobache.com - Reporta baches en <?php if($locality!=null) {echo($localityName);}else{echo("España");}?></title>
	
		<link rel="shortcut icon" href="/images/favicon.ico" >
	  <link rel="stylesheet" href="/stylesheets/layout.css" type="text/css" />
		
	
		<!-- IE 6 "fixes" -->
		<!--[if lt IE 7]>
		<link type='text/css' href='css/layout_ie.css' rel='stylesheet' media='screen' />
		<![endif]-->	

		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
    <script type="text/javascript" src="http://maps.google.com/maps?gwt=1&amp;file=api&amp;sensor=false&amp;v=2.x&amp;key=ABQIAAAAtDJGVn6RztUmxjnX5hMzjRRw3KWZ-x9A2HylNheByWtToULKzxSlnf4JpCGuPalF_xWQj_zXFJuCfw"></script>
    <script type="text/javascript" src="/javascript/jquery.scrollTo.js"></script>
		<script type="text/javascript" src="/javascript/jquery.simplemodal.js"></script>
		<script type="text/javascript" src="/javascript/init.js"></script>	
	</head>


	<body onload="initialize(<?php echo("$swLat,$swLon,$neLat,$neLon,'$localityName'") ?>)" onunload="GUnload()">
		
		<div id="iphone_modal">
			<h4>Estamos en fase beta</h4>
			<p>Estamos probando nuestra aplicación iphone. Hasta que podamos lanzarla, sólo <br>
			podremos distribuir 100 copias para 100 usuarios únicos.</p>
			<p class="distribute">Pidenos tu copia haciendo <a href="mailto:otrobache@gmail.com">click aquí</a>.</p>
			<p class="thanks">Gracias!</p>
		</div>
		
		<div id="android_modal">
			<h4>Estamos en fase beta</h4>
			<p>Estamos probando nuestra aplicación android. Hasta que podamos lanzarla, sólo <br>
			nos gustaría distribuir 100 copias para 100 usuarios únicos.</p>
			<p class="distribute">Pidenos tu copia haciendo <a href="mailto:otrobache@gmail.com">click aquí</a>.</p>
			<p class="thanks">Gracias!</p>
		</div>
		
		<div id="error_map">
			<h4>Ha ocurrido un error</h4>
			<p>Comprueba que la dirección que has introducido es correcta, <br>
				parece que no hemos encontrado nada en ese punto. </p>
			<p class="cerrar">Para cerrar esta ventana pulsa <i>Esc</i></p>
		</div>
		
		<div id="header">
			<div>
				<p><a href="http://www.elpais.com/articulo/madrid/capital/bache/elpepiespmad/20100227elpmad_1/Tes" target="_blank">Un artículo de El País</a> nos impulsó a hacer esto. En Madrid se realizan mas de 90 denuncias al día, sobre los socavones de la capital. Por desgracia estos datos no son públicos, y por eso queremos saber dónde y cuantos realmente hay... <a href="/sobre">leer más sobre el proyecto</a></p>
				<img src="../images/header_arrow.png" class="header_arrow" />
			</div>
		</div>
		
		<div id="content">
			<div id="map_canvas"></div>
			<img class="otrobache" src="../images/otrobache.png" />
			<p><span><?php echo($numBaches)?> baches reportados, <a href="#" id="report_bache_map">reporta otro</a></span></p>
		</div>
		
		<div id="container">
			<div class="title">
			    <?php if(count($lastbaches)>0) {?>
				<h3>últimos baches reportados <?php if($locality!=null){echo("en $localityName");} ?></h3>
				<?php } else {?>
				<h3>No hay baches reportados <?php if($locality!=null){echo("en $localityName");} ?></h3>
				<?php }?>    
				<a href="#" id="open_report">reportar un bache</a>
			</div>
			<div class="report_map">
				<div class="first_launch">
					<a id="plus"></a>
					<a id="minus"></a>
					<span class="add">
						<form action="#" onsubmit="showAddress(this.address.value); return false">
							<input type="text" value="calle, número, localidad,..." name="address"/>
							<input type="submit" value="" />
						</form>
					</span>
					<h2>Introduce la dirección en texto o situa el bache de manera manual en el mapa</h2>
					<div id="second_map"></div>
					<p>Si tu bache ya ha sido reportardo, no te preocupes, actualizaremos su estado</p>
					<a class="report_button" id="report_bache_a" onclick="pageTracker._trackEvent('Crear', 'Click');"></a>
				</div>
			</div>
			
			<div class="baches">
			    <?php if(count($lastbaches)>0) {?>
				<ul>
				    <?php
				    $count=1;
				    foreach($lastbaches as $bache) {
				        $addr=explode("|",$bache['addressline']);
						
						
						$calle=$addr[0];
						
						if ($calle == '')
							$calle = "-";
						
				        if(count($addr)>1) {
				            $num="cerca del ".$addr[1];
				        } else {
				            $num= "S/N";
				        }
				        
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
					<li <?php echo($cl)?> id="item<?php echo($count)?>">
						<div>
							<p class="ago">reportado <strong id="num<?php echo($count)?>"><?php echo($bache['count()'])?></strong> veces</p>
							<p class="location"><?php echo(shortenText($calle))?></p>
							<p class="number"><?php echo(shortenText($num))?></p>
							<p class="city"><span><?php echo($bache['zip'])?> <?php echo(shortenText($bache['city'],24))?></span></p>
						</div>
						<a id="rep<?php echo($count)?>" href="javascript: void getConfirmation(<?php echo($bache['lat'])?>,<?php echo($bache['lon'])?>,<?php echo($count)?>)" onclick="pageTracker._trackEvent('Confirmar', 'Click');"></a>
					</li>
					<?php
				        $count++;
			        }
				    
				    ?>
				</ul>
				<?php }?>    
			</div>

			
			<p class="visualize">
				<!-- <a class="view_more" href="#">ver más baches</a> -->
				Se visualizarán los últimos 15 baches
			</p>
			<p class="report">
				<a class="report" href="#" id="report_bache_button">reporta un nuevo bache</a>
			</p>
		</div>
		
		<div id="footer">
			<div class="iphone">
					<div class="data">
					<h2>¿Has visto nuestras aplicaciones para móviles?</h2>
					<p>Estamos probando nuestras aplicaciones para móviles.
					Si eres usuario de iphone/android descarga aquí 
					el reporta baches.</p>
					<a href="javascript: void $('#android_modal').modal()" class="android"></a>
					<a href="javascript: void $('#iphone_modal').modal()" class="iphone"></a>
				</div>
			</div>
			<?php if(count($cities)>0) {?>
			    <p class="title">Otrosbaches en:</p>
					<p class="cities">
							<?php $cities_count = count($cities) ?>
							<?php $cities_ext = 0 ?>
			        <?php foreach($cities as $city) {?>
			        	<a href="/en/<?php echo($city['city'])?>"><?php echo($city['city']." (".$city['count()'].")")?></a>
			 					<?php if ($cities_count-1!=$cities_ext) {?>| <?php } ?>
			        	<?php $cities_ext++ ?>
							<?php }?>
			    </p> 
			<?php }?>
			   
			<p>otrobache.com es un proyecto de <a href="http://www.vizzuality.com" target="_blank">vizzuality</a>. No nos hacemos responsables de la veracidad de los datos | <a href="/sobre" class="faq">FAQ</a> |
				<a class="twitter" href="http://twitter.com/home?status=<?php echo($url) ?>" target="_blank"></a>
				<a class="facebook" href="http://www.facebook.com/share.php?u=<?php echo($url) ?>" target="_blank"></a>
				<a class="del" href="http://del.icio.us/post?title=&url=<?php echo($url) ?>" target="_blank"></a>					
				<a class="digg" href="http://digg.com/submit?phase=2&url=<?php echo($url) ?>" target="_blank"></a>
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
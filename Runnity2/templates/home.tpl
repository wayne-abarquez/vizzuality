{include file="header.tpl"}

<div class="span-24">
<div class="span-1 column mapTop"></div>
<div class="span-1 column map">
	<div id="runnityHomeMap">
	<object id="flashMovie" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="894" height="364" wmode="opaque">
		<param name="movie" value="/flash/runnitHomeMap.swf?6" />
		<!--[if !IE]>-->
		<object type="application/x-shockwave-flash" data="/flash/runnitHomeMap.swf?6" width="894" height="364" wmode="opaque">
		<!--<![endif]-->
		<h1>Necesitas Flash para poder ver el mapa</h1>
		<p><a href="http://www.adobe.com/go/getflashplayer"><img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" /></a></p>
		<!--[if !IE]>-->
		</object>
		<!--<![endif]-->
    </object>
</div>
</div>
<div class="span-1 column mapBottom"></div>
</div>

<div class="span-24 column content">

	<!-- LEFT COLUMN -->
	<div class="span-1 last leftColumnHome">
	
		<div class="span-1 last column1">
		<p class="titulo">PRÓXIMAS CARRERAS CERCA DE TI</p>
			{foreach key=id item=race from=$nextRaces name=raceloop}
				{if $race eq "false"}
<!-- 						<div class="carrera">No hay próximas carreras.</div>  -->
				{else}
					<div class="span-1 {cycle values="carrera,carrera2"}">
						<div class="span-1 avatar2"><img src="/img/avatar2.jpg" class="avatar"></div>
						<div class="span-1 Race">
							<p class="span-4 nameRace"><a id="carrera{$smarty.foreach.raceloop.iteration}" 
							href="/run/{$race.id}/{$race.name|replace:' ':'/'}">{$race.name}</a></p>
							<p class="span-4 infoRace" id="iteracion{$smarty.foreach.raceloop.iteration}">
							<b>{$race.event_date|substr:8:2}/{getMonth month=$race.event_date|substr:5:2}/{$race.event_date|substr:2:2}</b> / 													{$race.distance_text}</p>
							<p class="span-4 placeRace">{$race.province_name} - {$race.event_location}</p>
						</div>
						{if $race.num_users > 0}
							<div class="ticketBlue"><p>{$race.num_users}</p></div>
						{/if}
					</div>
					{if $smarty.foreach.raceloop.iteration < 3}
						<div class="span-1 last separator"></div>
					{/if}
				{/if}
			{foreachelse}
<!-- 					<div class="carrera">No hay próximas carreras.</div>  -->
    		{/foreach}	
			<a class="verTodas" href="/buscar"><b>Ver todas las carreras en {$city}</b></a>
		</div>
		
		<div class="span-1 last column2">
			<p class="titulo">ACTIVIDAD RECIENTE</p>
			<div class="carrera">
				<div class="span-1 avatar2"><img src="/img/avatar2.jpg" class="avatar"></div>
				<div class="span-1 Race">
					<p class="span-4 nameRace"><a href="#">XVIII Carrera popular “La Melonera”</a></p>
					<p class="span-4 recentActivity"><img src="/img/note.gif"/> Recorrido añadido</p>
				</div>
				<div class="ticketBlue"><p>3</p></div>
			</div>
			<div class="separator"></div>
			<div class="carrera2">
				<div class="span-1 avatar2"><img src="/img/avatar2.jpg" class="avatar"></div>
				<div class="span-1 Race">
					<p class="span-4 nameRace"><a href="#">XVIII Carrera popular “La Melonera”</a></p>
					<p class="span-4 recentActivity"><img src="/img/note.gif"/> Recorrido añadido</p>
				</div>
				
				<div class="ticketBlue"><p>3</p></div>
			</div>
			<div class="separator"></div>
			<div class="carrera">
				<div class="span-1 avatar2"><img src="/img/avatar2.jpg" class="avatar"></div>
				<div class="span-1 Race">
					<p class="span-4 nameRace"><a href="#">XVIII Carrera popular “La Melonera”</a></p>
					<p class="span-4 recentActivity"><img src="/img/note.gif"/> Recorrido añadido</p>
				</div>
				<div class="ticketBlue"><p>3</p></div>
			</div>
		</div>
	</div>
	
	<!-- RIGHT COLUMN -->
	<div class="span-1 last rightColumnHome">
<!-- 	<div class="carrera">No hay próximas carreras destacadas.</div>  -->
		<p class="titulo titulOrange">CARRERAS DESTACADAS</p>
		{foreach key=id item=VipRace from=$nextImportantRaces name=raceloop}
		<div class="carreraOrange">
			<div class="span-1 avatar2Orange"><img src="/img/avatar2.jpg" class="avatarOrange"></div>
			<div class="span-1 Race">
				<p class="nameRaceOrange"><a id="carrera{$smarty.foreach.raceloop.iteration}" 
							href="/run/{$VipRace.id}/{$VipRace.name|replace:' ':'/'}">{$VipRace.name}</a></p>
				<p class="span-4 infoRaceOrange" id="iteracion{$smarty.foreach.raceloop.iteration}"><b>{$VipRace.event_date|substr:8:2}/{getMonth month=$VipRace.event_date|substr:5:2}/{$VipRace.event_date|substr:2:2}</b> / {$race.distance_text}</p>
				<p class="span-4 placeRaceOrange">{$VipRace.event_location}</p>
			</div>
		{if $smarty.foreach.raceloop.iteration < 3}
			<div class="span-1 last separatorRightOrange"></div>
		{/if}
		</div>
		{foreachelse}
<!-- 	<div class="carrera">No hay próximas carreras destacadas.</div>  -->
    	{/foreach}
	</div>
	
</div> <!-- content -->

</div> <!-- container -->

<div class="bannerTop"></div>
<div class="banner">
	<div class="titular">
		<div class="span-1 titularColumn">
			<p class="titularTitle titularTitleFirst">ENTÉRATE Y PLANEA</p>
			<p class="titularInfo">Obtén la mejor información de los eventos que están por venir; Recorridos, mapas, altimetrías, fotos, comentarios, ediciones pasadas...</p>	
			<br>
			<a href="">Mira una carrera de ejemplo</a>
		</div>
		<div class="span-1 titularColumn titularColumn2">
			<p class="titularTitle">DISFRUTA LA CARRERA</p>
			<p class="titularInfo titularInfo2">Esperamos que con nuestra ayuda no te falte nada para que la carrera salga como esperas.</p>
			<p class="titularInfo titularInfo2">Disfrútala al máximo y cuéntanos qué tal.</p>
		</div>
		<div class="span-1 titularColumn titularColumn2">
			<p class="titularTitle">VUELVE Y COMÉNTALO</p>
			<p class="titularInfo titularInfo2">¡Sube tus fotos, tus tiempos, clasificaciones y haz de Runnity un sitio cada vez mejor y más completo!</p>
			<br><br>
			<a href="">Regístrate y participa</a>
		</div>
	</div>
</div>

<div class="container">
	<div class="span-1 column ColumnHome">
		<div class="span-1 last columnLong">
			<p class="titulo">RUNNITY EN LA WEB</p>
			<div class="column span-3 first">
				<a href="http://www.tuenti.com/#m=Photo&func=view_photo&collection_key=1-66022443-567658561-66022443" target="_blank">
					<img src="/img/tuenti.jpg" alt="socialNetworks"/>
				</a>
			</div>
			<div class="column span-3">
				<a href="http://www.facebook.com/home.php?#/group.php?gid=158141673184&ref=ts" target="_blank">
					<img src="/img/facebook.jpg" alt="socialNetworks"/>
				</a>
			</div>
			<div class="column span-4 last">
				<a href="http://twitter.com/runnity" target="_blank">
					<img src="/img/twitter.jpg" alt="socialNetworks"/>
				</a>
			</div>
			<div class="column span-3 last">
				<a href="http://www.flickr.com/groups/1188628@N20/" target="_blank">
					<img src="/img/flickr.jpg" alt="socialNetworks"/>
				</a>
			</div>
		</div>
		<div class="span-1 last columnSort">
			<p class="titulo tituloRight">RUNNITY EN TWITTER</p>
				<div class="span-3 tweet last">
				<a id="tweets" href="http://twitter.com/runnity" target="_blank"></a>
				<p id="tweetsTime"></p>
				</div>
		</div>
	</div>

</div>
	
	<!-- SCRIPT TWITTER -->
	
	{literal}
	<script language="javaScript" type="text/javascript">
		$(document).ready( function() {
	
			/*$('textarea').autoResize({
			    // On resize:
			    onResize : function() {
			        $(this).css({opacity:0.8});
			    },
			    // After resize:
			    animateCallback : function() {
			        $(this).css({opacity:1});
			    },
			    // Quite slow animation:
			    animateDuration : 300,
			    // More extra space:
			    extraSpace : 40
			});
*/
			 
		
			var url = "http://twitter.com/status/user_timeline/runnity.json?count=1&callback=?";
			$.getJSON(url,function(data){	
				$.each(data, function(i, item) {
					$("#tweets").append( item.text.linkify());
					$("#tweetsTime").append(relative_time(item.created_at));
				});
		    });
		    
		    for (i=1;i<=6;i++){
				var len = 40;
				var p = document.getElementById("iteracion" + i);
				
				if (p) {
				  var trunc = p.innerHTML;
				  trunc = trunc.replace(/\t/g, "");
				  if (trunc.length > len) {
		
				    trunc = trunc.substring(0, len);
				    /* trunc = trunc.replace(/\w+$/, ''); */
				
				    /* Add an ellipses to the end and make it a link that expands
				       the paragraph back to its original size */
				    trunc += '<a style="color: #666666;">' +
				      '...<\/a>';
				    p.innerHTML = trunc;
				  }
				}
				
				var len = 43;
				var x = document.getElementById("carrera" + i);
				if (x) {
				  var trunc = x.innerHTML;
				  trunc = trunc.replace(/\t/g, "");
				  trunc = trunc.replace(/\n/g, "");
				  				  
				  if (trunc.length > len) {
					
					trunc = trunc.substring(0, len);
				    trunc = trunc.replace(/\w+$/, '');
				
				    /* Add an ellipses to the end and make it a link that expands
				       the paragraph back to its original size */
				    trunc += '<a style="color: #666666;">' +
				      '...<\/a>';
				    x.innerHTML = trunc;
				  }
				}
			}
		    
		    
		});
	</script>
	{/literal}
	
	
	{literal}
	<script language="javaScript" type="text/javascript">
		String.prototype.linkify = function() {
			return this.replace(/[A-Za-z]+:\/\/[A-Za-z0-9-_]+\.[A-Za-z0-9-_:%&\?\/.=]+/, function(m) {
				return m.link(m);
			});
		}; 
	</script>
	{/literal}
	
	
	
	{literal}
	<script language="javaScript" type="text/javascript">
		function twitter_callback (){
			return true;
		}
	</script>
	{/literal}

{include file="footer.tpl"} 
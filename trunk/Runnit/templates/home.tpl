{include file="header.tpl"} 

<script type="text/javascript" src="js/swfobject.js"></script>
{literal}
<script type="text/javascript">
swfobject.registerObject("flashMovie", "9.0.115", "expressInstall.swf");
</script>

<style type="text/css">
    html, body, #container, #race, #runnityHomeMap  {width: 100%;height: 100%;}  
</style>
{/literal}
<!-- IMPORTANT RACE AND NEXT RACES -->
	<div class="span-24 raceContainer" id="race">
		<div class="span-24 title">
			<p class="titlePage">Runnity es un punto de encuentro entre <b><a href="searchresults.php">carreras</a></b> y <b>atletas.</b></p>
			<p class="subtitlePage"><b>Utiliza el mapa, <a href="searchresults.php">busca</a>, o <a href="javascript: void showRegisterBox()">regístrate</a> </b> para recibir alertas vía e-mail de las próximas carreras cerca de dónde vives</p>
		</div>
		<div class="span-24 map" id="runnityHomeMap">
            <object id="flashMovie" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="939" height="364">
              <param name="movie" value="flash/runnitHomeMap.swf" />
              <!--[if !IE]>-->
              <object type="application/x-shockwave-flash" data="flash/runnitHomeMap.swf" width="939" height="364">
              <!--<![endif]-->
                <h1>Necesitas Flash para poder ver el mapa</h1>
    			<p><a href="http://www.adobe.com/go/getflashplayer"><img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" /></a></p>
              <!--[if !IE]>-->
              </object>
              <!--<![endif]-->
            </object>		    		
		</div>
	</div>	
	<!-- MORE RACES -->
	<div class="column first span-16 moreRaces">
		<div> 
			<div>
				<h2 class="column span-16 first newsTitle">
					<div class="first span-11">
						<div class="column first">Más carreras en {$city}, <a href="/searchresults.php" class="seeAll">ver todas.</a></div>
					</div>
					<div class=" last span-5 feed">
						<div class="column fisrt span-4 feedText"><a href="/rss.php">subscribete</a></div>
						<div class="column span-1 imgFeed last">
							<a href="/rss.php"><img src="/img/feed.jpg" alt="Feed"/></a>
						</div>
					</div>
				</h2>
			</div>		
		</div>
		{foreach key=id item=race from=$nextRaces}
			{if $race eq "false"}
				<div class="span-16">No hay proximas carreras.</div> 
			{else}
				{if $smarty.section.race.iteration is not even}
					<div class="column span-8 first races">
						<div class="column first image">
							<img src="media/run/{$race.thumbnail}" alt="Foto de la carrera {$race.name}"/>	
						</div>
						<div class="column span-5 last">
							<div class="nameRaceContainer"><a class="nameRace" href="carrera.php?id={$race.id}">{$race.name}</a></div>
							<div class="raceDateDetails">
								<div class="raceDetailsStyle"> 
									<b>{$race.event_date|substr:8:2}/{getMonth month=$race.event_date|substr:5:2}/{$race.event_date|substr:2:2}</b> | {$race.province_name} | {$race.event_location}
								</div>
								<p class="runnersNumber">{$race.num_users} van</p>
							</div>
						</div>
					</div>			
				{else}
					<div class="column span-8 last races">
						<div class="column first image">
							<img src="media/run/{$race.thumbnail}" alt="Foto de la carrera {$race.name}"/>	
						</div>
						<div class="column span-5 last">
							<div class="nameRaceContainer"><a class="nameRace" href="carrera.php?id={$race.id}">{$race.name}</a></div>
							<div class="raceDateDetails">
								<div class="raceDetailsStyle"> 
									<b>{$race.event_date|substr:8:2}/{getMonth month=$race.event_date|substr:5:2}/{$race.event_date|substr:2:2}</b> | {$race.province_name} | {$race.event_location}
								</div>
								<p class="runnersNumber">{$race.num_users} van</p>
							</div>
						</div>
					</div>	
				{/if}	
			{/if}
	    {foreachelse}
	        <div class="span-8 races">No hay proximas carreras.</div> 
	    {/foreach}			
		
	</div>
	
	
	<!-- USERS -->	
	<div class="column last span-8 moreRaces">
		<div> 
			<h2 class="newsTitle">Últimos valientes</h2>
		</div>
			{foreach key=id item=person from=$runners}
				{if $person eq 'f'}
					<div class="span-8 races">No hay valientes.</div> 
				{else}
					<div class="span-8 races">
						<div class="column first image">
							<img src="media/avatar/{$person.avatar}" alt="userImage"/>	
						</div>
						<div class="column span-5 last">
							<div class="detailsUser">
								<div class="nameUser"><a class="nameRace" href="#">{$person.username}</a></div>
								<div class="raceUserDetails"> dice que va a ir a </div>
								<div class="raceUserDetails"><a href="carrera.php?id={$person.run_id}"><b>{$person.run_name}</b></a></div>
							</div>
							<p class="runnersNumber">{$person.num_participants} van, <a href="">apúntate con él</a></p>
						</div>
					</div>
				{/if}
		    {foreachelse}
		        <div class="span-8 races">No hay valientes.</div>    
		    {/foreach}
		</div>
		
		
	<!-- PROMINENT -->
	<div class="span-24 prominent">
		
		<div class="column span-8 first">
			<div class="titleImportant">AL FÍN UN MODO DE VER CON DETALLE LOS RECORRIDOS DE LAS CARRERAS MEDIANTE GOOGLE MAPS</div>
			<div class="contentImportant">Además podrás comentar las distintas pruebas y conocer las opiniones de los demás.</div>
			<div class="buttonImportant"><input class="fg-button ui-state-default ui-corner-all" type="submit" value="Mira un ejemplo de carrera" onclick="location.href='carrera.php?id=22'"/></div>
		</div>
		
		
		<div class="column span-8">
			<div class="titleImportant">CREA Y COMPARTE TU PROPIO CALENDARIO DE CARRERAS. ES GRATIS, FÁCIL Y RÁPIDO</div>
			<div class="contentImportant">Así, podrás saber si van tus compañeros de rodaje, aquel que te pasó en el último sprint o el que siempre lo gana todo.</div>
			<div class="buttonImportant"><input class="fg-button ui-state-default ui-corner-all" type="submit" value="Regístrate ahora" onclick="showRegisterBox()"/></div>
		</div>
		
		<div class="column span-8 last">
			<div class="titleImportant">¿CONOCES ALGUNA CARRERA QUE NO ESTÁ EN RUNNY? ENTONCES DINOSLO!</div>
			<div class="contentImportant">Entre todos conseguiremos crear la mejor red de carreras nacionales y disfrutar aún más del mundo del running.</div>
			<div class="buttonImportant"><input class="fg-button ui-state-default ui-corner-all" type="submit" value="Ayúdanos con tu carrera" onclick="showContactBox()"/></div>
		</div>
	</div>

	<!-- SOCIAL LINKS -->
	<div class="span-24 socialLinks">	
		<div class="column span-16 first">
			<div> 
				<h2 class="newsTitle">Síguenos en...</h2>
			</div>
			<div class="column span-3 first">
				<a href="#">
					<img src="/img/tuenti.jpg" alt="socialNetworks"/>
				</a>
			</div>
			<div class="column span-3">
				<a href="#">
					<img src="/img/facebook.jpg" alt="socialNetworks"/>
				</a>
			</div>
			<div class="column span-4 last">
				<a href="#">
					<img src="/img/twitter.jpg" alt="socialNetworks"/>
				</a>
			</div>
			<div class="column span-3 last">
				<a href="#">
					<img src="/img/flickr.jpg" alt="socialNetworks"/>
				</a>
			</div>
		</div>
		<div class="column span-8 last">
			<div> 
				<h2 class="newsTitle">Lo último en twitter</h2>
			</div>
			<div class="twitterContent">
				<div class="column span-2 first">
					<img id="profile">
				</div>
				<div class="column span-6 tweet last" id="tweets">					
				</div>
			</div>
		</div>
	</div>
	
</div>


	<!-- SCRIPT TWITTER -->
	
	{literal}
	<script language="javaScript" type="text/javascript">
		$(document).ready( function() {
	
			$('textarea').autoResize({
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
			 
		
			var url = "http://twitter.com/status/user_timeline/runn_it.json?count=1&callback=?";
			$.getJSON(url,function(data){	
				$.each(data, function(i, item) {
					$("img#profile").attr("src", item.user["profile_image_url"]);
					$("#tweets").append( item.text.linkify() + relative_time(item.created_at));
				});
		    });
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
	
	
	<!-- TRUNCATION STRING -->
	{literal}
	<script type="text/javascript">

		var len = 53;
		var p = document.getElementById('truncateMe');
		if (p) {
		
		  var trunc = p.innerHTML;
		  if (trunc.length > len) {
		

		    trunc = trunc.substring(0, len);
		    trunc = trunc.replace(/\w+$/, '');
		
		    /* Add an ellipses to the end and make it a link that expands
		       the paragraph back to its original size */
		    trunc += '<a ' +
		      'onclick="this.parentNode.innerHTML=' +
		      'unescape(\''+escape(p.innerHTML)+'\');return false;" style="color: #666666;">' +
		      '...<\/a>';
		    p.innerHTML = trunc;
		  }
		}
		
	</script>
	{/literal}


{include file="footer.tpl"} 
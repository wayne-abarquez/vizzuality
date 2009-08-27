{include file="header.tpl"} 

<!-- IMPORTANT RACE AND NEXT RACES -->
	<div class="span-24 raceContainer" id="race">
		<div class="span-23 title">
			<p class="titlePage">Runnity es un punto de encuentro entre <b><a href="/buscar">carreras</a></b> y <b>atletas.</b></p>
			<p class="subtitlePage"><b>Utiliza el mapa, <a href="/buscar">busca</a>, o <a href="javascript: void showRegisterBox()">regístrate</a> </b> para recibir alertas vía e-mail de las próximas carreras cerca de dónde vives</p>
		</div>
		<div class="span-23 map" id="runnityHomeMap">
            <object id="flashMovie" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="930" height="364" wmode="opaque">
              <param name="movie" value="flash/runnitHomeMap.swf?2" />
              <!--[if !IE]>-->
              <object type="application/x-shockwave-flash" data="flash/runnitHomeMap.swf" width="930" height="364" wmode="opaque">
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
						<div class="column first">Carreras cerca de {$city}, <a href="/buscar" class="seeAll">ver todas.</a></div>
					</div>
					<div class=" last span-5 feed">
						<div class="column fisrt span-4 feedText"><a href="http://feeds.feedburner.com/runnity">RSS</a></div>
						<div class="column span-1 imgFeed last">
							<a href="http://feeds.feedburner.com/runnity"><img src="/img/feed.jpg" alt="Feed" class="rssImage"/></a>
						</div>
					</div>
				</h2>
			</div>		
		</div>
		{foreach key=id item=race from=$nextRaces name=raceloop}
			{if $race eq "false"}
				<div class="span-16">No hay proximas carreras.</div> 
			{else}
				{if $smarty.section.race.iteration is not even}
					<div class="column span-8 first races">
						<div class="column first image">
							<img src="/media/run/{$race.thumbnail}" alt="Foto de la carrera {$race.name}"/>	
						</div>
						<div class="column span-5 last">
							<div class="nameRaceContainer"><a class="nameRace" href="/run/{$race.id}/{$race.name|replace:' ':'/'}">{$race.name}</a></div>
							<div class="raceDateDetails">
								<div class="raceDetailsStyle" id="iteracion{$smarty.foreach.raceloop.iteration}"> 
									<b>{$race.event_date|substr:8:2}/{getMonth month=$race.event_date|substr:5:2}/{$race.event_date|substr:2:2}</b> | {$race.province_name} | {$race.event_location}
								</div>
								<p class="runnersNumber">{$race.distance_text} | {$race.num_users} van</p>
							</div>
						</div>
					</div>			
				{else}
					<div class="column span-8 last races">
						<div class="column first image">
							<img src="/media/run/{$race.thumbnail}" alt="Foto de la carrera {$race.name}"/>	
						</div>
						<div class="column span-5 last">
							<div class="nameRaceContainer"><a class="nameRace" href="/run/{$race.id}/{$race.name|replace:' ':'/'}">{$race.name}</a></div>
							<div class="raceDateDetails">
								<div class="raceDetailsStyle" id="iteracion{$smarty.foreach.raceloop.iteration}" > 
									<b>{$race.event_date|substr:8:2}/{getMonth month=$race.event_date|substr:5:2}/{$race.event_date|substr:2:2}</b> | {$race.province_name} | {$race.event_location}
								</div>
								<p class="runnersNumber">{$race.distance_text} | {$race.num_users} van</p>
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
							<img src="/media/avatar/{$person.avatar}" alt="userImage"/>	
						</div>
						<div class="column span-5 last">
							<div class="detailsUser">
								<div class="nameUser"><a class="nameRace" href="#">{$person.username}</a></div>
								<div class="raceUserDetails"> dice que va a ir a </div>
								<div class="raceUserDetails"><a class="raceUserLink" href="/run/{$person.run_id}/{$race.run_name|escape:"url"}">{$person.run_name}</a></div>
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
			<div class="buttonImportant"><input class="fg-button ui-state-default ui-corner-all" type="submit" value="Mira un ejemplo de carrera" onclick="location.href='/run/22/milla/arganda/del/rey'"/></div>
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
				<a href="http://www.flickr.com/groups/1188628@N20/">
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
			 
		
			var url = "http://twitter.com/status/user_timeline/runnity.json?count=1&callback=?";
			$.getJSON(url,function(data){	
				$.each(data, function(i, item) {
					$("img#profile").attr("src", item.user["profile_image_url"]);
					$("#tweets").append( item.text.linkify() + relative_time(item.created_at));
				});
		    });
		    
		    for (i=1;i<=6;i++){
				var len = 42;
				var p = document.getElementById("iteracion" + i);
				if (p) {
				  var trunc = p.innerHTML;
				  trunc = trunc.replace(/\t/g, "");
				  if (trunc.length > len) {
		
				    trunc = trunc.substring(0, len);
				    trunc = trunc.replace(/\w+$/, '');
				
				    /* Add an ellipses to the end and make it a link that expands
				       the paragraph back to its original size */
				    trunc += '<a style="color: #666666;">' +
				      '...<\/a>';
				    p.innerHTML = trunc;
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
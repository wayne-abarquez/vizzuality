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
				<!-- 	<div class="carrera">No hay próximas carreras.</div>  -->
				{else}
					<div class="span-1 {cycle values="carrera,carrera2"}">
						<div class="span-1 avatar2">
							{if $race.flickr_img_id==""}
							    <img src="/media/run/{$race.thumbnail}" alt="Foto de la carrera {$race.name}" class="avatar"/>	
							{else}
							    <img src="/runThumbImage.php?id={$race.id}&photo_id={$race.flickr_img_id}" alt="Foto de la carrera {$race.name}" class="avatar"/>	
							{/if}
						</div>
						<div class="span-1 Race">
							<p class="span-4 nameRace"><a id="carrera{$smarty.foreach.raceloop.iteration}" 
							href="/run/{$race.id}/{$race.name|replace:' ':'/'}">{$race.name}</a></p>
							<p class="span-4 infoRace" id="iteracion{$smarty.foreach.raceloop.iteration}">
							<b>{$race.event_date|substr:8:2}/{getMonth month=$race.event_date|substr:5:2}/{$race.event_date|substr:2:2}</b> /{$race.distance_text}</p>
							<p class="span-4 placeRace">{$race.province_name} - {$race.event_location}</p>
						</div>
						{if $race.num_users > 0}
							<div class="ticketBlue"><p>{$race.num_users}</p></div>
							<div class="ticketBlueCorner"></div>
						{/if}
					</div>
					{if $smarty.foreach.raceloop.iteration < 3}
						<div class="span-1 last separator"></div>
					{/if}
				{/if}
			{foreachelse}
			<!-- 	<div class="carrera">No hay próximas carreras.</div>  -->
    		{/foreach}	
			<a class="verTodas" {if $city eq "España"} href="/buscar?q=" {else} href="/buscar?q={$city}" {/if}><b>Ver todas las carreras en {$city}</b></a>
		</div>
		
		<div class="span-1 last column2">
			<p class="titulo">ACTIVIDAD RECIENTE</p>
			{foreach key=id item=race from=$activity name=raceloop}
			<div class="carrera">
				<div class="span-1 avatar2">
					{if $race.flickr_img_id==""}
					    <img src="/media/run/{$race.thumbnail}" alt="Foto de la carrera {$race.name}" class="avatar"/>	
					{else}
					    <img src="/runThumbImage.php?id={$race.id}&photo_id={$race.flickr_img_id}" alt="Foto de la carrera {$race.name}" class="avatar"/>	
					{/if}
				</div>
				<div class="span-1 Race">
					<p class="span-4 nameRace"><a id="carrera{$smarty.foreach.raceloop.iteration}" 
							href="/run/{$race.run1_id}/{$race.run1_name|replace:' ':'/'}">{$race.run1_name}</a></p>
					<p class="span-4 recentActivity"><img src="/img/note.gif"/>{$race.run1_description}</p>
				</div>
				{if $race.run1_num_users > 0}
					<div class="ticketBlue"><p>{$race.run1_num_users}</p></div>
					<div class="ticketBlueCorner"></div>
				{/if}
			</div>
			<div class="separator"></div>
			<div class="carrera2">
				<div class="span-1 avatar2">
					{if $race.flickr_img_id==""}
					    <img src="/media/run/{$race.thumbnail}" alt="Foto de la carrera {$race.name}" class="avatar"/>	
					{else}
					    <img src="/runThumbImage.php?id={$race.id}&photo_id={$race.flickr_img_id}" alt="Foto de la carrera {$race.name}" class="avatar"/>	
					{/if}
				</div>
				<div class="span-1 Race">
					<p class="span-4 nameRace"><a id="carrera{$smarty.foreach.raceloop.iteration}" 
							href="/run/{$race.run2_id}/{$race.run2_name|replace:' ':'/'}">{$race.run2_name}</a></p>
					<p class="span-4 recentActivity"><img src="/img/note.gif"/>{$race.run2_description}</p>
				</div>
				{if $race.run2_num_users > 0}
					<div class="ticketBlue"><p>{$race.run2_num_users}</p></div>
					<div class="ticketBlueCorner"></div>
				{/if}
			</div>
			<div class="separator"></div>
			<div class="carrera">
				<div class="span-1 avatar2">
					<!-- <img src="/img/avatar2.jpg" class="avatar"> -->
					{if $race.flickr_img_id==""}
					    <img src="/media/run/{$race.thumbnail}" alt="Foto de la carrera {$race.name}" class="avatar"/>	
					{else}
					    <img src="/runThumbImage.php?id={$race.id}&photo_id={$race.flickr_img_id}" alt="Foto de la carrera {$race.name}" class="avatar"/>	
					{/if}
				</div>
				<div class="span-1 Race">
					<p class="span-4 nameRace"><a id="carrera{$smarty.foreach.raceloop.iteration}" 
							href="/run/{$race.run3_id}/{$race.run3_name|replace:' ':'/'}">{$race.run3_name}</a></p>
					<p class="span-4 recentActivity"><img src="/img/note.gif"/>{$race.run3_description}</p>
				</div>
				{if $race.run3_num_users > 0}
					<div class="ticketBlue"><p>{$race.run3_num_users}</p></div>
					<div class="ticketBlueCorner"></div>
				{/if}
			</div>
    		{/foreach}	
		</div>
	</div>
	
	<!-- RIGHT COLUMN -->
	<div class="span-1 last rightColumnHome">
<!-- 	<div class="carrera">No hay próximas carreras destacadas.</div>  -->
		<p class="titulo titulOrange">CARRERAS DESTACADAS</p>
					<div class="span-1 imgFeed">
				<a href="http://feeds.feedburner.com/runnity"><img src="/img/feed-icon.gif" alt="Feed" class="rssImage"/></a>
			</div>
		{foreach key=id item=VipRace from=$nextImportantRaces name=raceloop}
		<div class="carreraOrange">
			<div class="span-1 avatar2Orange">
				<!-- <img src="/img/avatar2.jpg" class="avatarOrange"> -->
				{if $race.flickr_img_id==""}
				    <img src="/media/run/{$VipRace.thumbnail}" alt="Foto de la carrera {$VipRace.name}" class="avatar"/>	
				{else}
				    <img src="/runThumbImage.php?id={$VipRace.id}&photo_id={$VipRace.flickr_img_id}" alt="Foto de la carrera {$VipRace.name}" class="avatar"/>	
				{/if}
			</div>
			<div class="span-1 Race">
				<p class="nameRaceOrange"><a id="carrera{$smarty.foreach.raceloop.iteration}" 
							href="/run/{$VipRace.id}/{$VipRace.name|replace:' ':'/'}">{$VipRace.name}</a></p>
				<p class="span-4 infoRaceOrange" id="iteracion{$smarty.foreach.raceloop.iteration}"><b>{$VipRace.event_date|substr:8:2}/{getMonth month=$VipRace.event_date|substr:5:2}/{$VipRace.event_date|substr:2:2}</b> / {$VipRace.distance_text}</p>
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
			<a href="/run/234/Carrera/Popular/La/Melonera">Mira una carrera de ejemplo</a>
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
			<a href="/registro">Regístrate y participa</a>
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
			<div class="twitterContent">
                <div class="column">
                    <img id="twitterImage">
                </div>
                <div class="column tweetComment last">
                	<a id="tweets" href="http://twitter.com/runnity" target="_blank"></a>
                </div>
            </div>
		</div>
	</div>

</div>
	
	
{literal}
<script language="javaScript" type="text/javascript">
	$(document).ready( function() {
	
		var url = "http://twitter.com/status/user_timeline/runnity.json?count=1&callback=?";
		$.getJSON(url,function(data){	
			$.each(data, function(i, item) {
				$("#twitterImage").attr("src", item.user["profile_image_url"]);
				$("#tweets").append(item.text.linkify());
				$("div.tweetComment").append(relative_time(item.created_at));
			});
			
	    });
	    
		$(".nameRace").truncate( {max_length: 50} );
		$(".infoRace").truncate( {max_length: 30} );
		$(".nameRaceOrange").truncate( {max_length: 55} );			
		$(".placeRace").truncate( {max_length:30} );		
		
		function twitter_callback (){
			return true;
		}
		
		String.prototype.linkify = function() {
			return this.replace(/[A-Za-z]+:\/\/[A-Za-z0-9-_]+\.[A-Za-z0-9-_:%&\?\/.=]+/, function(m) {
				return m.link(m);
			});
		}; 	
	    
	});
</script>
{/literal}

{include file="footer.tpl"} 
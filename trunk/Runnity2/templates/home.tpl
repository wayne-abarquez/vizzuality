{include file="header.tpl"}

<div class="span-24">
<div class="span-1 column mapTop"></div>
<div class="span-1 column map">
	<div id="runnityHomeMap">
		<div id="home_map"></div>
		<a id="zoom_in"></a>
		<a id="zoom_out"></a>
		<div id="loading_map">
			<img src="/img/loadingmap.png" />
		</div>
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
				{if $race eq "true"}
					<div class="span-1 {cycle values="carrera,carrera2"}">
						<div class="span-1 avatar2">
							{if $race.flickr_img_id==""}
							    <img src="/media/run/{$race.thumbnail}" alt="Foto de la carrera {$race.name}" class="avatar">	
							{else}
							    <img src="/runThumbImage.php?id={$race.id}&amp;photo_id={$race.flickr_img_id}" alt="Foto de la carrera {$race.name}" class="avatar">	
							{/if}
						</div>
						<div class="span-1 Race">
							<p class="span-4 nameRace"><a class="nameRaceLink" href="/run/{$race.id}/{$race.name|seourl}">{$race.name|truncate:40:"..."}</a></p>
							<p class="span-4 infoRace" id="iteracion{$smarty.foreach.raceloop.iteration}">
							<b>{$race.event_date|substr:8:2}/{getMonth month=$race.event_date|substr:5:2}/{$race.event_date|substr:2:2}</b> /{$race.distance_text|truncate:18:"..."}</p>
							<p class="span-4 placeRace">{$race.province_name} - {$race.event_location|truncate:18:"..."}</p>
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
			<a class="verTodas" {if $city eq "España"} href="/buscar?q=&amp;tipoBusqueda=Proximas" {else} href="/buscar?q={$city}&amp;tipoBusqueda=Proximas" {/if}><b>Ver todas las carreras en {$city}</b></a>
		</div>
		
		<div class="span-1 last column2">
			<p class="titulo">ACTIVIDAD RECIENTE</p>
            {foreach key=id item=race from=$activity name=raceloop}
			<div class="carrera">
				<div class="span-1 avatar2">
					{if $race.flickr_img_id_1==""}
					    <img src="/media/run/{$race.thumbnail}" alt="Foto de la carrera {$race.name}" class="avatar">	
					{else}
					    <img src="/runThumbImage.php?id={$race.run1_id}&amp;photo_id={$race.flickr_img_id_1}" alt="Foto de la carrera {$race.name}" class="avatar">	
					{/if}
				</div>
				<div class="span-1 Race">
					<p class="span-4 nameRace"><a href="/run/{$race.run1_id}/{$race.run1_name|seourl}">{$race.run1_name|truncate:40:"..."}</a></p>
					<p class="span-4 recentActivity"><img src="/img/note.gif" alt="">{$race.run1_description}</p>
				</div>
				{if $race.run1_num_users > 0}
					<div class="ticketBlue"><p>{$race.run1_num_users}</p></div>
					<div class="ticketBlueCorner"></div>
				{/if}
			</div>
			<div class="separator"></div>
			<div class="carrera2">
				<div class="span-1 avatar2">
					{if $race.flickr_img_id_2==""}
					    <img src="/media/run/{$race.thumbnail}" alt="Foto de la carrera {$race.name}" class="avatar">	
					{else}
					    <img src="/runThumbImage.php?id={$race.run2_id}&amp;photo_id={$race.flickr_img_id_2}" alt="Foto de la carrera {$race.name}" class="avatar">	
					{/if}
				</div>
				<div class="span-1 Race">
					<p class="span-4 nameRace"><a href="/run/{$race.run2_id}/{$race.run2_name|seourl}">{$race.run2_name|truncate:40:"..."}</a></p>
					<p class="span-4 recentActivity"><img src="/img/note.gif" alt="">{$race.run2_description}</p>
				</div>
				{if $race.run2_num_users > 0}
					<div class="ticketBlue"><p>{$race.run2_num_users}</p></div>
					<div class="ticketBlueCorner"></div>
				{/if}
			</div>
			<div class="separator"></div>
			<div class="carrera">
				<div class="span-1 avatar2">
					{if $race.flickr_img_id_3==""}
					    <img src="/media/run/{$race.thumbnail}" alt="Foto de la carrera {$race.name}" class="avatar">	
					{else}
					    <img src="/runThumbImage.php?id={$race.run3_id}&amp;photo_id={$race.flickr_img_id_3}" alt="Foto de la carrera {$race.name}" class="avatar">	
					{/if}
				</div>
				<div class="span-1 Race">
					<p class="span-4 nameRace"><a href="/run/{$race.run3_id}/{$race.run3_name|seourl}">{$race.run3_name|truncate:40:"..."}</a></p>
					<p class="span-4 recentActivity"><img src="/img/note.gif" alt="">{$race.run3_description}</p>
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
		<p class="titulo titulOrange">CARRERAS DESTACADAS</p>
					<div class="span-1 imgFeed">
				<a href="http://feeds.feedburner.com/runnity"><img src="/img/feed-icon.gif" alt="Feed" class="rssImage"></a>
			</div>
		{foreach key=id item=VipRace from=$nextImportantRaces name=raceloop}
		<div class="carreraOrange">
			<div class="span-1 avatar2Orange">
				    <img src="/runThumbImage.php?id={$VipRace.id}&amp;photo_id={$VipRace.flickr_img_id}" alt="Foto de la carrera {$VipRace.name}" class="avatar">
			</div>
			<div class="span-1 Race">
				<p class="nameRaceOrange"><a href="/run/{$VipRace.id}/{$VipRace.name|seourl}">{$VipRace.name|truncate:40:"..."}</a></p>
				<p class="span-4 infoRaceOrange"><b>{$VipRace.event_date|substr:8:2}/{getMonth month=$VipRace.event_date|substr:5:2}/{$VipRace.event_date|substr:2:2}</b> / {$VipRace.distance_text|truncate:18:"..."}</p>
				<p class="span-4 placeRaceOrange">{$VipRace.event_location|truncate:18:"..."}</p>
			</div>
		{if $smarty.foreach.raceloop.iteration < 3}
			<div class="span-1 last separatorRightOrange"></div>
		{/if}
		</div>
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
		<div class="span-1 last columnHomeLong">
			<p class="titulo">RUNNITY EN LA WEB</p>
				<a href="http://www.tuenti.com/#m=Photo&amp;func=view_photo&amp;collection_key=1-66022443-567658561-66022443" target="_blank">
					<img src="/img/tuenti.jpg" alt="socialNetworks" class="socialNetworks">
				</a>
				<a href="http://www.facebook.com/home.php?#/group.php?gid=158141673184&amp;ref=ts" target="_blank">
					<img src="/img/facebook.jpg" alt="socialNetworks" class="socialNetworks">
				</a>
				<a href="http://twitter.com/runnity" target="_blank">
					<img src="/img/twitter.jpg" alt="socialNetworks" class="socialNetworks">
				</a>
				<a href="http://www.flickr.com/groups/1188628@N20/" target="_blank">
					<img src="/img/flickr.jpg" alt="socialNetworks" class="socialNetworks">
				</a>
		</div>
		<div class="span-1 columnCorrer">
			<p class="titulo tituloRight">LO ÚLTIMO EN CORRER.ES</p>
			<div class="twitterContent" id="correrContent">
					<a id="correres" target="_blank"></a>
       </div>
		</div>
		
		<div class="span-1 last columnSort">
			<p class="titulo tituloRight">RUNNITY EN TWITTER</p>
			<div class="twitterContent">
           <div class="column">
               <img id="twitterImage" alt="twitterImage" src="">
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
	
			var url = "http://www.google.com/reader/public/javascript/feed/http://www.correr.es/feed/?callback=?";
			$.getJSON(url,function(data) {
        for(var i = 0; i < 1; i += 1) {
	      	$('#correres').append("\"" + data.items[i].title + "\"");
					$('#correres').attr("href",data.items[i].alternate.href);
					if (data.items[i].summary != null) {
						$('#correrContent').append('<p id="summary">' + data.items[i].summary + '</p>');
						var len = 100;
						var x = document.getElementById('summary');
						var trunc = x.innerHTML;
						trunc = trunc.replace(/\t/g, "");
						if (trunc.length > len) {	
							trunc = trunc.substring(0, len);
						  trunc += '...';
						  x.innerHTML = trunc;
						}
					}
				}
      });

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
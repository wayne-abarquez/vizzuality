{include file="header.tpl"}

<div class="span-24">
<div class="span-1 column mapTop"></div>
<div class="span-1 column map"></div>
<div class="span-1 column mapBottom"></div>
</div>

<div class="span-24 column content">

	<!-- LEFT COLUMN -->
	<div class="span-1 last leftColumnHome">
	
		<div class="span-1 last column1">
			<p class="titulo">PRÓXIMAS CARRERAS CERCA DE TI</p>
				{foreach key=id item=race from=$nextRaces name=raceloop}
					{if $race eq "false"}
						<div class="carrera">No hay proximas carreras.</div> 
					{else}
						<div class="{cycle values="carrera,carrera2"}">
							<div class="span-1 avatar2"><img src="/img/avatar2.jpg" class="avatar"></div>
							<div class="span-1 Race">
								<p class="span-4 nameRace"><a id="carrera{$smarty.foreach.raceloop.iteration}" 
								href="/run/{$race.id}/{$race.name|replace:' ':'/'}">{$race.name}</a></p>
								<p class="span-4 infoRace" id="iteracion{$smarty.foreach.raceloop.iteration}">
								<b>{$race.event_date|substr:8:2}/{getMonth month=$race.event_date|substr:5:2}/
								{$race.event_date|substr:2:2}</b> / {$race.distance_text}</p>
								<p class="span-4 placeRace">{$race.province_name} - {$race.event_location}</p>
							</div>
							<div class="ticketBlue"><p>{$race.num_users}</p></div>
						</div>
						<div class="separator"></div>
					{/if}
				{foreachelse}
					<div class="carrera">No hay proximas carreras.</div> 
	    		{/foreach}	
			<a class="verTodas" href="#"><b>Ver todas las carreras en Madrid</b></a>
		</div>
		
		<div class="span-1 last column2">
			<p class="titulo">ACTIVIDAD RECIENTE</p>
			<div class="carrera">
				<div class="span-1 avatar2"><img src="/img/avatar2.jpg" class="avatar"></div>
				<div class="span-1 Race">
					<p class="span-4 nameRace"><a href="#">XVIII Carrera popular “La Melonera”</a></p>
				</div>
				<div class="ticketBlue"><p>3</p></div>
			</div>
			<div class="separator"></div>
			<div class="carrera2">
				<div class="span-1 avatar2"><img src="/img/avatar2.jpg" class="avatar"></div>
				<div class="span-1 Race">
					<p class="span-4 nameRace"><a href="#">XVIII Carrera popular “La Melonera”</a></p>
				</div>
				<div class="ticketBlue"><p>3</p></div>
			</div>
			<div class="separator"></div>
			<div class="carrera">
				<div class="span-1 avatar2"><img src="/img/avatar2.jpg" class="avatar"></div>
				<div class="span-1 Race">
					<p class="span-4 nameRace"><a href="#">XVIII Carrera popular “La Melonera”</a></p>
				</div>
				<div class="ticketBlue"><p>3</p></div>
			</div>
		</div>
	</div>
	
	<!-- RIGHT COLUMN -->
	<div class="span-1 last rightColumnHome">
		<p class="titulo titulOrange">CARRERAS DESTACADAS</p>
		<div class="carreraOrange">
			<div class="span-1 avatar2Orange"><img src="/img/avatar2.jpg" class="avatarOrange"></div>
			<div class="span-1 Race">
				<p class="nameRaceOrange"><a href="#">XVIII Carrera popular “La Melonera”</a></p>
<!--
				<p class="span-4 infoRaceOrange"><b>21/Agosto</b> / 5km - 10km</p>
				<p class="span-4 placeRaceOrange">Móstoles</p>
-->
			</div>
		</div>
	</div>
	
</div> <!-- content -->

</div> <!-- container -->

<div class="bannerTop"></div>
<div class="banner">
	<div class="titular">
		<div class="span-1 titularColumn">
			<p class="titularTitle titularTitleFirst">ENTÉRATE Y PLANEA</p>
			<p class="titularInfo">Obtén la mejor información de los eventos que están por venir; Recorridos, mapas, altimetrías, fotos, 				comentarios, ediciones pasadas...</p>	
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
			<p class="titularInfo titularInfo2">¡Sube tus fotos, tus tiempos, clasificaciones y haz de Runnity un sitio cada vez mejor y más 			completo!</p>
			<br><br>
			<a href="">Regístrate y participa</a>
		</div>
	</div>
</div>

<div class="container">

<div class="span-24 column content">
	<div class="span-1 column ColumnHome">
		<div class="span-1 last columnLong">
			<p class="titulo">RUNNITY EN LA WEB</p>
		</div>
		<div class="span-1 last columnSort">
			<p class="titulo tituloRight">RUNNITY EN TWITTER</p>
		</div>
	</div>
</div>

</div>


{include file="footer.tpl"} 
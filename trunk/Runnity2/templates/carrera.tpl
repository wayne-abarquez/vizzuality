{include file="header.tpl"}

<div class="span-24 column content">

	<div class="span-1 last leftColumn">
		<p><a href="#">Carreras en Madrid</a></p>
		<div class="carrera_principal">
			<div class="column span-1 first calendar">
				<div class="month month{$data.run_type}">{getMonth month=$data.event_date|substr:5:2}</div>
		    	<div class="day">{$data.event_date|substr:8:2}</div>
		    </div>
		    <p class="raceTitle" id="raceTitle">{$data.name}</p>
		    <p class="raceDetailsTitle">{$data.event_location} | {$data.distance_text} | <b>{$data.num_users} usuarios van</b></p>
		    
		    {if $data.flickr_img_id === null}
			    <img src="/media/run/{$data.big_picture}" class="imageCarrera"/>
			{else}
			<a href="{$data.flickr_url}" target="_blank"><img class="imageCarrera" src="/panoramioPic.php?												id={$data.id}&photo_id={$data.flickr_img_id}"/></a>
			{/if}
			
			<div class="span-1 last raceData">
				{if $data.distance_text != null or $data.category != null or $data.awards != null}
					<p class="titulo tituloLeft">DATOS TÉCNICOS</p>
					{if $data.distance_text != null}
					<div class="span-6 databox">
						<div class="span-2 last distance"><p>Distancia:</p></div>
						<div class="span-4 last distanceInfo"><p><b>{$data.distance_text}</b></p></div>
					</div>
					{/if}
					{if $data.event_date != null}
					<div class="span-6 databox">
						<div class="span-2 last distance"><p>Hora:</p></div>
						<div class="span-4 last distanceInfo"><p><b>{$data.event_date|substr:11:5}</b></p></div>
					</div>
					{/if}
					{if $data.category != null}
					<div class="span-6 databox">
						<div class="span-2 last distance"><p>Categorias:</p></div>
						<div class="span-4 last distanceInfo"><p><b>{$data.category}</b></p></div>
					</div>
					{/if}
					{if $data.awards != null}
					<div class="span-6 databox">
						<div class="span-2 last distance"><p>Premios:</p></div>
						<div class="span-4 last distanceInfo"><p><b>{$data.awards}</b></p></div>
					</div>
					{/if}
				{/if}
			</div>
			
			<div class="span-1 last raceDescription">
				<p class="titulo tituloLeft tituloRight">DESCRIPCIÓN Y DATOS ADICIONALES</p>
				
				<p class="textRace">
					{if $data.description!=null}
						{$data.description}
					{else}
					No hay descripción para esta carrera, ¿te animas a <a href="javascript: void showContactBox()">enviarnos una?</a>
					{/if}	
				</p>
			</div>
			
		</div>
	</div>
	
	<div class="span-1 last rightColumn">
		<div class="span-1 ticketOrangeVoy">Voy a ir a esta carrera</div>
		<div class="span-1 ticketOrange"></div>
	</div>

</div> <!-- content -->

</div> <!-- container -->

{include file="footer.tpl"} 
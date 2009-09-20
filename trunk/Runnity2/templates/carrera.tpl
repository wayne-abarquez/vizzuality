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
			
			
			
		</div>
	</div>
	
	<div class="span-1 last rightColumn">
		<div class="span-1 ticketOrangeVoy">Voy a ir a esta carrera</div>
		<div class="span-1 ticketOrange"></div>
	</div>

</div> <!-- content -->

</div> <!-- container -->

{include file="footer.tpl"} 
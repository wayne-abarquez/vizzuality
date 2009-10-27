{include file="header.tpl"} 
<div class="span-24 raceContainer" id="race">
	<div class="span-24 title">
		<p class="titlePage">Sitemap</p>
		<p class="subtitlePage">En esta pagina puedes encontrar enlaces a todas las carreras que se han publicado</p>
	</div>
	<div class="column first span-16 moreRaces">
		<uL>
		{foreach key=id item=run from=$runs}
			<li type="none"><a href="/run/{$run.id}/{$run.name|seourl}">{$run.name} - {$run.event_location} - {$run.distance_text} - {$run.event_date}</a></li>
		{/foreach}
		<ul>		
	</div>		
</div>
</div>
{include file="footer.tpl"} 
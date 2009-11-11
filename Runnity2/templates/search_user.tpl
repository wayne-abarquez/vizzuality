{include file="header.tpl"}
 
{literal}
<script type="text/javascript"> 
$(document).ready(function(){

    if(gup('q').length<1) {
        $('#inputsearch1').emptyonclick();
    }
});
</script>
{/literal}

<!-- GLOBAL CONTAINER RACE -->
	<div class="span-24 raceContainer" id="race">
	
		<!-- RACE & IMAGE -->
		<div class="span-24">
			
			<div id="searchBox">
				<div class="searchForm">
					<div class="column regionInput">
						<!-- METODO BUSCAR!?!??! -->
						<form id="searchForm" method="GET" action="/buscar">

							
							<div class="searchlabel"><p>NOMBRE</p></div>
							<div class="inputSearch">
								<div class="column first inputLeft">
									<label class="roundsearchUser" for="inputsearch1"><span><input type="text" id="userInputSearch" class="default" {if $smarty.get.q==null}value="Nombre de usuario (dejalo vacío para ver todos)"{else} value="{$smarty.get.q}"{/if}name="q"></span></label>			
								</div>
														
							</div>
					</div>
					
					<div class="column last buttonSearchBig">
						<span><a href="#"><input id="inputSearchGeneral" class="buttonsearchbig" type="submit" value="Buscar"></a></span>
					</div>
				</form>

					
				</div>
				<div class="span-23 topPaginator">
					<div class="column last upPaginator">
						{if $count > 10}
							<p>viendo del <b>{math equation="x+1" x=$offset} al {math equation="min(x2 +10,c)" x2=$offset c=$count}</b> de {$count}
								{if $offset > 0}
									<span><a href="?offset={math equation="max(x-10,0)" x=$offset}&amp;tipoBusqueda={$tipoBusqueda}&amp;tipoCarrera={$smarty.request.tipoCarrera}&amp;fechaInicio={$smarty.request.fechaInicio}&amp;fechaFin={$smarty.request.fechaFin}&amp;q={$smarty.request.q}"><input class="leftPaginator" type="button"></a></span>
								{/if}
								{if $offset < $count-10}
									<span><a href="?offset={$offset+10}&amp;tipoBusqueda={$tipoBusqueda}&amp;tipoCarrera={$smarty.request.tipoCarrera}&amp;fechaInicio={$smarty.request.fechaInicio}&amp;fechaFin={$smarty.request.fechaFin}&amp;q={$smarty.request.q}"><input class="rightPaginator" type="button"></a></span>
	                			{/if}	
							</p>	
	                    {/if}
					</div>	
				</div>
			</div>

				<div id="results" class="span-24 column first">			
	        		{foreach key=id item=race from=$results}
	        			{if $race eq "0"}
	        				<div class="column span-15 noResultsContainer">
	        					<div class="noResultsText">
		        					<p class="noResults">Ouch! No hay resultados</p>
		        					<p class="noResultsSub"><b>No hemos podido encontrar ningún usuario que coincidiera con tu búsqueda</b>
		        					<br />Comprueba que la ortografía es correcta.<br /><br /> 
		        					Si sigues sin encontrar nada por aquí, puedes intentarlo en el<a href="/"> mapa de carreras</a> de la home<br />o <a href="/rss.php">suscribirte a nuestro RSS</a> para estar al tanto de las últimas actualizaciones</p>
								</div>
	        				</div>
	        			{else}
	        				<div class="column first {cycle values="raceResult one,raceResult two"}">
	    						<div class="column first firstDetails">
	    							<div class="column first raceResultDate">
	    								<div class="month month{$race.run_type}">{getMonth month=$race.event_date|substr:5:2}</div>
	    								<div class="day">{$race.event_date|substr:8:2}</div>
	    							</div>
	    							<div class="column last">
	    								<div><img src="/runThumbImage.php?id={$race.id}&amp;photo_id={$race.flickr_img_id}" alt="Foto de la carrera {$race.name}"></div>
	    							</div>
	    						</div>
	    						<div class="column last">
	    							<p class="span-1 raceLocationText"><b>{$race.distance_text}</b> / {$race.event_location}, {$race.province_name}</p>   							
	    							<p class="span-18"><a href="/run/{$race.id}/{$race.name|seourl}" class="raceTitleText">{$race.name}</a></p>
	    							<div id="socialDetails">
	    								<div class="column socialBox first"><img src="/img/photo.jpg" alt="photo"><a href="/run/{$race.id}/{$race.name|seourl}#fotos">{$race.num_pictures} fotos</a></div>
	    							</div>
	    						</div>
	    						{if $race.num_users>0}
	    							<div class="blueTag"><a><span class="start">{$race.num_users}{if $race.num_users eq 1} VA{else} VAN{/if}</span></a></div> 							
	    						{/if}
	    					</div>     
	        			{/if}
	        	    {foreachelse}
        				<div class="column span-15 noResultsContainer">
        					<div class="noResultsText">
	        					<p class="noResults">Ouch! No hay resultados</p>
	        					<p class="noResultsSub"><b>No hemos podido encontrar ningún usuario que coincidiera con tu búsqueda</b>
	        					<br />Comprueba que la ortografía es correctas.<br /><br /> 
	        					Si sigues sin encontrar nada por aquí, puedes intentarlo en el<a href="/"> mapa de carreras</a> de la home<br />o <a href="/rss.php">suscribirte a nuestro RSS</a> para estar al tanto de las últimas actualizaciones</p>
							</div>
        				</div>
	        	    {/foreach}
        	    </div>
        	    
        	    
        	    <div id="belowPaginator" class="span-24">
        	    	<div class="column first belowPaginatorTotal"><p>{$count}{if $count eq 1} resultado{else} resultados{/if}</p></div>
        	   		<div class="column last bottomPaginator">
						{if $count > 10}
 							<p>viendo del <b>{math equation="x+1" x=$offset} al {math equation="min(x2 +10,c)" x2=$offset c=$count}</b> de {$count}
								{if $offset > 0}
									<span><a href="?offset={math equation="max(x-10,0)" x=$offset}&amp;tipoBusqueda={$tipoBusqueda}&amp;tipoCarrera={$smarty.request.tipoCarrera}&amp;fechaInicio={$smarty.request.fechaInicio}&amp;fechaFin={$smarty.request.fechaFin}&amp;q={$smarty.request.q}"><input class="leftPaginator" type="button"></a></span>
								{/if}
								{if $offset < $count-10}
									<span><a href="?offset={$offset+10}&amp;tipoBusqueda={$tipoBusqueda}&amp;tipoCarrera={$smarty.request.tipoCarrera}&amp;fechaInicio={$smarty.request.fechaInicio}&amp;fechaFin={$smarty.request.fechaFin}&amp;q={$smarty.request.q}"><input class="rightPaginator" type="button"></a></span>
	                			{/if}
 								
 							</p>	
                    	{/if}
					</div>
					
				</div>
				
				
			</div>					
		</div>
	</div>
</div>

{include file="footer.tpl"}
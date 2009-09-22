{include file="header.tpl"} 



<!-- GLOBAL CONTAINER RACE -->
	<div class="span-24 raceContainer" id="race">
	
		<!-- RACE & IMAGE -->
		<div class="span-24">
			
			<div class="raceContent1">
				<h2 class="newsTitle3">Resultados de tu búsqueda ({$count})</h2>
				<div class="raceSearchFirst">
					<div class="searchPanel">
						<div class="labels">
							<div class="searchlabel">Localidad, nombre, etc...</div>
							<div class="searchlabel searchlabel2">Distancia mín / max (metros)</div>
						</div>
						<div class="formSearch">
						<form id="searchForm" method="GET" action="/buscar">
							<div class="inputSearch">
			<label class="roundsearch" for="inputsearch1"><span><input type="text" name="q" id="inputsearch1" value="{$smarty.request.q}"></span></label>
							</div>
							<div class="inputSearch">
			<label class="roundsearch" for="inputsearch2"><span><input type="text" name="distancia_min" id="inputsearch2" value="{$smarty.request.distancia_min}"></span></label>
							</div>
							<div class="inputSearch">
			<label class="roundsearch" for="inputsearch3"><span><input type="text" name="distancia_max" id="inputsearch3" value="{$smarty.request.distancia_max}"></span></label>
							</div>
							<div class="buttonSearch"><input class="fg-button BuscarCarrera" type="submit" value="Buscar"/></div>
						</form>
						</div>
					</div>
					<div class="pagination">
						{if $count > 20}
 							<div class="numberResults">
 								<p>viendo del <b>{math equation="x+1" x=$offset} al {math equation="min(x2 +20,c)" x2=$offset c=$count}</b> de {$count}</p>                    							</div>
 								{if $offset > 0}
				<div class="searchAdelante"><a href="?offset={math equation="max(x-20,0)" x=$offset}"><input class="fg-button" type="button" value="<"/></a></div>
								{/if}
								{if $offset < $count-20}
									<div class="searchAtras"><a href="?offset={$offset+20}&q={$smarty.request.q}&distancia_min={$smarty.request.distancia_max}&distancia_max={$smarty.request.distancia_max}"><input class="fg-button" type="button" value=">"/></a></div>
                    			{/if}
                    	{/if}
					</div>
				</div>



				<div id="results" class="span-24 column first">			
	        		{foreach key=id item=race from=$results}
	        			{if $race eq "0"}
	        				<!--<div class="column span-15 noResultsContainer">
	        					<div class="carita"></div>
	        					<div class="noResultsText">
	        					<p class="noResults"><b>Lo sentimos, no hay resultados</b> que coincidan con tu búsqueda</p>
	        					<p class="noResultsSub">Pero si quieres puedes <a href="/rss.php">subscribirte a nuestro RSS</a> para estar al tanto de las nuevas carreras</p>
								</div>
	        				</div> -->
	        			{else}
	        				<div class="column first {cycle values="raceResult one,raceResult two"}">
	    						<div class="column first firstDetails">
	    							<div class="column first raceResultDate">
	    								<div class="month">{getMonth month=$race.event_date|substr:5:2}</div>
	    								<div class="day">{$race.event_date|substr:8:2}</div>
	    							</div>
	    							<div class="column last">
	    								<div ><img src="/img/avatar2.jpg"></div>
	    							</div>
	    						</div>
	    						<div class="column last">
	    							<p class=" raceLocationText"><b>{$race.distance_text}</b> / {$race.event_location}, {$race.province_name}</p>   							
	    							<p><a href="/run/{$race.id}/{$race.name|replace:' ':'/'}" class="raceTitleText">{$race.name}</a></p>
	    							<div id="socialDetails">
	    								<div class="column socialBox first"><img src="/img/photo.jpg"/><a href="/run/{$race.id}/{$race.name|replace:' ':'/'}">12 FOTOS</a></div>
	    								<div class="column socialBox last"><img src="img/comment.jpg"/> <a href="/run/{$race.id}/{$race.name|replace:' ':'/'}">12 COMENTARIOS</a></div>
	    							</div>
	    						</div>
	    						{if $race.num_users>0}
	    							<div class="blueTag"><a><span class="start">{$race.num_users} VAN</span></a></div>
	    						{/if}
	    					</div>   
	    					
	    					
	    					
	    					    
	        			{/if}
	        	    {foreachelse}
	        	        <div class="column span-15 noResultsContainer">
	        					<div class="carita"></div>
	        					<div class="noResultsText">
	        					<p class="noResults"><b>Lo sentimos, no hay resultados</b> que coincidan con tu búsqueda</p>
	        					<p class="noResultsSub">Pero si quieres puedes <a href="/rss.php">subscribirte a nuestro RSS</a> para estar al tanto de las nuevas carreras</p>
								</div>
	        				</div> 
	        	    {/foreach}
        	    </div>
        	    
        	    
				<div class="raceSearchLast">
					<div class="paginationLast">
						{if $count > 20}
 							<div class="numberResults">
 								<p>viendo del <b>{math equation="x+1" x=$offset} al {math equation="min(x2 +20,c)" x2=$offset c=$count}</b> de {$count}</p>                    							</div>
 								{if $offset > 0}
				<div class="searchAdelante"><a href="?offset={math equation="max(x-20,0)" x=$offset}"><input class="fg-button" type="button" value="<"/></a></div>
								{/if}
								{if $offset < $count-20}
									<div class="searchAtras"><a href="?offset={$offset+20}&q={$smarty.request.q}&distancia_min={$smarty.request.distancia_max}&distancia_max={$smarty.request.distancia_max}"><input class="fg-button" type="button" value=">"/></a></div>
                    			{/if}
                    	{/if}
					</div>
				</div>
				
				
			</div>					
		</div>
	</div>
</div>

{include file="footer.tpl"} 
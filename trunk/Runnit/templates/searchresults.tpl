{include file="header.tpl"} 

<!-- GLOBAL CONTAINER RACE -->
	<div class="span-24 raceContainer" id="race">
	
		<!-- RACE & IMAGE -->
		<div class="span-16 first leftColumn">
			<div class="span-16 column">
				<div class="span-16 navigationList">
					<ul> 
						<li><a href="/">Inicio ></a></li>
						<li><a href="#" class="selected">{$titulo_breadcrumb} <b>{$smarty.request.q}</b></a></li>
					</ul>
				</div>
			</div>
			
			<div class="raceContent1">
				<h2 class="newsTitle3">Resultados de tu búsqueda ({$count})</h2>
				<div class="raceSearchFirst">
					<div class="searchPanel">
						<div class="labels">
							<div class="searchlabel">Localidad, nombre, etc...</div>
							<div class="searchlabel searchlabel2">Distancia mín / max (metros)</div>
						</div>
						<div class="formSearch">
						<form id="searchForm" method="GET" action="/searchResults.php">
							<div class="inputSearch">
			<label class="roundsearch" for="inputsearch1"><span><input type="text" name="q" id="inputsearch1" value="{$smarty.request.q}"></span></label>
							</div>
							<div class="inputSearch">
			<label class="roundsearch" for="inputsearch2"><span><input type="text" name="distancia_min" id="inputsearch2" value="{$smarty.request.distancia_min}"></span></label>
							</div>
							<div class="inputSearch">
			<label class="roundsearch" for="inputsearch3"><span><input type="text" name="distancia_max" id="inputsearch3" value="{$smarty.request.distancia_max}"></span></label>
							</div>
							<div class="buttonSearch"><input class="fg-button ui-state-default ui-corner-all" type="submit" value="Buscar"/></div>
						</form>
						</div>
					</div>
					<div class="pagination">
							<!--

							    {if $offset > 0}
							        <a href="?offset={math equation="max(x-20,0)" x=$offset}">Previous</a>
							        <div class="column btnJoin"><input class="fg-button ui-state-default ui-corner-all" type="button" value="<"/></div>
							    {/if}
							    {if $offset < $count-20}
							        <a href="?offset={$offset+20}&q={$smarty.request.q}&distancia_min={$smarty.request.distancia_max}&distancia_max={$smarty.request.distancia_max}">Next</a>
							        <div class="column"><input class="fg-button ui-state-default ui-corner-all" type="button" value=">"/></div>	
                                {/if}

 								<div class="pagination">viendo del <b>{math equation="min(x*20,1)" x=$offset} al {math equation="min((x+1)*20,1)" x=$offset}</b> de {$count}</div> -->
 					<div class="numberResults numberMargin"><p>viendo del 1<b> al 12</b> de 12</p></div>
					<div class="numberResults"><a href=""><div><input class="fg-button ui-state-default ui-corner-all" type="button" value="<"/></div></a></div>
					<div class="numberResults numberMargin"><a href=""><div><input class="fg-button ui-state-default ui-corner-all" type="button" value=">"/></div></a></div>
									
					</div>
				</div>

				<div class="searchResultsBox">				
	        		{foreach key=id item=race from=$results}
	        			{if $race eq "0"}
	        				<div class="column span-15 noResultsCotainer">
	        					<div class="carita"></div>
	        					<div class="noResultsText">
	        					<p class="noResults"><b>Lo sentimos, no hay resultados</b> que coincidan con tu búsqueda</p>
	        					<p class="noResultsSub">Pero si quieres puedes <a href="rss.php">subscribirte a nuestro RSS</a> para estar al tanto de las nuevas carreras</p>
								</div>
	        				</div> 
	        			{else}
	        				<div class=" span-15 column first raceDetailsSearch">
	    						<div class="column span-1 first date">
	    							<div class="month">{getMonth month=$race.event_date|substr:5:2}</div>
	    							<div class="day">{$race.event_date|substr:8:2}</div>
	    						</div>
	    						<div class="column span-13 last calendarRaces">
	    							<div class="nextRaceComment"><a href="/run/{$race.id}/{$race.name|replace:' ':'/'}" class="nameRace">{$race.name}</a></div>
	    							<div class="raceLocation">{$race.event_location} | {$race.distance_text} | <b>{$race.num_users} van</b> </div>
	    						</div>
	    					</div>       			
	        			{/if}
	        	    {foreachelse}
	        	        <div class="span-9 races"><p class="noResults">No hay resultados para la búsqueda.</p></div> 
	        	    {/foreach}
        	    </div>
				<div class="raceSearchLast">
					<div class="searchPanel">
						<div class="pagination countAgo">
							<div class="pagination">
							    {if $offset > 0}
							        <a href="?offset={math equation="max(x-20,0)" x=$offset}">Previous</a>
							        <div class="column btnJoin"><input class="fg-button ui-state-default ui-corner-all" type="submit" value="<"/></div>
							    {/if}
							    {if $offset < $count-20}
							        <a href="?offset={$offset+20}&q={$smarty.request.q}&distancia_min={$smarty.request.distancia_max}&distancia_max={$smarty.request.distancia_max}">Next</a>
							        <div class="column"><input class="fg-button ui-state-default ui-corner-all" type="submit" value=">"/></div>	
	                            {/if}
							</div>
							<div class="column pagination">viendo del <b>{math equation="min(x*20,1)" x=$offset} al {math equation="min((x+1)*20,c)" x=$offset c=$count}</b> de {$count}</div>
						</div>
					</div>
				</div>
			</div>					
		</div>
		
		
		<!-- RIGHT COLUMN -->
		<div class="column span-8 last rightColumn">

			<div class="span-8 importantRaces">
				<div class="events"> 
					<h2 class="newsTitle4">Próximas carreras</h2>
				</div>	
				<div class="events">
            		{foreach key=id item=race from=$nextRaces}
            			{if $race eq 'f'}
            				<div class="span-8 races">No hay proximas carreras.</div> 
            			{else}		    				    
        					<div class="span-8 column first raceDetails" id="raceDetails">
        						<div class="column span-1 first date">
        							<div class="month">{getMonth month=$race.event_date|substr:5:2}</div>
        							<div class="day">{$race.event_date|substr:8:2}</div>
        						</div>
        						<div class="column span-6 last calendarRaces">
        							<div class="nextRaceComment"><a href="/run/{$race.id}/{$race.name|replace:' ':'/'}" class="nameRace">{$race.name}</a></div>
        							<div class="raceLocation">{$race.event_location} | {$race.distance_text} | <b>{$race.num_users} van</b> </div>
        						</div>
        					</div>
            			{/if}
            	    {foreachelse}
            	        <div class="span-8 races">No hay proximas carreras.</div> 
            	    {/foreach}					
				</div>				
			</div>		
		</div>
	</div>
</div>

{include file="footer.tpl"} 
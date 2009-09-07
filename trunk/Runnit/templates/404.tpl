{include file="header.tpl"} 
<!-- GLOBAL CONTAINER RACE -->
	<div class="span-24 raceContainer" id="race">
	
		<!-- RACE & IMAGE -->
		<div class="span-16 first leftColumn">
			<div class="span-16 column">
				<div class="span-16 navigationList">
					<ul> 
						<li><a href="#" class="selected">Página no encontrada</b></a></li>
					</ul>
				</div>
			</div>
			
			<div class="raceContent1">
				<h2 class="newsTitle3">Página no encontrada</h2>
				<div class="errorbox span-5 first"><img src="img/errorbox.jpg"></div>
				<div class="errorboxContainer last">
					<p class="errorboxTitle">uh oh, algo no ha ido bien...</p>
					<p class="errorboxInfo">La página que estas buscando parece no existir. Te animamos a que 
eches un vistazoal listado de <b><a href="searchresults.php">carreras</a></b> a ver si encuentras lo que 
estas buscando.</p>
					<p class="errorboxInfo">Si no lo encuentras,puedes <b><a href="/rss.php">subscribirte a nuestro RSS</a></b> para estar 
al tanto de las nuevas carreras</p>
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
	    							<div class="month month{$race.run_type}">{getMonth month=$race.event_date|substr:5:2}</div>
	    							<div class="day">{$race.event_date|substr:8:2}</div>
	    						</div>
        						<div class="column span-6 last calendarRaces">
        							<div class="nextRaceComment"><a href="/run/{$race.id}/{$race.name|replace:' ':'/'}" class="nameRace">{$race.name}</a></div>
        							<div class="raceLocation">{$race.event_location} | {$race.distance_text} | <b>{$race.num_users} van</b></div>
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
</div>
{include file="footer.tpl"} 
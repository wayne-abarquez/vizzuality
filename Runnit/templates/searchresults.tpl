{include file="header.tpl"} 

{literal}
<script type="text/javascript">
    <!--

    $(function () {
        $('.bubbleInfo').each(function () {
            var distance = 10;
            var time = 250;
            var hideDelay = 500;

            var hideDelayTimer = null;

            var beingShown = false;
            var shown = false;
            var trigger = $('.trigger', this);
            var info = $('.popup', this).css('opacity', 0);


            $([trigger.get(0), info.get(0)]).mouseover(function () {
                if (hideDelayTimer) clearTimeout(hideDelayTimer);
                if (beingShown || shown) {
                    // don't trigger the animation again
                    return;
                } else {
                    // reset position of info box
                    beingShown = true;

                    info.css({
                        top: -90,
                        left: -33,
                        display: 'block'
                    }).animate({
                        top: '-=' + distance + 'px',
                        opacity: 1
                    }, time, 'swing', function() {
                        beingShown = false;
                        shown = true;
                    });
                }

                return false;
            }).mouseout(function () {
                if (hideDelayTimer) clearTimeout(hideDelayTimer);
                hideDelayTimer = setTimeout(function () {
                    hideDelayTimer = null;
                    info.animate({
                        top: '-=' + distance + 'px',
                        opacity: 0
                    }, time, 'swing', function () {
                        shown = false;
                        info.css('display', 'none');
                    });

                }, hideDelay);

                return false;
            });
        });
    });
    
    //-->
    </script>
{/literal}

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
							<div class="buttonSearch"><input class="fg-button BuscarCarrera" type="submit" value="Buscar"/></div>
						</form>
						</div>
					</div>
					<div class="pagination">
					{if $count > 20}
 					<div class="numberResults numberMargin"><p>viendo del <b>{math equation="x+1" x=$offset} al {math equation="min(x2 +20,c)" x2=$offset c=$count}</b> de {$count}</p></div>
 					{if $offset > 0}
						<div class="numberResults"><a href="?offset={math equation="max(x-20,0)" x=$offset}"><input class="fg-button" type="button" value="<"/></a></div>
					{/if}
					{if $offset < $count-20}
						<div class="numberResults numberMargin"><a href="?offset={$offset+20}&q={$smarty.request.q}&distancia_min={$smarty.request.distancia_max}&distancia_max={$smarty.request.distancia_max}"><input class="fg-button" type="button" value=">"/></a></div>
                    {/if}
                    {/if}

					</div>
				</div>

				<div class="searchResultsBox">			
	        		{foreach key=id item=race from=$results}
	        			{if $race eq "0"}
	        				<div class="column span-15 noResultsContainer">
	        					<div class="carita"></div>
	        					<div class="noResultsText">
	        					<p class="noResults"><b>Lo sentimos, no hay resultados</b> que coincidan con tu búsqueda</p>
	        					<p class="noResultsSub">Pero si quieres puedes <a href="/rss.php">subscribirte a nuestro RSS</a> para estar al tanto de las nuevas carreras</p>
								</div>
	        				</div> 
	        			{else}
	        				<div class=" span-15 column first raceDetailsSearch">
	    						<div class="column span-1 first date">
	    						{if $race.run_type eq "1"}
	    							<div class="bubbleInfo">
	    								<div class="month month1">{getMonth month=$race.event_date|substr:5:2}</div>
			<table id="dpop" class="popup">
                <tbody>
                <tr>
                        <td id="topleft" class="corner"></td>
                        <td class="top"></td>
                        <td id="topright" class="corner"></td>
                </tr>

                <tr>
                        <td class="left"></td>
                        <td><table class="popup-contents">
                                <tbody><tr>
                                        <th>File:</th>
                                        <td>coda 1.1.zip</td>
                                </tr>
                                <tr>
                                        <th>Date:</th>
                                        <td>11/30/07</td>
                                </tr>
                                <tr>
                                        <th>Size:</th>
                                        <td>17 MB</td>
                                </tr>
                                <tr>
                                        <th>Req:</th>
                                        <td>Mac OS X 10.4+</td>
                                </tr>                                           
                                <tr id="release-notes">
                                        <th>Read the release notes:</th>
                                        <td><a title="Read the release notes" href="./releasenotes.html">release notes</a></td>
                                </tr>
                        </tbody></table>

                        </td>
                        <td class="right"></td>    
                </tr>

                <tr>
                        <td class="corner" id="bottomleft"></td>
                        <td class="bottom"><img width="30" height="29" alt="popup tail" src="http://jqueryfordesigners.com/demo/images/coda/bubble-tail2.png"/></td>
                        <td id="bottomright" class="corner"></td>
                </tr>
        	</tbody>
        </table>

	    							</div>
	    						{/if}
	    						{if $race.run_type eq "2"}
	    							<div class="month month2">{getMonth month=$race.event_date|substr:5:2}</div>
	    						{/if}
	    						{if $race.run_type eq "3"}
	    							<div class="month month3">{getMonth month=$race.event_date|substr:5:2}</div>
	    						{/if}
	    						{if $race.run_type eq "4"}
	    							<div class="month month4">{getMonth month=$race.event_date|substr:5:2}</div>
	    						{/if}
	    						{if $race.run_type eq "5"}
	    							<div class="month month5">{getMonth month=$race.event_date|substr:5:2}</div>
	    						{/if}
	    							<div class="day">{$race.event_date|substr:8:2}</div>
	    						</div>
	    						
	    						<div class="column span-13 last calendarRaces">
	    							<div class="nextRaceComment"><a href="/run/{$race.id}/{$race.name|replace:' ':'/'}" class="nameRace">{$race.name}</a></div>
	    							<div class="raceLocation">{$race.event_location} | {$race.distance_text} | <b>{$race.num_users} van</b> </div>
	    						</div>
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
 					<div class="numberResults numberMargin"><p>viendo del <b>{math equation="x+1" x=$offset} al {math equation="min(x2 +20,c)" x2=$offset c=$count}</b> de {$count}</p></div>
 					{if $offset > 0}
						<div class="numberResults"><a href="?offset={math equation="max(x-20,0)" x=$offset}"><input class="fg-button" type="button" value="<"/></a></div>
					{/if}
					{if $offset < $count-20}
						<div class="numberResults numberMargin"><a href="?offset={$offset+20}&q={$smarty.request.q}&distancia_min={$smarty.request.distancia_max}&distancia_max={$smarty.request.distancia_max}"><input class="fg-button" type="button" value=">"/></a></div>
                    {/if}
                    {/if}


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

{include file="footer.tpl"} 
{include file="header.tpl"} 
{literal}
<script type="text/javascript"> 
$(document).ready(function(){

	$("ul.subnav").parent().append("<span></span>"); //Only shows drop down trigger when js is enabled - Adds empty span tag after ul.subnav
	
	$('#ppalField').click(function() {
		$(this).parent().find("ul.subnav").slideDown('fast').show();
	});
	
	$("ul.topnav li span").click(function() { //When trigger is clicked...
		$(this).parent().find("ul.subnav").slideDown('fast').show(); //Drop down the subnav on click
		
		$(this).parent().hover(function() {
        }, function(){
        
        	/*
if ($(this).parent().attr('id') == 'Navigator'){return false;} else { $(this).parent().find("ul.subnav").slideUp('slow'); //Ocultamos el submenu cuando el raton sale fuera del submenu
        	}
*/
           
        });

		}).click(function() { 
			$(this).addClass("subhover"); //On hover over, add class "subhover"
		}, function(){	//On Hover Out
			$(this).removeClass("subhover"); //On hover out, remove class "subhover"
	});
	
	 
	
	$("ul.topnav li ul.subnav li a").click(function() { //When trigger is clicked...
		valor = $(this).html();
		$('#ppalField').html(valor);
		$('#ppalField').css("color",$(this).css("color"));
		$("ul.subnav").slideUp('fast'); //When the mouse hovers out of the subnav, move it back up */
	});

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
						<form id="searchForm" method="GET" action="/buscar">
							<div class="searchlabel"><p>TEXTO LIBRE</p></div>
							<div class="inputSearch">
								<div class="column first inputLeft">
									<label class="roundsearch1" for="inputsearch1"><span><input type="text" name="q" id="inputsearch1" value="{$smarty.request.q}"></span></label>			
								</div>
								<div class="column inputRight">
									<ul id="Navigator" class="topnav">
							            <li id="liField">
							                <a id="ppalField" href="#">Todas</a>
							                <ul class="subnav">
							                    <li><a href="#">Todas</a></li>
							                    <li><a href="#" id="a1">Mediofondo</a></li>
							                    <li><a href="#" id="a2">Fondo</a></li>
							                    <li><a href="#" id="a3">Marathon/Ultrafondo</a></li>
							                    <li><a href="#" id="a4">Cross/Campo</a></li>
												<li><a href="#" id="a5">Combinadas</a></li>
							                </ul>
							            </li>
							        </ul>	
							    </div>							
							</div>
						</form>
					</div>
					
					<div class="column dateInput">
						<div class="searchlabel"><p>RANGO DE FECHAS</p></div>
						<div class="inputSearch">
							<div id="widget">
								<div id="widgetField">
									<span>23/09/2009 - 31/09/2009</span>
									<a href="#">Selecciona un rango</a>
								</div>
								<div id="widgetCalendar">
								</div>
							</div>
						</div>
					</div>
					
					<div class="column last buttonSearchBig">
						<span><a href="#"><input class="buttonsearchbig" type="button" value="Buscar"/></a></span>
					</div>
					
				</div>
				<div class="topPaginator" class="span-24">
					<div class="column first racesTab">
					 	<ul>
					    	<li id="current"><a href="#" title="Link 1"><span>Carreras por llegar</span></a></li>
					    	<li><a href="#" title="Link 2"><span>Carreras pasadas</span></a></li>
					  	</ul>
					</div>
					<div class="column last upPaginator">
						{if $count > 20}
							<p>viendo del <b>{math equation="x+1" x=$offset} al {math equation="min(x2 +20,c)" x2=$offset c=$count}</b> de {$count}
								{if $offset > 0}
									<span><a href="?offset={math equation="max(x-20,0)" x=$offset}"><input class="fg-button" type="button" value="<"/></a></span>
								{/if}
								{if $offset < $count-20}
									<span><a href="?offset={$offset+20}&q={$smarty.request.q}&distancia_min={$smarty.request.distancia_max}&distancia_max={$smarty.request.distancia_max}"><input class="fg-button" type="button" value=">"/></a></span>
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
	        					<div class="carita"></div>
	        					<div class="noResultsText">
	        					<p class="noResults"><b>Lo sentimos, no hay resultados</b> que coincidan con tu búsqueda</p>
	        					<p class="noResultsSub">Pero si quieres puedes <a href="/rss.php">subscribirte a nuestro RSS</a> para estar al tanto de las nuevas carreras</p>
								</div>
	        				</div>
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
	    							<div class="blueTag"><a><span class="start">{$race.num_users}{if $race.num_users eq 1} VA{else} VAN{/if}</span></a></div> 							
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
        	    
        	    
        	    <div id="belowPaginator" class="span-24">
        	    	<div class="column first noResults"><p>{$count}{if $count eq 1} resultado{else} resultados{/if}</p></div>
        	   		<div class="column last bottomPaginator">
						{if $count > 20}
 							<p>viendo del <b>{math equation="x+1" x=$offset} al {math equation="min(x2 +20,c)" x2=$offset c=$count}</b> de {$count}
 								{if $offset > 0}
									<span><a href="?offset={math equation="max(x-20,0)" x=$offset}"><input class="fg-button" type="button" value="< ANTERIORES"/></a></span>
								{/if}
								{if $offset < $count-20}
									<span><a href="?offset={$offset+20}&q={$smarty.request.q}&distancia_min={$smarty.request.distancia_max}&distancia_max={$smarty.request.distancia_max}"><input class="fg-button" type="button" value="SIGUIENTES >"/></a></span>
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
{include file="header.tpl"} 

<!-- GLOBAL CONTAINER RACE -->
	<div class="span-24 raceContainer" id="race">
	
		<!-- RACE & IMAGE -->
		<div class="span-16 first leftColumn">
			<div class="span-16 column raceTitle">
				<div class="span-16 navigationList">
					<ul> 
						<li><a href="calendario.php">Calendario ></a></li>
						<li><a href="carrera.php" class="selected">Resultados de tu búsqueda</a></li>
						<li><a href="#" class="selected">"<b>Carrera popular"</b></a></li>
					</ul>
				</div>
			</div>
			
			<div class="span-16 raceContent1">
				<h2 class="newsTitle3">Resultados de tu búsqueda (12)</h2>
				<div class="raceSearchFirst">
					<div class="searchPanel">
						<div class="labels">
							<div class="searchlabel">Localidad, nombre, etc...</div>
							<div class="searchlabel searchlabel2">Distancia mín / max</div>
						</div>
						<form id="searchForm" method="GET">
							<div class="inputSearch">
			<label class="roundsearch" for="inputsearch1"><span><input type="text" name="q" id="inputsearch1"></span></label>
							</div>
							<div class="inputSearch">
			<label class="roundsearch" for="inputsearch2"><span><input type="text" name="distancia_min" id="inputsearch2"></span></label>
							</div>
							<div class="inputSearch">
			<label class="roundsearch" for="inputsearch3"><span><input type="text" name="distancia_max" id="inputsearch3"></span></label>
							</div>
							<div class="buttonSearch"><input class="fg-button ui-state-default ui-corner-all" type="submit" value="Buscar"/></div>
						</form>
					</div>
					<div class="pagination countAgo countAgo2">
						<div class="pagination">
							<div class="column btnJoin">
							    {if $smarty.request.offset > 0}
							        <a href="?offset={math equation="max(x-20,0)" x=$smarty.request.offset}">Previous</a>
							    {/if}
							    {if $smarty.request.offset < $count-20}
							        <a href="?offset={$smarty.request.offset+20}&q={$smarty.request.q}&distancia_min={$smarty.request.distancia_max}&distancia_max={$smarty.request.distancia_max}">Next</a>
                                {/if}
							        
							    <input class="fg-button ui-state-default ui-corner-all" type="submit" value="<"/></div>
							<div class="column"><input class="fg-button ui-state-default ui-corner-all" type="submit" value=">"/></div>	
						</div>
						<div class="column pagination">viendo del <b>1 al 4</b> de 21</div>			
					</div>
				</div>
				
				<div class="dates">
					<a href="carrera.php" class="nameRace">15- 31 de agosto</a>
				</div>
				<div class="raceDetails" id="raceDetails">
					<div class="column span-1 first date">
						<div class="month">AGO</div>
						<div class="day">01</div>
					</div>
					<div class="column span-6 last nextRaceComment">
						<a href="carrera.php" class="nameRace">XII Carrera de la mujer</a>
						<div class="raceLocation">Madrid | 10km | <b>22 van</b> </div>
					</div>
				</div>
				<div class="raceDetails" id="raceDetails">
					<div class="column span-1 first date">
						<div class="month">AGO</div>
						<div class="day">01</div>
					</div>
					<div class="column span-6 last nextRaceComment">
						<a href="carrera.php" class="nameRace">XII Carrera de la mujer</a>
						<div class="raceLocation">Madrid | 10km | <b>22 van</b> </div>
					</div>
				</div>
				<div class="raceDetails" id="raceDetails">
					<div class="column span-1 first date">
						<div class="month">AGO</div>
						<div class="day">01</div>
					</div>
					<div class="column span-6 last nextRaceComment">
						<a href="carrera.php" class="nameRace">XII Carrera de la mujer</a>
						<div class="raceLocation">Madrid | 10km | <b>22 van</b> </div>
					</div>
				</div>
				<div class="raceDetails" id="raceDetails">
					<div class="column span-1 first date">
						<div class="month">AGO</div>
						<div class="day">01</div>
					</div>
					<div class="column span-6 last nextRaceComment">
						<a href="carrera.php" class="nameRace">XII Carrera de la mujer</a>
						<div class="raceLocation">Madrid | 10km | <b>22 van</b> </div>
					</div>
				</div>
				<div class="datesmiddle">
					<a href="carrera.php" class="nameRace">15- 31 de agosto</a>
				</div>
				<div class="raceDetails" id="raceDetails">
					<div class="column span-1 first date">
						<div class="month">AGO</div>
						<div class="day">01</div>
					</div>
					<div class="column span-6 last nextRaceComment">
						<a href="carrera.php" class="nameRace">XII Carrera de la mujer</a>
						<div class="raceLocation">Madrid | 10km | <b>22 van</b> </div>
					</div>
				</div>
				<div class="raceDetails" id="raceDetails">
					<div class="column span-1 first date">
						<div class="month">AGO</div>
						<div class="day">01</div>
					</div>
					<div class="column span-6 last nextRaceComment">
						<a href="carrera.php" class="nameRace">XII Carrera de la mujer</a>
						<div class="raceLocation">Madrid | 10km | <b>22 van</b> </div>
					</div>
				</div>
				<div class="raceDetails" id="raceDetails">
					<div class="column span-1 first date">
						<div class="month">AGO</div>
						<div class="day">01</div>
					</div>
					<div class="column span-6 last nextRaceComment">
						<a href="carrera.php" class="nameRace">XII Carrera de la mujer</a>
						<div class="raceLocation">Madrid | 10km | <b>22 van</b> </div>
					</div>
				</div>
				<div class="raceDetails" id="raceDetails">
					<div class="column span-1 first date">
						<div class="month">AGO</div>
						<div class="day">01</div>
					</div>
					<div class="column span-6 last nextRaceComment">
						<a href="carrera.php" class="nameRace">XII Carrera de la mujer</a>
						<div class="raceLocation">Madrid | 10km | <b>22 van</b> </div>
					</div>
				</div>
				<div class="raceDetails" id="raceDetails">
					<div class="column span-1 first date">
						<div class="month">AGO</div>
						<div class="day">01</div>
					</div>
					<div class="column span-6 last nextRaceComment">
						<a href="carrera.php" class="nameRace">XII Carrera de la mujer</a>
						<div class="raceLocation">Madrid | 10km | <b>22 van</b> </div>
					</div>
				</div>
				<div class="raceDetails" id="raceDetails">
					<div class="column span-1 first date">
						<div class="month">AGO</div>
						<div class="day">01</div>
					</div>
					<div class="column span-6 last nextRaceComment">
						<a href="carrera.php" class="nameRace">XII Carrera de la mujer</a>
						<div class="raceLocation">Madrid | 10km | <b>22 van</b> </div>
					</div>
				</div>
				<div class="raceDetails" id="raceDetails">
					<div class="column span-1 first date">
						<div class="month">AGO</div>
						<div class="day">01</div>
					</div>
					<div class="column span-6 last nextRaceComment">
						<a href="carrera.php" class="nameRace">XII Carrera de la mujer</a>
						<div class="raceLocation">Madrid | 10km | <b>22 van</b> </div>
					</div>
				</div>
				<div class="raceDetailsBottom" id="raceDetails">
					<div class="column span-1 first date">
						<div class="month">AGO</div>
						<div class="day">01</div>
					</div>
					<div class="column span-6 last nextRaceComment">
						<a href="carrera.php" class="nameRace">XII Carrera de la mujer</a>
						<div class="raceLocation">Madrid | 10km | <b>22 van</b> </div>
					</div>
				</div>
				<div class="raceSearchLast">
					<div class="searchPanel">
						<div class="pagination countAgo">
						<div class="pagination">
							<div class="column btnJoin"><input type="Button" value="<" class="btn btnsearchBlue"></div>
							<div class="column"><input type="Button" value=">" class="btn btnsearchBlue"></div>	
						</div>
						<div class="column pagination">viendo del <b>1 al 4</b> de 21</div>			
					</div>
					</div>
				</div>
			</div>	
						
		</div>
		
		
		<!-- RIGHT COLUMN -->
		<div class="column span-8 last rightColumn">

			<div class="span-8 importantRaces">
				<div class="events"> 
					<h2 class="newsTitle">Próximas carreras</h2>
				</div>	
				<div class="events">
            		{foreach key=id item=race from=$nextRaces}
            			{if $race eq "false"}
            				<div class="span-8 races">No hay proximas carreras.</div> 
            			{else}		    				    
        					<div class="raceDetails" id="raceDetails">
        						<div class="column span-1 first date">
        							<div class="month">AGO</div>
        							<div class="day">01</div>
        						</div>
        						<div class="column span-6 last nextRaceComment">
        							<a href="carrera.php?id={$race.id}" class="nameRace">{$race.name}</a>
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
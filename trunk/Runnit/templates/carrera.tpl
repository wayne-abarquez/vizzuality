{include file="header.tpl"} 

<!-- GLOBAL CONTAINER RACE -->
	<div class="span-24 raceContainer" id="race">
	
		<!-- RACE & IMAGE -->
		<div class="span-16 first leftColumn">
			<div class="span-16 column raceTitle">
				<div class="span-16 navigationList">
					<ul> 
						<li><a href="/">Inicio ></a></li>
						<li><a href="#" class="selected">detalle de carrera</a></li>
					</ul>
				</div>
				
				<div class="span-16 first">
					<div class="span-1 first calendar">
						<div class="month monthRace">{getMonth month=$data.event_date|substr:5:2}</div>
						<div class="day dayRace">{$data.event_date|substr:8:2}</div>
					</div>
					<div class="span-14 last">
						<p class="raceTitle">{$data.name}</p>
						<p class="raceDetailsTitle">{$data.event_location} | {$data.distance_text} | <b>{$data.num_users} usuarios van</b>, <a href="" class="special">apúntate</a></p>
					</div>
				</div>
			</div>
			
			<img src="/media/run/{$data.big_picture}" class="carrera">
			
			<div class="span-16 raceContent">
			
				<div class="span-6 first">
					<div class="span-6 boxrace last">
						<h3 class="blue">Datos técnicos</h3>
						<div class="span-6 databox">
							<div class="span-2 last distance"><p>Distancia:</p></div>
							<div class="span-4 last distanceInfo"><p><b>{$data.distance_text},</b> <a href="#map2Container" class="special">ver mapa</a></p></div>
						</div>
						<div class="span-6 databox">
							<div class="span-2 last distance"><p>Categorias:</p></div>
							<div class="span-4 last distanceInfo"><p><b>{$data.category}</b></p></div>
						</div>
						<div class="span-6 databox">
							<div class="span-2 last distance"><p>Premios:</p></div>
							<div class="span-4 last distanceInfo"><p><b>{$data.awards}</b></p></div>
						</div>
					</div>
					<div class="span-6 boxrace last">
						<h3 class="blue">Inscripciones</h3>
						<div class="span-6 databox">
							<div class="span-2 last distance"><p>Precio:</p></div>
							<div class="span-4 last distanceInfo"><p><b>{$data.inscription_price}</b></p></div>
						</div>
						<div class="span-6 databox">
							<div class="span-2 last distance"><p>Presencial:</p></div>
							<div class="span-4 last distanceInfo"><p><b>{$data.inscription_location}</b></p></div>
						</div>
						<div class="span-6 databox">
							<div class="span-2 last distance"><p class="textRace">E-mail:</p></div>
							<div class="span-4 last distanceInfo"><p><a href="" class="special">{$data.inscription_email}</a></p></div>
						</div>
						<div class="span-6 databox">
							<div class="span-2 last distance"><p class="textRace">Web:</p></div>
							<div class="span-4 last distanceInfo"><p><a href="{$data.inscription_website}" class="special">{$data.inscription_website}</a></p></div>
						</div>	
						<div class="span-6 databox noborder">
							<div class="span-2 last distance"><p class="textRace">Teléfono:</p></div>
							<div class="span-4 last distanceInfo"><p><a href="{$data.inscription_website}" class="special">{$data.inscription_website}</a></p></div>
						</div>					
					</div>
				</div>

				<div class="span-10 last">
					<div class="marginDescription"><h3 class="blue">Descripción</h3></div>
					<div class="marginDescription">
						<p class="textRace">{$data.description}</p>
					</div>	
				</div>	
					
				<div id="map2Container" class="span-16">
					<div class="marginDescription margin10"><h3 class="blue">Mapa del recorrido</h3></div>
					<div class="mapStyle marginDescription">
						<div id="map2"><img src="http://maps.google.com/staticmap?size=598x250&maptype=map&markers={$data.start_point_lat},{$data.start_point_lon},greens%7C{$data.end_point_lat},{$data.end_point_lon},bluem&sensor=false&key=ABQIAAAAtDJGVn6RztUmxjnX5hMzjRTy9E-TgLeuCHEEJunrcdV8Bjp5lBTu2Rw7F-koeV8TrxpLHZPXoYd2BA"></div>
					</div>
				</div>
					
				<div class="span-16 marginDescription">
					<div class="marginDescription"><h3 class="blue">Comentarios[{$comments|@count}]</h3><h5>publicar un comentario</h5></div>			
					<ol id="update">
						{foreach key=id item=comment from=$comments}
	    				{if $comment eq false}
	    					<div class="column span-15 noCommentsContainer">
	        					<div class="carita"></div>
	        					<div class="noResultsText">
	        					<p class="noResults"><b>Aún no hay comentarios sobre esta carrera</b></p>
	        					<p class="noResultsSub">Pero si quieres puedes <a href="/rss.php">subscribirte a nuestro RSS</a> para estar al tanto de todo lo ocurrido en runnity</p>
								</div>
	        				</div>  
	    				{else}	    										
							<div class="column span-16 first racesComment">				
								<div class="column span-3 first image">
									<img src="/media/avatar/{$comment.avatar}"/>	
								</div>
								<div class="column span-12 last commentBox">
									<div class="nameUser"><a class="nameRace" href="#">{$comment.username}, </a>{elapsed_time timestamp=$comment.created_when|substr:0:13}</div>
									<p class="textRace">{$comment.commenttext}</p>
								</div>
							</div>							
	              		{/if}
	                	{foreachelse}
	                	    <div class="column span-15 noCommentsContainer">
	        					<div class="carita"></div>
	        					<div class="noResultsText">
	        					<p class="noResults"><b>Aún no hay comentarios sobre esta carrera</b></p>
	        					<p class="noResultsSub">Pero si quieres puedes <a href="/rss.php">subscribirte a nuestro RSS</a> para estar al tanto de todo lo ocurrido en runnity</p>
								</div>
	        				</div>    
	                	{/foreach}						
					</ol>
				</div>
				
				<!-- PARA AÑADIR COMENTARIOS -->
				<div class="span-16 boxraceMap">
					<div class="span-16" id="flash" align="left"></div>
					<div class="commentArea" id="commentBox">					
						{if $smarty.session}
							<div class="span-14 titleComents">Anímate y publica tu comentario</div>
							<textarea name="textarea2" id="commentTextArea" class="span-15 textArea"></textarea>
							<input class="fg-button ui-state-default ui-corner-all" type="submit" value="Publicar comentario" onclick="javascript: void commentAction({$smarty.request.id})"/>
						{else}
							<p class="noComments">Para realizar comentarios debes <b><a href="javascript: void showLoginBox()">iniciar tu sesión</a></b> en runnity. <b><a href="javascript: void showRegisterBox()">¿Aún no estás registrado?</a></b></p>
						{/if}
					</div>
				</div>		
			</div>				
		</div>
		
		
		<!-- RIGHT COLUMN -->
		<div class="column span-8 last rightColumn">
			<div class="span-8 importantRaces">
				<div class="events"> 
					<div><h2 class="newsTitle">Localización</h2></div>
					<div id="map" class="mapStyle">
					<img src="http://maps.google.com/staticmap?size=270x152&maptype=map&zoom=10&markers={$data.end_point_lat},{$data.end_point_lon},bluem%7C{$data.start_point_lat},{$data.start_point_lon},greens&sensor=false&key=ABQIAAAAtDJGVn6RztUmxjnX5hMzjRTy9E-TgLeuCHEEJunrcdV8Bjp5lBTu2Rw7F-koeV8TrxpLHZPXoYd2BA">
					</div>
				</div>
			</div>
	
			<div class="span-8 importantRaces">
				<div class="events"> 
					<h2 class="newsTitle">En las mismas fechas</h2>
				</div>
				<div class="events">
            		{foreach key=id item=race from=$nextRaces}
            			{if $race eq "f"}
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
					<input class="fg-button ui-state-default ui-corner-all" type="submit" value="Ver calendario completo"/>
				</div>
			</div>
		
			
			<div class="span-8 marginTopPlus">
				<div class="events"> 
					<h2 class="newsTitle">Valientes apuntados</h2>	
					{foreach key=id item=person from=$runners}
    				{if $person eq 'f'}
    					<div class="span-8 races2"><p>No hay valientes.</p></div> 
    				{else}					
    					<div class="span-8 races2 defaultWidth">
    						<div class="column first image">
    							<img src="/media/avatar/{$person.avatar}"/>	
    						</div>
    						<div class="column last">
    							<div class="detailsUser">
    								<div class="nameUser"><a class="nameRace" href="#">{$person.username}</a></div>
    								<div class="raceUserDetails"> dice que va a ir a esta carrera</div>
    							</div>
    							<div><p class="runnersNumber"><a href="">apúntate con él</a></p></div>
    						</div>
    					</div>
        			{/if}
        		    {foreachelse}
        		        <div class="span-8 races2">No hay valientes.</div>    
        		    {/foreach}					
				</div>
			</div>	
			<!--<div class="flickrFrame">
			    <iframe align="center" src="http://www.flickr.com/slideShow/index.gne?" frameBorder="0" width="280" scrolling="no" height="280"></iframe>
			</div>-->
			
		</div>
	</div>
</div>

{include file="footer.tpl"} 
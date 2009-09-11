{include file="header.tpl"} 



<!-- GLOBAL CONTAINER RACE -->
	<div class="span-24 raceContainer" id="race">
	
		<!-- INSCRIPTION CONFIRMATION WINDOW -->
		<div id="confirmationWindow" style='display:none'>
			<h2 id="titleConfirmation" class="registerTitle">¿Quieres inscribirte a esta carrera?</h2>
			<div class="column span-9 first" id="confirmationButtons">
				<div class="column span-6 first apuntarteButton"><input id="confirmationButtonRace" class="fg-button" type="submit" value="Si, claro" onclick="javascript: void inscribirseCarrera({$smarty.session.user.id},{$smarty.request.id})"/></div>
				<div class="column span-2 last apuntarteButton2"><input class="fg-button" type="submit" value="No, ahora no" onclick="$.modal.close();"/></div>
			</div>
		</div>
	
		<!-- RACE & IMAGE -->
		<div class="span-16 first leftColumn">
			<div class="span-16 column raceTitle">
				<div class="span-16 navigationList top">
					<ul> 
						<li><a href="/">Inicio ></a></li>
						<li><a href="#" class="selected">detalle de carrera</a></li>
					</ul>
				</div>
				
				<div class="span-16 first">
					<div class="column span-1 first date race calendar">
					        <div class="month month{$data.run_type}">{getMonth month=$data.event_date|substr:5:2}</div>
	    					<div class="day">{$data.event_date|substr:8:2}</div>
	    			</div>

					<div class="span-14 last">
						<p class="raceTitle" id="raceTitle">{$data.name}</p>
						<p class="raceDetailsTitle">{$data.event_location} | {$data.distance_text} | <b>{$data.num_users} usuarios van</b>,
						<input id="inscriptionButton" class="fg-button" type="button" value="{if $data.inscrito eq 'f'}apúntate{else}voy a ir{/if}" onclick="javascript: void checkInscrito({if $smarty.session.logged}'ok'{else}'ko'{/if})"/>					
						
						</p>
					</div>
				</div>
			</div>
			
			{if $data.flickr_img_id === null}
			    <img src="/media/run/{$data.big_picture}" class="carrera" />
			{else}
			<a href="{$data.flickr_url}" target="_blank"><img src="/panoramioPic.php?id={$data.id}&photo_id={$data.flickr_img_id}" class="carrera" /></a>
			{/if}
			<div class="span-16 raceContent">
			
				<div class="span-6 first">
					{if $data.distance_text != null or $data.category != null or $data.awards != null}
						<div class="span-6 boxrace last">
							<h3 class="blue">Datos técnicos</h3>
							{if $data.distance_text != null}
							<div class="span-6 databox">
								<div class="span-2 last distance"><p>Distancia:</p></div>
								<div class="span-4 last distanceInfo"><p><b>{$data.distance_text},</b> <a href="#map2Container" class="special">ver mapa</a></p></div>
							</div>
							{/if}
							{if $data.event_date != null}
							<div class="span-6 databox">
								<div class="span-2 last distance"><p>Hora:</p></div>
								<div class="span-4 last distanceInfo"><p><b>{$data.event_date|substr:11:5}</b></p></div>
							</div>
							{/if}
							{if $data.category != null}
							<div class="span-6 databox">
								<div class="span-2 last distance"><p>Categorias:</p></div>
								<div class="span-4 last distanceInfo"><p><b>{$data.category}</b></p></div>
							</div>
							{/if}
							{if $data.awards != null}
							<div class="span-6 databox">
								<div class="span-2 last distance"><p>Premios:</p></div>
								<div class="span-4 last distanceInfo"><p><b>{$data.awards}</b></p></div>
							</div>
							{/if}
						</div>
					{/if}
					<div class="span-6 boxrace last">
						{if $data.inscription_price != null or $data.inscription_location != null
							or $data.inscription_email != null or $data.inscription_website != null
							or $data.tlf_informacion != null}
							<h3 class="blue">Inscripciones</h3>
							{if $data.inscription_price != null}
							<div class="span-6 databox">
								<div class="span-2 last distance"><p>Precio:</p></div>
								<div class="span-4 last distanceInfo"><p><b>{$data.inscription_price}</b></p></div>
							</div>
							{/if}
							{if $data.inscription_location != null}
							<div class="span-6 databox">
								<div class="span-2 last distance"><p>Lugar:</p></div>
								<div class="span-4 last distanceInfo"><p><b>{$data.inscription_location}</b></p></div>
							</div>
							{/if}
							{if $data.inscription_email != null}
							<div class="span-6 databox">
								<div class="span-2 last distance"><p class="textRace">E-mail:</p></div>
								<div class="span-4 last distanceInfo"><p><a id="datos1" href="mailto:{$data.inscription_email}" class="special">{$data.inscription_email}</a></p></div>
							</div>
							{/if}
							{if $data.inscription_website != null}
							<div class="span-6 databox">
								<div class="span-2 last distance"><p class="textRace">Web:</p></div>
								<div class="span-4 last distanceInfo"><p><a target="_blank" id="datos2" href="{$data.inscription_website}" class="special">{$data.inscription_website}</a></p></div>
							</div>	
							{/if}
							{if $data.tlf_informacion != null}
							<div class="span-6 databox noborder">
								<div class="span-2 last distance"><p class="textRace">Teléfono:</p></div>
								<div class="span-4 last distanceInfo"><p><a id="datos3" href="" class="special">{$data.tlf_informacion}</a></p></div>
							</div>	
							{/if}
						{/if}
						<div class="span-6 boxrace last">
						    <h3 class="blue">Compartir</h3>
						    <div class="span-4 last compartir">
                            	<a target=_blank href="http://www.facebook.com/share.php?u=http://www.runnity.com/run/{$data.id}/{$data.name|replace:' ':'/'}"><img src="/img/ico_facebook.gif" alt="Facebook"></a>&nbsp;
                            	<a target=_blank href="http://del.icio.us/post?title=&url=http://www.runnity.com/run/{$data.id}/{$data.name|replace:' ':'/'}"><img src="/img/ico_delicious.gif" alt="delicious"></a>&nbsp;
                            	<a target=_blank href="http://meneame.net/submit.php?url=http://www.runnity.com/run/{$data.id}/{$data.name|replace:' ':'/'}"><img src="/img/ico_meneame.gif" alt="meneame"></a>
                                <a target=_blank href="http://twitter.com/home?status=http://www.runnity.com/run/{$data.id}/{$data.name|replace:' ':'/'}"><img src="/img/ico_twitter.png" alt="twitter"></a>	
                                <a target=_blank href="http://digg.com/submit?phase=2&url={$data.id}/{$data.name|replace:' ':'/'}"><img src="/img/ico_digg.png" alt="Facebook"></a>&nbsp;				        
						    </div>	    
						</div>					
					</div>
				</div>

				<div class="span-10 last">
					<div class="marginDescription"><h3 class="blue">Descripción</h3></div>
					<div class="marginDescription">
						<p class="textRace">
							{if $data.description!=null}
								{$data.description}
							{else}
								No hay descripción para esta carrera, te animas a <a href="javascript: void showContactBox()">enviarnos una?</a>
							{/if}	
						</p>
					</div>	
				</div>	
				
                {if $data.start_point_lat == null}
                	<div id="map3Container" class="span-16"></div>
                {else}	
                <a name="map2Container">		
					<div class="span-16">
						<div class="marginDescription margin10"><h3 class="blue">Mapa del recorrido aproximado</h3></div>
						<div class="mapStyle marginDescription">
							<div id="trackMap">
	                            <object id="flashMovie" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="609" height="400" wmode="opaque" flashvars="id={$data.id}">
	                              <param name="movie" value="/flash/raceMapViewer.swf?2" />
	                              <!--[if !IE]>-->
	                              <object type="application/x-shockwave-flash" data="/flash/raceMapViewer.swf" width="609" height="400" wmode="opaque" flashvars="id={$data.id}">
	                              <!--<![endif]-->

	                              <!--[if !IE]>-->
	                              </object>
	                              <!--<![endif]-->
	                            </object>		    					    
							</div>
						</div>	
					</div>
				</a>
				{/if}	
				
				<!-- GALLERY -->
				<!-- required CSS files -->

				<div class="navi"></div>
				<div class="span-10">
	
					<!-- "previous page" action -->
					<a class="column span-1 first prevPage browse left"></a>
					
					<!-- root element for scrollable -->
					<div class="column span-7 spascrollable" id="browsable">	
						
						<div class="items">
						
							<img src="http://farm1.static.flickr.com/143/321464099_a7cfcb95cf_t.jpg" />
							<img src="http://farm4.static.flickr.com/3089/2796719087_c3ee89a730_t.jpg" />
							<img src="http://farm1.static.flickr.com/79/244441862_08ec9b6b49_t.jpg" />
					
							<img src="http://farm1.static.flickr.com/28/66523124_b468cf4978_t.jpg" />
							<img src="http://farm1.static.flickr.com/164/399223606_b875ddf797_t.jpg" />
							
							<img src="http://farm1.static.flickr.com/163/399223609_db47d35b7c_t.jpg" />
							<img src="http://farm1.static.flickr.com/135/321464104_c010dbf34c_t.jpg" />
							<img src="http://farm1.static.flickr.com/40/117346184_9760f3aabc_t.jpg" />
							<img src="http://farm1.static.flickr.com/153/399232237_6928a527c1_t.jpg" />
							<img src="http://farm1.static.flickr.com/50/117346182_1fded507fa_t.jpg" />
												
							<img src="http://farm4.static.flickr.com/3629/3323896446_3b87a8bf75_t.jpg" />
							<img src="http://farm4.static.flickr.com/3023/3323897466_e61624f6de_t.jpg" />
							<img src="http://farm4.static.flickr.com/3650/3323058611_d35c894fab_t.jpg" />
							<img src="http://farm4.static.flickr.com/3635/3323893254_3183671257_t.jpg" />
							<img src="http://farm4.static.flickr.com/3624/3323893148_8318838fbd_t.jpg" />
						</div>
						
					</div>
					
					<!-- "next page" action -->
					<a class="column span-1 last nextPage browse right"></a>
					
					
				</div>
				<!-- javascript coding -->
				{literal}
				<script>
				$(document).ready(function() {
					$("#browsable").scrollable().navigator();	
				});
				</script>
				{/literal}



				
				<!-- END GALLERY -->
				
				
				
				
				
				
				
				
				<div class="span-16 marginDescription marginTop7">
					<div class="marginDescription"><h3 class="blue">Comentarios {if !empty($comments)}[{$comments|@count}]{/if}</h3><h5><a onclick="document.getElementById('commentTextArea').focus();
" class="PublicarComentarioEnlace">publicar un comentario</a></h5></div>			
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
									<div class="nameUser"><a class="nameRace" href="#">{$comment.username}, </a>hace {$comment.created_when|timeAgo}</div>
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
						{if $smarty.session.logged}
							<div class="span-14 titleComents">Anímate y publica tu comentario</div>
							<textarea name="textarea2" id="commentTextArea" class="span-15 textArea"></textarea>
							<input class="fg-button" type="submit" value="Publicar comentario" onclick="javascript: void commentAction({$smarty.request.id},'run')"/>
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
					<div><h2 class="newsTitle">En la zona...</h2></div>
					<div id="map" class="mapStyle">
			            <object id="aroundMap" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="270" height="152" wmode="opaque" flashvars="id={$data.id}">
			              <param name="movie" value="/flash/RunAroundMap.swf?6" />
			              <!--[if !IE]>-->
			              <object type="application/x-shockwave-flash" data="/flash/RunAroundMap.swf?6" width="270" height="152" wmode="opaque" flashvars="id={$data.id}">
			              <!--<![endif]-->
							    {if $data.start_point_lat === null}
		<img width="270" height="152" src="http://maps.google.com/maps/api/staticmap?size=270x152&maptype=map&zoom=10&center={$data.event_location},spain&sensor=false&key=ABQIAAAAtDJGVn6RztUmxjnX5hMzjRTy9E-TgLeuCHEEJunrcdV8Bjp5lBTu2Rw7F-koeV8TrxpLHZPXoYd2BA" />					    
							    {else}
							<img src="http://maps.google.com/staticmap?size=270x152&maptype=map&zoom=10&markers={if $data.end_point_lat}{$data.end_point_lat},{$data.end_point_lon},bluem%7C{/if}{$data.start_point_lat},{$data.start_point_lon},greens&sensor=false&key=ABQIAAAAtDJGVn6RztUmxjnX5hMzjRTy9E-TgLeuCHEEJunrcdV8Bjp5lBTu2Rw7F-koeV8TrxpLHZPXoYd2BA">
							    {/if}
			              <!--[if !IE]>-->
			              </object>
			              <!--<![endif]-->
			            </object>						
					</div>
				</div>
			</div>
	
	        {if $runsInSameDates}
			<div class="span-8 importantRaces">
				<div class="events"> 
					<h2 class="newsTitle">En las mismas fechas</h2>
				</div>
				<div class="events">
            		{foreach key=id item=race from=$runsInSameDates}	    				    
        					<div class="span-8 column first raceDetails" id="raceDetails">
        						<div class="column span-1 first date">
	    					        <div class="month month{$race.run_type}">{getMonth month=$race.event_date|substr:5:2}</div>
	    							<div class="day">{$race.event_date|substr:8:2}</div>
	    						</div>
        						<div class="column span-6 last calendarRaces">
        							<div class="nextRaceComment"><a href="/run/{$race.id}/{$race.name|replace:' ':'/'}" class="nameRace">{$race.name}</a></div>
        							<div class="raceLocation">{$race.event_location} | {$race.distance_text} | <b>{$race.num_users} van</b> </div>
        						</div>
        					</div>
                	    {/foreach}					
				</div>
			</div>
			{/if}
			{if $similarTypeRaces}
			<div class="span-8 importantRaces">
				<div class="events"> 
					<h2 class="newsTitle">De distancia parecida</h2>
				</div>
				<div class="events">
            		{foreach key=id item=race from=$similarTypeRaces}    				    
        					<div class="span-8 column first raceDetails" id="raceDetails">
        						<div class="column span-1 first date">
	    							<div class="month month{$race.run_type}">{getMonth month=$race.event_date|substr:5:2}</div>
	    							<div class="day">{$race.event_date|substr:8:2}</div>
	    						</div>
        						<div class="column span-6 last calendarRaces">
        							<div class="nextRaceComment"><a href="/run/{$race.id}/{$race.name|replace:' ':'/'}" class="nameRace">{$race.name}</a></div>
        							<div class="raceLocation">{$race.event_location} | {$race.distance_text} | <b>{$race.num_users} van</b> </div>
        						</div>
        					</div>
                	    {/foreach}					
				</div>
			</div>
            {/if}
            <div class="span-8">
	            <div class=" events2">
				    <input class="fg-button VerCalendario" type="button" value="Ver calendario completo" onclick="location='/buscar'"/>
				</div>  
            </div>
			  
			
			<div class="span-8 marginTopPlus">
				<div class="events"> 
					<h2 class="newsTitle">Valientes apuntados</h2>	
					{foreach key=id item=person from=$runners}
    				{if $person eq 'f'}
    					<div class="span-8 races2">
    						<p class="noApuntado">Aun no hay ningún valiente</p>
							<p class="noRaceSub">¿Quieres ser el primero? <b><a href="/rss.php">Apúntate</a></b></p>
						</div> 
    				{else}					
    					<div class="span-8 races2 defaultWidth">
    						<div class="column first image2">
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
        		        <div class="span-8 races2">
    						<p class="noApuntado">Aun no hay ningún valiente</p>
							<p class="noRaceSub">¿Quieres ser el primero? <b><a href="/rss.php">Apúntate</a></b></p>
						</div>     
        		    {/foreach}					
				</div>
			</div>	
			<!--<div class="flickrFrame">
			    <iframe align="center" src="http://www.flickr.com/slideShow/index.gne?" frameBorder="0" width="280" scrolling="no" height="280"></iframe>
			</div>-->
			
		</div>
	</div>
</div>


{literal}
<script language="javaScript" type="text/javascript">
	$(document).ready( function() {
	    
	    for (i=1;i<=3;i++){
			var len = 20;
			var p = document.getElementById("datos" + i);
			
			if (p) {
			  var trunc = p.innerHTML;
			  trunc = trunc.replace(/\t/g, "");
			  if (trunc.length > len) {
				
			    trunc = trunc.substring(0, len);
			
			    trunc += '<a style="color: #666666;">' +
			      '...<\/a>';
			    p.innerHTML = trunc;
			  }
			}
		}
	    
	    
	});
</script>
{/literal}

{include file="footer.tpl"}
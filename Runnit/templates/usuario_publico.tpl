{include file="header.tpl"} 

	<div class="span-24 raceContainer" id="race">
		<div class="column span-16">
			<div class="span-16 navigationList">
				<ul> 
					<li><a href="">Panel de control ></a></li>
					<li><a href="" class="selected">Preferencias de usuario</a></li>
				</ul>
			</div>
			<div class="span-16 marginContainer">
				<div class="column span-3 first">
					<img id="userImg" src="/avatar.php?id={$data.datos.id}"/>
				</div>
				<div class="span-13 last userLeft">
					<div class="span-13 userCount">
						<div class="wellcome"><a href="#" class="wellcome">{$data.datos.completename}</a></div>
						<div class="countAgo">usuario desde {getMonth2 month=$data.datos.created_when|substr:5:2}, {$data.datos.created_when|substr:0:4}</div>
					</div>
				</div>
			</div>
				<div class="span-16 marginContainer">

					<div class="marginDescription"><h3 class="blue">Perfil</h3></div>					
				
				
					<div class="marginDescription"><h3 class="blue">Tablón {if !empty($comments)}[{$comments|@count}]{/if}</h3><h5><a onclick="document.getElementById('commentTextArea').focus();
" class="PublicarComentarioEnlace">Dejar un comentario</a></h5></div>			
					<ol id="update">
						{foreach key=id item=comment from=$comments}
	    				{if $comment eq false}
	    					<div class="column span-15 noCommentsContainer"  id="noCommentsDiv">
	        					<div class="carita"></div>
	        					<div class="noResultsText">
	        					<p class="noResults"><b>Aún no hay comentarios en el tablón de {$data.datos.username}</b></p>
								</div>
	        				</div>  
	    				{else}	    										
							<div class="column span-16 first racesComment">				
								<div class="column span-3 first image">
									<img src="/avatar.php?id={$comment.user_id}"/>	
								</div>
								<div class="column span-12 last commentBox">
									<div class="nameUser"><a class="nameRace" href="#">{$comment.username}, </a>hace {$comment.created_when|timeAgo}</div>
									<p class="textRace">{$comment.commenttext}</p>
								</div>
							</div>							
	              		{/if}
	                	{foreachelse}
	                	    <div class="column span-15 noCommentsContainer" id="noCommentsDiv">
	        					<div class="carita"></div>
	        					<div class="noResultsText">
	        					<p class="noResults"><b>Aún no hay comentarios en el tablón de {$data.datos.username}</b></p>
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
						<div class="span-14 titleComents">Anímate y deja un comentario a {$smarty.session.user.username}</div>
						<textarea name="textarea2" id="commentTextArea" class="span-15 textArea"></textarea>
						<input class="fg-button" type="submit" value="Escribir comentario" onclick="javascript: void commentAction({$data.datos.id},'users')"/>
					{else}
						<p class="noComments">Para dejar comentarios debes <b><a href="javascript: void showLoginBox()">iniciar tu sesión</a></b> en runnity. <b><a href="javascript: void showRegisterBox()">¿Aún no estás registrado?</a></b></p>
					{/if}
				</div>
			</div>		
		</div>
		
		<div class="column last span-8 rightColumn">
			<div class="span-8 importantRaces">
				<div class="events"> 
					<h2 class="newsTitle5">Carreras de {$data.datos.username}</h2>
				</div>
				<div class="events">
            		{foreach key=id item=race from=$data.carreras}
            			{if $race eq 0}
            				<div class="span-8 races2"><p class="noApuntadoUser">Aun no te has apuntado a ninguna carrera.</p></div> 
            			{else}		    				    
        					<div class="span-8 column first raceDetails" id="raceDetails">
        						<div class="column span-1 first date race">
	    							<div class="month month{$race.run_type}">{getMonth month=$race.event_date|substr:5:2}</div>
	    							<div class="day">{$race.event_date|substr:8:2}</div>
	    						</div>
        						<div class="column span-6 last calendarRaces">
        							<div class="nextRaceComment"><a href="/run/{$race.id}/{$race.name|replace:' ':'/'}" class="nameRace">{$race.name}</a></div>
        							<div class="raceLocation">{$race.event_location} | {$race.distance_text} | <b>{$race.num_users} van</b> </div>
        						</div>
        					</div>
            			{/if}
                	    {foreachelse}
                	        <div class="span-8 races2"><p class="noApuntadoUser">Aun no te has apuntado a ninguna carrera.</p></div> 
                	    {/foreach}					
				</div>
			</div>
		</div>
	</div>
</div>

{include file="footer.tpl"}
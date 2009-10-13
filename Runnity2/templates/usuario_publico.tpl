{include file="header.tpl"}

<div class="span-24 column content">

	<div class="span-1 last leftColumn">
		
<div class="span-1 columnNameUser"><p class="nameUserProfile">{$data.datos.completename}<span class="nameUserProfileNick">, ({$data.datos.username})</span></div>
		<div class="globalContainerUser">	
			<div class="span-1 last userData">
				<div class="span-1 avatarPerfil">
					<img class="imgAvatarPerfil" src="/img/AvatarPerfil.jpg">
				</div>
				<div class="span-1 last functionalContainer">
				<p class="titulo tituloLeft">RANKING RUNNITY</p>
					<div class="span-1 last dataContainerUser">
						<div class="span-1 last dataTitleUserRanking"><p>800m:</p></div>
						<div class="span-1 last dataUserRanking"><p><b>2:02:00 (2006)</b></p></div>
						<div class="span-1 last dataUserPosition"><div class="rankingBox"><p>17º</p></div></div>
					</div>
					<div class="span-1 last dataContainerUser">
						<div class="span-1 last dataTitleUserRanking"><p>1.500m:</p></div>
						<div class="span-1 last dataUserRanking"><p><b>2:02:00 (2006)</b></p></div>
						<div class="span-1 last dataUserPosition"><div class="rankingBox"><p>17º</p></div></div>
					</div>
					<div class="span-1 last dataContainerUser">
						<div class="span-1 last dataTitleUserRanking"><p>10.000m:</p></div>
						<div class="span-1 last dataUserRanking"><p><b>2:02:00 (2006)</b></p></div>
						<div class="span-1 last dataUserPosition"><div class="rankingBox"><p>17º</p></div></div>
					</div>
				</div>
				<div class="span-1 last functionalContainer">
				<p class="titulo tituloLeft">DATOS PERSONALES</p>
					<div class="span-1 last dataContainerUser">
						<div class="span-1 last dataTitleUserProfile"><p>Club:</p></div>
						<div class="span-1 last dataUserProfile"><p><b>S.S. de los Reyes - Clínicas Menorca</b></p></div>
					</div>
					<div class="span-1 last dataContainerUser">
						<div class="span-1 last dataTitleUserProfile"><p>Categoría:</p></div>
						<div class="span-1 last dataUserProfile"><p><b>Senior Masculino</b></p></div>
					</div>
				</div>
			</div>
			
			<div class="span-1 last imagesUserContainer">
				<p class="titulo tituloLeft tituloRight">FOTOS DE {$data.datos.username|upper} [42], <a>ver todas</a></p>
				<div class="imagesUser">
					<img src="/img/avatar.jpg"/>	
				</div>
				<div class="imagesUser">
					<img src="/img/avatar.jpg"/>	
				</div>
				<div class="imagesUser">
					<img src="/img/avatar.jpg"/>	
				</div>
				<div class="imagesUser">
					<img src="/img/avatar.jpg"/>	
				</div>
				<div class="imagesUser">
					<img src="/img/avatar.jpg"/>	
				</div>
			</div>
			
			<div class="span-1 last commentsUser">
				<p class="titulo tituloLeft tituloRight">MENSAJES PARA {$data.datos.username|upper} {if !empty($comments)}[{$comments|@count}]{/if}</p>
				
				<div class="span-1 last columnComments">

				<ol id="update">
				{foreach key=id item=comment from=$comments}
					{if $comment eq false}
	
					{else}   										
						<div id="commentUser" class="span-1 last">
							<div class="span-1 last avatarBox">
								<img src="/img/avatar.jpg"/>	
							</div>
							<div class="span-1 commentBoxUser">
							<div class="nameUser"><a class="name" href="/user/{$comment.username}">{$comment.username}, </a>hace {$comment.created_when|timeAgo}</div>
							<p class="commentUserProfile">{$comment.commenttext}</p>
							</div>
							
						</div>							
	          		{/if}
            	{foreachelse}
					<div class="span-1 noComments">

    				</div>    
            	{/foreach}
            	</ol>
				</div>
				
				
				<!-- Crear servicio para los comentarios sobre usuario -->
				<!--
<div class="span-9 commentsPaginator">
        	   		<div class="userComments">
						<p>viendo del <b>1 al 5</b> de 60
							<span><a><input class="fg-button buttonLeftArrow" type="button"/></a></span>
							<span><a><input class="fg-button buttonRightArrow" type="button"/></a></span>
						</p>	
					</div>
				</div>
-->

			</div>
		</div>
	</div>
	

	<!-- RIGHT COLUMN -->
	<div class="span-1 last rightColumn userRightColumn">
		{if $nextRaces}
		<div class="span-1 functionalContainer">
			<p class="titulo tituloLeft tituloColumnRight">SUS PRÓXIMAS CARRERAS</p>
			<div class="events">
				{foreach key=id item=race from=$nextRaces name=raceloop}	    				    
					<div class="span-1 {cycle values="raceRight,raceRight2"}">
						<div class="span-1 first dateRight calendarRight">
					        <div class="month month{$race.run_type}">{getMonth month=$race.event_date|substr:5:2}</div>
							<div class="day">{$race.event_date|substr:8:2}</div>
						</div>
						{if $race.num_users > 0}
							<div class="ticketBlue"><p>{$race.num_users}</p></div>
							<div class="ticketBlueCorner ticketBlueCornerRight"></div>
						{/if}		
						<div class="span-1 last dataRaceRight">
							<div class="nameRaceRight"><a id="nameRunRight1{$smarty.foreach.raceloop.iteration}" href="/run/{$race.id}/{$race.name|replace:' ':'/'}">{$race.name}</a></div>
							<div class="dataRaceRight"><p>{$race.event_location} | {$race.distance_text}</p></div>
						</div>	
					</div>
					<div class="span-1 last separatorRight"></div>
			    {/foreach}
			</div>
		</div>
		{/if}
		
		<div class="span-1 functionalContainer">
			<p class="titulo tituloLeft tituloColumnRight">CARRERAS APUNTADAS</p>
			<div id="map" class="mapStyleRight">
	    		<img src="/img/mapaApuntadas.jpg">					
			</div>
		</div>
		
		<div class="span-1 functionalContainer">
			<p class="titulo tituloLeft tituloColumnRight">DE SU MISMO CLUB</p>
			<div class="eventsUsers">									
				<div class="avatarContainer">
					<!-- TODO -->
					<a href="/user/{$smarty.session.user.username}"><img title="{$smarty.session.user.username}" class="avatarRight" src="/avatar.php?id={$smarty.session.user.user_id}"/></a>	
				</div>
			</div>
		</div>
				
	</div>

</div> <!-- content -->

</div> <!-- container -->

{include file="footer.tpl"} 
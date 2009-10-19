{include file="header.tpl"}

<div class="span-24 column content">

	<div class="span-1 last leftColumn">
		
<div class="span-1 columnNameUser"><p class="nameUserProfile">{$data.datos.completename}<span class="nameUserProfileNick">, ({$data.datos.username})</span></div>
		<div class="globalContainerUser">	
			<div class="span-1 last userData">
				<div class="span-1 avatarPerfil" id="avatarPerfil">
					<img class="imgAvatarPerfil" id="userImg" src="/avatar.php?id={$data.datos.id}&type=t">
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
					<!--div class="span-1 last dataContainerUser">
						<div class="span-1 last dataTitleUserProfile"><p>Club:</p></div>
						<div class="span-1 last dataUserProfile"><p><b>S.S. de los Reyes - Clínicas Menorca</b></p></div>
					</div -->
					<div class="span-1 last dataContainerUser">
						<div class="span-1 last dataTitleUserProfile"><p>Categoría:</p></div>
						<div class="span-1 last dataUserProfile"><p><b>Senior Masculino</b></p></div>
					</div>
				</div>
			</div>
			
			<div class="span-1 last imagesUserContainer">
				<p class="titulo tituloLeft tituloRight">FOTOS DE {$data.datos.username|upper} {if !empty($pictures)}[{$pictures|@count}]{/if}, <a>ver todas</a></p>
				<div class="pictureUserContainer">
				{if $pictures}
				{foreach key=id item=picture from=$pictures name=pictureloop}
					{if $smarty.foreach.pictureloop.iteration<6}
						{if $smarty.foreach.pictureloop.iteration==5}
						<div class="imagesUserLast" id="imagesUser">
							<img src="{$picture.path|replace:"_b.jpg":"_t.jpg"}"/>
						</div>
						{else}
						<div class="imagesUser" id="imagesUser">
							<img src="{$picture.path|replace:"_b.jpg":"_t.jpg"}"/>
						</div>
						{/if}
					{/if}
				{/foreach}
				{/if}
				</div>
			</div>
			
			<div class="span-1 last commentsUser">
				<p class="user_title">MENSAJES PARA {$data.datos.username|upper} {if !empty($comments)}[{$comments|@count}]{/if}</p>
				
				<div class="span-1 last columnComments">

				<ol id="update">
				{foreach key=id item=comment from=$comments}
					{if $comment eq false}
	
					{else}   										
						<div id="commentUser" class="span-1 last">
							<div class="span-1 last avatarBox">
								<img src="/avatar.php?id={$comment.user_id}&type=s"/>	
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
            	<div class="span-8" id="flash" align="left"></div>
            	<div class="span-1 comment_wall">
					<div class="commentArea" id="commentBox">	
					{if $smarty.session.logged}				
						<div class="titleComents">Deja tu comentario</div>
						<textarea id="comment_textarea"></textarea>
						<input class="fg-button buttonComment" type="submit" value="Publicar comentario" onclick="javascript: void commentAction('User',{$data.datos.id},'user',$('#comment_textarea').val())"/>
					{else}
					<div>
						<p class="noComments_wall">Para realizar comentarios debes <b><a href="javascript: void showLoginWindow()">iniciar tu sesión</a></b> en Runnity. <b><a href="/registro">¿Aún no estás registrado?</a></b></p>
					</div>
					 {/if}
	
					</div>
				</div>
				</div>				
				
				<!-- Crear servicio para los comentarios sobre usuario -->
				<!--<div class="span-9 commentsPaginator">
        	   		<div class="userComments">
						<p>viendo del <b>1 al 5</b> de 60
							<span><a><input class="fg-button buttonLeftArrow" type="button"/></a></span>
							<span><a><input class="fg-button buttonRightArrow" type="button"/></a></span>
						</p>	
					</div>
				</div>-->

			</div>
		</div>
	</div>
	

	<!-- RIGHT COLUMN -->
	<div class="span-1 last rightColumn userRightColumn">

		<div class="span-1 ticketOrangeVoy" id="ticketOrangeVoy">{if $smarty.session}{if $isAlreadyFriend neq true}<a href="javascript: void followUser('{$data.datos.id}')"><div class="checkboxUnchecked"></div><p id="textoInscribirse">Sigue a {$data.datos.username}</p></a>{else}<div class="checkboxChecked"></div><p id="textoInscribirse">Ya sigues a {$data.datos.username}</p>{/if}{else}<div class="checkbox"></div><p><a href="javascript: void showLoginWindow()">Haz login</a> para seguir a {$data.datos.username}</p>{/if}</div>
		
		<div class="span-1 ticketOrange"></div>	
	
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
		
		{if $friends}
		<div class="span-1 functionalContainer">
			<p class="titulo tituloLeft tituloColumnRight">USUARIOS A LOS QUE SIGUES</p>
			<div class="eventsUsers">
				<!--TODO-->									
				<div class="avatarContainer">
					<a href="/user/{$smarty.session.user.username}"><img title="{$smarty.session.user.username}" class="avatarRight" src="/avatar.php?id={$smarty.session.user.user_id}"/></a>	
				</div>
			</div>
		</div>		
		{/if}
				
	</div>

</div> <!-- content -->

</div> <!-- container -->

{include file="footer.tpl"} 
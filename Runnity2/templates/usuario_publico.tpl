{include file="header.tpl"}
{literal}
<script type="text/javascript"> 
$(document).ready(function(){
	
	if ($('div.rightColumn').height()<$('div.leftColumn').height()) {
		$('div.rightColumn').height($('div.leftColumn').height());	
	}
});
</script>
{/literal}


<div class="span-24 column content">

	<div class="span-1 last leftColumn">
		
<div class="span-1 columnNameUser"><p class="nameUserProfile">{$data.datos.completename}<span class="nameUserProfileNick">, ({$data.datos.username})</span></div>
		<div class="globalContainerUser">	
			<div class="span-1 last userData">
				<div class="span-1 avatarPerfil" id="avatarPerfil">
					<img class="imgAvatarPerfil" id="userImg" src="/avatar.php?id={$data.datos.id}&type=t">
				</div>
				{if $records}
					<div class="span-1 last functionalContainer">
					<p class="titulo tituloLeft">RANKING RUNNITY</p>				
						{foreach key=id item=record from=$records name=record}
						<div class="span-1 last dataContainerUser">
							<div class="span-1 last dataTitleUserRanking"><p>{$record.distance_name}:</p></div>
							<div class="span-1 last dataUserRanking"><p><b>{$record.time_taken}</b></p></div>
							<div class="span-1 last dataUserPosition"><div class="rankingBox"><p>{$record.position}º</p></div></div>
						</div>
						{/foreach}
					</div>
				{/if}				
				<div class="span-1 last functionalContainer">
				<p class="titulo tituloLeft">DATOS PERSONALES</p>
					<div class="span-1 last dataContainerUser">
						<div class="span-1 last dataTitleUserProfile"><p>Categoría:</p></div>
						<div class="span-1 last dataUserProfile"><p><b>{$categoria}</b></p></div>
					</div>
					<div class="span-1 last dataContainerUserHack"></div>
				</div>
			</div>
			
			<div class="span-1 last imagesUserContainer">
				<p class="titulo tituloLeft tituloRight">FOTOS DE {$data.datos.username|upper} {if !empty($pictures)}[{$pictures|@count}]{/if}, <a href="#anclafotos">ver todas</a></p>
				{if $pictures}
				<div class="pictureUserContainer" id="pictureUserContainer">
					{foreach key=id item=picture from=$pictures name=pictureloop}
						{if $smarty.foreach.pictureloop.iteration<6}
							<div class="imagesUser" id="imagesUser">
								<a href="/picture/{$picture.id}/user"><img src="{$picture.path|replace:"_b.jpg":"_t.jpg"}"/></a>
							</div>
						{/if}
					{/foreach}
				</div>
				{else}
					<div class="pictureUserContainerNoPhotos" id="pictureUserContainerNoPhotos" title="first">
						<p class="up">{$data.datos.username} no ha subido fotos...</p>
					</div>
				{/if}
			</div>
			
			<div class="span-1 last commentsUser">
				<p class="titulo tituloLeft tituloRight">MENSAJES PARA {$data.datos.username|upper} {if !empty($comments)}[{$comments|@count}]{/if}</p>
				<div class="span-1 last columnComments">
				<ol id="update">
				{foreach key=id item=comment from=$comments name=commentloop}	
					{if $comment}			
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
         {/foreach}
         </ol>
				</div> 
			
				<div class="span-8" id="flash" align="left"></div>
	        	<div class="span-1 comment_wall">
					{if $smarty.session.logged}				
						<div class="commentArea" id="commentBox">	
							<div class="titleComents">Deja tu comentario</div>
							<textarea id="commentTextArea"></textarea>
							<input class="buttonComment" type="submit" value="Publicar comentario" onclick="javascript: void commentAction('User',{$data.datos.id},'user',$('#commentTextArea').val())"/>
						</div>
					{else}
						<div>
							<p class="noComments_wall">Para realizar comentarios debes <b><a href="javascript: void showLoginWindow()">iniciar tu sesión</a></b> en Runnity. <b><a href="/registro">¿Aún no estás registrado?</a></b></p>
						</div>
					 {/if}
				</div>
			
			</div> <!-- commentsUser -->
			
		</div>
		
		<div class="span-1 separatorBannerPhotosUser"></div>
		
		{if $pictures}
			<div class="span-1 last bannerTopPhotos" id="user_photos_id"></div>
			<div class="span-1 last columnPhotos">
				<p class="span-8 tituloPhotos">FOTOS DE {$data.datos.username|upper}</p>
				<div id="imgItems">
				{foreach key=id item=picture from=$pictures}
					<a name="anclafotos" href="/picture/{$picture.id}/user"><img class="avatarPhoto" src="{$picture.path|replace:"_b.jpg":"_t.jpg"}"/></a>
				{/foreach}	
				</div>
			</div>
		{/if}
		
	</div>
	

	<!-- RIGHT COLUMN -->
		<div class="span-1 last rightColumn">
<div class="span-1 ticketOrangeVoy" id="ticketOrangeVoy">{if $smarty.session}{if $isAlreadyFriend neq true}<a href="javascript: void followUser('{$data.datos.id}')"><div class="checkboxUnchecked"></div><p id="textoInscribirse">Sigue a {$data.datos.username}</p></a>{else}<div class="checkboxChecked"></div><p id="textoInscribirse">Ya sigues a {$data.datos.username}</p>{/if}{else}<div class="checkbox"></div><p><a href="javascript: void showLoginWindow()">Haz login</a> para seguir a {$data.datos.username}</p>{/if}</div>
		
		<div class="span-1 ticketOrange"></div>	
	
		{if $nextRaces}
		<div class="span-1 functionalContainerRight">
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
							<div class="nameRaceRight"><a id="nameRunRight1{$smarty.foreach.raceloop.iteration}" href="/run/{$race.id}/{$race.name|seourl}">{$race.name}</a></div>
							<div class="dataRaceRight"><p>{$race.event_location} | {$race.distance_text}</p></div>
						</div>	
					</div>
					<div class="span-1 last separatorRight"></div>
			    {/foreach}
			</div>
		</div>
		{/if}
		
		<div class="span-1 functionalContainerRight">
			<p class="titulo tituloLeft tituloColumnRight">CARRERAS APUNTADAS</p>
			<div id="map" class="mapStyleRight">
	            <object id="aroundMap" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="254" height="192">
			      <param name="flashvars" value="id={$data.datos.id}&amp;mapkey={$smarty.const.GMAPS_KEY}" />
	              <param name="wmode" value="opaque" />
	              <param name="movie" value="/flash/UserRacesMap.swf?7" />
	              <!--[if !IE]>-->
	              <object type="application/x-shockwave-flash" data="/flash/UserRacesMap.swf?7" width="254" height="192" flashvars="id={$data.datos.id}&amp;mapkey={$smarty.const.GMAPS_KEY}">
	              <!--<![endif]-->
	              <!--[if !IE]>-->
	              </object>
	              <!--<![endif]-->
	            </object>						
			</div>
		</div>
		
		{if $friends}
		<div class="span-1 functionalContainerRight">
			<p class="titulo tituloLeft tituloColumnRight">USUARIOS A LOS QUE SIGUE</p>
			<div class="events">
				<div class="avatarContainer">
				{foreach key=id item=friend from=$friends}
					<a href="/user/{$friend.username}"><img class="avatarRight" src="/avatar.php?id={$friend.id}&type=s"/>
						<div class="hidden">{$friend.username}</div>
					</a>
			    {/foreach}
			    </div>
			</div>
		</div>		
		{/if}		

	</div> <!-- right column -->

</div> <!-- content -->

</div> <!-- container -->

{include file="footer.tpl"} 
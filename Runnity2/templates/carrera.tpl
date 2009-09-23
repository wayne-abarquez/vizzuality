{include file="header.tpl"}

<div class="span-24 column content">

	<div class="span-1 last leftColumn">
		<p><a href="#">Carreras en Madrid</a></p>
		<div class="carrera_principal">
			<div class="column span-1 first calendar">
				<div class="month month{$data.run_type}">{getMonth month=$data.event_date|substr:5:2}</div>
		    	<div class="day">{$data.event_date|substr:8:2}</div>
		    </div>
		    <p class="raceTitle" id="raceTitle">{$data.name}</p>
		    <p class="raceDetailsTitle">{$data.event_location} | {$data.distance_text} | <b>{$data.num_users} usuarios van</b></p>
		    
		    {if $data.flickr_img_id === null}
			    <img src="/media/run/{$data.big_picture}" class="imageCarrera"/>
			{else}
			<a href="{$data.flickr_url}" target="_blank"><img class="imageCarrera" src="/panoramioPic.php?												id={$data.id}&photo_id={$data.flickr_img_id}"/></a>
			{/if}
			
			<div class="span-1 last raceData">
				{if $data.distance_text != null or $data.category != null or $data.awards != null}
				<div>
					<p class="titulo tituloLeft">DATOS TÉCNICOS</p>
					{if $data.distance_text != null}
						<div class="span-1 last dataContainer">
							<div class="span-1 last dataTitle"><p>Distancia:</p></div>
							<div class="span-1 last data"><p><b>{$data.distance_text}</b></p></div>
						</div>
						{/if}
						{if $data.event_date != null}
						<div class="span-1 last dataContainer">
							<div class="span-1 last dataTitle"><p>Hora:</p></div>
							<div class="span-1 last data"><p><b>{$data.event_date|substr:11:5}</b></p></div>
						</div>
						{/if}
						{if $data.category != null}
						<div class="span-1 last dataContainer">
							<div class="span-1 last dataTitle"><p>Categorias:</p></div>
							<div class="span-1 last data"><p><b>{$data.category}</b></p></div>
						</div>
						{/if}
						{if $data.awards != null}
						<div class="span-1 last dataContainer">
							<div class="span-1 last dataTitle"><p>Premios:</p></div>
							<div class="span-1 last data"><p><b>{$data.awards}</b></p></div>
						</div>
					{/if}
				</div>
				{/if}
				
				{if $data.inscription_price != null or $data.inscription_location != null
					or $data.inscription_email != null or $data.inscription_website != null
					or $data.tlf_informacion != null}
					<div>
						<p class="titulo tituloLeft">INSCRIPCIONES</p>
						{if $data.inscription_price != null}
						<div class="span-1 last dataContainer">
							<div class="span-1 last dataTitle"><p>Precio:</p></div>
							<div class="span-1 last data"><p><b>{$data.inscription_price}</b></p></div>
						</div>
						{/if}
						{if $data.inscription_location != null}
						<div class="span-1 last dataContainer">
							<div class="span-1 last dataTitle"><p>Lugar:</p></div>
							<div class="span-1 last data"><p><b>{$data.inscription_location}</b></p></div>
						</div>
						{/if}
						{if $data.inscription_email != null}
						<div class="span-1 last dataContainer">
							<div class="span-1 last dataTitle"><p class="textRace">E-mail:</p></div>
							<div class="span-1 last data"><p><a id="datos1" href="mailto:{$data.inscription_email}" class="special">{$data.inscription_email}</a></p></div>
						</div>
						{/if}
						{if $data.inscription_website != null}
						<div class="span-1 last dataContainer">
							<div class="span-1 last dataTitle"><p class="textRace">Web:</p></div>
							<div class="span-1 last data"><p><a target="_blank" id="datos2" href="{if $data.inscription_website|substr:0:7 eq "http://"}{$data.inscription_website}{else}http://								{$data.inscription_website}{/if}" class="special">{$data.inscription_website}</a></p></div>
						</div>	
						{/if}
						{if $data.tlf_informacion != null}
						<div class="span-6 databox noborder">
							<div class="span-1 last dataTitle"><p class="textRace">Teléfono:</p></div>
							<div class="span-1 last data"><p><a id="datos3" href="" class="special">{$data.tlf_informacion}</a></p></div>
						</div>	
						{/if}
					</div>
				{/if}
				
				<div class="span-1 last raceData">
				<p class="titulo tituloLeft">COMPARTIR</p>
<a target=_blank href="http://www.facebook.com/share.php?u=http://www.runnity.com/run/{$data.id}/{$data.name|replace:' ':'/'}"><img src="/img/ico_facebook.gif" alt="Facebook"></a>&nbsp;
<a target=_blank href="http://del.icio.us/post?title=&url=http://www.runnity.com/run/{$data.id}/{$data.name|replace:' ':'/'}"><img src="/img/ico_delicious.gif" alt="delicious"></a>&nbsp;
<a target=_blank href="http://meneame.net/submit.php?url=http://www.runnity.com/run/{$data.id}/{$data.name|replace:' ':'/'}"><img src="/img/ico_meneame.gif" alt="meneame"></a>
<a target=_blank href="http://twitter.com/home?status=http://www.runnity.com/run/{$data.id}/{$data.name|replace:' ':'/'}"><img src="/img/ico_twitter.png" alt="twitter"></a>	
<a target=_blank href="http://digg.com/submit?phase=2&url={$data.id}/{$data.name|replace:' ':'/'}"><img src="/img/ico_digg.png" alt="Facebook"></a>&nbsp;				        
				</div>	   

			</div>
			
			<div class="span-1 last raceDescription">
				<p class="titulo tituloLeft tituloRight">DESCRIPCIÓN Y DATOS ADICIONALES</p>
				<p class="textRace">
					{if $data.description!=null}
						{$data.description}
					{else}
						No hay descripción para esta carrera, ¿te animas a <a href="javascript: void showContactBox()">enviarnos una?</a>
					{/if}	
				</p>
			</div>
			
			<div class="span-1 last columnLong">
				<p class="titulo tituloLeft tituloRight">MAPA DE LA CARRERA Y ALTIMETRÍA APROXIMADA</p>
				{if $data.start_point_lat == null}
                	<div id="map3Container" class="span-16"></div>
                {else}	
					<div>
						<div class="mapStyle">
							<div id="trackMap">
	                            <object id="flashMovie" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="600" height="400" wmode="opaque" flashvars="id={$data.id}">
	                              <param name="movie" value="/flash/raceMapViewer.swf?2" />
	                              <!--[if !IE]>-->
	                              <object type="application/x-shockwave-flash" data="/flash/raceMapViewer.swf" width="600" height="400" wmode="opaque" flashvars="id={$data.id}">
	                              <!--<![endif]-->

	                              <!--[if !IE]>-->
	                              </object>
	                              <!--<![endif]-->
	                            </object>		    					    
							</div>
						</div>	
					</div>
				{/if}
			</div>
			
			<div class="span-1 last bannerTopPhotos"></div>
			<div class="span-1 last columnPhotos">
			</div>
			
			<div class="span-1 last columnLong">
				<p class="titulo tituloLeft tituloRight">COMENTARIOS {if !empty($comments)}[{$comments|@count}]{/if}
				<a class="publica" onclick="document.getElementById('commentTextArea').focus();">publicar un comentario</a>
				</p>
				
					{foreach key=id item=comment from=$comments}
    				{if $comment eq false}
    					<div class="span-1 last noComments">

        				</div>  
    				{else}	    										
    					<div id="comment" class="span-1 last">
							<div class="span-1 last avatarBox">
								<img src="/img/avatar.jpg"/>	
							</div>
							<div class="span-1 commentBox">
								<div class="nameUser"><a class="name" href="/user/{$comment.username}">{$comment.username}, </a>hace 									{$comment.created_when|timeAgo}</div>
							<p class="commentUser">{$comment.commenttext}</p>
							</div>
							
						</div>							
              		{/if}
                	{foreachelse}
    					<div class="span-1 noComments">

        				</div>    
                	{/foreach}						
			</div>
			
			<!-- PARA AÑADIR COMENTARIOS -->
    		<!--
<div class="span-1 id="flash" align="left"">
				<div>					
					{if $smarty.session.logged}
						<div class="span-1 titleComents">Anímate y publica tu comentario</div>
						<textarea name="textarea2" id="commentTextArea" class="span-1 textArea"></textarea>
						<input class="fg-button" type="submit" value="Publicar comentario" onclick="javascript: void commentAction({$smarty.request.id},'run')"/>
					{else}
						<p>Para realizar comentarios debes <b><a href="javascript: void showLoginBox()">iniciar tu sesión</a></b> en runnity. 							<b><a href="javascript: void showRegisterBox()">¿Aún no estás registrado?</a></b></p>
					{/if}
				</div>
			</div>
-->
			
		</div>
	</div>
	
	<div class="span-1 last rightColumn">
		<div class="span-1 ticketOrangeVoy"><p><input type="checkbox"> Voy a ir a esta carrera</p></div>
		<div class="span-1 ticketOrange"></div>
	</div>

</div> <!-- content -->

</div> <!-- container -->

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
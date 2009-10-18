{include file="header.tpl"}
{literal}
<script type="text/javascript">
    $(document).ready(function(){
    
    	$('#datos2').truncate({max_length: 23});
    	$('#datos1').truncate({max_length: 23});
    	
        new AjaxUpload('#buttonUploadPicture', {
        	action: '/imageController.php',
        	data : { 
					method:"uploadPicture",
					onTable:"run",
					onId:{/literal}{$data.id}{literal}
					},
        	onSubmit : function(file , ext){
        		if (ext && /^(jpg|png|jpeg|gif)$/.test(ext)){			
        			// change button text, when user selects file			
					$("#buttonUploadPicture").html(".");


        			// If you want to allow uploading only 1 file at time,
        			// you can disable upload button
        			this.disable();


        			// Uploding -> Uploading. -> Uploading...
        			interval = window.setInterval(function(){
        				var text = $("#buttonUploadPicture").html();
        				if (text.length < 17){
							$("#buttonUploadPicture").html(text + '.');					
        				} else {
        					$("#buttonUploadPicture").html(".");				
        				}
        			}, 200);

        		} else {
			
        			// extension is not allowed
        			//$('#example2 .text').text('Error: only images are allowed');
        			// cancel upload
        			return false;				
        		}

        	},
        	onComplete : function(file,response){	
        		        		
				$("#imgItems").append(response);
				
				$("#buttonUploadPicture").html("¿Tienes fotos de esta carrera? ¡Súbelas!");

    			window.clearInterval(interval);

    			//enable upload button
    			this.enable();
    						
        	}		
        });        				
	});

</script>
{/literal}

<div class="span-24 column content">

	<div class="span-1 last leftColumn">
		<p class="navigation"><a href="/buscar?q={$data.province_name}">Carreras en {$data.province_name} ></a></p>
		
		<div class="carreraPrincipal">
			<div class="column span-1 first calendar">
				<div class="month month{$data.run_type}">{getMonth month=$data.event_date|substr:5:2}</div>
		    	<div class="day">{$data.event_date|substr:8:2}</div>
		    </div>
		    <p class="raceTitle" id="raceTitle">{$data.name}</p>
		    <p class="raceDetailsTitle">{$data.event_location} | {$data.distance_text} | <b>{$data.num_users} usuarios van</b></p>
		    
		    {if $data.flickr_img_id === null}
			    <img src="/media/run/{$data.big_picture}" class="imageCarrera"/>
			{else}
			<a href="{$data.flickr_url}" target="_blank"><img class="imageCarrera" src="/panoramioPic.php?id={$data.id}&photo_id={$data.flickr_img_id}"/></a>
			{/if}
			
			
			<div class="span-1 last raceData">
				{if $data.distance_text != null or $data.category != null or $data.awards != null}
				<div class="span-1 last functionalContainer">
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
					<div class="span-1 last functionalContainer">
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
							<div class="span-1 last data"><p class="special"><a id="datos1" href="mailto:{$data.inscription_email}">{$data.inscription_email}</a></p></div>
						</div>
						{/if}
						{if $data.inscription_website != null}
						<div class="span-1 last dataContainer">
							<div class="span-1 last dataTitle"><p class="textRace">Web:</p></div>
							<div class="span-1 last data"><p class="special"><a target="_blank" id="datos2" href="{if $data.inscription_website|substr:0:7 eq "http://"}{$data.inscription_website}{else}http://{$data.inscription_website}{/if}">{$data.inscription_website|substr:7}</a></p></div>
						</div>	
						{/if}
						{if $data.tlf_informacion != null}
						<div class="span-6 dataContainer noborder">
							<div class="span-1 last dataTitle"><p class="textRace">Teléfono:</p></div>
							<div class="span-1 last data"><p><b>{$data.tlf_informacion}</b></p></div>
						</div>	
						{/if}
					</div>	
				{/if}
				
				<div class="span-1 last raceData">
				<p class="titulo tituloLeft">COMPARTIR</p>
<a target=_blank href="http://www.facebook.com/share.php?u=http://www.runnity.com/run/{$data.id}/{$data.name|replace:' ':'/'}"><img src="/img/ico_facebook.gif" alt="Facebook"></a>
<a target=_blank href="http://del.icio.us/post?title=&url=http://www.runnity.com/run/{$data.id}/{$data.name|replace:' ':'/'}"><img src="/img/ico_delicious.gif" alt="delicious"></a>
<a target=_blank href="http://meneame.net/submit.php?url=http://www.runnity.com/run/{$data.id}/{$data.name|replace:' ':'/'}"><img src="/img/ico_meneame.gif" alt="meneame"></a>
<a target=_blank href="http://twitter.com/home?status=http://www.runnity.com/run/{$data.id}/{$data.name|replace:' ':'/'}"><img src="/img/ico_twitter.png" alt="twitter"></a>	
<a target=_blank href="http://digg.com/submit?phase=2&url={$data.id}/{$data.name|replace:' ':'/'}"><img src="/img/ico_digg.png" alt="Facebook"></a> 
				</div>

			</div>
			
			<div class="span-1 last raceDescription">
				<div class="span-1 last functionalContainer">
					<p class="titulo tituloLeft tituloRight columnLonga">DESCRIPCIÓN Y DATOS ADICIONALES</p>
					<p class="textRace">
						{if $data.description!=null}
							<p class="textRace">{$data.description}</p>
						{else}
							<div class="nodesc">
								<img src="/img/nodesc.gif"/>
								<p>Aún no tenemos descripción para esta carrera,<br /> 
								<a href="javascript: void showContactBox()">¿te animas a enviarnos una?</a></p>
							</div>
						{/if}	
				</div>			
			</div>

			
			<div class="span-1 last columnLong">
				{if $data.start_point_lat == null}
				
                {else}
					<p class="titulo tituloLeft tituloRight">MAPA DE LA CARRERA Y ALTIMETRÍA APROXIMADA</p>
                	<div id="map3Container" class="span-16"></div>                
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
			
			{if $pictures}
			<div class="span-1 last bannerTopPhotos"></div>
			<div class="span-1 last columnPhotos">
				<p class="span-8 tituloPhotos">FOTOS DEL EVENTO {if !empty($pictures)}[{$pictures|@count}]{/if}</p>
				<div id="imgItems">
				{foreach key=id item=picture from=$pictures}
					<a href="/image.php?id={$data.id}&picId={$picture.id}&type=b"><img class="avatarPhoto" src="/picture.php?id={$data.id}&picId={$picture.id}&type=t"/></a>
				{/foreach}	
				</div>
				<div class="span-1 SubirFotosLink"><a href="#" id="buttonUploadPicture">¿Tienes fotos de esta carrera? ¡Súbelas! <img src="/img/photoIcon.gif"></a></div>
			</div>
			{else}
			<div class="span-1 last nophotos">
				<p class="up">Aún nadie ha subido fotos de esta carrera...</p>
				<p class="center">¿Tienes fotos del evento? ¡Anímate y súbelas!</p>
				<p class="down"><a href="#" id="buttonUploadPicture"><img src="/img/photoIcon.gif">Subir fotos</a></p>
			</div>			
			{/if}	
			
			<div class="span-1 last columnLong">
				<p class="titulo tituloLeft tituloRight">COMENTARIOS {if !empty($comments)}[{$comments|@count}]{/if}
				<a class="publica" onclick="document.getElementById('commentTextArea').focus();">publicar un comentario</a>
				</p>
				<ol id="update">
				{foreach key=id item=comment from=$comments}
				{if $comment eq false}
					<!--
<div class="span-1 last noComments">
						<p>Aún no hay comentarios sobre esta carrera</p>
        				<p>Pero si quieres puedes <a href="/rss.php">subscribirte a nuestro RSS</a> para estar al tanto de todo lo ocurrido en runnity</p>
    				</div>  
-->
				{else}	    										
					<div id="comment" class="span-1 last">
						<div class="span-1 last avatarBox">
							<img src="/avatar.php?id={$comment.user_id}&type=s"/>	
						</div>
						<div class="span-1 commentBox">
						<div class="nameUser"><a class="name" href="/user/{$comment.username}">{$comment.username}, </a>hace {$comment.created_when|timeAgo}</div>
						<p class="commentUser">{$comment.commenttext}</p>
						</div>
					</div>							
          		{/if} 
            	{/foreach}	
            </ol>						
			</div>
			
			<!-- PARA AÑADIR COMENTARIOS -->
			<div class="span-8" id="flash" align="left"></div>
			<div class="span-1 last boxraceMap">
				<div class="commentArea" id="commentBox">	
				{if $smarty.session.logged}				
					<div class="titleComents">Anímate y publica tu comentario</div>
					<textarea name="textarea2" id="commentTextArea" class="textArea"></textarea>
					<input class="fg-button buttonComment" type="submit" value="Publicar comentario" onclick="javascript: void commentAction('Run',{$smarty.request.id},'run',$('#commentTextArea').val())"/>
				{else}
				<div class="span-1 iconPhrase">
					<img src="/img/slash.gif"/>
				</div>
				<div>
					<p class="noComments">Para realizar comentarios debes <b><a href="javascript: void showLoginWindow()">iniciar tu sesión</a></b> en runnity. <b><a href="/registro">¿Aún no estás registrado?</a></b></p>
				</div>
				 {/if}

				</div>
			</div>
			
		</div>
	</div>
	
	<!-- RIGHT COLUMN -->
	<div class="span-1 last rightColumn">
		<div class="span-1 ticketOrangeVoy" id="ticketOrangeVoy">{if $smarty.session}{if $data.inscrito eq 'f'}<a href="javascript: void inscribirseCarrera('{$smarty.session.user.id}','{$smarty.request.id}')"><div class="checkboxUnchecked"></div><p id="textoInscribirse">Apúntate a esta carrera</p></a>{else}<div class="checkboxChecked"></div><p id="textoInscribirse">Estoy apuntado a esta carrera</p>{/if}{else}<div class="checkbox"></div><p><a href="javascript: void showLoginWindow()">Haz login</a> para apuntarte a la carrera</p>{/if}</div>
		
		<div class="span-1 ticketOrange"></div>
		
		<div class="span-1 functionalContainer">
			<p class="titulo tituloLeft tituloColumnRight">LOCALIZACIÓN</p>
			<div id="map" class="mapStyleRight">
	            <object id="aroundMap" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="254" height="192" wmode="opaque" flashvars="id={$data.id}">
	              <param name="movie" value="/flash/RunAroundMap.swf?7" />
	              <!--[if !IE]>-->
	              <object type="application/x-shockwave-flash" data="/flash/RunAroundMap.swf?7" width="254" height="192" wmode="opaque" flashvars="id={$data.id}">
	              <!--<![endif]-->
					    {if $data.start_point_lat === null}
<img width="254" height="192" src="http://maps.google.com/maps/api/staticmap?size=254x192&maptype=map&zoom=10&center={$data.event_location},spain&sensor=false&key=ABQIAAAAtDJGVn6RztUmxjnX5hMzjRTy9E-TgLeuCHEEJunrcdV8Bjp5lBTu2Rw7F-koeV8TrxpLHZPXoYd2BA" />					    
					    {else}
					<img src="http://maps.google.com/staticmap?size=254x192&maptype=map&zoom=10&markers={if $data.end_point_lat}{$data.end_point_lat},{$data.end_point_lon},bluem%7C{/if}{$data.start_point_lat},{$data.start_point_lon},greens&sensor=false&key=ABQIAAAAtDJGVn6RztUmxjnX5hMzjRTy9E-TgLeuCHEEJunrcdV8Bjp5lBTu2Rw7F-koeV8TrxpLHZPXoYd2BA">
					    {/if}
	              <!--[if !IE]>-->
	              </object>
	              <!--<![endif]-->
	            </object>						
			</div>
		</div>
		
		<div class="span-1 functionalContainer">
		{if $runsInSameDates}
		<p class="titulo tituloLeft tituloColumnRight">EN LAS MISMAS FECHAS</p>
		<div class="events">
			{foreach key=id item=race from=$runsInSameDates name=raceloop}	    				    
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
		{/if}
		</div>
		
		<div class="span-1 functionalContainer">
		{if $runsInSameDates}
		<p class="titulo tituloLeft tituloColumnRight">DE DISTANCIA PARECIDA</p>
		<div class="events">
			{foreach key=id item=race from=$similarTypeRaces name=raceloop}	    				    
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
						<div class="nameRaceRight"><a id="nameRunRight2{$smarty.foreach.raceloop.iteration}" href="/run/{$race.id}/{$race.name|replace:' ':'/'}">{$race.name}</a></div>
						<div class="dataRaceRight"><p>{$race.event_location} | {$race.distance_text}</p></div>
					</div>	
				</div>
				<div class="span-1 last separatorRight"></div>
		    {/foreach}					
		</div>
		{/if}
		</div>

		{if $data.num_users > 0}
		<div class="span-1 functionalContainer">		
			<p class="titulo tituloLeft tituloColumnRight">USUARIOS APUNTADOS</p>
			<div class="eventsUsers">				
				<div class="avatarContainer">
				{foreach key=id item=person from=$runners}
					<img title="{$person.username}" class="avatarRight" src="/avatar.php?id={$person.user_id}&type=s"/>
			    {/foreach}
				</div>
			</div>
		</div>
		{/if}
	</div>

</div> <!-- content -->

</div> <!-- container -->


{include file="footer.tpl"} 
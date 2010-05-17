{include file="header.tpl"}

{literal}
<script type="text/javascript">
function SubirFotos(){
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
        		
        		var tipoCont = $("#nophotos").attr("title");
        		
        		var iniciocadena = response.lastIndexOf("/");
    			var finalcadena = response.lastIndexOf("_");
    			var numcaracteres = finalcadena-iniciocadena;
    			var cadena = response.substr(iniciocadena+1,numcaracteres-1);
		
        		if(tipoCont=="first"){
        			$("#nophotos").remove();
/*         			esta puesto a pelo el id de la foto */
        			$("#newphotos").append('<div class="span-1 last bannerTopPhotos"></div><div class="span-1 last columnPhotos"><p class="span-8 tituloPhotos">FOTOS DEL EVENTO</p><div id="imgItems"><a href="/image.php?id='+cadena+'&source=run">'+response+'</a></div><div class="span-1 SubirFotosLink"><a href="#" id="buttonUploadPicture" class="buttonUploadPicture">¿Tienes fotos de esta carrera? ¡Súbelas! <img src="/img/photoIcon.gif"></a></div></div>');
    				
    				window.clearInterval(interval);

    				//enable upload button
    				this.enable();
        		} else {
        			$("#imgItems").append('<a href="/picture/'+cadena+'/run">'+response+'</a>');
					$("#buttonUploadPicture").html("¿Tienes fotos de esta carrera? ¡Súbelas! <img src='/img/photoIcon.gif'>");
    				
    				window.clearInterval(interval);

    				//enable upload button
    				this.enable();
        		}
        		SubirFotos();
    						
        	}		
        });
	}
</script>
{/literal}

{literal}
<script type="text/javascript">
    $(document).ready(function(){
    {/literal}{if $smarty.session.logged}
		SubirFotos();
	{/if}
	{literal}	
		
	if ($('div.rightColumn').height()<$('div.leftColumn').height()) {
		$('div.rightColumn').height($('div.leftColumn').height() + 25);	
	}
	
/*
	$('#datos2').truncate({max_length: 23});
	$('#datos1').truncate({max_length: 23});
*/
    	
                				
	});

</script>
{/literal}

<!-- <script type='text/javascript' src='/js/jquery-1.3.2.min.js'></script> -->
<script type="text/javascript" src="/js/init.js"></script>	

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
					<p class="titulo tituloLeft tituloRight">DATOS TÉCNICOS</p>
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
						<p class="titulo tituloLeft tituloRight">INSCRIPCIONES</p>
						{if $data.inscription_price != null}
						<div class="span-1 last dataContainer">
							<div class="span-1 last dataTitle"><p>Precio:</p></div>
							<div class="span-1 last data"><p><b>{$data.inscription_price}</b></p></div>
						</div>
						{/if}
						{if $data.inscription_location != null}
						<div class="span-1 last dataContainer">
							<div class="span-1 last dataTitle"><p>Lugar:</p></div>
							{if ($data.inscription_location|truncate:4:"" eq "www.") or ($data.inscription_location|truncate:4:"" eq "http")}
							<div class="span-1 last data"><p class="special"><a target="_blank" href="{if $data.inscription_location|substr:0:7 eq "http://"}{$data.inscription_location}{else}http://{$data.inscription_location}{/if}">{$data.inscription_location}</a></p></div>							
							{else}
								<div class="span-1 last data"><p><b>{$data.inscription_location}</b></p></div>
							{/if}
						</div>
						{/if}
						{if $data.inscription_email != null}
						<div class="span-1 last dataContainer">
							<div class="span-1 last dataTitle"><p class="textRace">E-mail:</p></div>
							<div class="span-1 last data"><p class="special"><a id="datos1" href="mailto:{$data.inscription_email}">{$data.inscription_email|truncate:23:"..."}</a></p></div>
						</div>
						{/if}
						{if $data.inscription_website != null}
						<div class="span-1 last dataContainer">
							<div class="span-1 last dataTitle"><p class="textRace">Web:</p></div>
							<div class="span-1 last data"><p class="special"><a target="_blank" id="datos2" href="{if $data.inscription_website|substr:0:7 eq "http://"}{$data.inscription_website}{else}http://{$data.inscription_website}{/if}">{$data.inscription_website|truncate:23:"..."}</a></p></div>
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
<a target=_blank href="http://www.facebook.com/share.php?u=http://www.runnity.com/run/{$data.id}/{$data.name|seourl}"><img src="/img/ico_facebook.gif" alt="Facebook"></a>
<a target=_blank href="http://del.icio.us/post?title=&url=http://www.runnity.com/run/{$data.id}/{$data.name|seourl}"><img src="/img/ico_delicious.gif" alt="delicious"></a>
<a target=_blank href="http://meneame.net/submit.php?url=http://www.runnity.com/run/{$data.id}/{$data.name|seourl}"><img src="/img/ico_meneame.gif" alt="meneame"></a>
<a target=_blank href="http://twitter.com/home?status=http://www.runnity.com/run/{$data.id}/{$data.name|seourl}"><img src="/img/ico_twitter.png" alt="twitter"></a>	
<a target=_blank href="http://digg.com/submit?phase=2&url={$data.id}/{$data.name|seourl}"><img src="/img/ico_digg.png" alt="Facebook"></a> 
				</div>

			</div>
			
			<div class="span-1 last raceDescription">
				<div class="span-1 last functionalContainerInfoRun">
					<p class="titulo tituloLeft tituloRight columnLonga">DESCRIPCIÓN Y DATOS ADICIONALES</p>
					<p class="textRace">
						{if $data.description!=null}
							<p class="textRace">{$data.description}</p>
						{else}
							<div class="nodesc">
								<img src="/img/nodesc.gif"/>
								<p>Aún no tenemos descripción para esta carrera,<br /> 
								<a href="javascript: void show_contact()">¿te animas a enviarnos una?</a></p>
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
	       				<object id="flashMovie" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="600" height="400">
								  <param name="flashvars" value="id={$data.id}&amp;mapkey={$smarty.const.GMAPS_KEY}">
	                  <param name="wmode" value="opaque">
                   <param name="movie" value="/flash/raceMapViewer.swf?2" />
                   <!--[if !IE]>-->
                   <object type="application/x-shockwave-flash" data="/flash/raceMapViewer.swf" width="600" height="400" flashvars="id={$data.id}&amp;mapkey={$smarty.const.GMAPS_KEY}">
                   <!--<![endif]-->
                   <!--[if !IE]>-->
                   </object>
                   <!--<![endif]-->
                 </object>		    					    
							</div>
						</div>	
						
					<div id="columnLong_last">	
						<div class="share_buttons">
							<a class="share_race" href="#">compartir esta carrera</a>
						</div>
						<div class="widget_race">
							<p>Selecciona, copia y pega el siguiente código:</p>
							<a class="close_window" href="#"></a>
							<div class="widget_embed">
								<input type="text" name="code" value="{$embedableCode}"/>
							</div>
							
						</div>
						</div>	
					</div>
				{/if}
			</div>
			
			<div id="newphotos">
				{if $pictures}
				<div class="span-1 last bannerTopPhotos"></div>
				<div class="span-1 last columnPhotos">
				    <a NAME="fotos"></a>
					<p class="span-8 tituloPhotos">FOTOS DEL EVENTO {if !empty($pictures)}[{$pictures|@count}]{/if}</p>
					<div id="imgItems">
					{foreach key=id item=picture from=$pictures}
						<a href="/picture/{$picture.id}/run"><img class="avatarPhoto" src="{$picture.path|replace:"_b.jpg":"_t.jpg"}"/></a>
					{/foreach}	
					</div>
					<div class="span-1 SubirFotosLink"><a href="#" id="buttonUploadPicture" class="buttonUploadPicture">¿Tienes fotos de esta carrera? ¡Súbelas! <img src="/img/photoIcon.gif"></a></div>
				</div>
				{else}
					{if $smarty.session.logged}
					<div class="span-1 last nophotos" id="nophotos" title="first">
						<p class="up">Aún nadie ha subido fotos de esta carrera...</p>
						<p class="center">¿Tienes fotos del evento? ¡Anímate y súbelas!</p>
						<p class="down"><img src="/img/photoIconLight.gif"><a href="#" id="buttonUploadPicture">Subir fotos</a></p>
					</div>			
					{else}
					<div class="span-1 last nophotos2" id="nophotos" title="first">
						<div class="span-1 iconPhrasePhotos">
							<img src="/img/slash.gif"/>
						</div>
						<div>
							<p class="noComments">Para subir fotos debes <b><a href="javascript: void showLoginWindow()">iniciar tu sesión</a></b> en runnity. <b><a href="/registro">¿Aún no estás registrado?</a></b></p>
						</div>	
					</div>					
					{/if}
				{/if}		
			</div>	
			
			<div class="span-1 last columnLong">
			  <a NAME="comentarios"></a>
				<p class="titulo tituloLeft tituloRight">COMENTARIOS {if !empty($comments)}[{$comments|@count}]{/if}
				{if $smarty.session.logged}
					<a class="publica" onclick="document.getElementById('commentTextArea').focus();">publicar un comentario</a>
				{/if}
				</p>
				<ol id="update">				
				{foreach key=id item=comment from=$comments name=commentloop}
				{if $comment}						
						<div id="comment" class="span-1 last">
							<div class="span-1 last avatarBox">
								<img width="67" height="66" src="/avatar.php?id={$comment.user_id}&type=s"/>	
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
					<input class="buttonComment" type="submit" value="Publicar comentario" onclick="javascript: void commentAction('Run',{$smarty.request.id},'run',$('#commentTextArea').val())"/>
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
		<div class="span-1 ticketOrangeVoy" id="ticketOrangeVoy">{if $smarty.session}{if $data.inscrito eq 'f'}<a href="javascript: void inscribirseCarrera('{$smarty.session.user.id}','{$smarty.request.id}')"><div class="checkboxUnchecked"></div><p id="textoInscribirse">Crees que irás a la carrera?</p></a>{else}<div class="checkboxChecked"></div><b><p id="textoInscribirse">Crees que irás a la carrera</p></b>{/if}{else}<div class="checkbox"></div><p><a href="javascript: void showLoginWindow()">Crees que irás a la carrera? Haz login...</a></p>{/if}</div>
		
		<div class="span-1 ticketOrange"></div>
		
		<div class="span-1 functionalContainerRight">
			<p class="titulo tituloLeft tituloColumnRight">LOCALIZACIÓN</p>
			<div id="map" class="mapStyleRight">
	            <object id="aroundMap" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="254" height="192" flashvars="id={$data.id}&amp;mapkey={$smarty.const.GMAPS_KEY}">
	              <param name="wmode" value="opaque">
	              <param name="movie" value="/flash/RunAroundMap.swf?7" />
	              <!--[if !IE]>-->
	              <object type="application/x-shockwave-flash" data="/flash/RunAroundMap.swf?7" width="254" height="192" flashvars="id={$data.id}&amp;mapkey={$smarty.const.GMAPS_KEY}">
	              <!--<![endif]-->
					    {if $data.start_point_lat === null}
<img width="254" height="192" src="http://maps.google.com/maps/api/staticmap?size=254x192&maptype=map&zoom=10&center={$data.event_location},spain&sensor=false&key={$smarty.const.GMAPS_KEY}" />					    
					    {else}
					<img src="http://maps.google.com/staticmap?size=254x192&maptype=map&zoom=10&markers={if $data.end_point_lat}{$data.end_point_lat},{$data.end_point_lon},bluem%7C{/if}{$data.start_point_lat},{$data.start_point_lon},greens&sensor=false&key={$smarty.const.GMAPS_KEY}">
					    {/if}
	              <!--[if !IE]>-->
	              </object>
	              <!--<![endif]-->
	            </object>						
			</div>
		</div>
		
		{if $runsInSameDates}
		<div class="span-1 functionalContainerRight">
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
						<div class="nameRaceRight"><a id="nameRunRight1{$smarty.foreach.raceloop.iteration}" href="/run/{$race.id}/{$race.name|seourl}">{$race.name}</a></div>
						<div class="dataRaceRight"><p>{$race.event_location} | {$race.distance_text}</p></div>
					</div>	
				</div>
				<div class="span-1 last separatorRight"></div>
		    {/foreach}					
		</div>
		</div>
		{/if}
		
		{if $similarTypeRaces}
		<div class="span-1 functionalContainerRight">
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
						<div class="nameRaceRight"><a id="nameRunRight2{$smarty.foreach.raceloop.iteration}" href="/run/{$race.id}/{$race.name|seourl}">{$race.name}</a></div>
						<div class="dataRaceRight"><p>{$race.event_location} | {$race.distance_text}</p></div>
					</div>	
				</div>
				<div class="span-1 last separatorRight"></div>
		    {/foreach}					
		</div>
		</div>
		{/if}

		{if $data.num_users > 0}
		<div class="span-1 functionalContainerRight">		
			<p class="titulo tituloLeft tituloColumnRight">USUARIOS APUNTADOS</p>
			<div class="events">				
				<div class="span-1 avatarContainer">
				{foreach key=id item=person from=$runners}
					<a href="/user/{$person.username}"><img class="avatarRight" src="/avatar.php?id={$person.user_id}&type=s"/>
						<div class="hidden">{$person.username}</div>
					</a>
			    {/foreach}
				</div>
			</div>
		</div>
		{/if}
	</div>

</div> <!-- content -->

</div> <!-- container -->


{include file="footer.tpl"} 
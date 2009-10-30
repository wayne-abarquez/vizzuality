{include file="header.tpl"}

{literal}
<script type="text/javascript"> 
$(document).ready(function(){
	
	if ($('div.rightColumn').height()<$('div.leftColumn').height()) {
		$('div.rightColumn').height($('div.leftColumn').height());	
	}
	
	$('#datos1').truncate({max_length: 32});

	new AjaxUpload('#buttonUploadPicture', {
    	action: '/imageController.php',
    	data : { 
				method:"uploadPicture",
				onTable:"users",
				onId:{/literal}{$user_id}{literal}
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
    	
    		var tipoCont = $("#pictureUserContainerNoPhotos").attr("title");
    		var iniciocadena = response.lastIndexOf("/");
    		var finalcadena = response.lastIndexOf("_");
    		var numcaracteres = finalcadena-iniciocadena;
    		var cadena = response.substr(iniciocadena+1,numcaracteres-1);
		
        	if(tipoCont=="first"){
        		$("#pictureUserContainerNoPhotos").remove();
        		$("#newphotos").append('<div class="pictureUserContainer" id="pictureUserContainer"><ul id="loc"><li><div class="imagesUser" id="imagesUser"><a href="/image.php?id='+cadena+'&source=user">' +response+ '</a></div></li></ul></div>');
				window.clearInterval(interval);
				$("#pictureUserContainer").append("<div class='span-1 editUserLinkDiv'><a class='editUserLink' id='buttonUploadPicture'>Subir fotos <img src='/img/pencil.gif'></a></div>");

				//enable upload button
				$("#buttonUploadPicture").enable();      
        	} else {
        	    var i=$('ul#loc li').size()+1;
        		if(i<6){
	            	$('<li><div class="imagesUser" id="imagesUser"><a href="/image.php?id='+cadena+'&source=user">' +response+ '</a></div></li>').prependTo('ul#loc');
	            	$("#buttonUploadPicture").html("Subir fotos <img src='/img/pencil.gif'>");
					window.clearInterval(interval);

					//enable upload button
					this.enable();
        		} else {
        			$('ul#loc li:last').remove();
	            	$('<li><div class="imagesUser" id="imagesUser"><a href="/image.php?id='+cadena+'&source=user">' +response+ '</a></div></li>').prependTo('ul#loc');
					$("#buttonUploadPicture").html("Subir fotos <img src='/img/pencil.gif'>");
					window.clearInterval(interval);

					//enable upload button
					this.enable();      
        		}
        		  	
			}
    								
    	}	
    		
    });  

    new AjaxUpload('#avatarPerfil', {
    	action: '/imageController.php',
    	data : { method:"uploadAvatar"},
    	onSubmit : function(file , ext){
    		if (ext && /^(jpg|png|jpeg|gif)$/.test(ext)){			
    			// change button text, when user selects file			
				$("#buttonUpload").html(".");


    			// If you want to allow uploading only 1 file at time,
    			// you can disable upload button
    			this.disable();


    			// Uploding -> Uploading. -> Uploading...
    			interval = window.setInterval(function(){
    				var text = $("#buttonUpload").html();
    				if (text.length < 17){
						$("#buttonUpload").html(text + '.');					
    				} else {
    					$("#buttonUpload").html(".");				
    				}
    			}, 200);

    		} else {
		
    			// extension is not allowed
    			//$('#example2 .text').text('Error: only images are allowed');
    			// cancel upload
    			return false;				
    		}

    	},
    	onComplete : function(file){

			$("#userImg").attr("src","/avatar.php?id={/literal}{$smarty.session.user.id}{literal}&type=t&"+new Date().valueOf());
			$("#buttonUpload").html("Subir foto");

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
		
<div class="span-1 columnNameUser"><p class="nameUserProfile">{$privateData.datos.completename} <span class="nameUserProfileNick">({$privateData.datos.username})</span></div>
		<div class="globalContainerUser">	
			<div class="span-1 last userData">
				<div class="span-1 avatarPerfil" id="avatarPerfil">
					<img class="imgAvatarPerfil" id="userImg" src="/avatar.php?id={$smarty.session.user.id}&type=t">
					<a class="changeAvatar" id="buttonUpload">Click para subir avatar</a>
				</div>
				<div class="span-1 last functionalContainer">
				<p class="titulo tituloLeft">ESTADÍSTICAS</p>
					<div class="span-1 last dataContainerUser">
						<div class="span-1 last dataTitleUser"><p>Visitas a tu perfil:</p></div>
						<div class="span-1 last dataUser"><p><b>{$privateData.datos.visits_profile}</b></p></div>
					</div>
					<div class="span-1 last dataContainerUser">
						<div class="span-1 last dataTitleUser"><p>Carreras corridas:</p></div>
						<div class="span-1 last dataUser"><p><b>{$privateData.datos.num_races_runned}</b></p></div>
					</div>
				</div>
				<div class="span-1 last functionalContainer">
				<p class="titulo tituloLeft">TU RANKING RUNNITY</p>
					{if $records}
						{foreach key=id item=record from=$records name=record}
						<div class="span-1 last dataContainerUser">
							<div class="span-1 last dataTitleUserRanking"><p>{$record.distance_name}:</p></div>
							<div class="span-1 last dataUserRanking"><p><b>{$record.time_taken}</b></p></div>
							<div class="span-1 last dataUserPosition"><div class="rankingBox"><p>{$record.position}º</p></div></div>
						</div>
						{/foreach}
					{else}
						<div class="span-1 last dataContainerUser">
							<p>No hay records, anímate y edita tus marcas</p>
						</div>					
					{/if}
					<a class="editUserLink" href="/usuario_editar.php">editar tus marcas <img src="/img/pencil.gif"></a>
				</div>
				<div class="span-1 last functionalContainer">
				<p class="titulo tituloLeft">DATOS PERSONALES</p>
					<div class="span-1 last dataContainerUser">
						<div class="span-1 last dataTitleUserProfile"><p>Email:</p></div>
						<div class="span-1 last dataUserProfile"><p id="datos1"><b>{$privateData.datos.email}</b></p></div>
					</div>
					<div class="span-1 last dataContainerUser">
						<div class="span-1 last dataTitleUserProfile"><p>Categoría:</p></div>
						<div class="span-1 last dataUserProfile"><p><b>{$categoria}</b></p></div>
					</div>
					<a class="editUserLink" href="/usuario_editar.php">editar tus datos <img src="/img/pencil.gif"></a>
				</div>
			</div>
			
			{if $privateData.datos.num_messages > 0}
			<div class="span-1 last userAlerts">
				<div class="alertUser"><p>Tienes <b>{$privateData.datos.num_messages} mensaje(s) nuevo(s)</b></p></div>
			</div>
			{/if}
			
			<div class="span-1 last imagesUserContainer">
				<p class="titulo tituloLeft tituloRight">TUS FOTOS {if !empty($pictures)}[{$pictures|@count}]{/if}</p>
				<div id="newphotos">
				{if $pictures}
				<div class="pictureUserContainer" id="pictureUserContainer">
					<ul id="loc">
					{foreach key=id item=picture from=$pictures name=pic}
						{if $smarty.foreach.pic.iteration<6}
							<li>
								<div class="imagesUser" id="imagesUser">
									<a href="/image.php?id={$picture.id}&source=user"><img src="{$picture.path|replace:"_b.jpg":"_t.jpg"}"/></a>
								</div>
							</li>
						{/if}
					{/foreach}
					</ul>
				</div>
				<div class="span-1 editUserLinkDiv"><a class="editUserLink" id="buttonUploadPicture">Subir fotos <img src="/img/pencil.gif"></a></div>
				{else}
					<div class="pictureUserContainerNoPhotos" id="pictureUserContainerNoPhotos" title="first">
						<p class="upPhotos">No has subido fotos...</p>
						<p class="down"><a href="#" id="buttonUploadPicture"><img src="/img/photoIconLight.gif">Subir fotos</a></p>
					</div>				
				{/if}
				</div>
			</div>
			
			<div class="span-1 last commentsUser">
				<p class="titulo tituloLeft tituloRight">MENSAJES PARA TI {if !empty($comments)}[{$comments|@count}]{/if}</p>
				{if $comments}
				<div class="span-1 last columnComments">
				<ol id="update">
				{foreach key=id item=comment from=$comments name=commentloop}
				{if $smarty.foreach.commentloop.iteration==1}		
					<div class="span-1 separatorFirstCommentUser"></div>
				{/if}
					<div id="commentUser" class="span-1 last">
						<div class="span-1 last avatarBox">
							<img src="/avatar.php?id={$comment.user_id}&type=s"/>	
						</div>
						<div class="span-1 commentBoxUser">
						<div class="nameUser"><a class="name" href="/user/{$comment.username}">{$comment.username}, </a>hace {$comment.created_when|timeAgo}</div>
						<p class="commentUserProfile">{$comment.commenttext}</p>
						</div>
					</div>
            	{/foreach}
            	</ol>
				</div>
				{else}
					<div class="pictureUserContainerNoPhotos">
						<p class="up">No tienes ningún mensaje...</p>
					</div> 
				{/if}
				
				
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
			<p class="titulo tituloLeft tituloColumnRight">TUS PRÓXIMAS CARRERAS</p>
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
		
		<div class="span-1 functionalContainer">
			<p class="titulo tituloLeft tituloColumnRight">CARRERAS APUNTADAS</p>
				<div id="map" class="mapStyleRight">
		            <object id="aroundMap" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="254" height="192" flashvars="id={$smarty.session.user.id}">
		              <param name="wmode" value="opaque">
		              <param name="movie" value="/flash/UserRacesMap.swf?7" />
		              <!--[if !IE]>-->
		              <object type="application/x-shockwave-flash" data="/flash/UserRacesMap.swf?7" width="254" height="192" flashvars="id={$smarty.session.user.id}">
		              <!--<![endif]-->
		              <!--[if !IE]>-->
		              </object>
		              <!--<![endif]-->
		            </object>						
				</div>
		</div>
		
		{if $friends}
		<div class="span-1 functionalContainer">
			<p class="titulo tituloLeft tituloColumnRight">USUARIOS A LOS QUE SIGUES</p>
			<div class="eventsUsers">
				<div class="avatarContainer">
				{foreach key=id item=friend from=$friends}
					<a href="/user/{$friend.username}"><img title="{$friend.username}" class="avatarRight" src="/avatar.php?id={$friend.id}&type=s"/>
						<div class="hidden">{$friend.username}</div>
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
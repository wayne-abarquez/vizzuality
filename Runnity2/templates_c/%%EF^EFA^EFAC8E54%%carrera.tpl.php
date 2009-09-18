<?php /* Smarty version 2.6.26, created on 2009-09-17 13:43:18
         compiled from carrera.tpl */ ?>
<?php require_once(SMARTY_CORE_DIR . 'core.load_plugins.php');
smarty_core_load_plugins(array('plugins' => array(array('function', 'getMonth', 'carrera.tpl', 90, false),array('modifier', 'substr', 'carrera.tpl', 90, false),array('modifier', 'replace', 'carrera.tpl', 180, false),array('modifier', 'count', 'carrera.tpl', 268, false),array('modifier', 'timeAgo', 'carrera.tpl', 286, false),)), $this); ?>
<?php $_smarty_tpl_vars = $this->_tpl_vars;
$this->_smarty_include(array('smarty_include_tpl_file' => "header.tpl", 'smarty_include_vars' => array()));
$this->_tpl_vars = $_smarty_tpl_vars;
unset($_smarty_tpl_vars);
 ?> 


<?php echo '
<script type="text/javascript">
    $(document).ready(function(){
        new AjaxUpload(\'#buttonUpload\', {
        	action: \'/imageController.php\',
        	data : { 
					method:"uploadPicture",
					onTable:"run",
					onId:'; ?>
<?php echo $this->_tpl_vars['data']['id']; ?>
<?php echo '
					},
        	onSubmit : function(file , ext){
        		if (ext && /^(jpg|png|jpeg|gif)$/.test(ext)){			
        			// change button text, when user selects file			
					$("#buttonUpload").attr("value",".");


        			// If you want to allow uploading only 1 file at time,
        			// you can disable upload button
        			this.disable();


        			// Uploding -> Uploading. -> Uploading...
        			interval = window.setInterval(function(){
        				var text = $("#buttonUpload").attr("value");
        				if (text.length < 17){
							$("#buttonUpload").attr("value",text + \'.\');					
        				} else {
        					$("#buttonUpload").attr("value",".");				
        				}
        			}, 200);

        		} else {
			
        			// extension is not allowed
        			//$(\'#example2 .text\').text(\'Error: only images are allowed\');
        			// cancel upload
        			return false;				
        		}

        	},
        	onComplete : function(file,response){	
				$("#imgItems").prepend(response);
				
				$("#buttonUpload").attr("value","Subir foto");

    			window.clearInterval(interval);

    			//enable upload button
    			this.enable();
    						
        	}		
        });
});

$(document).ready(function() {
	$("#browsable").scrollable().navigator();	
});

/*]]>*/</script>

'; ?>


<!-- GLOBAL CONTAINER RACE -->
	<div class="span-24 raceContainer" id="race">
	
		<!-- INSCRIPTION CONFIRMATION WINDOW -->
		<div id="confirmationWindow" style='display:none'>
			<h2 id="titleConfirmation" class="registerTitle">¿Quieres inscribirte a esta carrera?</h2>
			<div class="column span-9 first" id="confirmationButtons">
				<div class="column span-6 first apuntarteButton"><input id="confirmationButtonRace" class="fg-button" type="submit" value="Si, claro" onclick="javascript: void inscribirseCarrera(<?php echo $_SESSION['user']['id']; ?>
,<?php echo $_REQUEST['id']; ?>
)"/></div>
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
					        <div class="month month<?php echo $this->_tpl_vars['data']['run_type']; ?>
"><?php echo smarty_function_getMonth(array('month' => ((is_array($_tmp=$this->_tpl_vars['data']['event_date'])) ? $this->_run_mod_handler('substr', true, $_tmp, 5, 2) : substr($_tmp, 5, 2))), $this);?>
</div>
	    					<div class="day"><?php echo ((is_array($_tmp=$this->_tpl_vars['data']['event_date'])) ? $this->_run_mod_handler('substr', true, $_tmp, 8, 2) : substr($_tmp, 8, 2)); ?>
</div>
	    			</div>

					<div class="span-14 last">
						<p class="raceTitle" id="raceTitle"><?php echo $this->_tpl_vars['data']['name']; ?>
</p>
						<p class="raceDetailsTitle"><?php echo $this->_tpl_vars['data']['event_location']; ?>
 | <?php echo $this->_tpl_vars['data']['distance_text']; ?>
 | <b><?php echo $this->_tpl_vars['data']['num_users']; ?>
 usuarios van</b>,
						<input id="inscriptionButton" class="fg-button" type="button" value="<?php if ($this->_tpl_vars['data']['inscrito'] == 'f'): ?>apúntate<?php else: ?>voy a ir<?php endif; ?>" onclick="javascript: void checkInscrito(<?php if ($_SESSION): ?>'ok'<?php else: ?>'ko'<?php endif; ?>)"/>					
						
						</p>
					</div>
				</div>
			</div>
			
			<?php if ($this->_tpl_vars['data']['flickr_img_id'] === null): ?>
			    <img src="/media/run/<?php echo $this->_tpl_vars['data']['big_picture']; ?>
" class="carrera" />
			<?php else: ?>
			<a href="<?php echo $this->_tpl_vars['data']['flickr_url']; ?>
" target="_blank"><img src="/panoramioPic.php?id=<?php echo $this->_tpl_vars['data']['id']; ?>
&photo_id=<?php echo $this->_tpl_vars['data']['flickr_img_id']; ?>
" class="carrera" /></a>
			<?php endif; ?>
			<div class="span-16 raceContent">
			
				<div class="span-6 first">
					<?php if ($this->_tpl_vars['data']['distance_text'] != null || $this->_tpl_vars['data']['category'] != null || $this->_tpl_vars['data']['awards'] != null): ?>
						<div class="span-6 boxrace last">
							<h3 class="blue">Datos técnicos</h3>
							<?php if ($this->_tpl_vars['data']['distance_text'] != null): ?>
							<div class="span-6 databox">
								<div class="span-2 last distance"><p>Distancia:</p></div>
								<div class="span-4 last distanceInfo"><p><b><?php echo $this->_tpl_vars['data']['distance_text']; ?>
</b></p></div>
							</div>
							<?php endif; ?>
							<?php if ($this->_tpl_vars['data']['event_date'] != null): ?>
							<div class="span-6 databox">
								<div class="span-2 last distance"><p>Hora:</p></div>
								<div class="span-4 last distanceInfo"><p><b><?php echo ((is_array($_tmp=$this->_tpl_vars['data']['event_date'])) ? $this->_run_mod_handler('substr', true, $_tmp, 11, 5) : substr($_tmp, 11, 5)); ?>
</b></p></div>
							</div>
							<?php endif; ?>
							<?php if ($this->_tpl_vars['data']['category'] != null): ?>
							<div class="span-6 databox">
								<div class="span-2 last distance"><p>Categorias:</p></div>
								<div class="span-4 last distanceInfo"><p><b><?php echo $this->_tpl_vars['data']['category']; ?>
</b></p></div>
							</div>
							<?php endif; ?>
							<?php if ($this->_tpl_vars['data']['awards'] != null): ?>
							<div class="span-6 databox">
								<div class="span-2 last distance"><p>Premios:</p></div>
								<div class="span-4 last distanceInfo"><p><b><?php echo $this->_tpl_vars['data']['awards']; ?>
</b></p></div>
							</div>
							<?php endif; ?>
						</div>
					<?php endif; ?>
					<div class="span-6 boxrace last">
						<?php if ($this->_tpl_vars['data']['inscription_price'] != null || $this->_tpl_vars['data']['inscription_location'] != null || $this->_tpl_vars['data']['inscription_email'] != null || $this->_tpl_vars['data']['inscription_website'] != null || $this->_tpl_vars['data']['tlf_informacion'] != null): ?>
							<h3 class="blue">Inscripciones</h3>
							<?php if ($this->_tpl_vars['data']['inscription_price'] != null): ?>
							<div class="span-6 databox">
								<div class="span-2 last distance"><p>Precio:</p></div>
								<div class="span-4 last distanceInfo"><p><b><?php echo $this->_tpl_vars['data']['inscription_price']; ?>
</b></p></div>
							</div>
							<?php endif; ?>
							<?php if ($this->_tpl_vars['data']['inscription_location'] != null): ?>
							<div class="span-6 databox">
								<div class="span-2 last distance"><p>Lugar:</p></div>
								<div class="span-4 last distanceInfo"><p><b><?php echo $this->_tpl_vars['data']['inscription_location']; ?>
</b></p></div>
							</div>
							<?php endif; ?>
							<?php if ($this->_tpl_vars['data']['inscription_email'] != null): ?>
							<div class="span-6 databox">
								<div class="span-2 last distance"><p class="textRace">E-mail:</p></div>
								<div class="span-4 last distanceInfo"><p><a id="datos1" href="mailto:<?php echo $this->_tpl_vars['data']['inscription_email']; ?>
" class="special"><?php echo $this->_tpl_vars['data']['inscription_email']; ?>
</a></p></div>
							</div>
							<?php endif; ?>
							<?php if ($this->_tpl_vars['data']['inscription_website'] != null): ?>
							<div class="span-6 databox">
								<div class="span-2 last distance"><p class="textRace">Web:</p></div>
								<div class="span-4 last distanceInfo"><p><a target="_blank" id="datos2" href="<?php if (((is_array($_tmp=$this->_tpl_vars['data']['inscription_website'])) ? $this->_run_mod_handler('substr', true, $_tmp, 0, 7) : substr($_tmp, 0, 7)) == "http://"): ?><?php echo $this->_tpl_vars['data']['inscription_website']; ?>
<?php else: ?>http://<?php echo $this->_tpl_vars['data']['inscription_website']; ?>
<?php endif; ?>" class="special"><?php echo $this->_tpl_vars['data']['inscription_website']; ?>
</a></p></div>
							</div>	
							<?php endif; ?>
							<?php if ($this->_tpl_vars['data']['tlf_informacion'] != null): ?>
							<div class="span-6 databox noborder">
								<div class="span-2 last distance"><p class="textRace">Teléfono:</p></div>
								<div class="span-4 last distanceInfo"><p><a id="datos3" href="" class="special"><?php echo $this->_tpl_vars['data']['tlf_informacion']; ?>
</a></p></div>
							</div>	
							<?php endif; ?>
						<?php endif; ?>
						<div class="span-6 boxrace last">
						    <h3 class="blue">Compartir</h3>
						    <div class="span-4 last compartir">
                            	<a target=_blank href="http://www.facebook.com/share.php?u=http://www.runnity.com/run/<?php echo $this->_tpl_vars['data']['id']; ?>
/<?php echo ((is_array($_tmp=$this->_tpl_vars['data']['name'])) ? $this->_run_mod_handler('replace', true, $_tmp, ' ', '/') : smarty_modifier_replace($_tmp, ' ', '/')); ?>
"><img src="/img/ico_facebook.gif" alt="Facebook"></a>&nbsp;
                            	<a target=_blank href="http://del.icio.us/post?title=&url=http://www.runnity.com/run/<?php echo $this->_tpl_vars['data']['id']; ?>
/<?php echo ((is_array($_tmp=$this->_tpl_vars['data']['name'])) ? $this->_run_mod_handler('replace', true, $_tmp, ' ', '/') : smarty_modifier_replace($_tmp, ' ', '/')); ?>
"><img src="/img/ico_delicious.gif" alt="delicious"></a>&nbsp;
                            	<a target=_blank href="http://meneame.net/submit.php?url=http://www.runnity.com/run/<?php echo $this->_tpl_vars['data']['id']; ?>
/<?php echo ((is_array($_tmp=$this->_tpl_vars['data']['name'])) ? $this->_run_mod_handler('replace', true, $_tmp, ' ', '/') : smarty_modifier_replace($_tmp, ' ', '/')); ?>
"><img src="/img/ico_meneame.gif" alt="meneame"></a>
                                <a target=_blank href="http://twitter.com/home?status=http://www.runnity.com/run/<?php echo $this->_tpl_vars['data']['id']; ?>
/<?php echo ((is_array($_tmp=$this->_tpl_vars['data']['name'])) ? $this->_run_mod_handler('replace', true, $_tmp, ' ', '/') : smarty_modifier_replace($_tmp, ' ', '/')); ?>
"><img src="/img/ico_twitter.png" alt="twitter"></a>	
                                <a target=_blank href="http://digg.com/submit?phase=2&url=<?php echo $this->_tpl_vars['data']['id']; ?>
/<?php echo ((is_array($_tmp=$this->_tpl_vars['data']['name'])) ? $this->_run_mod_handler('replace', true, $_tmp, ' ', '/') : smarty_modifier_replace($_tmp, ' ', '/')); ?>
"><img src="/img/ico_digg.png" alt="Facebook"></a>&nbsp;				        
						    </div>	    
						</div>					
					</div>
				</div>

				<div class="span-10 last">
					<div class="marginDescription"><h3 class="blue">Descripción</h3></div>
					<div class="marginDescription">
						<p class="textRace">
							<?php if ($this->_tpl_vars['data']['description'] != null): ?>
								<?php echo $this->_tpl_vars['data']['description']; ?>

							<?php else: ?>
							No hay descripción para esta carrera, ¿te animas a <a href="javascript: void showContactBox()">enviarnos una?</a>
							<?php endif; ?>	
						</p>
					</div>	
				</div>	
				
                <?php if ($this->_tpl_vars['data']['start_point_lat'] == null): ?>
                	<div id="map3Container" class="span-16"></div>
                <?php else: ?>	
                <a name="map2Container">		
					<div class="span-16">
						<div class="marginDescription margin10"><h3 class="blue">Mapa del recorrido aproximado</h3></div>
						<div class="mapStyle marginDescription">
							<div id="trackMap">
	                            <object id="flashMovie" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="609" height="400" wmode="opaque" flashvars="id=<?php echo $this->_tpl_vars['data']['id']; ?>
">
	                              <param name="movie" value="/flash/raceMapViewer.swf?2" />
	                              <!--[if !IE]>-->
	                              <object type="application/x-shockwave-flash" data="/flash/raceMapViewer.swf" width="609" height="400" wmode="opaque" flashvars="id=<?php echo $this->_tpl_vars['data']['id']; ?>
">
	                              <!--<![endif]-->

	                              <!--[if !IE]>-->
	                              </object>
	                              <!--<![endif]-->
	                            </object>		    					    
							</div>
						</div>	
					</div>
				</a>
				<?php endif; ?>	
				
				<div class="span-16">
						<div class="marginDescription margin10"><h3 class="blue">Fotos de la carrera</h3></div>
						<input id="buttonUpload" class="fg-button" type="submit" value="Subir fotos">
				</div>
				
				<?php if ($this->_tpl_vars['pictures'] != false): ?>
				<!-- IMAGE -->
				<div id="showImage" style="display:hidden;">
					
				</div>
				
				<!-- GALLERY -->
				<div class="gallery span-16">
					<div class="navi"></div>
					
					<a class="column span-1 first prevPage browse left"></a>
					
					<div class="column span-14 scrollable" id="browsable">	
						
						<div class="items" id="imgItems">
						<?php if ($this->_tpl_vars['pictures']): ?>
							<?php $_from = $this->_tpl_vars['pictures']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }if (count($_from)):
    foreach ($_from as $this->_tpl_vars['id'] => $this->_tpl_vars['picture']):
?>
							    <img src="<?php echo $this->_tpl_vars['picture']['path']; ?>
" onclick="javascript: void showModalImage('<?php echo $this->_tpl_vars['picture']['path']; ?>
')"/>
							<?php endforeach; endif; unset($_from); ?>	
						<?php endif; ?>	
						</div>
						
					</div>
					
					<!-- "next page" action -->
					<a class="column span-1 last nextPage browse right"></a>
									
				</div>	
				<?php endif; ?>
									

				<!-- END GALLERY -->
				

				
				<div class="span-16 marginDescription marginTop7">
					<div class="marginDescription"><h3 class="blue">Comentarios <?php if (! empty ( $this->_tpl_vars['comments'] )): ?>[<?php echo count($this->_tpl_vars['comments']); ?>
]<?php endif; ?></h3><h5><a onclick="document.getElementById('commentTextArea').focus();
" class="PublicarComentarioEnlace">publicar un comentario</a></h5></div>			
					<ol id="update">
						<?php $_from = $this->_tpl_vars['comments']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }if (count($_from)):
    foreach ($_from as $this->_tpl_vars['id'] => $this->_tpl_vars['comment']):
?>
	    				<?php if ($this->_tpl_vars['comment'] == false): ?>
	    					<div class="column span-15 noCommentsContainer">
	        					<div class="carita"></div>
	        					<div class="noResultsText">
	        					<p class="noResults"><b>Aún no hay comentarios sobre esta carrera</b></p>
	        					<p class="noResultsSub">Pero si quieres puedes <a href="/rss.php">subscribirte a nuestro RSS</a> para estar al tanto de todo lo ocurrido en runnity</p>
								</div>
	        				</div>  
	    				<?php else: ?>	    										
							<div class="column span-16 first racesComment">				
								<div class="column span-3 first image">
									<img src="/avatar.php?id=<?php echo $this->_tpl_vars['comment']['user_id']; ?>
"/>	
								</div>
								<div class="column span-12 last commentBox">
									<div class="nameUser"><a class="nameRace" href="/user/<?php echo $this->_tpl_vars['comment']['username']; ?>
"><?php echo $this->_tpl_vars['comment']['username']; ?>
, </a>hace <?php echo ((is_array($_tmp=$this->_tpl_vars['comment']['created_when'])) ? $this->_run_mod_handler('timeAgo', true, $_tmp) : smarty_modifier_timeAgo($_tmp)); ?>
</div>
									<p class="textRace"><?php echo $this->_tpl_vars['comment']['commenttext']; ?>
</p>
								</div>
							</div>							
	              		<?php endif; ?>
	                	<?php endforeach; else: ?>
	                	    <div class="column span-15 noCommentsContainer">
	        					<div class="carita"></div>
	        					<div class="noResultsText">
	        					<p class="noResults"><b>Aún no hay comentarios sobre esta carrera</b></p>
	        					<p class="noResultsSub">Pero si quieres puedes <a href="/rss.php">subscribirte a nuestro RSS</a> para estar al tanto de todo lo ocurrido en runnity</p>
								</div>
	        				</div>    
	                	<?php endif; unset($_from); ?>						
					</ol>
				</div>
				
				<!-- PARA AÑADIR COMENTARIOS -->
				<div class="span-16 boxraceMap">
					<div class="span-16" id="flash" align="left"></div>
					<div class="commentArea" id="commentBox">					
						<?php if ($_SESSION['logged']): ?>
							<div class="span-14 titleComents">Anímate y publica tu comentario</div>
							<textarea name="textarea2" id="commentTextArea" class="span-15 textArea"></textarea>
							<input class="fg-button" type="submit" value="Publicar comentario" onclick="javascript: void commentAction(<?php echo $_REQUEST['id']; ?>
,'run')"/>
						<?php else: ?>
							<p class="noComments">Para realizar comentarios debes <b><a href="javascript: void showLoginBox()">iniciar tu sesión</a></b> en runnity. <b><a href="javascript: void showRegisterBox()">¿Aún no estás registrado?</a></b></p>
						<?php endif; ?>
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
			            <object id="aroundMap" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="270" height="152" wmode="opaque" flashvars="id=<?php echo $this->_tpl_vars['data']['id']; ?>
">
			              <param name="movie" value="/flash/RunAroundMap.swf?6" />
			              <!--[if !IE]>-->
			              <object type="application/x-shockwave-flash" data="/flash/RunAroundMap.swf?6" width="270" height="152" wmode="opaque" flashvars="id=<?php echo $this->_tpl_vars['data']['id']; ?>
">
			              <!--<![endif]-->
							    <?php if ($this->_tpl_vars['data']['start_point_lat'] === null): ?>
		<img width="270" height="152" src="http://maps.google.com/maps/api/staticmap?size=270x152&maptype=map&zoom=10&center=<?php echo $this->_tpl_vars['data']['event_location']; ?>
,spain&sensor=false&key=ABQIAAAAtDJGVn6RztUmxjnX5hMzjRTy9E-TgLeuCHEEJunrcdV8Bjp5lBTu2Rw7F-koeV8TrxpLHZPXoYd2BA" />					    
							    <?php else: ?>
							<img src="http://maps.google.com/staticmap?size=270x152&maptype=map&zoom=10&markers=<?php if ($this->_tpl_vars['data']['end_point_lat']): ?><?php echo $this->_tpl_vars['data']['end_point_lat']; ?>
,<?php echo $this->_tpl_vars['data']['end_point_lon']; ?>
,bluem%7C<?php endif; ?><?php echo $this->_tpl_vars['data']['start_point_lat']; ?>
,<?php echo $this->_tpl_vars['data']['start_point_lon']; ?>
,greens&sensor=false&key=ABQIAAAAtDJGVn6RztUmxjnX5hMzjRTy9E-TgLeuCHEEJunrcdV8Bjp5lBTu2Rw7F-koeV8TrxpLHZPXoYd2BA">
							    <?php endif; ?>
			              <!--[if !IE]>-->
			              </object>
			              <!--<![endif]-->
			            </object>						
					</div>
				</div>
			</div>
	
	        <?php if ($this->_tpl_vars['runsInSameDates']): ?>
			<div class="span-8 importantRaces">
				<div class="events"> 
					<h2 class="newsTitle">En las mismas fechas</h2>
				</div>
				<div class="events">
            		<?php $_from = $this->_tpl_vars['runsInSameDates']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }if (count($_from)):
    foreach ($_from as $this->_tpl_vars['id'] => $this->_tpl_vars['race']):
?>	    				    
        					<div class="span-8 column first raceDetails" id="raceDetails">
        						<div class="column span-1 first date">
	    					        <div class="month month<?php echo $this->_tpl_vars['race']['run_type']; ?>
"><?php echo smarty_function_getMonth(array('month' => ((is_array($_tmp=$this->_tpl_vars['race']['event_date'])) ? $this->_run_mod_handler('substr', true, $_tmp, 5, 2) : substr($_tmp, 5, 2))), $this);?>
</div>
	    							<div class="day"><?php echo ((is_array($_tmp=$this->_tpl_vars['race']['event_date'])) ? $this->_run_mod_handler('substr', true, $_tmp, 8, 2) : substr($_tmp, 8, 2)); ?>
</div>
	    						</div>
        						<div class="column span-6 last calendarRaces">
        							<div class="nextRaceComment"><a href="/run/<?php echo $this->_tpl_vars['race']['id']; ?>
/<?php echo ((is_array($_tmp=$this->_tpl_vars['race']['name'])) ? $this->_run_mod_handler('replace', true, $_tmp, ' ', '/') : smarty_modifier_replace($_tmp, ' ', '/')); ?>
" class="nameRace"><?php echo $this->_tpl_vars['race']['name']; ?>
</a></div>
        							<div class="raceLocation"><?php echo $this->_tpl_vars['race']['event_location']; ?>
 | <?php echo $this->_tpl_vars['race']['distance_text']; ?>
 | <b><?php echo $this->_tpl_vars['race']['num_users']; ?>
 van</b> </div>
        						</div>
        					</div>
                	    <?php endforeach; endif; unset($_from); ?>					
				</div>
			</div>
			<?php endif; ?>
			<?php if ($this->_tpl_vars['similarTypeRaces']): ?>
			<div class="span-8 importantRaces">
				<div class="events"> 
					<h2 class="newsTitle">De distancia parecida</h2>
				</div>
				<div class="events">
            		<?php $_from = $this->_tpl_vars['similarTypeRaces']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }if (count($_from)):
    foreach ($_from as $this->_tpl_vars['id'] => $this->_tpl_vars['race']):
?>    				    
        					<div class="span-8 column first raceDetails" id="raceDetails">
        						<div class="column span-1 first date">
	    							<div class="month month<?php echo $this->_tpl_vars['race']['run_type']; ?>
"><?php echo smarty_function_getMonth(array('month' => ((is_array($_tmp=$this->_tpl_vars['race']['event_date'])) ? $this->_run_mod_handler('substr', true, $_tmp, 5, 2) : substr($_tmp, 5, 2))), $this);?>
</div>
	    							<div class="day"><?php echo ((is_array($_tmp=$this->_tpl_vars['race']['event_date'])) ? $this->_run_mod_handler('substr', true, $_tmp, 8, 2) : substr($_tmp, 8, 2)); ?>
</div>
	    						</div>
        						<div class="column span-6 last calendarRaces">
        							<div class="nextRaceComment"><a href="/run/<?php echo $this->_tpl_vars['race']['id']; ?>
/<?php echo ((is_array($_tmp=$this->_tpl_vars['race']['name'])) ? $this->_run_mod_handler('replace', true, $_tmp, ' ', '/') : smarty_modifier_replace($_tmp, ' ', '/')); ?>
" class="nameRace"><?php echo $this->_tpl_vars['race']['name']; ?>
</a></div>
        							<div class="raceLocation"><?php echo $this->_tpl_vars['race']['event_location']; ?>
 | <?php echo $this->_tpl_vars['race']['distance_text']; ?>
 | <b><?php echo $this->_tpl_vars['race']['num_users']; ?>
 van</b> </div>
        						</div>
        					</div>
                	    <?php endforeach; endif; unset($_from); ?>					
				</div>
			</div>
            <?php endif; ?>
            <div class="span-8">
	            <div class=" events2">
				    <input class="fg-button VerCalendario" type="button" value="Ver calendario completo" onclick="location='/buscar'"/>
				</div>  
            </div>
			  
			
			<div class="span-8 marginTopPlus">
				<div class="events"> 
					<h2 class="newsTitle">Valientes apuntados</h2>	
					<?php $_from = $this->_tpl_vars['runners']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }if (count($_from)):
    foreach ($_from as $this->_tpl_vars['id'] => $this->_tpl_vars['person']):
?>
    				<?php if ($this->_tpl_vars['person'] == 'f'): ?>
    					<div class="span-8 races2">
    						<p class="noApuntado">Aun no hay ningún valiente</p>
							<p class="noRaceSub">¿Quieres ser el primero? <b><a href="/rss">Apúntate</a></b></p>
						</div> 
    				<?php else: ?>					
    					<div class="span-8 races2 defaultWidth">
    						<div class="column first image2">
    							<img src="/avatar.php?id=<?php echo $this->_tpl_vars['person']['user_id']; ?>
"/>	
    						</div>
    						<div class="column last">
    							<div class="detailsUser">
    								<div class="nameUser"><a class="nameRace" href="/user/<?php echo $this->_tpl_vars['person']['username']; ?>
"><?php echo $this->_tpl_vars['person']['username']; ?>
</a></div>
    								<div class="raceUserDetails"> dice que va a ir a esta carrera</div>
    							</div>
    							<div><p class="runnersNumber"><a href="">apúntate con él</a></p></div>
    						</div>
    					</div>
        			<?php endif; ?>
        		    <?php endforeach; else: ?>
        		        <div class="span-8 races2">
    						<p class="noApuntado">Aun no hay ningún valiente</p>
							<p class="noRaceSub">¿Quieres ser el primero? <b><a href="/rss.php">Apúntate</a></b></p>
						</div>     
        		    <?php endif; unset($_from); ?>					
				</div>
			</div>	
			<!--<div class="flickrFrame">
			    <iframe align="center" src="http://www.flickr.com/slideShow/index.gne?" frameBorder="0" width="280" scrolling="no" height="280"></iframe>
			</div>-->
			
		</div>
	</div>
</div>


<?php echo '
<script language="javaScript" type="text/javascript">
	$(document).ready( function() {
	    
	    for (i=1;i<=3;i++){
			var len = 20;
			var p = document.getElementById("datos" + i);
			
			if (p) {
			  var trunc = p.innerHTML;
			  trunc = trunc.replace(/\\t/g, "");
			  if (trunc.length > len) {
				
			    trunc = trunc.substring(0, len);
			
			    trunc += \'<a style="color: #666666;">\' +
			      \'...<\\/a>\';
			    p.innerHTML = trunc;
			  }
			}
		}
	    
	    
	});
</script>
'; ?>


<?php $_smarty_tpl_vars = $this->_tpl_vars;
$this->_smarty_include(array('smarty_include_tpl_file' => "footer.tpl", 'smarty_include_vars' => array()));
$this->_tpl_vars = $_smarty_tpl_vars;
unset($_smarty_tpl_vars);
 ?>
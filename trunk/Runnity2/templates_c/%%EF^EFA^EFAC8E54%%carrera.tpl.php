<?php /* Smarty version 2.6.26, created on 2009-10-13 15:14:29
         compiled from carrera.tpl */ ?>
<?php require_once(SMARTY_CORE_DIR . 'core.load_plugins.php');
smarty_core_load_plugins(array('plugins' => array(array('function', 'getMonth', 'carrera.tpl', 10, false),array('function', 'cycle', 'carrera.tpl', 244, false),array('modifier', 'substr', 'carrera.tpl', 10, false),array('modifier', 'replace', 'carrera.tpl', 94, false),array('modifier', 'count', 'carrera.tpl', 157, false),array('modifier', 'timeAgo', 'carrera.tpl', 175, false),)), $this); ?>
<?php $_smarty_tpl_vars = $this->_tpl_vars;
$this->_smarty_include(array('smarty_include_tpl_file' => "header.tpl", 'smarty_include_vars' => array()));
$this->_tpl_vars = $_smarty_tpl_vars;
unset($_smarty_tpl_vars);
 ?>

<div class="span-24 column content">

	<div class="span-1 last leftColumn">
		<p class="navigation"><a href="/buscar?q=<?php echo $this->_tpl_vars['data']['province_name']; ?>
">Carreras en <?php echo $this->_tpl_vars['data']['province_name']; ?>
 ></a></p>
		
		<div class="carreraPrincipal">
			<div class="column span-1 first calendar">
				<div class="month month<?php echo $this->_tpl_vars['data']['run_type']; ?>
"><?php echo smarty_function_getMonth(array('month' => ((is_array($_tmp=$this->_tpl_vars['data']['event_date'])) ? $this->_run_mod_handler('substr', true, $_tmp, 5, 2) : substr($_tmp, 5, 2))), $this);?>
</div>
		    	<div class="day"><?php echo ((is_array($_tmp=$this->_tpl_vars['data']['event_date'])) ? $this->_run_mod_handler('substr', true, $_tmp, 8, 2) : substr($_tmp, 8, 2)); ?>
</div>
		    </div>
		    <p class="raceTitle" id="raceTitle"><?php echo $this->_tpl_vars['data']['name']; ?>
</p>
		    <p class="raceDetailsTitle"><?php echo $this->_tpl_vars['data']['event_location']; ?>
 | <?php echo $this->_tpl_vars['data']['distance_text']; ?>
 | <b><?php echo $this->_tpl_vars['data']['num_users']; ?>
 usuarios van</b></p>
		    
		    <?php if ($this->_tpl_vars['data']['flickr_img_id'] === null): ?>
			    <img src="/media/run/<?php echo $this->_tpl_vars['data']['big_picture']; ?>
" class="imageCarrera"/>
			<?php else: ?>
			<a href="<?php echo $this->_tpl_vars['data']['flickr_url']; ?>
" target="_blank"><img class="imageCarrera" src="/panoramioPic.php?id=<?php echo $this->_tpl_vars['data']['id']; ?>
&photo_id=<?php echo $this->_tpl_vars['data']['flickr_img_id']; ?>
"/></a>
			<?php endif; ?>
			
			
			<div class="span-1 last raceData">
				<?php if ($this->_tpl_vars['data']['distance_text'] != null || $this->_tpl_vars['data']['category'] != null || $this->_tpl_vars['data']['awards'] != null): ?>
				<div class="span-1 last functionalContainer">
					<p class="titulo tituloLeft">DATOS TÉCNICOS</p>
					<?php if ($this->_tpl_vars['data']['distance_text'] != null): ?>
						<div class="span-1 last dataContainer">
							<div class="span-1 last dataTitle"><p>Distancia:</p></div>
							<div class="span-1 last data"><p><b><?php echo $this->_tpl_vars['data']['distance_text']; ?>
</b></p></div>
						</div>
						<?php endif; ?>
						<?php if ($this->_tpl_vars['data']['event_date'] != null): ?>
						<div class="span-1 last dataContainer">
							<div class="span-1 last dataTitle"><p>Hora:</p></div>
							<div class="span-1 last data"><p><b><?php echo ((is_array($_tmp=$this->_tpl_vars['data']['event_date'])) ? $this->_run_mod_handler('substr', true, $_tmp, 11, 5) : substr($_tmp, 11, 5)); ?>
</b></p></div>
						</div>
						<?php endif; ?>
						<?php if ($this->_tpl_vars['data']['category'] != null): ?>
						<div class="span-1 last dataContainer">
							<div class="span-1 last dataTitle"><p>Categorias:</p></div>
							<div class="span-1 last data"><p><b><?php echo $this->_tpl_vars['data']['category']; ?>
</b></p></div>
						</div>
						<?php endif; ?>
						<?php if ($this->_tpl_vars['data']['awards'] != null): ?>
						<div class="span-1 last dataContainer">
							<div class="span-1 last dataTitle"><p>Premios:</p></div>
							<div class="span-1 last data"><p><b><?php echo $this->_tpl_vars['data']['awards']; ?>
</b></p></div>
						</div>
					<?php endif; ?>
					</div>
				<?php endif; ?>
				
				<?php if ($this->_tpl_vars['data']['inscription_price'] != null || $this->_tpl_vars['data']['inscription_location'] != null || $this->_tpl_vars['data']['inscription_email'] != null || $this->_tpl_vars['data']['inscription_website'] != null || $this->_tpl_vars['data']['tlf_informacion'] != null): ?>
					<div class="span-1 last functionalContainer">
						<p class="titulo tituloLeft">INSCRIPCIONES</p>
						<?php if ($this->_tpl_vars['data']['inscription_price'] != null): ?>
						<div class="span-1 last dataContainer">
							<div class="span-1 last dataTitle"><p>Precio:</p></div>
							<div class="span-1 last data"><p><b><?php echo $this->_tpl_vars['data']['inscription_price']; ?>
</b></p></div>
						</div>
						<?php endif; ?>
						<?php if ($this->_tpl_vars['data']['inscription_location'] != null): ?>
						<div class="span-1 last dataContainer">
							<div class="span-1 last dataTitle"><p>Lugar:</p></div>
							<div class="span-1 last data"><p><b><?php echo $this->_tpl_vars['data']['inscription_location']; ?>
</b></p></div>
						</div>
						<?php endif; ?>
						<?php if ($this->_tpl_vars['data']['inscription_email'] != null): ?>
						<div class="span-1 last dataContainer">
							<div class="span-1 last dataTitle"><p class="textRace">E-mail:</p></div>
							<div class="span-1 last data"><p><a id="datos1" href="mailto:<?php echo $this->_tpl_vars['data']['inscription_email']; ?>
" class="special"><?php echo $this->_tpl_vars['data']['inscription_email']; ?>
</a></p></div>
						</div>
						<?php endif; ?>
						<?php if ($this->_tpl_vars['data']['inscription_website'] != null): ?>
						<div class="span-1 last dataContainer">
							<div class="span-1 last dataTitle"><p class="textRace">Web:</p></div>
							<div class="span-1 last data"><p><a target="_blank" id="datos2" href="<?php if (((is_array($_tmp=$this->_tpl_vars['data']['inscription_website'])) ? $this->_run_mod_handler('substr', true, $_tmp, 0, 7) : substr($_tmp, 0, 7)) == "http://"): ?><?php echo $this->_tpl_vars['data']['inscription_website']; ?>
<?php else: ?>http://<?php echo $this->_tpl_vars['data']['inscription_website']; ?>
<?php endif; ?>" class="special"><?php echo ((is_array($_tmp=$this->_tpl_vars['data']['inscription_website'])) ? $this->_run_mod_handler('substr', true, $_tmp, 7) : substr($_tmp, 7)); ?>
</a></p></div>
						</div>	
						<?php endif; ?>
						<?php if ($this->_tpl_vars['data']['tlf_informacion'] != null): ?>
						<div class="span-6 dataContainer noborder">
							<div class="span-1 last dataTitle"><p class="textRace">Teléfono:</p></div>
							<div class="span-1 last data"><p><b><?php echo $this->_tpl_vars['data']['tlf_informacion']; ?>
</b></p></div>
						</div>	
						<?php endif; ?>
					</div>	
				<?php endif; ?>
				
				<div class="span-1 last raceData">
				<p class="titulo tituloLeft">COMPARTIR</p>
<a target=_blank href="http://www.facebook.com/share.php?u=http://www.runnity.com/run/<?php echo $this->_tpl_vars['data']['id']; ?>
/<?php echo ((is_array($_tmp=$this->_tpl_vars['data']['name'])) ? $this->_run_mod_handler('replace', true, $_tmp, ' ', '/') : smarty_modifier_replace($_tmp, ' ', '/')); ?>
"><img src="/img/ico_facebook.gif" alt="Facebook"></a>
<a target=_blank href="http://del.icio.us/post?title=&url=http://www.runnity.com/run/<?php echo $this->_tpl_vars['data']['id']; ?>
/<?php echo ((is_array($_tmp=$this->_tpl_vars['data']['name'])) ? $this->_run_mod_handler('replace', true, $_tmp, ' ', '/') : smarty_modifier_replace($_tmp, ' ', '/')); ?>
"><img src="/img/ico_delicious.gif" alt="delicious"></a>
<a target=_blank href="http://meneame.net/submit.php?url=http://www.runnity.com/run/<?php echo $this->_tpl_vars['data']['id']; ?>
/<?php echo ((is_array($_tmp=$this->_tpl_vars['data']['name'])) ? $this->_run_mod_handler('replace', true, $_tmp, ' ', '/') : smarty_modifier_replace($_tmp, ' ', '/')); ?>
"><img src="/img/ico_meneame.gif" alt="meneame"></a>
<a target=_blank href="http://twitter.com/home?status=http://www.runnity.com/run/<?php echo $this->_tpl_vars['data']['id']; ?>
/<?php echo ((is_array($_tmp=$this->_tpl_vars['data']['name'])) ? $this->_run_mod_handler('replace', true, $_tmp, ' ', '/') : smarty_modifier_replace($_tmp, ' ', '/')); ?>
"><img src="/img/ico_twitter.png" alt="twitter"></a>	
<a target=_blank href="http://digg.com/submit?phase=2&url=<?php echo $this->_tpl_vars['data']['id']; ?>
/<?php echo ((is_array($_tmp=$this->_tpl_vars['data']['name'])) ? $this->_run_mod_handler('replace', true, $_tmp, ' ', '/') : smarty_modifier_replace($_tmp, ' ', '/')); ?>
"><img src="/img/ico_digg.png" alt="Facebook"></a> 
				</div>

			</div>
			
			<div class="span-1 last raceDescription">
				<div class="span-1 last functionalContainer">
					<p class="titulo tituloLeft tituloRight columnLonga">DESCRIPCIÓN Y DATOS ADICIONALES</p>
					<p class="textRace">
						<?php if ($this->_tpl_vars['data']['description'] != null): ?>
							<p class="textRace"><?php echo $this->_tpl_vars['data']['description']; ?>
</p>
						<?php else: ?>
							<div class="nodesc">
								<img src="/img/nodesc.gif" />
								<p>Aún no tenemos descripción para esta carrera,<br /> 
								<a href="javascript: void showContactBox()">¿te animas a enviarnos una?</a></p>
							</div>
						<?php endif; ?>	
				</div>			
			</div>

			
			<div class="span-1 last columnLong">
				<?php if ($this->_tpl_vars['data']['start_point_lat'] == null): ?>
				
                <?php else: ?>
					<p class="titulo tituloLeft tituloRight">MAPA DE LA CARRERA Y ALTIMETRÍA APROXIMADA</p>
                	<div id="map3Container" class="span-16"></div>                
					<div>
						<div class="mapStyle">
							<div id="trackMap">
	                            <object id="flashMovie" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="600" height="400" wmode="opaque" flashvars="id=<?php echo $this->_tpl_vars['data']['id']; ?>
">
	                              <param name="movie" value="/flash/raceMapViewer.swf?2" />
	                              <!--[if !IE]>-->
	                              <object type="application/x-shockwave-flash" data="/flash/raceMapViewer.swf" width="600" height="400" wmode="opaque" flashvars="id=<?php echo $this->_tpl_vars['data']['id']; ?>
">
	                              <!--<![endif]-->

	                              <!--[if !IE]>-->
	                              </object>
	                              <!--<![endif]-->
	                            </object>		    					    
							</div>
						</div>	
					</div>
				<?php endif; ?>
			</div>
			
			<?php if ($this->_tpl_vars['pictures']): ?>
			<div class="span-1 last bannerTopPhotos"></div>
			<div class="span-1 last columnPhotos">
<!--
				<?php $_from = $this->_tpl_vars['pictures']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }if (count($_from)):
    foreach ($_from as $this->_tpl_vars['id'] => $this->_tpl_vars['picture']):
?>
					<img src="<?php echo $this->_tpl_vars['picture']['path']; ?>
"/>
				<?php endforeach; endif; unset($_from); ?>
-->	
			</div>
			<?php endif; ?>	
			
			<div class="span-1 last columnLong">
				<p class="titulo tituloLeft tituloRight">COMENTARIOS <?php if (! empty ( $this->_tpl_vars['comments'] )): ?>[<?php echo count($this->_tpl_vars['comments']); ?>
]<?php endif; ?>
				<a class="publica" onclick="document.getElementById('commentTextArea').focus();">publicar un comentario</a>
				</p>
				<ol id="update">
				<?php $_from = $this->_tpl_vars['comments']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }if (count($_from)):
    foreach ($_from as $this->_tpl_vars['id'] => $this->_tpl_vars['comment']):
?>
				<?php if ($this->_tpl_vars['comment'] == false): ?>
					<!--
<div class="span-1 last noComments">
						<p>Aún no hay comentarios sobre esta carrera</p>
        				<p>Pero si quieres puedes <a href="/rss.php">subscribirte a nuestro RSS</a> para estar al tanto de todo lo ocurrido en runnity</p>
    				</div>  
-->
				<?php else: ?>	    										
					<div id="comment" class="span-1 last">
						<div class="span-1 last avatarBox">
							<img src="/img/avatar.jpg"/>	
						</div>
						<div class="span-1 commentBox">
						<div class="nameUser"><a class="name" href="/user/<?php echo $this->_tpl_vars['comment']['username']; ?>
"><?php echo $this->_tpl_vars['comment']['username']; ?>
, </a>hace <?php echo ((is_array($_tmp=$this->_tpl_vars['comment']['created_when'])) ? $this->_run_mod_handler('timeAgo', true, $_tmp) : smarty_modifier_timeAgo($_tmp)); ?>
</div>
						<p class="commentUser"><?php echo $this->_tpl_vars['comment']['commenttext']; ?>
</p>
						</div>
						
					</div>							
          		<?php endif; ?>
            	<?php endforeach; else: ?>
					<div class="span-1 noComments">
						<p>Aún no hay comentarios sobre esta carrera</p>
        				<p>Pero si quieres puedes <a href="/rss.php">subscribirte a nuestro RSS</a> para estar al tanto de todo lo ocurrido en runnity</p>
    				</div>    
            	<?php endif; unset($_from); ?>	
            </ol>						
			</div>
			
			<!-- PARA AÑADIR COMENTARIOS -->
			<div class="span-8" id="flash" align="left"></div>
			<div class="span-1 last boxraceMap">
				<div class="commentArea" id="commentBox">	
				<?php if ($_SESSION['logged']): ?>				
					<div class="titleComents">Anímate y publica tu comentario</div>
					<textarea name="textarea2" id="commentTextArea" class="textArea"></textarea>
					<input class="fg-button buttonComment" type="submit" value="Publicar comentario" onclick="javascript: void commentAction(<?php echo $_REQUEST['id']; ?>
,'run',$('#commentTextArea').val())"/>
				<?php else: ?>
				<div class="span-1 iconPhrase">
					<img src="/img/slash.gif"/>
				</div>
				<div>
					<p class="noComments">Para realizar comentarios debes <b><a href="javascript: void showLoginWindow()">iniciar tu sesión</a></b> en runnity. <b><a href="/registro">¿Aún no estás registrado?</a></b></p>
				</div>
				 <?php endif; ?>

				</div>
			</div>
			
		</div>
	</div>
	
	<!-- RIGHT COLUMN -->
	<div class="span-1 last rightColumn">
		<div class="span-1 ticketOrangeVoy" id="ticketOrangeVoy"><?php if ($_SESSION): ?><a href="javascript: void inscribirseCarrera('<?php echo $_SESSION['user']['id']; ?>
','<?php echo $_REQUEST['id']; ?>
')"><?php if ($this->_tpl_vars['data']['inscrito'] == 'f'): ?><div class="checkboxUnchecked"></div><p id="textoInscribirse">Apúntate a esta carrera</p><?php else: ?><div class="checkboxChecked"></div><p id="textoInscribirse">Estoy apuntado a esta carrera</p><?php endif; ?></a><?php else: ?><div class="checkbox"></div><p><a href="javascript: void showLoginWindow()">Haz login</a> para apuntarte a la carrera</p><?php endif; ?></div>
		
		<div class="span-1 ticketOrange"></div>
		
		<div class="span-1 functionalContainer">
			<p class="titulo tituloLeft tituloColumnRight">LOCALIZACIÓN</p>
			<div id="map" class="mapStyleRight">
	            <object id="aroundMap" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="254" height="192" wmode="opaque" flashvars="id=<?php echo $this->_tpl_vars['data']['id']; ?>
">
	              <param name="movie" value="/flash/RunAroundMap.swf?7" />
	              <!--[if !IE]>-->
	              <object type="application/x-shockwave-flash" data="/flash/RunAroundMap.swf?7" width="254" height="192" wmode="opaque" flashvars="id=<?php echo $this->_tpl_vars['data']['id']; ?>
">
	              <!--<![endif]-->
					    <?php if ($this->_tpl_vars['data']['start_point_lat'] === null): ?>
<img width="254" height="192" src="http://maps.google.com/maps/api/staticmap?size=254x192&maptype=map&zoom=10&center=<?php echo $this->_tpl_vars['data']['event_location']; ?>
,spain&sensor=false&key=ABQIAAAAtDJGVn6RztUmxjnX5hMzjRTy9E-TgLeuCHEEJunrcdV8Bjp5lBTu2Rw7F-koeV8TrxpLHZPXoYd2BA" />					    
					    <?php else: ?>
					<img src="http://maps.google.com/staticmap?size=254x192&maptype=map&zoom=10&markers=<?php if ($this->_tpl_vars['data']['end_point_lat']): ?><?php echo $this->_tpl_vars['data']['end_point_lat']; ?>
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
		
		<div class="span-1 functionalContainer">
		<?php if ($this->_tpl_vars['runsInSameDates']): ?>
		<p class="titulo tituloLeft tituloColumnRight">EN LAS MISMAS FECHAS</p>
		<div class="events">
			<?php $_from = $this->_tpl_vars['runsInSameDates']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }$this->_foreach['raceloop'] = array('total' => count($_from), 'iteration' => 0);
if ($this->_foreach['raceloop']['total'] > 0):
    foreach ($_from as $this->_tpl_vars['id'] => $this->_tpl_vars['race']):
        $this->_foreach['raceloop']['iteration']++;
?>	    				    
				<div class="span-1 <?php echo smarty_function_cycle(array('values' => "raceRight,raceRight2"), $this);?>
">
					<div class="span-1 first dateRight calendarRight">
				        <div class="month month<?php echo $this->_tpl_vars['race']['run_type']; ?>
"><?php echo smarty_function_getMonth(array('month' => ((is_array($_tmp=$this->_tpl_vars['race']['event_date'])) ? $this->_run_mod_handler('substr', true, $_tmp, 5, 2) : substr($_tmp, 5, 2))), $this);?>
</div>
						<div class="day"><?php echo ((is_array($_tmp=$this->_tpl_vars['race']['event_date'])) ? $this->_run_mod_handler('substr', true, $_tmp, 8, 2) : substr($_tmp, 8, 2)); ?>
</div>
					</div>
					<?php if ($this->_tpl_vars['race']['num_users'] > 0): ?>
						<div class="ticketBlue"><p><?php echo $this->_tpl_vars['race']['num_users']; ?>
</p></div>
						<div class="ticketBlueCorner ticketBlueCornerRight"></div>
					<?php endif; ?>		
					<div class="span-1 last dataRaceRight">
						<div class="nameRaceRight"><a id="nameRunRight1<?php echo $this->_foreach['raceloop']['iteration']; ?>
" href="/run/<?php echo $this->_tpl_vars['race']['id']; ?>
/<?php echo ((is_array($_tmp=$this->_tpl_vars['race']['name'])) ? $this->_run_mod_handler('replace', true, $_tmp, ' ', '/') : smarty_modifier_replace($_tmp, ' ', '/')); ?>
"><?php echo $this->_tpl_vars['race']['name']; ?>
</a></div>
						<div class="dataRaceRight"><p><?php echo $this->_tpl_vars['race']['event_location']; ?>
 | <?php echo $this->_tpl_vars['race']['distance_text']; ?>
</p></div>
					</div>	
				</div>
				<div class="span-1 last separatorRight"></div>
		    <?php endforeach; endif; unset($_from); ?>					
		</div>
		<?php endif; ?>
		</div>
		
		<div class="span-1 functionalContainer">
		<?php if ($this->_tpl_vars['runsInSameDates']): ?>
		<p class="titulo tituloLeft tituloColumnRight">DE DISTANCIA PARECIDA</p>
		<div class="events">
			<?php $_from = $this->_tpl_vars['similarTypeRaces']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }$this->_foreach['raceloop'] = array('total' => count($_from), 'iteration' => 0);
if ($this->_foreach['raceloop']['total'] > 0):
    foreach ($_from as $this->_tpl_vars['id'] => $this->_tpl_vars['race']):
        $this->_foreach['raceloop']['iteration']++;
?>	    				    
				<div class="span-1 <?php echo smarty_function_cycle(array('values' => "raceRight,raceRight2"), $this);?>
">
					<div class="span-1 first dateRight calendarRight">
				        <div class="month month<?php echo $this->_tpl_vars['race']['run_type']; ?>
"><?php echo smarty_function_getMonth(array('month' => ((is_array($_tmp=$this->_tpl_vars['race']['event_date'])) ? $this->_run_mod_handler('substr', true, $_tmp, 5, 2) : substr($_tmp, 5, 2))), $this);?>
</div>
						<div class="day"><?php echo ((is_array($_tmp=$this->_tpl_vars['race']['event_date'])) ? $this->_run_mod_handler('substr', true, $_tmp, 8, 2) : substr($_tmp, 8, 2)); ?>
</div>
					</div>
					<?php if ($this->_tpl_vars['race']['num_users'] > 0): ?>
						<div class="ticketBlue"><p><?php echo $this->_tpl_vars['race']['num_users']; ?>
</p></div>
						<div class="ticketBlueCorner ticketBlueCornerRight"></div>
					<?php endif; ?>		
					<div class="span-1 last dataRaceRight">
						<div class="nameRaceRight"><a id="nameRunRight2<?php echo $this->_foreach['raceloop']['iteration']; ?>
" href="/run/<?php echo $this->_tpl_vars['race']['id']; ?>
/<?php echo ((is_array($_tmp=$this->_tpl_vars['race']['name'])) ? $this->_run_mod_handler('replace', true, $_tmp, ' ', '/') : smarty_modifier_replace($_tmp, ' ', '/')); ?>
"><?php echo $this->_tpl_vars['race']['name']; ?>
</a></div>
						<div class="dataRaceRight"><p><?php echo $this->_tpl_vars['race']['event_location']; ?>
 | <?php echo $this->_tpl_vars['race']['distance_text']; ?>
</p></div>
					</div>	
				</div>
				<div class="span-1 last separatorRight"></div>
		    <?php endforeach; endif; unset($_from); ?>					
		</div>
		<?php endif; ?>
		</div>

				
		<div class="span-1 functionalContainer">		
		<?php if ($this->_tpl_vars['data']['num_users'] > 0): ?>
			<p class="titulo tituloLeft tituloColumnRight">USUARIOS APUNTADOS</p>
			<div class="eventsUsers">				
		<?php endif; ?>
		<?php $_from = $this->_tpl_vars['runners']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }if (count($_from)):
    foreach ($_from as $this->_tpl_vars['id'] => $this->_tpl_vars['person']):
?>
				<?php if ($this->_tpl_vars['person'] == 'f'): ?>
					<!--
<div class="span-8 races2">
						<p class="noApuntado">Aun no hay ningún valiente</p>
						<p class="noRaceSub">¿Quieres ser el primero? <b><a href="/rss">Apúntate</a></b></p>
					</div> 
-->
				<?php else: ?>							
					<div class="avatarContainer">
						<a href="/user/<?php echo $this->_tpl_vars['person']['username']; ?>
"><img title="<?php echo $this->_tpl_vars['person']['username']; ?>
" class="avatarRight" src="/avatar.php?id=<?php echo $this->_tpl_vars['person']['user_id']; ?>
"/></a>	
					</div>
    			<?php endif; ?>
    		    <?php endforeach; else: ?>
    		       <!--
 <div class="span-8 races2">
						<p class="noApuntado">Aun no hay ningún valiente</p>
						<p class="noRaceSub">¿Quieres ser el primero? <b><a href="/rss.php">Apúntate</a></b></p>
					</div>  
-->   
    		    <?php endif; unset($_from); ?>
			</div>
		</div>
		</div>
	</div>

</div> <!-- content -->

</div> <!-- container -->

<?php $_smarty_tpl_vars = $this->_tpl_vars;
$this->_smarty_include(array('smarty_include_tpl_file' => "footer.tpl", 'smarty_include_vars' => array()));
$this->_tpl_vars = $_smarty_tpl_vars;
unset($_smarty_tpl_vars);
 ?> 
<?php /* Smarty version 2.6.26, created on 2009-10-13 15:04:10
         compiled from home.tpl */ ?>
<?php require_once(SMARTY_CORE_DIR . 'core.load_plugins.php');
smarty_core_load_plugins(array('plugins' => array(array('function', 'cycle', 'home.tpl', 34, false),array('function', 'getMonth', 'home.tpl', 47, false),array('modifier', 'replace', 'home.tpl', 45, false),array('modifier', 'substr', 'home.tpl', 47, false),)), $this); ?>
<?php $_smarty_tpl_vars = $this->_tpl_vars;
$this->_smarty_include(array('smarty_include_tpl_file' => "header.tpl", 'smarty_include_vars' => array()));
$this->_tpl_vars = $_smarty_tpl_vars;
unset($_smarty_tpl_vars);
 ?>

<div class="span-24">
<div class="span-1 column mapTop"></div>
<div class="span-1 column map">
	<div id="runnityHomeMap">
	<object id="flashMovie" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="894" height="364" wmode="opaque">
		<param name="movie" value="/flash/runnitHomeMap.swf?6" />
		<!--[if !IE]>-->
		<object type="application/x-shockwave-flash" data="/flash/runnitHomeMap.swf?6" width="894" height="364" wmode="opaque">
		<!--<![endif]-->
		<h1>Necesitas Flash para poder ver el mapa</h1>
		<p><a href="http://www.adobe.com/go/getflashplayer"><img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" /></a></p>
		<!--[if !IE]>-->
		</object>
		<!--<![endif]-->
    </object>
</div>
</div>
<div class="span-1 column mapBottom"></div>
</div>

<div class="span-24 column content">

	<!-- LEFT COLUMN -->
	<div class="span-1 last leftColumnHome">
	
		<div class="span-1 last column1">
		<p class="titulo">PRÓXIMAS CARRERAS CERCA DE TI</p>
			<?php $_from = $this->_tpl_vars['nextRaces']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }$this->_foreach['raceloop'] = array('total' => count($_from), 'iteration' => 0);
if ($this->_foreach['raceloop']['total'] > 0):
    foreach ($_from as $this->_tpl_vars['id'] => $this->_tpl_vars['race']):
        $this->_foreach['raceloop']['iteration']++;
?>
				<?php if ($this->_tpl_vars['race'] == 'false'): ?>
				<!-- 	<div class="carrera">No hay próximas carreras.</div>  -->
				<?php else: ?>
					<div class="span-1 <?php echo smarty_function_cycle(array('values' => "carrera,carrera2"), $this);?>
">
						<div class="span-1 avatar2">
							<!-- <img src="/img/avatar2.jpg" class="avatar"> -->
							<?php if ($this->_tpl_vars['race']['flickr_img_id'] == ""): ?>
							    <img src="/media/run/<?php echo $this->_tpl_vars['race']['thumbnail']; ?>
" alt="Foto de la carrera <?php echo $this->_tpl_vars['race']['name']; ?>
" class="avatar"/>	
							<?php else: ?>
							    <img src="/runThumbImage.php?id=<?php echo $this->_tpl_vars['race']['id']; ?>
&photo_id=<?php echo $this->_tpl_vars['race']['flickr_img_id']; ?>
" alt="Foto de la carrera <?php echo $this->_tpl_vars['race']['name']; ?>
" class="avatar"/>	
							<?php endif; ?>
						</div>
						<div class="span-1 Race">
							<p class="span-4 nameRace"><a id="carrera<?php echo $this->_foreach['raceloop']['iteration']; ?>
" 
							href="/run/<?php echo $this->_tpl_vars['race']['id']; ?>
/<?php echo ((is_array($_tmp=$this->_tpl_vars['race']['name'])) ? $this->_run_mod_handler('replace', true, $_tmp, ' ', '/') : smarty_modifier_replace($_tmp, ' ', '/')); ?>
"><?php echo $this->_tpl_vars['race']['name']; ?>
</a></p>
							<p class="span-4 infoRace" id="iteracion<?php echo $this->_foreach['raceloop']['iteration']; ?>
">
							<b><?php echo ((is_array($_tmp=$this->_tpl_vars['race']['event_date'])) ? $this->_run_mod_handler('substr', true, $_tmp, 8, 2) : substr($_tmp, 8, 2)); ?>
/<?php echo smarty_function_getMonth(array('month' => ((is_array($_tmp=$this->_tpl_vars['race']['event_date'])) ? $this->_run_mod_handler('substr', true, $_tmp, 5, 2) : substr($_tmp, 5, 2))), $this);?>
/<?php echo ((is_array($_tmp=$this->_tpl_vars['race']['event_date'])) ? $this->_run_mod_handler('substr', true, $_tmp, 2, 2) : substr($_tmp, 2, 2)); ?>
</b> / 													<?php echo $this->_tpl_vars['race']['distance_text']; ?>
</p>
							<p class="span-4 placeRace"><?php echo $this->_tpl_vars['race']['province_name']; ?>
 - <?php echo $this->_tpl_vars['race']['event_location']; ?>
</p>
						</div>
						<?php if ($this->_tpl_vars['race']['num_users'] > 0): ?>
							<div class="ticketBlue"><p><?php echo $this->_tpl_vars['race']['num_users']; ?>
</p></div>
							<div class="ticketBlueCorner"></div>
						<?php endif; ?>
					</div>
					<?php if ($this->_foreach['raceloop']['iteration'] < 3): ?>
						<div class="span-1 last separator"></div>
					<?php endif; ?>
				<?php endif; ?>
			<?php endforeach; else: ?>
			<!-- 	<div class="carrera">No hay próximas carreras.</div>  -->
    		<?php endif; unset($_from); ?>	
			<a class="verTodas" <?php if ($this->_tpl_vars['city'] == "España"): ?> href="/buscar?q=" <?php else: ?> href="/buscar?q=<?php echo $this->_tpl_vars['city']; ?>
" <?php endif; ?>><b>Ver todas las carreras en <?php echo $this->_tpl_vars['city']; ?>
</b></a>
		</div>
		
		<div class="span-1 last column2">
			<p class="titulo">ACTIVIDAD RECIENTE</p>
			<?php $_from = $this->_tpl_vars['activity']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }$this->_foreach['raceloop'] = array('total' => count($_from), 'iteration' => 0);
if ($this->_foreach['raceloop']['total'] > 0):
    foreach ($_from as $this->_tpl_vars['id'] => $this->_tpl_vars['race']):
        $this->_foreach['raceloop']['iteration']++;
?>
			<div class="carrera">
				<div class="span-1 avatar2">
					<!-- <img src="/img/avatar2.jpg" class="avatar"> -->
					<?php if ($this->_tpl_vars['race']['flickr_img_id'] == ""): ?>
					    <img src="/media/run/<?php echo $this->_tpl_vars['race']['thumbnail']; ?>
" alt="Foto de la carrera <?php echo $this->_tpl_vars['race']['name']; ?>
" class="avatar"/>	
					<?php else: ?>
					    <img src="/runThumbImage.php?id=<?php echo $this->_tpl_vars['race']['id']; ?>
&photo_id=<?php echo $this->_tpl_vars['race']['flickr_img_id']; ?>
" alt="Foto de la carrera <?php echo $this->_tpl_vars['race']['name']; ?>
" class="avatar"/>	
					<?php endif; ?>
				</div>
				<div class="span-1 Race">
					<p class="span-4 nameRace"><a <a id="carrera<?php echo $this->_foreach['raceloop']['iteration']; ?>
" 
							href="/run/<?php echo $this->_tpl_vars['race']['run1_id']; ?>
/<?php echo ((is_array($_tmp=$this->_tpl_vars['race']['run1_name'])) ? $this->_run_mod_handler('replace', true, $_tmp, ' ', '/') : smarty_modifier_replace($_tmp, ' ', '/')); ?>
"><?php echo $this->_tpl_vars['race']['run1_name']; ?>
</a></p>
					<p class="span-4 recentActivity"><img src="/img/note.gif"/><?php echo $this->_tpl_vars['race']['run1_description']; ?>
</p>
				</div>
				<?php if ($this->_tpl_vars['race']['run1_num_users'] > 0): ?>
					<div class="ticketBlue"><p><?php echo $this->_tpl_vars['race']['run1_num_users']; ?>
</p></div>
					<div class="ticketBlueCorner"></div>
				<?php endif; ?>
			</div>
			<div class="separator"></div>
			<div class="carrera2">
				<div class="span-1 avatar2">
					<!-- <img src="/img/avatar2.jpg" class="avatar"> -->
					<?php if ($this->_tpl_vars['race']['flickr_img_id'] == ""): ?>
					    <img src="/media/run/<?php echo $this->_tpl_vars['race']['thumbnail']; ?>
" alt="Foto de la carrera <?php echo $this->_tpl_vars['race']['name']; ?>
" class="avatar"/>	
					<?php else: ?>
					    <img src="/runThumbImage.php?id=<?php echo $this->_tpl_vars['race']['id']; ?>
&photo_id=<?php echo $this->_tpl_vars['race']['flickr_img_id']; ?>
" alt="Foto de la carrera <?php echo $this->_tpl_vars['race']['name']; ?>
" class="avatar"/>	
					<?php endif; ?>
				</div>
				<div class="span-1 Race">
					<p class="span-4 nameRace"><a <a id="carrera<?php echo $this->_foreach['raceloop']['iteration']; ?>
" 
							href="/run/<?php echo $this->_tpl_vars['race']['run2_id']; ?>
/<?php echo ((is_array($_tmp=$this->_tpl_vars['race']['run2_name'])) ? $this->_run_mod_handler('replace', true, $_tmp, ' ', '/') : smarty_modifier_replace($_tmp, ' ', '/')); ?>
"><?php echo $this->_tpl_vars['race']['run2_name']; ?>
</a></p>
					<p class="span-4 recentActivity"><img src="/img/note.gif"/><?php echo $this->_tpl_vars['race']['run2_description']; ?>
</p>
				</div>
				<?php if ($this->_tpl_vars['race']['run2_num_users'] > 0): ?>
					<div class="ticketBlue"><p><?php echo $this->_tpl_vars['race']['run2_num_users']; ?>
</p></div>
					<div class="ticketBlueCorner"></div>
				<?php endif; ?>
			</div>
			<div class="separator"></div>
			<div class="carrera">
				<div class="span-1 avatar2">
					<!-- <img src="/img/avatar2.jpg" class="avatar"> -->
					<?php if ($this->_tpl_vars['race']['flickr_img_id'] == ""): ?>
					    <img src="/media/run/<?php echo $this->_tpl_vars['race']['thumbnail']; ?>
" alt="Foto de la carrera <?php echo $this->_tpl_vars['race']['name']; ?>
" class="avatar"/>	
					<?php else: ?>
					    <img src="/runThumbImage.php?id=<?php echo $this->_tpl_vars['race']['id']; ?>
&photo_id=<?php echo $this->_tpl_vars['race']['flickr_img_id']; ?>
" alt="Foto de la carrera <?php echo $this->_tpl_vars['race']['name']; ?>
" class="avatar"/>	
					<?php endif; ?>
				</div>
				<div class="span-1 Race">
					<p class="span-4 nameRace"><a <a id="carrera<?php echo $this->_foreach['raceloop']['iteration']; ?>
" 
							href="/run/<?php echo $this->_tpl_vars['race']['run3_id']; ?>
/<?php echo ((is_array($_tmp=$this->_tpl_vars['race']['run3_name'])) ? $this->_run_mod_handler('replace', true, $_tmp, ' ', '/') : smarty_modifier_replace($_tmp, ' ', '/')); ?>
"><?php echo $this->_tpl_vars['race']['run3_name']; ?>
</a></p>
					<p class="span-4 recentActivity"><img src="/img/note.gif"/><?php echo $this->_tpl_vars['race']['run3_description']; ?>
</p>
				</div>
				<?php if ($this->_tpl_vars['race']['run3_num_users'] > 0): ?>
					<div class="ticketBlue"><p><?php echo $this->_tpl_vars['race']['run3_num_users']; ?>
</p></div>
					<div class="ticketBlueCorner"></div>
				<?php endif; ?>
			</div>
    		<?php endforeach; endif; unset($_from); ?>	
		</div>
	</div>
	
	<!-- RIGHT COLUMN -->
	<div class="span-1 last rightColumnHome">
<!-- 	<div class="carrera">No hay próximas carreras destacadas.</div>  -->
		<p class="titulo titulOrange">CARRERAS DESTACADAS</p>
					<div class="span-1 imgFeed">
				<a href="http://feeds.feedburner.com/runnity"><img src="/img/feed-icon.gif" alt="Feed" class="rssImage"/></a>
			</div>
		<?php $_from = $this->_tpl_vars['nextImportantRaces']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }$this->_foreach['raceloop'] = array('total' => count($_from), 'iteration' => 0);
if ($this->_foreach['raceloop']['total'] > 0):
    foreach ($_from as $this->_tpl_vars['id'] => $this->_tpl_vars['VipRace']):
        $this->_foreach['raceloop']['iteration']++;
?>
		<div class="carreraOrange">
			<div class="span-1 avatar2Orange">
				<!-- <img src="/img/avatar2.jpg" class="avatarOrange"> -->
				<?php if ($this->_tpl_vars['race']['flickr_img_id'] == ""): ?>
				    <img src="/media/run/<?php echo $this->_tpl_vars['VipRace']['thumbnail']; ?>
" alt="Foto de la carrera <?php echo $this->_tpl_vars['VipRace']['name']; ?>
" class="avatar"/>	
				<?php else: ?>
				    <img src="/runThumbImage.php?id=<?php echo $this->_tpl_vars['VipRace']['id']; ?>
&photo_id=<?php echo $this->_tpl_vars['VipRace']['flickr_img_id']; ?>
" alt="Foto de la carrera <?php echo $this->_tpl_vars['VipRace']['name']; ?>
" class="avatar"/>	
				<?php endif; ?>
			</div>
			<div class="span-1 Race">
				<p class="nameRaceOrange"><a id="carrera<?php echo $this->_foreach['raceloop']['iteration']; ?>
" 
							href="/run/<?php echo $this->_tpl_vars['VipRace']['id']; ?>
/<?php echo ((is_array($_tmp=$this->_tpl_vars['VipRace']['name'])) ? $this->_run_mod_handler('replace', true, $_tmp, ' ', '/') : smarty_modifier_replace($_tmp, ' ', '/')); ?>
"><?php echo $this->_tpl_vars['VipRace']['name']; ?>
</a></p>
				<p class="span-4 infoRaceOrange" id="iteracion<?php echo $this->_foreach['raceloop']['iteration']; ?>
"><b><?php echo ((is_array($_tmp=$this->_tpl_vars['VipRace']['event_date'])) ? $this->_run_mod_handler('substr', true, $_tmp, 8, 2) : substr($_tmp, 8, 2)); ?>
/<?php echo smarty_function_getMonth(array('month' => ((is_array($_tmp=$this->_tpl_vars['VipRace']['event_date'])) ? $this->_run_mod_handler('substr', true, $_tmp, 5, 2) : substr($_tmp, 5, 2))), $this);?>
/<?php echo ((is_array($_tmp=$this->_tpl_vars['VipRace']['event_date'])) ? $this->_run_mod_handler('substr', true, $_tmp, 2, 2) : substr($_tmp, 2, 2)); ?>
</b> / <?php echo $this->_tpl_vars['VipRace']['distance_text']; ?>
</p>
				<p class="span-4 placeRaceOrange"><?php echo $this->_tpl_vars['VipRace']['event_location']; ?>
</p>
			</div>
		<?php if ($this->_foreach['raceloop']['iteration'] < 3): ?>
			<div class="span-1 last separatorRightOrange"></div>
		<?php endif; ?>
		</div>
		<?php endforeach; else: ?>
<!-- 	<div class="carrera">No hay próximas carreras destacadas.</div>  -->
    	<?php endif; unset($_from); ?>
	</div>
	
</div> <!-- content -->

</div> <!-- container -->

<div class="bannerTop"></div>
<div class="banner">
	<div class="titular">
		<div class="span-1 titularColumn">
			<p class="titularTitle titularTitleFirst">ENTÉRATE Y PLANEA</p>
			<p class="titularInfo">Obtén la mejor información de los eventos que están por venir; Recorridos, mapas, altimetrías, fotos, comentarios, ediciones pasadas...</p>	
			<br>
			<a href="/run/234/Carrera/Popular/La/Melonera">Mira una carrera de ejemplo</a>
		</div>
		<div class="span-1 titularColumn titularColumn2">
			<p class="titularTitle">DISFRUTA LA CARRERA</p>
			<p class="titularInfo titularInfo2">Esperamos que con nuestra ayuda no te falte nada para que la carrera salga como esperas.</p>
			<p class="titularInfo titularInfo2">Disfrútala al máximo y cuéntanos qué tal.</p>
		</div>
		<div class="span-1 titularColumn titularColumn2">
			<p class="titularTitle">VUELVE Y COMÉNTALO</p>
			<p class="titularInfo titularInfo2">¡Sube tus fotos, tus tiempos, clasificaciones y haz de Runnity un sitio cada vez mejor y más completo!</p>
			<br><br>
			<a href="/registro">Regístrate y participa</a>
		</div>
	</div>
</div>

<div class="container">
	<div class="span-1 column ColumnHome">
		<div class="span-1 last columnLong">
			<p class="titulo">RUNNITY EN LA WEB</p>
			<div class="column span-3 first">
				<a href="http://www.tuenti.com/#m=Photo&func=view_photo&collection_key=1-66022443-567658561-66022443" target="_blank">
					<img src="/img/tuenti.jpg" alt="socialNetworks"/>
				</a>
			</div>
			<div class="column span-3">
				<a href="http://www.facebook.com/home.php?#/group.php?gid=158141673184&ref=ts" target="_blank">
					<img src="/img/facebook.jpg" alt="socialNetworks"/>
				</a>
			</div>
			<div class="column span-4 last">
				<a href="http://twitter.com/runnity" target="_blank">
					<img src="/img/twitter.jpg" alt="socialNetworks"/>
				</a>
			</div>
			<div class="column span-3 last">
				<a href="http://www.flickr.com/groups/1188628@N20/" target="_blank">
					<img src="/img/flickr.jpg" alt="socialNetworks"/>
				</a>
			</div>
		</div>
		<div class="span-1 last columnSort">
			<p class="titulo tituloRight">RUNNITY EN TWITTER</p>
				<div class="span-3 tweet last">
				<a id="tweets" href="http://twitter.com/runnity" target="_blank"></a>
				<p id="tweetsTime"></p>
				</div>
		</div>
	</div>

</div>
	
	<!-- SCRIPT TWITTER -->
	
	<?php echo '
	<script language="javaScript" type="text/javascript">
		$(document).ready( function() {
		
			var url = "http://twitter.com/status/user_timeline/runnity.json?count=1&callback=?";
			$.getJSON(url,function(data){	
				$.each(data, function(i, item) {
					$("#tweets").append( item.text.linkify());
					$("#tweetsTime").append(relative_time(item.created_at));
				});
		    });
		    
			$(".nameRace").truncate( 55 );
			$(".nameRaceOrange").truncate( 55 );			
			$(".placeRace").truncate( 30 );			
		    
		});
	</script>
	'; ?>

	
	
	<?php echo '
	<script language="javaScript" type="text/javascript">
		String.prototype.linkify = function() {
			return this.replace(/[A-Za-z]+:\\/\\/[A-Za-z0-9-_]+\\.[A-Za-z0-9-_:%&\\?\\/.=]+/, function(m) {
				return m.link(m);
			});
		}; 
	</script>
	'; ?>

	
	
	
	<?php echo '
	<script language="javaScript" type="text/javascript">
		function twitter_callback (){
			return true;
		}
	</script>
	'; ?>


<?php $_smarty_tpl_vars = $this->_tpl_vars;
$this->_smarty_include(array('smarty_include_tpl_file' => "footer.tpl", 'smarty_include_vars' => array()));
$this->_tpl_vars = $_smarty_tpl_vars;
unset($_smarty_tpl_vars);
 ?> 
<?php /* Smarty version 2.6.26, created on 2009-09-17 17:22:40
         compiled from home.tpl */ ?>
<?php require_once(SMARTY_CORE_DIR . 'core.load_plugins.php');
smarty_core_load_plugins(array('plugins' => array(array('function', 'cycle', 'home.tpl', 20, false),array('function', 'getMonth', 'home.tpl', 26, false),array('modifier', 'replace', 'home.tpl', 24, false),array('modifier', 'substr', 'home.tpl', 26, false),)), $this); ?>
<?php $_smarty_tpl_vars = $this->_tpl_vars;
$this->_smarty_include(array('smarty_include_tpl_file' => "header.tpl", 'smarty_include_vars' => array()));
$this->_tpl_vars = $_smarty_tpl_vars;
unset($_smarty_tpl_vars);
 ?>

<div class="span-24">
<div class="span-1 column mapTop"></div>
<div class="span-1 column map"></div>
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
						<div class="carrera">No hay proximas carreras.</div> 
					<?php else: ?>
						<div class="<?php echo smarty_function_cycle(array('values' => "carrera,carrera2"), $this);?>
">
							<div class="span-1 avatar2"><img src="/img/avatar2.jpg" class="avatar"></div>
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
/
								<?php echo ((is_array($_tmp=$this->_tpl_vars['race']['event_date'])) ? $this->_run_mod_handler('substr', true, $_tmp, 2, 2) : substr($_tmp, 2, 2)); ?>
</b> / <?php echo $this->_tpl_vars['race']['distance_text']; ?>
</p>
								<p class="span-4 placeRace"><?php echo $this->_tpl_vars['race']['province_name']; ?>
 - <?php echo $this->_tpl_vars['race']['event_location']; ?>
</p>
							</div>
							<div class="ticketBlue"><p><?php echo $this->_tpl_vars['race']['num_users']; ?>
</p></div>
						</div>
						<div class="separator"></div>
					<?php endif; ?>
				<?php endforeach; else: ?>
					<div class="carrera">No hay proximas carreras.</div> 
	    		<?php endif; unset($_from); ?>	
			<a class="verTodas" href="#"><b>Ver todas las carreras en Madrid</b></a>
		</div>
		
		<div class="span-1 last column2">
			<p class="titulo">ACTIVIDAD RECIENTE</p>
			<div class="carrera">
				<div class="span-1 avatar2"><img src="/img/avatar2.jpg" class="avatar"></div>
				<div class="span-1 Race">
					<p class="span-4 nameRace"><a href="#">XVIII Carrera popular “La Melonera”</a></p>
					<p class="span-4 infoRace"><b>21/Agosto</b> / 5km - 10km</p>
					<p class="span-4 placeRace">Móstoles</p>
				</div>
				<div class="ticketBlue"><p>3</p></div>
			</div>
			<div class="separator"></div>
			<div class="carrera2">
				<div class="span-1 avatar2"><img src="/img/avatar2.jpg" class="avatar"></div>
				<div class="span-1 Race">
					<p class="span-4 nameRace"><a href="#">XVIII Carrera popular “La Melonera”</a></p>
					<p class="span-4 infoRace"><b>21/Agosto</b> / 5km - 10km</p>
					<p class="span-4 placeRace">Móstoles</p>
				</div>
				<div class="ticketBlue"><p>3</p></div>
			</div>
			<div class="separator"></div>
			<div class="carrera">
				<div class="span-1 avatar2"><img src="/img/avatar2.jpg" class="avatar"></div>
				<div class="span-1 Race">
					<p class="span-4 nameRace"><a href="#">XVIII Carrera popular “La Melonera”</a></p>
					<p class="span-4 infoRace"><b>21/Agosto</b> / 5km - 10km</p>
					<p class="span-4 placeRace">Móstoles</p>
				</div>
				<div class="ticketBlue"><p>3</p></div>
			</div>
		</div>
	</div>
	
	<!-- RIGHT COLUMN -->
	<div class="span-1 last rightColumnHome">
		<p class="titulo titulOrange">CARRERAS DESTACADAS</p>
		<div class="carreraOrange">
			<div class="span-1 avatar2Orange"><img src="/img/avatar2.jpg" class="avatarOrange"></div>
			<div class="span-1 Race">
				<p class="nameRaceOrange"><a href="#">XVIII Carrera popular “La Melonera”</a></p>
<!--
				<p class="span-4 infoRaceOrange"><b>21/Agosto</b> / 5km - 10km</p>
				<p class="span-4 placeRaceOrange">Móstoles</p>
-->
			</div>
		</div>
	</div>
	
</div> <!-- content -->

</div> <!-- container -->

<div class="bannerTop"></div>
<div class="banner">
	<div class="titular"></div>
</div>

<?php $_smarty_tpl_vars = $this->_tpl_vars;
$this->_smarty_include(array('smarty_include_tpl_file' => "footer.tpl", 'smarty_include_vars' => array()));
$this->_tpl_vars = $_smarty_tpl_vars;
unset($_smarty_tpl_vars);
 ?> 
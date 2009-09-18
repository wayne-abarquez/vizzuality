<?php /* Smarty version 2.6.26, created on 2009-09-10 18:44:54
         compiled from 404.tpl */ ?>
<?php require_once(SMARTY_CORE_DIR . 'core.load_plugins.php');
smarty_core_load_plugins(array('plugins' => array(array('function', 'getMonth', '404.tpl', 41, false),array('modifier', 'substr', '404.tpl', 41, false),array('modifier', 'replace', '404.tpl', 45, false),)), $this); ?>
<?php $_smarty_tpl_vars = $this->_tpl_vars;
$this->_smarty_include(array('smarty_include_tpl_file' => "header.tpl", 'smarty_include_vars' => array()));
$this->_tpl_vars = $_smarty_tpl_vars;
unset($_smarty_tpl_vars);
 ?> 
<!-- GLOBAL CONTAINER RACE -->
	<div class="span-24 raceContainer" id="race">
	
		<!-- RACE & IMAGE -->
		<div class="span-16 first leftColumn">
			<div class="span-16 column">
				<div class="span-16 navigationList">
					<ul> 
						<li><a href="#" class="selected">Página no encontrada</b></a></li>
					</ul>
				</div>
			</div>
			
			<div class="raceContent1">
				<h2 class="newsTitle3">Página no encontrada</h2>
				<div class="errorbox span-5 first"><img src="/img/errorbox.jpg"></div>
				<div class="span-10 errorboxContainer last">
					<p class="errorboxTitle">uh oh, algo no ha ido bien...</p>
					<p class="errorboxInfo">La página que estas buscando parece no existir. Te animamos a que eches un vistazo al listado de <b><a href="/buscar">carreras</a></b> a ver si encuentras lo que estas buscando.</p>
					<p class="errorboxInfo2">Si no lo encuentras,puedes <b><a href="/rss">subscribirte a nuestro RSS</a></b> para estar al tanto de las nuevas carreras</p>
				</div>	
			</div>					
		</div>
		
		
		<!-- RIGHT COLUMN -->
		<div class="column span-8 last rightColumn">

			<div class="span-8 importantRaces">
				<div class="events"> 
					<h2 class="newsTitle4">Próximas carreras</h2>
				</div>	
				<div class="events">
            		<?php $_from = $this->_tpl_vars['nextRaces']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }if (count($_from)):
    foreach ($_from as $this->_tpl_vars['id'] => $this->_tpl_vars['race']):
?>
            			<?php if ($this->_tpl_vars['race'] == 'f'): ?>
            				<div class="span-8 races">No hay proximas carreras.</div> 
            			<?php else: ?>		    				    
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
 van</b></div>
        						</div>
        					</div>
            			<?php endif; ?>
            	    <?php endforeach; else: ?>
            	        <div class="span-8 races">No hay proximas carreras.</div> 
            	    <?php endif; unset($_from); ?>					
				</div>				
			</div>		
		</div>
	</div>
</div>
</div>
<?php $_smarty_tpl_vars = $this->_tpl_vars;
$this->_smarty_include(array('smarty_include_tpl_file' => "footer.tpl", 'smarty_include_vars' => array()));
$this->_tpl_vars = $_smarty_tpl_vars;
unset($_smarty_tpl_vars);
 ?> 
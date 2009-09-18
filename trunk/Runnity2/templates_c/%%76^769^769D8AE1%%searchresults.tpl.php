<?php /* Smarty version 2.6.26, created on 2009-09-17 16:48:41
         compiled from searchresults.tpl */ ?>
<?php require_once(SMARTY_CORE_DIR . 'core.load_plugins.php');
smarty_core_load_plugins(array('plugins' => array(array('function', 'math', 'searchresults.tpl', 45, false),array('function', 'getMonth', 'searchresults.tpl', 69, false),array('modifier', 'substr', 'searchresults.tpl', 69, false),array('modifier', 'replace', 'searchresults.tpl', 74, false),)), $this); ?>
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
						<li><a href="/">Inicio ></a></li>
						<li><a href="#" class="selected"><?php echo $this->_tpl_vars['titulo_breadcrumb']; ?>
 <b><?php echo $_REQUEST['q']; ?>
</b></a></li>
					</ul>
				</div>
			</div>
			
			<div class="raceContent1">
				<h2 class="newsTitle3">Resultados de tu búsqueda (<?php echo $this->_tpl_vars['count']; ?>
)</h2>
				<div class="raceSearchFirst">
					<div class="searchPanel">
						<div class="labels">
							<div class="searchlabel">Localidad, nombre, etc...</div>
							<div class="searchlabel searchlabel2">Distancia mín / max (metros)</div>
						</div>
						<div class="formSearch">
						<form id="searchForm" method="GET" action="/buscar">
							<div class="inputSearch">
			<label class="roundsearch" for="inputsearch1"><span><input type="text" name="q" id="inputsearch1" value="<?php echo $_REQUEST['q']; ?>
"></span></label>
							</div>
							<div class="inputSearch">
			<label class="roundsearch" for="inputsearch2"><span><input type="text" name="distancia_min" id="inputsearch2" value="<?php echo $_REQUEST['distancia_min']; ?>
"></span></label>
							</div>
							<div class="inputSearch">
			<label class="roundsearch" for="inputsearch3"><span><input type="text" name="distancia_max" id="inputsearch3" value="<?php echo $_REQUEST['distancia_max']; ?>
"></span></label>
							</div>
							<div class="buttonSearch"><input class="fg-button BuscarCarrera" type="submit" value="Buscar"/></div>
						</form>
						</div>
					</div>
					<div class="pagination">
						<?php if ($this->_tpl_vars['count'] > 20): ?>
 							<div class="numberResults">
 								<p>viendo del <b><?php echo smarty_function_math(array('equation' => "x+1",'x' => $this->_tpl_vars['offset']), $this);?>
 al <?php echo smarty_function_math(array('equation' => "min(x2 +20,c)",'x2' => $this->_tpl_vars['offset'],'c' => $this->_tpl_vars['count']), $this);?>
</b> de <?php echo $this->_tpl_vars['count']; ?>
</p>                    							</div>
 								<?php if ($this->_tpl_vars['offset'] > 0): ?>
				<div class="searchAdelante"><a href="?offset=<?php echo smarty_function_math(array('equation' => "max(x-20,0)",'x' => $this->_tpl_vars['offset']), $this);?>
"><input class="fg-button" type="button" value="<"/></a></div>
								<?php endif; ?>
								<?php if ($this->_tpl_vars['offset'] < $this->_tpl_vars['count']-20): ?>
									<div class="searchAtras"><a href="?offset=<?php echo $this->_tpl_vars['offset']+20; ?>
&q=<?php echo $_REQUEST['q']; ?>
&distancia_min=<?php echo $_REQUEST['distancia_max']; ?>
&distancia_max=<?php echo $_REQUEST['distancia_max']; ?>
"><input class="fg-button" type="button" value=">"/></a></div>
                    			<?php endif; ?>
                    	<?php endif; ?>
					</div>
				</div>

				<div class="searchResultsBox">			
	        		<?php $_from = $this->_tpl_vars['results']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }if (count($_from)):
    foreach ($_from as $this->_tpl_vars['id'] => $this->_tpl_vars['race']):
?>
	        			<?php if ($this->_tpl_vars['race'] == '0'): ?>
	        				<div class="column span-15 noResultsContainer">
	        					<div class="carita"></div>
	        					<div class="noResultsText">
	        					<p class="noResults"><b>Lo sentimos, no hay resultados</b> que coincidan con tu búsqueda</p>
	        					<p class="noResultsSub">Pero si quieres puedes <a href="/rss.php">subscribirte a nuestro RSS</a> para estar al tanto de las nuevas carreras</p>
								</div>
	        				</div> 
	        			<?php else: ?>
	        				<div class=" span-15 column first raceDetailsSearch">
	    						<div class="column span-1 first date">
	    							<div class="month month<?php echo $this->_tpl_vars['race']['run_type']; ?>
"><?php echo smarty_function_getMonth(array('month' => ((is_array($_tmp=$this->_tpl_vars['race']['event_date'])) ? $this->_run_mod_handler('substr', true, $_tmp, 5, 2) : substr($_tmp, 5, 2))), $this);?>
</div>
	    							<div class="day"><?php echo ((is_array($_tmp=$this->_tpl_vars['race']['event_date'])) ? $this->_run_mod_handler('substr', true, $_tmp, 8, 2) : substr($_tmp, 8, 2)); ?>
</div>
	    						</div>
	    						
	    						<div class="column span-13 last calendarRaces">
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
	        			<?php endif; ?>
	        	    <?php endforeach; else: ?>
	        	        <div class="column span-15 noResultsContainer">
	        					<div class="carita"></div>
	        					<div class="noResultsText">
	        					<p class="noResults"><b>Lo sentimos, no hay resultados</b> que coincidan con tu búsqueda</p>
	        					<p class="noResultsSub">Pero si quieres puedes <a href="/rss.php">subscribirte a nuestro RSS</a> para estar al tanto de las nuevas carreras</p>
								</div>
	        				</div> 
	        	    <?php endif; unset($_from); ?>
        	    </div>
				<div class="raceSearchLast">
					<div class="paginationLast">
						<?php if ($this->_tpl_vars['count'] > 20): ?>
 							<div class="numberResults">
 								<p>viendo del <b><?php echo smarty_function_math(array('equation' => "x+1",'x' => $this->_tpl_vars['offset']), $this);?>
 al <?php echo smarty_function_math(array('equation' => "min(x2 +20,c)",'x2' => $this->_tpl_vars['offset'],'c' => $this->_tpl_vars['count']), $this);?>
</b> de <?php echo $this->_tpl_vars['count']; ?>
</p>                    							</div>
 								<?php if ($this->_tpl_vars['offset'] > 0): ?>
				<div class="searchAdelante"><a href="?offset=<?php echo smarty_function_math(array('equation' => "max(x-20,0)",'x' => $this->_tpl_vars['offset']), $this);?>
"><input class="fg-button" type="button" value="<"/></a></div>
								<?php endif; ?>
								<?php if ($this->_tpl_vars['offset'] < $this->_tpl_vars['count']-20): ?>
									<div class="searchAtras"><a href="?offset=<?php echo $this->_tpl_vars['offset']+20; ?>
&q=<?php echo $_REQUEST['q']; ?>
&distancia_min=<?php echo $_REQUEST['distancia_max']; ?>
&distancia_max=<?php echo $_REQUEST['distancia_max']; ?>
"><input class="fg-button" type="button" value=">"/></a></div>
                    			<?php endif; ?>
                    	<?php endif; ?>
					</div>
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

<?php $_smarty_tpl_vars = $this->_tpl_vars;
$this->_smarty_include(array('smarty_include_tpl_file' => "footer.tpl", 'smarty_include_vars' => array()));
$this->_tpl_vars = $_smarty_tpl_vars;
unset($_smarty_tpl_vars);
 ?> 
<?php /* Smarty version 2.6.26, created on 2009-09-28 19:13:14
         compiled from searchresults.tpl */ ?>
<?php require_once(SMARTY_CORE_DIR . 'core.load_plugins.php');
smarty_core_load_plugins(array('plugins' => array(array('function', 'math', 'searchresults.tpl', 108, false),array('function', 'cycle', 'searchresults.tpl', 135, false),array('function', 'getMonth', 'searchresults.tpl', 138, false),array('modifier', 'substr', 'searchresults.tpl', 138, false),array('modifier', 'replace', 'searchresults.tpl', 147, false),)), $this); ?>
<?php $_smarty_tpl_vars = $this->_tpl_vars;
$this->_smarty_include(array('smarty_include_tpl_file' => "header.tpl", 'smarty_include_vars' => array()));
$this->_tpl_vars = $_smarty_tpl_vars;
unset($_smarty_tpl_vars);
 ?> 
<?php echo '
<script type="text/javascript"> 
$(document).ready(function(){

	$("ul.subnav").parent().append("<span></span>"); //Only shows drop down trigger when js is enabled - Adds empty span tag after ul.subnav
	
	$(\'#ppalField\').click(function() {
		$(this).parent().find("ul.subnav").slideDown(\'fast\').show();
	});
	
	$("ul.topnav li span").click(function() { //When trigger is clicked...
		$(this).parent().find("ul.subnav").slideDown(\'fast\').show(); //Drop down the subnav on click
		
		$(this).parent().hover(function() {
        }, function(){
        
        	/*
if ($(this).parent().attr(\'id\') == \'Navigator\'){return false;} else { $(this).parent().find("ul.subnav").slideUp(\'slow\'); //Ocultamos el submenu cuando el raton sale fuera del submenu
        	}
*/
           
        });

		}).click(function() { 
			$(this).addClass("subhover"); //On hover over, add class "subhover"
		}, function(){	//On Hover Out
			$(this).removeClass("subhover"); //On hover out, remove class "subhover"
	});
	
	 
	
	$("ul.topnav li ul.subnav li a").click(function() { //When trigger is clicked...
		valor = $(this).html();
		$(\'#ppalField\').html(valor);
		$(\'#ppalField\').css("color",$(this).css("color"));
		$("ul.subnav").slideUp(\'fast\'); //When the mouse hovers out of the subnav, move it back up */
	});

});
</script>
'; ?>




<!-- GLOBAL CONTAINER RACE -->
	<div class="span-24 raceContainer" id="race">
	
		<!-- RACE & IMAGE -->
		<div class="span-24">
			
			<div id="searchBox">
				<div class="searchForm">
					<div class="column regionInput">
						<form id="searchForm" method="GET" action="/buscar">
							<div class="searchlabel"><p>TEXTO LIBRE</p></div>
							<div class="inputSearch">
								<div class="column first inputLeft">
									<label class="roundsearch1" for="inputsearch1"><span><input type="text" name="q" id="inputsearch1" value="<?php echo $_REQUEST['q']; ?>
"></span></label>			
								</div>
								<div class="column inputRight">
									<ul id="Navigator" class="topnav">
							            <li id="liField">
							                <a id="ppalField" href="#">Todas</a>
							                <ul class="subnav">
							                    <li><a href="#">Todas</a></li>
							                    <li><a href="#" id="a1">Mediofondo</a></li>
							                    <li><a href="#" id="a2">Fondo</a></li>
							                    <li><a href="#" id="a3">Marathon/Ultrafondo</a></li>
							                    <li><a href="#" id="a4">Cross/Campo</a></li>
												<li><a href="#" id="a5">Combinadas</a></li>
							                </ul>
							            </li>
							        </ul>	
							    </div>							
							</div>
						</form>
					</div>
					
					<div class="column dateInput">
						<div class="searchlabel"><p>RANGO DE FECHAS</p></div>
						<div class="inputSearch">
							<div id="widget">
								<div id="widgetField">
									<span>23/09/2009 - 31/09/2009</span>
									<a href="#">Selecciona un rango</a>
								</div>
								<div id="widgetCalendar">
								</div>
							</div>
						</div>
					</div>
					
					<div class="column last buttonSearchBig">
						<span><a href="#"><input class="buttonsearchbig" type="button" value="Buscar"/></a></span>
					</div>
					
				</div>
				<div class="topPaginator" class="span-24">
					<div class="column first racesTab">
					 	<ul>
					    	<li id="current"><a href="#" title="Link 1"><span>Carreras por llegar</span></a></li>
					    	<li><a href="#" title="Link 2"><span>Carreras pasadas</span></a></li>
					  	</ul>
					</div>
					<div class="column last upPaginator">
						<?php if ($this->_tpl_vars['count'] > 10): ?>
							<p>viendo del <b><?php echo smarty_function_math(array('equation' => "x+1",'x' => $this->_tpl_vars['offset']), $this);?>
 al <?php echo smarty_function_math(array('equation' => "min(x2 +10,c)",'x2' => $this->_tpl_vars['offset'],'c' => $this->_tpl_vars['count']), $this);?>
</b> de <?php echo $this->_tpl_vars['count']; ?>

								<?php if ($this->_tpl_vars['offset'] > 0): ?>
									<span><a href="?offset=<?php echo smarty_function_math(array('equation' => "max(x-10,0)",'x' => $this->_tpl_vars['offset']), $this);?>
"><input type="button" value="<"/></a></span>
								<?php endif; ?>
								<?php if ($this->_tpl_vars['offset'] < $this->_tpl_vars['count']-10): ?>
									<span><a href="?offset=<?php echo $this->_tpl_vars['offset']+10; ?>
&q=<?php echo $_REQUEST['q']; ?>
&distancia_min=<?php echo $_REQUEST['distancia_max']; ?>
&distancia_max=<?php echo $_REQUEST['distancia_max']; ?>
"><input type="button" value=">"/></a></span>
	                			<?php endif; ?>	
							</p>	
	                    <?php endif; ?>
					</div>	
				</div>
			</div>




				<div id="results" class="span-24 column first">			
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
	        				<div class="column first <?php echo smarty_function_cycle(array('values' => "raceResult one,raceResult two"), $this);?>
">
	    						<div class="column first firstDetails">
	    							<div class="column first raceResultDate">
	    								<div class="month"><?php echo smarty_function_getMonth(array('month' => ((is_array($_tmp=$this->_tpl_vars['race']['event_date'])) ? $this->_run_mod_handler('substr', true, $_tmp, 5, 2) : substr($_tmp, 5, 2))), $this);?>
</div>
	    								<div class="day"><?php echo ((is_array($_tmp=$this->_tpl_vars['race']['event_date'])) ? $this->_run_mod_handler('substr', true, $_tmp, 8, 2) : substr($_tmp, 8, 2)); ?>
</div>
	    							</div>
	    							<div class="column last">
	    								<div ><img src="/img/avatar2.jpg"></div>
	    							</div>
	    						</div>
	    						<div class="column last">
	    							<p class=" raceLocationText"><b><?php echo $this->_tpl_vars['race']['distance_text']; ?>
</b> / <?php echo $this->_tpl_vars['race']['event_location']; ?>
, <?php echo $this->_tpl_vars['race']['province_name']; ?>
</p>   							
	    							<p><a href="/run/<?php echo $this->_tpl_vars['race']['id']; ?>
/<?php echo ((is_array($_tmp=$this->_tpl_vars['race']['name'])) ? $this->_run_mod_handler('replace', true, $_tmp, ' ', '/') : smarty_modifier_replace($_tmp, ' ', '/')); ?>
" class="raceTitleText"><?php echo $this->_tpl_vars['race']['name']; ?>
</a></p>
	    							<div id="socialDetails">
	    								<div class="column socialBox first"><img src="/img/photo.jpg"/><a href="/run/<?php echo $this->_tpl_vars['race']['id']; ?>
/<?php echo ((is_array($_tmp=$this->_tpl_vars['race']['name'])) ? $this->_run_mod_handler('replace', true, $_tmp, ' ', '/') : smarty_modifier_replace($_tmp, ' ', '/')); ?>
">12 FOTOS</a></div>
	    								<div class="column socialBox last"><img src="img/comment.jpg"/> <a href="/run/<?php echo $this->_tpl_vars['race']['id']; ?>
/<?php echo ((is_array($_tmp=$this->_tpl_vars['race']['name'])) ? $this->_run_mod_handler('replace', true, $_tmp, ' ', '/') : smarty_modifier_replace($_tmp, ' ', '/')); ?>
">12 COMENTARIOS</a></div>
	    							</div>
	    						</div>
	    						<?php if ($this->_tpl_vars['race']['num_users'] > 0): ?>
	    							<div class="blueTag"><a><span class="start"><?php echo $this->_tpl_vars['race']['num_users']; ?>
<?php if ($this->_tpl_vars['race']['num_users'] == 1): ?> VA<?php else: ?> VAN<?php endif; ?></span></a></div> 							
	    						<?php endif; ?>
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
        	    
        	    
        	    <div id="belowPaginator" class="span-24">
        	    	<div class="column first noResults"><p><?php echo $this->_tpl_vars['count']; ?>
<?php if ($this->_tpl_vars['count'] == 1): ?> resultado<?php else: ?> resultados<?php endif; ?></p></div>
        	   		<div class="column last bottomPaginator">
						<?php if ($this->_tpl_vars['count'] > 10): ?>
 							<p>viendo del <b><?php echo smarty_function_math(array('equation' => "x+1",'x' => $this->_tpl_vars['offset']), $this);?>
 al <?php echo smarty_function_math(array('equation' => "min(x2 +10,c)",'x2' => $this->_tpl_vars['offset'],'c' => $this->_tpl_vars['count']), $this);?>
</b> de <?php echo $this->_tpl_vars['count']; ?>

 								<?php if ($this->_tpl_vars['offset'] > 0): ?>
									<span><a href="?offset=<?php echo smarty_function_math(array('equation' => "max(x-10,0)",'x' => $this->_tpl_vars['offset']), $this);?>
"><input type="button" value="< ANTERIORES"/></a></span>
								<?php endif; ?>
								<?php if ($this->_tpl_vars['offset'] < $this->_tpl_vars['count']-10): ?>
									<span><a href="?offset=<?php echo $this->_tpl_vars['offset']+20; ?>
&q=<?php echo $_REQUEST['q']; ?>
&distancia_min=<?php echo $_REQUEST['distancia_max']; ?>
&distancia_max=<?php echo $_REQUEST['distancia_max']; ?>
"><input type="button" value="SIGUIENTES >"/></a></span>
                    			<?php endif; ?>
 								
 							</p>	
                    	<?php endif; ?>
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
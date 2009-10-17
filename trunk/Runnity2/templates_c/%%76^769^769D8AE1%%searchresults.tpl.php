<?php /* Smarty version 2.6.26, created on 2009-10-13 12:17:31
         compiled from searchresults.tpl */ ?>
<?php require_once(SMARTY_CORE_DIR . 'core.load_plugins.php');
smarty_core_load_plugins(array('plugins' => array(array('function', 'math', 'searchresults.tpl', 163, false),array('function', 'cycle', 'searchresults.tpl', 188, false),array('function', 'getMonth', 'searchresults.tpl', 191, false),array('modifier', 'substr', 'searchresults.tpl', 191, false),array('modifier', 'replace', 'searchresults.tpl', 200, false),)), $this); ?>
<?php $_smarty_tpl_vars = $this->_tpl_vars;
$this->_smarty_include(array('smarty_include_tpl_file' => "header.tpl", 'smarty_include_vars' => array()));
$this->_tpl_vars = $_smarty_tpl_vars;
unset($_smarty_tpl_vars);
 ?> 
<?php echo '
<script type="text/javascript"> 
$(document).ready(function(){

	var state = false;
	
	$(\'#widgetField span\').hover(
		function(){
			$(\'#widgetField span a.delete\').css(\'background\',\'url(/img/deleteDateIcon.jpg) 0 7px no-repeat\');
		},
		function(){
			$(\'#widgetField span a.delete\').css(\'background\',\'url(/img/deleteDateIcon.jpg) 0 57px no-repeat\');
		}
	
	);
	
	
		
	$(\'#widgetField>a\').click(function(){
		$(\'#widgetCalendar\').stop().animate({height: state ? 0 : $(\'#widgetCalendar div.datepicker\').get(0).offsetHeight}, 500);
		state = !state;
		return false;	
	});
	
	$("ul.subnav").parent().append("<span></span>");
  
	$("#widgetField>a").click(function() {
		   
        $(\'#widget\').hover(function() {  
        }, function(){
        	$(\'#widgetCalendar\').stop().animate({height: 0 }, 500);
        	state = false;        	
        });    
      
    }); 

    
	$("#ppalField").click(function() { 
  
        $(this).parent().find("ul.subnav").slideDown(\'fast\').show();   
  
        $(\'#Navigator\').hover(function() {  
        }, function(){  
            $("ul.subnav").slideUp(\'slow\'); 
        }) 
  
        }).hover(function() {  
            $(this).addClass("subhover"); 
        }, function(){  //On Hover Out  
            $(this).removeClass("subhover");   
    });
    

	$("ul.topnav li span").click(function() { 
  
 
        $(this).parent().find("ul.subnav").slideDown(\'fast\').show(); 
  
        $(\'#Navigator\').hover(function() {  
        }, function(){  
            $("ul.subnav").slideUp(\'slow\'); 
        }) 
  
        }).hover(function() {  
            $(this).addClass("subhover");
        }, function(){  //On Hover Out  
            $(this).removeClass("subhover");  
    });
	
	$("ul.topnav li ul.subnav li a").click(function() { 
		valor = $(this).html();
		$(\'#ppalField\').html(valor);
		$(\'#ppalField\').css("color",$(this).css("color"));
		$(\'#ppalField\').html(valor);
		$("ul.subnav").slideUp(\'fast\');
		document.getElementById("tipoCarrera").value = valor;
	});
	
	$(document.getElementById("racesTab")).click(function() { 
	    var tipoBusqueda = $("#current a").attr("title");
		if (tipoBusqueda=="Todas"){
			document.getElementById("tipoBusqueda").value = "Proximas";
		}
		if (tipoBusqueda=="Proximas"){
			document.getElementById("tipoBusqueda").value = "Todas";
		}
		document.getElementById("inputSearchGeneral").click();
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
							<!-- inputs ocultos para obtener tipo de carrera y rango de fechas -->
							<input type="hidden" id="tipoBusqueda" name="tipoBusqueda" <?php if ($_REQUEST['q'] != ""): ?>value="<?php echo $_REQUEST['tipoBusqueda']; ?>
"<?php else: ?>value="Proximas"<?php endif; ?>>
							<input type="hidden" id="tipoCarrera" name="tipoCarrera" value="<?php echo $this->_tpl_vars['tipoCarrera']; ?>
">
							<input type="hidden" id="fechaInicio" name="fechaInicio" value="<?php echo $_REQUEST['fechaInicio']; ?>
">
							<input type="hidden" id="fechaFin" name="fechaFin" value="<?php echo $_REQUEST['fechaFin']; ?>
">
							
							<div class="searchlabel"><p>TEXTO LIBRE</p></div>
							<div class="inputSearch">
								<div class="column first inputLeft">
									<label class="roundsearch1" for="inputsearch1"><span><input type="text" id="inputsearch1" class="default" <?php if ($_GET['q'] == null): ?>value="Busca por nombre, localidad, provincia"<?php else: ?> value="<?php echo $_GET['q']; ?>
"<?php endif; ?>name="q"></span></label>			
								</div>
								<div class="column inputRight">
									<ul id="Navigator" class="topnav">
							            <li id="liField">
							                <a id="ppalField" href="#" class="<?php if (( $this->_tpl_vars['tipoCarrera'] == 'Mediofondo' )): ?>a1<?php elseif (( $this->_tpl_vars['tipoCarrera'] == 'Fondo' )): ?>a2<?php elseif (( $this->_tpl_vars['tipoCarrera'] == "Marathon/Ultrafondo" )): ?>a3<?php elseif (( $this->_tpl_vars['tipoCarrera'] == "Cross/Campo" )): ?>a4<?php elseif (( $this->_tpl_vars['tipoCarrera'] == 'Combinadas' )): ?>a5<?php endif; ?>"><?php if (( $this->_tpl_vars['tipoCarrera'] == "" )): ?>Todas<?php else: ?><?php echo $this->_tpl_vars['tipoCarrera']; ?>
<?php endif; ?></a>							                
							                <ul class="subnav">
							                    <li><a href="#">Todas</a></li>
							                    <li><a href="#" class="a1">Mediofondo</a></li>
							                    <li><a href="#" class="a2">Fondo</a></li>
							                    <li><a href="#" class="a3">Marathon/Ultrafondo</a></li>
							                    <li><a href="#" class="a4">Cross/Campo</a></li>
												<li><a href="#" class="a5">Combinadas</a></li>
							                </ul>
							            </li>
							        </ul>	
							    </div>							
							</div>
					</div>
					
					<div class="column dateInput">
						<div class="searchlabel"><p>RANGO DE FECHAS</p></div>
						<div class="inputSearch">
							<div id="widget">
								<div id="widgetField">
									<span><?php if (( $this->_tpl_vars['fechaInicioOld'] != "" )): ?><?php echo $this->_tpl_vars['fechaInicioOld']; ?>
 - <?php echo $this->_tpl_vars['fechaFinOld']; ?>
 <?php else: ?>Selecciona una fecha<?php endif; ?><a class="delete" href="javascript: void cleanDate()"></a></span>
									<a href="#"></a>
								</div>
								<div id="widgetCalendar">
								</div>
							</div>
						</div>
					</div>
					
					<div class="column last buttonSearchBig">
						<span><a href="#"><input id="inputSearchGeneral" class="buttonsearchbig" type="submit" value="Buscar"/></a></span>
					</div>
				</form>

					
				</div>
				<div class="topPaginator" class="span-24">
					<div id="racesTab" class="column first racesTab">
					 	<ul>
					 		<li <?php if (( $this->_tpl_vars['tipoBusqueda'] == 'Proximas' ) || ( $this->_tpl_vars['tipoBusqueda'] == "" )): ?>id="current"<?php endif; ?>><a href="#" title="Proximas"><span>Carreras por llegar</span></a></li>
					    	<li <?php if (( $this->_tpl_vars['tipoBusqueda'] == 'Todas' )): ?>id="current"<?php endif; ?>><a href="#" title="Todas"><span>Todas las carreras</span></a></li>
					  	</ul>
					</div>
					<div class="column last upPaginator">
						<?php if ($this->_tpl_vars['count'] > 10): ?>
							<p>viendo del <b><?php echo smarty_function_math(array('equation' => "x+1",'x' => $this->_tpl_vars['offset']), $this);?>
 al <?php echo smarty_function_math(array('equation' => "min(x2 +10,c)",'x2' => $this->_tpl_vars['offset'],'c' => $this->_tpl_vars['count']), $this);?>
</b> de <?php echo $this->_tpl_vars['count']; ?>

								<?php if ($this->_tpl_vars['offset'] > 0): ?>
									<span><a href="?offset=<?php echo smarty_function_math(array('equation' => "max(x-10,0)",'x' => $this->_tpl_vars['offset']), $this);?>
&tipoBusqueda=<?php echo $this->_tpl_vars['tipoBusqueda']; ?>
&tipoCarrera=<?php echo $_REQUEST['tipoCarrera']; ?>
&fechaInicio=<?php echo $_REQUEST['fechaInicio']; ?>
&fechaFin=<?php echo $_REQUEST['fechaFin']; ?>
"><input class="fg-button buttonLeftArrow" type="button"/></a></span>
								<?php endif; ?>
								<?php if ($this->_tpl_vars['offset'] < $this->_tpl_vars['count']-10): ?>
									<span><a href="?offset=<?php echo $this->_tpl_vars['offset']+10; ?>
&tipoBusqueda=<?php echo $this->_tpl_vars['tipoBusqueda']; ?>
&tipoCarrera=<?php echo $_REQUEST['tipoCarrera']; ?>
&fechaInicio=<?php echo $_REQUEST['fechaInicio']; ?>
&fechaFin=<?php echo $_REQUEST['fechaFin']; ?>
"><input class="fg-button buttonRightArrow" type="button"/></a></span>
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
	        					<div class="noResultsText">
		        					<p class="noResults">Ouch! No hay resultados</p>
		        					<p class="noResultsSub"><b>No hemos podido encontrar ninguna carrera que coincidiera con tu búsqueda</b>
		        					<br />Comprueba que el tipo, la ortografía y las fechas son correctas.<br /><br /> 
		        					Si sigues sin encontrar nada por aquí, puedes intentarlo en el<a href="/"> mapa de carreras</a> de la home<br />o <a href="/rss.php">suscribirte a nuestro RSS</a> para estar al tanto de las últimas actualizaciones</p>
								</div>
	        				</div>
	        			<?php else: ?>
	        				<div class="column first <?php echo smarty_function_cycle(array('values' => "raceResult one,raceResult two"), $this);?>
">
	    						<div class="column first firstDetails">
	    							<div class="column first raceResultDate">
	    								<div class="month month<?php echo $this->_tpl_vars['race']['run_type']; ?>
"><?php echo smarty_function_getMonth(array('month' => ((is_array($_tmp=$this->_tpl_vars['race']['event_date'])) ? $this->_run_mod_handler('substr', true, $_tmp, 5, 2) : substr($_tmp, 5, 2))), $this);?>
</div>
	    								<div class="day"><?php echo ((is_array($_tmp=$this->_tpl_vars['race']['event_date'])) ? $this->_run_mod_handler('substr', true, $_tmp, 8, 2) : substr($_tmp, 8, 2)); ?>
</div>
	    							</div>
	    							<div class="column last">
	    								<div><img src="/media/run/<?php echo $this->_tpl_vars['race']['thumbnail']; ?>
" alt="Foto de la carrera <?php echo $this->_tpl_vars['race']['name']; ?>
"/></div>
	    							</div>
	    						</div>
	    						<div class="column last">
	    							<p class="span-1 raceLocationText"><b><?php echo $this->_tpl_vars['race']['distance_text']; ?>
</b> / <?php echo $this->_tpl_vars['race']['event_location']; ?>
, <?php echo $this->_tpl_vars['race']['province_name']; ?>
</p>   							
	    							<p class="span-18"><a href="/run/<?php echo $this->_tpl_vars['race']['id']; ?>
/<?php echo ((is_array($_tmp=$this->_tpl_vars['race']['name'])) ? $this->_run_mod_handler('replace', true, $_tmp, ' ', '/') : smarty_modifier_replace($_tmp, ' ', '/')); ?>
" class="raceTitleText"><?php echo $this->_tpl_vars['race']['name']; ?>
</a></p>
	    							<div id="socialDetails">
	    								<div class="column socialBox first"><img src="/img/photo.jpg"/><a href="/run/<?php echo $this->_tpl_vars['race']['id']; ?>
/<?php echo ((is_array($_tmp=$this->_tpl_vars['race']['name'])) ? $this->_run_mod_handler('replace', true, $_tmp, ' ', '/') : smarty_modifier_replace($_tmp, ' ', '/')); ?>
"><?php echo $this->_tpl_vars['race']['num_pictures']; ?>
 fotos</a></div>
	    								<div class="column socialBox last"><img src="img/comment.jpg"/> <a href="/run/<?php echo $this->_tpl_vars['race']['id']; ?>
/<?php echo ((is_array($_tmp=$this->_tpl_vars['race']['name'])) ? $this->_run_mod_handler('replace', true, $_tmp, ' ', '/') : smarty_modifier_replace($_tmp, ' ', '/')); ?>
"><?php echo $this->_tpl_vars['race']['num_comments']; ?>
 comentarios</a></div>
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
        					<div class="noResultsText">
	        					<p class="noResults">Ouch! No hay resultados</p>
	        					<p class="noResultsSub"><b>No hemos podido encontrar ninguna carrera que coincidiera con tu búsqueda</b>
	        					<br />Comprueba que el tipo, la ortografía y las fechas son correctas.<br /><br /> 
	        					Si sigues sin encontrar nada por aquí, puedes intentarlo en el<a href="/"> mapa de carreras</a> de la home<br />o <a href="/rss.php">suscribirte a nuestro RSS</a> para estar al tanto de las últimas actualizaciones</p>
							</div>
        				</div>
	        	    <?php endif; unset($_from); ?>
        	    </div>
        	    
        	    
        	    <div id="belowPaginator" class="span-24">
        	    	<div class="column first belowPaginatorTotal"><p><?php echo $this->_tpl_vars['count']; ?>
<?php if ($this->_tpl_vars['count'] == 1): ?> resultado<?php else: ?> resultados<?php endif; ?></p></div>
        	   		<div class="column last bottomPaginator">
						<?php if ($this->_tpl_vars['count'] > 10): ?>
 							<p>viendo del <b><?php echo smarty_function_math(array('equation' => "x+1",'x' => $this->_tpl_vars['offset']), $this);?>
 al <?php echo smarty_function_math(array('equation' => "min(x2 +10,c)",'x2' => $this->_tpl_vars['offset'],'c' => $this->_tpl_vars['count']), $this);?>
</b> de <?php echo $this->_tpl_vars['count']; ?>

								<?php if ($this->_tpl_vars['offset'] > 0): ?>
									<span><a href="?offset=<?php echo smarty_function_math(array('equation' => "max(x-10,0)",'x' => $this->_tpl_vars['offset']), $this);?>
&tipoBusqueda=<?php echo $this->_tpl_vars['tipoBusqueda']; ?>
&tipoCarrera=<?php echo $_REQUEST['tipoCarrera']; ?>
&fechaInicio=<?php echo $_REQUEST['fechaInicio']; ?>
&fechaFin=<?php echo $_REQUEST['fechaFin']; ?>
"><input class="fg-button buttonLeftArrow" type="button"/></a></span>
								<?php endif; ?>
								<?php if ($this->_tpl_vars['offset'] < $this->_tpl_vars['count']-10): ?>
									<span><a href="?offset=<?php echo $this->_tpl_vars['offset']+10; ?>
&tipoBusqueda=<?php echo $this->_tpl_vars['tipoBusqueda']; ?>
&tipoCarrera=<?php echo $_REQUEST['tipoCarrera']; ?>
&fechaInicio=<?php echo $_REQUEST['fechaInicio']; ?>
&fechaFin=<?php echo $_REQUEST['fechaFin']; ?>
"><input class="fg-button buttonRightArrow" type="button"/></a></span>
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
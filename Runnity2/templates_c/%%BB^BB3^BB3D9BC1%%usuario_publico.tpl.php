<?php /* Smarty version 2.6.26, created on 2009-10-13 13:34:33
         compiled from usuario_publico.tpl */ ?>
<?php require_once(SMARTY_CORE_DIR . 'core.load_plugins.php');
smarty_core_load_plugins(array('plugins' => array(array('function', 'getMonth2', 'usuario_publico.tpl', 17, false),array('function', 'getMonth', 'usuario_publico.tpl', 86, false),array('modifier', 'substr', 'usuario_publico.tpl', 17, false),array('modifier', 'count', 'usuario_publico.tpl', 26, false),array('modifier', 'timeAgo', 'usuario_publico.tpl', 43, false),array('modifier', 'replace', 'usuario_publico.tpl', 90, false),)), $this); ?>
<?php $_smarty_tpl_vars = $this->_tpl_vars;
$this->_smarty_include(array('smarty_include_tpl_file' => "header.tpl", 'smarty_include_vars' => array()));
$this->_tpl_vars = $_smarty_tpl_vars;
unset($_smarty_tpl_vars);
 ?> 

	<div class="span-24 raceContainer" id="race">
		<div class="column span-16">
			<div class="span-16 navigationList">
				<ul> 
					<li><a href="">Perfil de usuario</a></li>
				</ul>
			</div>
			<div class="span-16 marginContainer">
				<div class="column span-3 first">
					<img id="userImg" src="/avatar.php?id=<?php echo $this->_tpl_vars['data']['datos']['id']; ?>
"/>
				</div>
				<div class="span-13 last userLeft">
					<div class="span-13 userCount">
						<div class="wellcome"><a href="#" class="wellcome"><?php echo $this->_tpl_vars['data']['datos']['completename']; ?>
</a></div>
						<div class="countAgo">usuario desde <?php echo smarty_function_getMonth2(array('month' => ((is_array($_tmp=$this->_tpl_vars['data']['datos']['created_when'])) ? $this->_run_mod_handler('substr', true, $_tmp, 5, 2) : substr($_tmp, 5, 2))), $this);?>
, <?php echo ((is_array($_tmp=$this->_tpl_vars['data']['datos']['created_when'])) ? $this->_run_mod_handler('substr', true, $_tmp, 0, 4) : substr($_tmp, 0, 4)); ?>
</div>
					</div>
				</div>
			</div>
				
				<div class="span-16 marginContainer">

					<div class="marginDescription"><h3 class="blue">Perfil</h3></div>					
				
					<div class="marginDescription"><h3 class="blue">Tablón <?php if (! empty ( $this->_tpl_vars['comments'] )): ?>[<?php echo count($this->_tpl_vars['comments']); ?>
]<?php endif; ?></h3><h5><a onclick="document.getElementById('commentTextArea').focus();
" class="PublicarComentarioEnlace">Dejar un comentario</a></h5></div>			
					<ol id="update">
						<?php $_from = $this->_tpl_vars['comments']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }if (count($_from)):
    foreach ($_from as $this->_tpl_vars['id'] => $this->_tpl_vars['comment']):
?>
	    				<?php if ($this->_tpl_vars['comment'] == false): ?>
	    					<div class="column span-15 noCommentsContainer"  id="noCommentsDiv">
	        					<div class="carita"></div>
	        					<div class="noResultsText">
	        					<p class="noResults"><b>Aún no hay comentarios en el tablón de <?php echo $this->_tpl_vars['data']['datos']['username']; ?>
</b></p>
								</div>
	        				</div>  
	    				<?php else: ?>	    										
							<div class="column span-16 first racesComment">				
								<div class="column span-3 first image">
									<img src="/avatar.php?id=<?php echo $this->_tpl_vars['comment']['user_id']; ?>
"/>	
								</div>
								<div class="column span-12 last commentBox">
									<div class="nameUser"><a class="nameRace" href="#"><?php echo $this->_tpl_vars['comment']['username']; ?>
, </a>hace <?php echo ((is_array($_tmp=$this->_tpl_vars['comment']['created_when'])) ? $this->_run_mod_handler('timeAgo', true, $_tmp) : smarty_modifier_timeAgo($_tmp)); ?>
</div>
									<p class="textRace"><?php echo $this->_tpl_vars['comment']['commenttext']; ?>
</p>
								</div>
							</div>							
	              		<?php endif; ?>
	                	<?php endforeach; else: ?>
	                	    <div class="column span-15 noCommentsContainer" id="noCommentsDiv">
	        					<div class="carita"></div>
	        					<div class="noResultsText">
	        					<p class="noResults"><b>Aún no hay comentarios en el tablón de <?php echo $this->_tpl_vars['data']['datos']['username']; ?>
</b></p>
								</div>
	        				</div>    
	                	<?php endif; unset($_from); ?>						
					</ol>
				</div>
			
						<!-- PARA AÑADIR COMENTARIOS -->
			<div class="span-16 boxraceMap boxraceMap2">
				<div class="span-16" id="flash" align="left"></div>
				<div class="commentArea" id="commentBox">					
					<?php if ($_SESSION['logged']): ?>
						<div class="span-14 titleComents">Anímate y deja un comentario a <?php echo $_SESSION['user']['username']; ?>
</div>
						<textarea name="textarea2" id="commentTextArea" class="span-15 textArea"></textarea>
						<input class="fg-button" type="submit" value="Escribir comentario" onclick="javascript: void commentAction(<?php echo $this->_tpl_vars['data']['datos']['id']; ?>
,'users')"/>
					<?php else: ?>
						<p class="noComments">Para dejar comentarios debes <b><a href="javascript: void showLoginBox()">iniciar tu sesión</a></b> en runnity. <b><a href="javascript: void showRegisterBox()">¿Aún no estás registrado?</a></b></p>
					<?php endif; ?>
				</div>
			</div>		
		</div>
		
		<div class="column last span-8 rightColumn">
			<div class="span-8 importantRaces">
				<div class="events"> 
					<h2 class="newsTitle5">Carreras de <?php echo $this->_tpl_vars['data']['datos']['username']; ?>
</h2>
				</div>
				<div class="events">
            		<?php $_from = $this->_tpl_vars['data']['carreras']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }if (count($_from)):
    foreach ($_from as $this->_tpl_vars['id'] => $this->_tpl_vars['race']):
?>
            			<?php if ($this->_tpl_vars['race'] == 0): ?>
            				<div class="span-8 races2"><p class="noApuntadoUser">Aun no se ha apuntado a ninguna carrera.</p></div> 
            			<?php else: ?>		    				    
        					<div class="span-8 column first raceDetails" id="raceDetails">
        						<div class="column span-1 first date race">
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
            			<?php endif; ?>
                	    <?php endforeach; else: ?>
            				<div class="span-8 races2"><p class="noApuntadoUser">Aun no se ha apuntado a ninguna carrera.</p></div> 
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
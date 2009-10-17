<?php /* Smarty version 2.6.26, created on 2009-10-13 12:36:18
         compiled from user.tpl */ ?>
<?php require_once(SMARTY_CORE_DIR . 'core.load_plugins.php');
smarty_core_load_plugins(array('plugins' => array(array('modifier', 'count', 'user.tpl', 89, false),array('modifier', 'timeAgo', 'user.tpl', 103, false),array('modifier', 'substr', 'user.tpl', 142, false),array('modifier', 'replace', 'user.tpl', 150, false),array('function', 'cycle', 'user.tpl', 140, false),array('function', 'getMonth', 'user.tpl', 142, false),)), $this); ?>
<?php $_smarty_tpl_vars = $this->_tpl_vars;
$this->_smarty_include(array('smarty_include_tpl_file' => "header.tpl", 'smarty_include_vars' => array()));
$this->_tpl_vars = $_smarty_tpl_vars;
unset($_smarty_tpl_vars);
 ?>

<div class="span-24 column content">

	<div class="span-1 last leftColumn">
		
<div class="span-1 columnNameUser"><p class="nameUserProfile"><?php echo $_SESSION['user']['completename']; ?>
 <span class="nameUserProfileNick">(<?php echo $_SESSION['user']['username']; ?>
)</span></div>
		<div class="globalContainerUser">	
			<div class="span-1 last userData">
				<div class="span-1 avatarPerfil">
					<img class="imgAvatarPerfil" src="/img/AvatarPerfil.jpg">
				</div>
				<div class="span-1 last functionalContainer">
				<p class="titulo tituloLeft">ESTADÍSTICAS</p>
					<div class="span-1 last dataContainerUser">
						<div class="span-1 last dataTitleUser"><p>Visitas a tu perfil:</p></div>
						<div class="span-1 last dataUser"><p><b>1142</b></p></div>
					</div>
					<div class="span-1 last dataContainerUser">
						<div class="span-1 last dataTitleUser"><p>Carreras corridas:</p></div>
						<div class="span-1 last dataUser"><p><b>23</b></p></div>
					</div>
				</div>
				<div class="span-1 last functionalContainer">
				<p class="titulo tituloLeft">TU RANKING RUNNITY</p>
					<div class="span-1 last dataContainerUser">
						<div class="span-1 last dataTitleUserRanking"><p>800m:</p></div>
						<div class="span-1 last dataUserRanking"><p><b>2:02:00 (2006)</b></p></div>
						<div class="span-1 last dataUserPosition"><div class="rankingBox"><p>17º</p></div></div>
					</div>
					<div class="span-1 last dataContainerUser">
						<div class="span-1 last dataTitleUserRanking"><p>1.500m:</p></div>
						<div class="span-1 last dataUserRanking"><p><b>2:02:00 (2006)</b></p></div>
						<div class="span-1 last dataUserPosition"><div class="rankingBox"><p>17º</p></div></div>
					</div>
					<div class="span-1 last dataContainerUser">
						<div class="span-1 last dataTitleUserRanking"><p>10.000m:</p></div>
						<div class="span-1 last dataUserRanking"><p><b>2:02:00 (2006)</b></p></div>
						<div class="span-1 last dataUserPosition"><div class="rankingBox"><p>17º</p></div></div>
					</div>
					<a class="editUserLink">editar tus marcas <img src="/img/pencil.gif"></a>
				</div>
				<div class="span-1 last functionalContainer">
				<p class="titulo tituloLeft">DATOS PERSONALES</p>
					<div class="span-1 last dataContainerUser">
						<div class="span-1 last dataTitleUserProfile"><p>Email:</p></div>
						<div class="span-1 last dataUserProfile"><p><b>a.rodriguez@gmail.com</b></p></div>
					</div>
					<div class="span-1 last dataContainerUser">
						<div class="span-1 last dataTitleUserProfile"><p>Club:</p></div>
						<div class="span-1 last dataUserProfile"><p><b>S.S. de los Reyes - Clínicas Menorca</b></p></div>
					</div>
					<div class="span-1 last dataContainerUser">
						<div class="span-1 last dataTitleUserProfile"><p>Categoría:</p></div>
						<div class="span-1 last dataUserProfile"><p><b>Senior Masculino</b></p></div>
					</div>
					<a class="editUserLink" href="/userprofile.php">editar tus datos <img src="/img/pencil.gif"></a>
				</div>
			</div>
			
			<div class="span-1 last userAlerts">
				<div class="alertUser"><p>Aún no nos has dicho si <b>perteneces a algún club</b></p></div>
				<div class="alertUser"><p>Tienes <b>2 mensajes nuevos</b></p></div>
			</div>
			
			<div class="span-1 last imagesUserContainer">
				<p class="titulo tituloLeft tituloRight">TUS FOTOS [42], <a>ver todas</a></p>
				<div class="imagesUser">
					<img src="/img/avatar.jpg"/>	
				</div>
				<div class="imagesUser">
					<img src="/img/avatar.jpg"/>	
				</div>
				<div class="imagesUser">
					<img src="/img/avatar.jpg"/>	
				</div>
				<div class="imagesUser">
					<img src="/img/avatar.jpg"/>	
				</div>
				<div class="imagesUser">
					<img src="/img/avatar.jpg"/>	
				</div>
				<div>
					<a class="editUserLink">subir fotos <img src="/img/pencil.gif"></a>
				</div>
			</div>
			
			<div class="span-1 last commentsUser">
				<p class="titulo tituloLeft tituloRight">MENSAJES PARA TI <?php if (! empty ( $this->_tpl_vars['comments'] )): ?>[<?php echo count($this->_tpl_vars['comments']); ?>
]<?php endif; ?></p>
				
				<div class="span-1 last columnComments">

				<ol id="update">
				<?php $_from = $this->_tpl_vars['comments']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }if (count($_from)):
    foreach ($_from as $this->_tpl_vars['id'] => $this->_tpl_vars['comment']):
?>
					<?php if ($this->_tpl_vars['comment'] == false): ?>
	
					<?php else: ?>   										
						<div id="commentUser" class="span-1 last">
							<div class="span-1 last avatarBox">
								<img src="/img/avatar.jpg"/>	
							</div>
							<div class="span-1 commentBoxUser">
							<div class="nameUser"><a class="name" href="/user/<?php echo $this->_tpl_vars['comment']['username']; ?>
"><?php echo $this->_tpl_vars['comment']['username']; ?>
, </a>hace <?php echo ((is_array($_tmp=$this->_tpl_vars['comment']['created_when'])) ? $this->_run_mod_handler('timeAgo', true, $_tmp) : smarty_modifier_timeAgo($_tmp)); ?>
</div>
							<p class="commentUserProfile"><?php echo $this->_tpl_vars['comment']['commenttext']; ?>
</p>
							</div>
							
						</div>							
	          		<?php endif; ?>
            	<?php endforeach; else: ?>
					<div class="span-1 noComments">

    				</div>    
            	<?php endif; unset($_from); ?>
            	</ol>
				</div>
				
				
				<!-- Crear servicio para los comentarios sobre usuario -->
				<div class="span-9 commentsPaginator">
        	   		<div class="userComments">
						<p>viendo del <b>1 al 5</b> de 60
							<span><a><input class="fg-button buttonLeftArrow" type="button"/></a></span>
							<span><a><input class="fg-button buttonRightArrow" type="button"/></a></span>
						</p>	
					</div>
				</div>

			</div>
		</div>
	</div>
	

	<!-- RIGHT COLUMN -->
	<div class="span-1 last rightColumn userRightColumn">
		<?php if ($this->_tpl_vars['nextRaces']): ?>
		<div class="span-1 functionalContainer">
			<p class="titulo tituloLeft tituloColumnRight">TUS PRÓXIMAS CARRERAS</p>
			<div class="events">
				<?php $_from = $this->_tpl_vars['nextRaces']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }$this->_foreach['raceloop'] = array('total' => count($_from), 'iteration' => 0);
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
		</div>
		<?php endif; ?>
		
		<div class="span-1 functionalContainer">
			<p class="titulo tituloLeft tituloColumnRight">CARRERAS APUNTADAS</p>
			<div id="map" class="mapStyleRight">
	    		<img src="/img/mapaApuntadas.jpg">					
			</div>
		</div>
		
		<div class="span-1 functionalContainer">
			<p class="titulo tituloLeft tituloColumnRight">DE TU MISMO CLUB</p>
			<div class="eventsUsers">									
				<div class="avatarContainer">
					<a href="/user/<?php echo $_SESSION['user']['username']; ?>
"><img title="<?php echo $_SESSION['user']['username']; ?>
" class="avatarRight" src="/avatar.php?id=<?php echo $_SESSION['user']['user_id']; ?>
"/></a>	
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
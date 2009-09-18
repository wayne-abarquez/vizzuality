<?php /* Smarty version 2.6.26, created on 2009-09-14 11:36:36
         compiled from user.tpl */ ?>
<?php require_once(SMARTY_CORE_DIR . 'core.load_plugins.php');
smarty_core_load_plugins(array('plugins' => array(array('function', 'getMonth2', 'user.tpl', 73, false),array('function', 'getMonth', 'user.tpl', 250, false),array('modifier', 'substr', 'user.tpl', 73, false),array('modifier', 'replace', 'user.tpl', 254, false),)), $this); ?>
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
        	data : { method:"uploadAvatar"},
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
        	onComplete : function(file){
	
				$("#userImg").attr("src","/avatar.php?id='; ?>
<?php echo $_SESSION['user']['id']; ?>
<?php echo '&"+new Date().valueOf());
				$("#buttonUpload").attr("value","Subir foto");

    			window.clearInterval(interval);

    			//enable upload button
    			this.enable();
    						
        	}		
        });
});/*]]>*/</script>

'; ?>

   
	<div class="span-24 raceContainer" id="race">
		<div class="column span-16">
			<div class="span-16 navigationList">
				<ul> 
					<li><a href="">Panel de control ></a></li>
					<li><a href="" class="selected">Preferencias de usuario</a></li>
				</ul>
			</div>
			<div class="span-16 marginContainer">
				<div class="column span-3 first">
					<img id="userImg" src="/avatar.php?id=<?php echo $_SESSION['user']['id']; ?>
"/>
					<div>
						<input id="buttonUpload" class="fg-button Subirfoto" type="submit" value="Subir foto">
					</div>
				</div>
				<div class="span-13 last userLeft">
					<div class="span-13 userCount">
						<div class="wellcome">Bienvenido/a <a href="#" class="wellcome"><?php echo $_SESSION['user']['completename']; ?>
</a></div>
						<div class="countAgo">usuario desde <?php echo smarty_function_getMonth2(array('month' => ((is_array($_tmp=$_SESSION['user']['created_when'])) ? $this->_run_mod_handler('substr', true, $_tmp, 5, 2) : substr($_tmp, 5, 2))), $this);?>
, <?php echo ((is_array($_tmp=$_SESSION['user']['created_when'])) ? $this->_run_mod_handler('substr', true, $_tmp, 0, 4) : substr($_tmp, 0, 4)); ?>
</div>
					</div>
					<div class="span-13">
						<div class="paddingRightContainer"> 
							<h2 class="userData">Datos de cuenta</h2>
						</div>
						<div class="paddingRightContainer">
							
							<form id="changeUserDataForm" action="javascript: void changeUserData('<?php echo $_SESSION['user']['pass']; ?>
','<?php echo $_SESSION['user']['email']; ?>
','<?php echo $_SESSION['user']['completename']; ?>
','<?php echo $_SESSION['user']['username']; ?>
')"
								<div class="column span-6 first marginTopBottom">
									<div>
										<div class="countAgo">nombre y apellidos</div>
										<div class="inputWhite">
											<label class="round" for="input1"><span><input type="text" name="input1" id="input1" value="<?php echo $_SESSION['user']['completename']; ?>
"></span></label>
										</div>
									</div>
									<div>
										<div class="countAgo">nombre de usuario</div>
										<div class="inputWhite">
											<label class="round" for="input2"><span><input type="text" name="input2" id="input2" disabled="true" value="<?php echo $_SESSION['user']['username']; ?>
"></span></label>
										</div>
									</div>
									<div>
										<div class="countAgo">email</div>
										<div class="inputWhite">
											<label class="round" for="input3"><span><input type="text" name="input3" id="input3" value="<?php echo $_SESSION['user']['email']; ?>
"></span></label>
										</div>
									</div>
									<div class="inputWhiteButton">
										<input id="userSaveData" class="fg-button" type="submit" value="Guardar cambios"/>
									</div>
									<div id="userError" class="registerError"></div>
								</div>
							</form>
								
								
							<form id="changePassDataForm" action="javascript: void changePassData('<?php echo $_SESSION['user']['pass']; ?>
','<?php echo $_SESSION['user']['email']; ?>
','<?php echo $_SESSION['user']['completename']; ?>
','<?php echo $_SESSION['user']['username']; ?>
')">
								<div class="column last passContainer">
									<div class="changePass">Cambiar contraseña</div>
									<div>
										<div class="inputTitleBlue">contraseña anterior</div>
										<div class="inputBlue">
									<label class="roundblue" for="input4"><span><input type="password" name="input4" id="input4"></span></label>
										</div>
									</div>
									<div>
										<div class="inputTitleBlue">nueva contraseña</div>
										<div class="inputBlue">
											<label class="roundblue" for="input5"><span><input type="password" name="input5" id="input5"></span></label>
										</div>
										<div class="inputBlueButton">
											<input id="passSaveData" class="fg-button" type="Submit" value="Cambiar contraseña" />
											<div id="passError" class="registerError"></div>
										</div>
									</div>
								</div>
							</form>
								
						</div>
					</div>
					<div class="span-13 DarDeBaja phraseGray">Si quieres dar de baja tu cuenta, por favor, <a href="#" class="hrefText">contacta con nosotros</a>.</div>
					<div class="span-13 marginTopPlus">
						<div class="paddingRightContainer">
							<h2 class="userData">Alerta geográfica por email 
								<span id="alertType" class="<?php if ($_SESSION['user']['radius_interest'] == ''): ?>desactivate<?php else: ?>activate<?php endif; ?>"><?php if ($_SESSION['user']['radius_interest'] == ""): ?>(desactivado) <?php else: ?>(activado) <?php endif; ?></span>
								<span id="desactiveAlertButton">
									<?php if ($_SESSION['user']['radius_interest'] != ''): ?><input id="alertButtonPpal" class="fg-button" type="submit" value="Desactivar" onclick="javascript: void desactivateAlerts()"/><?php endif; ?>
								</span>
							</h2>
						</div>
						<div class="paddingRightContainer phraseGray2">Introduce tu localidad y especifica cuanta distancia estás dispuesto a moverte. Nosotros te informaremos de todos los eventos que estén dentro de tu radio de búsqueda.</div>
						<div class="marginTopPlus">
						    <form id="formAlerts" method="GET"  action="<?php if ($_SESSION['user']['radius_interest'] == ''): ?>javascript: void activateAlerts()<?php else: ?>javascript: void updateAlerts()<?php endif; ?>">
								<div class="column first">
									<div class="alertLabel">Localidad y provincia</div>
									<div class="inputWhite">
										<label class="round" for="input6"><span><input type="text" name="input6" id="input6" value="<?php echo $_SESSION['user']['locality']; ?>
"></span></label>
									</div>
								</div>
								<div class="column">
									<div class="alertLabel">Radio (km)</div>
									<div class="inputWhite">
										<label class="round" for="input7"><span><input type="text" name="input7" id="input7" value="<?php echo $_SESSION['user']['radius_interest']; ?>
"></span></label>
									</div>
								</div>
								<div class="inputWhite paddingRightContainer">
									<input id="alertButton" class="fg-button" type="submit" value="<?php if ($_SESSION['user']['radius_interest'] == ''): ?>Activar alertas por email<?php else: ?>Actualizar alertas<?php endif; ?>"/>
								</div>
								<div id="alertError" class="span-10 registerError"></div>
						    </form>
						</div>					
					</div>
                                     
                    <div class="span-13">
                        <div id="map" style="width:512px; height:200px;"></div>
                    </div>    
                        <?php echo '
                        <script type="text/javascript">
                        //<![CDATA[
                            var map = new GMap2(document.getElementById("map"));
                            '; ?>
<?php if (! $_SESSION['user']['lat'] == ""): ?><?php echo '
                                var start = new GLatLng('; ?>
<?php echo $_SESSION['user']['lat']; ?>
, <?php echo $_SESSION['user']['lon']; ?>
<?php echo ');
                                map.setCenter(start, 10);
                            '; ?>
<?php else: ?><?php echo '
                                var start = new GLatLng(40.111688,-3.69140625);
                                map.setCenter(start, 4);
                            '; ?>
<?php endif; ?><?php echo '
                            
                            map.addControl(new GSmallZoomControl());
                            new GKeyboardHandler(map);
                            map.enableContinuousZoom();
                            map.enableDoubleClickZoom();    
                            
                            var bounds = new GLatLngBounds();


                            function drawCircle(center, radius, nodes, liColor, liWidth, liOpa, fillColor, fillOpa)
                            {
                                map.clearOverlays();
                            // Esa 2006
                            	//calculating km/degree
                            	var latConv = center.distanceFrom(new GLatLng(center.lat()+0.1, center.lng()))/100;
                            	var lngConv = center.distanceFrom(new GLatLng(center.lat(), center.lng()+0.1))/100;

                            	//Loop 
                            	var points = [];
                            	var step = parseInt(360/nodes)||10;
                            	for(var i=0; i<=360; i+=step)
                            	{
                            	var pint = new GLatLng(center.lat() + (radius/latConv * Math.cos(i * Math.PI/180)), center.lng() + 
                            	(radius/lngConv * Math.sin(i * Math.PI/180)));
                            	points.push(pint);
                            	bounds.extend(pint); //this is for fit function
                            	}
                            	points.push(points[0]); // Closes the circle, thanks Martin
                            	fillColor = fillColor||liColor||"#0055ff";
                            	liWidth = liWidth||2;
                            	var poly = new GPolygon(points,liColor,liWidth,liOpa,fillColor,fillOpa);
                            	map.addOverlay(poly);
                            }  

                            function fit(){
                                map.panTo(bounds.getCenter()); 
                                map.setZoom(map.getBoundsZoomLevel(bounds));
                            }

                            '; ?>
<?php if (! $_SESSION['user']['lat'] == ""): ?><?php echo '
                                drawCircle(start, '; ?>
<?php echo $_SESSION['user']['radius_interest']; ?>
<?php echo ', 40);   
                                fit();
                            '; ?>
<?php else: ?><?php echo '
                                $(\'#map\').hide();
                            '; ?>
<?php endif; ?><?php echo '
                                
                               
                            

                        //]]>

                        </script>
                        '; ?>
				
				</div>
			</div>	
			
		</div>
		
		<div class="column last span-8 rightColumn">
			<div class="span-8 importantRaces">
				<div class="events"> 
					<h2 class="newsTitle5">Tus próximas carreras</h2>
				</div>
				<div class="events">
            		<?php $_from = $this->_tpl_vars['nextRaces']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }if (count($_from)):
    foreach ($_from as $this->_tpl_vars['id'] => $this->_tpl_vars['race']):
?>
            			<?php if ($this->_tpl_vars['race'] == 0): ?>
            				<div class="span-8 races2"><p class="noApuntadoUser">Aun no te has apuntado a ninguna carrera.</p></div> 
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
                	        <div class="span-8 races2"><p class="noApuntadoUser">Aun no te has apuntado a ninguna carrera.</p></div> 
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
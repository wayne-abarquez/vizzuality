{include file="header.tpl"} 

{literal}
<script type="text/javascript">
    $(document).ready(function(){
        new AjaxUpload('#buttonUpload', {
        	action: '/up_page.php',
        	data : {},
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
							$("#buttonUpload").attr("value",text + '.');					
        				} else {
        					$("#buttonUpload").attr("value",".");				
        				}
        			}, 200);

        		} else {
			
        			// extension is not allowed
        			//$('#example2 .text').text('Error: only images are allowed');
        			// cancel upload
        			return false;				
        		}

        	},
        	onComplete : function(file){
	
				$("#userImg").attr("src",$("#userImg").attr("src")+"1");
				$("#buttonUpload").attr("value","Subir foto");

    			window.clearInterval(interval);

    			//enable upload button
    			this.enable();
    						
        	}		
        });
});/*]]>*/</script>

{/literal}
   
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
					<img id="userImg" src="{$user_image}"/>
					<div>
						<input id="buttonUpload" class="fg-button Subirfoto" type="submit" value="Subir foto">
<!-- 						<input class="fg-button Subirfoto" type="submit" value="Subir foto"> -->
					</div>
				</div>
				<div class="span-13 last userLeft">
					<div class="span-13 userCount">
						<div class="wellcome">Bienvenido/a <a href="#" class="wellcome">{$smarty.session.user.completename}</a></div>
						<div class="countAgo">usuario desde {getMonth2 month=$smarty.session.user.created_when|substr:5:2}, {$smarty.session.user.created_when|substr:0:4}</div>
					</div>
					<div class="span-13">
						<div class="paddingRightContainer"> 
							<h2 class="userData">Datos de cuenta</h2>
						</div>
						<div class="paddingRightContainer">
							<div class="column span-6 first marginTopBottom">
								<div>
									<div class="countAgo">nombre y apellidos</div>
									<div class="inputWhite">
										<label class="round" for="input1"><span><input type="text" name="input1" id="input1" value="{$smarty.session.user.completename}"></span></label>
									</div>
								</div>
								<div>
									<div class="countAgo">nombre de usuario</div>
									<div class="inputWhite">
										<label class="round" for="input2"><span><input type="text" name="input2" id="input2" disabled="true" value="{$smarty.session.user.username}"></span></label>
									</div>
								</div>
								<div>
									<div class="countAgo">email</div>
									<div class="inputWhite">
										<label class="round" for="input3"><span><input type="text" name="input3" id="input3" value="{$smarty.session.user.email}"></span></label>
									</div>
								</div>
								<div class="inputWhiteButton">
									<input id="userSaveData" class="fg-button" type="submit" value="Guardar cambios" onclick="javascript: void changeUserData('{$smarty.session.user.pass}','{$smarty.session.user.email}','{$smarty.session.user.completename}','{$smarty.session.user.username}')"/>
								</div>
								<div id="userError" class="registerError"></div>
							</div>
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
										<input id="passSaveData" class="fg-button" type="Submit" value="Cambiar contraseña" onclick="javascript: void changePassData('{$smarty.session.user.pass}','{$smarty.session.user.email}','{$smarty.session.user.completename}','{$smarty.session.user.username}')"/>
										<div id="passError" class="registerError"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="span-13 DarDeBaja phraseGray">Si quieres dar de baja tu cuenta, por favor, <a href="#" class="hrefText">contacta con nosotros</a>.</div>
					<div class="span-13 marginTopPlus">
						<div class="paddingRightContainer">
							<h2 class="userData">Alerta geográfica por email 
								<span id="alertType" class="{if $smarty.session.user.radius_interest eq ''}desactivate{else}activate{/if}">{if $smarty.session.user.radius_interest eq ""}(desactivado) {else}(activado) {/if}</span>
								<span id="desactiveAlertButton">
									{if $smarty.session.user.radius_interest ne ''}<input id="alertButtonPpal" class="fg-button" type="submit" value="Desactivar" onclick="javascript: void desactivateAlerts()"/>{/if}
								</span>
							</h2>
						</div>
						<div class="paddingRightContainer phraseGray2">Introduce tu localidad y especifica cuanta distancia estás dispuesto a moverte. Nosotros te informaremos de todos los eventos que estén dentro de tu radio de búsqueda.</div>
						<div class="marginTopPlus">
						    <form id="formAlerts" method="GET"  action="javascript: void activateAlerts()">
								<div class="column first">
									<div class="alertLabel">Localidad y provincia</div>
									<div class="inputWhite">
										<label class="round" for="input6"><span><input type="text" name="input6" id="input6" value="{$smarty.session.user.locality}"></span></label>
									</div>
								</div>
								<div class="column">
									<div class="alertLabel">Radio (km)</div>
									<div class="inputWhite">
										<label class="round" for="input7"><span><input type="text" name="input7" id="input7" value="{$smarty.session.user.radius_interest}"></span></label>
									</div>
								</div>
								<div class="inputWhite paddingRightContainer">
									<input id="alertButton" class="fg-button" type="submit" value="{if $smarty.session.user.radius_interest eq ''}Activar alertas por email{else}Actualizar alertas{/if}"/>
								</div>
								<div id="alertError" class="span-10 registerError"></div>
						    </form>
						</div>					
					</div>
                                     
                    <div class="span-13">
                        <div id="map" style="width:512px; height:200px;">Map...</div>
                    </div>    
                        {literal}
                        <script type="text/javascript">
                        //<![CDATA[
                            var map = new GMap2(document.getElementById("map"));
                            {/literal}{if !$smarty.session.user.lat eq ""}{literal}
                                var start = new GLatLng({/literal}{$smarty.session.user.lat}, {$smarty.session.user.lon}{literal});
                                map.setCenter(start, 10);
                            {/literal}{else}{literal}
                                var start = new GLatLng(40.111688,-3.69140625);
                                map.setCenter(start, 4);
                            {/literal}{/if}{literal}
                            
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

                            {/literal}{if !$smarty.session.user.lat eq ""}{literal}
                                drawCircle(start, {/literal}{$smarty.session.user.radius_interest}{literal}, 40);   
                                fit();
                            {/literal}{else}{literal}
                                $('#map').hide();
                            {/literal}{/if}{literal}
                                
                               
                            

                        //]]>

                        </script>
                        {/literal}				
				</div>
			</div>	
			
		</div>
		
		<div class="column last span-8 rightColumn">
			<div class="span-8 importantRaces">
				<div class="events"> 
					<h2 class="newsTitle5">Tus próximas carreras</h2>
				</div>
				<div class="events">
            		{foreach key=id item=race from=$nextRaces}
            			{if $race eq 0}
            				<div class="span-8 races2"><p class="noApuntadoUser">Aun no te has apuntado a ninguna carrera.</p></div> 
            			{else}		    				    
        					<div class="span-8 column first raceDetails" id="raceDetails">
        						<div class="column span-1 first date race">
	    							<div class="month month{$race.run_type}">{getMonth month=$race.event_date|substr:5:2}</div>
	    							<div class="day">{$race.event_date|substr:8:2}</div>
	    						</div>
        						<div class="column span-6 last calendarRaces">
        							<div class="nextRaceComment"><a href="/run/{$race.id}/{$race.name|replace:' ':'/'}" class="nameRace">{$race.name}</a></div>
        							<div class="raceLocation">{$race.event_location} | {$race.distance_text} | <b>{$race.num_users} van</b> </div>
        						</div>
        					</div>
            			{/if}
                	    {foreachelse}
                	        <div class="span-8 races2"><p class="noApuntadoUser">Aun no te has apuntado a ninguna carrera.</p></div> 
                	    {/foreach}					
				</div>
			</div>
		</div>
	</div>
</div>

{include file="footer.tpl"} 
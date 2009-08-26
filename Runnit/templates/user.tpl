{include file="header.tpl"} 

<script type="text/javascript" src="js/ajaxupload.3.6.js"></script>
{literal}
<script type="text/javascript">
    $(document).ready(function(){
        new AjaxUpload('#buttonUpload', {
        	action: 'up_avatar.php',
        	data : {},
        	onSubmit : function(file , ext){
        		if (ext && /^(jpg|png|jpeg|gif)$/.test(ext)){
        			/* Setting data */
        			this.setData({
        				'user_id': 999
        			});
			
        			// change button text, when user selects file			
        			button.text('Uploading');

        			// If you want to allow uploading only 1 file at time,
        			// you can disable upload button
        			this.disable();

        			// Uploding -> Uploading. -> Uploading...
        			interval = window.setInterval(function(){
        				var text = button.text();
        				if (text.length < 13){
        					button.text(text + '.');					
        				} else {
        					button.text('Uploading');				
        				}
        			}, 200);

        		} else {
			
        			// extension is not allowed
        			$('#example2 .text').text('Error: only images are allowed');
        			// cancel upload
        			return false;				
        		}

        	},
        	onComplete : function(file){
        		button.text('Upload');

    			window.clearInterval(interval);

    			// enable upload button
    			this.enable();
    						
        	}		
        });
});/*]]>*/</script>

<style type="text/css">
.wrapper {
    	width: 133px;
    	margin: 0 auto;
    }


div.button {
	height: 24px;	
	width: 56px;
	background: url(img/boton_prueba.png) 0 0;
	
	font-size: 14px;
	color: #C7D92C;
	text-align: center;
	padding-top: 4px;
}

div.button.hover {
	background: url(img/boton_prueba.png) 0 24px;
	color: #95A226;	
}

</style>
{/literal}
   
	<div class="span-24 raceContainer" id="race">
		<div class="column span-16 marginTopBottom">
			<div class="span-16 navigationList">
				<ul> 
					<li><a href="">Panel de control ></a></li>
					<li><a href="" class="selected">Preferencias de usuario</a></li>
				</ul>
			</div>
			<div class="span-16 marginContainer">
				<div class="column span-3 first">
					<img src="img/user.jpg"/>
					<div class="uploadButton">
						<input class="fg-button ui-state-default ui-corner-all" type="button" value="Subir foto"/>
					</div>
            		
					
                    
				</div>
				<div class="column span-13 last">
					<div class="span-13 userCount">
						<div class="wellcome">Bienvenida <a href="#" class="wellcome">{$smarty.session.user.completename}</a></div>
						<div class="countAgo">usuario desde Febrero, 2009</div>
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
										<label class="round" for="input1"><span><input type="text" name="input1" id="input1"></span></label>
									</div>
								</div>
								<div>
									<div class="countAgo">nombre de usuario</div>
									<div class="inputWhite">
										<label class="round" for="input2"><span><input type="text" name="input2" id="input2"></span></label>
									</div>
								</div>
								<div>
									<div class="countAgo">email</div>
									<div class="inputWhite">
										<label class="round" for="input3"><span><input type="text" name="input3" id="input3"></span></label>
									</div>
								</div>
								<div class="inputWhiteButton">
									<input class="fg-button ui-state-default ui-corner-all" type="submit" value="Guardar cambios"/>
								</div>
							</div>
							<div class="column last passContainer">
								<div class="changePass">Cambiar contraseña</div>
								<div>
									<div class="inputTitleBlue">contraseña anterior</div>
									<div class="inputBlue">
								<label class="roundblue" for="input4"><span><input type="text" name="input4" id="input4"></span></label>
									</div>
								</div>
								<div>
									<div class="inputTitleBlue">nueva contraseña</div>
									<div class="inputBlue">
										<label class="roundblue" for="input5"><span><input type="text" name="input5" id="input5"></span></label>
									</div>
									<div class="inputBlueButton">
										<input class="fg-button ui-state-default ui-corner-all" type="submit" value="Registrate ahora"/>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="span-13 marginTopPlus phraseGray">Si quieres dar de baja tu cuenta, por favor, <a href="#" class="hrefText">contacta con nosotros</a>.</div>
					<div class="span-13 marginTopPlus">
						<div class="paddingRightContainer"> 
							<h2 class="userData">Alerta geográfica por email <span class="desactivate">(desactivado)</span></h2>
						</div>
						<div class="paddingRightContainer phraseGray">Introduce tu localidad y especifica cuanta distancia estás dispuesto a moverte. Nosotros te informaremos de todos los eventos que estén dentro de tu radio de búsqueda.</div>
						<div class="marginTopPlus">
							<div class="column first">
								<div class="alertLabel">Localidad y provincia</div>
								<div class="inputWhite">
									<label class="round" for="input6"><span><input type="text" name="input6" id="input6"></span></label>
								</div>
							</div>
							<div class="column">
								<div class="alertLabel">Radio</div>
								<div class="inputWhite">
									<label class="round" for="input7"><span><input type="text" name="input7" id="input7"></span></label>
								</div>
							</div>
							<div class="inputWhite paddingRightContainer">
								<input class="fg-button ui-state-default ui-corner-all" type="submit" value="Activar alerta por email"/>
							</div>
						</div>
					</div>
				</div>
			</div>	
			
		</div>
		<div class="column last span-8 rightColumnUser">
			<div class="span-8 importantRaces">
				<div class="events"> 
					<h2 class="newsTitle">Tus próximas carreras</h2>
				</div>
				<div class="events">
            		{foreach key=id item=race from=$nextRaces}
            			{if $race eq "f"}
            				<div class="span-8 races2">No te has apuntado a ninguna.</div> 
            			{else}		    				    
        					<div class="span-8 column first raceDetails" id="raceDetails">
        						<div class="column span-1 first date">
        							<div class="month">{getMonth month=$race.event_date|substr:5:2}</div>
        							<div class="day">{$race.event_date|substr:8:2}</div>
        						</div>
        						<div class="column span-6 last calendarRaces">
        							<div class="nextRaceComment"><a href="carrera.php?id={$race.id}" class="nameRace">{$race.name}</a></div>
        							<div class="raceLocation">{$race.event_location} | {$race.distance_text} | <b>{$race.num_users} van</b> </div>
        						</div>
        					</div>
            			{/if}
                	    {foreachelse}
                	        <div class="span-8 races2">No te has apuntado a ninguna.</div> 
                	    {/foreach}					
				</div>
			</div>
			<!--div class="column last span-7 pagination countAgo">
				<div class="column last span-2 pagination btnMargin">
					<div class="column first span-1 btnJoin"><a href=""><input class="fg-button ui-state-default ui-corner-all" type="button" value="<"/></a></div>
					<div class="column last span-1 btnJoin"><a href=""><input class="fg-button ui-state-default ui-corner-all" type="button" value=">"/></a></div>	
				</div>
				<div class="column first span-4 pagination">viendo del 1-4 de 21</div>			
			</div -->
		</div>
	</div>
</div>

{include file="footer.tpl"} 
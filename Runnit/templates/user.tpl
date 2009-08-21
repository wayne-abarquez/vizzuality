{include file="header.tpl"} 

<script type="text/javascript" src="js/ajaxupload.3.6.js"></script>
{literal}
<script type="text/javascript">
    $(document).ready(function(){
        new AjaxUpload('#button2', {
        	action: 'upload.php',
        	data : {},
        	onSubmit : function(file , ext){
        		//if (ext && new RegExp('^(' + allowed.join('|') + ')$').test(ext)){
        		if (ext && /^(jpg|png|jpeg|gif)$/.test(ext)){
        			/* Setting data */
        			this.setData({
        				'user_id': 1
        			});
			
        			$('#example2 .text').text('Uploading ' + file);	
        		} else {
			
        			// extension is not allowed
        			$('#example2 .text').text('Error: only images are allowed');
        			// cancel upload
        			return false;				
        		}

        	},
        	onComplete : function(file){
        		$('#example2 .text').text('Uploaded ' + file);				
        	}		
        });
});/*]]>*/</script>
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
					<a href="#" id="button2">Subir foto</a>
				</div>
				<div class="column span-13 last">
					<div class="span-13 userCount">
						<div class="wellcome">Bienvenida <a href="#" class="wellcome">Marina_runner</a></div>
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
									<input type="Button" value="Guardar cambios" class="btn">
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
									<input type="Button" value="Regístrate ahora" class="btn btnblue right">
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
							<div class="column paddingRightContainer last mailAlert">
								<input type="Button" value="Activar alerta por email" class="btn">
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
					<div class="raceDetails" id="raceDetails">
						<div class="column span-1 first date">
							<div class="month">AGO</div>
							<div class="day">01</div>
						</div>
						<div class="column span-6 last nextRaceComment">
							<a href="#" class="nameRace">XII Carrera de la mujer</a>
							<div class="raceLocation">Madrid | 10km | <a href="#" class="runnersLink">22 van</a> </div>
						</div>
					</div>
					<div class="raceDetails" id="raceDetails">
						<div class="column span-1 first date">
							<div class="month">AGO</div>
							<div class="day">01</div>
						</div>
						<div class="column span-6 last nextRaceComment">
							<a href="#" class="nameRace">XVII Media Marathon de Madrid</a>
							<div class="raceLocation">Madrid | 10km | <a href="#" class="runnersLink">22 van</a> </div>
						</div>
					</div>
					<div class="raceDetails" id="raceDetails">
						<div class="column span-1 first date">
							<div class="month">AGO</div>
							<div class="day">01</div>
						</div>
						<div class="column span-6 last nextRaceComment">
							<a href="#" class="nameRace">XXVI Carrera del Rock’n’Roll</a>
							<div class="raceLocation">Madrid | 10km | <a href="#" class="runnersLink">22 van</a> </div>
						</div>
					</div>
					<div class="raceDetails" id="raceDetails">
						<div class="column span-1 first date">
							<div class="month">AGO</div>
							<div class="day">01</div>
						</div>
						<div class="column span-6 last nextRaceComment">
							<a href="#" class="nameRace">XV Cross popular “Ascenso a l...</a>
							<div class="raceLocation">Madrid | 10km | <a href="#" class="runnersLink">22 van</a> </div>
						</div>
					</div>
				</div>
			</div>
			<div class="column last span-7 pagination countAgo">
				<div class="column last span-2 pagination btnMargin">
					<div class="column first span-1 btnJoin"><input type="Button" value="<" class="btn"></div>
					<div class="column last span-1"><input type="Button" value=">" class="btn"></div>	
				</div>
				<div class="column first span-4 pagination">viendo del 1-4 de 21</div>			
			</div>
		</div>
	</div>
</div>

{include file="footer.tpl"} 
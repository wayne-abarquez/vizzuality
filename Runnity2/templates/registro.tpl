{include file="header.tpl"} 

<!-- GLOBAL CONTAINER RACE -->
	<div class="span-1 titleBoxRegister">
		<p>Regístrate en Runnity</p>
	</div>

	<div class="span-24 column content">
		<div class="span-1 last leftColumn">
			<div class="span-1 registerInfoTicket"><p>Para registrarte en runnity sólo tienes que rellenar los siguientes campos... <b>¡es grátis!</b></p></div>
		
			<div class="span-1 last leftRegister">
				<p>Email*</p>
				<label class="inputRegister" for="inputRegister"><span><input id="inputRegister1" type="text"></span></label>
			
				<p>Contraseña*</p>
				<label class="inputRegister" for="inputRegister"><span><input id="inputRegister2" type="text"></span></label>
				
				<p>Nombre de usuario*</p>
				<label class="inputRegister" for="inputRegister"><span><input id="inputRegister3" type="text"></span></label>
				
				<div class="nombreRegistro">
					<p >Nombre y apellidos*</p>
					<label class="inputRegister" for="inputRegister"><span><input id="inputRegister4" type="text"></span></label>
					
					<p>Sexo*</p>
					<select name="sexo" class="comboSexo">
	        			<option value="1">Hombre</option>
	        			<option value="2">Mujer</option>
	    			</select>
					
					<p>Fecha de nacimiento*</p>
					<select name="dia" class="comboFecha comboFechaFirst">
	        			<option value="1">Hombre</option>
	        			<option value="2">Mujer</option>
	    			</select>
	    			<select name="mes" class="comboFecha">
	        			<option value="1">Hombre</option>
	        			<option value="2">Mujer</option>
	    			</select>
	    			<select name="anio" class="comboFecha">
	        			<option value="1">Hombre</option>
	        			<option value="2">Mujer</option>
	    			</select>
	    			
	    			<div class="span-1 checkAlertas">
	    				<div class="span-1 last checkBoxAlerts"><input type="checkbox"></div>
	    				<div class="span-1 last checkTitle"><p class="checkTitle">Quiero recibir alertas con las próximas carreras cerca de mi</p></div>
	    			</div>
    			</div>
			</div>
			
			<div class="span-1 last rightRegister">
				<div class="pageUser"><p>Tu página será: <a href="#">http://www.runnity.com/users/...</a> </p></div>
				<div>
						<p class="titleMapAlert">Localidad,provincia*</p>
						<label class="roundLocalizacion last" for="roundLocalizacion">
							<input type="text" id="roundLocalizacion">
						</label>
						<label class="searchButtonFirst last">
							<input type="submit" value="Situar" class="buttonLocalizacion"/>
						</label>
					<div class="alertsMap"><img src="/img/alertsMap.jpg"></div>
				</div>
			</div>
				
			<div class="span-1 last TerminosCondicionesBox">
				<div class="span-12 first"><p >Al hacer click en “Registrarse” aceptas los <a href="#">Términos y condiciones</a> de runnity.com</p></div>
				<input class="fg-button buttonRegister" type="submit" value="Registrarse"/>
			</div>
			
			<div class="span-1 LoginEnRegistro"><p>¿Ya tienes una cuenta en runnity? <a href="javascript: void showLoginWindow()">Haz login</a></p></div>

		
		</div>
		
		<div class="span-1 last rightColumnRegister">
			<p class="titleRegisterRight">Crea tu cuenta en un par de minutos y así podrás...</p>
			<ul>
				<li></li>
				<li>· Recibir <b>alertas de carreras</b> en tu ciudad</li>
				<li>· Subir <b>fotos y videos</b> de carreras</li>
				<li>· <b>Compartir tus experiencias</b> en carreras</li>
				<li>· <b>Conocer</b> otros/as runners</li>
				<li>· <b>Comparar tus resultados</b> con los demás</li>
			</ul>
		</div>
	</div>
	
	</div>

{include file="footer.tpl"} 
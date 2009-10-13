{include file="header.tpl"} 

{*
{literal}
	<script type="text/javascript">
	$.validator.setDefaults({
		submitHandler: function() { alert("pues vale muchacho!!"); }
	});
	
	$().ready(function() {
		$("#register_form").validate({
			rules: {
				username_register: {
					required: true,
					minlength: 2
				},
				password_register: {
					required: true,
					minlength: 5
				},
				email_register: {
					required: true,
					email: true
				},
				name_register: {
					required: true,
					minlength: 5
				},
				localidad: {
					required: "#quiero:checked"
				},
				quiero: "required"
			},
			messages: {
				username_register: {
					required: "Introduce un usuario",
					minlength: "Al menos 5 caracteres"
				},
				password_register: {
					required: "Introduce una contraseña",
					minlength: "Al menos 5 caracteres"
				},
				email_register: {
					required: "Introduce una dirección de correo",
					email: "No es una dirección válida"
				},
				name_register: {
					required: "Introduce tu nombre",
					minlength: "Al menos 5 caracteres"
				},
				quiero: "Acepta nuestra política"
			}
		});
	});
</script>
{/literal}
*}



<!-- GLOBAL CONTAINER RACE -->
	<div class="span-1 titleBoxRegister">
		<p>Regístrate en Runnity</p>
	</div>

	<div class="span-24 column content">
		<div class="span-1 last leftColumn">
			<div class="span-1 registerInfoTicket"><p>Para registrarte en Runnity sólo tienes que rellenar los siguientes campos... <b>¡es grátis!</b></p></div>
			<form id="register_form" action="javascript: void registerUser()">
				<div class="span-1 last leftRegister">
					<p>Email*</p>
					<label class="inputRegister" for="inputRegister"><span><input id="inputRegister1" name="email_register" type="text"></span></label>
				
					<p>Contraseña*</p>
					<label class="inputRegister" for="inputRegister"><span><input id="inputRegister2" name="password_register" type="password"></span></label>
					
					<p>Nombre de usuario*</p>
					<label class="inputRegister" for="inputRegister"><span><input id="inputRegister3" name="username_register" type="text"></span></label>
					
					<div class="nombreRegistro">
						<p >Nombre y apellidos*</p>
						<label class="inputRegister" for="inputRegister"><span><input id="inputRegister4" name="name_register" type="text"></span></label>
						
						<p>Sexo*</p>
						<select name="sexo" class="comboSexo" id="combo_sex">
		        			<option value="1">Hombre</option>
		        			<option value="2">Mujer</option>
		    			</select>
						
						<p>Año de nacimiento*</p>
						<select name="dia" class="comboAnio comboFechaFirst" id="combo_anio">
		        			<option value="1">2009</option>
		        			<option value="2">2008</option>
		    			</select>
		    			
		    			<div class="span-1 checkAlertas">
		    				<div class="span-1 last checkBoxAlerts"><input type="checkbox" id="quiero"></div>
		    				<div class="span-1 last checkTitle"><p class="checkTitle">Quiero recibir alertas con las próximas carreras cerca de mi</p></div>
		    			</div>
	    			</div>
				</div>
				
				<div class="span-1 last rightRegister">
					<div class="pageUser"><p>Tu página será: <a>http://www.runnity.com/users/...</a> </p></div>
					<div>
							<p class="titleMapAlert">Localidad,provincia*</p>
							<label class="roundLocalizacion last" for="roundLocalizacion">
								<input type="text" id="roundLocalizacion" name="localidad">
							</label>
							<label class="searchButtonFirst last">
								<input type="submit" value="Situar" class="buttonLocalizacion"/>
							</label>
						<div class="alertsMap"><img src="/img/alertsMap.jpg"></div>
					</div>
				</div>
				<div class="error_register" id="error_register"></div>
				<div class="span-1 last TerminosCondicionesBox">
					<div class="span-12 first"><p>Al hacer click en “Registrarse” aceptas los <a href="/legalterms.html" target="_blank">Términos y condiciones</a> de runnity.com</p></div>
					<input class="fg-button buttonRegister" id="register_input" type="submit" value="Registrarse"/>
				</div>
				<div class="span-1 LoginEnRegistro"><p>¿Ya tienes una cuenta en runnity? <a href="javascript: void showLoginWindow()">Haz login</a></p></div>
			
			</form>
		
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
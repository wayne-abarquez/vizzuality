{include file="header.tpl"} 


{literal}
	<script type="text/javascript">
	$.validator.setDefaults({
		submitHandler: function() { 
			Alert('Esto va a registrarse!')
		 }
	});
	
	$().ready(function() {
		$("#register_form").validate({
			rules: {
				username_register: {
					required: true,
					minlength: 5
				},
				password_register: {
					required: true,
					minlength: 5
				},
				email_register: {
					required: true,
					email: true
				}
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
				}
			}
		});
		
    	$("#buttonLocalizacion").click(function() {
        	    var localidad=$("#roundLocalizacion").val();
        	    var url="http://maps.google.com/maps/api/staticmap?size=334x141&maptype=roadmap&markers=size:mid|color:red|"+localidad+",Spain&mobile=true&sensor=false&key=ABQIAAAAtDJGVn6RztUmxjnX5hMzjRT2yXp_ZAY8_ufC3CFXhHIE1NvwkxSPLBWm1r4y_v-I6fII4c2FT0yK6w";
        	    $("#map").attr("src",url);	        
    	});		
		
		
	});
	

	
</script>
{/literal}




<!-- GLOBAL CONTAINER RACE -->
	<div class="span-23 titleBoxRegister">
		<p>Regístrate en Runnity</p>
	</div>

	<div class="span-24 column content">
		<div class="span-17 last leftColumn">
		
			<!-- COLUMNA IZQ -->
			<div class="span-17 registerInfoTicket"><p>Para registrarte en Runnity sólo tienes que rellenar los siguientes campos... <b>¡es grátis!</b></p></div>
			{$php_errors}
			<form id="register_form" action="/registro" method="get">
			    <input type="hidden" name="lat" value="0">
			    <input type="hidden" name="lon" value="0">
			    
				<div class="span-17 last leftRegister">
					<div class="data_register_container">
						<p>Email</p>
						<label class="inputRegister" for="inputRegister"><span><input id="inputRegister1" name="email_register" type="text"></span></label>
					</div>
					
					<div class="data_register_container">
						<p>Contraseña</p>
						<label class="inputRegister" for="inputRegister"><span><input id="inputRegister2" name="password_register" type="password"></span></label>
					</div>
					
					<div class="data_register_container">
						<p>Nombre de usuario</p>
						<label class="inputRegister" for="inputRegister"><span><input id="inputRegister3" name="username_register" type="text" onchange="checkUsername()"></span>
							<span class="usernameCheck" id="checkUserBox">
	                            <img style='display:none' id="registerImage">
	                            <p id="answer"></p>
	                    	</span>
						</label>
					</div>
					
					<div class="pageUser"><p>Tu página será: <a>http://www.runnity.com/users/...</a> </p></div>
					
					
					<div class="nombreRegistro">
						<p >Nombre y apellidos</p>
						<label class="inputRegister" for="inputRegister"><span><input id="inputRegister4" name="name_register" type="text"></span></label>
						
						<p>Sexo</p>
						<select name="sexo" class="comboSexo" id="combo_sex">
		        			<option value="true">Hombre</option>
		        			<option value="false">Mujer</option>
		    			</select>
						
						<p>Fecha de nacimiento</p>
                        {html_select_date prefix='birthday' start_year='-55' month_format='%m' field_order='DMY' class='comboAnio comboFechaFirst'
                           end_year='-8' reverse_years=true}						
		    			
		    			<div class="span-1 checkAlertas">
		    				<div class="span-1 last checkBoxAlerts"><input type="checkbox" id="quiero" name="quiero" value="true"></div>
		    				<div class="span-1 last checkTitle"><p class="checkTitle">Quiero recibir alertas con las próximas carreras cerca de mi</p></div>
		    			</div>
	    			</div>
				</div>
				
				
				
				<div class="span-1 last rightRegister">
					<div>
							<p class="titleMapAlert">Localidad,provincia</p>
							<label class="roundLocalizacion last" for="roundLocalizacion">
								<input type="text" id="roundLocalizacion" name="localidad">
							</label>
							<label class="searchButtonFirst last">
								<input type="button" value="Situar" id="buttonLocalizacion" class="buttonLocalizacion"/>
							</label>
						<div class="alertsMap"><img id="map" src="http://maps.google.com/maps/api/staticmap?size=334x141&maptype=roadmap&center=Spain&mobile=true&sensor=false&key=ABQIAAAAtDJGVn6RztUmxjnX5hMzjRTy9E-TgLeuCHEEJunrcdV8Bjp5lBTu2Rw7F-koeV8TrxpLHZPXoYd2BA"></div>
					</div>
				</div>
				<div class="error_register" id="error_register"></div>
				<div class="span-1 last TerminosCondicionesBox">
					<div class="span-12 first"><p>Al hacer click en “Registrarse” aceptas los <a href="/legalterms.html" target="_blank">Términos y condiciones</a> de runnity.com</p></div>
					<input class="fg-button buttonRegister" id="register_input" type="submit" name="action" value="Registrarse"/>
				</div>
				<div class="span-1 LoginEnRegistro"><p>¿Ya tienes una cuenta en runnity? <a href="javascript: void showLoginWindow()">Haz login</a></p></div>
			
			</form>
		
		</div>
		
		<!-- COLUMNA DERECHA -->
		
		<div class="span-6 last rightColumnRegister">
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
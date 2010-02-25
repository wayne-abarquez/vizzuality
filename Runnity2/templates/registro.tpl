{include file="header.tpl"} 


{literal}

<script>
var RecaptchaOptions = {
   theme : 'white',
   lang : 'es'
};
</script>

	<script type="text/javascript">

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
				confirm_password: {
					required: true,
					minlength: 5,
					equalTo: "#inputRegister2"
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
					required: true
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
				confirm_password: {
					required: "Introduce la misma contraseña",
					minlength: "Al menos 5 caracteres",
					equalTo: "Debe ser igual a la contraseña"
				},
				email_register: {
					required: "Introduce una dirección de correo",
					email: "No es una dirección válida"
				},
				name_register: {
					required: "Introduce tu nombre",
					minlength: "Al menos 5 caracteres"
				},
				localidad: {
					required: "Introduce una localidad"
				}
			}
		});
		
    	$.validator.setDefaults({
    		submitHandler: function(form) { 
    			if (($('#answer').html()!='Buen nombre') || ($('#result').html()!='') || ($('#latHidden').val()==0) || ($('#lonHidden').val()==0) || ($('#error_geo').html()!='')) {
    				return false;
    			} else {
    				form.submit();
    			}
    		 }
    	});		
		
    	$("#buttonLocalizacion").click(function() {
            geolocateAddress("{/literal}{$smarty.const.GMAPS_KEY}{literal}");
    	});		
			
			$('#inputRegister1').bind("change keyup", function() {
				var valor = $('#result').html().length;
				var email = $("#inputRegister1").val();
				if ((email=='') || (email.length<5) || !(echeck(email))) {
					$('#emailImage').hide();
					$('#result').html('');
		 		}	
			});
			
			$('#inputRegister3').bind("change keyup", function() {
				var valor = $('#answer').html().length;
				var user = $("#inputRegister3").val();
				if ((user=='') || (user.length<5) ) {
					$('#registerImage').hide();
					$('#answer').html('');
		 		}	
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
			<form id="register_form"  method="post" action="/registro">
			    <input type="hidden" id="latHidden" name="lat" value="0">
			    <input type="hidden" id="lonHidden" name="lon" value="0">
			    
				<div class="span-17 last leftRegister">
					<div class="data_register_container">
						<p>Email</p>
						<input id="inputRegister1" class="inputRegister" name="email_register" type="text" onchange="checkEmail()"/>
						<span class="emailCheck" id="checkEmailBox">
                            <img style='display:none' id="emailImage">
                            <p id="result"></p>
                    	</span>
					</div>
					
					<div class="data_register_container">
						<p>Contraseña</p>
						<input id="inputRegister2" class="inputRegister" name="password_register" type="password"/>
					</div>
					
					<div class="data_register_container">
						<p>Confirmar contraseña</p>
						<input id="inputRegister5" class="inputRegister" name="confirm_password" type="password"/>
					</div>
					
					<div class="data_register_container">
						<p>Nombre de usuario</p>
						<input id="inputRegister3" class="inputRegister" name="username_register" type="text" onchange="checkUsername()"/>
						<span class="usernameCheck" id="checkUserBox">
                            <img style='display:none' id="registerImage">
                            <p id="answer"></p>
                    	</span>
					</div>
				</div>						
					
				<div class="span-16">
					<div class="span-6 first column nombreRegistro">
						<div class="register_name_column">
							<p>Nombre y apellidos</p>
							<input id="inputRegister4" name="name_register" type="text" class="inputRegister"/>
						</div>
						<div class="register_name_column">
							<p>Sexo</p>
							<select name="sexo" class="comboSexo" id="combo_sex">
		        				<option value="true">Hombre</option>
		        				<option value="false">Mujer</option>
		    				</select>
						</div>
						
						<div class="register_name_column">
							<p>Fecha de nacimiento</p>
		                    {html_select_date prefix='birthday' start_year='-55' month_format='%m' field_order='DMY' class='comboAnio'
		                       end_year='-8' reverse_years=true}					
			    			
			    			<div class="span-1 checkAlertas">
			    				<div class="span-1 checkBoxAlerts"><input type="checkbox" id="quiero" name="quiero" value="true"/></div>
			    				<div class="span-1 last checkTitle"><p class="checkTitle">Quiero recibir alertas con las próximas carreras cerca de mi</p></div>
			    			</div>
		    			</div>
		    			<br><br><br><br>
		    			<div class="register_name_column">
		    			    <p>Eres un robot?</p>
		    			    {$recaptcha}
		    			    
		    			</div>
		    		</div>
	    			<div class="span-1 column last rightRegister">
						<div>
							<p class="titleMapAlert">Localidad,provincia</p>
							<div>
								<input type="text" id="roundLocalizacion" name="localidad" class="inputRegister"/>
							</div>
							<div class="searchButtonFirst last">
								<input type="button" value="Situar" id="buttonLocalizacion" class="buttonLocalizacion"/>
							</div>
							<div id="error_geo"></div>
							<div class="alertsMap"><img id="map" src="http://maps.google.com/maps/api/staticmap?size=334x141&maptype=roadmap&center=Spain&mobile=true&sensor=false&key={$smarty.const.GMAPS_KEY}"></div>
						</div>
					</div>
				</div>
				
				
				
				
				
				<div class="error_register" id="error_register"></div>
				<div class="span-1 last TerminosCondicionesBox">
					<div class="span-12 first"><p>Al hacer click en “Registrarse” aceptas los <a href="/legalterms.html" target="_blank">Términos y condiciones</a> de runnity.com</p></div>
					<div class="registerButtonContainer"><input class="registerUserButton" id="register_input" type="submit" name="action" value="Registrarse"/></div>
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
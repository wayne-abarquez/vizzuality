{include file="header.tpl"} 

<!-- GLOBAL CONTAINER RACE -->
	<div class="span-1 titleBoxRegister">
		<p>Regístrate en Runnity</p>
	</div>

	<div class="span-24 column content">
		<div class="span-1 last leftColumn">
			<div class="span-1 registerInfoTicket"><p>Para registrarte en Runnity sólo tienes que rellenar los siguientes campos... <b>¡es grátis!</b></p></div>
			<form id="register_form" action="">
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
						<select name="dia" class="comboDia comboFechaFirst">
		        			<option value="1">1</option>
		        			<option value="2">2</option>
		        			<option value="3">3</option>
		        			<option value="4">4</option>
		        			<option value="5">5</option>
		        			<option value="6">6</option>
		        			<option value="7">7</option>
		        			<option value="8">8</option>
		        			<option value="9">9</option>
		        			<option value="10">10</option>
		        			<option value="11">11</option>
		        			<option value="12">12</option>
		        			<option value="13">13</option>
		        			<option value="14">14</option>
		        			<option value="15">15</option>
		        			<option value="16">16</option>
		        			<option value="17">17</option>
		        			<option value="18">18</option>
		        			<option value="19">19</option>
		        			<option value="20">20</option>
		        			<option value="21">21</option>
		        			<option value="22">22</option>
		        			<option value="23">23</option>
		        			<option value="24">24</option>
		        			<option value="25">25</option>
		        			<option value="26">26</option>
		        			<option value="27">27</option>
		        			<option value="28">28</option>
		        			<option value="29">29</option>
		        			<option value="30">30</option>
		        			<option value="31">31</option>
		    			</select>
		    			<select name="mes" class="comboMes">
		        			<option value="1">Enero</option>
		        			<option value="2">Febrero</option>
		        			<option value="3">Marzo</option>
		        			<option value="4">Abril</option>
		        			<option value="5">Mayo</option>
		        			<option value="6">Junio</option>
		        			<option value="7">Julio</option>
		        			<option value="8">Agosto</option>
		        			<option value="9">Septiembre</option>
		        			<option value="10">Octubre</option>
		        			<option value="11">Noviembre</option>
		        			<option value="12">Diciembre</option>
		    			</select>
		    			<select name="anio" class="comboAnio">
		        			<option value="1">2009</option>
		        			<option value="2">2008</option>
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
					<div class="span-12 first"><p>Al hacer click en “Registrarse” aceptas los <a href="/legalterms.html" target="_blank">Términos y condiciones</a> de runnity.com</p></div>
					<input class="fg-button buttonRegister" type="submit" value="Registrarse"/>
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
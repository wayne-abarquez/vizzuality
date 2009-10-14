{include file="header.tpl"}

$('$this').val("");

<div class="span-24 column content">

	<div class="span-1 last leftColumn">
<div class="span-1 columnNameUser"><p class="nameUserProfile">{$privateData.datos.completename} <span class="nameUserProfileNick">({$privateData.datos.username})</span></div><a class="dashboardLink" href="/perfil/{$smarty.session.user.username}">volver a tu dashboard <img src="/img/arrowDash.gif"></a>

		<div class="globalContainerUser">	
			<div class="span-1 last userData">
				<div class="span-1 avatarPerfil">
					<img class="imgAvatarPerfil" src="/img/AvatarPerfil.jpg">
				</div>
				<div class="span-1 last functionalContainer">
				<p class="titulo tituloLeft">ESTADÍSTICAS</p>
					<div class="span-1 last dataContainerUser">
						<div class="span-1 last dataTitleUser"><p>Visitas a tu perfil: </p></div>
						<div class="span-1 last dataUser"><p><b>{$privateData.datos.visits_profile}</b></p></div>
					</div>
					<div class="span-1 last dataContainerUser">
						<div class="span-1 last dataTitleUser"><p>Carreras corridas:</p></div>
						<div class="span-1 last dataUser"><p><b>{$privateData.datos.num_races_runned}</b></p></div>
					</div>
				</div>
			</div>
						
			<div class="span-1 last dataUserEdit">
				<p class="titulo tituloLeft tituloRight">DATOS PERSONALES</p>
				<div class="editdata">
					<div class="nameEdit">
						<p class="data">NOMBRE Y APELLIDOS</p>
						<label class="roundInputName last" for="roundInputName">
							<input type="text" id="roundInputName" value="{$privateData.datos.completename}">
						</label>
					</div>
					<div class="sexoFecha">
						<div class="span-1 first sexoEdit">
							<p class="data">SEXO</p>
							<select name="sexo" id="combo_sex">
								{if $privateData.datos.is_men eq TRUE}
								<option selected value="true">Hombre</option>
			        			<option value="false">Mujer</option>
			        			{else}
			        			<option selected value="false">Mujer</option>
			        			<option value="true">Hombre</option>
			        			{/if}
			    			</select>
						</div>
						<div class="span-1 last fechaEdit">
							<p class="data">FECHA NACIMIENTO</p>
							{html_select_date time='$privateData.datos.birthday' start_year='-55' month_format='%m' field_order='DMY' end_year='-8' reverse_years=true}
						</div>
					</div>
					<div class="localizacionEdit">
						<p class="data">LOCALIZACIÓN</p>
						<label class="roundInputDataLong last" for="roundInputDataLong">
							<input type="text" id="roundInputDataLong" value="{$privateData.datos.locality}">
						</label>
					</div>
					<div class="checkAlerts"><input type="checkbox"><span>RECIBIR ALERTAS | ZONAS INTERÉS</span></div>
					<div>
						<div class="span-1 first mapaAlerts">
							<img src="/img/mapaAlerts.jpg">
						</div>
						<div class="span-1 last editRadio">
							<p class="data">RADIO DE BÚSQUEDA</p>
							<label class="roundInputDataRadio" for="roundInputDataRadio">
								<input type="text" id="roundInputDataRadio"><span>(Km)</span>
							</label>
							<p class="data">Las alertas se enviarán semanalmente a tu dirección de email</p>
						
						</div>
					</div>
				</div>
				<div class="dataUserButtons">
					<span><input class="fg-button saveChangesButton" type="button" value="Guardar cambios"/></span>
				</div>
				
				<p class="titulo tituloLeft tituloRight">TUS MARCAS</p>
				<div class="editmarcas">
					<div class="span-1 first distanceName">
						<p class="data">DISTANCIA</p>
						{foreach key=id item=record from=$records}
							<p>{$record.distance_name}</p>
						{/foreach}
					</div>
					<div class="span-1 last recordsContainer">
						<p class="data">HH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;MM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;SS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CENTS</p>
						{foreach key=id item=record from=$records}
						<div class="span-1">
							<label class="roundInputRecords last" for="roundInputRecords">
								<input type="text" id="roundInputRecordsHH{$record.id}" value="{$record.time_taken|substr:0:2}">
							</label><span class="separatorInput">:</span>
						</div>
						<div class="span-1">
							<label class="roundInputRecords last" for="roundInputRecords">
								<input type="text" id="roundInputRecordsMM{$record.id}" value="{$record.time_taken|substr:3:2}">
							</label><span class="separatorInput">:</span>
						</div>
						<div class="span-1">
							<label class="roundInputRecords last" for="roundInputRecords">
								<input type="text" id="roundInputRecordsSS{$record.id}" value="{$record.time_taken|substr:6:2}">
							</label><span class="separatorInput">:</span>
						</div>
						<div class="span-1">
							<label class="roundInputRecords last" for="roundInputRecords">
								<input type="text" id="roundInputRecordsDD{$record.id}" value="{$record.time_taken|substr:9:2}">
							</label><span class="separatorInput"><input type="button" class="fg-button eraseRecordButton" value="x" onclick="javascript: void borrar(roundInputRecordsHH{$record.id},roundInputRecordsMM{$record.id},roundInputRecordsSS{$record.id},roundInputRecordsDD{$record.id})"></span>
						</div>					
						{/foreach}
					</div>
				</div>
				<div class="dataUserButtons">
					<span><input class="fg-button saveChangesButton" type="button" value="Guardar cambios"/></span>
				</div>
				
				<p class="titulo tituloLeft tituloRight">DATOS DE CUENTA</p>
				<div class="editAcount">
					<div class="span-1 editEmail first">
						<p class="data">EMAIL</p>
						<label class="roundInputName last" for="roundInputName">
							<input type="text" id="roundInputName" value="{$privateData.datos.email}">
						</label>
					</div>
					<div class="span-1 editPass last">
						<p class="data">PASSWORD</p>
						<label class="roundInputDataSmall last" for="roundInputDataSmall">
							<input type="password" id="roundInputDataSmall" value="{$privateData.datos.pass}">
						</label>
					</div>
				</div>
				<div class="dataUserButtons">
					<span><input class="fg-button saveChangesButton" type="button" value="Guardar cambios"/></span>
				</div>

			</div>			
		</div>
	</div>
	

	<!-- RIGHT COLUMN -->
	<div class="span-1 last rightColumn userRightColumn">
		{if $nextRaces}
		<div class="span-1 functionalContainer">
			<p class="titulo tituloLeft tituloColumnRight">TUS PRÓXIMAS CARRERAS</p>
			<div class="events">
				{foreach key=id item=race from=$nextRaces name=raceloop}	    				    
					<div class="span-1 {cycle values="raceRight,raceRight2"}">
						<div class="span-1 first dateRight calendarRight">
					        <div class="month month{$race.run_type}">{getMonth month=$race.event_date|substr:5:2}</div>
							<div class="day">{$race.event_date|substr:8:2}</div>
						</div>
						{if $race.num_users > 0}
							<div class="ticketBlue"><p>{$race.num_users}</p></div>
							<div class="ticketBlueCorner ticketBlueCornerRight"></div>
						{/if}		
						<div class="span-1 last dataRaceRight">
							<div class="nameRaceRight"><a id="nameRunRight1{$smarty.foreach.raceloop.iteration}" href="/run/{$race.id}/{$race.name|replace:' ':'/'}">{$race.name}</a></div>
							<div class="dataRaceRight"><p>{$race.event_location} | {$race.distance_text}</p></div>
						</div>	
					</div>
					<div class="span-1 last separatorRight"></div>
			    {/foreach}					
			</div>
		</div>
		{/if}
		
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
					<a href="/user/{$smarty.session.user.username}"><img title="{$smarty.session.user.username}" class="avatarRight" src="/avatar.php?id={$smarty.session.user.user_id}"/></a>	
				</div>
			</div>
		</div>
						
	</div>

</div> <!-- content -->

</div> <!-- container -->

{include file="footer.tpl"} 
{include file="header.tpl"}

<div class="span-24 column content">

	<div class="span-1 last leftColumn">
		
<div class="span-1 columnNameUser"><p class="nameUserProfile">{$smarty.session.user.completename} <span class="nameUserProfileNick">({$smarty.session.user.username})</span></div>
		<div class="globalContainerUser">	
			<div class="span-1 last userData">
				<div class="span-1 avatarPerfil">
					<img class="imgAvatarPerfil" src="/img/AvatarPerfil.jpg">
				</div>
				<div class="span-1 last functionalContainer">
				<p class="titulo tituloLeft">ESTADÍSTICAS</p>
					<div class="span-1 last dataContainerUser">
						<div class="span-1 last dataTitleUser"><p>Visitas a tu perfil:</p></div>
						<div class="span-1 last dataUser"><p><b>1142</b></p></div>
					</div>
					<div class="span-1 last dataContainerUser">
						<div class="span-1 last dataTitleUser"><p>Carreras corridas:</p></div>
						<div class="span-1 last dataUser"><p><b>23</b></p></div>
					</div>
				</div>
			</div>
						
			<div class="span-1 last dataUserEdit">
				<p class="titulo tituloLeft tituloRight">DATOS PERSONALES</p>
				<div class="editdata">
					<div class="span-1 nameEdit first">
						<p class="data">NOMBRE Y APELLIDOS</p>
						<label class="roundInputName last" for="roundInputName">
							<input type="text" id="roundInputName">
						</label>
					</div>
					<div class="span-1 anioEdit last">
						<p class="data">AÑO NACIMIENTO</p>
						<label class="roundInputDataSmall last" for="roundInputDataSmall">
							<input type="text" id="roundInputDataSmall">
						</label>
					</div>
					<div class="span-10 localizacionEdit last">
						<p class="data">LOCALIZACIÓN</p>
						<label class="roundInputDataLong last" for="roundInputDataLong">
							<input type="text" id="roundInputDataLong">
						</label>
					</div>
					<input type="checkbox"><span>RECIBIR ALERTAS | ZONAS INTERÉS </span>
					<div class="mapaAlerts">
						<img src="/img/mapaAlerts.jpg">
					</div>

				</div>
				<div class="dataUserButtons">
					<span><input class="fg-button saveChangesButton" type="button" value="Guardar cambios"/></span>
				</div>
				
				<p class="titulo tituloLeft tituloRight">TUS MARCAS</p>
				<div class="editmarcas">
					<div class="span-1 first distanceName">
						{foreach key=id item=record from=$records}
							<p>{$record.distance_name}</p>
						{/foreach}
					</div>
					<div class="span-1 last recordsContainer">
						{foreach key=id item=record from=$records}
						<div class="span-1">
							<label class="roundInputRecords last" for="roundInputRecords">
								<input type="text" id="roundInputRecords">
							</label>
						</div>
						<div class="span-1">
							<label class="roundInputRecords last" for="roundInputRecords">
								<input type="text" id="roundInputRecords">
							</label>
						</div>
						<div class="span-1">
							<label class="roundInputRecords last" for="roundInputRecords">
								<input type="text" id="roundInputRecords">
							</label>
						</div>
						<div class="span-1">
							<label class="roundInputRecords last" for="roundInputRecords">
								<input type="text" id="roundInputRecords">
							</label>
						</div>					
						{/foreach}
					</div>
				</div>
				
				<p class="titulo tituloLeft tituloRight">DATOS DE CUENTA</p>
				<div class="editAcount">
					<div class="span-1 nameEdit first">
						<p class="data">EMAIL</p>
						<label class="roundInputName last" for="roundInputName">
							<input type="text" id="roundInputName">
						</label>
					</div>
					<div class="span-1 anioEdit last">
						<p class="data">PASSWORD</p>
						<label class="roundInputDataSmall last" for="roundInputDataSmall">
							<input type="text" id="roundInputDataSmall">
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
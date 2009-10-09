{include file="header.tpl"}

<div class="span-24 column content">

	<div class="span-1 last leftColumn">
		
<div class="span-1 columnNameUser"><p class="nameUserProfile">Fernando Morales Roselló</p><p class="nameUserProfileNick">(Pumares)</p></div>
		<div class="globalContainerUser">	
			<div class="span-1 last userData">
				<div class="span-1 avatarPerfil">
					<img class="imgAvatarPerfil" src="/img/AvatarPerfil.jpg">
				</div>
				<div class="span-1 last functionalContainer">
				<p class="titulo tituloLeft">ESTADÍSTICAS</p>
					<div class="span-1 last dataContainerUser">
						<div class="span-1 last dataTitleUser"><p>Visitas a tu perfil</p></div>
						<div class="span-1 last dataUser"><p><b>1142</b></p></div>
					</div>
					<div class="span-1 last dataContainerUser">
						<div class="span-1 last dataTitleUser"><p>Carreras corridas</p></div>
						<div class="span-1 last dataUser"><p><b>23</b></p></div>
					</div>
				</div>
				<div class="span-1 last functionalContainer">
				<p class="titulo tituloLeft">TU RANKING RUNNITY</p>
					<div class="span-1 last dataContainerUser">
						<div class="span-1 last dataTitleUser"><p>Visitas a tu perfil</p></div>
						<div class="span-1 last dataUser"><p><b>1142</b></p></div>
					</div>
					<div class="span-1 last dataContainerUser">
						<div class="span-1 last dataTitleUser"><p>Carreras corridas</p></div>
						<div class="span-1 last dataUser"><p><b>23</b></p></div>
					</div>
					<div class="span-1 last dataContainerUser">
						<div class="span-1 last dataTitleUser"><p>Carreras corridas</p></div>
						<div class="span-1 last dataUser"><p><b>23</b></p></div>
					</div>
				</div>
				<div class="span-1 last functionalContainer">
				<p class="titulo tituloLeft">DATOS PERSONALES</p>
					<div class="span-1 last dataContainerUser">
						<div class="span-1 last dataTitleUser"><p>Email</p></div>
						<div class="span-1 last dataUser"><p><b>a.rodriguez@gmail.com</b></p></div>
					</div>
					<div class="span-1 last dataContainerUser">
						<div class="span-1 last dataTitleUser"><p>Club</p></div>
						<div class="span-1 last dataUser"><p><b>S.S. de los Reyes - Clínicas Menorca</b></p></div>
					</div>
					<div class="span-1 last dataContainerUser">
						<div class="span-1 last dataTitleUser"><p>Categoría</p></div>
						<div class="span-1 last dataUser"><p><b>Senior Masculino</b></p></div>
					</div>
				</div>
			</div>
			
			<div class="span-1 last userAlerts">
				<div class="alertUser"><p>Aún no nos has dicho si <b>perteneces a algún club</b></p></div>
				<div class="alertUser"><p>Tienes <b>2 mensajes nuevos</b></p></div>
			</div>
			
			<div class="span-1 last imagesUserContainer">
				<p class="titulo tituloLeft tituloRight">TUS FOTOS [42]</p>
				<div class="span-1 imagesUser">
					<img src="/img/avatar.jpg"/>	
				</div>
				<div class="span-1 imagesUser">
					<img src="/img/avatar.jpg"/>	
				</div>
				<div class="span-1 imagesUser">
					<img src="/img/avatar.jpg"/>	
				</div>
			</div>
			
			<div class="span-1 last commentsUser">
				<p class="titulo tituloLeft tituloRight">MENSAJES PARA TI [13]</p>
			</div>

		</div>
	</div>
	

	<!-- RIGHT COLUMN -->
	<div class="span-1 last rightColumn">
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
	</div>

</div> <!-- content -->

</div> <!-- container -->

{include file="footer.tpl"} 
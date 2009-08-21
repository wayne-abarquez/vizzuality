{include file="header.tpl"} 

<!-- IMPORTANT RACE AND NEXT RACES -->
	<div class="span-24 raceContainer" id="race">
		
		<div class="column span-16 first vipRace">
			<div class="raceHome">
				<div class="contentImportantRace">
					<div class="span-3 dateImpRace">{$highlightedRun.event_date|substr:8:2}/{getMonth month=$highlightedRun.event_date|substr:5:2}/{$highlightedRun.event_date|substr:2:2}</div>
					<div class="span-15 titleImpRace">{$highlightedRun.name}</div>
				<div class="span-15 dataImpRace">{$highlightedRun.event_location} | {$highlightedRun.distance_text} | {$highlightedRun.num_users} usuarios van </div>
				</div>
				
			</div>
		</div>
		
		<div class="column span-8 last importantRaces">
			<div class="events"> 
				<h2 class="newsTitle">Tus próximas carreras</h2>
			</div>
			<div class="events">
				{foreach key=id item=race from=$nextRaces}
			       <div class="raceDetails">
						<div class="column span-1 first date">
							<div class="month">{getMonth month=$race.event_date|substr:5:2}</div>
							<div class="day">{$race.event_date|substr:8:2}</div>
						</div>
						<div class="column span-6 last nextRaceComment">
							<a href="carrera.php" class="nameRace">{$race.name}</a>
							<div class="raceLocation">{$race.event_location} | {$race.distance_text} | <b>{$race.num_users} van</b> </div>
						</div>
					</div>
			    {foreachelse}
			        <div class="raceDetails">No hay carreras disponibles.</div>    
			    {/foreach}
				<input type="Button" value="Ver tu calendario completo" class="btn right" />
			</div>
		</div>
	</div>
		
		
	<!-- MORE RACES -->
	<div class="column first span-16 moreRaces">
		<div> 
			<div>
				<h2 class="column span-16 first newsTitle">
					<div class="first span-11">
						<div class="column first">Más carreras en</div>
						<div id="containerStates" class="column last">
							<form class="form" method="get" action="">
								<input type="text" disabled="" class="fauxselect s4 state" id="category" value="Madrid" name="category"/>
								<select id="select" class="s4 hidden" onchange="javascript:updateField('category',this);" name="cat">
									<option selected="selected" value="">Madrid</option>
									<option value="">Murcia</option>
									<option value="">Ciudad Real</option>
									<option value="">Valencia</option>
									<option value="">Barcelona</option>
									<option value="">Lerida</option>
									<option value="">Tarragona</option>
									<option value="">Gerona</option>
								</select>
							</form>
						</div>
					</div>
					<div class=" last span-5 feed">
						<div class="column fisrt span-4 feedText">suscríbete</div>
						<div class="column span-1 imgFeed last">
							<a href="#"><img src="/img/feed.jpg" alt="Feed"/></a>
						</div>
					</div>
				</h2>
			</div>		
		</div>
		
		<div class="column span-8 first races">
			<div class="column first image">
				<img src="img/raceExample.jpg" alt="exampleImage"/>	
			</div>
			<div class="column span-5 last">
				<div class="nameRaceContainer"><a class="nameRace" href="carrera.php">XVII Carrera solidaria BBVA adsfasdfsadfasdfasdfsd</a></div>
				<div class="raceDateDetails">
					<div class="raceDetailsStyle"> <b>21/Ago/09</b> | Madrid | 5km - 10km</div>
					<p class="runnersNumber">2 van</p>
				</div>
			</div>
		</div>	
	
		<div class="column span-8 last races">
			<div class="column first image">
				<img src="img/raceExample.jpg" alt="exampleImage"/>	
			</div>
			<div class="column span-5 last">
				<div class="nameRaceContainer"><a class="nameRace" href="carrera.php">XVII Carrera solidaria BBVA adsfasdfsadfasdfasdfsd</a></div>
				<div class="raceDateDetails">
					<div class="raceDetailsStyle"> <b>21/Ago/09</b> | Madrid | 5km - 10km</div>
					<p class="runnersNumber">2 van</p>
				</div>
			</div>
		</div>
		
		<div class="column span-8 first races">
			<div class="column first image">
				<img src="img/raceExample.jpg" alt="exampleImage"/>	
			</div>
			<div class="column span-5 last">
				<div class="nameRaceContainer"><a class="nameRace" href="carrera.php">XVII Carrera solidaria BBVA adsfasdfsadfasdfasdfsd</a></div>
				<div class="raceDateDetails">
					<div class="raceDetailsStyle"> <b>21/Ago/09</b> | Madrid | 5km - 10km</div>
					<p class="runnersNumber">2 van</p>
				</div>
			</div>
		</div>
		
		<div class="column span-8 last races">
			<div class="column first image">
				<img src="img/raceExample.jpg" alt="exampleImage"/>	
			</div>
			<div class="column span-5 last">
				<div class="nameRaceContainer"><a class="nameRace" href="carrera.php">XVII Carrera solidaria BBVA adsfasdfsadfasdfasdfsd</a></div>
				<div class="raceDateDetails">
					<div class="raceDetailsStyle"> <b>21/Ago/09</b> | Madrid | 5km - 10km</div>
					<p class="runnersNumber">2 van</p>
				</div>
			</div>
		</div>
		
		<div class="column span-8 first races">
			<div class="column first image">
				<img src="img/raceExample.jpg" alt="exampleImage"/>	
			</div>
			<div class="column span-5 last">
				<div class="nameRaceContainer"><a class="nameRace" href="carrera.php">XVII Carrera solidaria BBVA adsfasdfsadfasdfasdfsd</a></div>
				<div class="raceDateDetails">
					<div class="raceDetailsStyle"> <b>21/Ago/09</b> | Madrid | 5km - 10km</div>
					<p class="runnersNumber">2 van</p>
				</div>
			</div>
		</div>
		
		<div class="column span-8 last races">
			<div class="column first image">
				<img src="img/raceExample.jpg" alt="exampleImage"/>	
			</div>
			<div class="column span-5 last">
				<div class="nameRaceContainer"><a class="nameRace" href="carrera.php">XVII Carrera solidaria BBVA adsfasdfsadfasdfasdfsd</a></div>
				<div class="raceDateDetails">
					<div class="raceDetailsStyle"> <b>21/Ago/09</b> | Madrid | 5km - 10km</div>
					<p class="runnersNumber">2 van</p>
				</div>
			</div>
		</div>			
	</div>
	
	
	<!-- USERS -->	
	<div class="column last span-8 moreRaces">
		<div> 
			<h2 class="newsTitle">Últimos valientes</h2>
		</div>
			{foreach key=id item=person from=$runners}
				{if $person eq "false"}
					<div class="span-8 races">No hay valientes.</div> 
				{else}
					<div class="span-8 races">
						<div class="column first image">
							<img src="img/user.jpg" alt="userImage"/>	
						</div>
						<div class="column span-5 last">
							<div class="detailsUser">
								<div class="nameUser"><a class="nameRace" href="#">{$person.username}</a></div>
								<div class="raceUserDetails"> dice que va a ir a </div>
								<div class="raceUserDetails"> <b>{$person.run_name}</b> </div>
							</div>
							<p class="runnersNumber">{$person.num_participants} van, <a href="">apúntate con él</a></p>
						</div>
					</div>
				{/if}
		    {foreachelse}
		        <div class="span-8 races">No hay valientes.</div>    
		    {/foreach}
		</div>
		
		
	<!-- PROMINENT -->
	<div class="span-24 prominent">
		
		<div class="column span-8 first">
			<div class="titleImportant">AL FÍN UN MODO DE VER CON DETALLE LOS RECORRIDOS DE LAS CARRERAS MEDIANTE GOOGLE MAPS</div>
			<div class="contentImportant">Además podrás comentar las distintas pruebas y conocer las opiniones de los demás.</div>
			<div class="buttonImportant"><input type="Button" value="Mira la carrera destacada" class="left" ></div>
		</div>
		
		
		<div class="column span-8">
			<div class="titleImportant">CREA Y COMPARTE TU PROPIO CALENDARIO DE CARRERAS. ES GRATIS, FÁCIL Y RÁPIDO</div>
			<div class="contentImportant">Así, podrás saber si van tus compañeros de rodaje, aquel que te pasó en el último sprint o el que siempre lo gana todo.</div>
			<div class="buttonImportant"><input type="Button" value="Regístrate ahora" class=" left" onclick="showRegisterBox()"></div>
		</div>
		
		<div class="column span-8 last">
			<div class="titleImportant">¿CONOCES ALGUNA CARRERA QUE NO ESTÁ EN RUNNY? ENTONCES DINOSLO!</div>
			<div class="contentImportant">Entre todos conseguiremos crear la mejor red de carreras nacionales y disfrutar aún más del mundo del running.</div>
			<div class="buttonImportant"><input type="Button" value="Ayudanos con tu carrera" class=" left" onclick="showContactBox()"></div>
		</div>
	</div>

	<!-- SOCIAL LINKS -->
	<div class="span-24 socialLinks">	
		<div class="column span-16 first">
			<div> 
				<h2 class="newsTitle">Síguenos en...</h2>
			</div>
			<div class="column span-3 first">
				<a href="#">
					<img src="/img/tuenti.jpg" alt="socialNetworks"/>
				</a>
			</div>
			<div class="column span-3">
				<a href="#">
					<img src="/img/facebook.jpg" alt="socialNetworks"/>
				</a>
			</div>
			<div class="column span-4 last">
				<a href="#">
					<img src="/img/twitter.jpg" alt="socialNetworks"/>
				</a>
			</div>
			<div class="column span-3 last">
				<a href="#">
					<img src="/img/flickr.jpg" alt="socialNetworks"/>
				</a>
			</div>
		</div>
		<div class="column span-8 last">
			<div> 
				<h2 class="newsTitle">Lo último en twitter</h2>
			</div>
			<div class="twitterContent">
				<div class="column span-2 first">
					<img id="profile">
				</div>
				<div class="column span-6 tweet last" id="tweets">					
				</div>
			</div>
		</div>
	</div>
	
</div>

{include file="footer.tpl"} 
{include file="header.tpl"}

<div class="span-24 column content">

	<div class="span-1 last leftColumn">
		
		<div class="carrera_principal">
		    <p class="nameUser" id="nameUser">Fernando Morales Roselló</p>
			
			<div class="span-1 last raceData">
				<div class="avatarPerfil">
					<img class="imgAvatarPerfil" src="/img/AvatarPerfil.jpg">
				</div>
				<div class="span-1 last functionalContainer">
					<p class="titulo tituloLeft">ESTADÍSTICAS</p>
				</div>
			</div>
			<div class="span-1 last raceDescription">
				<div class="span-1 last functionalContainer">
					<p class="titulo tituloLeft tituloRight">TUS FOTOS</p>
				</div>
			</div>
		</div>
	</div>
	

	<!-- RIGHT COLUMN -->
	<div class="span-1 last rightColumn">
		<div class="span-1 functionalContainer">
			<p class="titulo tituloLeft tituloColumnRight">LOCALIZACIÓN</p>
			<div id="map" class="mapStyleRight">
	            <object id="aroundMap" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="254" height="192" wmode="opaque" flashvars="id={$data.id}">
	              <param name="movie" value="/flash/RunAroundMap.swf?7" />
	              <!--[if !IE]>-->
	              <object type="application/x-shockwave-flash" data="/flash/RunAroundMap.swf?7" width="254" height="192" wmode="opaque" flashvars="id={$data.id}">
	              <!--<![endif]-->
					    {if $data.start_point_lat === null}
<img width="254" height="192" src="http://maps.google.com/maps/api/staticmap?size=254x192&maptype=map&zoom=10&center={$data.event_location},spain&sensor=false&key=ABQIAAAAtDJGVn6RztUmxjnX5hMzjRTy9E-TgLeuCHEEJunrcdV8Bjp5lBTu2Rw7F-koeV8TrxpLHZPXoYd2BA" />					    
					    {else}
					<img src="http://maps.google.com/staticmap?size=254x192&maptype=map&zoom=10&markers={if $data.end_point_lat}{$data.end_point_lat},{$data.end_point_lon},bluem%7C{/if}{$data.start_point_lat},{$data.start_point_lon},greens&sensor=false&key=ABQIAAAAtDJGVn6RztUmxjnX5hMzjRTy9E-TgLeuCHEEJunrcdV8Bjp5lBTu2Rw7F-koeV8TrxpLHZPXoYd2BA">
					    {/if}
	              <!--[if !IE]>-->
	              </object>
	              <!--<![endif]-->
	            </object>						
			</div>
		</div>
		
		<div class="span-1 functionalContainer">
		{if $runsInSameDates}
		<p class="titulo tituloLeft tituloColumnRight">EN LAS MISMAS FECHAS</p>
		<div class="events">
			{foreach key=id item=race from=$runsInSameDates name=raceloop}	    				    
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
		{/if}
		</div>
		
		<div class="span-1 functionalContainer">
		{if $runsInSameDates}
		<p class="titulo tituloLeft tituloColumnRight">DE DISTANCIA PARECIDA</p>
		<div class="events">
			{foreach key=id item=race from=$similarTypeRaces name=raceloop}	    				    
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
						<div class="nameRaceRight"><a id="nameRunRight2{$smarty.foreach.raceloop.iteration}" href="/run/{$race.id}/{$race.name|replace:' ':'/'}">{$race.name}</a></div>
						<div class="dataRaceRight"><p>{$race.event_location} | {$race.distance_text}</p></div>
					</div>	
				</div>
				<div class="span-1 last separatorRight"></div>
		    {/foreach}					
		</div>
		{/if}
		</div>

				
		<div class="span-1 functionalContainer">		
		<p class="titulo tituloLeft tituloColumnRight">USUARIOS APUNTADOS</p>
		<div class="eventsUsers">
		{foreach key=id item=person from=$runners}
				{if $person eq 'f'}
					<!--
<div class="span-8 races2">
						<p class="noApuntado">Aun no hay ningún valiente</p>
						<p class="noRaceSub">¿Quieres ser el primero? <b><a href="/rss">Apúntate</a></b></p>
					</div> 
-->
				{else}					
					<div class="avatarContainer">
						<a href="/user/{$person.username}"><img title="{$person.username}" class="avatarRight" src="/avatar.php?id={$person.user_id}"/></a>	
					</div>
    			{/if}
    		    {foreachelse}
    		       <!--
 <div class="span-8 races2">
						<p class="noApuntado">Aun no hay ningún valiente</p>
						<p class="noRaceSub">¿Quieres ser el primero? <b><a href="/rss.php">Apúntate</a></b></p>
					</div>  
-->   
    		    {/foreach}
			</div>
		</div>
		</div>
	</div>

</div> <!-- content -->

</div> <!-- container -->

{include file="footer.tpl"} 
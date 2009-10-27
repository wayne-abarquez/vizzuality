{include file="header.tpl"} 

<link rel='stylesheet' type='text/css' href='/css/fullcalendar.css' />
<script type='text/javascript' src='/js/jquery-1.3.2.min.js'></script>
<script type='text/javascript' src='/js/fullcalendar.min.js'></script>
<script type='text/javascript'>
{literal}
$(document).ready(function() {

	var d = new Date();
	var y = d.getFullYear();
	var m = d.getMonth();
	$.fullCalendar.dayAbbrevs=['Dom','Lun','Mar','Mie','Jue','Vie','Sab'];
	$.fullCalendar.monthNames=['Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'];
	$.fullCalendar.monthAbbrevs=['Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Sep','Oct','Nov','Dic'];
	$.fullCalendar.dayNames=['Domingo','Lunes','Martes','Miercoles','Jueves','Viernes','Sabado'];	
	
	$('#calendar').fullCalendar({
		weekStart:1,
		events: [
			{/literal}
			{foreach key=id item=race from=$races}
			{literal}{{/literal}title: "{$race.name}",start: new Date({$race.anyo}, {$race.mes}-1, {$race.dia}),url: "/run/{$race.id}/{$race.name|seourl}"{literal}}{/literal},
			{/foreach}
			{literal}
			{}
		]
	});

	
	
});
{/literal}
</script>


<!-- GLOBAL CONTAINER RACE -->
	<div class="span-24 raceContainer" id="race">
	
		<!-- RACE & IMAGE -->
		<div class="span-16 first leftColumn">
			<div class="span-16 column">
				<div class="span-16 navigationList">
					<ul> 
						<li><a href="/">Inicio ></a></li>
						<li><a href="#" class="selected">{$titulo_breadcrumb} <b>{$smarty.request.q}</b></a></li>
					</ul>
				</div>
			</div>
			
			<div class="raceContent1">
				<h2 class="newsTitle3">Calendario de carreras ({$count})</h2>
				<div id='calendar' style='margin:3em 0'></div>
			</div>		
						
		</div>
		
		
		<!-- RIGHT COLUMN -->
		<div class="column span-8 last rightColumn">

			<div class="span-8 importantRaces">
				<div class="events"> 
					<h2 class="newsTitle4">Próximas carreras</h2>
				</div>	
				<div class="events">
            		{foreach key=id item=race from=$nextRaces}
            			{if $race eq 'f'}
            				<div class="span-8 races">No hay proximas carreras.</div> 
            			{else}		    				    
        					<div class="span-8 column first raceDetails" id="raceDetails">
        						<div class="column span-1 first date">
	    							<div class="month month{$race.run_type}">{getMonth month=$race.event_date|substr:5:2}</div>
	    							<div class="day">{$race.event_date|substr:8:2}</div>
	    						</div>
        						<div class="column span-6 last calendarRaces">
        							<div class="nextRaceComment"><a href="/run/{$race.id}/{$race.name|seourl}" class="nameRace">{$race.name}</a></div>
        							<div class="raceLocation">{$race.event_location} | {$race.distance_text} | <b>{$race.num_users} van</b></div>
        						</div>
        					</div>
            			{/if}
            	    {foreachelse}
            	        <div class="span-8 races">No hay proximas carreras.</div> 
            	    {/foreach}					
				</div>				
			</div>		
		</div>
	</div>
</div>

{include file="footer.tpl"} 
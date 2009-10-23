{include file="header.tpl"} 
{literal}
<script type="text/javascript"> 
$(document).ready(function(){

	var state = false;
	
	$('body').click(function() {
	 if ($('#widgetCalendar').height()==$('#widgetCalendar div.datepicker').get(0).offsetHeight) {
		  $('#widgetCalendar').stop().animate({height: 0 }, 500);
    	state = false;
		}
	});
	
	
	$('#widgetField span').hover(
		function(){
			$('#widgetField span a.delete').css('background','url(/img/deleteDateIcon.jpg) 0 7px no-repeat');
		},
		function(){
			$('#widgetField span a.delete').css('background','url(/img/deleteDateIcon.jpg) 0 57px no-repeat');
		}
	
	);
	
	
		
	$('#widgetField>a').click(function(){
		$('#widgetCalendar').stop().animate({height: state ? 0 : $('#widgetCalendar div.datepicker').get(0).offsetHeight}, 500);
		state = !state;
		return false;	
	});
	
	$("ul.subnav").parent().append("<span></span>");
  
	/*$("#widgetField>a").click(function() {
				   
		        $('#widget').hover(function() {  
		        }, function(){
		        	$('#widgetCalendar').stop().animate({height: 0 }, 500);
		        	state = false;        	
		        });    
		      
		    }); */

    
	$("#ppalField").click(function() { 
  
        $(this).parent().find("ul.subnav").slideDown('fast').show();   
  
        $('#Navigator').hover(function() {  
        }, function(){  
            $("ul.subnav").slideUp('slow'); 
        }) 
  
        }).hover(function() {  
            $(this).addClass("subhover"); 
        }, function(){  //On Hover Out  
            $(this).removeClass("subhover");   
    });
    

	$("ul.topnav li span").click(function() { 
  
 
        $(this).parent().find("ul.subnav").slideDown('fast').show(); 
  
        $('#Navigator').hover(function() {  
        }, function(){  
            $("ul.subnav").slideUp('slow'); 
        }) 
  
        }).hover(function() {  
            $(this).addClass("subhover");
        }, function(){  //On Hover Out  
            $(this).removeClass("subhover");  
    });
	
	$("ul.topnav li ul.subnav li a").click(function() { 
		valor = $(this).html();
		$('#ppalField').html(valor);
		$('#ppalField').css("color",$(this).css("color"));
		$('#ppalField').html(valor);
		$("ul.subnav").slideUp('fast');
		document.getElementById("tipoCarrera").value = valor;
	});
	
	$(document.getElementById("racesTab")).click(function() { 
	    var tipoBusqueda = $("#current a").attr("title");
		if (tipoBusqueda=="Todas"){
			document.getElementById("tipoBusqueda").value = "Proximas";
		}
		if (tipoBusqueda=="Proximas"){
			document.getElementById("tipoBusqueda").value = "Todas";
		}
		document.getElementById("inputSearchGeneral").click();
	});
});
</script>
{/literal}

<!-- GLOBAL CONTAINER RACE -->
	<div class="span-24 raceContainer" id="race">
	
		<!-- RACE & IMAGE -->
		<div class="span-24">
			
			<div id="searchBox">
				<div class="searchForm">
					<div class="column regionInput">
						<form id="searchForm" method="GET" action="/buscar">
							<!-- inputs ocultos para obtener tipo de carrera y rango de fechas -->
							<input type="hidden" id="tipoBusqueda" name="tipoBusqueda" {if $smarty.request.q!=""}value="{$smarty.request.tipoBusqueda}"{else}value="Proximas"{/if}>
							<input type="hidden" id="tipoCarrera" name="tipoCarrera" value="{$tipoCarrera}">
							<input type="hidden" id="fechaInicio" name="fechaInicio" value="{$smarty.request.fechaInicio}">
							<input type="hidden" id="fechaFin" name="fechaFin" value="{$smarty.request.fechaFin}">
							
							<div class="searchlabel"><p>TEXTO LIBRE</p></div>
							<div class="inputSearch">
								<div class="column first inputLeft">
									<label class="roundsearch1" for="inputsearch1"><span><input type="text" id="inputsearch1" class="default" {if $smarty.get.q==null}value="Busca por nombre, localidad, provincia"{else} value="{$smarty.get.q}"{/if}name="q"></span></label>			
								</div>
								<div class="column inputRight">
									<ul id="Navigator" class="topnav">
							            <li id="liField">
							                <a id="ppalField" href="#" class="{if ($tipoCarrera=="Mediofondo")}a1{elseif ($tipoCarrera=="Fondo")}a2{elseif ($tipoCarrera=="Marathon/Ultrafondo")}a3{elseif ($tipoCarrera=="Cross/Campo")}a4{elseif ($tipoCarrera=="Combinadas")}a5{/if}">{if ($tipoCarrera=="")}Todas{else}{$tipoCarrera}{/if}</a>							                
							                <ul class="subnav">
							                    <li><a href="#">Todas</a></li>
							                    <li><a href="#" class="a1">Mediofondo</a></li>
							                    <li><a href="#" class="a2">Fondo</a></li>
							                    <li><a href="#" class="a3">Marathon/Ultrafondo</a></li>
							                    <li><a href="#" class="a4">Cross/Campo</a></li>
												<li><a href="#" class="a5">Combinadas</a></li>
							                </ul>
							            </li>
							        </ul>	
							    </div>							
							</div>
					</div>
					
					<div class="column dateInput">
						<div class="searchlabel"><p>RANGO DE FECHAS</p></div>
						<div class="inputSearch">
							<div id="widget">
								<div id="widgetField">
									<span>{if ($fechaInicioOld!="")}{$fechaInicioOld} - {$fechaFinOld} {else}Selecciona una fecha{/if}<a class="delete" href="javascript: void cleanDate()"></a></span>
									<a href="#"></a>
								</div>
								<div id="widgetCalendar">
								</div>
							</div>
						</div>
					</div>
					
					<div class="column last buttonSearchBig">
						<span><a href="#"><input id="inputSearchGeneral" class="buttonsearchbig" type="submit" value="Buscar"/></a></span>
					</div>
				</form>

					
				</div>
				<div class="topPaginator" class="span-24">
					<div id="racesTab" class="column first racesTab">
					 	<ul>
					 		<li {if ($tipoBusqueda=="Proximas") or ($tipoBusqueda=="")}id="current"{/if}><a href="#" title="Proximas"><span>Carreras por llegar</span></a></li>
					    	<li {if ($tipoBusqueda=="Todas")}id="current"{/if}><a href="#" title="Todas"><span>Todas las carreras</span></a></li>
					  	</ul>
					</div>
					<div class="column last upPaginator">
						{if $count > 10}
							<p>viendo del <b>{math equation="x+1" x=$offset} al {math equation="min(x2 +10,c)" x2=$offset c=$count}</b> de {$count}
								{if $offset > 0}
									<span><a href="?offset={math equation="max(x-10,0)" x=$offset}&tipoBusqueda={$tipoBusqueda}&tipoCarrera={$smarty.request.tipoCarrera}&fechaInicio={$smarty.request.fechaInicio}&fechaFin={$smarty.request.fechaFin}"><input class="fg-button buttonLeftArrow" type="button"/></a></span>
								{/if}
								{if $offset < $count-10}
									<span><a href="?offset={$offset+10}&tipoBusqueda={$tipoBusqueda}&tipoCarrera={$smarty.request.tipoCarrera}&fechaInicio={$smarty.request.fechaInicio}&fechaFin={$smarty.request.fechaFin}"><input class="fg-button buttonRightArrow" type="button"/></a></span>
	                			{/if}	
							</p>	
	                    {/if}
					</div>	
				</div>
			</div>

				<div id="results" class="span-24 column first">			
	        		{foreach key=id item=race from=$results}
	        			{if $race eq "0"}
	        				<div class="column span-15 noResultsContainer">
	        					<div class="noResultsText">
		        					<p class="noResults">Ouch! No hay resultados</p>
		        					<p class="noResultsSub"><b>No hemos podido encontrar ninguna carrera que coincidiera con tu búsqueda</b>
		        					<br />Comprueba que el tipo, la ortografía y las fechas son correctas.<br /><br /> 
		        					Si sigues sin encontrar nada por aquí, puedes intentarlo en el<a href="/"> mapa de carreras</a> de la home<br />o <a href="/rss.php">suscribirte a nuestro RSS</a> para estar al tanto de las últimas actualizaciones</p>
								</div>
	        				</div>
	        			{else}
	        				<div class="column first {cycle values="raceResult one,raceResult two"}">
	    						<div class="column first firstDetails">
	    							<div class="column first raceResultDate">
	    								<div class="month month{$race.run_type}">{getMonth month=$race.event_date|substr:5:2}</div>
	    								<div class="day">{$race.event_date|substr:8:2}</div>
	    							</div>
	    							<div class="column last">
	    								<div><img src="/media/run/{$race.thumbnail}" alt="Foto de la carrera {$race.name}"/></div>
	    							</div>
	    						</div>
	    						<div class="column last">
	    							<p class="span-1 raceLocationText"><b>{$race.distance_text}</b> / {$race.event_location}, {$race.province_name}</p>   							
	    							<p class="span-18"><a href="/run/{$race.id}/{$race.name|replace:' ':'/'}" class="raceTitleText">{$race.name}</a></p>
	    							<div id="socialDetails">
	    								<div class="column socialBox first"><img src="/img/photo.jpg"/><a href="/run/{$race.id}/{$race.name|replace:' ':'/'}">{$race.num_pictures} fotos</a></div>
	    								<div class="column socialBox last"><img src="img/comment.jpg"/> <a href="/run/{$race.id}/{$race.name|replace:' ':'/'}">{$race.num_comments} comentarios</a></div>
	    							</div>
	    						</div>
	    						{if $race.num_users>0}
	    							<div class="blueTag"><a><span class="start">{$race.num_users}{if $race.num_users eq 1} VA{else} VAN{/if}</span></a></div> 							
	    						{/if}
	    					</div>     
	        			{/if}
	        	    {foreachelse}
        				<div class="column span-15 noResultsContainer">
        					<div class="noResultsText">
	        					<p class="noResults">Ouch! No hay resultados</p>
	        					<p class="noResultsSub"><b>No hemos podido encontrar ninguna carrera que coincidiera con tu búsqueda</b>
	        					<br />Comprueba que el tipo, la ortografía y las fechas son correctas.<br /><br /> 
	        					Si sigues sin encontrar nada por aquí, puedes intentarlo en el<a href="/"> mapa de carreras</a> de la home<br />o <a href="/rss.php">suscribirte a nuestro RSS</a> para estar al tanto de las últimas actualizaciones</p>
							</div>
        				</div>
	        	    {/foreach}
        	    </div>
        	    
        	    
        	    <div id="belowPaginator" class="span-24">
        	    	<div class="column first belowPaginatorTotal"><p>{$count}{if $count eq 1} resultado{else} resultados{/if}</p></div>
        	   		<div class="column last bottomPaginator">
						{if $count > 10}
 							<p>viendo del <b>{math equation="x+1" x=$offset} al {math equation="min(x2 +10,c)" x2=$offset c=$count}</b> de {$count}
								{if $offset > 0}
									<span><a href="?offset={math equation="max(x-10,0)" x=$offset}&tipoBusqueda={$tipoBusqueda}&tipoCarrera={$smarty.request.tipoCarrera}&fechaInicio={$smarty.request.fechaInicio}&fechaFin={$smarty.request.fechaFin}"><input class="fg-button buttonLeftArrow" type="button"/></a></span>
								{/if}
								{if $offset < $count-10}
									<span><a href="?offset={$offset+10}&tipoBusqueda={$tipoBusqueda}&tipoCarrera={$smarty.request.tipoCarrera}&fechaInicio={$smarty.request.fechaInicio}&fechaFin={$smarty.request.fechaFin}"><input class="fg-button buttonRightArrow" type="button"/></a></span>
	                			{/if}
 								
 							</p>	
                    	{/if}
					</div>
					
				</div>
				
				
			</div>					
		</div>
	</div>
</div>

{include file="footer.tpl"} 
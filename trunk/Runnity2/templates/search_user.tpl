{include file="header.tpl"}
 
{literal}
<script type="text/javascript"> 
$(document).ready(function(){

    if(gup('q').length<1) {
        $('#inputsearch1').emptyonclick();
    }
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
						<!-- METODO BUSCAR!?!??! -->
						<form id="searchForm" method="GET" action="/usuarios">
							<div class="searchlabel"><p>NOMBRE</p></div>
							<div class="inputSearch">
								<div class="column first inputLeft">
									<label class="roundsearchUser" for="inputsearch1"><span><input type="text" id="userInputSearch" class="default" {if $smarty.get.q==null}value="Nombre de usuario (dejalo vacío para ver todos)"{else} value="{$smarty.get.q}"{/if}name="q"></span></label>			
								</div>
														
							</div>
					</div>
					
					<div class="column last buttonSearchBig">
						<span><a href="#"><input id="inputSearchGeneral" class="buttonsearchbig" type="submit" value="Buscar"></a></span>
					</div>
				</form>

					
				</div>
				<div class="span-23 topPaginator">
					<div class="column last upPaginator">
						{if $count > 10}
							<p>viendo del <b>{math equation="x+1" x=$offset} al {math equation="min(x2 +10,c)" x2=$offset c=$count}</b> de {$count}
								{if $offset > 0}
									<span><a href="?offset={math equation="max(x-10,0)" x=$offset}&amp;q={$smarty.request.q}"><input class="leftPaginator" type="button"></a></span>
								{/if}
								{if $offset < $count-10}
									<span><a href="?offset={$offset+10}&amp;q={$smarty.request.q}"><input class="rightPaginator" type="button"></a></span>
	                			{/if}	
							</p>	
	                    {/if}
					</div>	
				</div>
			</div>

				<div id="results" class="span-24 column first">			
	        		{foreach key=id item=user from=$results}
	        			{if $user eq "0"}
	        				<div class="column span-15 noResultsContainer">
	        					<div class="noResultsText">
		        					<p class="noResults">Ouch! No hay resultados</p>
		        					<p class="noResultsSub"><b>No hemos podido encontrar ningún usuario que coincidiera con tu búsqueda</b>
		        					<br />Comprueba que la ortografía es correcta.<br /><br /> 
		        					Si sigues sin encontrar nada por aquí, puedes intentarlo en el<a href="/"> mapa de carreras</a> de la home<br />o <a href="/rss.php">suscribirte a nuestro RSS</a> para estar al tanto de las últimas actualizaciones</p>
								</div>
	        				</div>
	        			{else}
	        				<div class="column first {cycle values="userResult one,userResult two"}">
	    						<div class="column first secondDetails">
	    							<div class="column last">
	    								<div><img src="/avatar.php?id={$user.id}&amp;type=s" alt="{$user.username}"></div>
	    							</div>
	    						</div>
	    						<div class="column last">	
										<p class="span-20"><a href="/user/{$user.username}" class="userTitleText">{$user.completename}</a></p>
										<p class="span-1 userName"><b></b> {$user.username} / 
											{php}
													switch ($user.birthday){
														case ($anio>="1987" && $anio<="1989"):
															$categoria="Promesa";
														break;
														case ($anio>="1990" && $anio<="1991"):
															$categoria="Júnior";
														break;
														case ($anio>="1992" && $anio<="1993"):
															$categoria="Juvenil";
														break;
														case ($anio>="1994" && $anio<="1995"):
															$categoria="Cadete";
														break;
														case ($anio>="1996" && $anio<="1997"):
															$categoria="Infantil";
														break;
														case ($anio>="1998" && $anio<="1999"):
															$categoria="Alevín";
														break;
														case ($anio>="2000" && $anio<="2001"):
															$categoria="Benjamín";
														break;
															case ($anio<="1974"):
															$categoria="Veterano";
														break;
														case ($anio>="1975" && $anio<="1986"):
															$categoria="Senior";
														break;
														case ($anio>="2002"):
															$categoria="Pre-Benjamín";
														break;
													}
													echo $categoria;
											{/php}
										</p>
	    							
	    							<div id="socialDetails">
	    								<div class="column socialBox first"><img src="/img/photo.jpg" alt="photo"><a href="/run/{$race.id}/{$race.name|seourl}#fotos">{$user.num_pictures} fotos</a></div>
	    							</div>
	    						</div>
	    					</div>     
	        			{/if}
	        	    {foreachelse}
        				<div class="column span-15 noResultsContainer">
        					<div class="noResultsText">
	        					<p class="noResults">Ouch! No hay resultados</p>
	        					<p class="noResultsSub"><b>No hemos podido encontrar ningún usuario que coincidiera con tu búsqueda</b>
	        					<br />Comprueba que la ortografía es correctas.<br /><br /> 
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
									<span><a href="?offset={math equation="max(x-10,0)" x=$offset}&amp;q={$smarty.request.q}"><input class="leftPaginator" type="button"></a></span>
								{/if}
								{if $offset < $count-10}
									<span><a href="?offset={$offset+10}&amp;q={$smarty.request.q}"><input class="rightPaginator" type="button"></a></span>
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
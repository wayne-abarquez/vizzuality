{include file="header.tpl"} 
{literal}
<script type="text/javascript">
  	var _officeItemListCombobox = null;
  	var _cssStyleSelectJQ = null;
  	var _animationTypeSelectJQ = null;
  	var _animationType = "slide";

		$(
			function()
			{
				var comboboxSettings = {animationSpeed: 100};
				
				// Create the example combobox
				setupCombobox();
				
				// Create the different styles combobox
				_cssStyleSelectJQ = $("#cssStyleSelect").combobox({}, comboboxSettings);
				// Combobox has its own onChange event, but the onChange of the Select element can be used as well.
				// changeAnimation works in this manner.
				_cssStyleSelectJQ.combobox.onChange = 
					function()
					{	
						changeStyle();
					};
				
				// Create the Animation types combobox
				// Note: There is no need to configure the onChange event as the event is defined in the html
				//	<select id="animationTypeSelect" onchange="changeAnimation()">
				_animationTypeSelectJQ = $("#animationTypeSelect").combobox({}, comboboxSettings);
			});
			
			// create a jquery combobx and set the Css class styles
			function setupCombobox()
			{
				_officeItemListCombobox = $('#raceType').combobox(
					{
						comboboxContainerClass: "comboboxContainer",
						comboboxValueContentContainerClass: "comboboxValueContainer",
						comboboxValueContentClass: "comboboxValueContent",
						comboboxDropDownClass: "comboboxDropDownContainer",
						comboboxDropDownButtonClass: "comboboxDropDownButton",
						comboboxDropDownItemClass: "comboboxItem",
						comboboxDropDownItemHoverClass: "comboboxItemHover",
						comboboxDropDownGroupItemHeaderClass: "comboboxGroupItemHeader",
						comboboxDropDownGroupItemContainerClass: "comboboxGroupItemContainer"
					},
					{
						animationType: _animationType,
						width: 130
					});
			}
			
			function changeStyle()
			{
			
				var cssStyleSelectJQ = $("#cssStyleSelect");
				var selectedStyle = cssStyleSelectJQ.val();
				selectedStyle = "style/screen/" + selectedStyle + ".css";
				
				_officeItemListCombobox.combobox.remove()
				
				$("link[title='combobox']").attr("href", selectedStyle);
				
				// Time delay required for the new css stylesheet to be processed by the Browser,
				// otherwise, jquery.combobox cannot calculate the correct layout for the new styles
				setTimeout(setupCombobox, 1);
			}
			
			function changeAnimation()
			{
				var animationTypeSelectJQ = $("#animationTypeSelect");
				_animationType = animationTypeSelectJQ.val();
				
				_officeItemListCombobox.combobox.remove();
				setupCombobox();
			}
			
			// Example to show the dynamic insertion of data directly into the original Select element
			// and then calling the jQuery combobox to synchronise by calling update().
			function updateCombobox()
			{
				var officeItemListSelectJQ = $("#raceType");
				var currentDate = Date();
				officeItemListSelectJQ.append("<option value='" + currentDate + "'>" + currentDate + "</option>");

				_officeItemListCombobox.combobox.update();
			}
	</script>
{/literal}

<!-- GLOBAL CONTAINER RACE -->
	<div class="span-24 raceContainer" id="race">
	
		<!-- RACE & IMAGE -->
		<div class="span-24">
			
			<div id="searchBox">
				<div class="searchForm">
					<div class="column first regionInput">
						<form id="searchForm" method="GET" action="/buscar">
							<div class="searchlabel"><p>TEXTO LIBRE</p></div>
							<div class="inputSearch">
								<div class="column first">
									<label class="roundsearch" for="inputsearch1"><span><input type="text" name="q" id="inputsearch1" value="{$smarty.request.q}" style="width:400px;"></span></label>			
								</div>
								<div class="column last">
									<select id="raceType">
										<option value="1" selected="selected">Todas</option>
										<option value="2">Mediofondo</option>
										<option value="3">Fondo</option>
										<option value="4">Marathon/Ultrafondo</option>
										<option value="5">Cross/Campo</option>
										<option value="6">Combinadas</option>
									</select>
								</div>
							</div>
						</form>
					</div>
					
					<div class="column dateInput">
						<div class="searchlabel"><p>RANGO DE FECHAS</p></div>
						<div class="inputSearch">
							<div id="widget">
								<div id="widgetField">
									<span>23/09/2009 - 31/09/2009</span>
									<a href="#">Selecciona un rango</a>
								</div>
								<div id="widgetCalendar">
								</div>
							</div>
						</div>
					</div>
					
					<div class="column last buttonSearch">
						<span><a href="#"><input class="fg-button" type="button" value="Buscar"/></a></span>
					</div>
					
				</div>
				<div class="topPaginator" class="span-24">
					<div class="column first racesTab">
					 	<ul>
					    	<li id="current"><a href="#" title="Link 1"><span>Carreras por llegar</span></a></li>
					    	<li><a href="#" title="Link 2"><span>Carreras pasadas</span></a></li>
					  	</ul>
					</div>
					<div class="column last upPaginator">
						{if $count > 20}
							<p>viendo del <b>{math equation="x+1" x=$offset} al {math equation="min(x2 +20,c)" x2=$offset c=$count}</b> de {$count}
								{if $offset > 0}
									<span><a href="?offset={math equation="max(x-20,0)" x=$offset}"><input class="fg-button" type="button" value="<"/></a></span>
								{/if}
								{if $offset < $count-20}
									<span><a href="?offset={$offset+20}&q={$smarty.request.q}&distancia_min={$smarty.request.distancia_max}&distancia_max={$smarty.request.distancia_max}"><input class="fg-button" type="button" value=">"/></a></span>
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
	        					<div class="carita"></div>
	        					<div class="noResultsText">
	        					<p class="noResults"><b>Lo sentimos, no hay resultados</b> que coincidan con tu búsqueda</p>
	        					<p class="noResultsSub">Pero si quieres puedes <a href="/rss.php">subscribirte a nuestro RSS</a> para estar al tanto de las nuevas carreras</p>
								</div>
	        				</div>
	        			{else}
	        				<div class="column first {cycle values="raceResult one,raceResult two"}">
	    						<div class="column first firstDetails">
	    							<div class="column first raceResultDate">
	    								<div class="month">{getMonth month=$race.event_date|substr:5:2}</div>
	    								<div class="day">{$race.event_date|substr:8:2}</div>
	    							</div>
	    							<div class="column last">
	    								<div ><img src="/img/avatar2.jpg"></div>
	    							</div>
	    						</div>
	    						<div class="column last">
	    							<p class=" raceLocationText"><b>{$race.distance_text}</b> / {$race.event_location}, {$race.province_name}</p>   							
	    							<p><a href="/run/{$race.id}/{$race.name|replace:' ':'/'}" class="raceTitleText">{$race.name}</a></p>
	    							<div id="socialDetails">
	    								<div class="column socialBox first"><img src="/img/photo.jpg"/><a href="/run/{$race.id}/{$race.name|replace:' ':'/'}">12 FOTOS</a></div>
	    								<div class="column socialBox last"><img src="img/comment.jpg"/> <a href="/run/{$race.id}/{$race.name|replace:' ':'/'}">12 COMENTARIOS</a></div>
	    							</div>
	    						</div>
	    						{if $race.num_users>0}
	    							<div class="blueTag"><a><span class="start">{$race.num_users}{if $race.num_users eq 1} VA{else} VAN{/if}</span></a></div> 							
	    						{/if}
	    					</div>     
	        			{/if}
	        	    {foreachelse}
	        	        <div class="column span-15 noResultsContainer">
	        					<div class="carita"></div>
	        					<div class="noResultsText">
	        					<p class="noResults"><b>Lo sentimos, no hay resultados</b> que coincidan con tu búsqueda</p>
	        					<p class="noResultsSub">Pero si quieres puedes <a href="/rss.php">subscribirte a nuestro RSS</a> para estar al tanto de las nuevas carreras</p>
								</div>
	        				</div> 
	        	    {/foreach}
        	    </div>
        	    
        	    
        	    <div id="belowPaginator" class="span-24">
        	    	<div class="column first noResults"><p>{$count}{if $count eq 1} resultado{else} resultados{/if}</p></div>
        	   		<div class="column last bottomPaginator">
						{if $count > 20}
 							<p>viendo del <b>{math equation="x+1" x=$offset} al {math equation="min(x2 +20,c)" x2=$offset c=$count}</b> de {$count}
 								{if $offset > 0}
									<span><a href="?offset={math equation="max(x-20,0)" x=$offset}"><input class="fg-button" type="button" value="< ANTERIORES"/></a></span>
								{/if}
								{if $offset < $count-20}
									<span><a href="?offset={$offset+20}&q={$smarty.request.q}&distancia_min={$smarty.request.distancia_max}&distancia_max={$smarty.request.distancia_max}"><input class="fg-button" type="button" value="SIGUIENTES >"/></a></span>
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
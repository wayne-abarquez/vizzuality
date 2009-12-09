{include file="newheader_cat.tpl"}

<div class="content">
<form action="sheetresult.php" method="get">

	<div class="titleIndex"><p>Cerca a la base de dades de {$BDSelected} de l'Herbari de la Universitat de Barcelona (BCN)</p></div>
	
<div class="news-body">
	  <div class="buscador">
	  <form action="sheetresult.php" method="get" name="thisform" id="thisform">
	  	<span class="search-1">Nom del tˆxon:<br />
		<input name="nameauthoryearstring" id="nameauthoryearstring" value="" size="30" style="width: 15em;" type="text">
		</span> 
		<span class="search-1">Fam’lia:<br />
		<select name="highertaxon">
		  <option value="">Totes</option>
			{html_options values=$families output=$families}
		 </select>
		</span> 
		<span class="search-1">Pa’s:<br />
		<select name="countryname">
		  <option value="">Tots</option>
		  {html_options values=$countries output=$countries}
		</select>
		</span> 
		<span class="search-1">Recolálectors:<br />
		<input name="agenttext" id="agenttext" value="" size="30" style="width: 10em;" type="text">
		</span> 
		<span class="search-1">UTM:<br />
		<input name="utmformula" id="utmformula" value="" size="8" style="width: 5em;" type="text">
		</span> 
		<span class="search-1">Ordenat per:<br />
		<select name="orderby">
		  <option value="nameauthoryearstring" >Nom 
		  tˆxon</option>
		  <option value="highertaxon" >Fam’lia</option>
		  <option value="countryname" >Pa’s</option>
		  <option value="utmformula" >UTM</option>
		</select>
		</span> <br>
		<input name="db" type="hidden" value="cormofitos">
		<input name="submit" value="Cerca" type="submit">
	  </form>
	  </div>

	<div class="trobats">
	{if !$SearchSheetsResults}
	<p>0 Resultats trobats</p><a href="#" onClick="javascript:window.history.back();">Torna</a> 
	{else}
	<p>{$SearchSheetsResults.count} Resultats trobats</p>
	{/if}
	</div>
	
	
	
	<div class="results"> 
	{section name=resultado loop=$SearchSheetsResults}
	
	<div class="containerResult">
	<div class="span-1 first shade-1" id="main0"><p><a href="sheetdetail.php?UnitID={$SearchSheetsResults[resultado].UnitID}&amp;db={$BDSelected}">{$SearchSheetsResults[resultado].UnitID}<br> BCN
	 </a></p></div>

	<div class="span-1 last result">
	<a href="sheetdetail.php?UnitID={$SearchSheetsResults[resultado].UnitID}&amp;db={$BDSelected}"> 
	{$SearchSheetsResults[resultado].nameauthoryearstring}</a>
	<p>{$SearchSheetsResults[resultado].highertaxon} | {$SearchSheetsResults[resultado].TypeStatus}</p>
	<p>  
	  <b>Localitat:</b> 
	  {$SearchSheetsResults[resultado].localitytext}
	  <b>Recol&middot;lectors:</b> 
	  {$SearchSheetsResults[resultado].AgentText}
	  ( 
<!-- 	  fecha -->
	  ) 
	</p>
	<div class="news-details">  
	  <span>{if $SearchSheetsResults[resultado].has_images eq 0} 0 fotos {else} {$SearchSheetsResults[resultado].has_images} fotos {/if}</span> 
	  <span>No georeferenciat</span> 
	</div>
	
	</div>
	
	</div>
<!-- 	  revisar georeferenciados -->


	<div>
	
    {/section}

</div>

<div class="paginator">
{if $SearchSheetsResults.count > 0}
	<p>Tenemos {$SearchSheetsResults.count} resultados</p>
{/if}

{if $SearchSheetsResults.count > 10}
	<p>Viendo del <b>{math equation="x+1" x=$offset} al {math equation="min(x2 +10,c)" x2=$offset c=$SearchSheetsResults.count}</b> de {$SearchSheetsResults.count}
		{if $offset > 0}
		<span><a href="?offset={math equation="max(x-10,0)" x=$offset}&amp;nameauthoryearstring={$smarty.request.nameauthoryearstring}&amp;genus={$smarty.request.genus}&amp;highertaxon={$smarty.request.highertaxon}&amp;localitytext={$smarty.request.localitytext}&amp;countryname={$smarty.request.countryname}&amp;utmformula={$smarty.request.utmformula}&amp;agenttext={$smarty.request.agenttext}&amp;datesearchtype={$smarty.request.datesearchtype}&amp;datetext={$smarty.request.datetext}&amp;UnitID={$smarty.request.UnitID}&amp;submit={$smarty.request.submit}&amp;db={$smarty.request.db}"><input class="leftPaginator" type="button" value="Anterior"></a></span>
		{/if}
		{if $offset < $SearchSheetsResults.count-10}
		<span><a href="?offset={$offset+10}&amp;&amp;nameauthoryearstring={$smarty.request.nameauthoryearstring}&amp;genus={$smarty.request.genus}&amp;highertaxon={$smarty.request.highertaxon}&amp;localitytext={$smarty.request.localitytext}&amp;countryname={$smarty.request.countryname}&amp;utmformula={$smarty.request.utmformula}&amp;agenttext={$smarty.request.agenttext}&amp;datesearchtype={$smarty.request.datesearchtype}&amp;datetext={$smarty.request.datetext}&amp;UnitID={$smarty.request.UnitID}&amp;submit={$smarty.request.submit}&amp;db={$smarty.request.db}"><input class="rightPaginator" type="button" value="Siguiente"></a></span>
	    {/if}	
	</p>	
{/if}
</div>

</div> <!-- news -->

</form>
</div>

{include file="newfooter_cat.tpl"} 
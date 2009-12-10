{include file="newheader_es.tpl"}

<div class="content">
<form action="sheetresult.php" method="get">

	<div class="titleIndex"><p>Cerca a la base de dades de {$BDSelected} de l'Herbari de la Universitat de Barcelona (BCN)</p></div>
	
   <div class="news-body">
	  <div class="buscador">
	  <form action="sheetresult.php" method="get" name="thisform" id="thisform">
	  	<span class="search-1">Nom del tàxon:<br />
		<input name="nameauthoryearstring" id="nameauthoryearstring" value="" size="30" style="width: 15em;" type="text">
		</span> 
		<span class="search-1">Família:<br />
		<select name="highertaxon">
		  <option value="">Totes</option>
			{html_options values=$families output=$families}
		 </select>
		</span> 
		<span class="search-1">País:<br />
		<select name="countryname">
		  <option value="">Tots</option>
		  {html_options values=$countries output=$countries}
		</select>
		</span> 
		<span class="search-1">Recol·lectors:<br />
		<input name="agenttext" id="agenttext" value="" size="30" style="width: 10em;" type="text">
		</span> 
		<span class="search-1">UTM:<br />
		<input name="utmformula" id="utmformula" value="" size="8" style="width: 5em;" type="text">
		</span> 
		<span class="search-1">Ordenat per:<br />
		<select name="orderby">
		  <option value="nameauthoryearstring" >Nom 
		  tàxon</option>
		  <option value="highertaxon" >Família</option>
		  <option value="countryname" >País</option>
		  <option value="utmformula" >UTM</option>
		</select>
		</span> <br>
		<span class="search-1">
		<input name="submit" value="Cerca" type="submit" class="button">
		<input name="db" type="hidden" value="cormofitos">
		</span> 
		<br><br>
	  </form>
	  </div>
	  <div class="Map" id="map"></div>

	<div class="trobats">
	{if !$SearchSheetsResults}
	<p>0 Resultats trobats</p><a href="#" onClick="javascript:window.history.back();">Torna</a> 
	{else}
	<div class="paginator">
	{if $SearchSheetsResults.count > 10}
		<p>Viendo del <b>{math equation="x+1" x=$offset} al {math equation="min(x2 +10,c)" x2=$offset c=$SearchSheetsResults.count}</b> de <b>{$SearchSheetsResults.count}</b> Resultats trobats
			{if $offset > 0}
			<span><a href="?offset={math equation="max(x-10,0)" x=$offset}&amp;nameauthoryearstring={$smarty.request.nameauthoryearstring}&amp;genus={$smarty.request.genus}&amp;highertaxon={$smarty.request.highertaxon}&amp;localitytext={$smarty.request.localitytext}&amp;countryname={$smarty.request.countryname}&amp;utmformula={$smarty.request.utmformula}&amp;agenttext={$smarty.request.agenttext}&amp;datesearchtype={$smarty.request.datesearchtype}&amp;datetext={$smarty.request.datetext}&amp;UnitID={$smarty.request.UnitID}&amp;submit={$smarty.request.submit}&amp;db={$smarty.request.db}"><input type="button" class="button" value="Anterior"></a></span>
			{/if}
			{if $offset < $SearchSheetsResults.count-10}
			<span><a href="?offset={$offset+10}&amp;&amp;nameauthoryearstring={$smarty.request.nameauthoryearstring}&amp;genus={$smarty.request.genus}&amp;highertaxon={$smarty.request.highertaxon}&amp;localitytext={$smarty.request.localitytext}&amp;countryname={$smarty.request.countryname}&amp;utmformula={$smarty.request.utmformula}&amp;agenttext={$smarty.request.agenttext}&amp;datesearchtype={$smarty.request.datesearchtype}&amp;datetext={$smarty.request.datetext}&amp;UnitID={$smarty.request.UnitID}&amp;submit={$smarty.request.submit}&amp;db={$smarty.request.db}"><input type="button" class="button" value="Siguiente"></a></span>
		    {/if}	
		</p>	
	{/if}
	</div>
	{/if}
	</div>
	
	
	{foreach key=UnitID item=result from=$SearchSheetsResults.datos}
	<div class="results"> 

	
	<div class="containerResult">
		<div class="span-1 first shade-1" id="main0">
			<p><a href="sheetdetail.php?UnitID={$result.UnitID}&amp;db={$BDSelected}">{$result.UnitID}<br> BCN </a></p>
		</div>

		<div class="span-1 last result">
			<a href="sheetdetail.php?UnitID={$result.UnitID}&amp;db={$BDSelected}"> 
			{$result.nameauthoryearstring}</a>
			<p>{$result.highertaxon} | {$result.TypeStatus}</p>
			<p><b>Localitat: </b>{$result.localitytext}<b> Recollectors:</b> {$result.AgentText} ( <!--fecha-->	)</p>
		    <div class="news-details">  
	  		    <span>{if $result.has_images eq 0} 0 fotos {else} {$result.has_images} fotos {/if}</span> 
	  		    <span>No georeferenciat</span> 
		    </div>
	    </div>
	
	</div>
<!-- 	  revisar georeferenciados -->
	{/foreach}

   </div>

	<div class="trobats">
	{if !$SearchSheetsResults}
	<p>0 Resultats trobats</p><a href="#" onClick="javascript:window.history.back();">Torna</a> 
	{else}
	<div class="paginator">
	{if $SearchSheetsResults.count > 10}
		<p>Viendo del <b>{math equation="x+1" x=$offset} al {math equation="min(x2 +10,c)" x2=$offset c=$SearchSheetsResults.count}</b> de <b>{$SearchSheetsResults.count}</b> Resultats trobats
			{if $offset > 0}
			<span><a href="?offset={math equation="max(x-10,0)" x=$offset}&amp;nameauthoryearstring={$smarty.request.nameauthoryearstring}&amp;genus={$smarty.request.genus}&amp;highertaxon={$smarty.request.highertaxon}&amp;localitytext={$smarty.request.localitytext}&amp;countryname={$smarty.request.countryname}&amp;utmformula={$smarty.request.utmformula}&amp;agenttext={$smarty.request.agenttext}&amp;datesearchtype={$smarty.request.datesearchtype}&amp;datetext={$smarty.request.datetext}&amp;UnitID={$smarty.request.UnitID}&amp;submit={$smarty.request.submit}&amp;db={$smarty.request.db}"><input type="button" class="button" value="Anterior"></a></span>
			{/if}
			{if $offset < $SearchSheetsResults.count-10}
			<span><a href="?offset={$offset+10}&amp;&amp;nameauthoryearstring={$smarty.request.nameauthoryearstring}&amp;genus={$smarty.request.genus}&amp;highertaxon={$smarty.request.highertaxon}&amp;localitytext={$smarty.request.localitytext}&amp;countryname={$smarty.request.countryname}&amp;utmformula={$smarty.request.utmformula}&amp;agenttext={$smarty.request.agenttext}&amp;datesearchtype={$smarty.request.datesearchtype}&amp;datetext={$smarty.request.datetext}&amp;UnitID={$smarty.request.UnitID}&amp;submit={$smarty.request.submit}&amp;db={$smarty.request.db}"><input type="button" class="button" value="Siguiente"></a></span>
		    {/if}	
		</p>	
	{/if}
	</div>
	{/if}
	</div>

</div> <!-- news -->

</form>
</div>

{literal}<script src="http://maps.google.com/maps?file=api&v=2&key=nokey" type="text/javascript"></script>{/literal}

{literal}
<script type="text/javascript">
//<![CDATA[
var map;
if (GBrowserIsCompatible()) {
map = new GMap(document.getElementById("map"));
var point = new GLatLng(40.38051877130511, -3.7238287925720215);

map.setCenter(point, 15);
}

//]]>
</script>
{/literal}

{include file="newfooter_es.tpl"} 
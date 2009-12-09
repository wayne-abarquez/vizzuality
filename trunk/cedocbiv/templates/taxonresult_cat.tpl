{include file="newheader_cat.tpl"}


<div class="content">
<form action="sheetresult.php" method="get">

	<div class="titleIndex"><p>Cerca a la base de dades de {$BDSelected} de l'Herbari de la Universitat de Barcelona (BCN)</p></div>
	
<div class="news-body">
	  <div class="taxonMap" id="map"></div>

	<div class="trobats">
	{if !$SearchTaxonResults}
	<p>0 Resultats trobats</p><a href="#" onClick="javascript:window.history.back();">Torna</a> 
	{else}
	<p>{$SearchTaxonResults.count} Resultats trobats</p>
	{/if}
	</div>
	
	
	
	<div class="resultsTaxon"> 
	{section name=resultado loop=$SearchTaxonResults}
	
	<div class="containerResultTaxon">
	<div class="span-1 first shade-1" id="main0"><p><a href="sheetdetail.php?UnitID={$SearchTaxonResults[resultado].UnitID}&amp;db={$BDSelected}">{$SearchTaxonResults[resultado].UnitID}<br> BCN
	 </a></p></div>

	<div class="span-1 last resultTaxon">
	<a href="taxondetail.php?UnitID={$SearchTaxonResults[resultado].UnitID}&amp;db={$BDSelected}"> 
	{$SearchTaxonResults[resultado].nameauthoryearstring}</a>
	<p>{$SearchTaxonResults[resultado].highertaxon} | {$SearchTaxonResults[resultado].TypeStatus}</p>
	<p>  
	  <b>Localitat:</b> 
	  {$SearchTaxonResults[resultado].localitytext}
	  <b>Recol&middot;lectors:</b> 
	  {$SearchTaxonResults[resultado].AgentText}
	  ( 
<!-- 	  fecha -->
	  ) 
	</p>
	<div class="news-details">  
	  <span>{if $SearchTaxonResults[resultado].has_images eq 0} 0 fotos {else} {$SearchTaxonResults[resultado].has_images} fotos {/if}</span> 
	  <span>No georeferenciat</span> 
	</div>
	
	</div>
	
	</div>
<!-- 	  revisar georeferenciados -->


	<div>
	
    {/section}

</div>

<!--
<div class="paginator">
{if $SearchTaxonResults.count > 0}
	<p>Tenemos {$SearchTaxonResults.count} resultados</p>
{/if}

{if $SearchTaxonResults.count > 10}
	<p>Viendo del <b>{math equation="x+1" x=$offset} al {math equation="min(x2 +10,c)" x2=$offset c=$SearchTaxonResults.count}</b> de {$SearchTaxonResults.count}
		{if $offset > 0}
		<span><a href="?offset={math equation="max(x-10,0)" x=$offset}&amp;nameauthoryearstring={$smarty.request.nameauthoryearstring}&amp;genus={$smarty.request.genus}&amp;highertaxon={$smarty.request.highertaxon}&amp;localitytext={$smarty.request.localitytext}&amp;countryname={$smarty.request.countryname}&amp;utmformula={$smarty.request.utmformula}&amp;agenttext={$smarty.request.agenttext}&amp;datesearchtype={$smarty.request.datesearchtype}&amp;datetext={$smarty.request.datetext}&amp;UnitID={$smarty.request.UnitID}&amp;submit={$smarty.request.submit}&amp;db={$smarty.request.db}"><input class="leftPaginator" type="button" value="Anterior"></a></span>
		{/if}
		{if $offset < $SearchTaxonResults.count-10}
		<span><a href="?offset={$offset+10}&amp;&amp;nameauthoryearstring={$smarty.request.nameauthoryearstring}&amp;genus={$smarty.request.genus}&amp;highertaxon={$smarty.request.highertaxon}&amp;localitytext={$smarty.request.localitytext}&amp;countryname={$smarty.request.countryname}&amp;utmformula={$smarty.request.utmformula}&amp;agenttext={$smarty.request.agenttext}&amp;datesearchtype={$smarty.request.datesearchtype}&amp;datetext={$smarty.request.datetext}&amp;UnitID={$smarty.request.UnitID}&amp;submit={$smarty.request.submit}&amp;db={$smarty.request.db}"><input class="rightPaginator" type="button" value="Siguiente"></a></span>
	    {/if}	
	</p>	
{/if}
</div>
-->

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

{include file="newfooter_cat.tpl"} 
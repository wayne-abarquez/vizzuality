{include file="newheader.tpl"}


<div class="content">
<form action="sheetresult.php" method="get">

	<div class="titleIndex"><p>Cerca a la base de dades de {$BDSelected} de l'Herbari de la Universitat de Barcelona (BCN)</p></div>
	
<div class="news-body">
	<div class="Map" id="map"></div>

	<div class="trobats">
	{if !$SearchTaxonResults}
	<p>0 Resultats trobats</p><a href="#" onClick="javascript:window.history.back();">Torna</a> 
	{else}
	<div class="paginator">
	{if $SearchTaxonResults.count > 10}
		<p>Viendo del <b>{math equation="x+1" x=$offset} al {math equation="min(x2 +10,c)" x2=$offset c=$SearchTaxonResults.count}</b> de <b>{$SearchTaxonResults.count}</b> resultats trobats
			{if $offset > 0}
			<span><a href="?offset={math equation="max(x-10,0)" x=$offset}&amp;nameauthoryearstring={$smarty.request.nameauthoryearstring}&amp;genus={$smarty.request.genus}&amp;highertaxon={$smarty.request.highertaxon}&amp;UnitID={$smarty.request.UnitID}&amp;submit={$smarty.request.submit}&amp;db={$smarty.request.db}"><input type="button" class="button" value="Anterior"></a></span>
			{/if}
			{if $offset < $SearchTaxonResults.count-10}
			<span><a href="?offset={$offset+10}&amp;&amp;nameauthoryearstring={$smarty.request.nameauthoryearstring}&amp;genus={$smarty.request.genus}&amp;highertaxon={$smarty.request.highertaxon}&amp;UnitID={$smarty.request.UnitID}&amp;submit={$smarty.request.submit}&amp;db={$smarty.request.db}"><input type="button" class="button" value="Siguiente"></a></span>
		    {/if}	
		</p>	
	{/if}
	</div>
	{/if}
	</div>
	
	
	
	
	<div class="results"> 
	{foreach key=UnitID item=result from=$SearchTaxonResults.datos}

	
		<div class="containerResultTaxon">
			<div class="span-1 first shade-1Taxon" id="main0">
				<p><a href="#">{$result.highertaxon}<br></a></p>
			</div>
	
			<div class="span-1 last resultTaxon">
				<a href="taxondetail.php?nameauthoryearstring={$result.nameauthoryearstring}&amp;db={$BDSelected}"> 
				{$result.nameauthoryearstring}</a>
				<p>{$result.TypeStatus}</p>
				<p><b>Localitats: </b>{$result.locality|truncate:100:"..."}</p>
				<p><b>Paises: </b>{$result.country|truncate:100:"..."}</p>
				<p><b>Núm. Pliegos: </b>{$result.num_sheets}</p>
				<p><b>Altitud: </b>{$result.altitudUpper} - {$result.altitudLower}</p>
			</div>
		</div>
	
	{/foreach}
	</div>
	
</div>

<div class="trobats">
	{if !$SearchTaxonResults}
	<p>0 Resultats trobats</p><a href="#" onClick="javascript:window.history.back();">Torna</a> 
	{else}
	<div class="paginator">
	{if $SearchTaxonResults.count > 10}
		<p>Viendo del <b>{math equation="x+1" x=$offset} al {math equation="min(x2 +10,c)" x2=$offset c=$SearchTaxonResults.count}</b> de {$SearchTaxonResults.count} resultats trobats
			{if $offset > 0}
			<span><a href="?offset={math equation="max(x-10,0)" x=$offset}&amp;nameauthoryearstring={$smarty.request.nameauthoryearstring}&amp;genus={$smarty.request.genus}&amp;highertaxon={$smarty.request.highertaxon}&amp;UnitID={$smarty.request.UnitID}&amp;submit={$smarty.request.submit}&amp;db={$smarty.request.db}"><input type="button" class="button" value="Anterior"></a></span>
			{/if}
			{if $offset < $SearchTaxonResults.count-10}
			<span><a href="?offset={$offset+10}&amp;&amp;nameauthoryearstring={$smarty.request.nameauthoryearstring}&amp;genus={$smarty.request.genus}&amp;highertaxon={$smarty.request.highertaxon}&amp;UnitID={$smarty.request.UnitID}&amp;submit={$smarty.request.submit}&amp;db={$smarty.request.db}"><input type="button" class="button" value="Siguiente"></a></span>
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

{include file="newfooter.tpl"} 
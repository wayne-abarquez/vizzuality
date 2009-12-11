{include file="newheader.tpl"}

<div class="content">
<form action="sheetresult.php" method="get">

	<div class="titleIndex"><p>{$smarty.const.INTRO_TITLE} {$BDSelected}</p></div>
	
   <div class="news-body">
	  <div class="buscador">
	  <form action="sheetresult.php" method="get" name="thisform" id="thisform">
	  	<span class="search-1">{$smarty.const.NOMTAXON} <br />
		<input name="nameauthoryearstring" id="nameauthoryearstring" value="{$smarty.request.nameauthoryearstring}" size="30" style="width: 15em;" type="text">
		</span> 
		<span class="search-1">{$smarty.const.FAM}<br />
		<select name="highertaxon">
		  <option value="">{$smarty.const.TODOS}</option>
			{html_options values=$families output=$families}
		 </select>
		</span> 
		<span class="search-1">{$smarty.const.PAIS}<br />
		<select name="countryname">
		  <option value="">{$smarty.const.TODOS}</option>
		  {html_options values=$countries output=$countries}
		</select>
		</span> 
		<span class="search-1">{$smarty.const.RECOL}<br />
		<input name="agenttext" id="agenttext" value="{$smarty.request.agenttext}" size="30" style="width: 10em;" type="text">
		</span> 
		<span class="search-1">{$smarty.const.UTM}<br />
		<input name="utmformula" id="utmformula" value="{$smarty.request.utmformula}" size="8" style="width: 5em;" type="text">
		</span> 
		<span class="search-1">{$smarty.const.ORD}<br />
		<select name="orderby">
		  <option value="nameauthoryearstring" >{$smarty.const.NOMTAXON}</option>
		  <option value="highertaxon" >{$smarty.const.FAM}</option>
		  <option value="countryname" >{$smarty.const.PAIS}</option>
		  <option value="utmformula" >{$smarty.const.UTM}</option>
		</select>
		</span> <br>
		<span class="search-1">
		<input name="submit" value="{$smarty.const.BUTTONSEARCH}" type="submit" class="button">
		<input name="db" type="hidden" value="cormofitos">
		</span> 
		<br><br>
	  </form>
	  </div>
	  {if $SearchSheetsResults.hascoords}
	  <div class="Map" id="map"></div>
      {/if}
	<div class="trobats">
	{if !$SearchSheetsResults.datos}
	<p>0 {$smarty.const.RESULTADOS}</p><a href="#" onClick="javascript:window.history.back();">{$smarty.const.VOLVER}</a> 
	{else}
	<div class="paginator">
	{if $SearchSheetsResults.count > 10}
		<p>{$smarty.const.VIENDO} <b>{math equation="x+1" x=$offset} {$smarty.const.AL} {math equation="min(x2 +10,c)" x2=$offset c=$SearchSheetsResults.count}</b> {$smarty.const.DE} <b>{$SearchSheetsResults.count}</b> {$smarty.const.RESULTADOS}
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
			<p><b>{$smarty.const.LOCALITAT} </b>{$result.localitytext}<b> {$smarty.const.RECOL}</b> {$result.AgentText} ( <!--fecha-->	)</p>
		    <div class="news-details">  
	  		    <span>{if $result.has_images eq 0} 0 {$smarty.const.FOTOS} {else} {$result.has_images} {$smarty.const.FOTOS} {/if}</span> 
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
		<p>{$smarty.const.VIENDO} <b>{math equation="x+1" x=$offset} {$smarty.const.AL} {math equation="min(x2 +10,c)" x2=$offset c=$SearchSheetsResults.count}</b> {$smarty.const.DE} <b>{$SearchSheetsResults.count}</b> {$smarty.const.RESULTADOS}
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

{literal}<script src="http://maps.google.com/maps?file=api&v=2&key={/literal}{$smarty.const.MAPS_API_KEY}{literal}" type="text/javascript"></script>{/literal}

{literal}
<script type="text/javascript">
//<![CDATA[
var map;
if (GBrowserIsCompatible()) {
map = new GMap2(document.getElementById("map"));
map.setMapType(G_PHYSICAL_MAP);
map.addControl(new GSmallMapControl());
//map.addControl(new GMapTypeControl());
map.setCenter(new GLatLng(39,-3), 4);
geoXml = new GGeoXml("{/literal}{$kmlurl}{literal}", function() {
		if (geoXml.loadedCorrectly()) {
			geoXml.gotoDefaultViewport(map);
		}
	}
);
map.addOverlay(geoXml);
}

//]]>
</script>
{/literal}

{include file="newfooter.tpl"} 
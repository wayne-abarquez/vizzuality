{include file="newheader.tpl"}

<div class="content">
	<div class="titleIndex"><p>Base de dades de {$BDSelected} de l'Herbari de la Universitat de Barcelona (BCN)</p></div>
  
	<div class="news-body">
	    {if $hasGeo}
		    <div class="MapResult" id="map"></div>
		{/if}

		<div class="resultPliego"> 
		    <h2>{$Pliegos.scientificname} | {$Pliegos.family}</h2>
		    					
			{foreach key=UnitID item=result from=$Pliegos.datos}

			<div class="resultPliegoContainer">
				<div class="span-1 first shade-1" id="main0">
					<p><a href="sheetdetail.php?UnitID={$result.UnitID}&db={$smarty.session.db}">{$result.UnitID}</a></p>
				</div>
				<div class="pliego">
					<p>{$result.TypeStatus}</p>
					<p><b>Localitat: </b>{$result.localitytext}<b> Recollectors:</b> {$result.AgentText} ( <!--fecha-->	)</p>
				</div>
			</div>
			{/foreach}

	
		</div>
			  	 
	</div>
	
</div>

{if $hasGeo}
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
geoXml = new GGeoXml("{/literal}{$smarty.const.SERVER_URL}taxondetailKml.php?nameauthoryearstring={$smarty.request.nameauthoryearstring|urlencode}{literal}", function() {
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

{/if}
{include file="newfooter.tpl"}
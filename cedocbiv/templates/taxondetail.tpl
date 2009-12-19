{include file="header.tpl"}

<div class="content">
	<div class="titleIndexDetail"><p>{$BDSelected}</p></div>
	
	<div class="news-body">
		
		<div class="titleID">
			<div class="detailTitleTaxon">
				<p>{$Pliegos.scientificname}</p>
				<p class="family">{$Pliegos.family}</p>
			</div>
		</div>
		
		<div class="containerDetails">
    	{if $hasGeo}
			<div class="MapResultTaxon" id="map"></div>
		{/if}
		<div class="resultPliegoContainer">
		{foreach key=UnitID item=result from=$Pliegos.datos}
			<p><a href="sheetdetail.php?UnitID={$result.UnitID}&db={$smarty.session.db}">
				{if $BDSelected eq 'algas'}
					BCN-Phyc {$result.UnitID} 
				{/if}
				{if $BDSelected eq 'briofitos'} 
					BCN-Bryo {$result.UnitID}
				{/if}
				{if $BDSelected eq 'cormofitos'} 
					BCN {$result.UnitID}
				{/if}
				{if $BDSelected eq 'carpoteca'} 
					BCN-S {$result.UnitID}
				{/if}
				{if $BDSelected eq 'hongos'} 
					BCN-Myc {$result.UnitID}
				{/if}
				{if $BDSelected eq 'liquenes'} 
					BCN-Lich {$result.UnitID}
				{/if}
			</a></p>
			<p>{$result.TypeStatus}</p>
			<p><b>Localitat: </b>{$result.localitytext}<b> Recollectors:</b> {$result.AgentText} {if $result.photo}<img class="camera" src="/images/camera.png">{/if} {if $result.coords!=''} <img class="icon" src="/images/map.png"> {/if}</p>
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

{include file="footer.tpl"}
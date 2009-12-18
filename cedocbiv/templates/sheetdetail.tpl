{include file="header.tpl"}

<div class="content">
	<div class="titleIndexDetail"><p>{$BDSelected}</p></div>
	
	<div class="news-body">
		
		<div class="titleID">
			<div class="span-1 detailTitleID">
				{if $BDSelected eq 'algas'}
					<p>BCN-Phyc</p>
					<p>{$Ident[0].UnitID}</p>
				{/if}
				{if $BDSelected eq 'briofitos'}
					<p>BCN-Bryo</p>
					<p>{$Ident[0].UnitID}</p>
				{/if}
				{if $BDSelected eq 'cormofitos'}
					<p>BCN</p>
					<p>{$Ident[0].UnitID}</p>
				{/if}
				{if $BDSelected eq 'carpoteca'}
					<p>BCN-S</p>
					<p>{$Ident[0].UnitID}</p>
				{/if}
				{if $BDSelected eq 'hongos'}
					<p>BCN-Myc</p>
					<p>{$Ident[0].UnitID}</p>
				{/if}
				{if $BDSelected eq 'liquenes'}
					<p>BCN-Lich</p>
					<p>{$Ident[0].UnitID}</p>
				{/if}
			</div> 
			<div class="detailTitle">
				<p>{$Ident[0].NameAuthorYearString}</p>			
			</div>
		</div>
		
		<div class="containerDetails">
			{if ($Units.LatitudeDecimal != '' || $Units.LongitudeDecimal != '') || $Units.coords != ''}
				<div class="MapResult" id="map"></div>
			{/if}
			{if $Units.created_when}
			<div class="span-1 infoContainer">
				<div class="span-1 last infoLeft"><p class="detailInfo"><b>{$smarty.const.PUBLICAT}: </b></p></div>
				<div class="span-1 last infoRight"><p class="detailInfo">{$Units.created_when}</p></div>
			</div>
			{/if}
			
			<div class="span-4 titleGroup"></div>
			{if $Ident[0].HigherTaxon}
			<div class="span-1 infoContainer">
				<div class="span-1 last infoLeft"><p class="detailInfo"><b>{$smarty.const.FAM}: </b></p></div>
				<div class="span-1 last infoRight"><p class="detailInfo">{$Ident[0].HigherTaxon}</p></div>
			</div>
			{/if}
			
			{if $Ident[1].NameAuthorYearString}
			<div class="span-1 infoContainer">
				<div class="span-1 last infoLeft"><p class="detailInfo"><b>{$smarty.const.ETIQUETA}: </b></p></div>
				<div class="span-1 last infoRight"><p class="detailInfo">{$Ident[1].NameAuthorYearString}</p></div>
			</div>
			{/if}
			
			{if $Ident[0].NameAuthorYearString}
			<div class="span-1 infoContainer">
				<div class="span-1 last infoLeft"><p class="detailInfo"><b>{$smarty.const.GUARDAT}: </b></p></div>
				<div class="span-1 last infoRight"><p class="detailInfo">{$Ident[0].NameAuthorYearString}</p></div>
			</div>
			{/if}
			 
			<div class="span-4 titleGroup"></div>
			{if $Units.LocalityText}
			<div class="span-1 infoContainer">
				<div class="span-1 last infoLeft"><p class="detailInfo"><b>{$smarty.const.LOCALITAT}: </b></p></div>
				<div class="span-1 last infoRight"><p class="detailInfo">{$Units.LocalityText}</p></div>
			</div>
			{/if}
			
			{if $Units.CountryName}
			<div class="span-1 infoContainer">
				<div class="span-1 last infoLeft"><p class="detailInfo"><b>{$smarty.const.PAIS}: </b></p></div>
				<div class="span-1 last infoRight"><p class="detailInfo">{$Units.CountryName}</p></div>
			</div>
			{/if}
			
			{if $isAlt}
			<div class="span-1 infoContainer">
				<div class="span-1 last infoLeft"><p class="detailInfo"><b>{$smarty.const.ALTITUD}: </b></p></div>
				<div class="span-1 last infoRight"><p class="detailInfo">{if $Units.AltitudeLowerValue}{$Units.AltitudeLowerValue} m{/if}{if $Units.AltitudeUpperValue} - {$Units.AltitudeUpperValue} m{/if}</p></div>
			</div>
			{/if}
			
			{if $Units.BiotopeText}
			<div class="span-1 infoContainer">
				<div class="span-1 last infoLeft"><p class="detailInfo"><b>{$smarty.const.HABITAT}: </b></p></div>
				<div class="span-1 last infoRight"><p class="detailInfo">{$Units.BiotopeText}</p></div>
			</div>
			{/if}
			
			{if $Units.UTMText}
			<div class="span-1 infoContainer">
				<div class="span-1 last infoLeft"><p class="detailInfo"><b>{$smarty.const.UTM}: </b></p></div>
				<div class="span-1 last infoRight"><p class="detailInfo">{$Units.UTMText}</p></div>
			</div>
			{/if}
						
			<div class="span-4 titleGroup"></div>
			{if $Agents.GatheringAgentsText}
			<div class="span-1 infoContainer">
				<div class="span-1 last infoLeft"><p class="detailInfo"><b>{$smarty.const.RECOL}: </b></p></div>
				<div class="span-1 last infoRight"><p class="detailInfo">{$Agents.GatheringAgentsText}</p></div>
			</div>
			{/if}
			
			{if $Units.ISODateTimeBegin}
			<div class="span-1 infoContainer">
				<div class="span-1 last infoLeft"><p class="detailInfo"><b>{$smarty.const.DATAREC}: </b></p></div>
				<div class="span-1 last infoRight"><p class="detailInfo">{$Units.ISODateTimeBegin}</p></div>
			</div>
			{/if}

			<div class="span-4 titleGroup"></div>
			{if $Units.ProjectTitle}
			<div class="span-1 infoContainer">
				<div class="span-1 last infoLeft"><p class="detailInfo"><b>{$smarty.const.COL}: </b></p></div>
				<div class="span-1 last infoRight"><p class="detailInfo">{$Units.ProjectTitle}</p></div>
			</div>
			{/if}
			
			{if $Units.Phenology}
			<div class="span-1 infoContainer">
				<div class="span-1 last infoLeft"><p class="detailInfo"><b>{$smarty.const.FEN}: </b></p></div>
				<div class="span-1 last infoRight"><p class="detailInfo">{$Units.Phenology}</p></div>
			</div>
			{/if}

			<div class="span-4 titleGroup"></div>
			{if $Images}
			<div>
			<p class="detailInfo">{$smarty.const.IMG}</p>
			{foreach key=UnitID item=Image from=$Images.imagenes}
				<a href="{$Image.ImageURI}">{$Image.ImageURI}</a><br />
			{/foreach}
			</div>
			{/if}
		</div>
	</div>
	
</div>

{if ($Units.LatitudeDecimal != '' || $Units.LongitudeDecimal != '') || $Units.coords != ''}

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
	geoXml = new GGeoXml("{/literal}{$smarty.const.SERVER_URL}{literal}sheetdetailKml.php?UnitID={/literal}{$Ident[0].UnitID}{literal}", function() {
		
	if (geoXml.loadedCorrectly()) {
		geoXml.gotoDefaultViewport(map);
		{/literal}{if $isUtm eq false}{literal}
		    map.setZoom(map.getZoom()-6);
		{/literal}{else}{literal}
	    	map.setZoom(map.getZoom()-1);
		{/literal}{/if}{literal}
	}
		
	});
	map.addOverlay(geoXml);
	}
	//]]>
</script>
{/literal}

{/if}

{include file="footer.tpl"}
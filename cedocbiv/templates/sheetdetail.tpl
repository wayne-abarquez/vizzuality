{include file="header.tpl"}

<div class="content">
	<div class="titleIndex"><p>Base de dades de {$BDSelected} de l'Herbari de la Universitat de Barcelona (BCN)</p></div>
  
	<div class="news-body">
		{if ($Units.LatitudeDecimal != '' || $Units.LongitudeDecimal != '') || $Units.coords != ''}
		<div class="MapResult" id="map"></div>
		{/if}
		
		<div class="span-1 first shade-1" id="main0">
			<p><a>{$Ident[0].UnitID}</a></p>
		</div>
		
		<div class="pliego">
		
		  <p class="title"> {$Ident[0].NameAuthorYearString} </p>
	
		  <p><b>{$smarty.const.PUBLICAT}</b> {$Units.created_when}</p>
		  
		  <p><b>{$smarty.const.FAM}</b> {$Ident[0].HigherTaxon}</p> 
			  		
	  	  <p><b>{$smarty.const.ETIQUETA}</b> {$Ident[1].NameAuthorYearString}</p> 
		  		  		
		  <p><b>{$smarty.const.GUARDAT}</b> {$Ident[0].NameAuthorYearString}</p> 
		 	  
		  <p><b>{$smarty.const.LOCALITAT}</b> {$Units.LocalityText}</p> 
		  
		  <p><b>{$smarty.const.PAIS}</b> {$Units.CountryName}</p> 
		  	  
		  <p><b>{$smarty.const.ALTITUD}</b> {$Units.AltitudeLowerValue} - {$Units.AltitudeUpperValue}</p> 
		  	  
		  <p><b>{$smarty.const.RECOL}</b> {$Agents.GatheringAgentsText}</p> 
		  	   
		  <p><b>{$smarty.const.HABITAT}</b> {$Units.BiotopeText}</p> 
		  
	<!-- 	  meter CollectorNumber -->
	
		  <p><b>{$smarty.const.DATAREC}</b> 25-05-1985</p> 
		  	  
		  <p><b>{$smarty.const.COL}</b> {$Units.ProjectTitle}</p> 
		  
		  <p><b>{$smarty.const.FEN}</b> {$Units.Phenology}</p> 
		  
		  {if $Images}
		  <div>
		  <p>{$smarty.const.IMG}</p>
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
			{/literal}{/if}{literal}
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
{include file="newheader.tpl"}

<div class="content">
	<div class="titleIndex"><p>Base de dades de {$BDSelected} de l'Herbari de la Universitat de Barcelona (BCN)</p></div>
  
	<div class="news-body">
		{if ($Units.LatitudeDecimal != '' || $Units.LongitudeDecimal != '') || $Units.UTMText != ''}
		<div class="MapResult" id="map"></div>
		{/if}
		
		<div class="span-1 first shade-1" id="main0">
			<p><a>{$Ident[0].UnitID}</a></p>
		</div>
		
		<div class="pliego">
		
		  <p class="title"> {$Ident[0].NameAuthorYearString} </p>
	
		  <p>Publicat el {$Units.created_when}</p>
		  
		  <p><b>Família:</b> {$Ident[0].HigherTaxon}</p> 
			  		
	  	  <p><b>Nom etiqueta:</b> {$Ident[1].NameAuthorYearString}</p> 
		  		  		
		  <p><b>Guardat com:</b> {$Ident[0].NameAuthorYearString}</p> 
		 	  
		  <p><b>Localitat:</b> {$Units.LocalityText}</p> 
		  
		  <p><b>País:</b> {$Units.CountryName}</p> 
		  	  
		  <p><b>Altitud:</b> {$Units.AltitudeLowerValue} - {$Units.AltitudeUpperValue}</p> 
		  	  
		  <p><b>Recollectors:</b> {$Agents.GatheringAgentsText}</p> 
		  	   
		  <p><b>Hábitat:</b> {$Units.BiotopeText}</p> 
		  
	<!-- 	  meter CollectorNumber -->
	
		  <p><b>Data de recollecció:</b> 25-05-1985</p> 
		  	  
		  <p><b>Collecció:</b> {$Units.ProjectTitle}</p> 
		  
		  <p><b>Fenologia:</b> {$Units.Phenology}</p> 
		  
		  {if $Images}
		  <div>
		  <p>Imagenes</p>
	    	{foreach key=UnitID item=Image from=$Images.imagenes}
	    		<a href="{$Image.ImageURI}">{$Image.ImageURI}</a><br />
	    	{/foreach}
		  </div>
		  {/if}

		</div>
	  	 
	</div>
	
</div>

{literal}<script src="http://maps.google.com/maps?file=api&v=2&key={/literal}{$smarty.const.MAPS_API_KEY}{literal}" type="text/javascript"></script>{/literal}

{literal}
<script type="text/javascript">
//<![CDATA[
var map;
if (GBrowserIsCompatible()) {
map = new GMap(document.getElementById("map"));
map.setCenter(new GLatLng(39,-3), 4);
geoXml = new GGeoXml("{/literal}{$smarty.const.SERVER_URL}{literal}sheetdetailKml.php?UnitID={/literal}{$Ident[0].UnitID}{literal}", function() {
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
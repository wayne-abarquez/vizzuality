{include file="newheader_en.tpl"}

<div class="content">
	<div class="titleIndex"><p>Base de dades de {$BDSelected} de l'Herbari de la Universitat de Barcelona (BCN)</p></div>
  
	<div class="news-body">
		<div class="MapResult" id="map"></div>

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

{include file="newfooter_en.tpl"}
{include file="newheader_es.tpl"}

<div class="content">
	<div class="titleIndex"><p>Base de dades de {$BDSelected} de l'Herbari de la Universitat de Barcelona (BCN)</p></div>
  
	<div class="news-body">
		<div class="MapResult" id="map"></div>
		

		<div class="resultPliego"> 
			{foreach key=UnitID item=result from=$Pliegos}

			<div class="resultPliegoContainer">
				<div class="span-1 first shade-1" id="main0">
					<p><a>{$result.UnitID}</a></p>
				</div>
				<div class="pliego">
					<a href="sheetdetail.php?UnitID={$result.UnitID}&amp;db={$BDSelected}"><p class="title">{$result.nameauthoryearstring}</p></a>
					<p>{$result.highertaxon} | {$result.TypeStatus}</p>
					<p><b>Localitat: </b>{$result.localitytext}<b> Recollectors:</b> {$result.AgentText} ( <!--fecha-->	)</p>
				</div>
			</div>
			{/foreach}

	
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

{include file="newfooter_es.tpl"}
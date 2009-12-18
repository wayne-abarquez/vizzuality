{include file="header.tpl"}

{literal}
<script type="text/javascript" >
	$(document).ready(function(){
	var visibilidad = false;
	cargarmapa();
	
	$(".btn-slide").click(function(){

	  if (!visibilidad){
	     $("#map").slideDown('Slow',function(){visibilidad=true; })
	  } else {
	     $("#map").slideUp('Slow',function(){visibilidad=false; })
	  }
	});
});

</script>
{/literal}

<div class="content">
	<div class="news-body">
		<div class="navigator">
			<div class="span-1 last breadCrumb">
				<ul>
					<li class="arrowList">{$BDSelected}</li>
					<li>{$smarty.request.submit}</li>
				</ul>
			</div>
			
			{if !$SearchTaxonResults.datos}
			<div class="last paginator noresults">
			<p class="torna">0 {$smarty.const.RESULTADOS}...  <a class="tornaLink" href="#" onClick="javascript:window.history.back();">{$smarty.const.VOLVER}</a></p>
			</div>
			{else}
				<div class="last paginator">
				{if $SearchTaxonResults.count > 10}
				<p>{$smarty.const.VIENDO} <b>{math equation="x+1" x=$offset} {$smarty.const.AL} {math equation="min(x2 +10,c)" x2=$offset c=$SearchTaxonResults.count}</b> {$smarty.const.DE} <b>{$SearchTaxonResults.count}</b> {$smarty.const.RESULTADOS}
				{if $offset > 0}
				<span><a href="?offset={math equation="max(x-10,0)" x=$offset}&amp;nameauthoryearstring={$smarty.request.nameauthoryearstring}&amp;genus={$smarty.request.genus}&amp;highertaxon={$smarty.request.highertaxon}&amp;UnitID={$smarty.request.UnitID}&amp;submit={$smarty.request.submit}&amp;db={$smarty.request.db}"><input type="button" class="leftPaginator"></a></span>
				{/if}
				{if $offset < $SearchTaxonResults.count-10}
				<span><a href="?offset={$offset+10}&amp;&amp;nameauthoryearstring={$smarty.request.nameauthoryearstring}&amp;genus={$smarty.request.genus}&amp;highertaxon={$smarty.request.highertaxon}&amp;UnitID={$smarty.request.UnitID}&amp;submit={$smarty.request.submit}&amp;db={$smarty.request.db}"><input type="button" class="rightPaginator"></a></span>
		    	{/if}	
				</p>	
				{/if}
				</div>
			{/if}		
		</div>
		{if $SearchTaxonResults.hascoords}
  			<div class="Map" id="map"></div>
    		<div class="slide"><p><a href="#" class="btn-slide">{$smarty.const.VISSUALMAP}</a></p></div>	
  		{/if}
	      	
	  	<div class="containerResult">
			{foreach key=UnitID item=result from=$SearchTaxonResults.datos}
      		<div class="result" onmouseover="this.className='result activo'" onmouseout="this.className='result inactivo'" onclick="location.href='taxondetail.php?nameauthoryearstring={$result.nameauthoryearstring}&amp;db={$BDSelected}';">
      			<p class="resultTitle"><a href="taxondetail.php?nameauthoryearstring={$result.nameauthoryearstring}&amp;db={$BDSelected}"> 
				{$result.UnitID}. {$result.nameauthoryearstring}</a></p>
      			<p class="resultTaxon">{$result.highertaxon} {$result.TypeStatus}</p>
      			<p class="resultLocal">{$result.locality|truncate:100:"..."}</p>
      			<p class="resultFotos">{$result.num_sheets} pliegos | Altitud: {if $result.altitudUpper}{$result.altitudUpper} m{else}0 m{/if} - {if $result.altitudLower}{$result.altitudLower} m{else}0 m{/if} | {if $result.has_images}{$result.has_images} fotos{else} 0 fotos{/if}</p>
      		</div>
			{/foreach}
      	</div>
      	
	</div> <!-- news-body -->
	
</div> <!-- content -->

{literal}<script src="http://maps.google.com/maps?file=api&v=2&key={/literal}{$smarty.const.MAPS_API_KEY}{literal}" type="text/javascript"></script>{/literal}

{literal}

<script type="text/javascript">
	function cargarmapa(){
		//<![CDATA[
		var map;
		if (GBrowserIsCompatible()) {
		map = new GMap2(document.getElementById("map"),{size:new GSize (950,300)});
		map.setMapType(G_PHYSICAL_MAP);
		map.addControl(new GSmallMapControl());
		//map.addControl(new GMapTypeControl());
		map.setCenter(new GLatLng(39,-3), 4);
		geoXml = new GGeoXml("{/literal}{$smarty.const.SERVER_URL}sheetresultKml.php{$kmlurl}{literal}", function() {
		if (geoXml.loadedCorrectly()) {
			geoXml.gotoDefaultViewport(map);
		}
	}
);
map.addOverlay(geoXml);
}

//]]>
}
</script>
{/literal}

{include file="footer.tpl"}
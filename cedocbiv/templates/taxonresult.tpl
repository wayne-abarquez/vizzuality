{include file="header.tpl"}

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
			<p>0 {$smarty.const.RESULTADOS}</p><a href="#" onClick="javascript:window.history.back();">{$smarty.const.VOLVER}</a> 
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
    		<div class="slide"><p><a href="#" class="btn-slide">Visualizar mapa</a></p></div>	
  		{/if}
	      	
	  	<div class="containerResult">
			{foreach key=UnitID item=result from=$SearchTaxonResults.datos}
      		<div class="result" onmouseover="this.className='result activo'" onmouseout="this.className='result inactivo'" onclick="location.href='taxondetail.php?nameauthoryearstring={$result.nameauthoryearstring}&amp;db={$BDSelected}';">
      			<p class="resultTitle"><a href="taxondetail.php?nameauthoryearstring={$result.nameauthoryearstring}&amp;db={$BDSelected}"> 
				{$result.UnitID}. {$result.nameauthoryearstring}</a></p>
      			<p class="resultTaxon">{$result.highertaxon} {$result.TypeStatus}</p>
      			<p class="resultLocal">{$result.locality|truncate:100:"..."}</p>
      			<p class="resultFotos">{$result.num_sheets} pliegos | Altitud: {$result.altitudUpper} - {$result.altitudLower} | {$result.has_images} fotos</p>
      		</div>
			{/foreach}
      	</div>
      	
	</div> <!-- news-body -->
	
</div> <!-- content -->

{include file="footer.tpl"} 
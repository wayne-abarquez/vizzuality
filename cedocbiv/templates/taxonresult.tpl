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
			
			{if !$SearchSheetsResults.datos}
			<p>0 {$smarty.const.RESULTADOS}</p><a href="#" onClick="javascript:window.history.back();">{$smarty.const.VOLVER}</a> 
			{else}
				<div class="last paginator">
				{if $SearchSheetsResults.count > 10}
				<p>{$smarty.const.VIENDO} <b>{math equation="x+1" x=$offset} {$smarty.const.AL} {math equation="min(x2 +10,c)" x2=$offset c=$SearchSheetsResults.count}</b> {$smarty.const.DE} <b>{$SearchSheetsResults.count}</b> {$smarty.const.RESULTADOS}
				{if $offset > 0}
				<span><a class="paginatorA" href="?offset={math equation="max(x-10,0)" x=$offset}&amp;nameauthoryearstring={$smarty.request.nameauthoryearstring}&amp;genus={$smarty.request.genus}&amp;highertaxon={$smarty.request.highertaxon}&amp;localitytext={$smarty.request.localitytext}&amp;countryname={$smarty.request.countryname}&amp;utmformula={$smarty.request.utmformula}&amp;agenttext={$smarty.request.agenttext}&amp;datesearchtype={$smarty.request.datesearchtype}&amp;datetext={$smarty.request.datetext}&amp;UnitID={$smarty.request.UnitID}&amp;submit={$smarty.request.submit}&amp;db={$smarty.request.db}"><input type="button" class="leftPaginator"></a></span>
				{/if}
				{if $offset < $SearchSheetsResults.count-10}
				<span><a class="paginatorA"  href="?offset={$offset+10}&amp;&amp;nameauthoryearstring={$smarty.request.nameauthoryearstring}&amp;genus={$smarty.request.genus}&amp;highertaxon={$smarty.request.highertaxon}&amp;localitytext={$smarty.request.localitytext}&amp;countryname={$smarty.request.countryname}&amp;utmformula={$smarty.request.utmformula}&amp;agenttext={$smarty.request.agenttext}&amp;datesearchtype={$smarty.request.datesearchtype}&amp;datetext={$smarty.request.datetext}&amp;UnitID={$smarty.request.UnitID}&amp;submit={$smarty.request.submit}&amp;db={$smarty.request.db}"><input type="button" class="rightPaginator"></a></span>
		    	{/if}	
				</p>	
				{/if}
				</div>
			{/if}		
		</div>
		{if $SearchSheetsResults.hascoords}
  			<div class="Map" id="map"></div>
    		<div class="slide"><p><a href="#" class="btn-slide">Visualizar mapa</a></p></div>	
  		{/if}
	      	
	  	<div class="containerResult">
	  		{foreach key=UnitID item=result from=$SearchSheetsResults.datos}
      		<div class="result" onmouseover="this.className='result activo'" onmouseout="this.className='result inactivo'" onclick="location.href='taxondetail.php?nameauthoryearstring={$result.nameauthoryearstring}&amp;db={$BDSelected}';">
      			<p class="resultTitle"><a href="taxondetail.php?nameauthoryearstring={$result.nameauthoryearstring}&amp;db={$BDSelected}">{$result.nameauthoryearstring}</a></p>
      			<p class="resultTaxon">{$result.highertaxon}</p>
      			<p class="resultLocal">{$result.num_sheets} pliego(s) | {$result.num_georef} georef.  | {$result.num_images} foto(s)</p>
      		</div>
			{/foreach}
      	</div>
      	
	</div> <!-- news-body -->
	
</div> <!-- content -->

{include file="footer.tpl"} 
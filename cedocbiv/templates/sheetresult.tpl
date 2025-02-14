{include file="header.tpl"}

<div class="content">
	<div class="news-body">
		<div class="navigator">
			<div class="span-1 last breadCrumb">
				<ul>
					<li class="arrowList"><a href="index.php">{$smarty.const.BASES_DE_DADES}</a></li>
					<li class="arrowList"><a href="query.php?db={$BDSelected}">{$BDSelected}</a></li>
				</ul>
			</div>
			
			{if !$SearchSheetsResults.datos}
			<div class="last paginator noresults">
			<p class="torna">0 {$smarty.const.RESULTADOS}... 	<input value="{$smarty.const.BUTTONNEWSEARCH}" type="button" class="buttonLong" onClick="javascript:window.history.back();"/>
			</p>
			</div>
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
				<input value="{$smarty.const.BUTTONNEWSEARCH}" type="button" class="buttonLong" onClick="javascript:window.history.back();"/>
				</p>	
				{/if}
				</div>
			{/if}		
		</div>
	      	
	  	<div class="containerResult">
	  		{foreach key=UnitID item=result from=$SearchSheetsResults.datos}
      		<div class="result" onmouseover="this.className='result activo'" onmouseout="this.className='result inactivo'" onclick="location.href='taxondetail.php?nameauthoryearstring={$result.nameauthoryearstring|escape:'url'}&amp;db={$BDSelected}';">
      			<p class="resultTitle"><a href="taxondetail.php?nameauthoryearstring={$result.nameauthoryearstring|escape:'url'}&amp;db={$BDSelected}">{$result.nameauthoryearstring}</a></p>
      			<p class="resultTaxon">{$result.highertaxon}</p>
      			<p class="resultLocal">{$result.num_sheets} pliego(s) | {$result.num_georef} georef.  | {$result.num_images} foto(s)

{if $result.num_images>0}<img class="camera" src="images/camera.png">{/if} {if $result.num_georef>0} <img class="icon" src="images/google_marker_red.jpg"> {/if}			    
      			    </p>
      		</div>
			{/foreach}
      	</div>
      	
	</div> <!-- news-body -->
	
</div> <!-- content -->

{include file="footer.tpl"} 
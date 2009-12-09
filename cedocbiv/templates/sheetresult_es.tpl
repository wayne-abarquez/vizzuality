{include file="newheader_es.tpl"}

<div class="content">
<form action="sheetresult.php" method="get">
  <div id="searchform"> 
	<h3><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Cerca a la 
	  base de dades {$BDSelected} de l'Herbari de la Universitat de Barcelona (BCN) </font></h3>
	<div> 
	  <div class="buscador"> <font face="Verdana, Arial, Helvetica, sans-serif" size="2"><span class="search-2"><strong>Nom 
		del tàxon:</strong><br />
		<input name="nameauthoryearstring" id="nameauthoryearstring" value="" size="30" style="width: 15em;" type="text">
		</span> <span class="search-2"><strong>Família:</strong><br />
		<select name="highertaxon">
		  <option value="">Totes</option>
			{html_options values=$families output=$families}
		 </select>
		</span> <span class="search-2"><strong>País:</strong><br />
		<select name="countryname">
		  <option value="">Tots</option>
		  {html_options values=$countries output=$countries}
		</select>
		</span> <span class="search-2"><strong>Recol·lectors:</strong><br />
		<input name="agenttext" id="agenttext" value="" size="30" style="width: 10em;" type="text">
		</span> <span class="search-2"><strong>UTM:</strong><br />
		<input name="utmformula" id="utmformula" value="" size="8" style="width: 5em;" type="text">
		</span> <span class="search-1"><strong>Ordenat per:</strong><br />
		<select name="orderby">
		  <option value="nameauthoryearstring" >Nom 
		  tàxon</option>
		  <option value="highertaxon" >Família</option>
		  <option value="countryname" >País</option>
		  <option value="utmformula" >UTM</option>
		</select>
		</span> <br>
		<input name="db" type="hidden" value="cormofitos">
		<input name="submit" value="Cerca" type="submit">
		</font></div>
	</div>
  </div>
</form>
<div style="float: right;"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><a href="bdresult3_cat.php" class="positive">Veure 
  tots els resultats</a></font></div>
<font face="Verdana, Arial, Helvetica, sans-serif" size="2"> 
</font> 
{if !$SearchSheetsResults}
<h3><font face="Verdana, Arial, Helvetica, sans-serif" size="2">0 Resultats trobats</font></h3>
<font face="Verdana, Arial, Helvetica, sans-serif" size="2">No hi ha resultats. 
<a href="#" onClick="javascript:window.history.back();">Torna</a> 
</font> 
{else}
<h3> <font face="Verdana, Arial, Helvetica, sans-serif" size="2"> 
  {$SearchSheetsResults|@count} Resultats trobats</font></h3>
{/if}

{section name=resultado loop=$SearchSheetsResults}
<font face="Verdana, Arial, Helvetica, sans-serif" size="2"> 

<!-- Agents? -->

</font> 
<div class="news-summary" style="z-index: 1000;"> 
  <div class="news-body"> 
	<h3><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><a href="sheetdetail.php?UnitID={$SearchSheetsResults[resultado].UnitID}&db={$BDSelected}"> 
	{$SearchSheetsResults[resultado].nameauthoryearstring}
	  </a></font></h3>
	<p class="news-submitted"> <font face="Verdana, Arial, Helvetica, sans-serif" size="2"> 
	  {$SearchSheetsResults[resultado].highertaxon} | {$SearchSheetsResults[resultado].TypeStatus}
	  </font></p>
	<p> <font face="Verdana, Arial, Helvetica, sans-serif" size="2"> 
	  <b>Localitat:</b> 
	  {$SearchSheetsResults[resultado].localitytext}
	  <b>Recol&middot;lectors:</b> 
	  {$SearchSheetsResults[resultado].AgentText}
	  ( 
<!-- 	  fecha -->
	  ) 
	  </font></p>
	  
<!-- 	  revisar georeferenciados -->
	<div class="news-details"> <font face="Verdana, Arial, Helvetica, sans-serif" size="2"> 
	  <span class="tool">{if $SearchSheetsResults[resultado].has_images eq 0} 0 fotos {else} {$SearchSheetsResults[resultado].has_images} fotos {/if}</span> 
	  <span class="tool">No georeferenciat</span> 
	  </font></div>
  </div>
  <ul class="news-digg">
	<li class="digg-count shade-1" id="main0"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><a href="sheetdetail.php?UnitID={$SearchSheetsResults[resultado].UnitID}&db={$BDSelected}"><strong id="diggs-strong-0">{$SearchSheetsResults[resultado].UnitID} BCN<br>
	  </strong></a></font></li>
  </ul>
</div>
  {/section}
</div>


{include file="newfooter_es.tpl"} 
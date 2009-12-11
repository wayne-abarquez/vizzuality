{include file="newheader.tpl"}
						
{literal}
<script type="text/javascript" src="js/tabber.js"></script>
{/literal}

<div class="content">
<div class="news-body">
  <div class="titleIndex"><p>{$smarty.const.INTRO_TITLE} {$BDSelected}</p></div>
  <div class="TextBD">
  {if $BDSelected eq "cormofitos"}
  <p class="texto_intro"> {$smarty.const.INTRO_TEXTBD3} <a href="mailto:cedocbiv@pcb.ub.es">{$smarty.const.INTRO_TEXTCONTACT}</a></p>
  {/if}
  
  {if $BDSelected eq "algas"} 
  <p class="texto_intro"> {$smarty.const.INTRO_TEXTBD1} <a href="mailto:cedocbiv@pcb.ub.es">{$smarty.const.INTRO_TEXTCONTACT}</a></p></p>
  {/if}
  
  {if $BDSelected eq "briofitos"} 
  <p class="texto_intro"> {$smarty.const.INTRO_TEXTBD2} <a href="mailto:cedocbiv@pcb.ub.es">{$smarty.const.INTRO_TEXTCONTACT}</a></p>
  {/if}
  
  {if $BDSelected eq "carpoteca"} 
  <p class="texto_intro"> {$smarty.const.INTRO_TEXTBD4} <a href="http://www.ub.es/cedocbiv/indexcar.htm">{$smarty.const.INTRO_TEXTHERBARI}</a>
  </p>
  {/if}
  
  {if $BDSelected eq "hongos"} 
  <p class="texto_intro">{$smarty.const.INTRO_TEXTBD5} <a href="mailto:cedocbiv@pcb.ub.es">{$smarty.const.INTRO_TEXTCONTACT}</a></p>
  {/if}
  
  {if $BDSelected eq "liquenes"} 
  <p class="texto_intro">{$smarty.const.INTRO_TEXTBD6} <a href="mailto:cedocbiv@pcb.ub.es">{$smarty.const.INTRO_TEXTCONTACT}</a></p>
  {/if}
  <p class="info">{$smarty.const.ACTUAL} <b>{$LastUpdate}</b> | {$smarty.const.REG} <b>{$Numregistros}</b> | {$smarty.const.INTRO_TEXTAST}</p>
  </div>
  
<div class="tabber">
   <div class="tabbertab">
	  <div id="queryForm" class="buscador"> 
	     <form action="sheetresult.php" method="get" name="thisform" id="thisform">
	     <h2>{$smarty.const.TITLE_TABPLIEGO}</h2>
	     <div class="instruction"> 
		    <div>
		    <span class="search-1"> 
		  		<label for="search">{$smarty.const.NOMTAXON} </label> (Acro*)<br />
		 		<input name="nameauthoryearstring" id="nameauthoryearstring" size="30" style="width: 15em;" type="text" />
		  	</span>
		  	<span class="search-1"><strong>{$smarty.const.GEN} </strong> (Acant*) <br />
			<select name="genus">
				<option value="">{$smarty.const.TODOS}</option>
				{html_options values=$genus output=$genus}
			</select>	
		    </span> 
		    <span class="search-2"><strong>{$smarty.const.FAM}</strong><br />
			<select name="highertaxon">
				<option value="">{$smarty.const.TODOS}</option>
				{html_options values=$families output=$families}
			</select>			
		    </span><br />
		    <br />
		    <br />
		    <span class="search-1"> 
		       <label for="search">{$smarty.const.LOCALITAT}</label> (*Balagu*)<br />
		       <input name="localitytext" id="localitytext" size="30" style="width: 15em;" type="text" />
		    </span> 
		    <span class="search-1"><strong>{$smarty.const.PAIS}</strong><br />
		       <select name="countryname">
			   <option value="">{$smarty.const.TODOS}</option>
			   {html_options values=$countries output=$countries}
		       </select>
		    </span> 
		    <span class="search-2"><strong>{$smarty.const.UTM}</strong> (31TCG65) <br />
		       <input name="utmformula" id="utmformula" size="8" style="width: 5em;" type="text" />
		    </span>
		    <br />
		  	<br />
		  	<br />
		    <span class="search-1"><strong>{$smarty.const.RECOL}</strong> (*Sennen*)<br />
		       <input name="agenttext" id="agenttext" size="30" style="width: 15em;" type="text" />
		    </span> 
		    <span class="search-2"><strong>{$smarty.const.DATAREC}</strong> (1984-05-14)<br />
		        <select name="datesearchtype" size="1" id="datesearchtype">
			    <option value="greaterthan">{$smarty.const.ABANS}</option>
			    <option value="lessthan">{$smarty.const.DESPRES}</option>
			    <option value="equal">{$smarty.const.IGUAL}</option>
		        </select>
		  		<input name="datetext" id="datetext" size="8" style="width: 5em;">
		  	</span> 
		  	<br />
		    <br />
		    <br />
		    <span class="search-1"><strong>{$smarty.const.NUMHERB} </strong> (104*)<br />BCN 
		    	<input name="UnitID" id="UnitID" size="30" style="width: 5em;" type="text" />
		  	</span> 
		  	<span class="search-1"><input name="submit" value="{$smarty.const.BUTTONSEARCH}" type="submit" class="button topmargin"/></span>
		  	<input name="db" type="hidden" value="{$BDSelected}">
		  	<br />
		  	<br />
		  </div>
	  </div>
	</form>
  </div>
	  
     </div> <!-- del tab de pliego -->


     <div class="tabbertab">
	  
	<div id="queryForm2" class="buscador"> 
	<form action="taxonresult.php" method="get" name="thisform" id="thisform">
	  <h2>{$smarty.const.TITLE_TABTAXON}</h2>
	  <div class="instruction"> 
		<div>
		  <span class="search-1"> 
		     <label for="search">{$smarty.const.NOMTAXON} </label> (Acro*)<br />
		     <input name="nameauthoryearstring" id="nameauthoryearstring" size="30" style="width: 15em;" type="text" />
		  </span> 
		  <span class="search-1"><strong>{$smarty.const.GEN} </strong> (Acant*) <br />
			<select name="genus">
				<option value="">{$smarty.const.TODOS}</option>
				{html_options values=$genus output=$genus}
			</select>	
		  </span> 
		  <span class="search-1"><strong>{$smarty.const.FAM}</strong><br />
			<select name="highertaxon">
				<option value="">{$smarty.const.TODOS}</option>
				{html_options values=$families output=$families}
			</select>			
		  </span>
		  <br />
		  <span class="search-1"><input name="submit" value="{$smarty.const.BUTTONSEARCH}" type="submit" class="button"/></span>
		  <input name="db" type="hidden" value="{$BDSelected}">
		  <br />
		  <br />
		  </font></div>
	  </div>
	</form>
  </div>
	  
</div>

						
{include file="newfooter.tpl"} 
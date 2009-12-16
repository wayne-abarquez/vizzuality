{include file="header.tpl"}
						
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
			    
			    	<div class="fila"> 
			    		<div class="span-1 last inputContainer">
			    			<p>{$smarty.const.NOMTAXON} <b>(Acro*)</b></p> 
				 			<input name="nameauthoryearstring" id="nameauthoryearstring" class="inputDataLong" type="text" />
			    		</div>
			    		
			    		<div class="span-1 last inputContainer2">
			    			<p>{$smarty.const.GEN} <b>(Acant*)</b></p> 
							<select name="genus" class="inputSelect">
								<option value="">{$smarty.const.TODOS}</option>
								{html_options values=$genus output=$genus}
							</select>
			    		</div>
			    		
			    		<div class="span-1 last inputContainer2">
							<p>{$smarty.const.FAM}</p>
							<select name="highertaxon" class="inputSelect">
								<option value="">{$smarty.const.TODOS}</option>
								{html_options values=$families output=$families}
							</select>	
			    		</div>
			    	</div>
			    	
			    	<div class="fila">
			    		<div class="span-1 last inputContainer">
				       		<p>{$smarty.const.LOCALITAT} <b>(*Balagu*)</b></p> 
				       		<input name="localitytext" id="localitytext" class="inputDataLong" type="text" />
			    		</div>
			    		<div class="span-1 last inputContainer2">
			    			<p>{$smarty.const.PAIS}</p>
				       		<select name="countryname" class="inputSelect">
					   			<option value="">{$smarty.const.TODOS}</option>
					   			{html_options values=$countries output=$countries}
				       		</select>
			    		</div>
			    		<div class="span-1 last inputContainer2">
			    			<p>{$smarty.const.UTM} <b>(31TCG65)</b></p>  
				       		<input name="utmformula" id="utmformula" class="inputDataSmall" type="text" />
			    		</div>
			    	</div>
			    	
			    	<div class="fila">
			    		<div class="span-1 last inputContainer">
				       		<p>{$smarty.const.RECOL} <b>(*Sennen*)</b><p>
				       		<input name="agenttext" id="agenttext" class="inputDataLong" type="text" />
			    		</div>
			    		<div class="span-1 last inputContainer2">
			    			<p>{$smarty.const.DATAREC}<p>
				        	<select name="datesearchtype" size="1" id="datesearchtype" class="inputSelect">
					    		<option value="greaterthan">{$smarty.const.ABANS}</option>
					    		<option value="lessthan">{$smarty.const.DESPRES}</option>
					    		<option value="equal">{$smarty.const.IGUAL}</option>
				        	</select>
			    		</div>
			    		<div class="span-1 last inputContainer2">
			    			<p><b>(1984-05-14)</b><p>
				  			<input name="datetext" id="datetext" class="inputDataSmall" type="text">
			    		</div>
			    	</div>
			    	<div class="fila">
			    		<div class="span-1 last inputContainer">
				       		<p>{$smarty.const.NUMHERB} <b>(104*)</b></p> 
				    		<input name="UnitID" id="UnitID" class="inputDataSmall" type="text" />
				    		<input name="submit" value="{$smarty.const.BUTTONSEARCH}" type="submit"/>
				  			<input name="db" type="hidden" value="{$BDSelected}">
			    		</div>
			    	</div>
			    	</form>
		  	  	</div>
			
			</div> <!-- del tab de pliego -->
		
		
		    <div class="tabbertab">
			  	<div id="queryForm2" class="buscador"> 
		    	<form action="taxonresult.php" method="get" name="thisform" id="thisform">
		    	<h2>{$smarty.const.TITLE_TABTAXON}</h2>
		    
		    	<div class="fila"> 
		    		<div class="span-1 last inputContainer">
		    			<p>{$smarty.const.NOMTAXON} <b>(Acro*)</b></p> 
			 			<input name="nameauthoryearstring" id="nameauthoryearstring" class="inputDataLong" type="text" />
		    		</div>
		    		
		    		<div class="span-1 last inputContainer2">
		    			<p>{$smarty.const.GEN} <b>(Acant*)</b></p> 
						<select name="genus" class="inputSelect">
							<option value="">{$smarty.const.TODOS}</option>
							{html_options values=$genus output=$genus}
						</select>
		    		</div>
		    		
		    		<div class="span-1 last inputContainer2">
						<p>{$smarty.const.FAM}</p>
						<select name="highertaxon" class="inputSelect">
							<option value="">{$smarty.const.TODOS}</option>
							{html_options values=$families output=$families}
						</select>	
		    		</div>
		    		<input name="submit" value="{$smarty.const.BUTTONSEARCH}" type="submit"/>
				  	<input name="db" type="hidden" value="{$BDSelected}">
		    	</div>
		   	    </form>
			  	</div> 
		  
		  </div> <!-- del tab de taxon -->
			  
		</div>
	
	</div>

</div>
						
{include file="footer.tpl"} 
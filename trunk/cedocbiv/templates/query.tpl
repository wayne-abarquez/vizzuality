{include file="header.tpl"}
						
{literal}
<script type="text/javascript" src="js/tabber.js"></script>
{/literal}

<div class="content">
	<div class="span-1 last breadCrumb">
		<ul>
			<li class="arrowList"><a href="index.php">{$smarty.const.BASES_DE_DADES}</a></li>
			<li>{$BDSelected}</li>
		</ul>
	</div>
	
	<div class="news-body">
		<div class="titleIndex">

		</div>
		<div class="TextBD">
		{if $BDSelected eq "algas"} 
		<p class="texto_intro"> {$smarty.const.INTRO_TEXTBD1} <a href="mailto:cedocbiv@pcb.ub.es">{$smarty.const.INTRO_TEXTCONTACT}</a> {$smarty.const.INTRO_TEXTCONTACTE}</p>
		{/if}
		
		{if $BDSelected eq "briofitos"} 
		<p class="texto_intro"> {$smarty.const.INTRO_TEXTBD2} <a href="mailto:cedocbiv@pcb.ub.es">{$smarty.const.INTRO_TEXTCONTACT}</a> {$smarty.const.INTRO_TEXTCONTACTE}</p>
		{/if}
		
		{if $BDSelected eq "cormofitos"}
		<p class="texto_intro"> {$smarty.const.INTRO_TEXTBD3} <a href="mailto:cedocbiv@pcb.ub.es">{$smarty.const.INTRO_TEXTCONTACT}</a> {$smarty.const.INTRO_TEXTCONTACTE}</p>
		{/if}
		
		{if $BDSelected eq "carpoteca"} 
		<p class="texto_intro"> {$smarty.const.INTRO_TEXTBD4} <a href="http://herbaribcn.ub.es/herbvirt/carpoteca/indexca.htm">{$smarty.const.INTRO_TEXTHERBARI}</a>
		</p>
		{/if}
		
		{if $BDSelected eq "hongos"} 
		<p class="texto_intro">{$smarty.const.INTRO_TEXTBD5} <a href="mailto:cedocbiv@pcb.ub.es">{$smarty.const.INTRO_TEXTCONTACT}</a> {$smarty.const.INTRO_TEXTCONTACTE}</p>
		{/if}
		
		{if $BDSelected eq "liquenes"} 
		<p class="texto_intro">{$smarty.const.INTRO_TEXTBD6} <a href="mailto:cedocbiv@pcb.ub.es">{$smarty.const.INTRO_TEXTCONTACT}</a> {$smarty.const.INTRO_TEXTCONTACTE}</p>
		{/if}
		
		<p class="info">{$smarty.const.ACTUAL} <b>{$LastUpdate}</b> | {$smarty.const.REG} <b>{$Numregistros}</b> | {$smarty.const.INTRO_TEXTAST}</p>
		</div>
  
		<div class="tabber">
			<div class="tabbertab">
			  	<div id="queryForm" class="buscador"> 
			    	<form action="sheetresult.php" method="get" name="thisform" id="thisform">
			    	<h2>{$smarty.const.TITLE_TABTAXON}</h2>
			    
			    	<div class="fila"> 
			    		<div class="span-1 last inputContainer">
			    			<p>{$smarty.const.NOMTAXON} <b>({$nomCientifSug})</b></p> 
				 			<input name="nameauthoryearstring" id="nameauthoryearstring" class="inputDataLong" type="text" />
			    		</div>
			    		
			    		<div class="span-1 last inputContainer2">
			    			<p>{$smarty.const.GEN} </p> 
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
				       		<p>{$smarty.const.LOCALITAT} <b>({$localitSug})</b></p> 
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
				       		<p>{$smarty.const.RECOL} <b>({$recolSug})</b><p>
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
				       		<p>{$smarty.const.NUMHERB} <b>({$numHerbSug})</b></p> 
				    		<input name="UnitID" id="UnitID" class="inputDataSmall" type="text" />
				  			<input name="db" type="hidden" value="{$BDSelected}">
			    		</div>
			    	</div>
					<div class="buttonContainer"><input name="submit" value="{$smarty.const.BUTTONSEARCH}" type="submit" class="buttonSearch"/>
						<input value="{$smarty.const.VOLVER}" type="button" class="buttonSearch"/ onclick="location.href='index.php'">
					</div>
			    	</form>
		  	  	</div>
			
			</div> <!-- del tab de taxon -->
		
		
		    <!-- <div class="tabbertab">
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
		    				  	<input name="db" type="hidden" value="{$BDSelected}">
		    		    	</div>
		    				<div class="buttonContainer"><input name="submit" value="{$smarty.const.BUTTONSEARCH}" type="submit" class="buttonSearch buttonTaxon"/></div>
		    		   	    </form>
		    			  	</div> 
		    		  
		    		  </div>  -->
			  
		</div>
	
	</div>

</div>
						
{include file="footer.tpl"} 
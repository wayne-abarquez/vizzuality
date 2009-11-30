{include file="header.tpl"}

<div id="container"> 
  <h3><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Base de dades 
	de {$BDSelected} de l'Herbari de la Universitat de Barcelona (BCN)</font></h3>
  {if $BDSelected eq "cormofitos"}
  <font face="Verdana, Arial, Helvetica, sans-serif" size="2"> 
  <p><font face="Verdana, Arial, Helvetica, sans-serif" size="2"> La informatitzaci&oacute; 
	de les mostres de plantes vasculars de l'herbari BCN es va iniciar abans de 
	la fusi&oacute; dels herbaris de les facultats de Biologia i de Farmacia. 
	Pel fet de ser la m&eacute;s gran de les col&middot;leccions de l'herbari, 
	la seva completa informatitzaci&oacute; &eacute;s un projecte a llarg termini. 
	Actualment aquesta base de dades recull b&agrave;sicament els registres corresponents 
	a la fam&iacute;lia de las aster&agrave;cies, escrofulari&agrave;cies, lami&agrave;cies, 
	boragin&agrave;cies i fab&agrave;cies. Si amb la vostra consulta no obteniu 
	els resultats esperats o b&eacute; voleu cercar mostres d'altres grups, <a href="mailto:cedocbiv@pcb.ub.es">poseu-vos 
	en contacte</a> amb el personal del centre i indiqueu clarament la informaci&oacute; 
	que desitgeu localitzar. </font></p>
  </font> 
  {/if}
  {if $BDSelected eq "algas"} 
  <font face="Verdana, Arial, Helvetica, sans-serif" size="2"> 
  <p><font face="Verdana, Arial, Helvetica, sans-serif" size="2"> En aquesta base 
	de dades es recullen pr&agrave;cticament totes les mostres d'algues de l'herbari. 
	Si amb la vostra consulta no obteniu els resultats esperats <a href="mailto:cedocbiv@pcb.ub.es">poseu-vos 
	en contacte</a> amb el personal del centre i indiqueu clarament la informaci&oacute; 
	que desitgeu localitzar.</font></p>
  </font> 
  {/if}
  {if $BDSelected eq "briofitos"} 
  <font face="Verdana, Arial, Helvetica, sans-serif" size="2"> 
  <p><font face="Verdana, Arial, Helvetica, sans-serif" size="2"> La informatitzaci&oacute; 
	dels bri&ograve;fits de l' herbari BCN s'ha iniciat recentment i de moment 
	el nombre de registres que cont&eacute; aquesta base de dades &eacute;s molt 
	baix. Si amb la vostra consulta no obteniu els resultats esperats <a href="mailto:cedocbiv@pcb.ub.es">poseu-vos 
	en contacte</a> amb el personal del centre i indiqueu clarament la informaci&oacute; 
	que desitgeu localitzar.</font></p>
  </font>
  {/if}
  {if $BDSelected eq "carpoteca"} 
  <font face="Verdana, Arial, Helvetica, sans-serif" size="2"> 
  <p><font face="Verdana, Arial, Helvetica, sans-serif" size="2"> La col&middot;lecci&oacute; 
	de fruits i llavors de l'herbari BCN actualment est&agrave; pr&agrave;ctiament 
	informatitzada en la seva totalitat. Si desitgeu consultar nom&eacute;s els 
	registres que inclouen imatges podeu consultar directament l'apartat de la 
	carpoteca de l'<a href="http://www.ub.es/cedocbiv/indexcar.htm">herbari virtual</a>.</font></p>
  </font> 
  {/if}
  {if $BDSelected eq "hongos"} 
  <font face="Verdana, Arial, Helvetica, sans-serif" size="2"> 
  <p><font face="Verdana, Arial, Helvetica, sans-serif" size="2"> La informatitzaci&oacute; 
	de la col&middot;lecci&oacute; de fongs de l' herbari BCN s'ha iniciat recentment 
	i de moment el nombre de registres que cont&eacute; aquesta base de dades 
	&eacute;s molt baix. Si amb la vostra consulta no obteniu els resultats esperats 
	<a href="mailto:cedocbiv@pcb.ub.es">poseu-vos en contacte</a> amb el personal 
	del centre i indiqueu clarament la informaci&oacute; que desitgeu localitzar.</font></p>
  </font> 
  {/if}
  {if $BDSelected eq "liquenes"} 
  <font face="Verdana, Arial, Helvetica, sans-serif" size="2"> 
  <p><font face="Verdana, Arial, Helvetica, sans-serif" size="2"> La informatitzaci&oacute; 
	de la col&middot;lecci&oacute; de l&iacute;quens s'ha iniciat pels exemplars 
	tipus que es conserven a l'herbari. Si no obteniu els resultats esperats <a href="mailto:cedocbiv@pcb.ub.es">poseu-vos 
	en contacte</a> amb el personal del centre i indiqueu clarament les mostres 
	que desitgeu localitzar.</font></p>
  </font> 
  {/if}
  <p><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><span class="positive"><b>&Uacute;ltima 
	actualitzaci&oacute;:</b></span> {$LastUpdate}
	<br>
	<b class="positive">Registres:</b> {$Numregistros}
	</font></p>
  <p><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Per a fer una 
	consulta ompliu el camp corresponent. Podeu fer servir l'asterisc (*) en qualsevol 
	posici&oacute; d'una paraula. </font></p>
  <div id="queryForm"> 
	<form action="bdresult_cat.php" method="get" name="thisform" id="thisform">
	  <h2><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Consulta</font></h2>
	  <div class="instruction"> 
		<div> <font face="Verdana, Arial, Helvetica, sans-serif" size="2"><span class="search-1"> 
		  <label for="search">Nom del tàxon:</label> (Acro*)<br />
		  <input name="nameauthoryearstring" id="nameauthoryearstring" size="30" style="width: 15em;" type="text" />
		  </span> <span class="search-1"><strong>Gènere:</strong> (Acant*) <br />
		  <select name="genus">
			<option value="">Tots</option>
			{section name=genus loop=$GenusResults}
				<option value="{$genus}"></option> 
			{/section}
		  </select>
		  </span> <span class="search-2"><strong>Família:</strong><br />
		  <select name="highertaxon">
			<option value="">Totes</option>
			{foreach key=id item=highertaxon from=$HighertaxonResults}
				<option value="{$highertaxon.highertaxon}"></option> 
			{/foreach}
		  </select>
		  </span><br />
		  <br />
		  <br />
		  <span class="search-1"> <label for="search">Localitat:</label> (*Balagu*)<br />
		  <input name="localitytext" id="localitytext" size="30" style="width: 15em;" type="text" />
		  </span> <span class="search-1"><strong>País:</strong><br />
		  <select name="countryname">
			<option value="">Tots</option>
			
		  </select>
		  </span> <span class="search-2"><strong>UTM:</strong> (31TCG65) <br />
		  <input name="utmformula" id="utmformula" size="8" style="width: 5em;" type="text" />
		  </span><br />
		  <br />
		  <br />
		  <span class="search-1"><strong>Recol·lectors:</strong> (*Sennen*)<br />
		  <input name="agenttext" id="agenttext" size="30" style="width: 15em;" type="text" />
		  </span> <span class="search-2"><strong>Data recol·lecció:</strong> (1984-05-14)<br />
		  <select name="datesearchtype" size="1" id="datesearchtype">
			<option value="greaterthan">Abans de</option>
			<option value="lessthan">Després de</option>
			<option value="equal">Igual que (amb *)</option>
		  </select>
		  <input name="datetext" id="datetext" size="8" style="width: 5em;">
		  </span> <br />
		  <br />
		  <br />
		  <span class="search-1"><strong>Número d'herbari: </strong> (104*)<br />
		  BCN 
		  <input name="UnitID" id="UnitID" size="30" style="width: 5em;" type="text" />
		  </span> <br />
		  <br />
		  <br />
		  <input name="submit" value="Cerca" type="submit" style="font-size:16px;"/>
		  <input name="db" type="hidden" value="{$BDSelected}">
		  </font></div>
	  </div>
	</form>
  </div>
</div>
						
{include file="footer.tpl"} 
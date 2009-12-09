{include file="newheader_cat.tpl"}

<div class="content">
  <h3><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Base de dades 
	de {$BDSelected}</font></h3>
  
	<div class="news-body">
	  {section name=mostrar loop=$Ident}

	  <h3> 
	  {$Ident[0].NameAuthorYearString}		
	  </h3>

	  <p>Publicat el 22-08-2005 </p>
	  
	  <br />
	  <span class="label">Fam&iacute;lia:</span> 
		  {$Ident[0].HigherTaxon}		
	  </h3>
	  
	  <br />
	  	  <span class="label">Nom etiqueta:</span> 
	  		  {$Ident[1].NameAuthorYearString}		
	  <br />

	  <span class="label">Guardat com:</span> 
	  {$Ident[0].NameAuthorYearString}	  
	  <br />
	  <br />
	  <span class="label">Localitat: </span> 
	  {$Units.LocalityText}
	  <br />
	  <span class="label">Pa’s: </span> 
	  	  {$Units.CountryName}
	  <br />
	  <span class="label">Altitud: </span> 
	  	  {$Units.AltitudeLowerValue} <!-- meter tb UpperValue -->
	  <br />
	  <br />
	  <span class="label">Recol&middot;lectors:</span> 
	  	  {$Agents.GatheringAgentsText} <!-- meter tb UpperValue --> 
	  <br />
	  	  <span class="label">H&agrave;bitat: </span> 
	  {$Units.BiotopeText}	  <br />
	  
<!-- 	  meter CollectorNumber -->

	  <span class="label">Data de recol&middot;lecci—:</span> 
	  25-05-1985	  <br />
	  <span class="label">Col&middot;lecci—:</span> 
	  {$Units.ProjectTitle}	  <br />	  <br />
	  <span class="label">Fenologia:</span> 
	  {$Units.Phenology}	  	  <br />
	  
	  {if $Images}
	  <div>
	  <p>Imagenes</p>
    	{section name=imagenes loop=$Images}
    		<a href="{$Images[imagenes].ImageURI}">{$Images[imagenes].ImageURI}</a><br />
    	{/section}
	  </div>
	  {/if}
  	{/section}	  
	 </div>
	
  </div>

{include file="newfooter_cat.tpl"}
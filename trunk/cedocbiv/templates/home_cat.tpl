{include file="newheader_cat.tpl"}
						
<div class="content">
	<div class="titleIndex"><p>Bases de Dades de l'Herbari BCN</p></div>

	<div class="news-body"> 
	  <p class="texto_intro">{$smarty.const.INTRO_TEXT}</p>
	  
	  <a class="link_bd" href="query.php?db=algas">Algues</a>
	  <p class="subheader">aprox. <b>99%</b> informatitzat | <b> 
		{$NumregistrosAlgas}
		</b> registres | <b> 
		{$NumRegistrosImagenAlgas}
		</b> imatges | <b> 
		{$NumRegistrosGeoreferenciadosAlgas}
		</b> registres georeferenciats</p>
		
	  <a class="link_bd" href="query.php?db=briofitos">Briófits</a>
	  <p class="subheader">aprox. <b>3%</b> informatitzat | <b> 
		{$NumregistrosBriofitos}
		</b> registres | <b> 
		{$NumRegistrosImagenBriofitos}
		</b> imatges | <b> 
		{$NumRegistrosGeoreferenciadosBriofitos}
		</b> registres georeferenciats</p>
	  
	  <a class="link_bd" href="query.php?db=cormofitos">Cormófits</a>
	  <p class="subheader">aprox. <b>5%</b> informatizado | <b> 
		{$NumregistrosCormofitos}
		</b> registres | <b> 
		{$NumRegistrosImagenCormofitos}
		</b> imatges | <b> 
		{$NumRegistrosGeoreferenciadosCormofitos}
		</b> registres georeferenciats</p>
	  
	  <a class="link_bd" href="query.php?db=carpoteca">Collecció de fruits i llavors</a>
	  <p class="subheader">aprox <b>98%</b> informatitzat | <b> 
		{$NumregistrosCarpoteca}
		</b> registres | <b> 
		{$NumRegistrosImagenCarpoteca}
		</b> imatges | <b> 
		{$NumRegistrosGeoreferenciadosCarpoteca}
		</b> registres georeferenciats</p>
	  
	  <a class="link_bd" href="query.php?db=hongos">Fongs</a>
	  <p class="subheader">aprox. <b>1%</b> informatitzat | <b> 
		{$NumregistrosHongos}
		</b> registres | <b> 
		{$NumRegistrosImagenHongos}
		</b> imatges | <b> 
		{$NumRegistrosGeoreferenciadosHongos}
		</b> registres georeferenciats</p>
	  
	  <a class="link_bd" href="query.php?db=liquenes">Líquens</a>
	  <p class="subheader">aprox. <b>1%</b> informatitzat | <b> 
		{$NumregistrosLiquenes}
		</b> registres | <b> 
		{$NumRegistrosImagenLiquenes}
		</b> imatges | <b> 
		{$NumRegistrosGeoreferenciadosLiquenes}
		</b> registres georeferenciats</p>
	</div>

</div>
						
{include file="newfooter_cat.tpl"} 
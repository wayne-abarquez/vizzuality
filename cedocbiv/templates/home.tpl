{include file="newheader.tpl"}
						
<div class="content">
	<div class="titleIndex"><p>{$smarty.const.INTRO_TITLE}</p></div>

	<div class="news-body"> 
	  <p class="texto_intro">{$smarty.const.INTRO_TEXT}</p>
	  
	  <a class="link_bd" href="query.php?db=algas">{$smarty.const.BD1}</a>
	  <p class="subheader"> {$smarty.const.APROX} <b>99%</b> {$smarty.const.INFOR} | <b> 
		{$NumregistrosAlgas}
		</b> {$smarty.const.REG} | <b> 
		{$NumRegistrosImagenAlgas}
		</b> {$smarty.const.IMG} | <b> 
		{$NumRegistrosGeoreferenciadosAlgas}
		</b> {$smarty.const.REGGEO}</p>
		
	  <a class="link_bd" href="query.php?db=briofitos">{$smarty.const.BD2}</a>
	  <p class="subheader"> {$smarty.const.APROX} <b>3%</b> {$smarty.const.INFOR} | <b> 
		{$NumregistrosBriofitos}
		</b> {$smarty.const.REG} | <b> 
		{$NumRegistrosImagenBriofitos}
		</b> {$smarty.const.IMG} | <b> 
		{$NumRegistrosGeoreferenciadosBriofitos}
		</b> {$smarty.const.REGGEO}</p>
	  
	  <a class="link_bd" href="query.php?db=cormofitos">{$smarty.const.BD3}</a>
	  <p class="subheader"> {$smarty.const.APROX} <b>5%</b> {$smarty.const.INFOR} | <b> 
		{$NumregistrosCormofitos}
		</b> {$smarty.const.REG} | <b> 
		{$NumRegistrosImagenCormofitos}
		</b> {$smarty.const.IMG} | <b> 
		{$NumRegistrosGeoreferenciadosCormofitos}
		</b> {$smarty.const.REGGEO}</p>
	  
	  <a class="link_bd" href="query.php?db=carpoteca">{$smarty.const.BD4}</a>
	  <p class="subheader"> {$smarty.const.APROX} <b>98%</b> {$smarty.const.INFOR} | <b> 
		{$NumregistrosCarpoteca}
		</b> {$smarty.const.REG} | <b> 
		{$NumRegistrosImagenCarpoteca}
		</b> {$smarty.const.IMG} | <b> 
		{$NumRegistrosGeoreferenciadosCarpoteca}
		</b> {$smarty.const.REGGEO}</p>
	  
	  <a class="link_bd" href="query.php?db=hongos">{$smarty.const.BD5}</a>
	  <p class="subheader"> {$smarty.const.APROX} <b>1%</b> {$smarty.const.INFOR} | <b> 
		{$NumregistrosHongos}
		</b> {$smarty.const.REG} | <b> 
		{$NumRegistrosImagenHongos}
		</b> {$smarty.const.IMG} | <b> 
		{$NumRegistrosGeoreferenciadosHongos}
		</b> {$smarty.const.REGGEO}</p>
	  
	  <a class="link_bd" href="query.php?db=liquenes">{$smarty.const.BD6}</a>
	  <p class="subheader"> {$smarty.const.APROX} <b>1%</b> {$smarty.const.INFOR} | <b> 
		{$NumregistrosLiquenes}
		</b> {$smarty.const.REG} | <b> 
		{$NumRegistrosImagenLiquenes}
		</b> {$smarty.const.IMG} | <b> 
		{$NumRegistrosGeoreferenciadosLiquenes}
		</b> {$smarty.const.REGGEO}</p>
	</div>

</div>
						
{include file="newfooter.tpl"} 
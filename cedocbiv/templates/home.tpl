{include file="header.tpl"}
						
<div class="content">
	<div class="titleIndex"><p>{$smarty.const.INTRO_TITLE}</p></div>

	<div class="news-body"> 
	  <div><p class="texto_intro">{$smarty.const.INTRO_TEXT}</p></div>
	  <div class="containerBox">
	     <div class="span-1 last boxBD noborder" onmouseover="this.className='span-1 last boxBD activo noborder'" onmouseout="this.className='span-1 last boxBD inactivo noborder'" onclick="location.href='query.php?db=algas';">
			 <div class="imageLinkAlgas"></div>
	     	 <a class="link_bd" href="query.php?db=algas">{$smarty.const.BD1}</a>
	     	 <p class="subheader"> {$smarty.const.APROX} <b>{$smarty.const.APROXALGAS}</b> {$smarty.const.INFOR}</p>
	 	     <div class="containerReg">
	     	 	<div class="span-1 last boxLeft">
	     	 		<p class="numeroReg">{$NumregistrosAlgas}</p>
	     	 		<p class="reg">{$smarty.const.REG}</p>
	     	 	</div>
	     	 	<div class="span-1 last boxRight">
	     	 		<p class="numeroReg">{$NumRegistrosImagenAlgas}</p>
	     	 		<p class="reg">{$smarty.const.IMG}</p>
	     	 	</div>
	     	 </div>
			 <div class="span-1 georef"><p><b>{$NumRegistrosGeoreferenciadosAlgas}</b> {$smarty.const.REGGEO}</p></div>
	     </div>
	     <div class="span-1 last boxBD" onmouseover="this.className='span-1 last boxBD activo'" onmouseout="this.className='span-1 last boxBD inactivo'" onclick="location.href='query.php?db=briofitos';">
			 <div class="imageLinkBriofitos"></div>
	 	 	 <a class="link_bd" href="query.php?db=briofitos">{$smarty.const.BD2}</a>
	 	     <p class="subheader2"> {$smarty.const.APROX} <b>{$smarty.const.APROXBRIOFITOS}</b> {$smarty.const.INFOR}</p>
	 	     <div class="containerReg">
	     	 	<div class="span-1 last boxLeft">
	     	 		<p class="numeroReg">{$NumregistrosBriofitos}</p>
	     	 		<p class="reg">{$smarty.const.REG}</p>
	     	 	</div>
	     	 	<div class="span-1 last boxRight">
	     	 		<p class="numeroReg">{$NumRegistrosImagenBriofitos}</p>
	     	 		<p class="reg">{$smarty.const.IMG}</p>
	     	 	</div>
	     	 </div>
			 <div class="span-1 georef"><p><b>{$NumRegistrosGeoreferenciadosBriofitos}</b> {$smarty.const.REGGEO}</p></div>
		 </div>
	     <div class="span-1 last boxBD" onmouseover="this.className='span-1 last boxBD activo'" onmouseout="this.className='span-1 last boxBD inactivo'" onclick="location.href='query.php?db=cormofitos';">
			 <div class="imageLinkCormofitos"></div>
	 	  	 <a class="link_bd" href="query.php?db=cormofitos">{$smarty.const.BD3}</a>
	 	     <p class="subheader2"> {$smarty.const.APROX} <b>{$smarty.const.APROXCORMOFITOS}</b> {$smarty.const.INFOR}</p>
	 	     <div class="containerReg">
	     	 	<div class="span-1 last boxLeft">
	     	 		<p class="numeroReg">{$NumregistrosCormofitos}</p>
	     	 		<p class="reg">{$smarty.const.REG}</p>
	     	 	</div>
	     	 	<div class="span-1 last boxRight">
	     	 		<p class="numeroReg">{$NumRegistrosImagenCormofitos}</p>
	     	 		<p class="reg">{$smarty.const.IMG}</p>
	     	 	</div>
	     	 </div>
			 <div class="span-1 georef"><p><b>{$NumRegistrosGeoreferenciadosCormofitos}</b> {$smarty.const.REGGEO}</p></div>
	     </div>
	     <div class="span-1 last boxBD" onmouseover="this.className='span-1 last boxBD activo'" onmouseout="this.className='span-1 last boxBD inactivo'" onclick="location.href='query.php?db=carpoteca';">
			 <div class="imageLinkSemillas"></div>
	 	  	 <a class="link_bd" href="query.php?db=carpoteca">{$smarty.const.BD4}</a>
	 	  	 <p class="subheader"> {$smarty.const.APROX} <b>{$smarty.const.APROXFRUITSLLAV}</b> {$smarty.const.INFOR}</p>
	 	     <div class="containerReg">
	     	 	<div class="span-1 last boxLeft">
	     	 		<p class="numeroReg">{$NumregistrosCarpoteca}</p>
	     	 		<p class="reg">{$smarty.const.REG}</p>
	     	 	</div>
	     	 	<div class="span-1 last boxRight">
	     	 		<p class="numeroReg">{$NumRegistrosImagenCarpoteca}</p>
	     	 		<p class="reg">{$smarty.const.IMG}</p>
	     	 	</div>
	     	 </div>
			 <div class="span-1 georef"><p><b>{$NumRegistrosGeoreferenciadosCarpoteca}</b> {$smarty.const.REGGEO}</p></div>
	     </div>
	     <div class="span-1 last boxBD" onmouseover="this.className='span-1 last boxBD activo'" onmouseout="this.className='span-1 last boxBD inactivo'" onclick="location.href='query.php?db=hongos';">
			 <div class="imageLinkHongos"></div>
	 	  	 <a class="link_bd" href="query.php?db=hongos">{$smarty.const.BD5}</a>
	 	  	 <p class="subheader2"> {$smarty.const.APROX} <b>{$smarty.const.APROXHONGOS}</b> {$smarty.const.INFOR}</p>
	 	     <div class="containerReg">
	     	 	<div class="span-1 last boxLeft">
	     	 		<p class="numeroReg">{$NumregistrosHongos}</p>
	     	 		<p class="reg">{$smarty.const.REG}</p>
	     	 	</div>
	     	 	<div class="span-1 last boxRight">
	     	 		<p class="numeroReg">{$NumRegistrosImagenHongos}</p>
	     	 		<p class="reg">{$smarty.const.IMG}</p>
	     	 	</div>
	     	 </div>
			 <div class="span-1 georef"><p><b>{$NumRegistrosGeoreferenciadosHongos}</b> {$smarty.const.REGGEO}</p></div>
	     </div>
	     <div class="span-1 last boxBD" onmouseover="this.className='span-1 last boxBD activo'" onmouseout="this.className='span-1 last boxBD inactivo'" onclick="location.href='query.php?db=liquenes';">
			 <div class="imageLinkLiquenes"></div>
	 	 	 <a class="link_bd" href="query.php?db=liquenes">{$smarty.const.BD6}</a>
	 	 	 <p class="subheader2"> {$smarty.const.APROX} <b>{$smarty.const.APROXLIQUENES}</b> {$smarty.const.INFOR}</p>
	 	     <div class="containerReg">
	     	 	<div class="span-1 last boxLeft">
	     	 		<p class="numeroReg">{$NumregistrosLiquenes}</p>
	     	 		<p class="reg">{$smarty.const.REG}</p>
	     	 	</div>
	     	 	<div class="span-1 last boxRight">
	     	 		<p class="numeroReg">{$NumRegistrosImagenLiquenes}</p>
	     	 		<p class="reg">{$smarty.const.IMG}</p>
	     	 	</div>
	     	 </div>
			 <div class="span-1 georef"><p><b>{$NumRegistrosGeoreferenciadosLiquenes}</b> {$smarty.const.REGGEO}</p></div>
	     </div>
	  
	  </div> <!-- containerBox -->

	</div> <!-- news-body -->

</div> <!-- content -->
						
{include file="footer.tpl"} 
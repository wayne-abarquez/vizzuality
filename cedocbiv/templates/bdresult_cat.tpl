{include file="header.tpl"}

<!-- #BeginEditable "editable" --> <font face="Verdana, Arial, Helvetica, sans-serif" size="2"><div id="container"> </font> 
<form action="bdresult2_cat.php" method="get">
  <div id="searchform"> 
	<h3><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Cerca a la 
	  base de dades {$BDSelected} de l'Herbari de la Universitat de Barcelona (BCN) </font></h3>
	<div> 
	  <div class="buscador"> <font face="Verdana, Arial, Helvetica, sans-serif" size="2"><span class="search-2"><strong>Nom 
		del tàxon:</strong><br />
		<input name="nameauthoryearstring" id="nameauthoryearstring" value="{$nameauthoryearstring}" size="30" style="width: 15em;" type="text">
		</span> <span class="search-2"><strong>Família:</strong><br />
		<select name="highertaxon">
		  <option value="">Totes</option>
		  		</select>
		</span> <span class="search-2"><strong>País:</strong><br />
		<select name="countryname">
		  <option value="">Tots</option>
		  
		</select>
		</span> <span class="search-2"><strong>Recol·lectors:</strong><br />
		<input name="agenttext" id="agenttext" value="<?php echo($_REQUEST['agenttext']);?>" size="30" style="width: 10em;" type="text">
		</span> <span class="search-2"><strong>UTM:</strong><br />
		<input name="utmformula" id="utmformula" value="<?php echo($_REQUEST['utmformula']);?>" size="8" style="width: 5em;" type="text">
		</span> <span class="search-1"><strong>Ordenat per:</strong><br />
		<select name="orderby">
		  <option value="nameauthoryearstring">Nom tàxon</option>
		  <option value="highertaxon">Família</option>
		  <option value="countryname">País</option>
		  <option value="utmformula">UTM</option>
		</select>
		</span> <br>
		<input name="db" type="hidden" value="<?php echo($_REQUEST['db'])?>">
		<input name="submit" value="Cerca" type="submit">
		</font></div>
	</div>
  </div>
</form>
<div style="float: right;"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><a href="bdresult3_cat.php" class="positive">Veure 
  tots els resultats</a></font></div>
<font face="Verdana, Arial, Helvetica, sans-serif" size="2"> 
{if !$totalRows_Runits}
</font> 
<h3><font face="Verdana, Arial, Helvetica, sans-serif" size="2">0 Resultats trobats</font></h3>
<font face="Verdana, Arial, Helvetica, sans-serif" size="2">No hi ha resultats. 
<a href="#" onClick="javascript:window.history.back();">Torna</a> 
{else}
</font> 
<h3> <font face="Verdana, Arial, Helvetica, sans-serif" size="2"> 
 {$totalRows_Runits}
  Resultats trobats</font></h3>
<font face="Verdana, Arial, Helvetica, sans-serif" size="2"> 

{/if}
</font> 
<div class="news-summary" style="z-index: 1000;"> 
  <div class="news-body"> 
	<h3><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><a href="bdresult3_cat.php?UnitID=<?php echo $arr['unitid']?>&db=<?php echo($_REQUEST['db'])?>"> 
	  {$nameauthoryearstring}
	  </a></font></h3>
	<p class="news-submitted"> <font face="Verdana, Arial, Helvetica, sans-serif" size="2"> 
	  {$highertaxon}
	  | 
	  {$TypeStatus}
	  </font></p>
	<p> <font face="Verdana, Arial, Helvetica, sans-serif" size="2"> 
	  {if !$localitytext}
	  <b>Localitat:</b> 
	  {$localitytext}
	  {/if}
	  {if !$AgentText}
	  <b>Recol&middot;lectors:</b> 
	  {$AgentText}
	  ( 
<!-- 	  <?php echo(date("d-m-Y", strtotime($arr['ISODateTimeBegin'])))?> -->
	  ) 
	  {/if}
	  </font></p>
	<div class="news-details"> <font face="Verdana, Arial, Helvetica, sans-serif" size="2"> 
<!-- 	  <?php if ($arr['has_images']) { ?> -->
	  <a href="#" class="tool comments"> 
<!-- 	  <?php echo $arr['has_images']?> -->
	  pictures </a> 
<!-- 	  <?php } else { ?> -->
	  <span class="tool">0 fotos</span> 
<!-- 	  <?php } ?> -->
<!-- 	  <?php if ($arr['utmformula']) { ?> -->
	  <a href="#" class="tool"> 
<!-- 	  <?php echo $arr['utmformula']?> -->
	  (veure mapa) </a> 
<!-- 	  <?php } else { ?> -->
	  <span class="tool">No georeferenciat</span> 
<!-- 	  <?php } ?> -->
	  </font></div>
  </div>
  <ul class="news-digg">
	<li class="digg-count shade-1" id="main0"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><a href="bdresult3_cat.php?UnitID=<?php echo $arr['unitid']?>&db=<?php echo($_REQUEST['db'])?>"><strong id="diggs-strong-0">BCN<br>
<!-- 	  <?php echo $arr['unitid']?> -->
	  </strong></a></font></li>
  </ul>
</div>
<font face="Verdana, Arial, Helvetica, sans-serif" size="2"> 
<!--
<?php	} ?>
<!-- PAGING -->
<?php 


 
 $num_pag=$pageNum_Runits+1;
 $total_pag=$totalPages_Runits+1;
 $paging= array();
 
//esto en el medio del paging
if ($num_pag>5 && $num_pag<($total_pag-5)) {
	array_push($paging,'1','2','...');
	$start=$num_pag-2;
	$end=$num_pag+3;
	for ($i=$start; $i < $end;$i++) {
		array_push($paging,$i);
	}
	array_push($paging,"...",($total_pag-1),($total_pag));

} 

//estoy al principio del paging y no veo el final
if ($num_pag<6 && $num_pag<($total_pag-5)) {
	$start=1;
	$end=6;
	for ($i=$start; $i < $end;$i++) {
		array_push($paging,$i);
	}
	array_push($paging,"...",($total_pag-1),($total_pag));
}	

// veo el principio y el final = son como mucho 10
if ($total_pag<11) {
	$start=1;
	$end=10;
	for ($i=$start; $i < $end;$i++) {
		array_push($paging,$i);
	}
}

//no veo el principio y si que veo el final y hay mas de 10
if ($num_pag>5 && $total_pag>10 && $num_pag>($total_pag-6)) {
	$start=$total_pag-5;
	$end=$total_pag+1;
	array_push($paging,"1","2","...");
	for ($i=$start; $i < $end;$i++) {
		array_push($paging,$i);
	}
}

?>
-->
</font> 
<div class="pages"> <font face="Verdana, Arial, Helvetica, sans-serif" size="2"> 
  <?php if ($pageNum_Runits > 0) { ?>
  <a href="<?php printf("%s?pageNum_Runits=%d%s", $currentPage, max(0, $pageNum_Runits - 1), $queryString_Runits); ?>" class="nextprev">&laquo; 
  Anterior</a> 
  <?php } else { ?>
  <span class="nextprev">&laquo; Anterior</span> 
  <?php } ?>
  <?php 

foreach ($paging as $value) {
	if ($value==$pageNum_Runits+1) { ?>
  <span class="current"> 
  <?php echo ($value) ?>
  </span> 
  <?php } elseif ($value<>"...") { ?>
  <a href="<?php printf("%s?pageNum_Runits=%d%s", $currentPage, ($value-1), $queryString_Runits); ?>" class="nextprev"> 
  <?php echo($value); ?>
  </a> 
  <?php } else { ?>
  <span class="nextprev">...</span> 
  <?php }
}

?>
  <?php if ($pageNum_Runits < $totalPages_Runits) {?>
  <a href="<?php printf("%s?pageNum_Runits=%d%s", $currentPage, min($totalPages_Runits, $pageNum_Runits + 1), $queryString_Runits); ?>" class="nextprev">Seg&uuml;ent&raquo;</a> 
  <?php } else { ?>
  <span class="nextprev">Seg&uuml;ent&raquo;</span
  > 
  <?php	} ?>
  <!--
     <span class="current"><?php echo ($startRow_Runits + 1) ?> - <?php echo min($startRow_Runits + $maxRows_Runits, $totalRows_Runits) ?></span>
  
  </div>
  
  -->
  <?php	} ?>
  </font></div>
<!-- #EndEditable --> 

						
{include file="footer.tpl"} 
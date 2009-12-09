<?php /* Smarty version 2.6.26, created on 2009-11-30 12:58:14
         compiled from bdresult_cat.tpl */ ?>
<?php $_smarty_tpl_vars = $this->_tpl_vars;
$this->_smarty_include(array('smarty_include_tpl_file' => "header.tpl", 'smarty_include_vars' => array()));
$this->_tpl_vars = $_smarty_tpl_vars;
unset($_smarty_tpl_vars);
 ?>

<!-- #BeginEditable "editable" --> <font face="Verdana, Arial, Helvetica, sans-serif" size="2"><div id="container"> </font> 
<form action="bdresult_cat.php" method="get">
  <div id="searchform"> 
	<h3><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Cerca a la 
	  base de dades <?php echo $this->_tpl_vars['BDSelected']; ?>
 de l'Herbari de la Universitat de Barcelona (BCN) </font></h3>
	<div> 
	  <div class="buscador"> <font face="Verdana, Arial, Helvetica, sans-serif" size="2"><span class="search-2"><strong>Nom 
		del tàxon:</strong><br />
		<input name="nameauthoryearstring" id="nameauthoryearstring" value="" size="30" style="width: 15em;" type="text">
		</span> <span class="search-2"><strong>Família:</strong><br />
		<select name="highertaxon">
		    <option value="">Totes</option>
		</select>
		</span> <span class="search-2"><strong>País:</strong><br />
		<select name="countryname">
		    <option value="">Tots</option>
		</select>
		</span> <span class="search-2"><strong>Recol·lectors:</strong><br />
		<input name="agenttext" id="agenttext" value="" size="30" style="width: 10em;" type="text">
		</span> <span class="search-2"><strong>UTM:</strong><br />
		<input name="utmformula" id="utmformula" value="" size="8" style="width: 5em;" type="text">
		</span> <span class="search-1"><strong>Ordenat per:</strong><br />
		<select name="orderby">
		  <option value="nameauthoryearstring">Nom 
		  tàxon</option>
		  <option value="highertaxon">Família</option>
		  <option value="countryname">País</option>
		  <option value="utmformula">UTM</option>
		</select>
		</span> <br>
		<input name="db" type="hidden" value="<?php echo $this->_tpl_vars['BDSelected']; ?>
">
		<input name="submit" value="Cerca" type="submit">
		</font></div>
	</div>
  </div>
</form>
<div style="float: right;"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><a href="bdresult3_cat.php" class="positive">Veure 
  tots els resultats</a></font></div>
<font face="Verdana, Arial, Helvetica, sans-serif" size="2"> 
</font> 
<h3><font face="Verdana, Arial, Helvetica, sans-serif" size="2">0 Resultats trobats</font></h3>
<font face="Verdana, Arial, Helvetica, sans-serif" size="2">No hi ha resultats. 
<a href="#" onClick="javascript:window.history.back();">Torna</a> 

</font> 
<div class="news-summary" style="z-index: 1000;"> 
  <div class="news-body"> 
	<h3><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><a href="bdresult3_cat.php?UnitID=<?php echo '<?php'; ?>
 echo $arr['unitid']<?php echo '?>'; ?>
&db=<?php echo '<?php'; ?>
 echo($_REQUEST['db'])<?php echo '?>'; ?>
"> 
	  </a></font></h3>
	<p class="news-submitted"> <font face="Verdana, Arial, Helvetica, sans-serif" size="2"> 
	  | 
	  </font></p>
	<p> <font face="Verdana, Arial, Helvetica, sans-serif" size="2"> 
	  <b>Localitat:</b> 
	  <b>Recol&middot;lectors:</b> 
	  ( 
	  ) 
	  </font></p>
	<div class="news-details"> <font face="Verdana, Arial, Helvetica, sans-serif" size="2"> 
	  <a href="#" class="tool comments"> 
	  pictures </a> 
	  
	  </font></div>
  </div>
  <ul class="news-digg">
	<li class="digg-count shade-1" id="main0"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><a href="bdresult3_cat.php?UnitID="><strong id="diggs-strong-0">BCN<br>
	  </strong></a></font></li>
  </ul>
</div>
<font face="Verdana, Arial, Helvetica, sans-serif" size="2"> 
 
  </font></div>
<!-- #EndEditable --> 

						
<?php $_smarty_tpl_vars = $this->_tpl_vars;
$this->_smarty_include(array('smarty_include_tpl_file' => "footer.tpl", 'smarty_include_vars' => array()));
$this->_tpl_vars = $_smarty_tpl_vars;
unset($_smarty_tpl_vars);
 ?> 
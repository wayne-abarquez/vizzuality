<?php /* Smarty version 2.6.26, created on 2009-12-02 17:48:31
         compiled from sheetresult.tpl */ ?>
<?php require_once(SMARTY_CORE_DIR . 'core.load_plugins.php');
smarty_core_load_plugins(array('plugins' => array(array('function', 'html_options', 'sheetresult.tpl', 15, false),array('modifier', 'count', 'sheetresult.tpl', 52, false),)), $this); ?>
<?php $_smarty_tpl_vars = $this->_tpl_vars;
$this->_smarty_include(array('smarty_include_tpl_file' => "newheader.tpl", 'smarty_include_vars' => array()));
$this->_tpl_vars = $_smarty_tpl_vars;
unset($_smarty_tpl_vars);
 ?>

<div class="content">
<form action="sheetresult.php" method="get">
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
			<?php echo smarty_function_html_options(array('values' => $this->_tpl_vars['families'],'output' => $this->_tpl_vars['families']), $this);?>

		 </select>
		</span> <span class="search-2"><strong>País:</strong><br />
		<select name="countryname">
		  <option value="">Tots</option>
		  <?php echo smarty_function_html_options(array('values' => $this->_tpl_vars['countries'],'output' => $this->_tpl_vars['countries']), $this);?>

		</select>
		</span> <span class="search-2"><strong>Recol·lectors:</strong><br />
		<input name="agenttext" id="agenttext" value="" size="30" style="width: 10em;" type="text">
		</span> <span class="search-2"><strong>UTM:</strong><br />
		<input name="utmformula" id="utmformula" value="" size="8" style="width: 5em;" type="text">
		</span> <span class="search-1"><strong>Ordenat per:</strong><br />
		<select name="orderby">
		  <option value="nameauthoryearstring" >Nom 
		  tàxon</option>
		  <option value="highertaxon" >Família</option>
		  <option value="countryname" >País</option>
		  <option value="utmformula" >UTM</option>
		</select>
		</span> <br>
		<input name="db" type="hidden" value="cormofitos">
		<input name="submit" value="Cerca" type="submit">
		</font></div>
	</div>
  </div>
</form>
<div style="float: right;"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><a href="bdresult3_cat.php" class="positive">Veure 
  tots els resultats</a></font></div>
<font face="Verdana, Arial, Helvetica, sans-serif" size="2"> 
</font> 
<?php if (! $this->_tpl_vars['SearchSheetsResults']): ?>
<h3><font face="Verdana, Arial, Helvetica, sans-serif" size="2">0 Resultats trobats</font></h3>
<font face="Verdana, Arial, Helvetica, sans-serif" size="2">No hi ha resultats. 
<a href="#" onClick="javascript:window.history.back();">Torna</a> 
</font> 
<?php else: ?>
<h3> <font face="Verdana, Arial, Helvetica, sans-serif" size="2"> 
  <?php echo count($this->_tpl_vars['SearchSheetsResults']); ?>
 Resultats trobats</font></h3>
<?php endif; ?>

<?php unset($this->_sections['resultado']);
$this->_sections['resultado']['name'] = 'resultado';
$this->_sections['resultado']['loop'] = is_array($_loop=$this->_tpl_vars['SearchSheetsResults']) ? count($_loop) : max(0, (int)$_loop); unset($_loop);
$this->_sections['resultado']['show'] = true;
$this->_sections['resultado']['max'] = $this->_sections['resultado']['loop'];
$this->_sections['resultado']['step'] = 1;
$this->_sections['resultado']['start'] = $this->_sections['resultado']['step'] > 0 ? 0 : $this->_sections['resultado']['loop']-1;
if ($this->_sections['resultado']['show']) {
    $this->_sections['resultado']['total'] = $this->_sections['resultado']['loop'];
    if ($this->_sections['resultado']['total'] == 0)
        $this->_sections['resultado']['show'] = false;
} else
    $this->_sections['resultado']['total'] = 0;
if ($this->_sections['resultado']['show']):

            for ($this->_sections['resultado']['index'] = $this->_sections['resultado']['start'], $this->_sections['resultado']['iteration'] = 1;
                 $this->_sections['resultado']['iteration'] <= $this->_sections['resultado']['total'];
                 $this->_sections['resultado']['index'] += $this->_sections['resultado']['step'], $this->_sections['resultado']['iteration']++):
$this->_sections['resultado']['rownum'] = $this->_sections['resultado']['iteration'];
$this->_sections['resultado']['index_prev'] = $this->_sections['resultado']['index'] - $this->_sections['resultado']['step'];
$this->_sections['resultado']['index_next'] = $this->_sections['resultado']['index'] + $this->_sections['resultado']['step'];
$this->_sections['resultado']['first']      = ($this->_sections['resultado']['iteration'] == 1);
$this->_sections['resultado']['last']       = ($this->_sections['resultado']['iteration'] == $this->_sections['resultado']['total']);
?>
<font face="Verdana, Arial, Helvetica, sans-serif" size="2"> 

<!-- Agents? -->

</font> 
<div class="news-summary" style="z-index: 1000;"> 
  <div class="news-body"> 
	<h3><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><a href="sheetdetail.php?UnitID=<?php echo $this->_tpl_vars['SearchSheetsResults'][$this->_sections['resultado']['index']]['UnitID']; ?>
&db=<?php echo $this->_tpl_vars['BDSelected']; ?>
"> 
	<?php echo $this->_tpl_vars['SearchSheetsResults'][$this->_sections['resultado']['index']]['nameauthoryearstring']; ?>

	  </a></font></h3>
	<p class="news-submitted"> <font face="Verdana, Arial, Helvetica, sans-serif" size="2"> 
	  <?php echo $this->_tpl_vars['SearchSheetsResults'][$this->_sections['resultado']['index']]['highertaxon']; ?>
 | <?php echo $this->_tpl_vars['SearchSheetsResults'][$this->_sections['resultado']['index']]['TypeStatus']; ?>

	  </font></p>
	<p> <font face="Verdana, Arial, Helvetica, sans-serif" size="2"> 
	  <b>Localitat:</b> 
	  <?php echo $this->_tpl_vars['SearchSheetsResults'][$this->_sections['resultado']['index']]['localitytext']; ?>

	  <b>Recol&middot;lectors:</b> 
	  <?php echo $this->_tpl_vars['SearchSheetsResults'][$this->_sections['resultado']['index']]['AgentText']; ?>

	  ( 
<!-- 	  fecha -->
	  ) 
	  </font></p>
	  
<!-- 	  revisar georeferenciados -->
	<div class="news-details"> <font face="Verdana, Arial, Helvetica, sans-serif" size="2"> 
	  <span class="tool"><?php if ($this->_tpl_vars['SearchSheetsResults'][$this->_sections['resultado']['index']]['has_images'] == 0): ?> 0 fotos <?php else: ?> <?php echo $this->_tpl_vars['SearchSheetsResults'][$this->_sections['resultado']['index']]['has_images']; ?>
 fotos <?php endif; ?></span> 
	  <span class="tool">No georeferenciat</span> 
	  </font></div>
  </div>
  <ul class="news-digg">
	<li class="digg-count shade-1" id="main0"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><a href="sheetdetail.php?UnitID=<?php echo $this->_tpl_vars['SearchSheetsResults'][$this->_sections['resultado']['index']]['UnitID']; ?>
&db=<?php echo $this->_tpl_vars['BDSelected']; ?>
"><strong id="diggs-strong-0"><?php echo $this->_tpl_vars['SearchSheetsResults'][$this->_sections['resultado']['index']]['UnitID']; ?>
 BCN<br>
	  </strong></a></font></li>
  </ul>
</div>
  <?php endfor; endif; ?>
</div>


<?php $_smarty_tpl_vars = $this->_tpl_vars;
$this->_smarty_include(array('smarty_include_tpl_file' => "newfooter.tpl", 'smarty_include_vars' => array()));
$this->_tpl_vars = $_smarty_tpl_vars;
unset($_smarty_tpl_vars);
 ?> 
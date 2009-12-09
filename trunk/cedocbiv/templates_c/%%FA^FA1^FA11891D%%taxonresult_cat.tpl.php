<?php /* Smarty version 2.6.26, created on 2009-12-09 12:11:52
         compiled from taxonresult_cat.tpl */ ?>
<?php require_once(SMARTY_CORE_DIR . 'core.load_plugins.php');
smarty_core_load_plugins(array('plugins' => array(array('function', 'math', 'taxonresult_cat.tpl', 66, false),)), $this); ?>
<?php $_smarty_tpl_vars = $this->_tpl_vars;
$this->_smarty_include(array('smarty_include_tpl_file' => "newheader_cat.tpl", 'smarty_include_vars' => array()));
$this->_tpl_vars = $_smarty_tpl_vars;
unset($_smarty_tpl_vars);
 ?>


<div class="content">
<form action="sheetresult.php" method="get">

	<div class="titleIndex"><p>Cerca a la base de dades de <?php echo $this->_tpl_vars['BDSelected']; ?>
 de l'Herbari de la Universitat de Barcelona (BCN)</p></div>
	
<div class="news-body">
	  <div class="taxonMap" id="map"></div>

	<div class="trobats">
	<?php if (! $this->_tpl_vars['SearchTaxonResults']): ?>
	<p>0 Resultats trobats</p><a href="#" onClick="javascript:window.history.back();">Torna</a> 
	<?php else: ?>
	<p><?php echo $this->_tpl_vars['SearchTaxonResults']['count']; ?>
 Resultats trobats</p>
	<?php endif; ?>
	</div>
	
	
	
	<div class="resultsTaxon"> 
	<?php unset($this->_sections['resultado']);
$this->_sections['resultado']['name'] = 'resultado';
$this->_sections['resultado']['loop'] = is_array($_loop=$this->_tpl_vars['SearchTaxonResults']) ? count($_loop) : max(0, (int)$_loop); unset($_loop);
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
	
	<div class="containerResultTaxon">
	<div class="span-1 first shade-1" id="main0"><p><a href="sheetdetail.php?UnitID=<?php echo $this->_tpl_vars['SearchTaxonResults'][$this->_sections['resultado']['index']]['UnitID']; ?>
&amp;db=<?php echo $this->_tpl_vars['BDSelected']; ?>
"><?php echo $this->_tpl_vars['SearchTaxonResults'][$this->_sections['resultado']['index']]['UnitID']; ?>
<br> BCN
	 </a></p></div>

	<div class="span-1 last resultTaxon">
	<a href="taxondetail.php?UnitID=<?php echo $this->_tpl_vars['SearchTaxonResults'][$this->_sections['resultado']['index']]['UnitID']; ?>
&amp;db=<?php echo $this->_tpl_vars['BDSelected']; ?>
"> 
	<?php echo $this->_tpl_vars['SearchTaxonResults'][$this->_sections['resultado']['index']]['nameauthoryearstring']; ?>
</a>
	<p><?php echo $this->_tpl_vars['SearchTaxonResults'][$this->_sections['resultado']['index']]['highertaxon']; ?>
 | <?php echo $this->_tpl_vars['SearchTaxonResults'][$this->_sections['resultado']['index']]['TypeStatus']; ?>
</p>
	<p>  
	  <b>Localitat:</b> 
	  <?php echo $this->_tpl_vars['SearchTaxonResults'][$this->_sections['resultado']['index']]['localitytext']; ?>

	  <b>Recol&middot;lectors:</b> 
	  <?php echo $this->_tpl_vars['SearchTaxonResults'][$this->_sections['resultado']['index']]['AgentText']; ?>

	  ( 
<!-- 	  fecha -->
	  ) 
	</p>
	<div class="news-details">  
	  <span><?php if ($this->_tpl_vars['SearchTaxonResults'][$this->_sections['resultado']['index']]['has_images'] == 0): ?> 0 fotos <?php else: ?> <?php echo $this->_tpl_vars['SearchTaxonResults'][$this->_sections['resultado']['index']]['has_images']; ?>
 fotos <?php endif; ?></span> 
	  <span>No georeferenciat</span> 
	</div>
	
	</div>
	
	</div>
<!-- 	  revisar georeferenciados -->


	<div>
	
    <?php endfor; endif; ?>

</div>

<!--
<div class="paginator">
<?php if ($this->_tpl_vars['SearchTaxonResults']['count'] > 0): ?>
	<p>Tenemos <?php echo $this->_tpl_vars['SearchTaxonResults']['count']; ?>
 resultados</p>
<?php endif; ?>

<?php if ($this->_tpl_vars['SearchTaxonResults']['count'] > 10): ?>
	<p>Viendo del <b><?php echo smarty_function_math(array('equation' => "x+1",'x' => $this->_tpl_vars['offset']), $this);?>
 al <?php echo smarty_function_math(array('equation' => "min(x2 +10,c)",'x2' => $this->_tpl_vars['offset'],'c' => $this->_tpl_vars['SearchTaxonResults']['count']), $this);?>
</b> de <?php echo $this->_tpl_vars['SearchTaxonResults']['count']; ?>

		<?php if ($this->_tpl_vars['offset'] > 0): ?>
		<span><a href="?offset=<?php echo smarty_function_math(array('equation' => "max(x-10,0)",'x' => $this->_tpl_vars['offset']), $this);?>
&amp;nameauthoryearstring=<?php echo $_REQUEST['nameauthoryearstring']; ?>
&amp;genus=<?php echo $_REQUEST['genus']; ?>
&amp;highertaxon=<?php echo $_REQUEST['highertaxon']; ?>
&amp;localitytext=<?php echo $_REQUEST['localitytext']; ?>
&amp;countryname=<?php echo $_REQUEST['countryname']; ?>
&amp;utmformula=<?php echo $_REQUEST['utmformula']; ?>
&amp;agenttext=<?php echo $_REQUEST['agenttext']; ?>
&amp;datesearchtype=<?php echo $_REQUEST['datesearchtype']; ?>
&amp;datetext=<?php echo $_REQUEST['datetext']; ?>
&amp;UnitID=<?php echo $_REQUEST['UnitID']; ?>
&amp;submit=<?php echo $_REQUEST['submit']; ?>
&amp;db=<?php echo $_REQUEST['db']; ?>
"><input class="leftPaginator" type="button" value="Anterior"></a></span>
		<?php endif; ?>
		<?php if ($this->_tpl_vars['offset'] < $this->_tpl_vars['SearchTaxonResults']['count']-10): ?>
		<span><a href="?offset=<?php echo $this->_tpl_vars['offset']+10; ?>
&amp;&amp;nameauthoryearstring=<?php echo $_REQUEST['nameauthoryearstring']; ?>
&amp;genus=<?php echo $_REQUEST['genus']; ?>
&amp;highertaxon=<?php echo $_REQUEST['highertaxon']; ?>
&amp;localitytext=<?php echo $_REQUEST['localitytext']; ?>
&amp;countryname=<?php echo $_REQUEST['countryname']; ?>
&amp;utmformula=<?php echo $_REQUEST['utmformula']; ?>
&amp;agenttext=<?php echo $_REQUEST['agenttext']; ?>
&amp;datesearchtype=<?php echo $_REQUEST['datesearchtype']; ?>
&amp;datetext=<?php echo $_REQUEST['datetext']; ?>
&amp;UnitID=<?php echo $_REQUEST['UnitID']; ?>
&amp;submit=<?php echo $_REQUEST['submit']; ?>
&amp;db=<?php echo $_REQUEST['db']; ?>
"><input class="rightPaginator" type="button" value="Siguiente"></a></span>
	    <?php endif; ?>	
	</p>	
<?php endif; ?>
</div>
-->

</div> <!-- news -->

</form>
</div>

<?php echo '<script src="http://maps.google.com/maps?file=api&v=2&key=nokey" type="text/javascript"></script>'; ?>


<?php echo '
<script type="text/javascript">
//<![CDATA[
var map;
if (GBrowserIsCompatible()) {
map = new GMap(document.getElementById("map"));
var point = new GLatLng(40.38051877130511, -3.7238287925720215);

map.setCenter(point, 15);
}

//]]>
</script>
'; ?>


<?php $_smarty_tpl_vars = $this->_tpl_vars;
$this->_smarty_include(array('smarty_include_tpl_file' => "newfooter_cat.tpl", 'smarty_include_vars' => array()));
$this->_tpl_vars = $_smarty_tpl_vars;
unset($_smarty_tpl_vars);
 ?> 
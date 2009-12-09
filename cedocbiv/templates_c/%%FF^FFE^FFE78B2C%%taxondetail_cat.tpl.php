<?php /* Smarty version 2.6.26, created on 2009-12-09 12:11:59
         compiled from taxondetail_cat.tpl */ ?>
<?php $_smarty_tpl_vars = $this->_tpl_vars;
$this->_smarty_include(array('smarty_include_tpl_file' => "newheader_cat.tpl", 'smarty_include_vars' => array()));
$this->_tpl_vars = $_smarty_tpl_vars;
unset($_smarty_tpl_vars);
 ?>

<div class="content">
  <h3><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Base de dades 
	de <?php echo $this->_tpl_vars['BDSelected']; ?>
</font></h3>
  
	<div class="news-body">
	  <?php unset($this->_sections['mostrar']);
$this->_sections['mostrar']['name'] = 'mostrar';
$this->_sections['mostrar']['loop'] = is_array($_loop=$this->_tpl_vars['Ident']) ? count($_loop) : max(0, (int)$_loop); unset($_loop);
$this->_sections['mostrar']['show'] = true;
$this->_sections['mostrar']['max'] = $this->_sections['mostrar']['loop'];
$this->_sections['mostrar']['step'] = 1;
$this->_sections['mostrar']['start'] = $this->_sections['mostrar']['step'] > 0 ? 0 : $this->_sections['mostrar']['loop']-1;
if ($this->_sections['mostrar']['show']) {
    $this->_sections['mostrar']['total'] = $this->_sections['mostrar']['loop'];
    if ($this->_sections['mostrar']['total'] == 0)
        $this->_sections['mostrar']['show'] = false;
} else
    $this->_sections['mostrar']['total'] = 0;
if ($this->_sections['mostrar']['show']):

            for ($this->_sections['mostrar']['index'] = $this->_sections['mostrar']['start'], $this->_sections['mostrar']['iteration'] = 1;
                 $this->_sections['mostrar']['iteration'] <= $this->_sections['mostrar']['total'];
                 $this->_sections['mostrar']['index'] += $this->_sections['mostrar']['step'], $this->_sections['mostrar']['iteration']++):
$this->_sections['mostrar']['rownum'] = $this->_sections['mostrar']['iteration'];
$this->_sections['mostrar']['index_prev'] = $this->_sections['mostrar']['index'] - $this->_sections['mostrar']['step'];
$this->_sections['mostrar']['index_next'] = $this->_sections['mostrar']['index'] + $this->_sections['mostrar']['step'];
$this->_sections['mostrar']['first']      = ($this->_sections['mostrar']['iteration'] == 1);
$this->_sections['mostrar']['last']       = ($this->_sections['mostrar']['iteration'] == $this->_sections['mostrar']['total']);
?>

	  <h3> 
	  <?php echo $this->_tpl_vars['Ident'][0]['NameAuthorYearString']; ?>
		
	  </h3>

	  <p>Publicat el 22-08-2005 </p>
	  
	  <br />
	  <span class="label">Fam&iacute;lia:</span> 
		  <?php echo $this->_tpl_vars['Ident'][0]['HigherTaxon']; ?>
		
	  </h3>
	  
	  <br />
	  	  <span class="label">Nom etiqueta:</span> 
	  		  <?php echo $this->_tpl_vars['Ident'][1]['NameAuthorYearString']; ?>
		
	  <br />

	  <span class="label">Guardat com:</span> 
	  <?php echo $this->_tpl_vars['Ident'][0]['NameAuthorYearString']; ?>
	  
	  <br />
	  <br />
	  <span class="label">Localitat: </span> 
	  <?php echo $this->_tpl_vars['Units']['LocalityText']; ?>

	  <br />
	  <span class="label">Pa’s: </span> 
	  	  <?php echo $this->_tpl_vars['Units']['CountryName']; ?>

	  <br />
	  <span class="label">Altitud: </span> 
	  	  <?php echo $this->_tpl_vars['Units']['AltitudeLowerValue']; ?>
 <!-- meter tb UpperValue -->
	  <br />
	  <br />
	  <span class="label">Recol&middot;lectors:</span> 
	  	  <?php echo $this->_tpl_vars['Agents']['GatheringAgentsText']; ?>
 <!-- meter tb UpperValue --> 
	  <br />
	  	  <span class="label">H&agrave;bitat: </span> 
	  <?php echo $this->_tpl_vars['Units']['BiotopeText']; ?>
	  <br />
	  
<!-- 	  meter CollectorNumber -->

	  <span class="label">Data de recol&middot;lecci—:</span> 
	  25-05-1985	  <br />
	  <span class="label">Col&middot;lecci—:</span> 
	  <?php echo $this->_tpl_vars['Units']['ProjectTitle']; ?>
	  <br />	  <br />
	  <span class="label">Fenologia:</span> 
	  <?php echo $this->_tpl_vars['Units']['Phenology']; ?>
	  	  <br />
	  
	  <?php if ($this->_tpl_vars['Images']): ?>
	  <div>
	  <p>Imagenes</p>
    	<?php unset($this->_sections['imagenes']);
$this->_sections['imagenes']['name'] = 'imagenes';
$this->_sections['imagenes']['loop'] = is_array($_loop=$this->_tpl_vars['Images']) ? count($_loop) : max(0, (int)$_loop); unset($_loop);
$this->_sections['imagenes']['show'] = true;
$this->_sections['imagenes']['max'] = $this->_sections['imagenes']['loop'];
$this->_sections['imagenes']['step'] = 1;
$this->_sections['imagenes']['start'] = $this->_sections['imagenes']['step'] > 0 ? 0 : $this->_sections['imagenes']['loop']-1;
if ($this->_sections['imagenes']['show']) {
    $this->_sections['imagenes']['total'] = $this->_sections['imagenes']['loop'];
    if ($this->_sections['imagenes']['total'] == 0)
        $this->_sections['imagenes']['show'] = false;
} else
    $this->_sections['imagenes']['total'] = 0;
if ($this->_sections['imagenes']['show']):

            for ($this->_sections['imagenes']['index'] = $this->_sections['imagenes']['start'], $this->_sections['imagenes']['iteration'] = 1;
                 $this->_sections['imagenes']['iteration'] <= $this->_sections['imagenes']['total'];
                 $this->_sections['imagenes']['index'] += $this->_sections['imagenes']['step'], $this->_sections['imagenes']['iteration']++):
$this->_sections['imagenes']['rownum'] = $this->_sections['imagenes']['iteration'];
$this->_sections['imagenes']['index_prev'] = $this->_sections['imagenes']['index'] - $this->_sections['imagenes']['step'];
$this->_sections['imagenes']['index_next'] = $this->_sections['imagenes']['index'] + $this->_sections['imagenes']['step'];
$this->_sections['imagenes']['first']      = ($this->_sections['imagenes']['iteration'] == 1);
$this->_sections['imagenes']['last']       = ($this->_sections['imagenes']['iteration'] == $this->_sections['imagenes']['total']);
?>
    		<a href="<?php echo $this->_tpl_vars['Images'][$this->_sections['imagenes']['index']]['ImageURI']; ?>
"><?php echo $this->_tpl_vars['Images'][$this->_sections['imagenes']['index']]['ImageURI']; ?>
</a><br />
    	<?php endfor; endif; ?>
	  </div>
	  <?php endif; ?>
  	<?php endfor; endif; ?>	  
	 </div>
	
  </div>

<?php $_smarty_tpl_vars = $this->_tpl_vars;
$this->_smarty_include(array('smarty_include_tpl_file' => "newfooter_cat.tpl", 'smarty_include_vars' => array()));
$this->_tpl_vars = $_smarty_tpl_vars;
unset($_smarty_tpl_vars);
 ?>
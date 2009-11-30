<?php /* Smarty version 2.6.26, created on 2009-11-30 00:39:14
         compiled from queryForm_cat.tpl */ ?>
<?php $_smarty_tpl_vars = $this->_tpl_vars;
$this->_smarty_include(array('smarty_include_tpl_file' => "header.tpl", 'smarty_include_vars' => array()));
$this->_tpl_vars = $_smarty_tpl_vars;
unset($_smarty_tpl_vars);
 ?>

<!-- #BeginEditable "editable" --> 
<div id="container"> 
  <h3><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Base de dades 
	de <?php echo $this->_tpl_vars['BDSelected']; ?>
 de l'Herbari de la Universitat de Barcelona (BCN)</font></h3>
  <?php if ($this->_tpl_vars['BDSelected'] == 'cormofitos'): ?>
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
  <?php endif; ?>
  <?php if ($this->_tpl_vars['BDSelected'] == 'algas'): ?> 
  <font face="Verdana, Arial, Helvetica, sans-serif" size="2"> 
  <p><font face="Verdana, Arial, Helvetica, sans-serif" size="2"> En aquesta base 
	de dades es recullen pr&agrave;cticament totes les mostres d'algues de l'herbari. 
	Si amb la vostra consulta no obteniu els resultats esperats <a href="mailto:cedocbiv@pcb.ub.es">poseu-vos 
	en contacte</a> amb el personal del centre i indiqueu clarament la informaci&oacute; 
	que desitgeu localitzar.</font></p>
  </font> 
  <?php endif; ?>
  <?php if ($this->_tpl_vars['BDSelected'] == 'briofitos'): ?> 
  <font face="Verdana, Arial, Helvetica, sans-serif" size="2"> 
  <p><font face="Verdana, Arial, Helvetica, sans-serif" size="2"> La informatitzaci&oacute; 
	dels bri&ograve;fits de l' herbari BCN s'ha iniciat recentment i de moment 
	el nombre de registres que cont&eacute; aquesta base de dades &eacute;s molt 
	baix. Si amb la vostra consulta no obteniu els resultats esperats <a href="mailto:cedocbiv@pcb.ub.es">poseu-vos 
	en contacte</a> amb el personal del centre i indiqueu clarament la informaci&oacute; 
	que desitgeu localitzar.</font></p>
  </font>
  <?php endif; ?>
  <?php if ($this->_tpl_vars['BDSelected'] == 'carpoteca'): ?> 
  <font face="Verdana, Arial, Helvetica, sans-serif" size="2"> 
  <p><font face="Verdana, Arial, Helvetica, sans-serif" size="2"> La col&middot;lecci&oacute; 
	de fruits i llavors de l'herbari BCN actualment est&agrave; pr&agrave;ctiament 
	informatitzada en la seva totalitat. Si desitgeu consultar nom&eacute;s els 
	registres que inclouen imatges podeu consultar directament l'apartat de la 
	carpoteca de l'<a href="http://www.ub.es/cedocbiv/indexcar.htm">herbari virtual</a>.</font></p>
  </font> 
  <?php endif; ?>
  <?php if ($this->_tpl_vars['BDSelected'] == 'hongos'): ?> 
  <font face="Verdana, Arial, Helvetica, sans-serif" size="2"> 
  <p><font face="Verdana, Arial, Helvetica, sans-serif" size="2"> La informatitzaci&oacute; 
	de la col&middot;lecci&oacute; de fongs de l' herbari BCN s'ha iniciat recentment 
	i de moment el nombre de registres que cont&eacute; aquesta base de dades 
	&eacute;s molt baix. Si amb la vostra consulta no obteniu els resultats esperats 
	<a href="mailto:cedocbiv@pcb.ub.es">poseu-vos en contacte</a> amb el personal 
	del centre i indiqueu clarament la informaci&oacute; que desitgeu localitzar.</font></p>
  </font> 
  <?php endif; ?>
  <?php if ($this->_tpl_vars['BDSelected'] == 'liquenes'): ?> 
  <font face="Verdana, Arial, Helvetica, sans-serif" size="2"> 
  <p><font face="Verdana, Arial, Helvetica, sans-serif" size="2"> La informatitzaci&oacute; 
	de la col&middot;lecci&oacute; de l&iacute;quens s'ha iniciat pels exemplars 
	tipus que es conserven a l'herbari. Si no obteniu els resultats esperats <a href="mailto:cedocbiv@pcb.ub.es">poseu-vos 
	en contacte</a> amb el personal del centre i indiqueu clarament les mostres 
	que desitgeu localitzar.</font></p>
  </font> 
  <?php endif; ?>
  <p><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><span class="positive"><b>&Uacute;ltima 
	actualitzaci&oacute;:</b></span> <?php echo $this->_tpl_vars['LastUpdate']; ?>

	<br>
	<b class="positive">Registres:</b> <?php echo $this->_tpl_vars['Numregistros']; ?>

	</font></p>
  <p><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Per a fer una 
	consulta ompliu el camp corresponent. Podeu fer servir l'asterisc (*) en qualsevol 
	posici&oacute; d'una paraula. </font></p>
  <div id="queryForm"> 
	<form action="bdresult2_cat.php" method="get" name="thisform" id="thisform">
	  <h2><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Consulta</font></h2>
	  <div class="instruction"> 
		<div> <font face="Verdana, Arial, Helvetica, sans-serif" size="2"><span class="search-1"> 
		  <label for="search">Nom del tàxon:</label> (Acro*)<br />
		  <input name="nameauthoryearstring" id="nameauthoryearstring" size="30" style="width: 15em;" type="text" />
		  </span> <span class="search-1"><strong>Gènere:</strong> (Acant*) <br />
		  <select name="genus">
			<option value="">Tots</option>
			<?php $_from = $this->_tpl_vars['GenusResults']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }if (count($_from)):
    foreach ($_from as $this->_tpl_vars['id'] => $this->_tpl_vars['genus']):
?>
				<option value="<?php echo $this->_tpl_vars['genus']; ?>
"></option> 
			<?php endforeach; endif; unset($_from); ?>
		  </select>
		  </span> <span class="search-2"><strong>Família:</strong><br />
		  <select name="highertaxon">
			<option value="">Totes</option>
			<?php $_from = $this->_tpl_vars['HighertaxonResults']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }if (count($_from)):
    foreach ($_from as $this->_tpl_vars['id'] => $this->_tpl_vars['highertaxon']):
?>
				<option value="<?php echo $this->_tpl_vars['highertaxon']['highertaxon']; ?>
"></option> 
			<?php endforeach; endif; unset($_from); ?>
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
		  <input name="db" type="hidden" value="<?php echo '<?php'; ?>
 echo($_REQUEST['db'])<?php echo '?>'; ?>
">
		  </font></div>
	  </div>
	</form>
  </div>
</div>
						
<?php $_smarty_tpl_vars = $this->_tpl_vars;
$this->_smarty_include(array('smarty_include_tpl_file' => "footer.tpl", 'smarty_include_vars' => array()));
$this->_tpl_vars = $_smarty_tpl_vars;
unset($_smarty_tpl_vars);
 ?> 
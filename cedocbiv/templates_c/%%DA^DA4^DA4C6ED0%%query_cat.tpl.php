<?php /* Smarty version 2.6.26, created on 2009-12-09 02:45:13
         compiled from query_cat.tpl */ ?>
<?php require_once(SMARTY_CORE_DIR . 'core.load_plugins.php');
smarty_core_load_plugins(array('plugins' => array(array('function', 'html_options', 'query_cat.tpl', 82, false),)), $this); ?>
<?php $_smarty_tpl_vars = $this->_tpl_vars;
$this->_smarty_include(array('smarty_include_tpl_file' => "newheader_cat.tpl", 'smarty_include_vars' => array()));
$this->_tpl_vars = $_smarty_tpl_vars;
unset($_smarty_tpl_vars);
 ?>
						
<?php echo '
<script type="text/javascript" src="/js/tabber.js"></script>
'; ?>


<div class="content">
<div class="news-body">
  <div class="titleIndex"><p>Base de dades de <?php echo $this->_tpl_vars['BDSelected']; ?>
 de l'Herbari de la Universitat de Barcelona (BCN)</p></div>
  <div class="TextBD">
  <?php if ($this->_tpl_vars['BDSelected'] == 'cormofitos'): ?>
  <p class="texto_intro">La informatitzaci&oacute; de les mostres de plantes vasculars de l'herbari BCN es va iniciar abans de 
	la fusi&oacute; dels herbaris de les facultats de Biologia i de Farmacia. 
	Pel fet de ser la m&eacute;s gran de les col&middot;leccions de l'herbari, 
	la seva completa informatitzaci&oacute; &eacute;s un projecte a llarg termini. 
	Actualment aquesta base de dades recull b&agrave;sicament els registres corresponents 
	a la fam&iacute;lia de las aster&agrave;cies, escrofulari&agrave;cies, lami&agrave;cies, 
	boragin&agrave;cies i fab&agrave;cies. Si amb la vostra consulta no obteniu 
	els resultats esperats o b&eacute; voleu cercar mostres d'altres grups, <a href="mailto:cedocbiv@pcb.ub.es">poseu-vos 
	en contacte</a> amb el personal del centre i indiqueu clarament la informaci&oacute; 
	que desitgeu localitzar.
  </p>
  <?php endif; ?>
  
  <?php if ($this->_tpl_vars['BDSelected'] == 'algas'): ?> 
  <p class="texto_intro">En aquesta base de dades es recullen pr&agrave;cticament totes les mostres d'algues de l'herbari. 
	Si amb la vostra consulta no obteniu els resultats esperats <a href="mailto:cedocbiv@pcb.ub.es">poseu-vos 
	en contacte</a> amb el personal del centre i indiqueu clarament la informaci&oacute; 
	que desitgeu localitzar.
  </p>
  <?php endif; ?>
  
  <?php if ($this->_tpl_vars['BDSelected'] == 'briofitos'): ?> 
  <p class="texto_intro">La informatitzaci&oacute; dels bri&ograve;fits de l' herbari BCN s'ha iniciat recentment i de moment 
	el nombre de registres que cont&eacute; aquesta base de dades &eacute;s molt 
	baix. Si amb la vostra consulta no obteniu els resultats esperats <a href="mailto:cedocbiv@pcb.ub.es">poseu-vos 
	en contacte</a> amb el personal del centre i indiqueu clarament la informaci&oacute; 
	que desitgeu localitzar.
  </p>
  <?php endif; ?>
  
  <?php if ($this->_tpl_vars['BDSelected'] == 'carpoteca'): ?> 
  <p class="texto_intro">La col&middot;lecci&oacute; de fruits i llavors de l'herbari BCN actualment est&agrave; pr&agrave;ctiament 
	informatitzada en la seva totalitat. Si desitgeu consultar nom&eacute;s els 
	registres que inclouen imatges podeu consultar directament l'apartat de la 
	carpoteca de l'<a href="http://www.ub.es/cedocbiv/indexcar.htm">herbari virtual</a>
  </p>
  <?php endif; ?>
  
  <?php if ($this->_tpl_vars['BDSelected'] == 'hongos'): ?> 
  <p class="texto_intro">La informatitzaci&oacute; de la col&middot;lecci&oacute; de fongs de l' herbari BCN s'ha iniciat recentment 
	i de moment el nombre de registres que cont&eacute; aquesta base de dades 
	&eacute;s molt baix. Si amb la vostra consulta no obteniu els resultats esperats 
	<a href="mailto:cedocbiv@pcb.ub.es">poseu-vos en contacte</a> amb el personal 
	del centre i indiqueu clarament la informaci&oacute; que desitgeu localitzar.
  </p>
  <?php endif; ?>
  
  <?php if ($this->_tpl_vars['BDSelected'] == 'liquenes'): ?> 
  <p class="texto_intro">La informatitzaci&oacute; de la col&middot;lecci&oacute; de l&iacute;quens s'ha iniciat pels exemplars 
	tipus que es conserven a l'herbari. Si no obteniu els resultats esperats <a href="mailto:cedocbiv@pcb.ub.es">poseu-vos 
	en contacte</a> amb el personal del centre i indiqueu clarament les mostres 
	que desitgeu localitzar.</p>
  <?php endif; ?>
  <p class="info">&Uacute;ltima actualitzaci&oacute;: <b><?php echo $this->_tpl_vars['LastUpdate']; ?>
</b> | Registres: <b><?php echo $this->_tpl_vars['Numregistros']; ?>
</b> | Per a fer una consulta ompliu el camp corresponent. Podeu fer servir l'asterisc (*) en qualsevol posici&oacute; d'una paraula.</p>
  </div>
  
<div class="tabber">
   <div class="tabbertab">
	  <div id="queryForm" class="buscador"> 
	     <form action="sheetresult.php" method="get" name="thisform" id="thisform">
	     <h2>Buscar Pliego</h2>
	     <div class="instruction"> 
		    <div>
		    <span class="search-1"> 
		  		<label for="search">Nom del tàxon:</label> (Acro*)<br />
		 		<input name="nameauthoryearstring" id="nameauthoryearstring" size="30" style="width: 15em;" type="text" />
		  	</span>
		  	<span class="search-1"><strong>Gènere:</strong> (Acant*) <br />
			<select name="genus">
				<option value="">Totes</option>
				<?php echo smarty_function_html_options(array('values' => $this->_tpl_vars['genus'],'output' => $this->_tpl_vars['genus']), $this);?>

			</select>	
		    </span> 
		    <span class="search-2"><strong>Família:</strong><br />
			<select name="highertaxon">
				<option value="">Totes</option>
				<?php echo smarty_function_html_options(array('values' => $this->_tpl_vars['families'],'output' => $this->_tpl_vars['families']), $this);?>

			</select>			
		    </span><br />
		    <br />
		    <br />
		    <span class="search-1"> 
		       <label for="search">Localitat:</label> (*Balagu*)<br />
		       <input name="localitytext" id="localitytext" size="30" style="width: 15em;" type="text" />
		    </span> 
		    <span class="search-1"><strong>País:</strong><br />
		       <select name="countryname">
			   <option value="">Tots</option>
			   <?php echo smarty_function_html_options(array('values' => $this->_tpl_vars['countries'],'output' => $this->_tpl_vars['countries']), $this);?>

		       </select>
		    </span> 
		    <span class="search-2"><strong>UTM:</strong> (31TCG65) <br />
		       <input name="utmformula" id="utmformula" size="8" style="width: 5em;" type="text" />
		    </span>
		    <br />
		  	<br />
		  	<br />
		    <span class="search-1"><strong>Recol·lectors:</strong> (*Sennen*)<br />
		       <input name="agenttext" id="agenttext" size="30" style="width: 15em;" type="text" />
		    </span> 
		    <span class="search-2"><strong>Data recol·lecció:</strong> (1984-05-14)<br />
		        <select name="datesearchtype" size="1" id="datesearchtype">
			    <option value="greaterthan">Abans de</option>
			    <option value="lessthan">Després de</option>
			    <option value="equal">Igual que (amb *)</option>
		        </select>
		  		<input name="datetext" id="datetext" size="8" style="width: 5em;">
		  	</span> 
		  	<br />
		    <br />
		    <br />
		    <span class="search-1"><strong>Número d'herbari: </strong> (104*)<br />BCN 
		    	<input name="UnitID" id="UnitID" size="30" style="width: 5em;" type="text" />
		  	</span> 
		  	<br />
		  	<br />
		  	<br />
		  	<input name="submit" value="Cerca" type="submit"/>
		  	<input name="db" type="hidden" value="<?php echo $this->_tpl_vars['BDSelected']; ?>
">
		  </div>
	  </div>
	</form>
  </div>
	  
     </div> <!-- del tab de pliego -->


     <div class="tabbertab">
	  
	<div id="queryForm2" class="buscador"> 
	<form action="taxonresult.php" method="get" name="thisform" id="thisform">
	  <h2>Buscar Taxon</h2>
	  <div class="instruction"> 
		<div>
		  <span class="search-1"> 
		     <label for="search">Nom del tàxon:</label> (Acro*)<br />
		     <input name="nameauthoryearstring" id="nameauthoryearstring" size="30" style="width: 15em;" type="text" />
		  </span> 
		  <span class="search-1"><strong>Gènere:</strong> (Acant*) <br />
			<select name="genus">
				<option value="">Totes</option>
				<?php echo smarty_function_html_options(array('values' => $this->_tpl_vars['genus'],'output' => $this->_tpl_vars['genus']), $this);?>

			</select>	
		  </span> 
		  <span class="search-2"><strong>Família:</strong><br />
			<select name="highertaxon">
				<option value="">Totes</option>
				<?php echo smarty_function_html_options(array('values' => $this->_tpl_vars['families'],'output' => $this->_tpl_vars['families']), $this);?>

			</select>			
		  </span>
		  <br />
		  <br />
		  <br />
		  <br />
		  <input name="submit" value="Cerca" type="submit"/>
		  <input name="db" type="hidden" value="<?php echo $this->_tpl_vars['BDSelected']; ?>
">
		  </font></div>
	  </div>
	</form>
  </div>
	  
</div>

						
<?php $_smarty_tpl_vars = $this->_tpl_vars;
$this->_smarty_include(array('smarty_include_tpl_file' => "newfooter_cat.tpl", 'smarty_include_vars' => array()));
$this->_tpl_vars = $_smarty_tpl_vars;
unset($_smarty_tpl_vars);
 ?> 
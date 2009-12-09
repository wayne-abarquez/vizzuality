<?php /* Smarty version 2.6.26, created on 2009-12-04 01:27:48
         compiled from home_es.tpl */ ?>
<?php $_smarty_tpl_vars = $this->_tpl_vars;
$this->_smarty_include(array('smarty_include_tpl_file' => "newheader_es.tpl", 'smarty_include_vars' => array()));
$this->_tpl_vars = $_smarty_tpl_vars;
unset($_smarty_tpl_vars);
 ?>
						
<div class="content">
	<div class="titleIndex"><p>Bases de Dades de l'Herbari BCN</p></div>

	<div class="news-body"> 
	  <p class="texto_intro">Des d'aquesta p‡gina podeu accedir a les sis bases de dades de l'herbari 
		BCN, que es corresponen a les respectives colleccions que allotja el centre. Cliqueu en la base de dades que volgueu consultar:</p>
	  
	  <a class="link_bd" href="query.php?db=algas">Algues</a>
	  <p class="subheader">aprox. <b>99%</b> informatitzat | <b> 
		<?php echo $this->_tpl_vars['NumregistrosAlgas']; ?>

		</b> registres | <b> 
		<?php echo $this->_tpl_vars['NumRegistrosImagenAlgas']; ?>

		</b> imatges | <b> 
		<?php echo $this->_tpl_vars['NumRegistrosGeoreferenciadosAlgas']; ?>

		</b> registres georeferenciats</p>
		
	  <a class="link_bd" href="query.php?db=briofitos">Bri—fits</a>
	  <p class="subheader">aprox. <b>3%</b> informatitzat | <b> 
		<?php echo $this->_tpl_vars['NumregistrosBriofitos']; ?>

		</b> registres | <b> 
		<?php echo $this->_tpl_vars['NumRegistrosImagenBriofitos']; ?>

		</b> imatges | <b> 
		<?php echo $this->_tpl_vars['NumRegistrosGeoreferenciadosBriofitos']; ?>

		</b> registres georeferenciats</p>
	  
	  <a class="link_bd" href="query.php?db=cormofitos">Corm—fits</a>
	  <p class="subheader">aprox. <b>5%</b> informatizado | <b> 
		<?php echo $this->_tpl_vars['NumregistrosCormofitos']; ?>

		</b> registres | <b> 
		<?php echo $this->_tpl_vars['NumRegistrosImagenCormofitos']; ?>

		</b> imatges | <b> 
		<?php echo $this->_tpl_vars['NumRegistrosGeoreferenciadosCormofitos']; ?>

		</b> registres georeferenciats</p>
	  
	  <a class="link_bd" href="query.php?db=carpoteca">Collecci— de fruits i llavors</a>
	  <p class="subheader">aprox <b>98%</b> informatitzat | <b> 
		<?php echo $this->_tpl_vars['NumregistrosCarpoteca']; ?>

		</b> registres | <b> 
		<?php echo $this->_tpl_vars['NumRegistrosImagenCarpoteca']; ?>

		</b> imatges | <b> 
		<?php echo $this->_tpl_vars['NumRegistrosGeoreferenciadosCarpoteca']; ?>

		</b> registres georeferenciats</p>
	  
	  <a class="link_bd" href="query.php?db=hongos">Fongs</a>
	  <p class="subheader">aprox. <b>1%</b> informatitzat | <b> 
		<?php echo $this->_tpl_vars['NumregistrosHongos']; ?>

		</b> registres | <b> 
		<?php echo $this->_tpl_vars['NumRegistrosImagenHongos']; ?>

		</b> imatges | <b> 
		<?php echo $this->_tpl_vars['NumRegistrosGeoreferenciadosHongos']; ?>

		</b> registres georeferenciats</p>
	  
	  <a class="link_bd" href="query.php?db=liquenes">L’quens</a>
	  <p class="subheader">aprox. <b>1%</b> informatitzat | <b> 
		<?php echo $this->_tpl_vars['NumregistrosLiquenes']; ?>

		</b> registres | <b> 
		<?php echo $this->_tpl_vars['NumRegistrosImagenLiquenes']; ?>

		</b> imatges | <b> 
		<?php echo $this->_tpl_vars['NumRegistrosGeoreferenciadosLiquenes']; ?>

		</b> registres georeferenciats</p>
	</div>

</div>
						
<?php $_smarty_tpl_vars = $this->_tpl_vars;
$this->_smarty_include(array('smarty_include_tpl_file' => "newfooter_es.tpl", 'smarty_include_vars' => array()));
$this->_tpl_vars = $_smarty_tpl_vars;
unset($_smarty_tpl_vars);
 ?> 
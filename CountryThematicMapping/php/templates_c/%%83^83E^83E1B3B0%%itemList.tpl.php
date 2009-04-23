<?php /* Smarty version 2.6.22, created on 2009-03-03 02:32:31
         compiled from itemList.tpl */ ?>
<?php require_once(SMARTY_CORE_DIR . 'core.load_plugins.php');
smarty_core_load_plugins(array('plugins' => array(array('modifier', 'escape', 'itemList.tpl', 2, false),array('modifier', 'date_format', 'itemList.tpl', 5, false),)), $this); ?>
<?php $_from = $this->_tpl_vars['data']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }if (count($_from)):
    foreach ($_from as $this->_tpl_vars['entry']):
?>
	<h1>Title: <?php echo ((is_array($_tmp=$this->_tpl_vars['entry']['title'])) ? $this->_run_mod_handler('escape', true, $_tmp) : smarty_modifier_escape($_tmp)); ?>
</h1>
	<h2>Description: <?php echo ((is_array($_tmp=$this->_tpl_vars['entry']['description'])) ? $this->_run_mod_handler('escape', true, $_tmp) : smarty_modifier_escape($_tmp)); ?>
</h2>
	<p>Content: <?php echo ((is_array($_tmp=$this->_tpl_vars['entry']['content'])) ? $this->_run_mod_handler('escape', true, $_tmp) : smarty_modifier_escape($_tmp)); ?>
</p>
	<p>Date: <?php echo ((is_array($_tmp=$this->_tpl_vars['entry']['pubdate'])) ? $this->_run_mod_handler('date_format', true, $_tmp, "%d/%m/%y") : smarty_modifier_date_format($_tmp, "%d/%m/%y")); ?>
</p>
	<p><a href="<?php echo $this->_tpl_vars['entry']['link']; ?>
">Link</a></p>
	<p>Source:<?php echo ((is_array($_tmp=$this->_tpl_vars['entry']['source'])) ? $this->_run_mod_handler('escape', true, $_tmp) : smarty_modifier_escape($_tmp)); ?>
</p>

	<hr />
<?php endforeach; else: ?>
    <p>No hay items</p>
<?php endif; unset($_from); ?>	
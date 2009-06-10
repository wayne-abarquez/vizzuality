<?php /* Smarty version 2.6.22, created on 2009-03-03 02:17:52
         compiled from itemDetail.tpl */ ?>
<?php require_once(SMARTY_CORE_DIR . 'core.load_plugins.php');
smarty_core_load_plugins(array('plugins' => array(array('modifier', 'escape', 'itemDetail.tpl', 1, false),array('modifier', 'date_format', 'itemDetail.tpl', 4, false),)), $this); ?>
<h1>Title: <?php echo ((is_array($_tmp=$this->_tpl_vars['data']['title'])) ? $this->_run_mod_handler('escape', true, $_tmp) : smarty_modifier_escape($_tmp)); ?>
</h1>
<h2>Description: <?php echo ((is_array($_tmp=$this->_tpl_vars['data']['description'])) ? $this->_run_mod_handler('escape', true, $_tmp) : smarty_modifier_escape($_tmp)); ?>
</h2>
<p>Content: <?php echo ((is_array($_tmp=$this->_tpl_vars['data']['content'])) ? $this->_run_mod_handler('escape', true, $_tmp) : smarty_modifier_escape($_tmp)); ?>
</p>
<p>Date: <?php echo ((is_array($_tmp=$this->_tpl_vars['data']['pubdate'])) ? $this->_run_mod_handler('date_format', true, $_tmp, "%d/%m/%y") : smarty_modifier_date_format($_tmp, "%d/%m/%y")); ?>
</p>
<p><a href="<?php echo $this->_tpl_vars['data']['link']; ?>
">Link</a></p>
<p>Source:<?php echo ((is_array($_tmp=$this->_tpl_vars['data']['source'])) ? $this->_run_mod_handler('escape', true, $_tmp) : smarty_modifier_escape($_tmp)); ?>
</p>
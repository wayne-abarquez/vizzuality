<?php /* Smarty version 2.6.26, created on 2009-09-07 12:47:18
         compiled from rss.tpl */ ?>
<?php require_once(SMARTY_CORE_DIR . 'core.load_plugins.php');
smarty_core_load_plugins(array('plugins' => array(array('modifier', 'date_format', 'rss.tpl', 12, false),array('modifier', 'replace', 'rss.tpl', 17, false),)), $this); ?>
<?php echo '<?xml'; ?>
 version="1.0" encoding="UTF-8"<?php echo '?>'; ?>

<rss xmlns:georss="http://www.georss.org/georss" version="2.0">
<channel>
<title>Próximas carreras en runnity.com</title>
<copyright>Copyright retained by original author, refer to http://www.runnity.com/ for further information</copyright>
<webMaster>jatorre@runnity.com</webMaster>
<link>http://runnity.com/</link>
<description>Español</description>
<language>es-es</language>
<pubDate><?php echo ((is_array($_tmp=time())) ? $this->_run_mod_handler('date_format', true, $_tmp, '%Y-%m-%dT%H:%M:%SZ') : smarty_modifier_date_format($_tmp, '%Y-%m-%dT%H:%M:%SZ')); ?>
</pubDate>
<generator>Runnity.com http://runnity.com/</generator>
<?php $_from = $this->_tpl_vars['runs']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }if (count($_from)):
    foreach ($_from as $this->_tpl_vars['id'] => $this->_tpl_vars['run']):
?>
<item>
<title><?php echo $this->_tpl_vars['run']['name']; ?>
, <?php echo $this->_tpl_vars['run']['event_date']; ?>
, <?php echo $this->_tpl_vars['run']['event_location']; ?>
</title>
<link>http://runnity.com/run/<?php echo $this->_tpl_vars['run']['id']; ?>
/<?php echo ((is_array($_tmp=$this->_tpl_vars['run']['name'])) ? $this->_run_mod_handler('replace', true, $_tmp, ' ', '/') : smarty_modifier_replace($_tmp, ' ', '/')); ?>
</link>
<description><?php echo $this->_tpl_vars['run']['description']; ?>
</description>
<author>Runnity.com</author>
<category>Carreras</category>
<pubDate><?php echo $this->_tpl_vars['run']['created_when']; ?>
</pubDate>
<guid>http://runnity.com/carrera.php?id=<?php echo $this->_tpl_vars['run']['id']; ?>
</guid>
<georss:point><?php echo $this->_tpl_vars['run']['start_point_lat']; ?>
,<?php echo $this->_tpl_vars['run']['start_point_lon']; ?>
</georss:point>
<comments>http://runnity.com/carrera.php?id=<?php echo $this->_tpl_vars['run']['id']; ?>
#comments</comments>
</item>
<?php endforeach; endif; unset($_from); ?>
</channel>
</rss>
<?php /* Smarty version 2.6.26, created on 2009-09-28 18:36:16
         compiled from header.tpl */ ?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd" >
<html>
<head>
    <meta name="verify-v1" content="nBehsGXRSiH2qvWfAcnU4AZJzlOQbABqaiw7dzaXSeo=" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	
	<?php if ($this->_tpl_vars['meta_keywords']): ?>
		<meta name="keywords" content="<?php echo $this->_tpl_vars['meta_keywords']; ?>
">
	<?php else: ?>
		<meta name="keywords" content="running,popular,atletismo,correr,carrera,runner">	
	<?php endif; ?>

	<?php if ($this->_tpl_vars['meta_description']): ?>
		<meta name="description" content="<?php echo $this->_tpl_vars['meta_description']; ?>
">
	<?php else: ?>
		<meta name="description" content="Runnity es un punto de encuentro entre carreras y atletas.">	
	<?php endif; ?>
	<meta name="author" content="runnity.com">
	
	<title><?php echo $this->_tpl_vars['titulo_pagina']; ?>
</title>
	
	<link rel="shortcut icon" href="/img/favicon.ico"/>

	<link rel="stylesheet" href="/css/blueprint/screen.css" type="text/css" media="screen, projection">
	<link rel="stylesheet" href="/css/blueprint/print.css" type="text/css" media="print">
	<link rel="stylesheet" href="/css/menu.css" type="text/css">	
	<link rel="stylesheet" href="/css/datepicker.css" type="text/css">
	<link rel="stylesheet" href="/css/combobox.css" type="text/css">
	<link rel="stylesheet" href="/css/layout.css" type="text/css" media="screen, projection">
	
	<link rel="alternate" type="application/rss+xml" title="Próximas carreras en runnity.com RSS feed" href="http://feeds.feedburner.com/runnity" />

    <?php if ($this->_tpl_vars['section'] == 'usuario' || $this->_tpl_vars['section'] == 'carrera'): ?>
        <script type="text/javascript" src="/js/ajaxupload.3.6.js"></script>
	<?php endif; ?>
	
	<!-- Import JS source files -->
	
	<script type="text/javascript" src="/js/jquery.js"></script>
	
 	<script type="text/javascript" src="/js/jquery.combobox.js"></script>	
	<script type="text/javascript" src="/js/datepicker.js"></script>
    <script type="text/javascript" src="/js/eye.js"></script>
    <script type="text/javascript" src="/js/utils.js"></script>
    <script type="text/javascript" src="/js/layout.js?ver=1.0.2"></script>
	
	<script type='text/javascript' src='/js/init.js'></script>
	
	<!--[if IE 6]>
	<link rel="stylesheet" href="/css/layout_ie.css" type="text/css" media="screen, projection">
	<![endif]-->
	
	<script src="/cufon/cufon-yui.js" type="text/javascript"></script>
	<script src="/cufon/Arial_Rounded_MT_Bold_400.font.js" type="text/javascript"></script>
	<?php echo '
	<script type="text/javascript">
		Cufon.replace(\'.horizontalcssmenu\',{hover: true});
		Cufon.replace(\'.subTitle\');
		Cufon.replace(\'.subTitleInfo\');
		Cufon.replace(\'.titularTitle\');
		Cufon.replace(\'.raceTitle\');
		Cufon.replace(\'.buttonmenuContainer a\');
	</script>
	'; ?>

	
	<?php if ($this->_tpl_vars['section'] == 'index'): ?>
		<script type="text/javascript" src="/js/swfobject.js"></script>
		<?php echo '
		<script type="text/javascript">
			swfobject.registerObject("flashMovie", "9.0.115", "expressInstall.swf");
		</script>
		'; ?>

	<?php endif; ?>
	<?php if ($this->_tpl_vars['section'] == 'carrera'): ?>
		<script type="text/javascript" src="/js/swfobject.js"></script>
		<?php echo '
		<script type="text/javascript">
			swfobject.registerObject("flashMovie", "10.0.0", "expressInstall.swf");
		</script>
		'; ?>

	<?php endif; ?>	
	
    <?php if ($this->_tpl_vars['section'] == 'usuario'): ?>
        <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAtDJGVn6RztUmxjnX5hMzjRTy9E-TgLeuCHEEJunrcdV8Bjp5lBTu2Rw7F-koeV8TrxpLHZPXoYd2BA&amp;sensor=false" type="text/javascript"></script>	
	<?php endif; ?>
</head>

<body>

<div class="container">

	<!-- HEADER -->
	<div id="header" class="span-24 column header">
	
		<a href="/"><div class="span-5 first logo"></div></a>
		
		<div class="span-19 last access">
			<p>
				<a>accede a tu cuenta</a>
				 / 
				<a>regístrate</a>
			</p>
		</div>
		<div class="span-18 search">
			<form id="searchForm" class="span-14" action="/buscar" method="get">
				<label class="roundsearchFirst last" for="inputsearchFirst">
					<input type="text" id="inputsearchFirst" name="q">
				</label>
				<label class="searchButtonFirst last">
					<input type="submit" value="Buscar" class="buttonSearchFirst"/>
				</label>
			</form>
		</div>
	</div>
		
	<div class="span-24 subHeader">
		<div class="span-11 first subInfo">
		<?php if ($this->_tpl_vars['section'] == 'home'): ?> 
			<p class="subTitle">Carreras, fotos, comentarios...</p>
			<p class="subTitleInfo">Todo sobre mas de <a href="#">140 carreras</a> en toda España</p>				
		<?php endif; ?>
		<?php if ($this->_tpl_vars['section'] == 'carrera'): ?> 
			<div class="buttonmenuContainer">
				<a href="#"><div class="menu_button"><p>Publica tu carrera en runnity</p></div></a>
			</div>			
		<?php endif; ?>
		<?php if ($this->_tpl_vars['section'] == 'searchresults'): ?> 
			<div class="buttonmenuContainer">
				<a href="#"><div class="menu_button"><p>Publica tu carrera en runnity</p></div></a>
			</div>			
		<?php endif; ?>
		<?php if ($this->_tpl_vars['section'] == 'usuario'): ?> 
			<div class="buttonmenuContainer">
				<a href="#"><div class="menu_button"><p>Invita a tus amigos a runnity</p></div></a>
			</div>			
		<?php endif; ?>
		</div>
		
		<div class="menu">
			<div class="span-13 last horizontalcssmenu">
			<ul id="cssmenu1">
				<li><div><a <?php if ($this->_tpl_vars['section'] == 'blog'): ?> class="current"<?php endif; ?> href="/blog">BLOG</a></div></li>			
				<li><div class="border"><a <?php if ($this->_tpl_vars['section'] == 'carrera'): ?> class="current"<?php endif; ?> href="/buscar">CARRERAS</a></div></li>
				<li><div class="border"><a <?php if ($this->_tpl_vars['section'] == 'home'): ?> class="current"<?php endif; ?> href="/">HOME</a></div></li>				
			</ul>
			</div>
		</div>
	</div>
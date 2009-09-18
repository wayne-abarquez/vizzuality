<?php /* Smarty version 2.6.26, created on 2009-09-17 15:03:17
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
	<link rel="stylesheet" type="text/css" href="/css/menu.css">	
<!-- 	<link rel="stylesheet" type="text/css" href="/css/floating.css">	 -->
<!-- 	<link rel="stylesheet" type="text/css" href="/css/contact.css">	 -->
	<link rel="stylesheet" href="/css/layout.css" type="text/css" media="screen, projection">
<!-- 	<link rel="stylesheet" href="/css/scrollable.css" type="text/css" media="screen, projection"> -->
<!-- 	<link rel="alternate" type="application/rss+xml" title="Próximas carreras en runnity.com RSS feed" href="http://feeds.feedburner.com/runnity" /> -->


    <?php if ($this->_tpl_vars['section'] == 'usuario' || $this->_tpl_vars['section'] == 'carrera'): ?>
        <script type="text/javascript" src="/js/ajaxupload.3.6.js"></script>
	<?php endif; ?>

	
	<!-- Import JS source files -->
	<script src='/js/jquery-1.3.2.min.js' type='text/javascript'></script>
	<script src='/js/jquery.simplemodal.js' type='text/javascript'></script>
	<script src='/js/autoresize.jquery.min.js' type='text/javascript'></script>	
	<script src='/js/jquery.tools.min.js' type='text/javascript'></script>	
	
	<!-- Contact Form JS and CSS files -->
	<script src='/js/init.js' type='text/javascript'></script>
	<link type='text/css' href='/css/login.css' rel='stylesheet' media='screen'>
	<link type='text/css' href='/css/register.css' rel='stylesheet' media='screen'>
	

	<link type='text/css' href='/css/botones.css' rel='stylesheet' media='screen'>
	<script src="/js/corner.js" type="text/javascript"></script>
	
	<!--[if IE 6]>
	<link rel="stylesheet" href="/css/layout_ie.css" type="text/css" media="screen, projection">
	<![endif]-->
	
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
	<div class="span-24 column header">
	
		<a href="/"><div class="span-5 first logo"></div></a>
		
		<div class="span-19 last access"><p><a href="#">accede a tu cuenta</a> / <a href="#">regístrate</a></p></div>
		<div class="span-19 last search">
		
		<div class="searchCont">
			<div class="searchC">
				<form id="searchForm" action="/buscar" method="get">
					<div class="buttonSearch">
						<label class="roundsearchFirst" for="inputsearchFirst">
							<span><input type="text" id="inputsearchFirst" name="q"></span>
						</label>
					</div>
					<div class="buttonSearch"><input class="fg-button" type="submit" value="Buscar"/></div>
				</form>
				</div>
			</div>
		</div>
	</div>
		
	<div class="span-24 subHeader">
		<div class="span-11 first subInfo">
			<p class="subTitle">Carreras, fotos, comentarios...</p>
			<p class="subTitleInfo">Todo sobre mas de <a href="#">140 carreras</a> en toda españa</p>
		</div>
		<div class="menu">
			<div class="span-13 last horizontalcssmenu">
			<ul id="cssmenu1">
				<li><a <?php if ($this->_tpl_vars['section'] == 'home'): ?> class="current"<?php endif; ?> href="/">HOME</a> <a class="separator">|</a></li>
				<li><a <?php if ($this->_tpl_vars['section'] == 'carrera'): ?> class="current"<?php endif; ?> href="/buscar">CARRERAS</a> <a class="separator">|</a></li>
				<li><a <?php if ($this->_tpl_vars['section'] == 'blog'): ?> class="current"<?php endif; ?> href="/blog">BLOG</a> <a class="separator"></a></li>
			</ul>
			</div>
		</div>
	</div>
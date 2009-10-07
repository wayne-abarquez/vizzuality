<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd" >
<html>
<head>
    <meta name="verify-v1" content="nBehsGXRSiH2qvWfAcnU4AZJzlOQbABqaiw7dzaXSeo=" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	
	{if $meta_keywords}
		<meta name="keywords" content="{$meta_keywords}">
	{else}
		<meta name="keywords" content="running,popular,atletismo,correr,carrera,runner">	
	{/if}

	{if $meta_description}
		<meta name="description" content="{$meta_description}">
	{else}
		<meta name="description" content="Runnity es un punto de encuentro entre carreras y atletas.">	
	{/if}
	<meta name="author" content="runnity.com">
	
	<title>{$titulo_pagina}</title>
	
	<link rel="shortcut icon" href="/img/favicon.ico"/>

	<link rel="stylesheet" href="/css/blueprint/screen.css" type="text/css" media="screen, projection">
	<link rel="stylesheet" href="/css/blueprint/print.css" type="text/css" media="print">
	<link rel="stylesheet" href="/css/menu.css" type="text/css">	
	<link rel="stylesheet" href="/css/datepicker.css" type="text/css">
	<link rel="stylesheet" href="/css/layout.css" type="text/css" media="screen, projection">
	
	<link rel="alternate" type="application/rss+xml" title="Próximas carreras en runnity.com RSS feed" href="http://feeds.feedburner.com/runnity" />

    {if $section eq "usuario" or $section eq "carrera"}
        <script type="text/javascript" src="/js/ajaxupload.3.6.js"></script>
	{/if}
	
	<!-- Import JS source files -->
	
	<script type="text/javascript" src="/js/jquery.js"></script>
		
	<script type="text/javascript" src="/js/datepicker.js"></script>
    <script type="text/javascript" src="/js/eye.js"></script>
    <script type="text/javascript" src="/js/utils.js"></script>
    <script type="text/javascript" src="/js/layout.js?ver=1.0.2"></script>
    <script src="/js/jquery.simplemodal-1.3.js" type="text/javascript"></script>
    <script src="/js/basic.js" type="text/javascript"></script>
	
	<script type='text/javascript' src='/js/init.js'></script>
	
	<!--[if IE 6]>
	<link rel="stylesheet" href="/css/layout_ie.css" type="text/css" media="screen, projection">
	<![endif]-->
	
	<script src="/cufon/cufon-yui.js" type="text/javascript"></script>
	<script src="/cufon/Arial_Rounded_MT_Bold_400.font.js" type="text/javascript"></script>

	
	{if $section eq "index"}
		<script type="text/javascript" src="/js/swfobject.js"></script>
		{literal}
		<script type="text/javascript">
			swfobject.registerObject("flashMovie", "9.0.115", "expressInstall.swf");
		</script>
		{/literal}
	{/if}
	{if $section eq "carrera"}
		<script type="text/javascript" src="/js/swfobject.js"></script>
		{literal}
		<script type="text/javascript">
			swfobject.registerObject("flashMovie", "10.0.0", "expressInstall.swf");
		</script>
		{/literal}
	{/if}	
	
    {if $section eq "usuario"}
        <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAtDJGVn6RztUmxjnX5hMzjRTy9E-TgLeuCHEEJunrcdV8Bjp5lBTu2Rw7F-koeV8TrxpLHZPXoYd2BA&amp;sensor=false" type="text/javascript"></script>	
	{/if}
	
</head>

<body>

<div class="container">

	<!-- LOGIN -->
	<div id="login_modal">
		<div id="loginForm" class="span-1 first loginForm">
			<p class="title">Accede a tu cuenta</p>
			<form id="FormularioLogin" method="GET" action="javascript: void login()">
				<div>
					<p>e-mail / nombre de usuario</p>
					<div class="span-1 inputContainer">
						<label class="inputLogin" for="login1">
							<input type="text" name="login1" id="emailLogin" class="inputLogin">
						</label>
					</div>
				</div>
				<div style="margin-top: 30px;">
					<p>contraseña</p>			
					<div class="span-1 inputContainer">
						<label class="inputLogin" for="login2">
							<input type="password" name="login2" id="passwordLogin" class="inputLogin">
						</label>
					</div>
				</div>
				<div class="forgetFind">
					<div class="forgetPass"><a id="forgetLink" href="javascript: void sendPassword()">¿olvidaste tu contraseña?</a></div>
					<div class="loginButton"><input id="submitLogin" class="fg-button" type="submit" value="Entrar"/></div>	
				</div>	
				<div class="first">
					<img id="checking" class="column first registerImage" src="/img/ajax-loader.gif" style="display:none">
					<div class="column last errorMessage" id="error_msg"></div>
				</div>
			</form>
		</div>
		
		<div class="span-1 last separatorLogin"></div>
	</div>

	<!-- HEADER -->
	<div id="header" class="span-24 column header">
		<a href="/"><div class="span-5 first logo"></div></a>
		<div class="span-19 last access">
			<p>
				{if $smarty.session.logged}
				<a href="/perfil/{$smarty.session.user.username}">bienvenido {$smarty.session.user.username}</a>
				/ 
				<a onclick="logout()">salir</a>
				{else}
				<a href="javascript: void showLoginWindow()">accede a tu cuenta</a>
				/ 
				<a href="/registro.php">registrarse</a>
				{/if}
			</p>
		</div>
		<div class="span-18 search">
			<form id="searchForm" class="span-14" action="/buscar" method="get">
				<label class="roundsearchFirst last" for="inputsearchFirst">
					<input type="text" id="inputsearchFirst" value="Busca carreras" class="default" name="q">
				</label>
				<label class="searchButtonFirst last">
					<input type="submit" value="Buscar" class="buttonSearchFirst"/>
				</label>
			</form>
		</div>
	</div>
		
	<div class="span-24 subHeader">
		<div class="span-11 first subInfo">
		{if $section eq "home"} 
			<p class="subTitle">Carreras, fotos, comentarios...</p>
			<p class="subTitleInfo">Todo sobre mas de <a href="#">140 carreras</a> en toda España</p>				
		{/if}
		{if $section eq "carrera"} 
			<div class="buttonmenuContainer">
				<a href="#"><div class="menu_button"><p>Publica tu carrera en runnity</p></div></a>
			</div>			
		{/if}
		{if $section eq "searchresults"} 
			<div class="buttonmenuContainer">
				<a href="#"><div class="menu_button"><p>Publica tu carrera en runnity</p></div></a>
			</div>			
		{/if}
		{if $section eq "usuario" or $section eq "registro" or $section eq "404"} 
			<div class="buttonmenuContainer">
				<a href="#"><div class="menu_button"><p>Invita a tus amigos a runnity</p></div></a>
			</div>			
		{/if}
		</div>
		
		<div class="menu">
			<div class="span-13 last horizontalcssmenu">
			<ul id="cssmenu1">
				<li><div><a {if $section eq "blog"} class="current"{/if} href="/blog">BLOG</a></div></li>			
				<li><div class="border"><a {if $section eq "carrera"} class="current"{/if} href="/buscar">CARRERAS</a></div></li>
				<li><div class="border"><a {if $section eq "home"} class="current"{/if} href="/">HOME</a></div></li>				
			</ul>
			</div>
		</div>
	</div>
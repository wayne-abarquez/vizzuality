<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd" >
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	
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
	
	<link rel="shortcut icon" href="/img/favicon.ico">
    
    <link rel="stylesheet" href="/css/site_{$smarty.const.CSS_VERSION}.css" type="text/css">
	
	<link rel="alternate" type="application/rss+xml" title="Próximas carreras en runnity.com RSS feed" href="http://feeds.feedburner.com/runnity">
	
	<!-- Import JS source files -->
    <!-- script type="text/javascript" src="/js/site_{$smarty.const.JS_VERSION}.js"></script -->
	<script type="text/javascript" src="http://runnity.com.s3-external-3.amazonaws.com/js/1256935337.js"></script>	
	<script type="text/javascript" src="http://runnity.com.s3-external-3.amazonaws.com/js/cufon-yui.js"></script>	
	<script type="text/javascript" src="http://runnity.com.s3-external-3.amazonaws.com/js/Arial_Rounded_MT_Bold_400.font.js"></script>	
	<script type="text/javascript" src="/js/init.js"></script>	
	
	{if $section eq "index"}
		{literal}
		<script type="text/javascript">
			swfobject.registerObject("flashMovie", "9.0.115", "expressInstall.swf");
		</script>
		{/literal}
	{/if}
	{if $section eq "carrera"}
		{literal}
		<script type="text/javascript">
			swfobject.registerObject("flashMovie", "10.0.0", "expressInstall.swf");
		</script>
		{/literal}
	{/if}	
	
    {if $section eq "usuario"}
        <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key={$smarty.const.GMAPS_KEY}&amp;sensor=false" type="text/javascript"></script>	
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
						<label class="inputLogin">
							<input type="text" name="login1" id="emailLogin" class="inputLogin">
						</label>
					</div>
				</div>
				<div id="passForm" style="margin-top: 30px;">
					<p>contraseña</p>			
					<div class="span-1 inputContainer">
						<label class="inputLogin">
							<input type="password" name="login2" id="passwordLogin" class="inputLogin">
						</label>
					</div>
				</div>
				<div class="forgetFind">
					<div class="forgetPass"><a id="forgetLink" href="javascript: void sendPassword()">¿olvidaste tu contraseña?</a></div>
					<div class="loginButton"><input id="submitLogin" class="buttonLogin" type="submit" value="Entrar"></div>	
				</div>	
				<div class="first">
					<div class="column last errorMessage" id="error_msg"></div>
				</div>
			</form>
		</div>
		
		<div class="span-1 separatorLogin"></div>
		
		<div class="span-1 last register_text">
			<h3>¿No estás registrado?</h3>
			<div><p>¡Regístrate ahora y disfruta de todas las ventajas de Runnity! Es grátis y tardarás un par de minutos.</p></div>
			<div class="registerLoginButton"><input class="buttonRegisterLogin" value="Crea tu cuenta" type="button" onclick="location.href = '/registro'"></div>
		</div>
	</div>
	
	<!-- CONTACT -->
	<div id="contact_modal">
		<div class="contact_container" id="contact_container">
			<h2 id="contactTitle">Sugerencias, dudas... escríbenos!</h2>
			<form id="contactForm" method="GET" action="javascript: void sendMessage()">
				<div>
					<label>nombre</label>
					<div class="span-12 inputContainer">
						<label class="inputLogin">
							<input type="text" class="inputLogin" id="contact1">
						</label>
					</div>
				</div>
				<div>
					<label>e-mail</label>
					<div class="span-12 inputContainer">
						<label class="inputLogin" >
							<input type="text" class="inputLogin" id="contact2">
						</label>
					</div>
				</div>
				<div>
					<label>mensaje</label>
					<div class="span-12 inputContainer">
						<textarea id="contact3" rows="0" cols="0"></textarea>
					</div>
				</div>
				<div><span id="contactError" class="errorMessage"></span></div>
				<div class="contactButtonContainer"><input id="contactSubmit" class="buttonLogin" value="Enviar" type="submit"></div>
			</form>
		</div>
	</div>
	
	
	<!-- PUBLISH RUN -->
	<div id="publish_modal">
		<div class="publish_container">
			<h2>Publica tu carrera</h2>
			<form id="publishForm" method="GET" action="javascript: void publishRun()">
				<div class="name">
					<label>Nombre de la carrera</label>
					<input type="text" class="text" id="publishName" name="publishName">
				</div>
				<div class="date">
					<label>Fecha</label>
					<input type="text" class="text" id="publishDate" name="publishDate">
				</div>
				<div class="data">
					<label>Info de la carrera</label>
					<textarea id="publishData" name="publishData" rows="0" cols="0"></textarea>
				</div>
				<div class="mail">
					<label>e-mail de contacto</label>
					<input type="text" class="text" id="publishEmail" name="publishEmail">
				</div>
				<div><span id="contactError2" class="errorMessage"></span></div>
				<div class="bottom">
					<p>Una vez mandada la información, nuestro equipo contactará contigo para completarla.</p>
					<div class="contactButtonContainerRun"><input id="contactPublish" class="buttonLogin" value="Enviar" type="submit"></div>
				</div>
			</form>
		</div>
	</div>

	<!-- HEADER -->
	<div id="header" class="span-24 column header">
		<a href="/"><div class="span-5 first logo"></div></a>
		<div class="span-19 last access">
			<p>
				{if $smarty.session.logged}
				<a href="/perfil/{$smarty.session.user.username}">bienvenido {$smarty.session.user.username}</a>
				/ 
				<a onclick="logout()">cerrar sesión</a>
				{else}
				<a href="javascript: void showLoginWindow()">accede a tu cuenta</a>
				/ 
				<a href="/registro">registrarse</a>
				{/if}
			</p>
		</div>
		<div class="span-18 search">
			<form id="searchForm" class="span-14" action="/buscar" method="get">
				<div><label class="roundsearchFirst last" for="inputsearchFirst">
					<input type="text" id="inputsearchFirst" value="Busca carreras" class="default" name="q">
				</label></div>
				<div><label class="searchButtonFirst last">
					<input type="submit" value="Buscar" class="buttonSearchFirst">
				</label></div>
			</form>
		</div>
	</div>
		
	<div class="span-24 subHeader">
		<div class="span-10 first subInfo">
		{if $section eq "home"} 
			<p class="subTitle">Carreras, fotos, comentarios...</p>
			<p class="subTitleInfo">Todo sobre más de <a href="/buscar">140 carreras</a> en toda España</p>				
		{/if}
		{if $section eq "carrera" or $section eq "usuario" or $section eq "registro" or $section eq "imagen" or $section eq "404"} 
			<div class="buttonmenuContainer">
				<a href="javascript: void show_publish()"><div class="menu_button"><p>Publica tu carrera en Runnity</p></div></a>
			</div>			
		{/if}
		{if $section eq "searchresults" or $section eq "search_user"} 
			<div class="buttonmenuContainer">
				<a href="javascript: void show_publish()"><div class="menu_button"><p>Publica tu carrera en Runnity</p></div></a>
			</div>			
		{/if}
		</div>
		
		<div class="menu">
			<div class="span-14 last horizontalcssmenu">
			<ul id="cssmenu1">
				<li><div><a {if $section eq "blog"} class="current"{/if} href="/blog">BLOG</a></div></li>
				{if $smarty.session.logged}
				<li><div class="border"><a {if $section eq "usuario"} class="current"{/if} href="/perfil/{$smarty.session.user.username}">TU PERFIL</a></div></li>
				{/if}
				<li><div class="border"><a {if $section eq "search_user" or $section eq "search_user"} class="current"{/if} href="/">USUARIOS</a></div></li>
				<li><div class="border"><a {if $section eq "carrera" or $section eq "searchresults"} class="current"{/if} href="/buscar">CARRERAS</a></div></li>
				<li><div class="border"><a {if $section eq "home"} class="current"{/if} href="/">HOME</a></div></li>				
			</ul>
			</div>
		</div>
	</div>
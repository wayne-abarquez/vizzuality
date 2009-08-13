<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd" >
<html>

<html lang="es">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<title>Runnit</title>
	<style type="text/css"></style>

	<link rel="stylesheet" href="css/blueprint/screen.css" type="text/css" media="screen, projection">
	<link rel="stylesheet" href="css/blueprint/print.css" type="text/css" media="print">
	<link rel="stylesheet" type="text/css" href="css/menu.css">	
	<link rel="stylesheet" type="text/css" href="css/floating.css">	
	<link rel="stylesheet" href="css/layout.css" type="text/css" media="screen, projection">
	
	<!-- Import jQuery and SimpleModal source files -->
	<script src='http://code.jquery.com/jquery-latest.pack.js' type='text/javascript'></script>
	<script src='js/jquery.simplemodal.js' type='text/javascript'></script>
	
	<!-- Contact Form JS and CSS files -->
	<script src='js/init.js' type='text/javascript'></script>
	<link type='text/css' href='css/login.css' rel='stylesheet' media='screen'>
	<link type='text/css' href='css/register.css' rel='stylesheet' media='screen'>
	
	<!-- Buttons -->
	<script src='js/btn.js' type='text/javascript'></script>
	<link type='text/css' href='css/botones.css' rel='stylesheet' media='screen'>
	
	<script src="js/corner.js" type="text/javascript"></script>
	
	{literal}
	<script type="text/javascript">	
		/* input_id is the ID of the input element */
		/* container_class will let you control the text input background color and padding */
		/* border_class will let you control the border color */
		function roundInput(input_id, container_class, border_class){
			var input = $('#'+input_id+'');
			var input_width = input.css("width"); //get the width of input
			var wrap_width = parseInt(input_width) + 10; //add 10 for padding
			wrapper = input.wrap("<div class='"+container_class+"'></div>").parent();
			wrapper.wrap("<div class='"+border_class+"' style='width: "+wrap_width+"px;'></div>"); //apply border
			wrapper.corner("round 8px").parent().css('padding', '2px').corner("round 10px"); //round box and border
		}
		
		$(function(){
			roundInput('rounded_input1','rounded_container','rounded_border');
			roundInput('rounded_input2','rounded_container','rounded_border');
		});
	</script>
	{/literal}

</head>

<body>

<div class="container">

	<!-- LOGIN WINDOW -->
	<div id="loginWindow" style='display:none'>
		<div class="column span-5 first loginColumn">
			<h2 class="loginTitle">Accede a tu cuenta</h2>
			<div>
				<div class="inputTitle">e-mail</div>
				<input class="textInput" type="text">
			</div>
			<div>
				<div class="inputTitle">contraseña</div>
				<input class="textInput" type="text">
			</div>
			<div class="forgetFind">
				<div class="column first forgetPass">¿olvidaste tu contraseña?</div>
				<input type="Button" value="Entrar" class="btn btnblue" />			
			</div>	
		</div>
		
		<div class="column span-1 separator">
			<img src="/img/separator.jpg" alt="separator">
		</div>
		
		<div class="column span-5 last">
			<h3 class="registro">¿Aún no estas registrado?</h3>
			<div class="registerText">Regístrate ahora y disfruta de todas las ventajas de runnit! Es grátis y tardarás un par de minutos.</div>
			<input type="Button" value="Mira la carrera destacada" class="btn btnblue" />
		</div>
	</div>
	
	<!-- REGISTER -->
	<div id="registerWindow" style='display:none'>
		<div class="registerWindow">
			<div class="registerLeft">
				<h2 class="registerTitle">Crea tu cuenta en runnit!</h2>
				<div class="inputBox">
					<div class="inputTitle">nombre y apellidos</div>
					<div>
						<input class="textInputRegister" type="text">
					</div>
				</div>
				<div class="inputBox">
					<div class="inputTitle">nombre de usuario</div>
					<div>
						<input class="textInputRegister" type="text">
					</div>
				</div>
				<div class="inputBox">
					<div class="inputTitle">contraseña</div>
					<div>
						<input class="textInputRegister" type="text">
					</div>
				</div>
				<div class="inputBox">
					<div class="inputTitle">email</div>
					<div>
						<input class="textInputRegister" type="text">
					</div>
				</div>
				<input type="Button" value="Crear mi cuenta" class="btn btnblue" />
			</div>
			<div class="registerRight"></div>
			<div class="conditions">
				Hacer click en “Crear mi cuenta” implica haber aceptado los términos y condiciones del servicio.	
			</div>
		</div>
	</div>
	
	
	<!-- HEADER -->
	<div class="span-24 header">
		<div class="span-6 loginImage">
			<div class="loginText" id="loginBox">
				<a href="javascript: void showLoginBox()" class="hrefText">accede a tu cuenta</a>
				<a class="normalText"> ó </a>
				<a href="javascript: void showRegisterBox()" class="hrefText">registrate</a>
			</div>
		</div>
 
 		<a href="index.php"><div class="span-6 first headerImage"></div></a>
		<div class="span-18 last">
			<div class="searchCont">
				<div class="searchC">
					<form id="searchForm" method="GET">
						<div class="inputSearch"><input class="input_Search" type="text" /></div>
						<div class="buttonSearch"><input id="search" class="button_Search" type="submit" value="Buscar" /></div>
					</form>
				</div>
			</div>
			<div class="span-18 last horizontalcssmenu">
				<ul id="cssmenu1">
					<li><a href="index.php">HOME</a> <a class="separator">|</a> </li>
					<li><a href="calendario.php">CALENDARIO</a> <a class="separator">|</a> </li>
					<li><a href="about.php">SOBRE NOSOTROS</a> <a class="separator">|</a> </li>
					<li><a href="#">BLOG</a> <a class="separator">|</a> </li>
					<li><a href="contacto.php">CONTACTO</a> </li>
				</ul>
			</div>
		</div>
	</div>
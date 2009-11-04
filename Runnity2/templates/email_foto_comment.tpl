<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8">
	<title>Aviso</title>
	{literal}
    	<style type="text/css">
    <!--
    body {
    	font-family: Verdana, Arial, Helvetica, sans-serif;
    	font-size: 10px;
    	color: #333333;
    }

    h1{
    	margin-left: 20px;
    	margin-top: 20px;
    	font-family: "Arial";
    	font-size: 19px;
    	font-weight: bold;
    	color: #336699;
    }

    .title{
    	margin-left: 20px;
    	margin-top: 30px;
    	margin-bottom: 30px;
    	font-family: "Arial";
    	font-size: 14px;
    	color: #666666;
    }

    .contacta{
    	margin-top: 30px;
    	margin-bottom: 30px;
    	font-family: "Arial";
    }

    p{
    	margin-left: 20px;
    	font-family: "Arial";
    	font-size: 12px;
    	color: #666666;
    	line-height: 20px;
    }

    a{
    	color: #336699;
    	font-weight: bold;
    }

    -->
    	</style>
	{/literal}
</head>
<body>

<h1>Tienes un mensaje nuevo en una foto que has comentado {$username}</h1>

<p>{$user_from} ha dejado un mensaje nuevo en una foto que has comentado: "{$comment}" <a href="http://www.runnity.com/picture/{$idFoto}/{$table}">http://www.runnity.com/picture/{$idFoto}/{$table}</a></p> 

<p>Para contestar a {$user_from} entra en su perfil <a href="http://www.runnity.com/user/{$user_from}">http://www.runnity.com/user/{$user_from}</a></p>

<p class="contacta">Si tienes alguna duda o sugerencia, <a href="mailto:contacto@runnity.com">contacta con nosotros</a></p>

<p class="title">¡Suerte en tus próximas carreras!</p>


</body>
</html>
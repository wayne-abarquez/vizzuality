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
    	margin-top: 50px;
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

<h1>{$user_from} te ha dejado un mensaje nuevo</h1>

<p>"{$comment}"</p> 

<p>Para contestar a {$user_from} entra en su perfil <a href="http://www.runnity.com/user/{$user_from}"> http://www.runnity.com/user/{$user_from}</a></p>

<p>Para ver todos tus mensajes entra en tu cuenta de Runnity <a href="http://www.runnity.com/perfil/{$username}"> http://www.runnity.com/perfil/{$username}</a></p>

<p class="contacta">Si tienes alguna duda o sugerencia, <a href="mailto:contacto@runnity.com">contacta con nosotros</a></p>

<p class="title">¡Suerte en tus próximas carreras!</p>


</body>
</html>
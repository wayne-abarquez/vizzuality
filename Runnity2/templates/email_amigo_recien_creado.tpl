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

<h1>Hola {$followingFriendName}!,</h1>

<p>{$followerName} te esta siguiendo en Runnity!</p> 

<p>Para seguir tu a {$followerName} entra en su perfil <a href="http://www.runnity.com/user/{$followerName}">http://www.runnity.com/user/{$followerName}</a></p>

<p>Para cambiar tu perfil <a href="http://www.runnity.com/perfil/{$followingFriendName}">http://www.runnity.com/perfil/{$followingFriendName}</a></p>



<p class="contacta">Si tienes alguna duda o sugerencia, <a href="mailto:contacto@runnity.com">contacta con nosotros</a></p>

<p class="title">¡Suerte en tus próximas carreras!</p>

</body>
</html>
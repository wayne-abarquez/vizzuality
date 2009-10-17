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
	line-height: 0px;
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

<h1>Hola {$name}!</h1>

<p class="title">Aquí tienes un listado de con las próximas carreras que tendrán lugar en las próximas semanas cerca de donde vives. Por defecto te mandamos las carreras a menos de 200Km de tu localidad, si quieres puedes cambiar esta distancia en tus <a href="http://www.runnity.com/perfil/{$user_name}">preferencias de usuario</a></b></p>

<p> Listado de carreras del ({$timeRange})</p>

{foreach key=id item=race from=$carreras}
<p class="titulo_1"><a href="http://www.runnity.com/run/{$race.run_id}/{$race.run_name}">{$race.run_name}</a></p>
<p class="titulo_2">{$race.day_in_week}, {$race.event_date|substr:8:2}/{$race.event_date|substr:5:2}/{$race.event_date|substr:2:2} - {$race.event_date|substr:11:5} hrs - {$race.distance_text}</p>  
<p class="titulo_3">{$race.event_location}, {$race.province_name}</p>
{/foreach}

<p>Esperamos que corras alguna, y que se te dé lo mejor posible! Recuerda que podrás subir tus fotos / comentarios del evento en la página de la carrera.

<p class="contacta">Si tienes alguna duda o sugerencia, no dudes en <a href="mailo:contacto@runnity.com">contactar con nosotros</a></p>

<p>Te esperamos en <a href="http://www.runnity.com">runnity.com</a></p>

<p>Si en algún momento quieres dejar de recibir este mensaje, puedes desactivarlo en tu <a href="http://www.runnity.com/perfil/{$user_name}">página de usuario</a></p>

</body>
</html>
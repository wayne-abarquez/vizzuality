{include file="header.tpl"} 

<!-- GLOBAL CONTAINER RACE -->
	<div class="span-1 titleBoxRegister" style="text-align: center">
		<p>Registro completado, bienvenido {$smarty.session.user.username}!</p>
	</div>

	<div class="span-24 column content">
		<div class="register_success_content">
			<p class="first">Tu cuenta en Runnity ha sido creada con éxito.</p>
			<p class="second">Recibiras un mail con los datos de tu cuenta en tu buzón de correo.</p>
			<p class="third">(No olvides revisar la carpeta de correo no deseado)</p>
			<p class="fourth">Ahora te sugerimos que <a href="/perfil/{$smarty.session.user.username}">completes tu perfíl de usuario</a> o <a href="/buscar">busques tus próximas carreras</a></p>
			<p class="fiveth">Nos vemos! ;P</p>
		</div>
	</div>
</div>
{include file="footer.tpl"} 
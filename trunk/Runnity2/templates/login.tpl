{include file="header.tpl"} 

<!-- GLOBAL CONTAINER RACE -->
	<div class="span-1 titleBoxRegister" style="text-align: center">
		<p>Hey!, tienes que hacer login para acceder a esta página</p>
	</div>

	<div class="span-24 column content">
		<div class="content404">
			<form action="login.php" method="POST">
				<div class="span-1 loginContainer">
					<div class="loginContainerData">
						<div class="span-1 loginSpaceFirst">
						<p>Nombre de usuario / email</p>
						<label class="roundInputName last" for="roundInputName">
							<input type="text" name="username" id="roundInputName">
						</label>
						<p>Contraseña</p>
						<label class="roundInputName last" for="roundInputName">
							<input type="text" name="password" id="roundInputName">
						</label>
						<input type="hidden" name="url" value="{$url}" />
						<input class="fg-button buttonLoginPage" type="submit" name="action" value="Entrar" />
						</div>
						<div class="span-1 loginSpace">
						<p class="loginRegisterLink">¿Aún no estás registrado?</p>
						<a class="loginRegisterLink" href="/registro">Regístrate aquí</a>
						</div>

					</div>
				</div>
			</form>
		</div>
	</div>
</div>

{include file="footer.tpl"} 
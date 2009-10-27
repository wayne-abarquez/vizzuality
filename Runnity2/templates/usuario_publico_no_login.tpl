{include file="header.tpl"} 

	<div class="span-1 titleBoxRegister" style="text-align: center">
		<p>Hey!, tienes que hacer login para acceder al perfil de este usuario</p>
	</div>

	<div class="span-24 column content">
		<div class="content404">
			<div class="span-1 noUser">
				<div class="containerNoUser">
					<div class="span-6 first">
						<div class="span-1 avatarPerfil" id="avatarPerfil">
							<img class="imgAvatarPerfil" id="userImg" src="/avatar.php?id={$data.datos.id}&type=t">
						</div>
					</div>
					<div class="span-1 last NoUserInfo">
						<p class="nameUserProfile">{$data.datos.completename}<span class="nameUserProfileNick">, ({$data.datos.username})</span></p>
						<p>Para poder ver mas sobre Andrés David, dejarle un mensaje o ver sus fotos y próximas carreras, tienes que estar registrado en runnity.</p>
						<p>Si ya lo estás, <a href="#">haz login</a>, si no, <a href="#">registrate aquí.</a></p>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

{include file="footer.tpl"}

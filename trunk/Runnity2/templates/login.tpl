{include file="header.tpl"} 

<!-- GLOBAL CONTAINER RACE -->
	<div class="span-1 titleBoxRegister" style="text-align: center">
		<p>Ooops! Debes hacer login para continuar...</p>
	</div>

	<div class="span-24 column content">
		<div class="content404">
			<form action="login.php" method="POST">
				User:<input type="text" name="username" />
				Pass:<input type="text" name="password" />
				<input type="hidden" name="url" value="{$url}" />
				<input type="submit" name="action" value="Submit" />
			</form>
		</div>
	</div>
</div>

{include file="footer.tpl"} 
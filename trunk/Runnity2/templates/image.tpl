{include file="header.tpl"}


<div class="span-24 column content">

	<div class="span-1 last leftColumn">
		
		<div class="span-1 columnNameUser">
			<p class="nameUserProfile">Fotos subidas por {$pictures[1].user_name}</p>
		</div>
		<a class="dashboardLink" href="#">volver a su perfil <img src="/img/arrowDash.gif"></a>
		<div class="globalContainerUser">	
			<div class="span-1 last imgData">
				<div class="span-1 last upPaginator imagePaginator">
					<p>1 de 57</b>
					<span><a href="#"><input class="fg-button buttonLeftArrow" type="button"/></a></span>
					<span><a href="#"><input class="fg-button buttonRightArrow" type="button"/></a></span>
					</p>	
				</div>	
				<div class="span-1 containerImg ">
					<!--TODO: AL HACER CLick EN LA FOTO HAY QUE PASAR A LA SIGUIENTE-->
					<img class="targetImg" id="userImg" src="{$targetPicture}">
					<p>ver más fotos de <a href="/run/{$data.id}/{$data.name|replace:' ':'/'}">{$data.name}</a></p>
				</div>
			</div>
		</div>
	
		<div class="span-1 last columnLong">
			<p class="titulo tituloLeft tituloRight">COMENTARIOS {if !empty($comments)}[{$comments|@count}]{/if}
			<a class="publica" onclick="document.getElementById('commentTextArea').focus();">publicar un comentario</a>
			</p>
			<ol id="update">
			{foreach key=id item=comment from=$comments}
			{if $comment}										
				<div id="comment" class="span-1 last">
					<div class="span-1 last avatarBox">
						<img src="/avatar.php?id={$comment.user_id}&type=s"/>	
					</div>
					<div class="span-1 commentBox">
					<div class="nameUser"><a class="name" href="/user/{$comment.username}">{$comment.username}, </a>hace {$comment.created_when|timeAgo}</div>
					<p class="commentUser">{$comment.commenttext}</p>
					</div>
				</div>							
				{/if}
			{/foreach}	
		</ol>						
		</div>
		
		<!-- PARA AÑADIR COMENTARIOS -->
		<div class="span-8" id="flash" align="left"></div>
		<div class="span-1 last boxraceMap">
			<div class="commentArea" id="commentBox">	
			{if $smarty.session.logged}				
				<div class="titleComents">Anímate y publica tu comentario</div>
				<textarea name="textarea2" id="commentTextArea" class="textArea"></textarea>
				<!-- CUIDADO!!! QUE HE COPIPASTEADO DE LA DE CARRERA! -->				
				<input class="fg-button buttonComment" type="submit" value="Publicar comentario" onclick="javascript: void commentAction('picture',{$smarty.request.id},'run',$('#commentTextArea').val())"/>
			{else}
			<div class="span-1 iconPhrase">
				<img src="/img/slash.gif"/>
			</div>
			<div>
				<p class="noComments">Para realizar comentarios debes <b><a href="javascript: void showLoginWindow()">iniciar tu sesión</a></b> en runnity. <b><a href="/registro">¿Aún no estás registrado?</a></b></p>
			</div>
			 {/if}
		
			</div>
		</div>		
	</div>


	<!-- RIGHT COLUMN -->
	<div class="span-1 last rightColumn userRightColumn">
		<div class="span-1 functionalContainer">
			<p class="titulo tituloLeft tituloColumnRight">MAS FOTOS DE {$pictures[1].user_name}</p>
			<div class="eventsUsers">
			{if $pictures}
				<div class="avatarContainer">
				{foreach key=id item=picture from=$pictures}
					<a href="/image.php?id={$data.id}&picId={$picture.id}&type=b"><img class="avatarPhoto" src="/picture.php?id={$data.id}&picId={$picture.id}&type=t"/></a>
				{/foreach}	
				</div>
			{/if}
			</div>
		</div>
	</div>

</div> <!-- content -->

</div> <!-- container -->

{include file="footer.tpl"} 
{include file="header.tpl"}

<span class="lat" style="display:none" id="{$obra.lat}"></span>
<span class="lon" style="display:none" id="{$obra.lon}"></span>
<span class="licitacion_id" style="display:none" id="{$licitacion_id}"></span>
<span class="obra_map" style="display:none" id="obra_map"></span>

<div id="mapa"></div>
<div id="layout">
	<div class="left_region_work">
	
		<div class="top_information">
			<div class="region_data">
				{if $obra.org_contratante eq 'Administración Local'}
					<h1><a href="/org/{$obra.grupo_fk}">{$obra.poblacion}</a></h1>
					<p class="information"><a>{$obra.provincia}</a>, {$obra.habitantes} habitantes</p>
					<p class="information"><a href="{$obra.web}">{$obra.web}</a></p>					
				{else}
					<h1><a href="/org/{$obra.grupo_fk}">{$obra.nombre_admin}</a></h1>
					<p class="information"><a href="{$obra.web}">{$obra.web}</a></p>
				{/if}
			</div>
		</div>

		<hr color="#E2E3DD" size="1"/>
		<div class="political_data">
			{if $obra.org_contratante eq 'Administración Local'}
				<h2>Alcaldía</h2>
				
				
<!--				<div class="political_logo">
					<img src="../images/iconospartido/pp.png" />
				</div> -->
				
				
				<div class="political_information">
					<h3>{$obra.alcalde}</h3>
					<p>ver su <a href="{$obra.alcalde_voota_link}">biografía en voota</a></p>
				</div>
			{else}
				<h2>Responsable</h2>	
				{if $obra.alcalde != null}
					
					<!-- <div class="political_logo">
						<img src="../images/iconospartido/pp.png" />
						</div>-->
						<div class="political_information">
							<h3>{$obra.alcalde}</h3>
							<p>ver su <a href="{$obra.alcalde_voota_link}">biografía en voota</a></p>
						</div>
				{else}
					<p style="font:normal 12px Arial; color:#666666; font-style: italic;">Información aún no disponible</p>
					
					
				{/if}
			{/if}
		</div>
		<hr color="#E2E3DD" size="1"/>
	
		
		
		<div class="political_stats">
			
			
			
			<h2>Gasto por tipo de procedimiento</h2>
			
		
				<a href="#"><div class="big_chart">	</div></a>
				
				<div class="tool_tip_toomuch">
					<span class="head"></span>
					<span class="body">
						<p class="title">too much</p>
						<p class="info">¡Que esto lo hicimos en 48 h!, ¿te parece poco?</p>
					</span>
					<span class="bottom"></span>								
				</div>
				
		
			
		</div>
		<hr color="#E2E3DD" size="1"/>
		
		
		
		<div class="political_stats">
			
			
			<h2>Gasto por categorías</h2>
			
			<a href="#"><div class="big_chart"></div></a>
			<div class="tool_tip_toomuch_two">
				<span class="head"></span>
				<span class="body">
					<p class="title">too much</p>
					<p class="info">¡Que esto lo hicimos en 48 h!, ¿te parece poco?</p>
				</span>
				<span class="bottom"></span>								
			</div>
				

		</div>
		<hr color="#E2E3DD" size="1"/>
		<div class="more_enterprises">
			<h2>Empresas más contratadas</h2>
			
						
			<a href="#"><p style="font:normal 12px Arial; color:#666666; font-style: italic;">Información aún no disponible</p></a>
			<!--><ul>
				<li>CM Construcciones y Obras (1,457,983€)</li>
				<li>Vizzuality S.L. (1,457,983€)</li>
				<li>Mallorca Catering S.L (1,457,983€)</li>
				<li>IBM (1,457,983€)</li>
				<li>La cacatua S.A (1,457,983€)</li>
			</ul>-->
		</div>
		<hr color="#E2E3DD" size="1"/>
		<div class="related_regions">
			{if $obra.org_contratante eq 'Administración Local'}
				<span>
					<h2>Municipios relacionados</h2>
					<a href="#" id="ve_mapa">ver mapa</a>
				</span>
				<ul>
				{foreach key=id item=organismo from=$orga_relacionados name=counter}
					<li><a href="/org/{$organismo.id}">{$organismo.nombre_admin}</a></li>
		    {/foreach}
				</ul>
			{else}
				<span><h2>Otros organismos</h2></span>
				<ul>
				{foreach key=id item=organismo from=$orga_relacionados name=counter}
					<li><a href="/org/{$organismo.id}">{$organismo.nombre_admin}</a></li>
		    {/foreach}
				</ul>
			{/if}
		</div>
	</div>
	<div class="renovation_content">
			
			<img src="../images/pink_arrow.png" alt="pink arrow" class="arrow" />
			<div class="content_up">
				<div class="content_left">
					<div class="avatar">
						<img src="../images/default_work.png">
					</div>
					<!-- <p class="upload"><a href="#" class="upload_photo">sube una foto</a></p> -->
				</div>
				<div class="content_right">
					<p class="title">{$obra_title|truncate:90:"..."}</p>
<!--					<p class="title">{$obra.titulo|truncate:90:"..."|lower}</p>-->
					<p class="content">{$obra.categoria}<span class="state"> - {$obra.estado} - </span>Publicada el 
						{if $obra.fecha1 eq null}
							{if $obra.fecha3 eq null}
								{$obra.fecha2}
							{else}
								{$obra.fecha3}
							{/if}
						{else}
							{$obra.fecha1}
						{/if}</p>
				</div>			
			</div>
			
			<div class="content_down">
				<div class="content_left_like" alt="{$licitacion_id}">
					<a class="like" href="#">si, me gusta (<strong>{$obra.votes_up}</strong>)</a>
					<a class="no_like" href="#">no me gusta (<strong>{$obra.votes_down}</strong>)</a>
				</div>
				<div class="content_right_comment">
					<p><a href="#" id="gotocomment">{if $obra.num_comentarios eq 1}{$obra.num_comentarios} comentario{else}{$obra.num_comentarios} comentarios{/if}</a></p>
				</div>
			</div>
			
			<div class="content_head"></div>
			
			<div class="content">
				<div class="content_left">
					<p class="award">Adjudicado a:</p>
					<p class="name">{if $obra.empresa_adjudicada eq null}Información aún no disponible{else}<a href="#">{$obra.empresa_adjudicada}{/if}</a></p>
				</div>
				
			
				
			
				<div class="content_right">
					
					{if $obra.tipo_contrato == "NegociadoConPubli" || $obra.tipo_contrato == "NegociadoSinPublicidad" }
					
					<!-- CONTRATO NEGOCIADO -->
					<div class="tool_tip_negociated">
						<span class="head"></span>
						<span class="body">
							<p class="title">Contrato negociado</p>
							<p class="info">Obras de renovación de las instalaciones deportivas del polideportivo municipal...</p>
						</span>
						<span class="bottom"></span>								
					</div>
					<a href="#">
						<span class="kind_contrat_negociated">
						</span>
					</a>
					{/if}
					{if $obra.tipo_contrato == "Abierto"}
					
					<!-- CONTRATO ABIERTO -->
					<div class="tool_tip_open">
						<span class="head"></span>
						<span class="body">
							<p class="title">Contrato abierto</p>
							<p class="info">Todo empresario interesado puede presentar una oferta.</p>
						</span>
						<span class="bottom"></span>								
					</div> 
					<a href="#">
						<span class="kind_contrat_open">
						</span>
					</a>
					{/if}
					{if $obra.tipo_contrato == "Restringido"}
					<!-- CONTRATO RESTRINGIDO -->
					<div class="tool_tip_restricted">
						<span class="head"></span>
						<span class="body">
							<p class="title">Contrato restringido</p>
							<p class="info">Sólo podrán presentar ofertas los empresarios seleccionados por la Administración.</p>
						</span>
						<span class="bottom"></span>								
					</div>
					<a href="#">
						<span class="kind_contrat_restricted">
						</span>
					</a>
					{/if}
					{if $obra.tipo_contrato == "Autodefinido" || $obra.tipo_contrato == "Dialogo"}
					<!-- CONTRATO OTROS -->
					<div class="tool_tip_other">
						<span class="head"></span>
						<span class="body">
							<p class="title">Otros contratos</p>
							<p class="info">Contratos raramente usados: diálogo competitivo o autodefinido.</p>
						</span>
						<span class="bottom"></span>								
					</div>
					<a href="#">
						<span class="kind_contrat_other">
						</span>
					</a>
					{/if}
					
					
					
					
					<a class="money"><span>{$obra.importe|number_format}€</span></a>		
				</div>
				<div class="content_left">
					<p class="title">Descripción de la obra</p>
				</div>
				<div class="line_to_separate"></div>
					{if $obra.descripcion == null}
						<div class="no_info">
							<p class="messageTitle">Aún no tenemos descripción para esta obra</p>
							<p class="suggestMessage">Si quieres, puedes <a href="mailto:contact@vizzuality.com">sugerirnos una</a> . </p>
						</div>
					{else}
						<p class="description">{$obra.descripcion}</p>
					{/if}

				<p class="download">
					<span class="view_more"><a href="{$obra.url_html_licitacion}">Ver esta licitación en contratacióndelestado.es</a></span>
				</p>
				
				<div class="content_left" id="comments_container">
					<p class="title_comments">Comentarios ({$obra.num_comentarios})</p>
				</div>

				{if $obra.num_comentarios != 0}
				<div class="line_to_separate"></div>
				<div class="comments">
					<ul>
						{foreach key=id item=comentario from=$comentarios name=counter}
							<li>
								<div class="avatar">
									<img src="{$comentario.md5_imagen}" />
								</div>
								<div class="comment_area">
									<p class="name"><a href="{$comentario.web}">{$comentario.nombre}</a><small>, el {$comentario.created_when}</small></p>
									<p class="comment">{$comentario.comentario}</p>
								</div>
							</li>
							{if $smarty.foreach.counter.iteration != $obra.num_comentarios}
								<li><div class="line_to_separate"></div></li>
							{/if}
				    {/foreach}
					</ul>
				</div>
				{/if}
				<form class="send_comment" action="javascript:void createNewComment()" alt="">
					<div class="line_comment"></div>
					<img src="../images/ajax-loader.gif" style="display:none; padding:40px 0 40px 270px">
					
					<div class="all_inputs">
						<div class="name">
							<p class="title">Tu nombre</p>
							<input type="text" value="" id="name_text"/>
						</div>

						<div class="email">
							<p class="title">Tu email</p>
							<input type="text" value="" id="mail_text"/>
						</div>
					
						<div class="web">
							<p class="title">Tu web (opcional)</p>
							<input type="text" value="" id="web_text"/>
						</div>
					
						<div class="comment">
							<p class="title">Tu comentario</p>
							<textarea id="comment_text"></textarea>
						</div>
						<p id="errors" style="float:left; margin:30px 0 0 19px; font:bold 13px Arial; font-style: italic; color:#333333;"></p>	
						<input type="submit" value="" />
					</div>
				</form>
			</div>
					
			 <div class="more">
				<p class="title">Más obras relacionadas</p>
				<ul>
					{foreach key=id item=licitacion from=$otras_obras name=counter}
					<li>
						<div class="imgPlace">
							<a href="{$licitacion.licitacion_id}">
								
								<img src="../images/default_work.png">
							</a>
						</div>
						<div class="info">
							<p class="about"><a href="{$licitacion.licitacion_id}">{$licitacion.titulo|truncate:70:"..."|lower|capitalize}</a></p>
							<p class="info">{$licitacion.categoria} <span>- {$licitacion.importe|number_format}€</span></p>
						</div>
						<div class="result">
							<a class="likes" href="#">{$licitacion.votes_up}</a>
							<a class="no_likes" href="#">{$licitacion.votes_down}</a>
							<p class="comments"><a href="{$licitacion.licitacion_id}">{if $licitacion.num_comentarios eq 1}{$licitacion.num_comentarios} comentario{else}{$licitacion.num_comentarios} comentarios{/if}</a></p>
						</div>
					</li>
			   {/foreach}

				</ul>
			</div>
	</div>


	
</div>

{include file="footer.tpl"}

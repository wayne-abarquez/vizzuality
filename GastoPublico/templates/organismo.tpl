{include file="header.tpl"}

<span class="lat" style="display:none" id="{$organismo.lat}"></span>
<span class="lon" style="display:none" id="{$organismo.lon}"></span>

<div id="mapa"></div>
<div id="layout">
	<div class="left_region">
		<img class="arrow" src="../images/white_arrow.png" alt="white arrow" />
		<div class="top_information">
			<div class="logo">	
				{if $organismo.escudo == null}
					<img src="{$organismo.escudo}"/>
				{else}
					<img src="{$organismo.escudo}"/>
				{/if}
			</div>
			<div class="region_data">
				<h1>{$organismo.nombre_admin}</h1>
				<p class="web"><a href="{$organismo.web}" target="_blank">{$organismo.web}</a></p>
			</div>
		</div>
		<hr color="#E2E3DD" size="1"/>
		<div class="political_data">
			<h2>Responsable</h2>

			<div class="political_logo">				
				<img src="{$logoPartido}"/>
			</div>
			
			<div class="political_information">
				<h3>{$organismo.alcalde}</h3>
				<p>ver su <a href="{$organismo.alcalde_voota_link}">biografía en voota</a></p>
			</div>
		</div>
		<hr color="#E2E3DD" size="1"/>
		<div class="political_stats">
			<h2>Gasto por tipo de procedimiento</h2>
			<a href="#"><div class="big_chart">	</div></a>
			
			<div class="tool_tip_toomuch_org">
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
			<a href="#"><div class="big_chart">	</div></a>
			
			<div class="tool_tip_toomuch_org_two">
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
				<li>asdfñjfasdf (1,457,983€)</li>
				<li>asdfñjfasdf (1,457,983€)</li>
				<li>asdfñjfasdf (1,457,983€)</li>
				<li>asdfñjfasdf (1,457,983€)</li>
				<li>asdfñjfasdf (1,457,983€)</li>
			</ul>-->
		</div>
		<hr color="#E2E3DD" size="1"/>
		<div class="related_regions">
			<span>
				<h2>Otros organismos</h2>
			</span>	
			<ul>
				{foreach key=id item=organismo_lista from=$orga_relacionados name=counter}
					<li><a href="../org/{$organismo_lista.id}">{$organismo_lista.nombre_admin}</a></li>
		    {/foreach}
			</ul>
		</div>
	</div>
	
	<div class="right_region">
		<span>
			<h3>{$organismo.num_licitaciones} Licitaciones</h3>
			<div>
				<p>{$organismo.sum_importe|number_format}€</p>
				<p class="small">GASTO TOTAL</p>
			</div>
		</span>
		<div class="search_container">
		</div>
		<ul>
			{foreach key=id item=licitacion from=$lista_licitaciones name=counter}
				<li>
					<div class="left_information">
						<div class="work_image">
							<a href="../contrato/{$licitacion.licitacion_id}"><img src="{if $licitaion.imagen eq null}../images/default_work.png{else}{$licitacion.imagen}{/if}" /></a>
						</div>
						<div class="work_information">
							<a href="../contrato/{$licitacion.licitacion_id}">{$licitacion.titulo|truncate:120:"..."|lower|capitalize:true}</a>
							<p>{$licitacion.categoria} - Presupuesto de <strong>{$licitacion.importe|number_format}€</strong></p>
						</div>
					</div>
					<div class="right_information">
						<a class="no_likes" href="#">{$licitacion.votes_down}</a>	
						<a class="likes" href="#">{$licitacion.votes_up}</a>
						<a class="comments" href="#">{if $licitacion.num_comentarios eq 1}{$licitacion.num_comentarios} comentario{else}{$licitacion.num_comentarios} comentarios{/if}</a>
					</div>
				</li>
	    {/foreach}
		</ul>
		
		<p class="long"><a href="#">pronto...</a></p>
		<p class="long">viendo 20 de {$organismo.num_licitaciones}</p>
		
	</div>
	
</div>

{include file="footer.tpl"}
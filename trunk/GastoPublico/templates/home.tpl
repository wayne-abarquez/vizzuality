{include file="header.tpl"}

<div id="map" style="height:384px">
</div>

<div id="layout">
	
	<div class="overMap">
		<h1>Entérate de las obras que hay a tu alrededor y dí qué te parecen.</h1>
	
		<div class="searchForm">
			<h3>Busca tu municipio y encuentra obras en él</h3>
			<form>
				<input type="text" name="bigSearch" value="" />
				<input type="submit" value="" />
				
			</form>
			<p>¿es tu municipio <a href="#">Villaviciosa de Odón, Madrid</a>?</p>
		</div>
	
	</div>
	
	<div class="main_container">
		<div class="left_home">
			<h3>Obras con comentarios recientes</h3>
			<ul>
				{foreach key=id item=licitacion from=$licitaciones name=count}
					{if $smarty.foreach.count.iteration < 5}
						<li>
					{else}
						<li class="last">
					{/if}
					<div class="left_information">
						<div class="work_image">
								<a href="obra.php?id={$licitacion.licitacion_id}"><img src="../images/default_work.png" alt="Work" /></a>
						</div>
						<div class="work_information">
							<h4><a href="obra.php?id={$licitacion.licitacion_id}">{$licitacion.titulo|truncate:120:"..."|lower|capitalize:true}</a></h4>
							{if $licitacion.org_contratante eq 'Administración Local'}
								<p><a href="municipio.php?id={$licitacion.grupo_id}">{$licitacion.nombre_admin}</a> - <strong>{$licitacion.importe|number_format}€</strong></p>
							{else}
								<p><a href="organismo.php?id={$licitacion.grupo_id}">{$licitacion.nombre_admin}</a> - <strong>{$licitacion.importe|number_format}€</strong></p>
							{/if}
						</div>
					</div>
					<div class="right_information" alt="{$licitacion.licitacion_id}">
						<a class="no_likes" href="#">{$licitacion.votes_down}</a>	
						<a class="likes" href="#">{$licitacion.votes_up}</a>
						<a class="comments" 
						{if $licitacion.org_contratante eq 'Administración Local'}
							href="municipio.php?id={$licitacion.grupo_id}"
						{else}
							href="organismo.php?id={$licitacion.grupo_id}"
						{/if}>{if $licitacion.num_comentarios eq 1}{$licitacion.num_comentarios} comentario{else}{$licitacion.num_comentarios} comentarios{/if}</a>
						
					</div>
				</li>
		    {/foreach}
			</ul>
		</div>
		<div class="right_home">
			<h3>¿Cómo gasta España el dinero en obras?</h3>
			<div class="long">
				<div class="stats left">
					<label>GASTO</label>
					<p class="amount">212,317,321€</p>
				</div>
				<div class="right expensive_chart">
				</div>
			</div>

			<hr size="1" color="#CDCDC7" width="320" style="float:left"/>
			
			<h3>¿Cómo gastan los principales partidos el dinero en obras?</h3>
		
			<div class="longPolitical">
				<div class="political_stats2">
					<div class="expensive_chart2"></div>
					<p class="politicalName">Partido Popular</p>
				</div>
				<div class="political_stats">
					<div class="expensive_chart2"></div>
					<p class="politicalName">PSOE</p>
				</div>
				<div class="political_stats">
					<div class="expensive_chart2"></div>
					<p class="politicalName">Izquierda Unida</p>
				</div>
			</div>
			<p class="long"><a href="#">Más respuestas en stats.gastopublico.es</a></p> 
		</div>
	</div>
</div>

{include file="footer_home.tpl"}
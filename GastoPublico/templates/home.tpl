{include file="header.tpl"}

<div id="map" style="height:384px">
</div>

<div id="layout">
	
	<div class="overMap">
		<h1>Entérate de las obras que hay a tu alrededor y di que te parecen.</h1>
	
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
								<a href="obra/{$licitacion.licitacion_id}"><img src="../images/default_work.png" alt="Work" /></a>
						</div>
						<div class="work_information">
							<h4><a href="obra/{$licitacion.licitacion_id}">{$licitacion.titulo|truncate:100:"..."}</a></h4>
							{if $licitacion.org_contratante eq 'Administración Local'}
								<p><a href="municipio/{$licitacion.organismo_id}">{$licitacion.nombre_admin}</a> - <strong>{$licitacion.importe|number_format}€</strong></p>
							{else}
								<p><a href="organismo/{$licitacion.organismo_id}">{$licitacion.nombre_admin}</a> - <strong>{$licitacion.importe|number_format}€</strong></p>
							{/if}
						</div>
					</div>
					<div class="right_information">
						<a class="no_likes" href="#">{$licitacion.votes_down}</a>	
						<a class="likes" href="#">{$licitacion.votes_up}</a>
						<a class="comments" href="#">{$licitacion.num_comentarios} comentarios</a>
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
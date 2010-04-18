{include file="header.tpl"}

<div id="map"></div>
<div id="layout">
	<div class="left_region">
		<img class="arrow" src="../images/white_arrow.png" alt="white arrow">
		<div class="top_information">
			<div class="logo">
				<img src="../images/villaviciosa.png" />
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
				<img src="../images/iconospartido/psoe.png" />
			</div>
			<div class="political_information">
				<h3>{$organismo.alcalde}</h3>
				<p>ver su <a href="{$organismo.alcalde_voota_link}">biografía en voota</a></p>
			</div>
		</div>
		<hr color="#E2E3DD" size="1"/>
		<div class="political_stats">
			<h2>Gasto por tipo de procedimiento</h2>
			<div class="big_chart"></div>
		</div>
		<hr color="#E2E3DD" size="1"/>
		<div class="political_stats">
			<h2>Gasto por categorías</h2>
			<div class="big_chart"></div>
		</div>
		<hr color="#E2E3DD" size="1"/>
		<div class="more_enterprises">
			<h2>Empresas mas contratadas</h2>
			<ul>
				<li>asdfñjfasdf (1,457,983€)</li>
				<li>asdfñjfasdf (1,457,983€)</li>
				<li>asdfñjfasdf (1,457,983€)</li>
				<li>asdfñjfasdf (1,457,983€)</li>
				<li>asdfñjfasdf (1,457,983€)</li>
			</ul>
		</div>
		<hr color="#E2E3DD" size="1"/>
		<div class="related_regions">
			<span>
				<h2>Otros organismos</h2>
			</span>	
			<ul>
				{foreach key=id item=organismo_lista from=$orga_relacionados name=counter}
					<li><a href="organismo.php?id={$organismo_lista.id}">{$organismo_lista.nombre_admin}</a></li>
		    {/foreach}
			</ul>
		</div>
	</div>
	
	<div class="right_region">
		<span>
			<h3>{$organismo.num_licitaciones} Obras en el municipio</h3>
			<div>
				<p>{$organismo.sum_importe}€</p>
				<p class="small">GASTO</p>
			</div>
		</span>
		<div class="search_container">
		</div>
		<ul>
			<li>
				<div class="left_information">
					<div class="work_image">
						<a href="#"><img src="../images/work_fake.png" /></a>
					</div>
					<div class="work_information">
						<a hre="#">Renovación de las instalaciones deportivas del Polideportivo municipal “El Torreón”</a>
						<p>Infraestructuras - Presupuesto de <strong>431,234€</strong></p>
					</div>
				</div>
				<div class="right_information">
					<a class="no_likes" href="#">21</a>	
					<a class="likes" href="#">1</a>
					<a class="comments" href="#">0 comentarios</a>
				</div>
			</li>
			<li>
				<div class="left_information">
					<div class="work_image">
						<a href="#"><img src="../images/default_work.png" /></a>
					</div>
					<div class="work_information">
						<a hre="#">Renovación de las instalaciones deportivas del Polideportivo municipal “El Torreón”</a>
						<p>Infraestructuras - Presupuesto de <strong>431,234€</strong></p>
					</div>
				</div>
				<div class="right_information">
					<a class="no_likes" href="#">21</a>	
					<a class="likes" href="#">1</a>
					<a class="comments" href="#">{if $organismo.num_comentarios eq 1}{$organismo.num_comentarios} comentario{else}{$organismo.num_comentarios} comentarios{/if}</a>
				</div>
			</li>
			<li>
				<div class="left_information">
					<div class="work_image">
						<a href="#"><img src="../images/work_fake.png" /></a>
					</div>
					<div class="work_information">
						<a hre="#">Renovación de las instalaciones deportivas del Polideportivo municipal “El Torreón”</a>
						<p>Infraestructuras - Presupuesto de <strong>431,234€</strong></p>
					</div>
				</div>
				<div class="right_information">
					<a class="no_likes" href="#">21</a>	
					<a class="likes" href="#">1</a>
					<a class="comments" href="#">0 comentarios</a>
				</div>
			</li>
			<li>
				<div class="left_information">
					<div class="work_image">
						<a href="#"><img src="../images/default_work.png" /></a>
					</div>
					<div class="work_information">
						<a hre="#">Renovación de las instalaciones deportivas del Polideportivo municipal “El Torreón”</a>
						<p>Infraestructuras - Presupuesto de <strong>431,234€</strong></p>
					</div>
				</div>
				<div class="right_information">
					<a class="no_likes" href="#">21</a>	
					<a class="likes" href="#">1</a>
					<a class="comments" href="#">0 comentarios</a>
				</div>
			</li>
			<li>
				<div class="left_information">
					<div class="work_image">
						<a href="#"><img src="../images/work_fake.png" /></a>
					</div>
					<div class="work_information">
						<a hre="#">Renovación de las instalaciones deportivas del Polideportivo municipal “El Torreón”</a>
						<p>Infraestructuras - Presupuesto de <strong>431,234€</strong></p>
					</div>
				</div>
				<div class="right_information">
					<a class="no_likes" href="#">21</a>	
					<a class="likes" href="#">1</a>
					<a class="comments" href="#">0 comentarios</a>
				</div>
			</li>
			<li>
				<div class="left_information">
					<div class="work_image">
						<a href="#"><img src="../images/work_fake.png" /></a>
					</div>
					<div class="work_information">
						<a hre="#">Renovación de las instalaciones deportivas del Polideportivo municipal “El Torreón”</a>
						<p>Infraestructuras - Presupuesto de <strong>431,234€</strong></p>
					</div>
				</div>
				<div class="right_information">
					<a class="no_likes" href="#">21</a>	
					<a class="likes" href="#">1</a>
					<a class="comments" href="#">0 comentarios</a>
				</div>
			</li>
		</ul>
		
		<p class="long"><a href="#">ver más</a></p>
		<p class="long">viendo 6 de 17</p>
		
	</div>
	
</div>

{include file="footer.tpl"}
	<div class="outer_layout_footer">
		<div class="footer">
			<div class="left_footer_home">
				<h5>Organismos más activos</h5>
				<p class="regions">
					{foreach key=id item=region from=$regiones name=contador}
						{if $region.org_contratante eq 'Administración Local'}
							<a href="/org/{$region.grupo_fk}">{$region.nombre_admin} ({$region.num_licitaciones})</a>
						{else}
							<a href="/org/{$region.grupo_fk}">{$region.nombre_admin} ({$region.num_licitaciones})</a>
						{/if}
						{if $smarty.foreach.contador.iteration < 7}, {else}...{/if}
			    {/foreach}
				</p>
				<p class="footer">gastopublico.es es una iniciativa de <a href="http://vizzuality.com" target="_blank">vizzuality</a> para <a href="http://abredatos.es" target="_blank">abredatos</a></p>
			</div>
			<div class="right_footer_home">
				<ul>
					<li><a href="mailto:contact@vizzuality.com">contacto</a></li>
					<li class="last"><a href="../sobre/">sobre</a></li>
				</ul>
			</div>
		</div>
	</div>

	{literal}
	<script type="text/javascript">
	var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
	document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
	</script>
	<script type="text/javascript">
	try {
	var pageTracker = _gat._getTracker("UA-15905050-1");
	pageTracker._trackPageview();
	} catch(err) {}</script>
	{/literal}

</BODY>
</HTML>
{include file="header.tpl"}
	<div class="outer_layout">
		<div class="explore_map">
			<img class="arrow" src="images/common/arrow_menu.png" alt=""/>
			<h2>Explore the Antarctic and create your field guide</h2>
			<p class="subtitle"><strong>11,312 species</strong> and <strong>193 landscapes</strong> in our database</p>
			<div class="map">
				<div id="map"></div>
			</div>
		</div>

		
		<div class="taxonomy_browser_body">
			<div class="content">
				<div class="content_left">
					<p class="species_included">Taxonomic Browser</p>
					<p class="number_species">1432 species in this database</p>				
				</div>
				<div class="content_right">
					<a class="view_advanced_browser" href="#">view the <span>advanced taxon browser</span></a>
				</div>
				<div class="taxonomy_browser"></div>
			</div>
		</div> 
		
		<div class="most_popular_explore">
			<div class="content">
				<h3>Most popular Antartic Field Guides</h3>
				<p class="subtitle">choose one of this guides if you don't want to create yours from scratch</p>
				<ul>
					<li>
						<div class="information_title">
							<h4><a href="guide.php">The definitive Atlantic Field Guide</a></h4>
							<p class="by">by Brunno Dannis</p>
							<p class="heart"><span><img src="images/home/pink_heart.png" alt="heart"/>11</span></p>
						</div>
						<div class="stats">
							<p class="species_rank second_rank left">32 SPECIES</p>
							<p class="landscapes_rank first_rank left">9 LANDSCAPES</p>
						</div>							
					</li>
					<li>
						<div class="information_title">
							<h4><a href="guide.php">This is gonna be great. Antartic trip...</a></h4>
							<p class="by">by Javier de la Torre</p>
							<p class="heart"><span><img src="images/home/pink_heart.png" alt="heart"/>11</span></p>
						</div>
						<div class="stats">
							<p class="species_rank second_rank left">20 SPECIES</p>
							<p class="landscapes_rank second_rank left">18 LANDSCAPES</p>
						</div>
					</li>
					<li>
						<div class="information_title">
							<h4><a href="guide.php">Whales guide</a></h4>
							<p class="by">by Sergio Alvarez</p>
							<p class="heart"><span><img src="images/home/pink_heart.png" alt="heart"/>11</span></p>
						</div>
						<div class="stats">
							<p class="species_rank third_rank left">41 SPECIES</p>
						</div>
					</li>

					<li>
						<div class="information_title">
							<h4><a href="guide.php">The Whole Pole</a></h4>
							<p class="by">by Brunno Dannis</p>
							<p class="heart"><span><img src="images/home/pink_heart.png" alt="heart"/>11</span></p>
						</div>
						<div class="stats">
							<p class="species_rank third_rank left">41 SPECIES</p>
						</div>
					</li>
				</ul>
			</div>
		</div>
		
		

		<div class="long">
			<div class="long_in">
				<h3>Your Atlantic Field Guide</h3>
				<p class="subtitle">Here is were your species and landscapes will be added</p>
				<ul id="sortable">
					<li id ="draggable" class="single"><p class="title">Your AFG</p></li>
					<li id ="draggable" class="single"><p class="title">Your AFG</p></li>
					<li id ="draggable" class="amount"><p class="title">Your AFG</p></li>
					<li class="dragg_here"><p>DRAGG SOMETHING HERE TO ADD IT</p></li>					
				</ul>
				
			</div>
			<div class="bottom">
				<div class="left_side">
					<a href="#" class="left"></a>
					<a href="#" class="right"></a>
				</div>
				<div class="right_side">
					<a href="#"></a>
				</div>
			</div>
		</div>		
	</div>
{include file="footer.tpl"}

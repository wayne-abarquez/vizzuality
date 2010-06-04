<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
	<head>
		<title>{$title} {if ($page!=null)}-{/if} {$page}</title>
		<link rel="stylesheet" href="stylesheets/layout.css" type="text/css" media="screen" title="no title" charset="utf-8">
		
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.js" type="text/javascript" charset="utf-8"></script>
		
		<script src="javascripts/jquery.nivo.slider.js" type="text/javascript" charset="utf-8"></script> 
		<script type="text/javascript" src="javascripts/jquery.ui.js"></script>
		<script type="text/javascript" src="javascripts/jquery.ui.widget.js"></script>
		<script type="text/javascript" src="javascripts/jquery.ui.mouse.js"></script>
		<script type="text/javascript" src="javascripts/jquery.ui.sortable.js"></script>
		<script src="javascripts/application.js" type="text/javascript" charset="utf-8"></script>
	</head>

	<body>

		<div class="outer_layout">
			<div class="header">
				<div class="logo">
					<a href="index.php"></a>
					<span class="search">
						<form>
							<input type="text" value="Search species, guides, ..." />
							<input type="submit" value="" />
						</form>
					</span>
				</div>
				<div class="header_menu">
					<ul>
						<li class="first">
							{if $page == 'Home'}						
								<a class="current" href="index.php">HOME</a></li>
							{else}
								<a href="index.php">HOME</a></li>
							{/if}
						<li>
							{if $page == 'Explore'}						
								<a class="current" href="explore.php">EXPLORE</a>
							{else}
								<a href="explore.php">EXPLORE</a>
							{/if}
						</li>
						<li>
							{if $page == 'Guides' || $page == 'Guide'}
								<a class="current" href="guides.php">GUIDES</a>
							{else}
								<a href="guides.php">GUIDES</a>
							{/if}
						</li>
						<li><a href="#">ABOUT</a></li>
					</ul>
				</div>
			</div>
		</div>

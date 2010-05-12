
	$(document).ready(function() {

		//hover species list effect >> HOME
		$('div.left ul li div.specie').hover(function(ev){
			$(this).css('background-position','-4px -175px');
		},
		function(ev){
			$(this).css('background-position','-4px -4px');
		});
		
		//hover created list effect >> HOME
		$('div.left div.create ul li').hover(function(ev){
			$(this).css('background-position','-2px -175px');
		},
		function(ev){
			$(this).css('background-position','-2px -2px');
		});
		
  });


	$(window).load(function() {
		//gallery effect >> HOME
		$('#slider').nivoSlider({effect:'fold'});
	});


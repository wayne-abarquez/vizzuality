	$(document).ready(function() {
		
		//hover species list effect >> HOME
		$('div.left ul li div.specie').hover(function(ev){
			$(this).css('background-position','-4px -175px');
		},
		function(ev){
			$(this).css('background-position','-4px -4px');
		});
		
		//hover created list effect >> HOME
		$('div.left div.create ul.published_afg li').hover(function(ev){
			$(this).css('background-position','-2px -175px');
		},
		function(ev){
			$(this).css('background-position','-2px -2px');
		});
		
		//list effect latest activity >> HOME
		setInterval("changeList()",3000);
		
		

		//hover created list effect >> GUIDES
		$('div.header_guides div.content ul li').hover(function(ev){
			$(this).css('background-position','0px -177px');
		},
		function(ev){
			$(this).css('background-position','0 -2px');
		});
		
		//hover created list effect >> GUIDES
		$('div.sorted_by a.sorted_box_deactivated').click(function(ev){
			ev.stopPropagation();
			ev.preventDefault();
			$(this).parent().children('div.activated_box').show();

		});

		//hover created list effect >> GUIDES
		$('div.activated_box a.sorted_box_activated').click(function(ev){

			ev.stopPropagation();
			ev.preventDefault();

			$(this).parent().fadeOut();

		});
		
		
		
  });


	$(window).load(function() {
		//gallery effect >> HOME
		$('#slider').nivoSlider({effect:'fold'});
	});


	function changeList() {
		$('div.right div.latest_ ul li:first div').removeClass('first');
		$('div.right div.latest_ ul li:eq(4) div').animate({opacity: 0}, 700);
		var last_li = $('div.right div.latest_ ul li:last').html();
		$('div.right div.latest_ ul li:last').remove();
		$('div.right div.latest_ ul').prepend('<li style="height:0;"></li>');
		$('div.right div.latest_ ul li:first').animate({
		    height: 67
		  }, 700, function() {
		    $('div.right div.latest_ ul li:first').html(last_li);
				$('div.right div.latest_ ul li:first div').css('opacity','0');
				$('div.right div.latest_ ul li:first div').addClass('first');
				$('div.right div.latest_ ul li:first div').animate({opacity: 1}, 700);
		});


		
	}

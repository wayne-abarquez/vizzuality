
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
		
		//list effect latest activity >> HOME
		setInterval("changeList()",3000);
		
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

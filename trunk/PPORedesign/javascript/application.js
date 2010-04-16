/* VARIABLES */

/* */

$(document).ready(function() {

	$('div.content_browse ul li a.more').click(function(ev){
		ev.stopPropagation();
		ev.preventDefault();
		$(this).parent().children('div.submenu_actived').show();
		
	});
	
	$('div.submenu_actived li.submenu a.title_submenu').click(function(ev){

		ev.stopPropagation();
		ev.preventDefault();
	
		$(this).parent().parent().fadeOut();
		
	});

});




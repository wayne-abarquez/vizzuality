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

	$('div.content_browse ul li a.more').click(function(ev){
		ev.stopPropagation();
		ev.preventDefault();
		$(this).parent().children('div.submenu_actived').show();
		
	});
	
	$('div.content_browse ul li a').click(function(ev){
		ev.stopPropagation();
		ev.preventDefault();
		console.log('entra');
		
		if ($(this).parent().hasClass('checked')) {
			console.log('entra2');
			
			$(this).parent().removeClass('checked');
			$(this).parent().addClass('unchecked');			
		}
		
		else if ($(this).parent().hasClass('unchecked')) {
			console.log('entra3');
			
			$(this).parent().removeClass('unchecked');
			$(this).parent().addClass('checked');			
		}
		
	});
	
});




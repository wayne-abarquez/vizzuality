$(document).ready(function() {

	// FONTS	
	
	// Cufon.replace('.myriad', {fontFamily: 'Myriad Pro',fontWeight:'600'}); -- SHADOW
	// Cufon.replace('.calibri', {fontFamily: 'Calibri'});

	// -- HOME
	// show upload options - URL
	if(($('a#import_url_option') != null) && ($('a#import_url_option')[0])){
		$('a#import_url_option').click(function(ev){
			ev.stopPropagation();
			ev.preventDefault();
			if ($(this).parent().parent('div.upload_content').find('div#upload_file').hasClass('active')){
				$(this).parent().parent('div.upload_content').find('div#upload_file').removeClass('active');
				$(this).parent('div#import_url').addClass('active');
			}

		});		
	}

	if (($('a#upload_file_option') != null)&&($('a#upload_file_option')[0])){
		// show upload options - FILE
		$('a#upload_file_option').click(function(ev){
			ev.stopPropagation();
			ev.preventDefault();

			if ($(this).parent().parent('div.upload_content').find('div#import_url').hasClass('active')){
				$(this).parent().parent('div.upload_content').find('div#import_url').removeClass('active');
				$(this).parent('div#upload_file').addClass('active');
			}
		});		
	}
	
	if (($('ul.datasets li')!=null) && ($('ul.datasets li')[0])){
		$('ul.datasets li').find('a#category').click(function(ev){
			ev.stopPropagation();
			ev.preventDefault();

			$(this).parent().find('div.suboptions').fadeIn();
		});

		$('ul.datasets li').find('div.suboptions').find('span.top a').click(function(ev){
			ev.stopPropagation();
			ev.preventDefault();

			$(this).parent().parent().fadeOut();
		});		
	}
	
	 if (($('a.data_type')!=null)&&($('a.data_type')[0])) {
		$('a.data_type').click(function(e){
			e.stopPropagation();
			e.preventDefault();
			
			if ($(this).hasClass('displayed')){
				$(this).removeClass('displayed');
				$(this).parent().children('ul').css('display','none');
			}else {
				$(this).addClass('displayed');
				$(this).parent().children('ul').fadeIn('fast');
			}			
		});		
	}
	
	// if 	(($('div#your_layers_content')!=null)&&($('div#your_layers_content')[0])) {
	// 	
	// 	$("div#list_column_layers").easySlider({
	// 				auto: false, 
	// 				continuous: false,
	// 				numeric:true
	// 			});
	// 			
	// }
	
	// if 	(($('div#your_maps_content')!=null)&&($('div#your_maps_content')[0])) {
	// 			$("div#list_column_maps").easySlider({
	// 						auto: false, 
	// 						continuous: false,
	// 						numeric:true
	// 					});				
				
	// }
	
	// TABS CONTROL
	if (($('#your_layers_tab') != null)&&($('#your_layers_tab')[0])){
		$('#your_layers_tab').click(function(ev){
			ev.stopPropagation();
			ev.preventDefault();
			
			if (!$(this).hasClass('active')){
				$('ul.tabs').children('li.active').removeClass('active');
				$(this).addClass('active');
			}
			$('div#your_layers_content').css('display','inline');
			$('div#your_maps_content').css('display','none');
			$('div#pending_layers_content').css('display','none');
		});
	}
	
	if (($('#your_maps_tab') != null)&&($('#your_maps_tab')[0])){
		$('#your_maps_tab').click(function(ev){
			ev.stopPropagation();
			ev.preventDefault();
			
			if (!$(this).hasClass('active')){
				$('ul.tabs').children('li.active').removeClass('active');
				$(this).addClass('active');
			}
			$('div#your_layers_content').css('display','none');
			$('div#your_maps_content').css('display','inline');
			$('div#pending_layers_content').css('display','none');
		});
	}

	if (($('#pending_layers_tab') != null)&&($('#pending_layers_tab')[0])){
		$('#pending_layers_tab').click(function(ev){
			ev.stopPropagation();
			ev.preventDefault();
			
			if (!$(this).hasClass('active')){
				$('ul.tabs').children('li.active').removeClass('active');
				$(this).addClass('active');
			}
			$('div#your_layers_content').css('display','none');
			$('div#your_maps_content').css('display','none');
			$('div#pending_layers_content').css('display','inline');			
		});
	}

	$('a#library_upload_file_combo').click(function(ev){
		ev.stopPropagation();
		ev.preventDefault();
		console.log('entra');
		if (!$(this).parent().hasClass('active')){
			$('div#library_import_url_option').removeClass('active');
			$(this).parent().addClass('active');
		}		
	});
	
	$('a#library_import_url_combo').click(function(ev){
		console.log('entra');
		ev.stopPropagation();
		ev.preventDefault();
	
		if (!$(this).parent().hasClass('active')){
			$('div#library_upload_file_option').removeClass('active');
			$(this).parent().addClass('active');
		}		
	});
});

function importUrl() {
	$('div#import_url').find('#importButton').addClass('disabled');
	$('div#import_url').find('#importButton').val('Importing...');
	$('div#import_url').find('span.processing').fadeIn('fast');
	$('div#import_url').find('.input_content').css('display','none');
	$('div#import_url').find('a.data_type').css('display','none');
}



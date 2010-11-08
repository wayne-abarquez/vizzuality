$(document).ready(function() {
	
	// -- HOME
	
	// show upload options - URL
	$('a#import_url_option').click(function(ev){
		ev.stopPropagation();
		ev.preventDefault();
		if ($(this).parent().parent('div.upload_content').find('div#upload_file').hasClass('active')){
			$(this).parent().parent('div.upload_content').find('div#upload_file').removeClass('active');
			$(this).parent('div#import_url').addClass('active');
		}
		
	});

	// show upload options - FILE
	$('a#upload_file_option').click(function(ev){
		ev.stopPropagation();
		ev.preventDefault();
		
		if ($(this).parent().parent('div.upload_content').find('div#import_url').hasClass('active')){
			$(this).parent().parent('div.upload_content').find('div#import_url').removeClass('active');
			$(this).parent('div#upload_file').addClass('active');
		}
	});
	
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
});

function importUrl() {
	$('div#import_url').find('#importButton').addClass('disabled');
	$('div#import_url').find('#importButton').val('Importing...');
	$('div#import_url').find('span.processing').fadeIn('fast');
	$('div#import_url').find('.input_content').css('display','none');
	$('div#import_url').find('a.data_type').css('display','none');
}



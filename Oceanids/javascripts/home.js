$(document).ready(function() {
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
		$('ul.datasets li').find('a.element').click(function(ev){		
			ev.stopPropagation();
			ev.preventDefault();
         
         $('div.suboptions').fadeOut();			
         
			$(this).parent().find('div.suboptions').fadeIn();
			
			$(document).click(function(event) {
				
					if (!$(event.target).closest('div.suboptions').length) {
						$('div.suboptions').fadeOut();
						$(document).unbind('click');
					};
			});
			
		});

		$('ul.datasets li').find('div.suboptions').find('span.top a').click(function(ev){	
			ev.stopPropagation();
			ev.preventDefault();
			$(this).parent().parent().fadeOut();
			$('body').unbind('click');
		});		
	}
	   
   //remove text from input
   $('input#searchDataSet').focusin(function(ev){
     var value = $(this).attr('value');
     if (value == "Search datasets by name, type, tag...") {
       old_value = value;
       $(this).attr('value','');
     }
   });
   $('input#searchDataSet').focusout(function(ev){
     var value = $(this).attr('value');
     if (value == "") {
       $(this).attr('value',old_value);
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

$(document).ready(function() {
      // SHOW SUB_MENU OPTIONS
   if ($('li.user').length > 0){
      $('li.user').click(function(ev){
         ev.preventDefault();
         ev.stopPropagation();
         
         if (!$(this).hasClass('clicked')){
            $(this).addClass('clicked');   
         }else {
            $(this).removeClass('clicked');
         }
      });
      
      console.log($(this).find('ul.suboptions').width);
      var padding_difference = 0;
      console.log(padding_difference);
      var width_list = $(this).find('ul.suboptions').width;
      console.log(width_list);
      var width_bottom_element = $(this).find('ul.suboptions').find('li.bottom').width;
      console.log(width_bottom_element);
      padding_difference = width_list - width_bottom_element;
      console.log(padding_difference);
      $('ul.suboptions li.bottom').css('padding-right',padding_difference);

   }

	// FONTS	
	Cufon.replace('.calibri', {fontFamily: 'Calibri'});
	Cufon.replace('.calibri_criteria', {fontFamily: 'Calibri',hover: {color: 'white'}});

	
	if (($('div.data_results')!= null)&&($('div.data_results')[0])){
		$('ul.data').jScrollPane();
	}

	if (($('ul.data_scrollable')!= null)&&($('ul.data_scrollable')[0])){
		$('ul.data_scrollable').jScrollPane();
	}
	
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
	
	if ((('a#library_upload_file_combo')!=null) && (('a#library_upload_file_combo')[0])){
		$('a#library_upload_file_combo').click(function(ev){
			ev.stopPropagation();
			ev.preventDefault();
			if (!$(this).parent().hasClass('active')){
				$('div#library_import_url_option').removeClass('active');
				$(this).parent().addClass('active');
			}		
		});		
	}

	if ((('a#library_import_url_combo')!=null) && (('a#library_import_url_combo')[0])){
		$('a#library_import_url_combo').click(function(ev){
			ev.stopPropagation();
			ev.preventDefault();
	
			if (!$(this).parent().hasClass('active')){
				$('div#library_upload_file_option').removeClass('active');
				$(this).parent().addClass('active');
			}		
		});
	}
	
	// UPLOAD JOIN
	if (($('.data_scrollable')!=null)&&($('.data_scrollable')[0])){

		$('ul#your_boundaries_data').find('li').click(function(ev){
			ev.stopPropagation();
			ev.preventDefault();
			
			if (!$(this).hasClass('active')){
				
				// To reset line colour
				$('li.data_list').each(function(index) {
					$(this).css('border-bottom','1px solid #CCCCCC');;
				});
				
				var index = parseInt($(this).index()) - 1;
				
				if (index != -1) {
					$('ul#your_boundaries_data').find('li:eq('+index+')').css('border-bottom','1px solid #666666');
				}
				
				$('ul#your_boundaries_data').find('li.active').removeClass('active');
				$(this).addClass('active');
			}			
		});
		
		$('ul#boundaries_data').find('li').click(function(ev){
			ev.stopPropagation();
			ev.preventDefault();
			
			if (!$(this).hasClass('active')){
				$('ul#boundaries_data').find('li.active').removeClass('active');
				$(this).addClass('active');
			}
		});
	}
	
	if (($('div#content_upload div.choice div.use_existing.active')!=null)&&($('div#content_upload div.choice div.use_existing.active')[0])){
		$('div#content_upload div.choice div.use_existing.active').find('a.combo').click(function(ev){

			$(document).click(function(event) {
				if (!$(event.target).closest('div.suboptions').length) {
					$('div.suboptions').fadeOut();
					$(document).unbind('click');
				};
			});
		});
	}


	if (($('div.description_attributes')!=null)&&($('div.description_attributes')[0])){
		$('a.remove').click(function(ev){
			$(this).parent().css('display','none');
		});
	} 
	
	if (($('ul.checks_options li')!=null)&&($('ul.checks_options li')!=null)){
		$('ul.checks_options li').find('a.check').click(function(ev){
			if (!$(this).hasClass('clicked')){
				$(this).addClass('clicked');
			}else{
				$(this).removeClass('clicked');
			}
		});
	}

	if (($('div.option')!=null)&&($('div.option')!=null)){
		$('div.option').find('a.combo').click(function(ev){
			if (!$(this).parent().parent().hasClass('active')){
				$('div.left.section').find('div.option.active').removeClass('active');
				$(this).parent().parent().addClass('active');
			}
		});
	}
	
	if (($('div.user_access')!=null)&&($('div.user_access')[0])){
		$('div.user_access').find('a.delete').click(function(ev){
			$(this).parent().css('display','none');
		})
	}
	
	if (($('div.choice div.use_existing')!=null)&&($('div.choice div.use_existing')[0])){
		$('div.choice div.use_existing').find('a.combo').click(function(ev){
			if (!$(this).parent().parent().hasClass('active')){
				$('div.choice div.use_existing.active').removeClass('active');
				$(this).parent().parent().addClass('active');
			}
		});
	}

	if (($('div#content_upload')!=null)&&($('div#content_upload')[0])){

		$('input[type="text"]').click(function() {
			var originalValue = this.value;
			this.value='';
			
			$(this).css('color','#666666');
			$(this).css('font','normal 15px Arial');
		});
	}
	
});

function importUrl() {
	$('div#import_url').find('#importButton').addClass('disabled');
	$('div#import_url').find('#importButton').val('Importing...');
	$('div#import_url').find('span.processing').fadeIn('fast');
	$('div#import_url').find('.input_content').css('display','none');
	$('div#import_url').find('a.data_type').css('display','none');
}


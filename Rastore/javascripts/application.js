$(document).ready(function() {
	
	$("#slider").easySlider({
		auto: false, 
		continuous: true,
		numeric: true,
		numericId: 'controls'
	});
	
	// Showing the modal window
	$('#upload_bttn').click(function (e) {
		e.stopPropagation();
		e.preventDefault();
	
  		$('#upload_modal_window').modal();
	
		  return false;
	});
	
	// Autocomplete
	$('#search_taxon_species').focus().autocomplete('http://data.gbif.org/species/nameSearch?maxResults=5&returnType=nameId&view=json',{
				dataType: 'jsonp',
				parse: function(data){
                  var animals = new Array();
                  gbif_data = data;

                  for(var i=0; i<gbif_data.length; i++) {
                    animals[i] = { data: gbif_data[i], value: gbif_data[i].scientificName, result: gbif_data[i].scientificName };
                  }

                  return animals;
				}, 
				formatItem: function(row, i, n, value, term) {							
					var menu_string = '<p style="float:left;width:285px;font:normal 14px Arial;">' + value.replace(new RegExp("(?![^&;]+;)(?!<[^<>]*)(" + term.replace(/([\^\$\(\)\[\]\{\}\*\.\+\?\|\\])/gi, "\\$1") + ")(?![^<>]*>)(?![^&;]+;)", "gi"), "<strong>$1</strong>") + '</p>';
					return menu_string;
	      },		
				width: 238,
				height: 'auto',
				minChars: 4,
				max: 5,
				selectFirst: false,
				loadingClass: 'loader',
				multiple: false,
				scroll: false
			}).result(function(event,row){
				//location.href = '/model/' + row.id + '/' + escape(row.scientificName);
			});
			
	// MODEL COMBO
	
		$('div#program_combo a.program').click(function (e) {
			e.stopPropagation();
			e.preventDefault();
			
			$(this).parent().children('div#activated_list').css('display','inline');

		});
		
		$('div#program_combo div#activated_list a.program_others').click(function (e) {
			e.stopPropagation();
			e.preventDefault();
			
			$(this).parent().fadeOut('fast');

		});
		
	// <div id="program_combo">
	// 		<a class="program">Program</a>
	// 
	// 		<div id="activated_list">
	// 			<a class="program_others"></a>
	// 			<ul>						
	// 				<li><a class="other_program" href="#">Program 1</a></li>
	// 				<div class="line_split"></div>
	// 				<li><a class="other_program" href="#">Program 2</a></li>
	// 				<div class="line_split"></div>
	// 				<li class="last"><a class="other_program" href="#">Program 3</a></li>
	// 			</ul>
	// 		</div>
	// 	</div>
	// 	
	
});
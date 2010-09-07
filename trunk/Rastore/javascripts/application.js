$(document).ready(function() {
	// Showing the modal window
	$('#upload_bttn').click(function (e) {
//		  $('div.ac_results').css('display','inline');
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
	
});
var map;
var tooltip;
var moveStart;
var clickMap;
var tooltip;
var lastMousePoint;
var polys = [];



$(document).ready(function() {
	
	var position_window = $(window).width();
	$('#center_information').css('left',((position_window-698)/2)+'px');
	
	
	
			

	$('a.close_window').click(function(ev){
		ev.stopPropagation();
		ev.preventDefault();
		hideWindow();
	});
	
	
	$('a.explore').click(function(ev){
		ev.stopPropagation();
		ev.preventDefault();
		hideWindow();
	});	
	

});


function init() {
	
		tooltip = document.createElement("div");
		$(tooltip).attr('id','tooltip');
		$(tooltip).html('<h4><a href="#"></a></h4><div class="areas_number"><p></p><label>Protected Areas</label></div><div class="protected"><p></p><label>Protected</label></div><div class="area"><p></p><label>Ocean Area</label></div>');

		map = new GMap2(document.getElementById("home_map"));
		map.disableDoubleClickZoom();
	
		map.setCenter(new GLatLng(27.996162679728116, -30.41015625), 3);
		map.setMapType(G_PHYSICAL_MAP);
	
		
		clickMap = GEvent.addListener(map, "click", function(latlng, index) {
			GEvent.removeListener(clickMap);
			GEvent.removeListener(moveStart);
			hideWindow();
	  });
	
		moveStart = GEvent.addListener(map, "movestart", function(latlng, index) {
			GEvent.removeListener(clickMap);
			GEvent.removeListener(moveStart);
			hideWindow();
	  });
	
	  map.getPane(G_MAP_FLOAT_PANE).appendChild(tooltip);

	  addRegions();


}


function hideWindow() {
	$('div#center_information').fadeOut(function(ev){
		$('div#home_header').fadeIn();
	});
}


function showWindow() {
	
}
var map;
var tooltip;


$(document).ready(function() {

	$('a.close_window').click(function(ev){
		ev.stopPropagation();
		ev.preventDefault();
		hideWindow();
	});
	
});



function init() {
	
	var position_window = $(window).width();
	$('#center_information').css('left',position_window-349-698+'px');

	
	var map = new GMap2(document.getElementById("home_map"));


	map.setCenter(new GLatLng(37.996162679728116, -30.41015625), 4);

	// POLYGON EXAMPLES
  var polygon = new GPolygon([
						new GLatLng(25.774252, -80.190262),
		        new GLatLng(18.466465, -66.118292),
		        new GLatLng(32.321384, -64.75737),
		        new GLatLng(25.774252, -80.190262)
  ], "#f33f00", 1, 1, "#ff0000", 0.2);

  var polygon2 = new GPolygon([
					new GLatLng(37.25319, -7.431854), new GLatLng(37.00889, -7.897779), new GLatLng(37.02631, -8.9892369), 
					new GLatLng(38.71722, -9.118473), new GLatLng(37.70555, -25.45611), new GLatLng(37.88389, -25.85417), 
					new GLatLng(37.70555, -25.45611), new GLatLng(32.6375, -16.94361), new GLatLng(32.6375, -16.94361),new GLatLng(37.25319, -7.431854)
  ], "#f33f00", 1, 1, "#ff0000", 0.2);

  map.addOverlay(polygon);
	map.addOverlay(polygon2);
	
	GEvent.addListener(polygon, "mouseover", function(latlng, index) {
    this.setFillStyle({color:"yellow"});
		var bounds = this.getBounds();
		var polygon_center = bounds.getCenter();
		var position = map.fromLatLngToContainerPixel(polygon_center);
		$('div#tooltip').css('top',position.y-40+'px');
		$('div#tooltip').css('left',position.x+'px');
		$('div#tooltip').show();
  });

	GEvent.addListener(polygon, "mouseout", function(latlng, index) {
		this.setFillStyle({color:"#ff0000"});
		$('div#tooltip').hide();
  });

	GEvent.addListener(polygon2, "mouseover", function(latlng, index) {
    this.setFillStyle({color:"purple"});
		var bounds = this.getBounds();
		var polygon_center = bounds.getCenter();
		var position = map.fromLatLngToContainerPixel(polygon_center);
		$('div#tooltip').css('top',position.y-40+'px');
		$('div#tooltip').css('left',position.x+'px');
		$('div#tooltip').show();
  });

	GEvent.addListener(polygon2, "mouseout", function(latlng, index) {
		this.setFillStyle({color:"#ff0000"});
		$('div#tooltip').hide();
  });

}


function hideWindow() {
	$('div#center_information').fadeOut(function(ev){
		$('div#home_header').fadeIn();
	});
}


function showWindow() {
	
}
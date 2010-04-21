var map;

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
	
	var myOptions = {
    zoom: 3,
    center: new google.maps.LatLng(44.08758502824516, -7.03125),
    disableDefaultUI: true,
		scrollwheel:true,
    mapTypeId: google.maps.MapTypeId.TERRAIN
  }    

  map = new google.maps.Map(document.getElementById("home_map"), myOptions);
}


function hideWindow() {
	$('div#center_information').fadeOut(function(ev){
		$('div#home_header').fadeIn();
	});
}


function showWindow() {
	
}
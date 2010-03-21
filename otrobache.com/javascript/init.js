var map;


$(document).ready(function() {

	var myOptions = {
	  zoom: 11,
	  center: new google.maps.LatLng(40.4166909, -3.7003454),
	  disableDefaultUI: true,
		scrollwheel:false,
	  mapTypeId: google.maps.MapTypeId.ROADMAP
	}
	map = new google.maps.Map(document.getElementById("map"), myOptions);
	
});
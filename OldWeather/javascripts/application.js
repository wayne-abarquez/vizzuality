	
	$(document).ready(function(){ 
		if ($('div#map').is(':visible')) {
			var myLatlng = new google.maps.LatLng(-34.397, 150.644);
		    var myOptions = {
		      zoom: 8,
		      center: myLatlng,
					disableDefaultUI: true,
		      mapTypeId: google.maps.MapTypeId.ROADMAP
		    }
		   var map = new google.maps.Map(document.getElementById("map"), myOptions);
		}

	});
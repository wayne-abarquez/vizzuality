var map;
var marker_manager;
var markers;

$(document).ready(function() {
	
		$('a#zoom_in').click(function(ev){
			ev.stopPropagation();
			ev.preventDefault();
			map.setZoom(map.getZoom()+1);
		});
		
		$('a#zoom_out').click(function(ev){
			ev.stopPropagation();
			ev.preventDefault();
			map.setZoom(map.getZoom()-1);
		});
	
		var myLatlng = new google.maps.LatLng(40.463667, -3.74922);
    var myOptions = {
      zoom: 5,
      center: myLatlng,
		  disableDefaultUI: true,
			scrollwheel:false,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }
    map = new google.maps.Map(document.getElementById("home_map"), myOptions);
		
		$.ajax({
			method: 'GET',
		  url: '/amfphp/json.php/RunnitServices.getAllRuns',
		  success: function(result) {
				var markers = [];
				var bounds = new google.maps.LatLngBounds();
				var data = JSON.parse(result);
				
				
				var image = new google.maps.MarkerImage('/img/markerIcon.png',
				      new google.maps.Size(31, 34),
				      new google.maps.Point(0,0),
				      new google.maps.Point(15, 34));
				
				
				$.each(data, function(key, value) {
					var latLng = new google.maps.LatLng(value.lat,value.lon);
					bounds.extend(latLng);
					var url = value.name.replace(/ /g,'/');
					url = value.id + '/' + url;
					var marker = new google.maps.Marker({
            position: latLng,
						title: value.name,
						icon: image,
						data: url
          });

					google.maps.event.addListener(marker, 'click', function(ev) {
						location.href = '/run/'+this.data;
					});

					markers.push(marker);
				});

		
				
				var markerCluster = new MarkerClusterer(map, markers);


				map.fitBounds(bounds);
				$('#loading_map').fadeOut();
		  }
		});
});




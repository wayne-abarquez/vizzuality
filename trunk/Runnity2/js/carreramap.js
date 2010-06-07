var map;
var marker_manager;
var markers;

$(document).ready(function(){
	var myLatlng = new google.maps.LatLng(40.463667, -3.74922);
  var myOptions = {
    zoom: 5,
    center: myLatlng,
	  disableDefaultUI: true,
		scrollwheel:false,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  }
  map = new google.maps.Map(document.getElementById("race_map"), myOptions);
	var carrera_id = $('#id_carrera').text();
	

	$.ajax({
		method: 'POST',
	  url: '/amfphp/json.php/RunnitServices.getRunsCloseToAnotherForMap/'+ carrera_id,
	  success: function(result) {
			var data = JSON.parse(result);
			console.log(data);

			var markers = [];
			var bounds = new google.maps.LatLngBounds();
			
			var image = new google.maps.MarkerImage('http://localhost:8888/img/markerIcon.png',
			      new google.maps.Size(31, 34),
			      new google.maps.Point(0,0),
			      new google.maps.Point(15, 34));
			var image2 = new google.maps.MarkerImage('http://localhost:8888/img/raceNoActive.png',
			      new google.maps.Size(31, 34),
			      new google.maps.Point(0,0),
			      new google.maps.Point(15, 34));
			

			$.each(data.around, function(key, value) {
				var latLng = new google.maps.LatLng(value.lat,value.lon);
				bounds.extend(latLng);
				var url = value.name.replace(/ /g,'/');
				url = value.id + '/' + url;
				var marker = new google.maps.Marker({
          position: latLng,
					title: value.name,
					icon: image2,
					data: url
        });

				google.maps.event.addListener(marker, 'click', function(ev) {
					location.href = '/run/'+this.data;
				});

				markers.push(marker);
			});
			
			var marker = new google.maps.Marker({
         position: new google.maps.LatLng(data.coords.lat,data.coords.lon),
				icon: image,
				map: map
       });
			bounds.extend(new google.maps.LatLng(data.coords.lat,data.coords.lon));


			var markerCluster = new MarkerClusterer(map, markers);


			map.fitBounds(bounds);
			$('#loading_race').fadeOut();
	  }
	});


});
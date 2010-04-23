var map;


$(document).ready(function() {

	var height_content = $('div.upper_area div.content').height();
	$('a#zoom_in').css('top',height_content + 11 + 'px');
	$('a#zoom_out').css('top',height_content + 11 + 'px');
	$('a#terrain').css('top',height_content + 11 + 'px');
	$('a#satellite').css('top',height_content + 11 + 'px');
	$('a#previous').css('top',height_content + 135 + 'px');
	$('a#next').css('top',height_content + 135 + 'px');
	$('div#data1').css('top',height_content + 262 + 'px');
	$('div#data2').css('top',height_content + 262 + 'px');
	$('div#data3').css('top',height_content + 262 + 'px');
	
	$('a#zoom_in').fadeIn();
	$('a#zoom_out').fadeIn();
	$('a#terrain').fadeIn();
	$('a#satellite').fadeIn();
	$('a#next').fadeIn();
	$('a#previous').fadeIn();
		
	$('a#zoom_in').click(function(ev) {
		ev.stopPropagation();
		ev.preventDefault();
		map.setZoom(map.getZoom()+1);
	});

	$('a#zoom_out').click(function(ev) {
		ev.stopPropagation();
		ev.preventDefault();
		map.setZoom(map.getZoom()-1);
	});

	$('a#satellite').click(function(ev) {
		ev.stopPropagation();
		ev.preventDefault();
		if (!$(this).hasClass('selected')) {
			$('a#terrain').removeClass('selected');
			$('a#satellite').addClass('selected');
			map.setMapTypeId(google.maps.MapTypeId.SATELLITE);
		}
	});

	$('a#terrain').click(function(ev) {
		ev.stopPropagation();
		ev.preventDefault();
		if (!$(this).hasClass('selected')) {
			$('a#satellite').removeClass('selected');
			$('a#terrain').addClass('selected');
			map.setMapTypeId(google.maps.MapTypeId.TERRAIN);
		}
	});
	
	$('a#terrain').addClass('selected');



	var myLatlng = new google.maps.LatLng(-34.397, 150.644);
  var myOptions = {
    zoom: 3,
    center: myLatlng,
		disableDefaultUI: true,
    mapTypeId: google.maps.MapTypeId.TERRAIN
  }
  map = new google.maps.Map(document.getElementById("pa_map"), myOptions);
	
});


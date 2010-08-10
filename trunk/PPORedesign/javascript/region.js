var hawaii;
var cluster;
var reciprocal=0;
var colors={hawaii:""};

$(document).ready(function() {
	
	var map_position = $('div#pa_map').offset();
	$('div#loader_map').css('top',map_position.top + 2 + 'px');

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



	var myLatlng = new google.maps.LatLng(19.808054128088585, -74.35546875);
  var myOptions = {
    zoom: 3,
    center: myLatlng,
		disableDefaultUI: true,
    mapTypeId: google.maps.MapTypeId.TERRAIN,
    scrollwheel: false
  }
  map = new google.maps.Map(document.getElementById("pa_map"), myOptions);



	//Marine overlay
	var marineOverlay=new SparseTileLayerOverlay();
	marineOverlay.setUrl = function SetUrl(xy,z){
		var q=[];
		q[0]= "http://184.73.201.235/geoserver/gwc/service/gmaps?layers=ppe:marine_public_blue&zoom="+z+"&x="+xy.x+"&y="+xy.y;
		return q;
	};
	marineOverlay.setMap(map);
	google.maps.event.addListener(map,"idle",function(){marineOverlay.idle();});



	//Get the region data
	$.ajax({
	  type: "GET",
	  url: 'region.json.txt',
	  dataType: "json",
	  success: function(data) {
		
			console.log(data);
			$("div.relatedBox a div.image").each(function(index,element){
				console.log('slakfja');
				try {									$(element).css('background-image','url(http://maps.google.com/maps/api/staticmap?size=197x124&maptype=terrain&path=fillcolor:0xED671E66|color:0xED671EFF|weight:2|enc:' + escape(data.popular_pas[index].encoding) + '&sensor=false)');			
					$(element).parent().parent().find('img').attr('src',data.popular_pas[index].image);
					$(element).parent().attr('href','region.html?id=' + data.popular_pas[index].id);
					$(element).parent().parent().children('a').attr('href', 'region.html?id=' + data.popular_pas[index].id);
					$(element).parent().parent().find('p.description a').text(data.popular_pas[index].name);
					$(element).parent().parent().find('p.description a').attr('href', 'region.html?id=' + data.popular_pas[index].id);
				} catch (e) {
					$(element).parent().parent().hide();
				}
			});
			
			$('div#data1 p').text(data.area + 'km');
			$('div#data2 p').text(data.per_protected + '%');
			$('div#data2 sup').text('(' + data.position + ')');
			$('div#data3 p').text(data.num_pas);
		
			var geomCoords = new Array();
			for(var i=0; i<data.geometry.length; i++) {
				geomCoords.push(new google.maps.LatLng(data.geometry[i][0],data.geometry[i][1]));
			}
			var world = [
		    new google.maps.LatLng(-89.99,-179.99),
		    new google.maps.LatLng(89.99, -179.99),
		    new google.maps.LatLng(89.99,179.99),
		    new google.maps.LatLng(-89.99,179.99),
		    new google.maps.LatLng(-89.99,0)
		  ];			
		  var region = new google.maps.Polygon({
		    paths: [world, geomCoords],
		    strokeColor: "#000000",
		    strokeOpacity: 0.5,
		    strokeWeight: 0.1,
		    fillColor: "#000000",
		    fillOpacity: 0.5
		  });
		  var region_border = new google.maps.Polyline({
	      path: geomCoords,
	      strokeColor: "#FF9900",
	      strokeOpacity: 1.0,
	      strokeWeight: 4
		  });		
		  region.setMap(map);
		  region_border.setMap(map);
		
			$('div#loader_map').fadeOut();
		}
	  });
	


});



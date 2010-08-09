var hawaii;
var cluster;
var reciprocal=0;
var colors={hawaii:""};

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



	var myLatlng = new google.maps.LatLng(19.808054128088585, -74.35546875);
  var myOptions = {
    zoom: 3,
    center: myLatlng,
		disableDefaultUI: true,
    mapTypeId: google.maps.MapTypeId.TERRAIN
  }
  map = new google.maps.Map(document.getElementById("pa_map"), myOptions);




	//Get the region data
	$.ajax({
	  type: "GET",
	  url: 'region.json.txt',
	  dataType: "json",
	  success: function(data) {
			var geomCoords = new Array() ;
			for(var co in data.geometry) {
				geomCoords.push(new google.maps.LatLng(co[0],co[1]));
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
		}
	  });
	





	// cluster=new PolyCluster();
	// 	cluster.setMap(hawaii);
	// 	google.maps.event.addListener(hawaii,"idle",function(){cluster.repair();});
	// 	q=document.getElementById("_");
	// 	if (q) 
	// 		document.body.removeChild(q);
	// 	
	// 	q=document.createElement("SCRIPT");
	// 
	// 	if (q) 
	// 		document.body.appendChild(q);
	// 		
	// 	q.src="http://home.provide.net/~bratliff/polycluster/pack/hawaii.set";
	// 	q.id="_";

});



		function PolyClusterFile(call,file) {
			var q;
			cluster.load(call);
			for (q in call) setTimeout('setColor("'+q+'","#000000")',0);
		}
 
		function setColor(a,c) {
			if (c==colors[a]) {
				colors[a]="";
				cluster.setColor(a,0);
			} else {
				colors[a]=c;
				cluster.setColor(a,{fill:1,stroke:1,fillColor:colors[a],strokeColor:colors[a],fillAlpha:0.4,strokeAlpha:1.0,weight:1});
			}
			Reciprocal(a,1);
		}
 
		function Reciprocal(a,c) {
			reciprocal^=c;
			cluster.reciprocal(reciprocal ? {fill:1,fillColor:colors[a],fillAlpha:0.4,stroke:0,strokeColor:colors[a],strokeAlpha:0.4,weight:0} : 0);
		}

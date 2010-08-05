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

		var everythingElse = [
	    new google.maps.LatLng(-89.99,-179.99),
	    new google.maps.LatLng(89.99, -179.99),
	    new google.maps.LatLng(89.99,179.99),
	    new google.maps.LatLng(-89.99,179.99),
	    new google.maps.LatLng(-89.99,0)
	  ];



	  var caribeanCoords = [
	
		new google.maps.LatLng(29.6880527498568,-94.130859375),
		new google.maps.LatLng(28.613459424004414,-95.9765625),
		new google.maps.LatLng(28.381735043223106,-97.03125),
		new google.maps.LatLng(27.137368359795584,-97.119140625),
		new google.maps.LatLng(25.3241665257384,-97.294921875),
		new google.maps.LatLng(22.512556954051437,-97.822265625),
		new google.maps.LatLng(18.895892559415024,-96.15234375),
		new google.maps.LatLng(18.47960905583197,-94.5703125),
		new google.maps.LatLng(18.56294744288831,-91.845703125),
		new google.maps.LatLng(20.715015145512098,-90.439453125),
		new google.maps.LatLng(21.69826549685252,-88.681640625),
		new google.maps.LatLng(21.53484700204879,-87.01171875),
		new google.maps.LatLng(20.3034175184893,-87.099609375),
		new google.maps.LatLng(18.895892559415024,-87.451171875),
		new google.maps.LatLng(17.22475820662464,-88.154296875),
		new google.maps.LatLng(15.707662769583505,-88.76953125),
		new google.maps.LatLng(15.707662769583505,-86.484375),
		new google.maps.LatLng(15.961329081596647,-84.814453125),
		new google.maps.LatLng(14.859850400601049,-83.583984375),
		new google.maps.LatLng(12.983147716796578,-83.49609375),
		new google.maps.LatLng(11.43695521614319,-83.759765625),
		new google.maps.LatLng(10.31491928581316,-83.056640625),
		new google.maps.LatLng(9.102096738726456,-81.73828125),
		new google.maps.LatLng(9.102096738726456,-80.33203125),
		new google.maps.LatLng(9.362352822055605,-79.1015625),
		new google.maps.LatLng(8.928487062665504,-77.431640625),
		new google.maps.LatLng(9.188870084473406,-75.9375),
		new google.maps.LatLng(11.005904459659464,-74.794921875),
		new google.maps.LatLng(11.523087506868512,-73.037109375),
		new google.maps.LatLng(12.297068292853817,-71.630859375),
		new google.maps.LatLng(11.86735091145932,-70.83984375),
		new google.maps.LatLng(11.092165893502,-71.54296875),
		new google.maps.LatLng(11.43695521614319,-69.521484375),
		new google.maps.LatLng(10.919617760254697,-68.291015625),
		new google.maps.LatLng(10.660607953624774,-66.708984375),
		new google.maps.LatLng(10.746969318460001,-63.369140625),
		new google.maps.LatLng(8.754794702435618,-60.46875),
		new google.maps.LatLng(6.053161295714067,-56.25),
		new google.maps.LatLng(5.878332109674327,-53.876953125),
		new google.maps.LatLng(4.740675384778373,-51.6796875),
		new google.maps.LatLng(4.390228926463396,-50.80078125),
		new google.maps.LatLng(4.477856485570586,-34.365234375),
		new google.maps.LatLng(19.31114335506464,-43.2421875),
		new google.maps.LatLng(35.17380831799959,-76.025390625),
		new google.maps.LatLng(34.74161249883172,-77.255859375),
		new google.maps.LatLng(33.87041555094183,-77.87109375),
		new google.maps.LatLng(33.578014746143985,-78.92578125),
		new google.maps.LatLng(32.91648534731439,-79.8046875),
		new google.maps.LatLng(32.62087018318113,-80.595703125),
		new google.maps.LatLng(31.20340495091737,-81.474609375),
		new google.maps.LatLng(27.21555620902969,-80.419921875),
		new google.maps.LatLng(25.562265014427517,-80.244140625),
		new google.maps.LatLng(24.686952411999155,-80.5078125),
		new google.maps.LatLng(25.958044673317843,-81.298828125),
		new google.maps.LatLng(26.980828590472107,-82.353515625),
		new google.maps.LatLng(27.916766641249062,-82.79296875),
		new google.maps.LatLng(29.22889003019423,-82.705078125),
		new google.maps.LatLng(30.372875188118016,-84.19921875),
		new google.maps.LatLng(29.53522956294847,-84.814453125),
		new google.maps.LatLng(30.44867367928756,-85.95703125),
		new google.maps.LatLng(30.372875188118016,-87.451171875),
		new google.maps.LatLng(30.29701788337205,-89.033203125),
		new google.maps.LatLng(29.6880527498568,-89.736328125),
		new google.maps.LatLng(29.075375179558346,-90.703125),
		new google.maps.LatLng(29.53522956294847,-91.93359375),
		new google.maps.LatLng(29.6880527498568,-94.130859375)
	  ];


	  var caribean_sea = new google.maps.Polygon({
	    paths: [everythingElse, caribeanCoords],
	    strokeColor: "#000000",
	    strokeOpacity: 0.5,
	    strokeWeight: 0.1,
	    fillColor: "#000000",
	    fillOpacity: 0.5
	  });
	
	  var caribean_sea_border = new google.maps.Polyline({
      path: caribeanCoords,
      strokeColor: "#FF9900",
      strokeOpacity: 1.0,
      strokeWeight: 4
	  });
	

	  caribean_sea.setMap(map);
		caribean_sea_border.setMap(map);



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

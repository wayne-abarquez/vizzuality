var $j = jQuery;
var map;

$(document).ready(function() {
	
	
  var myOptions = {
      zoom: 4,
      center: new google.maps.LatLng(25, 25),
      disableDefaultUI: true,
      scrollwheel:false,
      mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  map = new google.maps.Map(document.getElementById("map"), myOptions);

	// Initialize Fluster and give it a existing map
	var fluster = new Fluster2(map);
	var image = '../images/markers/small.png';
	
	for(var i = 0; i < 200; i++)
	{
		var pos = [
			50 * Math.random(),
			50 * Math.random()
		];
		
		// Create a new marker. Don't add it to the map!
		var marker = new google.maps.Marker({
			position: new google.maps.LatLng(pos[0], pos[1]),
			title: 'Marker ' + i,
			icon: image
		});
		
		// Add the marker to the Fluster
		fluster.addMarker(marker);
	}
	
	// Set styles
	// These are the same styles as default, assignment is only for demonstration ...
	fluster.styles = {
		0: {
			image: '../images/markers/medium.png',
			textColor: '#FFFFFF',
			width: 48,
			height: 48
		},
		6: {
			image: '../images/markers/big.png',
			textColor: '#FFFFFF',
			width: 58,
			height: 58
		}
	};
	
	// Initialize Fluster
	// This will set event handlers on the map and calculate clusters the first time.
	fluster.initialize();





	//OBRA LENGTH
	var left_work = $('div.left_region_work').height();
	var right_work = $('div.renovation_content').height();

	if (left_work<right_work) {
			$('div.left_region_work').height(right_work-279);
	} else {
		 	$('div.renovation_content').height(left_work+279);
	}


	//MUNICIPIO LENGTH
	var left_lenght = $('div#layout div.left_region').innerHeight()-226;
	var right_lenght = $('div#layout div.right_region').innerHeight();
	if (left_lenght<right_lenght) {
		if ($.browser.mozilla) {
		    $('div.left_region').height(right_lenght + 189);
		 } else {
				$('div.left_region').height(right_lenght + 261);
		}
	} else {
		if ($.browser.mozilla) {
		    $('div.right_region').height(left_lenght-122);
		 } else {
				$('div.right_region').height(left_lenght+208);
		}
	}
	
	
	//CHARTS
	
	//home
	var colors =["#CACA4E", "#bcbc5f", "#CACA4E"];
	$('.expensive_chart').sparkline([4,3,5,7,9], {type:'bar', fillColor: '#666666', width:'80px', height:'30px', barColor:'#ADAEAC', barWidth:15, barSpacing:1, chartRangeMin:0 });
	$('.expensive_chart2').sparkline([4,3,5,7,9], {type:'bar', fillColor: '#666666', width:'85px', height:'30px', barColor:'#ADAEAC', barWidth:16, barSpacing:1, chartRangeMin:0 });
	$('.big_chart').sparkline([6,10,14], {type:'bar', fillColor: '#666666', width:'274px', height:'80px', barColor:'#ADAEAC', barWidth:90, barSpacing:1, chartRangeMin:0, colorMap: colors });



	$('div.content_right a span.kind_contrat').hover(function(ev){
		ev.stopPropagation();
		ev.preventDefault();
		
		$(this).parent().parent().children('div.tool_tip').show();
		
	},
	function(){
		$(this).parent().parent().children('div.tool_tip').fadeOut();
		
	});

});


	


$j(function(){
	$j("input[name=search]").prompt("Busca tu municipio...");
});


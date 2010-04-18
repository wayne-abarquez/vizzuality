var $j = jQuery;
var map;

$(document).ready(function() {
	
	// VER MAPA
	$('#ve_mapa').click (function(ev){
		ev.stopPropagation();
		ev.preventDefault();
		$.scrollTo('#mapa',500);
	});
	
	// ABOUT
	$('#ve_queesgastoPublico').click (function(ev){
		ev.stopPropagation();
		ev.preventDefault();
		$.scrollTo('#queesgastopublico',500);
	});

	$('#ve_comonace').click (function(ev){
		ev.stopPropagation();
		ev.preventDefault();
		$.scrollTo('#comonace',500);
	});

	$('#ve_quienesta').click (function(ev){
		ev.stopPropagation();
		ev.preventDefault();
		$.scrollTo('#quienesta',500);
	});
	
	$('#back_about').click (function(ev){
		ev.stopPropagation();
		ev.preventDefault();
		$.scrollTo('.outer_layout_gray',500);
	});
	
	

  var myOptions = {
      zoom: 4,
      center: new google.maps.LatLng(25, 25),
      disableDefaultUI: true,
      scrollwheel:false,
      mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  map = new google.maps.Map(document.getElementById("mapa"), myOptions);
	var image = '../images/markers/small.png';

	if (!$('span.location').length>0) {
		var position = new google.maps.LatLng($('span.lat').attr('id'),$('span.lon').attr('id'));
		map.setCenter(position);
		map.setZoom(12);
		
		var marker = new google.maps.Marker({
					position: position,
					title: '',
					icon: image
				});
		marker.setMap(map);
		map.panBy(-200,-10);
	} else {
		var position = new google.maps.LatLng($('span.lat').attr('id'),$('span.lon').attr('id'));
		map.setCenter(position);
		map.setZoom(12);
		
		map.panBy(-200,-10);	    
	}

	// var fluster = new Fluster2(map);
	// 	var image = '../images/markers/small.png';
	// 	
	// 	for(var i = 0; i < 200; i++)
	// 	{
	// 		var pos = [
	// 			50 * Math.random(),
	// 			50 * Math.random()
	// 		];
	// 		
	// 		var marker = new google.maps.Marker({
	// 			position: new google.maps.LatLng(pos[0], pos[1]),
	// 			title: 'Marker ' + i,
	// 			icon: image
	// 		});
	// 		
	// 		// Add the marker to the Fluster
	// 		fluster.addMarker(marker);
	// 	}
	// 
	// 	fluster.styles = {
	// 		0: {
	// 			image: '../images/markers/medium.png',
	// 			textColor: '#FFFFFF',
	// 			width: 48,
	// 			height: 48
	// 		},
	// 		6: {
	// 			image: '../images/markers/big.png',
	// 			textColor: '#FFFFFF',
	// 			width: 58,
	// 			height: 58
	// 		}
	// 	};
	// 
	// 	fluster.initialize();





	// OBRA LENGTH
	var left_work = $('div.left_region_work').height();
	var right_work = $('div.renovation_content').height()-388;
	
	if (left_work<right_work) {
			$('div.left_region_work').height(right_work+20);
	} else {
		 	$('div.renovation_content').height(left_work+389);
	}
	

	//ORGANISMO LENGTH
	var left_lenght = $('div#layout div.left_region').innerHeight()-226;
	var right_lenght = $('div#layout div.right_region').innerHeight();
	
	if (left_lenght<right_lenght) { 
		$('div.left_region').height(right_lenght + 189);
	} else {	
		$('div.right_region').height(left_lenght + 77);
	}
	

	//MUNICIPIO LENGTH
	var left_mun_lenght = $('div.left_region_mun').height()-226;
	var right_mun_lenght = $('div.right_region_mun').height();

	if (left_mun_lenght<right_mun_lenght) { 
		$('div.left_region_mun').height(right_mun_lenght + 269);
	} else {
		$('div.right_region_mun').height(left_mun_lenght + 118);
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
	
	//VOTES ACTION
	$('a.likes').click(function(ev){
		ev.stopPropagation();
		ev.preventDefault();
		var licitacion = $(this).parent().attr('alt');
		var this_ = this;
		var dataObj = ({method: 'vote_up', licitacion: licitacion});    
		$.ajax({
		    	type: "POST",
		    	url: "../ajaxController.php",
		    	data: dataObj,
		    	cache: false,
		    	success: function(result){
						var count = parseInt($(this_).html());
						$(this_).html(count+1);
		    	},
		      error:function (xhr, ajaxOptions, thrownError){
	        	alert('GastoPublico' + xhr.status + "\n" + thrownError);
	        }
		 });
	});
	
	$('a.no_likes').click(function(ev){
		ev.stopPropagation();
		ev.preventDefault();
		var licitacion = $(this).parent().attr('alt');
		var this_ = this;
		var dataObj = ({method: 'vote_down', licitacion: licitacion});    
		$.ajax({
		    	type: "POST",
		    	url: "../ajaxController.php",
		    	data: dataObj,
		    	cache: false,
		    	success: function(result){
						var count = parseInt($(this_).html());
						$(this_).html(count+1);
		    	},
		      error:function (xhr, ajaxOptions, thrownError){
	        	alert('GastoPublico' + xhr.status + "\n" + thrownError);
	        }
		 });
	});
	
	//CREATE COMMENT
	
	
	
	

});


	


$j(function(){
	$j("input[name=search]").prompt("Busca tu municipio...");
	$j("input[name=bigSearch]").prompt("Busca tu municipio...");
});


/* VARIABLES */
var map;
var protected_layer;
var carbon_layer;
var kba_layer;
var cluster1;
var cluster2;
var white_markers= [];
var yellow_markers=[];
var white_style = new Object();
var yellow_style = new Object();
var lastMask = 10000;

var e1 = true;
var e2 = true;
var e3 = true;
var e4 = true;
var e5 = true;

var ppe_infowindow;
var ppe_layer = false;

function initialize() {
		var center = new google.maps.LatLng(42.68243539838623, -37.08984375);
 
		map = new google.maps.Map(document.getElementById('map'), {
			zoom: 3,
			center: center,
			mapTypeControl:false,
			navigationControl:false,
			mapTypeId: google.maps.MapTypeId.TERRAIN
		});
		

		/*yellow style*/
		var yellow_array = []
		
		var obj_yellow = new Object();
		obj_yellow.height = 32;
		obj_yellow.width = 32;
		obj_yellow.opt_textColor = 'white';
		obj_yellow.url = 'images/markers/22_yellow.png';
		yellow_array.push(obj_yellow);
		
		var obj_yellow_2 = new Object();
		obj_yellow_2.height = 40;
		obj_yellow_2.width = 40;
		obj_yellow_2.opt_textColor = 'white';
		obj_yellow_2.url = 'images/markers/30_yellow.png';
		yellow_array.push(obj_yellow_2);
		
		yellow_style.styles = yellow_array;
		yellow_style.gridSize = 60;
		yellow_style.zoom = null;
		
		
		/*white style*/
		var white_array = []
		
		var obj_white = new Object();
		obj_white.height = 32;
		obj_white.width = 32;
		obj_white.opt_textColor = '#5099B4';
		obj_white.url = 'images/markers/22_white.png';
		white_array.push(obj_white);
		
		var obj_white_2 = new Object();
		obj_white_2.height = 40;
		obj_white_2.width = 40;
		obj_white_2.opt_textColor = '#5099B4';
		obj_white_2.url = 'images/markers/30_white.png';
		white_array.push(obj_white_2);
		
		white_style.styles = white_array;
		white_style.gridSize = 60;
		white_style.zoom = null;
 

		
		bounds = new google.maps.LatLngBounds();
		
		
		carbon_layer=new SparseTileLayerOverlay();
		    carbon_layer.setUrl = function SetUrl(xy,z){
		    	var u=[];
		    	u[0]= 'http://development3.unep-wcmc.org/ArcGIS/rest/services/LifeWeb/Carbon_webmerc/MapServer/tile/'+z+'/'+xy.y+'/'+xy.x;
		    	return u;
		    };
		carbon_layer.setMap(map);
		carbon_layer.setStyle(0,{alpha:0.5});
		
		kba_layer=new SparseTileLayerOverlay();
		    kba_layer.setUrl = function SetUrl(xy,z){
		    	var u=[];
		    	u[0]= 'http://development3.unep-wcmc.org/ArcGIS/rest/services/LifeWeb/KBA/MapServer/tile/'+z+'/'+xy.y+'/'+xy.x;
		    	return u;
		    };
		kba_layer.setMap(null);
		kba_layer.setStyle(0,{alpha:0});
		
		protected_layer=new SparseTileLayerOverlay();
		    protected_layer.setUrl = function SetUrl(xy,z){
		    	var q=[];
		    	q[0]= 'http://184.73.201.235/blue/'+z+'/'+xy.x+'/'+xy.y;
		    	return q;
		    };
		protected_layer.setMap(null);
		protected_layer.setStyle(0,{alpha:0});
		
		
		
   
		$.ajax({
		  url: 'http://lifeweb.heroku.com/projects',
		  dataType: 'jsonp',
		  data: null,
		  success: function(result) {
			
					$.each(result, function(key, value) {
						bounds.extend (new google.maps.LatLng(value.lat,value.lon));
						if (value.matched) {
							var marker = new White_Marker(new google.maps.LatLng(value.lat, value.lon),value,map);
							white_markers.push(marker);
						} else {
							var marker = new Yellow_Marker(new google.maps.LatLng(value.lat, value.lon),value,map); 
							yellow_markers.push(marker);
						}
						marker.setMap(map);
					});

				
				
					map.fitBounds (bounds);
			  	map.setCenter( bounds.getCenter());

			
			 		// $.each(result, function(key, value) {
			 		// 						bounds.extend (new google.maps.LatLng(value.lat,value.lon));
			 		// 						if (value.matched) {
			 		// 							var marker = new White_Marker(new google.maps.LatLng(value.lat, value.lon),value,map); 
			 		// 							white_markers.push(marker);
			 		// 						} else {
			 		// 							var marker = new Yellow_Marker(new google.maps.LatLng(value.lat, value.lon),value,map); 
			 		// 							yellow_markers.push(marker);
			 		// 						}
			 		// 					});
			 		// 
			 		// 					
			 		// 					
			 		// 					map.fitBounds (bounds);
			 		// 			  	map.setCenter( bounds.getCenter());
			 		// 						
			 		// 					cluster1 = new MarkerClusterer(map, white_markers,white_style);
			 		// 					cluster2 = new MarkerClusterer(map, yellow_markers,yellow_style);
			 		// 					
			 		// 					ppe_infowindow = new PPE_Infowindow(new google.maps.LatLng(0,0), null, map);

			
			 }
		});
		
		google.maps.event.addListener(map, 'center_changed', function(ev){ 
				
				if ($('div.layers_overlay div').hasClass('clicked')){
					$('div.layers_overlay').children('div.list').fadeOut();
					$('div.layers_overlay div').removeClass('clicked');
					$('div.layers_overlay div').addClass('unclicked');						
				}
				
				if ($('div.filter_markers div').hasClass('clicked')){
					$('div.filter_markers').children('div.list').fadeOut();
					$('div.filter_markers div').removeClass('clicked');
					$('div.filter_markers div').addClass('unclicked');						
				}
								
			}
		);
		
		google.maps.event.addListener(map, 'click', function(ev){ 
				// console.log(ev);
				if (ppe_layer) {
					$.ajax({
					  url: 'http://www.protectedplanet.net/api2/sites?lat='+ev.latLng.b+'&lng='+ev.latLng.c,
					  dataType: 'jsonp',
					  data: null,
					  success: function(result) {
						 		console.log(result);

						 }
					});
				}
								
			}
		);
		
	  // var pixPosition = this.getProjection().fromLatLngToDivPixel(latlng);
	  // if (!pixPosition) return;
	  // 
	  // ppe_infowindow.style.left = (pixPosition.x) + "px";
	  // ppe_infowindow.style.top = (pixPosition.y) + "px";
		
}

$(document).ready(function() {
		
	$('a.filter_markers_legend_button').click(function(ev){
		ev.stopPropagation();
		ev.preventDefault();
		if ($(this).parent().parent().hasClass('unclicked')){
			$(this).parent().parent().parent().children('div.clicked').fadeIn();
		} else {
			$(this).parent().parent().parent().children('div.clicked').fadeOut();				
		}
	});

	
	$('#matches').click(function(ev){
		ev.stopPropagation();
		ev.preventDefault();
		if ($(this).children('p').hasClass('enabled')) {
			$(this).children('p').removeClass('enabled');
			$(this).children('p').addClass('disabled');		
			cleanWhiteMarkers();
		} else {
			$(this).children('p').removeClass('disabled');
			$(this).children('p').addClass('enabled');
			showWhiteClusters();
		}
	});
	
	
	$('#potential').click(function(ev){
		ev.stopPropagation();
		ev.preventDefault();
		if ($(this).children('p').hasClass('enabled')) {
			$(this).children('p').removeClass('enabled');
			$(this).children('p').addClass('disabled');		
			cleanYellowMarkers();
		} else {
			$(this).children('p').removeClass('disabled');
			$(this).children('p').addClass('enabled');	
			showYellowClusters();
		}
	});
	
	
	$('#carbon_layer').click(function(ev){
		ev.stopPropagation();
		ev.preventDefault();
		if ($(this).parent().hasClass('checked')) {
			$(this).parent().removeClass('checked');
			$(this).parent().addClass('unchecked');		
			carbon_layer.setStyle(0,{alpha:0});
		} else {
			$(this).parent().removeClass('unchecked');
			$(this).parent().addClass('checked');	
			carbon_layer.setStyle(0,{alpha:.5});		
		}
	});
	
	$('#protected_layer').click(function(ev){
		ev.stopPropagation();
		ev.preventDefault();
		if ($(this).parent().hasClass('checked')) {
			$(this).parent().removeClass('checked');
			$(this).parent().addClass('unchecked');
			protected_layer.setMap(map);
			protected_layer.setStyle(0,{alpha:0});
			ppe_layer = false;		
		} else {
			$(this).parent().removeClass('unchecked');
			$(this).parent().addClass('checked');
			protected_layer.setMap(map);
			protected_layer.setStyle(0,{alpha:.5});	
			ppe_layer = true;	
		}
	});
	
	$('#kba_layer').click(function(ev){
		ev.stopPropagation();
		ev.preventDefault();
		if ($(this).parent().hasClass('checked')) {
			$(this).parent().removeClass('checked');
			$(this).parent().addClass('unchecked');
			kba_layer.setStyle(0,{alpha:0});
		} else {
			$(this).parent().removeClass('unchecked');
			$(this).parent().addClass('checked');
			kba_layer.setMap(map);
			kba_layer.setStyle(0,{alpha:.5});	
		}
	});
	
	
	$('#climate').click(function(ev){
		ev.stopPropagation();
		ev.preventDefault();
		if ($(this).parent().hasClass('checked')) {
			$(this).parent().removeClass('checked');
			$(this).parent().addClass('unchecked');
			e1 = false;
			if ($('#matches').children('p').hasClass('enabled')) showWhiteClusters();
			if ($('#potential').children('p').hasClass('enabled')) showYellowClusters();
		} else {
			$(this).parent().removeClass('unchecked');
			$(this).parent().addClass('checked');
			e1 = true;
			if ($('#matches').children('p').hasClass('enabled')) showWhiteClusters();
			if ($('#potential').children('p').hasClass('enabled')) showYellowClusters();
		}
	});
	
	
	$('#freshwater').click(function(ev){
		ev.stopPropagation();
		ev.preventDefault();
		if ($(this).parent().hasClass('checked')) {
			$(this).parent().removeClass('checked');
			$(this).parent().addClass('unchecked');
			e2 = false;
			if ($('#matches').children('p').hasClass('enabled')) showWhiteClusters();
			if ($('#potential').children('p').hasClass('enabled')) showYellowClusters();
		} else {
			$(this).parent().removeClass('unchecked');
			$(this).parent().addClass('checked');
			e2 = true;
			if ($('#matches').children('p').hasClass('enabled')) showWhiteClusters();
			if ($('#potential').children('p').hasClass('enabled')) showYellowClusters();
		}
	});
	
	
	$('#food').click(function(ev){
		ev.stopPropagation();
		ev.preventDefault();
		if ($(this).parent().hasClass('checked')) {
			$(this).parent().removeClass('checked');
			$(this).parent().addClass('unchecked');
			e3 = false;
			if ($('#matches').children('p').hasClass('enabled')) showWhiteClusters();
			if ($('#potential').children('p').hasClass('enabled')) showYellowClusters();
		} else {
			$(this).parent().removeClass('unchecked');
			$(this).parent().addClass('checked');
			e3 = true;
			if ($('#matches').children('p').hasClass('enabled')) showWhiteClusters();
			if ($('#potential').children('p').hasClass('enabled')) showYellowClusters();
		}
	});
	

	$('#potential_pro').click(function(ev){
		ev.stopPropagation();
		ev.preventDefault();
		if ($(this).parent().hasClass('checked')) {
			$(this).parent().removeClass('checked');
			$(this).parent().addClass('unchecked');
			e4 = false;
			if ($('#matches').children('p').hasClass('enabled')) showWhiteClusters();
			if ($('#potential').children('p').hasClass('enabled')) showYellowClusters();
		} else {
			$(this).parent().removeClass('unchecked');
			$(this).parent().addClass('checked');
			e4 = true;
			if ($('#matches').children('p').hasClass('enabled')) showWhiteClusters();
			if ($('#potential').children('p').hasClass('enabled')) showYellowClusters();
		}
	});


	$('#cultural').click(function(ev){
		ev.stopPropagation();
		ev.preventDefault();
		if ($(this).parent().hasClass('checked')) {
			$(this).parent().removeClass('checked');
			$(this).parent().addClass('unchecked');
			e5 = false;
			if ($('#matches').children('p').hasClass('enabled')) showWhiteClusters();
			if ($('#potential').children('p').hasClass('enabled')) showYellowClusters();	
		} else {
			$(this).parent().removeClass('unchecked');
			$(this).parent().addClass('checked');
			e5 = true;
			if ($('#matches').children('p').hasClass('enabled')) showWhiteClusters();
			if ($('#potential').children('p').hasClass('enabled')) showYellowClusters();
		}
	});


	$('div.bttn_zoomIn').click(function(ev){map.setZoom(map.getZoom()+1)});
	$('div.bttn_zoomOut').click(function(ev){map.setZoom(map.getZoom()-1)});
	
	
});


// function showWhiteClusters() {
// 	cluster1.clearMarkers();
// 	var new_white_markers = [];
// 	for (var i=0; i<white_markers.length;i++) {
// 		if ((e1 && white_markers[i].information_.ecosystem_service.e1) || (e2 && white_markers[i].information_.ecosystem_service.e2) || (e3 && white_markers[i].information_.ecosystem_service.e3) || (e4 && white_markers[i].information_.ecosystem_service.e4) || (e5 && white_markers[i].information_.ecosystem_service.e5)) {
// 			new_white_markers.push(white_markers[i]);
// 		}
// 	}
// 	cluster1 = new MarkerClusterer(map, new_white_markers,white_style);
// }
// 
// 
// function showYellowClusters() {
// 	cluster2.clearMarkers();
// 	var new_yellow_markers = [];
// 	for (var i=0; i<yellow_markers.length;i++) {
// 		if ((e1 && yellow_markers[i].information_.ecosystem_service.e1) || (e2 && yellow_markers[i].information_.ecosystem_service.e2) || (e3 && yellow_markers[i].information_.ecosystem_service.e3) || (e4 && yellow_markers[i].information_.ecosystem_service.e4) || (e5 && yellow_markers[i].information_.ecosystem_service.e5)) {
// 			new_yellow_markers.push(yellow_markers[i]);
// 		}
// 	}
// 	cluster2 = new MarkerClusterer(map, new_yellow_markers,yellow_style);
// }


function showWhiteClusters() {
	for (var i=0; i<white_markers.length;i++) {
		if ((e1 && white_markers[i].information_.ecosystem_service.e1) || (e2 && white_markers[i].information_.ecosystem_service.e2) || (e3 && white_markers[i].information_.ecosystem_service.e3) || (e4 && white_markers[i].information_.ecosystem_service.e4) || (e5 && white_markers[i].information_.ecosystem_service.e5)) {
			white_markers[i].setMap(map);
		} else {
			white_markers[i].setMap(null);
		}
	}
	
}


function showYellowClusters() {
	for (var i=0; i<yellow_markers.length;i++) {
		if ((e1 && yellow_markers[i].information_.ecosystem_service.e1) || (e2 && yellow_markers[i].information_.ecosystem_service.e2) || (e3 && yellow_markers[i].information_.ecosystem_service.e3) || (e4 && yellow_markers[i].information_.ecosystem_service.e4) || (e5 && yellow_markers[i].information_.ecosystem_service.e5)) {
			yellow_markers[i].setMap(map);
		}else {
			yellow_markers[i].setMap(null);
		}
	}
}


function cleanYellowMarkers() {
	for (var i=0; i<yellow_markers.length;i++) {
			yellow_markers[i].setMap(null);
	}
}

function cleanWhiteMarkers() {
	for (var i=0; i<white_markers.length;i++) {
			white_markers[i].setMap(null);
	}
}





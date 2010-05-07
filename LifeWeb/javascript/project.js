/* VARIABLES */
var map;
var protected_layer;
var carbon_layer;
var kba_layer;
var lastMask = 10000;

var e1 = true;
var e2 = true;
var e3 = true;
var e4 = true;
var e5 = true;

var ppe_infowindow;
var ppe_layer = false;

function initialize(lat,lng) {
		var center = new google.maps.LatLng(lat, lng);
 
		map = new google.maps.Map(document.getElementById('map'), {
			zoom: 6,
			center: center,
			mapTypeControl:false,
			navigationControl:false,
			mapTypeId: google.maps.MapTypeId.TERRAIN
		});
		

		carbon_layer=new SparseTileLayerOverlay();
		    carbon_layer.setUrl = function SetUrl(xy,z){
		    	var u=[];
		    	u[0]= 'http://development3.unep-wcmc.org/ArcGIS/rest/services/LifeWeb/Carbon_webmerc/MapServer/tile/'+z+'/'+xy.y+'/'+xy.x;
		    	return u;
		    };
		carbon_layer.setMap(map);
		
		protected_layer=new SparseTileLayerOverlay();
		    protected_layer.setUrl = function SetUrl(xy,z){
		    	var q=[];
		    	q[0]= 'http://184.73.201.235/blue/'+z+'/'+xy.x+'/'+xy.y;
		    	return q;
		    };
		protected_layer.setMap(null);
		protected_layer.setStyle(0,{alpha:0});
		
		kba_layer=new SparseTileLayerOverlay();
		    kba_layer.setUrl = function SetUrl(xy,z){
		    	var u=[];
		    	u[0]= 'http://development3.unep-wcmc.org/ArcGIS/rest/services/LifeWeb/KBA/MapServer/tile/'+z+'/'+xy.y+'/'+xy.x;
		    	return u;
		    };
		kba_layer.setMap(null);
		kba_layer.setStyle(0,{alpha:0});
		
   
		$.ajax({
		  url: 'http://lifeweb.heroku.com/projects',
		  dataType: 'jsonp',
		  data: null,
		  success: function(result) {
			 		$.each(result, function(key, value) {
						if (value.matched) {
							var marker = new White_Marker(new google.maps.LatLng(value.lat, value.lon),value,map); 
						} else {
							var marker = new Yellow_Marker(new google.maps.LatLng(value.lat, value.lon),value,map); 
						}
						marker.setMap(map);
					});
					
					ppe_infowindow = new PPE_Infowindow(new google.maps.LatLng(0,0), null, map);
					ppe_infowindow.setMap(null);
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
		
}

$(document).ready(function() {
		
	$('div.filterButtons div a').click(function(ev){
		ev.stopPropagation();
		ev.preventDefault();
		
		if ($(this).parent().hasClass('unclicked')){
			$(this).parent().parent().children('div.list').show();
			$(this).parent().removeClass('unclicked');
			$(this).parent().addClass('clicked');			
		}
		else {
			$(this).parent().parent().children('div.list').fadeOut();
			$(this).parent().removeClass('clicked');
			$(this).parent().addClass('unclicked');						
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

	
	
});


function showWhiteClusters() {
	cluster1.clearMarkers();
	var new_white_markers = [];
	for (var i=0; i<white_markers.length;i++) {
		if ((e1 && white_markers[i].information_.ecosystem_service.e1) || (e2 && white_markers[i].information_.ecosystem_service.e2) || (e3 && white_markers[i].information_.ecosystem_service.e3) || (e4 && white_markers[i].information_.ecosystem_service.e4) || (e5 && white_markers[i].information_.ecosystem_service.e5)) {
			new_white_markers.push(white_markers[i]);
		}
	}
	cluster1 = new MarkerClusterer(map, new_white_markers,white_style);
}


function showYellowClusters() {
	cluster2.clearMarkers();
	var new_yellow_markers = [];
	for (var i=0; i<yellow_markers.length;i++) {
		if ((e1 && yellow_markers[i].information_.ecosystem_service.e1) || (e2 && yellow_markers[i].information_.ecosystem_service.e2) || (e3 && yellow_markers[i].information_.ecosystem_service.e3) || (e4 && yellow_markers[i].information_.ecosystem_service.e4) || (e5 && yellow_markers[i].information_.ecosystem_service.e5)) {
			new_yellow_markers.push(yellow_markers[i]);
		}
	}
	cluster2 = new MarkerClusterer(map, new_yellow_markers,yellow_style);
}


/* VARIABLES */
var map;


function initialize() {
		var center = new google.maps.LatLng(42.68243539838623, -37.08984375);
 
		map = new google.maps.Map(document.getElementById('map'), {
			zoom: 3,
			center: center,
			mapTypeControl:false,
			navigationControl:false,
			mapTypeId: google.maps.MapTypeId.ROADMAP
		});
 
		var fluster1 = new Fluster2(map);
		var fluster2 = new Fluster2(map);
		
		bounds = new google.maps.LatLngBounds();
   
		$.ajax({
		  url: 'http://lifeweb.heroku.com/projects',
		  dataType: 'jsonp',
		  data: null,
		  success: function(result) {
							 		$.each(result, function(key, value) {
										bounds.extend (new google.maps.LatLng(value.lat,value.lon));
										if (value.matched) {
											var marker = new White_Marker(new google.maps.LatLng(value.lat, value.lon),value,map); 
											fluster2.addMarker(marker);
										} else {
											var marker = new Yellow_Marker(new google.maps.LatLng(value.lat, value.lon),value,map); 
											fluster1.addMarker(marker);
										}
									});
									
									
									map.fitBounds (bounds);
							  	map.setCenter( bounds.getCenter());
							
									fluster1.styles = {
											0: {
												image: 'images/markers/22_yellow.png',
												textColor: '#FFFFFF',
												width: 32,
												height: 32
											},
											5: {
												image: 'images/markers/30_yellow.png',
												textColor: '#FFFFFF',
												width: 40,
												height: 40
											}
										};
										
										fluster2.styles = {
												0: {
													image: 'images/markers/22_white.png',
													textColor: '#FFFFFF',
													width: 32,
													height: 32
												},
												5: {
													image: 'images/markers/30_white.png',
													textColor: '#FFFFFF',
													width: 40,
													height: 40
												}
											};

										fluster1.initialize();
										fluster2.initialize();
							
							 }
		});
		

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
		
	$('div.list ul li a').click(function(ev){
		ev.stopPropagation();
		ev.preventDefault();
		
		if ($(this).parent().hasClass('checked')) {
		
			$(this).parent().removeClass('checked');
			$(this).parent().addClass('unchecked');			
		}
		
		else if ($(this).parent().hasClass('unchecked')) {
			
			$(this).parent().removeClass('unchecked');
			$(this).parent().addClass('checked');			
		}
		
	});
	

	$('div.bttn_zoomIn').click(function(ev){map.setZoom(map.getZoom()+1)});
	$('div.bttn_zoomOut').click(function(ev){map.setZoom(map.getZoom()-1)});
	
	
});




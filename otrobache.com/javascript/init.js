var geocoder = null;
var map = null;
var map2 = null;
var marker;
var busy = false;
var change_html = false;
var second_map_height;
var address;
var locality;
var click_flag = 0;
var try_ = 0;
var array_params;
var infowindow_open = false;
var choosenDictionary = [];

function initialize(localityName,centerLat,centerLon,swLat,swLon,neLat,neLon) {
	    locality=localityName;
		//JQUERY EFFECTS
		second_map_height = $('div#container div.report_map').height();
		$('div#container div.report_map').height(0);
		if ($('span.add input').attr('value')=='calle, número, localidad,...') {
			$('div#container div.report_map span.add input[type="text"]').css('color','#999999');
		} else {
			$('div#container div.report_map span.add input[type="text"]').css('color','#333333');
		}
		
		$('#open_report').click (function(ev) {
			ev.preventDefault();
			ev.stopPropagation();
			if (!busy) {
				if ($(this).html()=='reportar un bache') {
					$(this).html('cancelar');
					$('div#container div.report_map').css('padding-bottom','17px');
					$('div#container div.report_map').css('border-bottom','1px solid #c2c2c2');
					$('div#container div.report_map').stop().animate({
					    height: second_map_height
					  }, 500);
				} else {
					$(this).html('reportar un bache');
					$('div#container div.report_map').stop().animate({
					    height: 0
					  }, 500,function() {
							$('div#container div.report_map').css('padding-bottom','0');
							$('div#container div.report_map').css('border-bottom','none');
							if (change_html) {
								change_html = false;
								$('div#container div.report_map div.first_launch').show();
								$('span.add input[type="text"]').attr('value','calle, número, localidad,...');
								$('span.add input[type="text"]').css('color','#999999');
								$('div#container div.report_map div.loading2').remove();
							}
					});
				}
			}
		});
		
		$('#report_bache_map').click (function(ev) {
			ev.preventDefault();
			ev.stopPropagation();
			if ($('div#container div.report_map').height() < second_map_height) {
				$('#open_report').html('cancelar');
				$('div#container div.report_map').css('padding-bottom','17px');
				$('div#container div.report_map').css('border-bottom','1px solid #c2c2c2');
				$('div#container div.report_map').stop().animate({
				    height: second_map_height
				  }, 500, function(){
						$('div#container div.report_map input[type=text]').focus();
				});
				
			}
			$.scrollTo('div.report_map',500);
		});
		
		$('a.confirm_info').click(function(ev){
			ev.stopPropagation();
			ev.preventDefault();
		});
		
		$('#report_bache_button').click (function(ev) {
			ev.preventDefault();
			ev.stopPropagation();
			if ($('div#container div.report_map').height() < second_map_height) {
				$('#open_report').html('cancelar');
				$('div#container div.report_map').css('padding-bottom','17px');
				$('div#container div.report_map').css('border-bottom','1px solid #c2c2c2');
				$('div#container div.report_map').stop().animate({
				    height: second_map_height
				  }, 500, function(){
						$('div#container div.report_map input[type=text]').focus();
				});
				
			}
			$.scrollTo('div.report_map',500);
		});
		
		$('#plus').click(function(ev){map2.setZoom(map2.getZoom()+1)});
		$('#minus').click(function(ev){map2.setZoom(map2.getZoom()-1)});
		
		$('span.add input[type=text]').focus( function(ev){
			if ($(this).attr('value') == 'calle, número, localidad,...') {
				$(this).attr('value','');
				$(this).css('color','#333333');
				$(this).focus();
			}
		});  
		
		$('#report_bache_a').click( function(ev){
			ev.preventDefault();
			ev.stopPropagation();
			if (!busy) {
				if (marker) {
					busy = true;
					change_html = true;
					$('div#container div.report_map').animate({
					    height: 0
					  }, 300,function() {
							var loading_html = "<div class='loading1'><img style='margin:56px 0 10px 315px;' src='../images/ajax-loader.gif'/><p style='width:100%; text-align:center; margin:0; padding:0'>Estamos reportando tu bache, gracias!</p></div>";
							$('div#container div.report_map div.first_launch').hide();
							$('div#container div.report_map').append(loading_html);
							$('div#container div.report_map').animate({
							    height: 150
							  }, 300);
					});
					createNewBache(marker.getPoint().lat(),marker.getPoint().lng());
				} else {
					$('#error_map').modal();
				}
			}
		});
		
		   
		
		//LOAD MAP
		if (GBrowserIsCompatible()) {
				geocoder = new GClientGeocoder();
        var options = {

        onIdleCallback : function() { alert("search control is idle");},
        onGenerateMarkerHtmlCallback : function(marker, div, result) { div.innerHTML = "<input type='button' value='Anadir este bache' />"; return div; },
        searchFormHint : "busca direccion"
        };      

      map = new GMap2(document.getElementById("map_canvas"),{googleBarOptions: options});
			map2 = new GMap2(document.getElementById("second_map"));
		
		if(centerLat==0) {
		  var bounds = new GLatLngBounds(
		  		new GLatLng(swLat,swLon),new GLatLng(neLat,neLon));
		  var center = bounds.getCenter();
		  var zoom = map.getBoundsZoomLevel(bounds);			
      map.setCenter(center,zoom);
			map2.setCenter(center,zoom);		

		} else {
			var center=new GLatLng(centerLat,centerLon);
			var zoom=10;	
      map.setCenter(new GLatLng(41.73852846935917,-3.4716796875),5);
			map2.setCenter(center,zoom);			
		}
		
		

	  
	  var d = new Date();
      d.setDate(d.getDate()-60);
      var monthsago= escape(d.getMonth()+1+"/"+d.getDate()+"/"+d.getFullYear());
	  

			
      var l = new GLayer("ft:136993");
      l.setParameter("h", "false");
      l.setParameter("s", "select+reported_date,reported_by,city,zip,addressline+from+136993+where+reported_date%2520%253E%3D%2520%27"+monthsago+"%27");

      map.addOverlay(l);
      //map.setUIToDefault();
      map.enableScrollWheelZoom();
      map.addControl(new GMapTypeControl());
      map.addControl(new GSmallZoomControl());
      //map.addControl(new GLargeMapControl());
      //map.setUIToDefault();

      //map.enableGoogleBar();


			$('#map_canvas').click(function(ev) {

				if (ev.target.nodeName!='A' && ev.target.nodeName!='DIV' && ev.target.nodeName!='P') {
					click_flag = click_flag + 1;
					try_ = 0;
					window.setTimeout('changeInfowindowData('+click_flag+')', 400);
					
				}
			});

    }
  }

	function changeInfowindowData(flag) {
			var find = false;
				$('div#map_canvas').find('div[jstcache]').each(function(index){
						$(this).parent().hide();
				  	$('div#content p').fadeOut();
						find = true;
						$(this).find('*:contains("lat")').remove();
						$(this).find('*:contains("lon")').remove();
						$(this).find('*:contains("reported_date")').remove();
						$(this).find('*:contains("reported_by")').remove();
						$(this).find('*:contains("address")').remove();
						$(this).find('*:contains("city")').remove();
						$(this).find('*:contains("zip")').remove();
						$(this).find('*:contains("addressline")').remove();

						array_params = $(this).text().split(': ');
						var code_address = array_params[8].split('|');

						if (code_address[1]=='undefined' || code_address[1]=='' || code_address[1]==null) {
							var street_number = 'S/N';
						} else {
							var street_number = 'Cerca del ' + code_address[1];
						}

						if (choosen_bache(array_params[1],array_params[2])) {
							$(this).html('<p style="position:relative; width:100%; top:0; left:0; float:left; padding:13px 0 0 0;">Calle '+ code_address[0] +'</p><p style="position:relative; padding:5px 0 0 0; width:100%; top:0; left:0; float:left; font-weight:normal">'+ street_number +'</p><p style="padding:5px 0 0 0; position:relative; width:100%; top:0; left:0; float:left" class="below_bache">'+array_params[7] + ', ' + array_params[6] +'</p<p style="position:relative; top:0; left:0; float:left; width:100%; text-align:right; padding:22px 8px 0 0; margin:0; font:normal 12px Arial; color:#666666">Ya reportado</p>');
						} else {
							$(this).html('<p style="position:relative; width:100%; top:0; left:0; float:left; padding:13px 0 0 0;">Calle '+ code_address[0] +'</p><p style="position:relative; padding:5px 0 0 0; width:100%; top:0; left:0; float:left; font-weight:normal">'+ street_number +'</p><p style="padding:5px 0 0 0; position:relative; width:100%; top:0; left:0; float:left" class="below_bache">'+array_params[7] + ', ' + array_params[6] +'</p><a href="javascript:void confirmBacheInfoWindow('+array_params[1]+','+array_params[2]+')" class="confirm_info"></a>');
						}
						$(this).parent().show();
				});
				if (!find) {
					$('div#content p').fadeIn();
					if (click_flag==flag && try_<50) {
						try_ = try_ + 1;
						window.setTimeout('changeInfowindowData('+flag+')', 100);
					}
				}

	}
  
	function getConfirmation(lat,lon,id) {
		$("div#container div.baches ul li #rep"+id).hide();
		$("div#container div.baches ul li#item"+ id).append('<p class="loading">enviando</p>');
		confirmBache(lat,lon,id);
	}

  
  function confirmBache(lat,lon,id) {
      pageTracker._trackPageview("/confirmBache");
	  $.ajax({ url: "/api/OtroBache.reportBache/"+lat+"/"+lon+"/web", context: document.body, success: function(){
	    $("#num"+id).text(parseInt($("#num"+id).text())+1);
			$("div#container div.baches ul li#item"+ id + " p.loading").hide();
			$("div#container div.baches ul li#item"+ id).append('<p class="done">Ya reportado</p>');
			var new_object = new Object();
			new_object.lat = lat;
			new_object.lon = lon;
			choosenDictionary.push(new_object);
	  }});
  }

  function confirmBacheInfoWindow(lat,lon) {
      pageTracker._trackPageview("/confirmBache");
			$('a.confirm_info').hide();
			$('a.confirm_info').after("<img style='margin:18px 20px 0 0; float:right; position:relative;width:22px; height:22px;' class='image-loading' src='../images/ajax-loader.gif'/>");
	  $.ajax({ url: "/api/OtroBache.reportBache/"+lat+"/"+lon+"/web", context: document.body, success: function(){
			$('img.image-loading').hide();
			$('a.confirm_info').after('<p style="position:relative; top:0; left:0; float:left; width:100%; text-align:right; padding:22px 8px 0 0; margin:0; font:normal 12px Arial; color:#666666">Ya reportado</p>');	
			var new_object = new Object();
			new_object.lat = lat;
			new_object.lon = lon;
			choosenDictionary.push(new_object);
	  }});
  }
	

  function createNewBache(lat,lon) {
      pageTracker._trackPageview("/createNewBache");
      $.ajax({ url: "/api/OtroBache.reportBache/"+lat+"/"+lon+"/web", context: document.body, success: function(){
				map2.clearOverlays();
				marker = null;
				busy = false;
				
				
				$('div#container div.report_map').animate({
				    height: 0
				  }, 300,function() {
						var addressInput= $("input[name=address]").val() +",Madrid";
						var loading_html = "<div class='loading2'><img style='margin:40px 0 10px 315px;' src='../images/smile.png'/><p style='width:100%; text-align:center; margin:0; padding:0'>El bache ha sido reportado correctamente.<br>Si quieres, puedes <a href='http://www.facebook.com/sharer.php?t="+escape('Otro bache en '+addressInput )+"&u=" + escape('http://otrobache.com/en/'+ locality +'?address='+addressInput) +"' class='facebook' target='_blank'>compartirlo en facebook</a> y darle más visibilidad. </p><a href='#' id='new_report'>reportar otro bache</a></div>";					
						$('div#container div.report_map div.loading1').remove();
						$('div#container div.report_map').append(loading_html);
						$('a#new_report').click( function(ev){
							ev.preventDefault();
							ev.stopPropagation();
							change_html = false;
							$('div#container div.report_map').animate({
							    height: 0
							  }, 300,function() {
									$('div#container div.report_map div.first_launch').show();
									$('div#container div.report_map div.loading2').remove();
									$('span.add input[type="text"]').attr('value','calle, número, localidad,...');
									$('span.add input[type="text"]').css('color','#999999');
									$('div#container div.report_map').animate({
									    height: second_map_height
									  }, 300);
							});
						});

						$('div#container div.report_map').animate({
						    height: 180
						  }, 300);
				});
			}});
  }

	function showAddress(address) {
     if (geocoder) {
			address += ', '+locality;
       geocoder.getLatLng(
         address,
         function(point) {
           if (!point) {
             $('#error_map').modal();
           } else {
						 if (marker) {
							 map2.removeOverlay(marker); 
						 } else {
							 $('#report_bache_a ').fadeIn('fast');
						 }
             map2.setCenter(point, 13);
             marker = new GMarker(point,{draggable: true});
						 GEvent.addListener(marker, "dragend", function(ev){
								
								if (marker.getLatLng() != null) {
								    address = marker.getLatLng();
								    geocoder.getLocations(marker.getLatLng(), getAddress);
								}
						 });
						
             map2.addOverlay(marker);
           }
         }
       );
     }
   }

	function getAddress(response) {
	  if (!response || response.Status.code != 200) {
	    alert("Status Code:" + response.Status.code);
	  } else {
	    place = response.Placemark[0];
			$('span.add input[type=text]').attr('value',place.address);
	  }

  }

	function choosen_bache(lat,lon) {
		for( var i in choosenDictionary ){
				if (choosenDictionary[i].lat==lat && choosenDictionary[i].lon==lon) {
					return true;
				}
		}
		return false;
	}








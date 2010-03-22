var geocoder = null;
var map = null;
var map2 = null;
var marker;
var busy = false;

function initialize() {
	
		//JQUERY EFFECTS
		var second_map_height = $('div#container div.report_map').height();
		$('div#container div.report_map').height(0);
		if ($('span.add input').attr('value')=='calle, número, localidad,...') {
			$('div#container div.report_map span.add input[type="text"]').css('color','#999999');
		} else {
			$('div#container div.report_map span.add input[type="text"]').css('color','#333333');
		}
		
		$('#open_report').click (function(ev) {
			ev.preventDefault();
			ev.stopPropagation();
			if ($(this).html()=='reportar un bache') {
				$(this).html('ocultar reporte');
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
				});
			}
		});
		
		$('#report_bache_map').click (function(ev) {
			ev.preventDefault();
			ev.stopPropagation();
			if ($('div#container div.report_map').height() < second_map_height) {
				$('#open_report').html('ocultar reporte');
				$('div#container div.report_map').css('padding-bottom','17px');
				$('div#container div.report_map').css('border-bottom','1px solid #c2c2c2');
				$('div#container div.report_map').stop().animate({
				    height: second_map_height
				  }, 500);
			}
			$.scrollTo('div.report_map',500);
		});
		
		$('#report_bache_button').click (function(ev) {
			ev.preventDefault();
			ev.stopPropagation();
			if ($('div#container div.report_map').height() < second_map_height) {
				$('#open_report').html('ocultar reporte');
				$('div#container div.report_map').css('padding-bottom','17px');
				$('div#container div.report_map').css('border-bottom','1px solid #c2c2c2');
				$('div#container div.report_map').stop().animate({
				    height: second_map_height
				  }, 500);
			}
			$.scrollTo('div.report_map',500);
		});
		
		$('#plus').click(function(ev){map2.setZoom(map2.getZoom()+1)});
		$('#minus').click(function(ev){map2.setZoom(map2.getZoom()-1)});
		
		$('span.add input').click( function(ev){
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
					$('#report_bache_a').css('background-position','0 -68px');
					$('#report_bache_a:hover').css('background-position','0 -68px');
					createNewBache(marker.getPoint().lat(),marker.getPoint().lng());
				} else {
					alert ('Debes marcar un sitio para reportar el bache.');
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
			
      map.setCenter(new google.maps.LatLng(40.4392758681028,-3.7121450901031494),12);
			map2.setCenter(new google.maps.LatLng(40.4392758681028,-3.7121450901031494),12);
			
      var l = new GLayer("ft:136993");
      l.setParameter("h", "true");
      l.setParameter("s", "select+address+from+136993");

      map.addOverlay(l);
      //map.setUIToDefault();
      map.enableScrollWheelZoom();
      map.addControl(new GMapTypeControl());
      //map.addControl(new GLargeMapControl());
      //map.setUIToDefault();


      //map.enableGoogleBar();

    }
  }
  
  
  function confirmBache(lat,lon,id) {
      $.ajax({ url: "amfphp/json.php/OtroBache.reportBache/"+lat+"/"+lon+"/web/1/1/null", context: document.body, success: function(){
              $("#rep"+id).addClass("done");
              $("#num"+id).text(parseInt($("#num"+id).text())+1);
            }});
  }

  function createNewBache(lat,lon) {
      $.ajax({ url: "amfphp/json.php/OtroBache.reportBache/"+lat+"/"+lon+"/web/1/1/null", context: document.body, success: function(){
				map2.clearOverlays();
				marker = null;
				busy = false;
				$('div.report_map a.report_button').fadeOut('fast');
				$('#report_bache_a').css('background-position','0 0');
				$('#report_bache_a:hover').css('background-position','0 -34px');
				$('span.add input[type="text"]').attr('value','calle, número, localidad,...');
				$('span.add input[type="text"]').css('color','#999999');
				alert('Gracias por reportar un bache nuevo. :D');
			}});
  }

	function showAddress(address) {
     if (geocoder) {
       geocoder.getLatLng(
         address,
         function(point) {
           if (!point) {
             alert(address + " - No hemos encontrado esa dirección. Lo sentimos.");
           } else {
						 if (marker) {
							map2.removeOverlay(marker); 
						 } else {
							$('#report_bache_a ').fadeIn('fast');
						}
             map2.setCenter(point, 13);
             marker = new GMarker(point,{draggable: true});
             map2.addOverlay(marker);
           }
         }
       );
     }
   }






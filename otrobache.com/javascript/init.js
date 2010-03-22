var geocoder = null;
var map = null;
var map2 = null;
var marker;
var busy = false;
var change_html = false;
var second_map_height;

function initialize() {
	
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
				  }, 500);
			}
			$.scrollTo('div.report_map',500);
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
  
	function getConfirmation(lat,lon,id) {
		$("div#container div.baches ul li #rep"+id).hide();
		$("div#container div.baches ul li#item"+ id).append('<p class="loading">enviando</p>');
		confirmBache(lat,lon,id);
	}

  
  function confirmBache(lat,lon,id) {
	  $.ajax({ url: "amfphp/json.php/OtroBache.reportBache/"+lat+"/"+lon+"/web/1/1/null", context: document.body, success: function(){
	    $("#num"+id).text(parseInt($("#num"+id).text())+1);
			$("div#container div.baches ul li#item"+ id + " p.loading").hide();
			$("div#container div.baches ul li#item"+ id).append('<p class="done">ya reportado por tí</p>');
	  }});
  }

  function createNewBache(lat,lon) {
      $.ajax({ url: "amfphp/json.php/OtroBache.reportBache/"+lat+"/"+lon+"/web/1/1/null", context: document.body, success: function(){
				map2.clearOverlays();
				marker = null;
				busy = false;
				
				
				$('div#container div.report_map').animate({
				    height: 0
				  }, 300,function() {
						var addressInput= $("input[name=address]").val() +",Madrid";
						var loading_html = "<div class='loading2'><img style='margin:40px 0 10px 315px;' src='../images/smile.png'/><p style='width:100%; text-align:center; margin:0; padding:0'>El bache ha sido reportado correctamente.<br>Si quieres, puedes <a href='http://www.facebook.com/sharer.php?t="+escape('Otro bache en '+addressInput )+"&u=" + escape('http://otrobache.com?address='+addressInput) +"' class='facebook'>compartirlo en facebook</a> y darle mas visibilidad. </p><a href='#' id='new_report'>reportar otro bache</a></div>";					
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
						    height: 150
						  }, 300);
				});
			}});
  }

	function showAddress(address) {
     if (geocoder) {
			address += ', Madrid';
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
             map2.addOverlay(marker);
           }
         }
       );
     }
   }








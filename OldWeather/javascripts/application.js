	
	$(document).ready(function(){ 

		
		Cufon.set('selector', jQuery);
		Cufon.replace('.clarendon');
		Cufon.replace('div.data div.information.vessel_map div.orange_container h1',{textShadow:'0 -1px #712B1D'});
		Cufon.replace('div.data div.information.vessel_map div.orange_container p',{textShadow:'0 2px #AB422D'});
		


		if ($('div#map').is(':visible')) {
			var myLatlng = new google.maps.LatLng(-34.397, 150.644);
		    var myOptions = {
		      zoom: 8,
		      center: myLatlng,
					disableDefaultUI: true,
		      mapTypeId: google.maps.MapTypeId.ROADMAP
		    }
		   var map = new google.maps.Map(document.getElementById("map"), myOptions);
		}

		/* VESSELS_LIST */
		$('div.following a').click(function(ev){
			console.log('entra');
			ev.stopPropagation();
		    ev.preventDefault();
		 	$(this).hide();
		    $(this).parent().children('span').show();

		});
	});
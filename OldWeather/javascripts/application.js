	
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
			ev.stopPropagation();
		    ev.preventDefault();
		 	$(this).hide();
		    $(this).parent().children('span').fadeIn('fast');

		});
		
		$('li div.bar').each(function(index) {
			var percent_orange = $(this).children('p.percent_orange').text();
			var percent_blue = $(this).children('p.percent_blue').text();
			
			if (!percent_orange.length > 0) percent_orange = 0;	 
			if (!percent_blue.length > 0) percent_blue = 0; 
			
			drawProgressBar(percent_orange,percent_blue,$(this));
		});
		
		
	});
	
	/* RETURN THE CORRECT WIDTH FOR SPECIFIC PERCENT */
	function getWidthBar(percent){
	
		var width = 0;
		width = percent * 303 / 100;
		return Math.round(width);
	}
	
	/* DRAW THE PROGRESS BAR IN VESSELS_LIST.HTML */
	function drawProgressBar(percent_orange, percent_blue, element_to_draw) {
		// 100% -> 303px
		// 50% ->  151px
		
		console.log('percent_blue: '+ percent_blue);
		console.log('function: ',getWidthBar(percent_blue));

		var html_to_add = ""
		
		if ((percent_orange != 0) || (percent_blue != 0)){
			if (percent_orange > 0) {
				html_to_add = html_to_add + '<a class="left orange"><span class="orange" style="width:'+ getWidthBar(percent_orange) +'px"></span></a>'
				
				if (percent_blue > 0) {
					html_to_add = html_to_add + '<span class="space"></span><a class="second_bar blue" style="width:'+ getWidthBar(percent_blue) +'px"></a><a class="right blue"></a>'
				}
				else {
					html_to_add = html_to_add + '<a class="right orange"></a>'
				}
			}
			else {
				html_to_add = html_to_add + '<a class="left blue"><span class="blue" style="width:'+ getWidthBar(percent_blue) +'px"></span></a><a class="right blue"></a>'
				element_to_draw.prepend(html_to_add);
			}
			element_to_draw.prepend(html_to_add);
		}
	}
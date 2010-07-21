	
	$(document).ready(function(){ 

		Cufon.set('selector', jQuery);
		Cufon.replace('.clarendon');
		Cufon.replace('div.information.vessel_map div.orange_container h1',{textShadow:'0 -1px #712B1D'});
		Cufon.replace('div.information.vessel_map div.orange_container p',{textShadow:'0 2px #AB422D'});
		Cufon.replace('div.information.vessels div.right.top h3',{textShadow:'0 1px #6F2A1C'});
		

		Cufon.replace('div.pages ul li a.option',{hover:{color:'#666666'}});
		Cufon.replace('div.pages ul li.selected',{hover:{color:'white'}});
		Cufon.replace('div.pages a.next',{hover:{color:'#B2432E'}});
		
		//Bar completed tooltip
		$('div.inner_bar').each(function(index){
			var bar_width = $(this).parent().width();
			var percentage = $(this).parent().find('p.completed').text();
			$(this).find('span').css('width', ((bar_width * percentage) / 100) - 2 + 'px');
		});
		
		//Map stuff - If there isn't a map, it doesn't matter
		if ($('div#map').is(':visible')) {
			var myLatlng = new google.maps.LatLng(38.97595868249733, 1.1844635009765625);
		    var myOptions = {
		      zoom: 14,
		      center: myLatlng,
					disableDefaultUI: true,
		      mapTypeId: google.maps.MapTypeId.ROADMAP
		    }
		  var map = new google.maps.Map(document.getElementById("map"), myOptions);
			
			if ($('div.floating_content').length==0) {
				var image = new google.maps.MarkerImage('images/vessels/tiny_marker.png', new google.maps.Size(32, 38), new google.maps.Point(0,0), new google.maps.Point(16, 38));
				var marker = new google.maps.Marker({position: myLatlng,map: map,icon: image});
			} else {
				var marker = new BoatMarker(myLatlng,218,135,'images/vessels/queen.png', map);
				map.panBy(170,-80);
			}
		}

		/* VESSELS_LIST */
		$('div.following a').click(function(ev){
			ev.stopPropagation();
		    ev.preventDefault();
		 	$(this).hide();
		    $(this).parent().children('span').fadeIn('fast');

		});
		
		$('div.bar').each(function(index) {
			var percent_orange = $(this).children('p.percent_orange').text();
			var percent_blue = $(this).children('p.percent_blue').text();
			
			if (!percent_orange.length > 0) percent_orange = 0;	 
			if (!percent_blue.length > 0) percent_blue = 0;
						
			drawProgressBar(percent_orange,percent_blue,$(this),$(this).width()-4);
		});	
		
		
		$('div.information div.digitalizing_content div.bar').each(function(index) {
			var percent_orange = $(this).children('p.percent_orange').text();
			var percent_blue = $(this).children('p.percent_blue').text();
			
			if (!percent_orange.length > 0) percent_orange = 0;	 
			if (!percent_blue.length > 0) percent_blue = 0; 
			
			drawProgressBar(percent_orange,percent_blue,$(this),483);
		});
	});

	/* RETURN THE CORRECT WIDTH FOR SPECIFIC PERCENT */
	function getWidthBar(percent,sizeBar){

		// 100% -> 303px/483px 
		// 50% ->  151px
				
		var width = 0;
		width = percent * sizeBar / 100;
		return Math.round(width);
	}
	
	
	/* DRAW THE PROGRESS BAR IN VESSELS_LIST.HTML */
	function drawProgressBar(percent_orange, percent_blue, element_to_draw,sizeBar) {
		
		var html_to_add = ""

		if ((percent_orange != 0) || (percent_blue != 0)){
			if (percent_orange > 0) {
				html_to_add = html_to_add + '<a class="left orange"><span class="orange" style="width:'+ getWidthBar(percent_orange,sizeBar) +'px"></span></a>'
				
				if (percent_blue > 0) {
					html_to_add = html_to_add + '<span class="space"></span><a class="second_bar blue" style="width:'+ getWidthBar(percent_blue,sizeBar) +'px"></a><a class="right blue"></a>'
				}
				else {
					html_to_add = html_to_add + '<a class="right orange"></a>'
				}
			}
			else {
				html_to_add = html_to_add + '<a class="left blue"><span class="blue" style="width:'+ getWidthBar(percent_blue,sizeBar) +'px"></span></a><a class="right blue"></a>'
				element_to_draw.prepend(html_to_add);
			}
			element_to_draw.prepend(html_to_add);
		}
	}
	
	
	function blendimage(divid, imageid, imagefile, millisec, alt, total, workn, linkn) {
		var speed = Math.round(millisec / 100);
		var timer = 0;

		//set the current image as background
		document.getElementById(divid).style.backgroundImage = "url(" + document.getElementById(imageid).src + ")";
		document.getElementById(divid).style.backgroundPosition = "0 bottom";
		document.getElementById(divid).style.backgroundRepeat = "no-repeat";		

		//make image transparent
		changeOpac(0, imageid);

		//make new image
		document.getElementById(imageid).src = imagefile;

		//fade in image
		for(i = 0; i <= 100; i++) {
			setTimeout("changeOpac(" + i + ",'" + imageid + "')",(timer * speed));
			timer++;

		//change class and description
		}
		substr = imageid.substring(10,11);
		for (i=1; i<=total; i++) {
			link = "image" + workn + i;
			document.getElementById(link).className = "";
		}

		document.getElementById("image"+workn+linkn).className = "current";

	}
	
	
	function opacity(id, opacStart, opacEnd, millisec) {
		//speed for each frame
		var speed = Math.round(millisec / 100);
		var timer = 0;

		//determine the direction for the blending, if start and end are the same nothing happens
		if(opacStart > opacEnd) {
			for(i = opacStart; i >= opacEnd; i--) {
				setTimeout("changeOpac(" + i + ",'" + id + "')",(timer * speed));
				timer++;
			}
		} else if(opacStart < opacEnd) {
			for(i = opacStart; i <= opacEnd; i++)
				{
				setTimeout("changeOpac(" + i + ",'" + id + "')",(timer * speed));
				timer++;
			}
		}
	}

	//change the opacity for different browsers
	function changeOpac(opacity, id) {
		var object = document.getElementById(id).style; 
		object.opacity = (opacity / 100);
		object.MozOpacity = (opacity / 100);
		object.KhtmlOpacity = (opacity / 100);
		object.filter = "alpha(opacity=" + opacity + ")";
	}

	function shiftOpacity(id, millisec) {
		//if an element is invisible, make it visible, else make it ivisible
		if(document.getElementById(id).style.opacity == 0) {
			opacity(id, 0, 100, millisec);
		} else {
			opacity(id, 100, 0, millisec);
		}
	}
	
	function currentOpac(id, opacEnd, millisec) {
		//standard opacity is 100
		var currentOpac = 100;

		//if the element has an opacity set, get it
		if(document.getElementById(id).style.opacity < 100) {
			currentOpac = document.getElementById(id).style.opacity * 100;
		}

		//call for the function that changes the opacity
		opacity(id, currentOpac, opacEnd, millisec)
	}

	
	
	
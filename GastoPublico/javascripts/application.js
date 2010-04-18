var $j = jQuery;
var map;
var geocoder;
var userLatLng;
var userCity;



$(document).ready(function() {
	
    var zoom;
     if (google.loader.ClientLocation) {
       zoom = 9;
       userLatLng = new google.maps.LatLng(google.loader.ClientLocation.latitude, google.loader.ClientLocation.longitude);
       userCity=google.loader.ClientLocation.address.city;
     }  else {
         zoom = 6;
         userLatLng = new google.maps.LatLng(40.3967643055720,-3.58154296875);       
         userCity="España";
     }  


   	geocoder = new google.maps.Geocoder();
     var myOptions = {
         zoom: zoom,
         center: userLatLng,
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
   		if ($('span.obra_map').length>0) {
   			map.panBy(300,-10);
   		} else {
   			map.panBy(-200,-10);
   		}

   	} else {


   		map.panBy(-330,-10);	

   		var fluster = new Fluster2(map);
   			var image = '../images/markers/small.png';

   			for(var i = 0; i < organismos.length; i++)
   			{
   				var marker = new google.maps.Marker({
   					position: new google.maps.LatLng(organismos[i].lat, organismos[i].lon),
   					title: organismos[i].nombre,
   					icon: image,
   					data: organismos[i].id
   				});
   				google.maps.event.addListener(marker, 'click', function() {
   				  window.location = '../org/'+this.data;
   				});
   				fluster.addMarker(marker);
   			}

   			fluster.styles = {
   				0: {
   					image: '../images/markers/medium.png',
   					textColor: '#FFFFFF',
   					width: 48,
   					height: 48
   				},
   				6: {
   					image: '../images/markers/big.png',
   					textColor: '#FFFFFF',
   					width: 58,
   					height: 58
   				}
   			};

   			fluster.initialize();
   	}
	
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
	
	$('.back_about').click (function(ev){
		ev.stopPropagation();
		ev.preventDefault();
		$.scrollTo('.outer_layout_gray',500);
	});
	
	$('#gotocomment').click (function(ev){
		ev.stopPropagation();
		ev.preventDefault();
		$.scrollTo('p.title_comments',500);
	});
	
	



	// OBRA LENGTH
	var left_work = $('div.left_region_work').height();
	var right_work = $('div.renovation_content').height()-226;
	
	if (left_work<right_work) {
			$('div.left_region_work').height(right_work+20);
			$('div.renovation_content').height($('div.renovation_content').height()+20);
	} else {
		 	$('div.renovation_content').height(left_work);
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



	$('div.content_right a span.kind_contrat_open').hover(function(ev){
		ev.stopPropagation();
		ev.preventDefault();
		
		$(this).parent().parent().children('div.tool_tip_open').show();
		
	},
	function(){
		$(this).parent().parent().children('div.tool_tip_open').fadeOut();
		
	});

	$('a div.big_chart').hover(function(ev){
		ev.stopPropagation();
		ev.preventDefault();
		
		$(this).parent().parent().children('div.tool_tip_toomuch').show();
		
	},
	function(){
		$(this).parent().parent().children('div.tool_tip_toomuch').fadeOut();
		
	});
	
	$('a div.big_chart').hover(function(ev){
		ev.stopPropagation();
		ev.preventDefault();
		
		$(this).parent().parent().children('div.tool_tip_toomuch_two').show();
		
	},
	function(){
		$(this).parent().parent().children('div.tool_tip_toomuch_two').fadeOut();
		
	});
	
	$('a div.big_chart').hover(function(ev){
		ev.stopPropagation();
		ev.preventDefault();
		
		$(this).parent().parent().children('div.tool_tip_toomuch_org').show();
		
	},
	function(){
		$(this).parent().parent().children('div.tool_tip_toomuch_org').fadeOut();
		
	});
	
	$('a div.big_chart').hover(function(ev){
		ev.stopPropagation();
		ev.preventDefault();
		
		$(this).parent().parent().children('div.tool_tip_toomuch_org_two').show();
		
	},
	function(){
		$(this).parent().parent().children('div.tool_tip_toomuch_org_two').fadeOut();
		
	});
	
	$('div.more_enterprises a').hover(function(ev){
		ev.stopPropagation();
		ev.preventDefault();
		
		$(this).parent().children('div.tool_tip_toomuch_info').show();
		
	},
	function(){
		$(this).parent().children('div.tool_tip_toomuch_info').fadeOut();
		
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
	

	$('a.like').click(function(ev){
		
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
						var count = parseInt($(this_).children('strong').html());
						$(this_).children('strong').html(count+1);
		    	},
		      error:function (xhr, ajaxOptions, thrownError){
	        	alert('GastoPublico' + xhr.status + "\n" + thrownError);
	        }
		 });
	});	
	
	
	
	$('a.no_like').click(function(ev){
						
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
						var count = parseInt($(this_).children('strong').html());
						$(this_).children('strong').html(count+1);
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


});


function createNewComment() {
	var email = $('#mail_text').attr('value');
	var name = $('#name_text').attr('value');
	var comment = $('#comment_text').val();
	var web = $('#web_text').attr('value');
	var licitacion_id = $('span.licitacion_id').attr('id');

	//CREATE COMMENT
	
	if ((email.length==0) || (echeck(email)==false)) {
		$('#errors').text('Ups! Hay un problema con tu dirección de correo.');
		return false;
	}
	
	if (name.length<4) {
		$('#errors').text('Uy! Es un nombre un poco corto.');
		return false;
	}
	
	if (comment.length==0) {
		$('#errors').text('¡Recuerda commentar algo!');
		return false;
	}
	
	$('form.send_comment').animate({height:0},500,function(ev) {
		$('div.all_inputs').hide();
		$('form.send_comment img').show();
		$('form.send_comment').animate({height:100},500,function(ev){
			var dataObj = ({method: 'new_comment', name: name, email:email, comment:comment, web:web, licitacion_id:licitacion_id});

			$.ajax({
	    	type: "POST",
	    	url: "../ajaxController.php",
	    	data: dataObj,
	    	cache: false,
	    	success: function(result){
				
					if (result=="OK") {
						
						if ($('div.comments').length==0) {
							var html_comments = '<div class="line_to_separate"></div><div class="comments"><ul><li><div class="avatar"><img src="../images/default_work.png"></div><div class="comment_area"><p class="name"><a href="';
							html_comments+= web + '">'+ name +'</a>, ahora mismo</p><p class="comment">'+comment;
							html_comments+= '</p></div></li><li><div class="line_to_separate"></div></li></ul></div>';
							$('div.content_left').append(html_comments).hide().fadeIn();
							
							$('div.left_region_work').height($('div.renovation_content').height()-149);
							
						} else {
							var html_comments = '<li><div class="line_to_separate"></div></li><li><div class="avatar"><img src="../images/default_work.png"></div><div class="comment_area"><p class="name"><a href="';
							html_comments+= web + '">'+ name +'</a>, ahora mismo</p><p class="comment">'+comment;
							html_comments+= '</p></div></li>';
							$('div.comments ul').append(html_comments).fadeIn();
							
							$('div.left_region_work').height($('div.renovation_content').height()-149);
						}

						$('#mail_text').attr('value','');
						$('#name_text').attr('value','');
						$('#comment_text').val('');
						$('#web_text').attr('value','');
					} else {
						$('#errors').text('Ha ocurrido un error, inténtalo más tarde');
					}
					
					$('form.send_comment').animate({height:0},500,function(ev) {
						$('div.all_inputs').show();
						$('form.send_comment img').hide();
						$('form.send_comment').animate({height:260},500);
					});

	    	},
	      error:function (xhr, ajaxOptions, thrownError){
	       	alert('GastoPublico' + xhr.status + "\n" + thrownError);
	       }
			 });
		});
	});
}

//CHECK EMAIL JAVASCRIPT
function echeck(str) {
	var at="@"
	var dot="."
	var lat=str.indexOf(at)
	var lstr=str.length
	var ldot=str.indexOf(dot)
	if (str.indexOf(at)==-1){
	   return false
	}

	if (str.indexOf(at)==-1 || str.indexOf(at)==0 || str.indexOf(at)==lstr){
	   return false
	}

	if (str.indexOf(dot)==-1 || str.indexOf(dot)==0 || str.indexOf(dot)==lstr){
	    return false
	}

	 if (str.indexOf(at,(lat+1))!=-1){
	    return false
	 }

	 if (str.substring(lat-1,lat)==dot || str.substring(lat+1,lat+2)==dot){
	    return false
	 }

	 if (str.indexOf(dot,(lat+2))==-1){
	    return false
	 }

	 if (str.indexOf(" ")!=-1){
	    return false
	 }
	 return true
}


function codeAddress() {
   var address = $("#direccion").val();
	 address += ', España';
   if (geocoder) {
     geocoder.geocode( { 'address': address}, 
			function(results, status) {
				var country = results.formatted_address;
				if (status == google.maps.GeocoderStatus.OK) {
	         map.setCenter(results[0].geometry.location);
	         map.panBy(-330,-10);
	       } else {
	         $('div.tooltip').fadeIn();
					 $('div.tooltip').delay(3000).fadeOut();
	       }
			});
   }
 }


$j(function(){
	$j("input[name=search]").prompt("Busca tu municipio...");
	$j("input[name=bigSearch]").prompt("Busca tu municipio...");
});


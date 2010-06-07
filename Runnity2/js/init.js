$(document).ready(function(){

	  Cufon.replace('.horizontalcssmenu',{hover: true});
	  Cufon.replace('.subTitle');
	  Cufon.replace('.subTitleInfo');
	  Cufon.replace('.titularTitle');
	  Cufon.replace('.raceTitle');
	  Cufon.replace('.buttonmenuContainer a');
	  Cufon.replace('.titleBoxRegister p');
	  Cufon.replace('.nameUserProfile');
	  Cufon.replace('.nameUserProfileNick');
	  Cufon.replace('#correres');
		
		
	
	 $('a.share_race').click (function(ev){

		ev.stopPropagation();
		ev.preventDefault();
		
		$(this).parent().parent('div#columnLong_last').animate({height:125},500);
		$(this).parent().parent('div#columnLong_last').children('div.widget_race').show();
		
	});
	
	 $('a.close_window').click (function(ev){

		ev.stopPropagation();
		ev.preventDefault();
		
		$(this).parent().parent('div#columnLong_last').animate({height:25},500);
		$(this).parent().parent('div#columnLong_last').children('div.widget_race').fadeOut();
		
	});
	
	

    $('#inputsearchFirst').emptyonclick(); 

	  $('div.avatarContainer a img').hover(
		function () {
			$(this).css('z-index','9999');
			$(this).parent().find('div.hidden').show();
		}, 
		function () { 
			$(this).css('z-index','1');
		  $(this).parent().find('div.hidden').hide();
		}
	)

});

function logout () {

	var dataObj = ({method: 'logout'});    
    $.ajax({
    	type: "POST",
    	url: "/ajaxController.php",
    	data: dataObj,
    	cache: false,
    	success: function(result){
    		window.location = "/";
    	},
        error:function (xhr, ajaxOptions, thrownError){
             window.location = "/";
        }
    });
    
}


function relative_time(time_value) {
      var values = time_value.split(" ");
      time_value = values[1] + " " + values[2] + ", " + values[5] + " " + values[3];
      var parsed_date = Date.parse(time_value);
      var relative_to = (arguments.length > 1) ? arguments[1] : new Date();
      var delta = parseInt((relative_to.getTime() - parsed_date) / 1000);
      delta = delta + (relative_to.getTimezoneOffset() * 60);

      var r = '';
      if (delta < 60) {
        r = '<p> Hace un minuto';
      } else if(delta < 120) {
        r = '<p> Hace un par de minutos.';
      } else if(delta < (45*60)) {
        r = '<p> Hace ' + (parseInt(delta / 60)).toString() + ' minutos.';
      } else if(delta < (90*60)) {
        r = '<p> Hace una hora.';
      } else if(delta < (24*60*60)) {
        r = '<p> Hace ' + (parseInt(delta / 3600)).toString() + ' horas.';
      } else if(delta < (48*60*60)) {
        r = '<p> Hace un día.';
      } else {
        r ='<p> Hace ' + (parseInt(delta / 86400)).toString() + ' días.';
      }

      return r;
}




function borrarRecords(id1,id2,id3,id4) {
	$(id1).val(""); 
	$(id2).val(""); 	  
	$(id3).val(""); 	  
	$(id4).val(""); 	  
}

function showLoginWindow() {
	$('#login_modal').modal();
}

function confirmationWindowPhoto() {
	$('#confirmationWindowPhoto').modal();
}

function confirmationWindowUser() {
	$('#confirmationWindowUser').modal();
}

function show_contact() {
	$('#contact_modal').modal();
	
	
	var wscr = $(window).width();
    var hscr = $(window).height();
    
    // obtener posicion central
    var mleft = ( wscr - 500 ) / 2;
    var mtop = ( hscr - 480 ) / 2;
    
    // estableciendo ventana modal en el centro
    $('#simplemodal-container').css("left", mleft+'px');
    $('#simplemodal-container').css("top", mtop+'px');
	
	$('#simplemodal-container').css("width",'500px');
	$('#simplemodal-container').css("height",'480px');
	
}

function show_publish() {
	$('#publish_modal').modal();
	
	
	var wscr = $(window).width();
    var hscr = $(window).height();
    
    // obtener posicion central
    var mleft = ( wscr - 500 ) / 2;
    var mtop = ( hscr - 480 ) / 2;
    
    // estableciendo ventana modal en el centro
    $('#simplemodal-container').css("left", mleft+'px');
    $('#simplemodal-container').css("top", mtop+'px');
	
	$('#simplemodal-container').css("width",'500px');
	$('#simplemodal-container').css("height",'480px');
	
}


// When the form is submitted
function login(){  

	var email = $("#emailLogin").val();
    var password = $("#passwordLogin").val();
	
	if ((email=="") || (password=="")) {
		$('#error_msg').html('Existen campos vacíos.');
		return false;
	}
	
	/*if (!echeck(email)) {
		$('#error_msg').html('Email incorrecto.');
		return false;
	}*/

    // Hide 'Submit' Button
    $('#submitLogin').val('Enviando');
    $('#submitLogin').attr("disabled", "true");
    $('#emailLogin').attr("disabled", "true");
    $('#passwordLogin').attr("disabled", "true");

    // Show Gif Spinning Rotator
	$('#error_msg').hide();


    var dataObj = ({email : email,
        method: 'login',
        password: password
        });
    // -- Start AJAX Call --
    $.ajax({
    	type: "POST",
    	url: "/ajaxController.php",
    	data: dataObj,
    	cache: false,
    	success: function(result){
            if(result=='invalid') {
                //notify the user that the login was wrong
                $('#submitLogin').val('Enviar');
                $("#error_msg").show();
                $("#error_msg").html('E-mail o password incorrectos.');
                $('#submitLogin').removeAttr("disabled");
                $('#emailLogin').removeAttr("disabled");
    			$('#passwordLogin').removeAttr("disabled");
            } else {
            	location.reload();
            }
        
    	},
        error:function (xhr, ajaxOptions, thrownError){
                alert('Runnity' + xhr.status + "\n" + thrownError);
        }
    });
    
    return false;
}

function sendPassword() {
	$('#error_msg').html('');
	$('#submitLogin').val('Enviar');
	$("#FormularioLogin").attr("action","javascript: void sendPasswordTo();"); 
	$('#passForm').hide();
	$('#forgetLink').removeAttr("href");
	$('#forgetLink').html('Introduce tu e-mail.');
	$('#loginEmailText').html('Te enviaremos tu contraseña');
}


function sendPasswordTo() {

	$('#error_msg').html('');

	var email = $("#emailLogin").val();
	
	if (email=="") {
		$('#error_msg').html('El email esta vacío.');
    	return false;
	} 
	
	if (!echeck(email)) {
    	$('#error_msg').html('Tu email es incorrecto.');
    	return false;
    }
	
	$('#submitLogin').attr('value','Enviando');
	
	var dataObj = ({method: 'sendPasswordToEmail', email:email});  
	  
    $.ajax({
    	type: "POST",
    	url: "/ajaxController.php",
    	data: dataObj,
    	cache: false,
    	success: function(result){
    		if(result=='') {
    			$('#passForm').show();
    			$('#loginEmailText').html('email');
    			$("#FormularioLogin").attr("action","javascript: void login();");
    			$('#submitLogin').attr('value','Enviar');
    			$('#forgetLink').html('Contraseña enviada.');
    			$('#forgetLink').css('color','#c24949');
    			timerID = setTimeout("changeText()", 2000);
            } else {
            	$('#submitLogin').attr('value','Enviar');
            	$('#error_msg').html('El email no existe.');       
            }
    	},
        error:function (xhr, ajaxOptions, thrownError){
                alert(xhr.status + "\n" + thrownError);
        }
    });
}

//PARA QUE SE CIERRE SOLO LA VENTANA DE LOGIN
function changeText() {
	$('#forgetLink').html('¿olvidaste tu contraseña?');
	$('#forgetLink').css('color','#336699');
	$('#forgetLink').attr("href","javascript: void sendPassword()");
    clearTimeout(timerID);
}


function alertLogout() {
	$('#logoutWindow').modal();
	
	
	var wscr = $(window).width();
    var hscr = $(window).height();
    
    // obtener posicion central
    var mleft = ( wscr - 330 ) / 2;
    var mtop = ( hscr - 100 ) / 2;
    
    // estableciendo ventana modal en el centro
    $('#simplemodal-container').css("left", mleft+'px');
    $('#simplemodal-container').css("top", mtop+'px');
	
	$('#simplemodal-container').css("width",'330px');
	$('#simplemodal-container').css("height",'100px');
	
}

function logout () {

	var dataObj = ({method: 'logout'});    
    $.ajax({
    	type: "POST",
    	url: "/ajaxController.php",
    	data: dataObj,
    	cache: false,
    	success: function(result){
    		window.location = "/";
    	},
        error:function (xhr, ajaxOptions, thrownError){
             window.location = "/";
        }
    });
    
}




function commentAction(tipo,id,on_table,comment) {
		
		//comment = comment.replace('\"','"');
		if(tipo=='User') {
		    var dataObj = ({
		            comment : comment,
		            method: 'addCommentUser',
		            id:id,onTable:on_table
		        });
	
			if(comment=='') {
		    	alert('El comentario esta vacío, mejor revísalo.');
		    } else {
				$("#flash").show();
				$("#flash").fadeIn(400).html('<img src="/img/ajax-loader.gif" align="absmiddle" style="height:20px;width:20px;padding-top:4px;padding-left:5px;">&nbsp;<span style="margin-top:-15px;">Cargando comentario...</span>');
				$.ajax({
					type: "POST",
		 	 		url: "/ajaxController.php",
		   			data: dataObj,
		  			cache: false,
		  			success: function(html){
		  				$("ol#update").append(html);
		  				$("ol#update li:last").fadeIn(400);
						$('#commentTextArea').val('');
		  				$("#flash").hide();
		  			},
			        error:function (xhr, ajaxOptions, thrownError){
			                alert('Runnity' + xhr.status + "\n" + thrownError);
			        }
		 		});
		 			
			}
		}else if(tipo=='Run') {
			var dataObj = ({
	            comment : comment,
	            method: 'addComment',
	            id:id,onTable:on_table
	        });
	
			if(comment=='') {
		    	alert('El comentario esta vacío, mejor revísalo.');
		    } else {
				$("#flash").show();
				$("#flash").fadeIn(400).html('<img src="/img/ajax-loader.gif" align="absmiddle" style="height:20px;width:20px;padding-top:4px;padding-left:5px;">&nbsp;<span style="margin-top:-15px;">Cargando comentario...</span>');
				$.ajax({
					type: "POST",
		 	 		url: "/ajaxController.php",
		   			data: dataObj,
		  			cache: false,
		  			success: function(html){
		  				$("ol#update").append(html);
		  				$("ol#update li:last").fadeIn(400);
						$('#commentTextArea').val('');		
		  				$("#flash").hide();
		  			},
			        error:function (xhr, ajaxOptions, thrownError){
			                alert('Runnity' + xhr.status + "\n" + thrownError);
			        }
		 		});
		 			
			}
		}else if (tipo=='Picture'){
			var dataObj = ({
	            comment : comment,
	            method: 'addComment',
	            id:id,onTable:on_table
	        });
	
			if(comment=='') {
		    	alert('El comentario esta vacío, mejor revísalo.');
		    } else {
				$("#flash").show();
				$("#flash").fadeIn(400).html('<img src="/img/ajax-loader.gif" align="absmiddle" style="height:20px;width:20px;padding-top:4px;padding-left:5px;">&nbsp;<span style="margin-top:-15px;">Cargando comentario...</span>');
				$.ajax({
					type: "POST",
		 	 		url: "/ajaxController.php",
		   			data: dataObj,
		  			cache: false,
		  			success: function(html){
		  				$("ol#update").append(html);
		  				$("ol#update li:last").fadeIn(400);
						$('#commentTextArea').val('');		
		  				$("#flash").hide();

		  			},
			        error:function (xhr, ajaxOptions, thrownError){
			                alert('Runnity' + xhr.status + "\n" + thrownError);
			        }
		 		});
		 			
			}
		}
		return false;
};

//INSCRIBIRSE O QUITARSE LA CARRRERA
function inscribirseCarrera(userID,raceID) {
	
		$('#ticketOrangeVoy').html('<b><a><div class="checkboxUnchecked"></div></a><p id="textoInscribirse">Actualizando...</p></b>');
		var dataObj = ({runId : raceID,
	        method: 'inscribeUserToRun',
	        userId: userID
	        });
	    
	 	$.ajax({
	    	type: "POST",
	    	url: "/ajaxController.php",
	    	data: dataObj,
	    	cache: false,
	    	success: function(result){     				
				$('#ticketOrangeVoy').html('<b><a><div class="checkboxChecked"></div></a><p id="textoInscribirse">Crees que irás a la carrera</p></b>');	    	
				},
	        error:function (xhr, ajaxOptions, thrownError){   
	                alert('Runnit' + xhr.message + "\n" + thrownError);
	        }
	    });
    return false;
}


//SEGUIR A UN USUARIO
function followUser(friendId) {
	
		
$('#ticketOrangeVoy').html('<b><a><div class="checkboxUnchecked"></div></a><p id="textoInscribirse">Actualizando...</p></b>');
		var dataObj = ({
			method: 'setUserToFriend',
	        friendId: friendId
	        });
	    
	 	$.ajax({
	    	type: "POST",
	    	url: "/ajaxController.php",
	    	data: dataObj,
	    	cache: false,
	    	success: function(result){     				
				$('#ticketOrangeVoy').html('<b><a><div class="checkboxChecked"></div></a><p id="textoInscribirse">Ya sigues a este usuario</p></b>');	    	
				},
	        error:function (xhr, ajaxOptions, thrownError){   
	                alert('Runnit' + xhr.message + "\n" + thrownError);
	        }
	    });

    return false;
}




//MANDAR MENSAJE DE CONTACTO
function sendMessage() {

    $('#contactError').html('');

    var name = $("#contact1").val();
    var email = $("#contact2").val();
    var message = $("#contact3").val();

    if ((name=="") || (email=="") || (message=="")) {
        $('#contactError').html('Existen campos vacíos.');
        return false;
    }

    if (!echeck(email)) {
        $('#contactError').html('Tu email es incorrecto.');
        return false;
    }

    $('#contactSubmit').val('Enviando');
    $('#contactSubmit').attr("disabled", "true");
    $("#contact1").attr("disabled", "true");
    $("#contact2").attr("disabled", "true");
    $("#contact3").attr("disabled", "true");


    var dataObj = ({nombre : name,
        method: 'sendEmailToAlertas',
        mensaje: message,
        email: email
    });


        $.ajax({
        type: "POST",
        url: "/ajaxController.php",
        data: dataObj,
        cache: false,
        success: function(result){
                var h = 100;
                $('#contact_container').html('');
                $('#contact_container').append('<h2 style="width:450px; text-align: center;">Gracias por enviar tu sugerencia</h2>');
                $('#contact_container').append('<div style="text-align:center;width:450px;color:#336699;margin-top:-20px">Gracias por enviar tus comentarios, en breve se cerrará esta ventana.</div>');
                $('div.simplemodal-data').animate({height:100},500);

               	timerID = setTimeout("timerHide()", 2000);
        },
        error:function (xhr, ajaxOptions, thrownError){
                alert('Runnity' + xhr.message + "\n" + thrownError);
        }
    });

    return false;

}


function timerHide () {
    $.modal.close();
    clearTimeout(timerID);
}



function geolocateAddress(keymapvalue) {
	
	$('#error_geo').html(''); 
		
		
    var addressval = $("#roundLocalizacion").val();
    var dataObj = ({address : addressval,method: 'geolocateAddress'});
    
    if(addressval="") {
    		return false; 
    }
    
    $('#buttonLocalizacion').val('...');
		$('#buttonLocalizacion').attr("disabled", "true"); 
		
    // -- Start AJAX Call --
    $.ajax({
        type: "POST",
        url: "/ajaxController.php",
        data: dataObj,
        cache: false,
        success: function(result){
            if(result=="INVALID") {
                //notify the user that the username is free
                $('#error_geo').html("La dirección no se ha encontrado");
                $('#buttonLocalizacion').val('Situar');
				$('#buttonLocalizacion').removeAttr("disabled");                
            } else {
                //notify the user that the username is used.
                var lat = result.split(",")[0];
                var lon = result.split(",")[1];
                $('#latHidden').attr("value", lat);
                $('#lonHidden').attr("value", lon);
                $('#buttonLocalizacion').val('Situar');
				$('#buttonLocalizacion').removeAttr("disabled"); 
								
                var url='http://maps.google.com/maps/api/staticmap?size=334x141&maptype=roadmap&center='+lat+','+lon+'&zoom=8&markers=size:mid|color:red|'+lat+','+lon+'&mobile=true&sensor=false&key='+keymapvalue+'';
         	    $("#map").attr("src",url);                
                
            }
       
        },
        error:function (xhr, ajaxOptions, thrownError){
        	$('#buttonLocalizacion').val('Situar');
			$('#buttonLocalizacion').removeAttr("disabled"); 
            $('#error_geo').html("La dirección no se ha encontrado");
        }
    });
    
    return false;
    
    
}

function checkEmail(){

	var email = $("#inputRegister1").val();
    
    if ((email=='') || (email.length<5) || !(echeck(email))) {
    	$('#checkEmailBox').hide();
 		return false;
 	}
    $('#result').html('');
    $('#emailImage').attr("src", "/img/ajax-loader.gif");   
    $('#checkEmailBox').show();
    $('#emailImage').show();
    
   

    var dataObj = ({email : email,method: 'isEmailFree'});
    
       
    // -- Start AJAX Call --
    $.ajax({
        type: "POST",
        url: "/ajaxController.php",
        data: dataObj,
        cache: false,
        success: function(result){
            if(result=="valid") {
                //notify the user that the username is free
                $('#emailImage').show();
                $('#emailImage').attr("src", "/img/ok.png");
                
            } else {
                //notify the user that the username is used.
                $('#emailImage').show();
                $('#emailImage').attr("src", "/img/ko.png");
                $('#result').css('color','#c24949');
                $('#result').html('Ups, el email ya está registrado');
            }
       
        },
        error:function (xhr, ajaxOptions, thrownError){
                alert('Runnity' + xhr.status + "\n" + thrownError);
        }
    });
    
    return false;

}



function checkUsername(){

	var name = $("#inputRegister3").val();
    
    if ((name=='') || (name.length<5)) {
    	$('#checkUserBox').hide();
 		return false;
 	}
    $('#answer').html('');
    $('#registerImage').attr("src", "/img/ajax-loader.gif");   
    $('#checkUserBox').show();
    $('#registerImage').show();
    
   

    var dataObj = ({username : name,method: 'isUsernameFree'});
    
       
    // -- Start AJAX Call --
    $.ajax({
        type: "POST",
        url: "/ajaxController.php",
        data: dataObj,
        cache: false,
        success: function(result){
            if(result=="valid") {
                //notify the user that the username is free
                $('#registerImage').show();
                $('#registerImage').attr("src", "/img/ok.png");
                 $('#answer').css('color','green');
                $('#answer').html('Buen nombre');
                
            } else {
                //notify the user that the username is used.
                $('#registerImage').show();
                $('#registerImage').attr("src", "/img/ko.png");
                $('#answer').css('color','#c24949');
                $('#answer').html('Ups, está cogido');
            }
       
        },
        error:function (xhr, ajaxOptions, thrownError){
                alert('Runnity' + xhr.status + "\n" + thrownError);
        }
    });
    
    return false;

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



//MANDAR MENSAJE DE PUBLICAR CARRERA
function publishRun() {

    $('#contactError2').html('');

    var publishName = $("#publishName").val();
    var publishDate = $("#publishDate").val();
    var publishData = $("#publishData").val();
    var publishEmail = $("#publishEmail").val();

    if ((publishName=="") || (publishDate=="") || (publishData=="") || (publishEmail=="")) {
        $('#contactError2').html('Existen campos vacíos.');
        return false;
    }

    if (!echeck(publishEmail)) {
        $('#contactError2').html('Tu email es incorrecto.');
        return false;
    }

    $('#contactPublish').val('Enviando');
    $('#contactPublish').attr("disabled", "true");
    $("#publishName").attr("disabled", "true");
    $("#publishDate").attr("disabled", "true");
    $("#publishData").attr("disabled", "true");
    $("#publishEmail").attr("disabled", "true");



    var dataObj = ({nombre : publishName,
        method: 'sendEmailPublish',
        data: publishData,
        date: publishDate,
        email: publishEmail
    });


        $.ajax({
        type: "POST",
        url: "/ajaxController.php",
        data: dataObj,
        cache: false,
        success: function(result){
                $('div.publish_container').html('');
                $('div.publish_container').append('<h2 style="width:450px; text-align: center;">Gracias por enviar tu carrera</h2>');
                $('div.publish_container').append('<div style="text-align:center;width:450px;color:#336699;margin-top:-20px">Gracias por enviar la carrera, en breve se cerrará esta ventana.</div>');
                $('#publish_modal').animate({height:100},500);

               	timerID = setTimeout("timerHide()", 2000);
        },
        error:function (xhr, ajaxOptions, thrownError){
                alert('Runnity' + xhr.message + "\n" + thrownError);
        }
    });

    return false;

}


function gup( name )
{
  name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
  var regexS = "[\\?&]"+name+"=([^&#]*)";
  var regex = new RegExp( regexS );
  var results = regex.exec( window.location.href );
  if( results == null )
    return "";
  else
    return results[1];
}


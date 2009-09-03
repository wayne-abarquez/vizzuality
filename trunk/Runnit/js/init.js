
//FUNCIONES QUE SE REALIZAN CUANDO EL DOCUMENTO ESTA LISTO
$(document).ready( function() {

	$('textarea').autoResize({
	    // On resize:
	    onResize : function() {
	        $(this).css({opacity:0.8});
	    },
	    // After resize:
	    animateCallback : function() {
	        $(this).css({opacity:1});
	    },
	    // Quite slow animation:
	    animateDuration : 300,
	    // More extra space:
	    extraSpace : 40
	});
    
});


//FUNCIONES PARA REDONDEAR INPUTS
function roundInput(input_id, container_class, border_class){
	var input = $('#'+input_id+'');
	var input_width = input.css("width"); //get the width of input
	var wrap_width = parseInt(input_width) + 10; //add 10 for padding
	wrapper = input.wrap("<div class='"+container_class+"'></div>").parent();
	wrapper.wrap("<div class='"+border_class+"' style='width: "+wrap_width+"px;'></div>"); //apply border
	wrapper.corner("round 8px").parent().css('padding', '2px').corner("round 10px"); //round box and border
}


$(function(){
	roundInput('rounded_input1','rounded_container','rounded_border');
	roundInput('rounded_input2','rounded_container','rounded_border');
});

 
 
//FUNCION PARA CALCULAR EL TIEMPO 
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



// PARA ABRIR VENTANAS MODALES
function showLoginBox() {
	$('#loginWindow').modal();	
};


function showRegisterBox() {
	$('#registerWindow').modal();
	
	
	var wscr = $(window).width();
    var hscr = $(window).height();
    
    // obtener posicion central
    var mleft = ( wscr - 500 ) / 2;
    var mtop = ( hscr - 390 ) / 2;
    
    // estableciendo ventana modal en el centro
    $('#simplemodal-container').css("left", mleft+'px');
    $('#simplemodal-container').css("top", mtop+'px');
	
	$('#simplemodal-container').css("width",'500px');
	$('#simplemodal-container').css("height",'390px');
	
};

function showContactBox() {
	$('#contactWindow').modal();
	
	
	var wscr = $(window).width();
    var hscr = $(window).height();
    
    // obtener posicion central
    var mleft = ( wscr - 500 ) / 2;
    var mtop = ( hscr - 320 ) / 2;
    
    // estableciendo ventana modal en el centro
    $('#simplemodal-container').css("left", mleft+'px');
    $('#simplemodal-container').css("top", mtop+'px');
	
	$('#simplemodal-container').css("width",'500px');
	$('#simplemodal-container').css("height",'320px');
	
};



/* FUNCION PARA COMENTAR -- REVISAR -- */
function commentAction(idRun) {
		
		var comment = $("#commentTextArea").val();
	    var dataObj = ({comment : comment,
	        method: 'addComment',id:idRun
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
	    			$('#commentTextArea').html('');
	  				$("#flash").hide();
	  			},
		        error:function (xhr, ajaxOptions, thrownError){
		                alert('Runnity' + xhr.status + "\n" + thrownError);
		        }
	 		});
		}
		return false;
};



//REGISTER SECTION

function checkUsername(){  

	var name = $("#popup_register1").val();
	
	if (name=="") {
		return false;
	}
	
    // Show Gif Spinning Rotator
    var registerImage = document.getElementById("registerImage");
    $('#registerImage').hide();
    $('#answer').html('');
    
    

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
            	registerImage.setAttribute("src", "/img/ok.png");
            	$('#answer').html('Buen nombre');
            } else {
        		//notify the user that the username is used.
        		$('#registerImage').show();
        		registerImage.setAttribute("src", "/img/ko.png");
            	$('#answer').html('Ups, está cogido...cachis');
            }
        
    	},
        error:function (xhr, ajaxOptions, thrownError){
                alert('Runnity' + xhr.status + "\n" + thrownError);
        }
    });
  
    // -- End AJAX Call --

    return false;

}

function registerUser(){  
    
    //Hacer comprobaciones -> ningun campo blanco - contraseña mayor de 7 - email correcto -> Registro()
    var username = $("#popup_register1").val();
    var name = $("#popup_register2").val();
    var pass = $("#popup_register3").val();
    var email = $("#popup_register4").val();
    var answer = $("#answer").html();
    
    if ((username=="") || (name=="") || (pass=="")) {
    	$('#registerError').html('Hay campos vacíos.');
    	return false;
    }
    
    
    if (answer=='Ups, está cogido...cachis') {
    	$('#registerError').html('Ese nombre de usuario ya esta registrado.');
    	return false;
    }
    
    if (pass.length<7) {
    	$('#registerError').html('El password debe ser mayor de 5 caracteres.');
    	return false;
    }
    
    if (!echeck(email)) {
    	$('#registerError').html('Tu email es incorrecto.');
    	return false;
    }
    
    
     $('#registerError').fadeIn(400).html('<img src="/img/ajax-loader.gif" class="registerImage">');
    
    
 
	var dataObj = ({username : username,name: name,password:pass, email:email ,method: 'register'});
        
    // -- Start AJAX Call --
    $.ajax({
    	type: "POST",
    	url: "/ajaxController.php",
    	data: dataObj,
    	cache: false,
    	success: function(result){ 
    			directLogin(email,pass,username);
    	},
        error:function (xhr, ajaxOptions, thrownError){   
        		$('#registerError').show();
                $('#registerError').html('Este email ya está en uso.');
        }
    });
    return false;
}


function directLogin(email,pass,user) {
	var dataObj = ({email : email,
    method: 'login',
    password: pass
    });
    // -- Start AJAX Call --
    $.ajax({
    	type: "POST",
    	url: "/ajaxController.php",
    	data: dataObj,
    	cache: false,
    	success: function(result){
    			window.location="/user/" + user;
            	$('#registerError').html(''); 
		    	var h = 150;
		    	$('#registerError').fadeIn(400).html('');  
		    	$('#registerTitle').html('Gracias por registrarte ' + user);
		    	$('#conditions').hide();
		    	$('#registerForm').html('<div class="margin10"><div class="inputTitle" style="text-align:center;">Gracias por haberte registrado, en breves momentos recibirás un email con tus datos.</div></div>');
				$('#simplemodal-container').animate({height: h},500);          	     
    	},
        error:function (xhr, ajaxOptions, thrownError){
                alert('Runnity' + xhr.status + "\n" + thrownError);
        }
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



/* LOGIN SECTION */

// When the form is submitted
function login(){  

	var email = $("#emailLogin").val();
    var password = $("#passwordLogin").val();
	
	if ((email=="") || (password=="")) {
		$('#error_msg').html('Existen campos vacíos.');
		return false;
	}

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
		$('#contactError').html('El email esta vacío.');
    	return false;
	} 
	
	if (!echeck(email)) {
    	$('#contactError').html('Tu email es incorrecto.');
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
    		if(result=='OK') {
    			$('#passForm').show();
    			$('#loginEmailText').html('email');
    			$("#FormularioLogin").attr("action","javascript: void login();");
    			$('#submitLogin').attr('value','Enviar');
    			$('#forgetLink').html('Contraseña enviada.');
    			$('#forgetLink').css('color','red');
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
	$('#logoutButtons').html('<div class="span-8" style="text-align:center;color:#336699;">Cerrando sesión...</div>');
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
	
	$('#contactButton').val('Enviando');
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
			$('#contactForm').html(''); 
    		var h = 100;
    		$('#contactTitle').html('Gracias por enviar tu sugerencia ');
    		$('#contactForm').html('<div style="text-align:left;width:400px;color:#336699;padding-left:20px;margin-top:-20px">Gracias por enviar tus comentarios, en breve se cerrará esta ventana.</div>');
			$('#simplemodal-container').animate({height: h},500);
			
			timerID = setTimeout("timerHide()", 2000);
    	},
        error:function (xhr, ajaxOptions, thrownError){   
                alert('Runnit' + xhr.message + "\n" + thrownError);
        }
    });

    return false;

}

function timerHide () {
	$.modal.close();
    clearTimeout(timerID);
}



/* INSCRIBIRSE / QUITARSE CARRERAS */

function checkInscrito(str) {
	var valor = $('#inscriptionButton').val();
	
	if (str=="ok") {
		if (valor=="apúntate") {
		
			$('#confirmationWindow').modal();
			
			var wscr = $(window).width();
		    var hscr = $(window).height();
		    
		    // obtener posicion central
		    var mleft = ( wscr - 380 ) / 2;
		    var mtop = ( hscr - 100 ) / 2;
		    
		    // estableciendo ventana modal en el centro
		    $('#simplemodal-container').css("left", mleft+'px');
		    $('#simplemodal-container').css("top", mtop+'px');
			
			$('#simplemodal-container').css("width",'400px');
			$('#simplemodal-container').css("height",'100px');
			
		} else {
		
			$('#confirmationWindow').modal();
			$('#titleConfirmation').html('¿Quieres quitarte de esta carrera?');
			
			var wscr = $(window).width();
		    var hscr = $(window).height();
		    
		    // obtener posicion central
		    var mleft = ( wscr - 380 ) / 2;
		    var mtop = ( hscr - 100 ) / 2;
		    
		    // estableciendo ventana modal en el centro
		    $('#simplemodal-container').css("left", mleft+'px');
		    $('#simplemodal-container').css("top", mtop+'px');
			
			$('#simplemodal-container').css("width",'400px');
			$('#simplemodal-container').css("height",'100px');
		}
	} else {
		$('#loginWindow').modal();
	}
}





//INSCRIBIRSE O QUITARSE LA CARRRERA
function inscribirseCarrera(userID,raceID) {

	if ($('#titleConfirmation').html()=="¿Quieres quitarte de esta carrera?") {
	
		$('#confirmationButtons').html('<div class="span-9" style="text-align:center;color:#336699;padding-left:10px;">Borrándote de la carrera...</div>');
		var dataObj = ({runId : raceID,
	        method: 'unInscribeUserToRun',
	        userId: userID
	        });
	        
	    $.ajax({
	    	type: "POST",
	    	url: "/ajaxController.php",
	    	data: dataObj,
	    	cache: false,
	    	success: function(result){    				
						$('#inscriptionButton').val('apúntate');
						$.modal.close();
	    	},
	        error:function (xhr, ajaxOptions, thrownError){   
	                alert('Runnit' + xhr.message + "\n" + thrownError);
	        }
	    });
	    
	} else {
	
		$('#confirmationButtons').html('<div class="span-9" style="text-align:center;color:#336699;padding-left:10px;">Inscribiendote a la carrera...</div>');
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
						$('#inscriptionButton').val('voy a ir');
						$.modal.close();
	    	},
	        error:function (xhr, ajaxOptions, thrownError){   
	                alert('Runnit' + xhr.message + "\n" + thrownError);
	        }
	    });
	}
    return false;
}


//ALERTAS POR LOCALIDAD
function activateAlerts() {
	$('#alertError').html('');

	var lugar = $("#input6").val();
    var radio = $("#input7").val();
	
	if ((lugar=="") || (radio=="")) {
		$('#alertError').html('Existen campos vacíos.');
		return false;
	}
	
	$("#alertButton").attr("disabled", "true");
    $("#input6").attr("disabled", "true");
    $("#input7").attr("disabled", "true");
	
	$('#alertButton').val('Activando...');
	
/*
    var dataObj = ({runId : $se,
        method: 'inscribeUserToRun',
        userId: userID
        });
    
 	$.ajax({
    	type: "POST",
    	url: "/ajaxController.php",
    	data: dataObj,
    	cache: false,
    	success: function(result){     				
					$('#inscriptionButton').val('voy a ir');
					$.modal.close();
    	},
        error:function (xhr, ajaxOptions, thrownError){   
                alert('Runnit' + xhr.message + "\n" + thrownError);
        }
    });
*/
     
}


function desactivateAlerts() {

}




//CAMBIO DE DATOS EN USUARIO

function changeUserData (pass,mail,longName,userN) {
	
	$('#userError').html('');

	var name = $("#input1").val();
    var user = $("#input2").val();
    var email = $("#input3").val();
    	
	if ((name=="") || (email=="") || (user=="")) {
		$('#userError').html('Existen campos vacíos.');
		return false;
	}
	
	if ((name==longName) && (email==mail) && (user==userN)) {
		$('#userError').html('No has realizado cambios.');
		return false;
	}
	
	if (!echeck(email)) {
    	$('#contactError').html('Tu email es incorrecto.');
    	return false;
    }
	
	
	$("#input1").attr("disabled", "true");
    $("#input3").attr("disabled", "true");
    $('#userSaveData').attr('disabled','true');
	
	$('#userSaveData').val('Guardando...');
	
	
	var dataObj = ({name : name,
        method: 'updateUser',
        username: user, email:email, password: pass
        });
    
 	$.ajax({
    	type: "POST",
    	url: "/ajaxController.php",
    	data: dataObj,
    	cache: false,
    	success: function(result){     				
					$("#input1").attr("disabled", "false");
				    $("#input3").attr("disabled", "false");
				    $('#userSaveData').attr('disabled','false');
					
					$('#userSaveData').val('Guardado!');
					timerID = setTimeout("changeTextUser()", 2000);
    	},
        error:function (xhr, ajaxOptions, thrownError){   
                alert('Runnit' + xhr.message + "\n" + thrownError);

        }
    });
	
}


function changeTextUser () {
	$('#userSaveData').val('Guardar cambios');
    clearTimeout(timerID);
}


function changePassData (pass,mail,longName,userN) {
	
	$('#userError').html('');

	var passOld = $("#input4").val();
    var passNew = $("#input5").val();
    	
	if ((passOld=="") || (passNew=="")) {
		$('#userError').html('Existen campos vacíos.');
		return false;
	}
	
	
	if (passOld==passNew) {
		$('#userError').html('Son iguales.');
		return false;
	}

	
	
	$("#input4").attr("disabled", "true");
    $("#input5").attr("disabled", "true");
    $('#userSaveData').attr('disabled','true');
	
	$('#passSaveData').val('Actualizando...');
	
	
	var dataObj = ({name : longName,
        method: 'updateUser',
        username: userN, email:mail, password: passNew
        });
    
 	$.ajax({
    	type: "POST",
    	url: "/ajaxController.php",
    	data: dataObj,
    	cache: false,
    	success: function(result){     				
					$("#input4").removeAttr('disabled');
				    $("#input5").removeAttr('disabled');
				    $("#input4").val('');
				    $("#input5").val('');
				    $('#userSaveData').removeAttr('disabled');
					
					$('#passSaveData').val('Actualizado!');
					timerID = setTimeout("passTextUser()", 2000);
    	},
        error:function (xhr, ajaxOptions, thrownError){   
                alert('Runnit' + xhr.message + "\n" + thrownError);

        }
    });
	
}


function passTextUser () {
	$('#passSaveData').val('Cambiar contraseña');
    clearTimeout(timerID);
}

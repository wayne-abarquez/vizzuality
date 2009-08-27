
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
    		$('#registerError').html(''); 
    		var h = 100;
    		$('#registerError').fadeIn(400).html('');  
    		$('#registerTitle').html('Gracias por registrarte ' + result);
    		$('#conditions').hide();
    		$('#registerForm').html('<div class="margin10"><div class="inputTitle" style="text-align:center;">Gracias por haberte registrado, en breves momentos recibirás un email con tus datos.</div></div>');
			$('#simplemodal-container').animate({height: h},500);
    	},
        error:function (xhr, ajaxOptions, thrownError){   
                alert('Runnit' + xhr.message + "\n" + thrownError);
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
                //login ok. Close the popup and change the login menu in the header
                $("#loginBox").css('text-align','right');
                $("#loginBox").css('padding-right','27px');
                $("#loginBox").html("<a href='./usuario.php' class='blackLogin'>" + result + '</a> | <a id="logoutRef" class="hrefText" href="javascript: void alertLogout()"> Salir</a> ');
                $("#commentBox").html("<div class='span-14 titleComents'>Anímate y publica tu comentario</div><textarea name='textarea2' id='commentTextArea' class='span-15 textArea'></textarea><input class='fg-button ui-state-default ui-corner-all' type='submit' value='Publicar comentario'/>");   
                $.modal.close();         
            }
        
    	},
        error:function (xhr, ajaxOptions, thrownError){
                alert('Runnity' + xhr.status + "\n" + thrownError);
        }
    });
    
    return false;
}


//PARA QUE SE CIERRE SOLO LA VENTANA DE LOGIN
function timerHide() {
     $.modal.close();
     //document.getElementById("login").style.display = "none";
     clearTimeout(timerID);
}

function sendPassword() {
	$('#error_msg').html('');
	$('#submitLogin').val('Enviar');
	$("#FormularioLogin").attr("action","javascript: void sendPasswordTo();"); 

/* 	$('#submitLogin').attr('onClick','javascript: void sendPasswordTo();'); */
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
               	$('#error_msg').html('El email existe.');
            } else {
            	$('#error_msg').html('El email no existe.');       
            }
    	},
        error:function (xhr, ajaxOptions, thrownError){
                alert(xhr.status + "\n" + thrownError);
        }
    });
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
    		$("#loginBox").css('text-align','left');
    		$("#loginBox").css('padding-left','30px');
    		$("#loginBox").css('padding-right','0px');
    		$("#loginBox").html("<div class='loginText' id='loginBox'><a href='javascript: void showLoginBox()' class='hrefText'>accede a tu cuenta</a><a class='normalText'> ó </a><a href='javascript: void showRegisterBox()' class='hrefText'>registrate</a></div>");
    		$("#commentBox").html("Lo siento no puedes comentar sin estar registrado");
    		$.modal.close();
    	},
        error:function (xhr, ajaxOptions, thrownError){
                alert(xhr.status + "\n" + thrownError);
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
    		/* $('#registerError').fadeIn(400).html(''); */  
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

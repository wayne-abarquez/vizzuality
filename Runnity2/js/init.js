$(document).ready(function(){

	  Cufon.replace('.horizontalcssmenu',{hover: true});
	  Cufon.replace('.subTitle');
	  Cufon.replace('.subTitleInfo');
	  Cufon.replace('.titularTitle');
	  Cufon.replace('.raceTitle');
	  Cufon.replace('.buttonmenuContainer a');
	  Cufon.replace('.titleBoxRegister p');
	  Cufon.replace('#login_modal .title');
	  Cufon.replace('.nameUserProfile');
	  Cufon.replace('.nameUserProfileNick');


      var match = 'input.default[@type=text]';
      $(match).focus(function(){
      	this.valuedefault = this.valuedefault || this.value;
      	if (this.value == this.valuedefault)
      		this.value = '';
      	$(this).css('color','#666666');
      });
      $(match).blur(function(){
      	if (this.value.length == 0 || this.value == this.valuedefault)
      		$(this).css('color','#999999');
      	if (this.valuedefault && this.value.length==0)
      	this.value = this.valuedefault;
      });

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

/* LOGIN */

function showLoginWindow() {
	$('#login_modal').modal();
}

function show_contact() {
	$('#contact_modal').modal();
	
	
	var wscr = $(window).width();
    var hscr = $(window).height();
    
    // obtener posicion central
    var mleft = ( wscr - 500 ) / 2;
    var mtop = ( hscr - 500 ) / 2;
    
    // estableciendo ventana modal en el centro
    $('#simplemodal-container').css("left", mleft+'px');
    $('#simplemodal-container').css("top", mtop+'px');
	
	$('#simplemodal-container').css("width",'500px');
	$('#simplemodal-container').css("height",'500px');
	
}

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




function commentAction(id,on_table) {
		
		var comment = $("#commentTextArea").val();
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
	    			$('#commentTextArea').html('');
	  				$("#flash").hide();
	  				
	  				if($("#noCommentsDiv").length > 0) {
	  				    $("#noCommentsDiv").hide();
	  				}
	  			},
		        error:function (xhr, ajaxOptions, thrownError){
		                alert('Runnity' + xhr.status + "\n" + thrownError);
		        }
	 		});
	 			
		}
		return false;
};

//INSCRIBIRSE O QUITARSE LA CARRRERA
function inscribirseCarrera(userID,raceID) {
	
		$('#ticketOrangeVoy').html('<b><a><div class="checkboxUnchecked"></div></a><p id="textoInscribirse">Incribiéndote a esta carrera...</p></b>');
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
				$('#ticketOrangeVoy').html('<b><a><div class="checkboxChecked"></div></a><p id="textoInscribirse">Estoy apuntado a esta carrera</p></b>');	    	
				},
	        error:function (xhr, ajaxOptions, thrownError){   
	                alert('Runnit' + xhr.message + "\n" + thrownError);
	        }
	    });
    return false;
}


//INSCRIBIRSE O QUITARSE LA CARRRERA
function seguirUsuario(userID,userToID) {
	
		/*
$('#ticketOrangeVoy').html('<b><a><div class="checkboxUnchecked"></div></a><p id="textoInscribirse">Procesando...</p></b>');
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
				$('#ticketOrangeVoy').html('<b><a><div class="checkboxChecked"></div></a><p id="textoInscribirse">Ya sigues a este usuario</p></b>');	    	
				},
	        error:function (xhr, ajaxOptions, thrownError){   
	                alert('Runnit' + xhr.message + "\n" + thrownError);
	        }
	    });
*/
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
                $('#contact_modal').html('');
                var h = 100;
                $('#contactTitle').html('Gracias por enviar tu sugerencia ');
                $('#contactForm').html('<div style="text-align:left;width:400px;color:#336699;padding-left:20px;margin-top:-20px">Gracias por enviar tus comentarios, en breve se cerrará esta ventana.</div>');
                $('#simplemodal-container').animate({height: h},500);

               /*  timerID = setTimeout("timerHide()", 2000); */
        },
        error:function (xhr, ajaxOptions, thrownError){
                alert('Runnit' + xhr.message + "\n" + thrownError);
        }
    });

    return false;

}


function registerUser() {

	$('#error_register').html('');

	var email = $("#inputRegister1").val();
	var contraseña = $("#inputRegister2").val();
	var user = $("#inputRegister3").val();
	var nombre = $("#inputRegister4").val();
	var check = $('#quiero').attr('checked');
	var localidad = $("#roundLocalization").val();
		
	if ($('#quiero').attr('checked')) {
		if (localidad =="") {
			$('#error_register').html('Existen campos vacíos');
			return false;
		}
	}
	
	if ((email=="") || (contraseña=="") || (user=="") || (nombre =="")) {
		$('#error_register').html('Existen campos vacíos');
		return false;
	}
	
	
	if ((email.length<5) || (contraseña.length<5) || (user.length<5) || (nombre.length<5)) {
		$('#error_register').html('Existen campos con pocos caracteres');
		return false;
	}
	
	if (!echeck(email)) {
    	$('#error_register').html('Tu email es incorrecto');
    	return false;
    }
	
	$("#inputRegister1").attr("disabled", "true");
	$("#inputRegister2").attr("disabled", "true");
	$("#inputRegister3").attr("disabled", "true");
	$("#inputRegister4").attr("disabled", "true");
	$('#quiero').attr("disabled", "true");
	$("#roundLocalization").attr("disabled", "true");
	$("#combo_anio").attr("disabled", "true");
	$("#combo_sex").attr("disabled", "true");
	
	
	$('#register_input').attr('value','Enviando');
	
	$("#register_input").attr("disabled", "true");
	
	var dataObj = ({method: 'sendPasswordToEmail', email:email});  
	  
    /*$.ajax({
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
    });*/
}




function cleanDate() {
	if ($('#widgetField span').html()!='Selecciona una fecha<a class="delete"></a>') {
			
			$('#widgetField span').html('Selecciona una fecha<a class="delete"></a>');
			$("#fechaInicio").attr("value", null);
			$("#fechaFin").attr("value", null);
		}

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

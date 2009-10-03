$(document).ready(function(){

	  Cufon.replace('.horizontalcssmenu',{hover: true});
	  Cufon.replace('.subTitle');
	  Cufon.replace('.subTitleInfo');
	  Cufon.replace('.titularTitle');
	  Cufon.replace('.raceTitle');
	  Cufon.replace('.nameUser');
	  Cufon.replace('.buttonmenuContainer a');
	  Cufon.replace('#login_modal .title');


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






/* FUNCION PARA COMENTAR -- REVISAR -- */
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


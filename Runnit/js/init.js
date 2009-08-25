
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

	//Hack en internet explorer para dropdownlist
	var browserName=navigator.appName; 
	if (browserName=="Microsoft Internet Explorer"){
	   $('#category').css("display",'none');
	   $('#select').css("margin-left",'0px');
	   $('#select').css("margin-top",'6px');
	}
	 

	var url = "http://twitter.com/status/user_timeline/runn_it.json?count=1&callback=?";
	$.getJSON(url,function(data){	
		$.each(data, function(i, item) {
			$("img#profile").attr("src", item.user["profile_image_url"]);
			$("#tweets").append( item.text.linkify() + relative_time(item.created_at));
		});
    });
    
});



String.prototype.linkify = function() {
	return this.replace(/[A-Za-z]+:\/\/[A-Za-z0-9-_]+\.[A-Za-z0-9-_:%&\?\/.=]+/, function(m) {
		return m.link(m);
	});
}; 
 
 
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

function twitter_callback (){
	return true;
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
function commentAction() {

		var comment = $("#comment").val();
	    var dataObj = ({comment : comment,
	        method: 'addComment'
	        });

		if(comment=='') {
	    	alert('Error, comment area empty');
	    } else {
			$("#flash").show();
			$("#flash").fadeIn(400).html('<img src="/img/ajax-loader.gif" align="absmiddle">&nbsp;<span class="loading">Loading Comment...</span>');
			$.ajax({
				type: "POST",
	 	 		url: "ajaxController.php",
	   			data: dataObj,
	  			cache: false,
	  			success: function(html){
	  				$("ol#update").append(html);
	  				$("ol#update li:last").fadeIn("slow");
	    			document.getElementById('comment').value='';
	  				$("#flash").hide();
	  			}
	 		});
		}
		return false;
};


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


//COMBOBOX EN JQUERY
/*function updateField(target,selected) {
	document.getElementById(target).value =$(selected.options[selected.selectedIndex]).html();
}*/




//REGISTER SECTION

function checkUsername(){  

	var name = $("#popup_register1").val();
	
	if (name=="") {
		return false;
	}
	
    // Show Gif Spinning Rotator
    var registerImage = document.getElementById("registerImage");
    registerImage.setAttribute("src", "../img/ajax-loader.gif");
    $('#registerImage').show();
    $('#answer').html('');
    
    

    var dataObj = ({username : name,method: 'isUsernameFree'});
        
    // -- Start AJAX Call --
    $.ajax({
    	type: "POST",
    	url: "ajaxController.php",
    	data: dataObj,
    	cache: false,
    	success: function(result){
            if(result=="valid") {
                //notify the user that the username is free
            	registerImage.setAttribute("src", "../img/ok.png");
            	$('#answer').html('Buen nombre');
            } else {
        		//notify the user that the username is used.
        		registerImage.setAttribute("src", "../img/ko.png");
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
    
    
    $('#registerError').fadeIn(400).html('<img src="../img/ajax-loader.gif" class="registerImage">');
    
    
 
	var dataObj = ({username : username,name: name,password:pass, email:email ,method: 'register'});
        
    // -- Start AJAX Call --
    $.ajax({
    	type: "POST",
    	url: "ajaxController.php",
    	data: dataObj,
    	cache: false,
    	success: function(result){ 
    		$('#registerError').html(''); 
    		var h = 100;
    		$('#registerError').fadeIn(400).html('');  
    		$('#registerTitle').html('Gracias por registrarte ' + result[0].username);
    		$('#conditions').hide();
    		$('#registerForm').html('<div class="margin10"><div class="inputTitle" style="text-align:center;">Gracias por haberte registrado, en breves momentos recibirás un email con tus datos.</div></div>');
			$('#simplemodal-container').animate({height: h},500);

        
    	},
        error:function (xhr, ajaxOptions, thrownError){
                
                alert('Runnit' + xhr.message + "\n" + thrownError);
        }
    });

  
    // -- End AJAX Call --
    

    return false;

}

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



//FUNCIONES QUE SE REALIZAN CUANDO EL DOCUMENTO ESTA LISTO
  $(document).ready( function() {
		
	    var browserName=navigator.appName; 
		 if (browserName=="Microsoft Internet Explorer"){
		  $('#category').css("display",'none');
		  $('#select').css("margin-left",'0px');
		  $('#select').css("margin-top",'6px');
		 }
		 
		
		
		var url = "http://twitter.com/status/user_timeline/runn_it.json?count=1&callback=?";
		$.getJSON(url,
        function(data){
			$.each(data, function(i, item) {
				$("img#profile").attr("src", item.user["profile_image_url"]);
				$("#tweets").append( item.text.linkify() + relative_time(item.created_at) + " via " + item.source + ".");
			});
        });
        
        $("textarea").TextAreaExpander();
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
	    r = '<p> Hace un par de minutos';
	  } else if(delta < (45*60)) {
	    r = '<p> Hace ' + (parseInt(delta / 60)).toString() + ' minutos';
	  } else if(delta < (90*60)) {
	    r = '<p> Hace una hora';
	  } else if(delta < (24*60*60)) {
	    r = '<p> Hace ' + (parseInt(delta / 3600)).toString() + ' horas';
	  } else if(delta < (48*60*60)) {
	    r = '<p> Hace un día';
	  } else {
	    r ='<p> Hace ' + (parseInt(delta / 86400)).toString() + ' días';
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
    var mtop = ( hscr - 390 ) / 2;
    
    // estableciendo ventana modal en el centro
    $('#simplemodal-container').css("left", mleft+'px');
    $('#simplemodal-container').css("top", mtop+'px');
	
	$('#simplemodal-container').css("width",'500px');
	$('#simplemodal-container').css("height",'390px');

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
			$("#flash").fadeIn(400).html('<img src="/images/ajax-loader.gif" align="absmiddle">&nbsp;<span class="loading">Loading Comment...</span>');
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
function updateField(target,selected) {
	document.getElementById(target).value =$(selected.options[selected.selectedIndex]).html();
}
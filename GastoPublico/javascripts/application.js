var $j = jQuery;
var map;

$(document).ready(function() {
  var myOptions = {
      zoom: 13,
      center: new google.maps.LatLng(40.4166909, -3.7003454),
      disableDefaultUI: true,
      scrollwheel:false,
      mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  map = new google.maps.Map(document.getElementById("map"), myOptions);

	//OBRA LENGTH
	var left_work = $('div.left_region_work').height();
	var right_work = $('div.renovation_content').height();

	if (left_work<right_work) {
			$('div.left_region_work').height(right_work-279);
	} else {
		 	$('div.renovation_content').height(left_work+279);
	}


	//MUNICIPIO LENGTH
	var left_lenght = $('div#layout div.left_region').innerHeight()-226;
	var right_lenght = $('div#layout div.right_region').innerHeight();
	if (left_lenght<right_lenght) {
		if ($.browser.mozilla) {
		    $('div.left_region').height(right_lenght + 189);
		 } else {
				$('div.left_region').height(right_lenght + 261);
		}
	} else {
		if ($.browser.mozilla) {
		    $('div.right_region').height(left_lenght-122);
		 } else {
				$('div.right_region').height(left_lenght+208);
		}
	}
	


});


$j(function(){
	$j("input[name=search]").prompt("Busca tu municipio...");
});
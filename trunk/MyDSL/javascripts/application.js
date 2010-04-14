$(document).ready(function() {
	
	// HEADER EFFECTS
	$('#country_link').click (function(ev) {
		ev.preventDefault();
		ev.stopPropagation();
		$('#country_list').stop().animate({
		    height: 134
		  }, 500);
		$('#alert_popup').fadeOut();
	});
	
	$('#country_list').click (function(ev) {
		ev.preventDefault();
		ev.stopPropagation();
		$('#country_list').stop().animate({
		    height: 0
		  }, 500);
	});
	
	$('#alert_link').click (function(ev) {
		ev.preventDefault();
		ev.stopPropagation();
		$('#country_list').stop().animate({
		    height: 0
		  }, 500);
		$('#alert_popup').fadeIn();
	});
	
	$('#alert_popup').click (function(ev) {
		ev.preventDefault();
		ev.stopPropagation();
		$('#alert_popup').fadeOut();
	});
	
	
	// MENU EFFECTS
	
	$('#dashboard').hover(function(ev) {
		$('#dashboard_hover').show();
	});
	$('#dashboard_hover').hover(function(){},function(ev) {
		$('#dashboard_hover').hide();
	});
	$('#services').hover(function(ev) {
		$('#services_hover').show();
	});
	$('#services_hover').hover(function(){},function(ev) {
		$('#services_hover').hide();
	});
	$('#shared').hover(function(ev) {
		$('#shared_reports_hover').show();
	});
	$('#shared_reports_hover').hover(function(){},function(ev) {
		$('#shared_reports_hover').hide();
	});
	
	
	// SEGMENT EFFETS
	
	$('#grow_detail').click (function(ev) {
		ev.preventDefault();
		ev.stopPropagation();
			if ($(this).children('img').attr('src')=='/images/plus.png') {
				$(this).attr('style',"position:absolute; top:344px; left:460px");
				$(this).children('img').attr('src','/images/delete.png');
				$('#detail_container').stop().animate({
				    height: 181
				  }, 500);
			} else {
				$(this).attr('style',"position:absolute; top:348px; left:464px");
				$(this).children('img').attr('src','/images/plus.png');
				$('#detail_container').stop().animate({
				    height: 0
				  }, 500);
			}
	});
	
	$('#new_segment').click (function(ev) {
		ev.preventDefault();
		ev.stopPropagation();
		$(this).fadeOut();
		$('#new_segment_container').stop().animate({
		    height: 330
		  }, 500);
	});
	
	$('#create_segment_top').click (function(ev) {
		ev.preventDefault();
		ev.stopPropagation();
		$('#new_segment').fadeOut();
		$.scrollTo('#new_segment_box',500,function(ev){
			$('#new_segment_container').stop().animate({
			    height: 330
			  }, 500);
		});
	});
	
	

});
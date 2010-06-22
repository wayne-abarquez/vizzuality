
function White_Marker(latlng,opts,map) {
  google.maps.OverlayView.call(this);
  this.latlng_ = latlng;
  this.map_ = map;
  this.offsetVertical_ = 14;
  this.offsetHorizontal_ = 14;
  this.height_ = 28;
  this.width_ = 28;
	this.information_ = opts;

  var me = this;

}

White_Marker.prototype = new google.maps.OverlayView();

White_Marker.prototype.remove = function() {
  if (this.div_) {
    this.div_.parentNode.removeChild(this.div_);
    this.div_ = null;
  }
};

White_Marker.prototype.draw = function() {
  this.createElement();
  if (!this.div_) return;

  var pixPosition = this.getProjection().fromLatLngToDivPixel(this.latlng_);
  if (!pixPosition) return;

  this.div_.style.width = this.width_ + "px";
  this.div_.style.left = (pixPosition.x + this.offsetHorizontal_) + "px";
  this.div_.style.height = this.height_ + "px";
  this.div_.style.top = (pixPosition.y + this.offsetVertical_) + "px";
	
	$(this.div_).fadeIn('fast');
	
};

White_Marker.prototype.createElement = function() {
  var panes = this.getPanes();
	var this_ = this;
  var div = this.div_;
  if (!div) {

    div = this.div_ = document.createElement("div");
		$(div).addClass('marker_infowindow');
    div.style.border = "0px none";
    div.style.position = "absolute";
    div.style.background = "url('images/markers/18_white.png') no-repeat 0 0";
    div.style.width = "28px";
    div.style.height = "28px";
		div.style.cursor = 'pointer';
	
		var hiddenDiv = document.createElement('div');
		hiddenDiv.style.position = "absolute";
		hiddenDiv.style.display = 'none';
		hiddenDiv.style.top = '-172px';
		hiddenDiv.style.left = '-147px'; 
    hiddenDiv.style.width = "342px";
    hiddenDiv.style.height = "185px";
		hiddenDiv.style.background = "url('images/infowindows/bkg_white.png') no-repeat 0 0";
		hiddenDiv.style.cursor = 'default';
		
		var close = document.createElement('a');
		close.style.position = "absolute";
		close.style.top = '-7px';
		close.style.right = '-3px'; 
    close.style.width = "17px";
    close.style.height = "17px";
		close.style.background = "url(images/infowindows/close_window.png) no-repeat 0 -17px";
		$(close).hover(function(ev){
			$(this).css('background','url(images/infowindows/close_window.png) no-repeat 0 0');
		}, function(ev){
			$(this).css('background','url(images/infowindows/close_window.png) no-repeat 0 -17px');
		});
		close.style.cursor = "pointer";
		hiddenDiv.appendChild(close);
	
		var imgDiv = document.createElement('div');
		imgDiv.style.position = "absolute";
		imgDiv.style.top = '13px';
		imgDiv.style.left = '11px'; 
		imgDiv.style.width = "108px";
		imgDiv.style.height = "83px";
		imgDiv.style.border = '1px solid #CCCCCC';
		hiddenDiv.appendChild(imgDiv);
	
		var image_place = document.createElement("img");
		image_place.style.position = "absolute";
		image_place.style.float = 'left';
	  image_place.style.width = "100px";
	  image_place.style.height = "75px";
		image_place.style.border = '4px solid #E5E5E5';
	  if (this.information_.pictures.length>0) {
			image_place.src = this.information_.pictures[0];
		} else {
			image_place.src = 'http://mw2.google.com/mw-panoramio/photos/small/5110708.jpg';
		}
		imgDiv.appendChild(image_place);

		var title = document.createElement('p');
		title.style.float = "left";
		title.style.margin = '12px 0 0 132px';
		title.style.padding = '0';
	  title.style.width = "189px";
		title.style.height = "37px";
		title.style.overflow = "hidden";
		
		var link_title = document.createElement('a');
		link_title.style.font = 'bold 15px Arial';
		link_title.style.color = '#006699';
		link_title.style.lineHeight = '13px';
		if (this.information_.title.length>40) {
			$(link_title).text(this.information_.title.substr(0,40)+'...');
		} else {
			$(link_title).text(this.information_.title);
		}
		$(link_title).attr('href',this.information_.href);
		$(link_title).css('text-decoration','none');
		$(link_title).hover(function(ev){
			$(this).css('text-decoration','underline');
		}, function(ev){
			$(this).css('text-decoration','none');
		});
		title.appendChild(link_title);
		
		hiddenDiv.appendChild(title);
		
		var country = document.createElement('p');
		country.style.float = "left";
		country.style.padding = '0';
		country.style.width = "180px";
		country.style.margin = '2px 0 0 132px';
		country.style.font = 'normal 13px Arial';
		country.style.color = '#999999';
		if (this.information_.funding!=null || this.information_.funding!=undefined) {
			if (this.information_.country.length>20) {
				$(country).text(this.information_.country.substr(0,17)+'... ' +this.information_.funding+'$');
			} else {
				$(country).text(this.information_.country+'. '+this.information_.funding+'$');
			}
		} else {
			$(country).html(this.information_.country);
		}
		hiddenDiv.appendChild(country);
	
	
		var good_div = document.createElement('div');
		good_div.style.margin = '9px 0 0 132px';
		good_div.style.position = "relative";
		good_div.style.float = "left";
	  good_div.style.width = "193px";
		
		var good_for = document.createElement('img');
		good_for.style.float = 'left';
	  good_for.style.width = "auto";
	  good_for.style.height = "auto";
		good_for.style.padding = "0";
		good_for.src = './images/infowindows/good_for.png';
		good_div.appendChild(good_for);
	
		var image_1 = document.createElement("img");
		image_1.style.float = 'left';
	  image_1.style.width = "auto";
	  image_1.style.height = "auto";
		image_1.style.padding = "1px 0 0 6px";
		image_1.alt="Climate change mitigation";
		image_1.src = './images/icons/1.jpg';
		if (this.information_.ecosystem_service.e1) {
			good_div.appendChild(image_1);
		}
		
		var image_2 = document.createElement("img");
		image_2.style.float = 'left';
	  image_2.style.width = "auto";
	  image_2.style.height = "auto";
		image_2.alt="Climate change adaption";
		image_2.style.padding = "1px 0 0 3px";
		image_2.src = './images/icons/2.jpg';
		if (this.information_.ecosystem_service.e2) {
			good_div.appendChild(image_2);
		}
		
		var image_3 = document.createElement("img");
		image_3.style.float = 'left';
	  image_3.style.width = "auto";
	  image_3.style.height = "auto";
		image_3.alt="Freshwater security";
		image_3.style.padding = "1px 0 0 3px";
		image_3.src = './images/icons/3.jpg';
		if (this.information_.ecosystem_service.e3) {
			good_div.appendChild(image_3);
		}
		
		var image_4 = document.createElement("img");
		image_4.style.float = 'left';
	  image_4.style.width = "auto";
		image_4.alt="Food security";
	  image_4.style.height = "auto";
		image_4.style.padding = "1px 0 0 3px";
		image_4.src = './images/icons/4.jpg';
		if (this.information_.ecosystem_service.e4) {
			good_div.appendChild(image_4);
		}
		
		var image_5 = document.createElement("img");
		image_5.style.float = 'left';
	  image_5.style.width = "auto";
	  image_5.style.height = "auto";
		image_5.alt="Human Health";
		image_5.style.padding = "1px 0 0 3px";
		image_5.src = './images/icons/5.jpg';
		if (this.information_.ecosystem_service.e5) {
			good_div.appendChild(image_5);
		}
		
		var image_6 = document.createElement("img");
		image_6.style.float = 'left';
	  image_6.style.width = "auto";
		image_6.alt="Cultural and Spiritual Access";
	  image_6.style.height = "auto";
		image_6.style.padding = "1px 0 0 3px";
		image_6.src = './images/icons/6.jpg';
		if (this.information_.ecosystem_service.e6) {
			good_div.appendChild(image_6);
		}
		
		var image_7 = document.createElement("img");
		image_7.style.float = 'left';
	  image_7.style.width = "auto";
		image_7.alt ="Income Generation";
	  image_7.style.height = "auto";
		image_7.style.padding = "1px 0 0 3px";
		image_7.src = './images/icons/7.jpg';
		if (this.information_.ecosystem_service.e7) {
			good_div.appendChild(image_7);
		}

		hiddenDiv.appendChild(good_div);

	
		var donor_div = document.createElement('div');
		donor_div.style.float = "left";
		donor_div.style.margin = '20px 0 0 10px';
		donor_div.style.position = "relative";
	  donor_div.style.width = "315px";
		
		var donor_title = document.createElement('p');
		donor_title.style.position = "relative";
		donor_title.style.float = "left";
		donor_title.style.textAlign = "right";
		donor_title.style.width = "110px";
		donor_title.style.font = 'normal 10px Arial';
		donor_title.style.margin = '0';
		donor_title.style.padding = '1px 0 0 0';
		donor_title.style.lineHeight = '10px';
		donor_title.style.color = '#FF9900';
		$(donor_title).text('DONOR');
		$(donor_title).css('background','url(images/infowindows/donor.png) no-repeat 60px 1px');
		donor_div.appendChild(donor_title);
		
		var donor_p = document.createElement('p');
		donor_p.style.position = "absolute";
		donor_p.style.right = "0px";
		donor_p.style.top = "0px";
		donor_p.style.textAlign = "left";
		donor_p.style.width = "194px";
		donor_p.style.font = 'bold 11px Arial';
		donor_p.style.color = '#FF9900';
		$(donor_p).text(this.information_.organisation);
		donor_div.appendChild(donor_p);
		
	
		hiddenDiv.appendChild(donor_div);
	

    div.appendChild(hiddenDiv);

    function removeInfoBox(ib) {
      return function() {
        ib.setMap(null);
      };
    }

		$(close).click(
			function (ev) {
				$(this).parent().hide();
				ppe_close = true;
			}
		);
		
		$(div).hover(
			function (ev) {
				$(this).css('z-index',lastMask+1);
				lastMask++;
			}
		);

		$(div).click(
			function (ev) {
				ppe_close = true;
				if ($(ev.target).hasClass('marker_infowindow')) {
					if (!$(this).children('div').is(':visible')) {
						if (this_.map_.getZoom()<6) {
							this_.map_.setCenter(this_.latlng_);
							this_.map_.setZoom(6);
							this_.map_.panBy(0,-90);
						} else {
							if (!$(this).children('div').is(':visible')) {
								this_.map_.setCenter(this_.latlng_);
								this_.map_.panBy(0,-90);
							}
						}
					}
					
					if ( $(this).children('div').is(':visible')) {
						$(this).children('div').hide();
					} else {	
						$(this).parent().trigger("close_image");
						$(this).parent().bind('close_image', function() {
							$(this).children('div').children('div').hide();
						});				
						lastMask++;
						$(this).children('div').css('z-index',lastMask+1);
						$(this).css('z-index',lastMask);
						$(this).children('div').show();
					}
				}
			}
		);

    panes.floatPane.appendChild(div);				
		
    this.panMap();
  } else if (div.parentNode != panes.floatPane) {
    div.parentNode.removeChild(div);
    panes.floatPane.appendChild(div);
  }
}

White_Marker.prototype.getPosition = function() {
    return this.latlng_;
};

White_Marker.prototype.panMap = function() {

};

White_Marker.prototype.setIcon = function(source,type) {
	$(this.div_).css('background','url("'+source+'") no-repeat 0 0');
	if (type=='far') {
		$(this.div_).css('height','28px');
		$(this.div_).css('width','28px');
		$(this.div_).children('div').css('left','-147px');
	  this.offsetVertical_ = -14;
	  this.offsetHorizontal_ = -14;
	  this.height_ = 28;
	  this.width_ = 28;
	} else {
		$(this.div_).css('height','54px');
		$(this.div_).css('width','52px');
		$(this.div_).children('div').css('left','-135px');
	  this.offsetVertical_ = -54;
	  this.offsetHorizontal_ = -26;
	  this.height_ = 54;
	  this.width_ = 52;
	}
	
};

White_Marker.prototype.setVisible = function(bool) {
	if (bool) {
		this.setMap(this.map_);
	} else {
		this.setMap(null);
	}	
};


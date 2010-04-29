var lastMask = 10000;

function Yellow_Marker(latlng,opts,map) {
  google.maps.OverlayView.call(this);
  this.latlng_ = latlng;
  this.map_ = map;
  this.offsetVertical_ = -14;
  this.offsetHorizontal_ = -14;
  this.height_ = 28;
  this.width_ = 28;
	this.information_ = opts;

  var me = this;

	
  // this.setMap(this.map_);
}

Yellow_Marker.prototype = new google.maps.OverlayView();

Yellow_Marker.prototype.remove = function() {
  if (this.div_) {
    this.div_.parentNode.removeChild(this.div_);
    this.div_ = null;
  }
};

Yellow_Marker.prototype.draw = function() {
  // Creates the element if it doesn't exist already.
  this.createElement();
  if (!this.div_) return;

  // Calculate the DIV coordinates of two opposite corners of our bounds to
  // get the size and position of our Bar
  var pixPosition = this.getProjection().fromLatLngToDivPixel(this.latlng_);
  if (!pixPosition) return;

  // Now position our DIV based on the DIV coordinates of our bounds
  this.div_.style.width = this.width_ + "px";
  this.div_.style.left = (pixPosition.x + this.offsetHorizontal_) + "px";
  this.div_.style.height = this.height_ + "px";
  this.div_.style.top = (pixPosition.y + this.offsetVertical_) + "px";
	
	$(this.div_).fadeIn('fast');
  // this.div_.style.display = 'block';
};

Yellow_Marker.prototype.createElement = function() {
  var panes = this.getPanes();
  var div = this.div_;
  if (!div) {
    // This does not handle changing panes.  You can set the map to be null and
    // then reset the map to move the div.
    div = this.div_ = document.createElement("div");
    div.style.border = "0px none";
    div.style.position = "absolute";
    div.style.background = "url('images/markers/18_yellow.png') no-repeat 0 0";
    div.style.width = "28px";
    div.style.height = "28px";
		div.style.cursor = 'pointer';
	
	var hiddenDiv = document.createElement('div');
	hiddenDiv.style.position = "absolute";
	hiddenDiv.style.display = 'none';
	hiddenDiv.style.top = '-115px';
	hiddenDiv.style.left = '-147px'; 
    hiddenDiv.style.width = "342px";
    hiddenDiv.style.height = "125px";
	hiddenDiv.style.background = "url('images/infowindows/bkg_yellow.png') no-repeat 0 0";
    hiddenDiv.style.cursor = "pointer";
	
	
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
    image_place.style.cursor = "pointer";
	image_place.style.border = '4px solid #E5E5E5';
    image_place.src = 'http://mw2.google.com/mw-panoramio/photos/small/5110708.jpg';
	//image_place.src = this.information_.image;
    imgDiv.appendChild(image_place);

	var title = document.createElement('p');
	title.style.float = "left";
	title.style.padding = '0';
	title.style.margin = '15px 0 0 132px';
	title.style.font = 'bold 15px Arial';
	title.style.color = '#006699';
	$(title).html('Management support to the Northern Reefs...');
	//$(title).html(this.information_.username);
    title.style.width = "189px";
	hiddenDiv.appendChild(title);
		
	var country = document.createElement('p');
	country.style.float = "left";
	country.style.padding = '0';
	country.style.width = "210px";
	country.style.margin = '2px 0 0 132px';
	country.style.font = 'normal 13px Arial';
	country.style.color = '#999999';
	$(country).html('Palau. 396,250$ required');
	//$(country).html(this.information_.ago);

    country.style.width = "103px";
	hiddenDiv.appendChild(country);
	
	var activity_kind = document.createElement('p');
	activity_kind.style.position = "relative";
	activity_kind.style.float = "left";
	activity_kind.style.padding = '0';
	activity_kind.style.margin = '11px 0 0 70px';
	activity_kind.style.font = 'bold 11px Arial';
	activity_kind.style.color = '#006699';
	$(activity_kind).html(this.information_.kind);
    activity_kind.style.width = "103px";
	hiddenDiv.appendChild(activity_kind);

    div.appendChild(hiddenDiv);

    function removeInfoBox(ib) {
      return function() {
        ib.setMap(null);
      };
    }

		// div.style.display = 'none';

		$(div).click(
			function (ev) {
				if ( $(this).children('div').is(':visible')) {
					$(this).children('div').hide();
				} else {
					lastMask++;
					$(this).children('div').css('z-index',lastMask+1);
					$(this).css('z-index',lastMask);
					$(this).children('div').show();
				}
			}
		);

    panes.floatPane.appendChild(div);				
		
    this.panMap();
  } else if (div.parentNode != panes.floatPane) {
    // The panes have changed.  Move the div.
    div.parentNode.removeChild(div);
    panes.floatPane.appendChild(div);
  }
}

Yellow_Marker.prototype.getPosition = function() {
    return this.latlng_;
};

Yellow_Marker.prototype.panMap = function() {

};

Yellow_Marker.prototype.setIcon = function(source,type) {
	$(this.div_).css('background-image','url('+source+')');
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


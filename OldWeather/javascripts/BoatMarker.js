

function BoatMarker(latlng,width_,height_,image,map) {
  google.maps.OverlayView.call(this);
  this.latlng_ = latlng;
  this.map_ = map;
  this.height_ = height_;
  this.width_ = width_;
  this.offsetVertical_ = this.height_ + 17;
  this.offsetHorizontal_ = (this.width_-2)/2;
	this.image_ = image;

  var me = this;
	this.setMap(this.map_);
	

	
}

BoatMarker.prototype = new google.maps.OverlayView();

BoatMarker.prototype.remove = function() {
  if (this.div_) {
    this.div_.parentNode.removeChild(this.div_);
    this.div_ = null;
  }
};

BoatMarker.prototype.draw = function() {
  this.createElement();
  if (!this.div_) return;

  var pixPosition = this.getProjection().fromLatLngToDivPixel(this.latlng_);
  if (!pixPosition) return;

  this.div_.style.width = this.width_ + "px";
  this.div_.style.left = (pixPosition.x - this.offsetHorizontal_) + "px";
  this.div_.style.height = this.height_ + "px";
  this.div_.style.top = (pixPosition.y - this.offsetVertical_) + "px";
	
	$(this.div_).fadeIn('fast');
};

BoatMarker.prototype.createElement = function() {
  var panes = this.getPanes();
	var this_ = this;
  var div = this.div_;
  if (!div) {
	
		div = this.div_ = document.createElement("div");
    div.style.border = "0px none";
    div.style.position = "absolute";
    div.style.width = this.width_ + 6 + "px";
    div.style.height = this.height_ + 12 + "px";
	
		var boat_image = document.createElement('div');
		boat_image.style.position = "absolute";
		boat_image.style.top = '0';
		boat_image.style.left = '0'; 
    boat_image.style.width = this.width_ + "px";
    boat_image.style.height = this.height_ + "px";
		boat_image.style.border = "3px solid #E54E1A";
		boat_image.style.background = "url("+ this.image_ +") no-repeat 0 0 white";
		div.appendChild(boat_image);

	
		var mini_marker = document.createElement('div');
		mini_marker.style.position = "absolute";
		mini_marker.style.bottom = '-20px';
		mini_marker.style.left = ((this.width_/2) - 16) + 'px'; 
		mini_marker.style.width = "32px";
		mini_marker.style.height = "38px";
		mini_marker.style.background = "url('images/home/mini_marker.png') no-repeat 0 0";
		div.appendChild(mini_marker);


    panes.floatPane.appendChild(div);				
		
  } 
}




package com.vizzuality.markers{
	
	import com.google.maps.LatLng;
	
	import flare.vis.data.NodeSprite;
	
	import flash.display.Shape;
	
	public class ClusterMarkerIcon extends NodeSprite {	

		public var location:LatLng;
		
        public function ClusterMarkerIcon(ll:LatLng) {
        		super();
        		location=ll;
                var background:Shape = new Shape();
	            background.graphics.beginFill(0xFFFFFF,1);
	            background.graphics.drawCircle(0,0,5);
	            background.graphics.endFill();
	            addChild(background);
	            
                
        }
      }
      
 }

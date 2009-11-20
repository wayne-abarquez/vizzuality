package org.vizzuality.maps
{
    import com.google.maps.Copyright;
    import com.google.maps.CopyrightCollection;
    import com.google.maps.LatLng;
    import com.google.maps.LatLngBounds;
    import com.google.maps.TileLayerBase;
    import com.google.maps.interfaces.IMap;
    
    import flash.display.DisplayObject;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.TimerEvent;
    import flash.geom.Point;
    import flash.net.URLRequest;
    import flash.utils.Timer;

    public class GeoserverTileLayer extends TileLayerBase
    {  
        private var srvNum:Number=0;   
        public var numRunningRequest:Number=0;		
		private var previousNum:Number;     
		
		private var _ed:EventDispatcher;
		private var discardTimer:Timer;
		public var isOverFeature:Boolean=false;
		public var map:IMap;
		
        public function GeoserverTileLayer(_map:IMap)
        {
        	
        	map=_map;
            
            var copyrightCollection:CopyrightCollection = new CopyrightCollection();
            copyrightCollection.addCopyright(new Copyright("ennefox", new LatLngBounds(new LatLng(-180, 90), new LatLng(180, -90)), 21,"ennefox"));            
            super(copyrightCollection, 0, 23,0.7);
            
			_ed= new EventDispatcher(); 
			discardTimer = new Timer(5000,0);
			discardTimer.addEventListener(TimerEvent.TIMER,checkRequests,false,0,true);
			discardTimer.start();           
            
        }       
        
        public override function loadTile(tile:Point,zoom:Number):DisplayObject {
            
            if (!isNaN(tile.x) && !isNaN(tile.y) && zoom >= 0) {               
                if(zoom>8) {
	                var tileUrl:String = "http://174.129.214.28:8080/geowebcache/service/gmaps?layers=ppe:ppeblue&zoom=|Z|&x=|X|&y=|Y|";                    
                    srvNum++;
                   if (srvNum>3)
                       srvNum=0;        
                       
                   if (tileUrl.indexOf("|N|")>0)
                       tileUrl = tileUrl.replace("|N|",srvNum);
                   
                   tileUrl = tileUrl.replace("|X|",tile.x);    
                   tileUrl = tileUrl.replace("|Y|",tile.y);    
                   tileUrl = tileUrl.replace("|Z|",zoom);  
                } else {
            		tileUrl = getTilesURLforS3("http://ppe.org.tiles.s3.amazonaws.com",
            			"ppe_ppeblue",tile,zoom,"EPSG_900913")                	
                }            
    
    			if(numRunningRequest<1) {
    				dispatchEvent(new Event("GEOSERVER_TILE_LAYER_LOADING"));
    			}
                var customTile:CustomTile = new CustomTile(this,tileUrl);
                return customTile;    
            }
            return null;
        }
        
        
        public function possiblyFireEvent():void {
             if(numRunningRequest<1) {
            	dispatchEvent(new Event("GEOSERVER_TILE_LAYER_LOADED"));
            	discardTimer.stop();
            } else {
            	if (!discardTimer.running) {
	            	discardTimer.start();
            	}
            }       	
        }   
        
		private function checkRequests(event:Event):void {
			if (previousNum == numRunningRequest) {
				previousNum = 0;
				numRunningRequest = 0;
				dispatchEvent(new Event("GEOSERVER_TILE_LAYER_LOADED"));
				discardTimer.stop();
			} else {
				previousNum = numRunningRequest;
			}
		}          

        private function getTilesURLforS3(prefix:String, layerName:String, tile:Point, z:int, gridSetId:String):String {
        	
        	//put the map params in the 
        	var x:int = tile.x;
	        var y:int = tile.y;
	        
	        y = (Math.pow(2,z)-1) - y;
	        
	        var gridSetStr:String = filteredGridSetId(gridSetId);
	        var layerStr:String = filteredLayerName(layerName);	        
	        var paramstr:String = "";
	              
	        var shift:Number= z / 2;
        	var half:Number= 2<< shift;
        	var digits:int= 1;
        
	        if (half > 10) {
	            digits = int((Math.log(half)* Math.LOG10E) + 1);
	        }
        	      
	        var halfx:int = Number(x / half);
	        var halfy:int = Number(y / half);
        
			var ret:String = prefix + "/" + layerStr + "/"
              		+ gridSetStr + "_" + zeroPadder(z, 2) +  "/"
              		+ zeroPadder(halfx, digits) + "_" 
              		+ zeroPadder(halfy, digits) + "/" + zeroPadder(x, 2* digits) + "_" + zeroPadder(y, 2* digits) + ".png";
                
               return ret;
        	
        }


        
        private function filteredGridSetId(gridSetId:String):String
        {
        	 return gridSetId.replace(':', '_');
        	      	
        }
        
        private function  filteredLayerName(layerName:String):String {
	        return layerName.replace(':', '_').replace(' ', '_');
	    } 
         
	    private function zeroPadder(number:Number, order:Number):String {
	        var numberOrder:Number= 1;
	
	        if (number > 9) {
	            if(number > 11) {
	                numberOrder = Number(Math.ceil((Math.log(number)* Math.LOG10E) - 0.001));
	            } else {
	                numberOrder = 2;
	            }
	        }
	
	        var diffOrder:Number= order - numberOrder;
	        
	        if(diffOrder > 0) {
	            var padding:String= new String();
	            
	            while (diffOrder > 0) {
	                padding = padding + "0";
	                diffOrder--;
	            }
	            return padding.toString() + number.toString();
	        } else {
	            return number.toString();
	        }
	    }       
	    
	     
		public function addEventListener(type:String, listener:Function,useCapture:Boolean=false, priority:int=0,useWeakReference:Boolean=false):void {
			_ed.addEventListener(type,listener, useCapture, priority, useWeakReference);
		}
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void {
			_ed.removeEventListener(type, listener,useCapture);
		}
		public function dispatchEvent(event:Event):Boolean {
			return _ed.dispatchEvent(event);
		}
		public function hasEventListener(type:String):Boolean {
			return _ed.hasEventListener(type);
		}
		public function willTrigger(type:String):Boolean {
			return _ed.willTrigger(type);
		}        
       
        
        
    }
}
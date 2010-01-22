package com.vizzuality.tileoverlays
{
    import com.google.maps.Copyright;
    import com.google.maps.CopyrightCollection;
    import com.google.maps.LatLng;
    import com.google.maps.LatLngBounds;
    import com.google.maps.TileLayerBase;
    
    import flash.display.DisplayObject;
    import flash.events.IOErrorEvent;
    import flash.geom.Point;
    import flash.net.URLRequest;

    public class GeoserverTileLayer extends TileLayerBase
    {  
        private var srvNum:Number=0;   
        private var customTile:CustomTile;	
        private var addMouseOverListener:Boolean;
     
        public function GeoserverTileLayer(_addMouseOverListener:Boolean=true)
        { 
            
            addMouseOverListener=_addMouseOverListener;
            var copyrightCollection:CopyrightCollection = new CopyrightCollection();
            copyrightCollection.addCopyright(new Copyright("ennefox", new LatLngBounds(new LatLng(-180, 90), new LatLng(180, -90)), 21,"ennefox"));            
            super(copyrightCollection, 0, 23,0.7);
            
        }
        
        public override function loadTile(tile:Point,zoom:Number):DisplayObject {
            
            if (!isNaN(tile.x) && !isNaN(tile.y) && zoom >= 0) {
                customTile = new CustomTile(addMouseOverListener);
                customTile.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler,false,0,true);
                
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
    
                customTile.loader.load(new URLRequest(tileUrl));
                return customTile;    
            }
            return null;
        }
        
        private function ioErrorHandler(event:IOErrorEvent):void {
            event.currentTarget.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
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
        
        
        
    }
}
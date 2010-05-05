package com.vizzuality.maps
{
	import com.google.maps.Copyright;
	import com.google.maps.CopyrightCollection;
	import com.google.maps.LatLng;
	import com.google.maps.LatLngBounds;
	import com.google.maps.TileLayerBase;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Point;
	import flash.net.URLRequest;

	public class BasicLayer extends TileLayerBase
	{
        public var rasterUrl:String;	
        private var srvNum:Number=1;
 
		public function BasicLayer(_rasterUrl:String=null) {
			
			rasterUrl=_rasterUrl;	
            var copyrightCollection:CopyrightCollection = new CopyrightCollection();
            copyrightCollection.addCopyright(new Copyright("ennefox", new LatLngBounds(new LatLng(-180, 90), new LatLng(180, -90)), 21,"ennefox"));            
            
            super(copyrightCollection, 0, 6,0.8); 
		}
		
		public override function loadTile(tile:Point, zoom:Number):DisplayObject {
            if (!isNaN(tile.x) && !isNaN(tile.y) && zoom >= 0) {
            	
            	srvNum++;
           		if (srvNum>4)
           			srvNum=1;
           		
                var tileUrl:String = rasterUrl;
                tileUrl = tileUrl.replace("|N|",srvNum);    
                tileUrl = tileUrl.replace("|X|",tile.x);    
                tileUrl = tileUrl.replace("|Y|",tile.y);    
                tileUrl = tileUrl.replace("|Z|",zoom); 
                
                var tileLoader:Loader=new Loader();
        		tileLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
				tileLoader.load(new URLRequest(tileUrl));                 
                return tileLoader;    
            }
            
            return null;			
		}
		
		private function ioErrorHandler(ev:Event):void {
			
		}
		

		
	}
}
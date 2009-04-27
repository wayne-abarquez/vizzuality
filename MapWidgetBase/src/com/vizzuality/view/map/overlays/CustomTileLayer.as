package com.vizzuality.view.map.overlays
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

	public class CustomTileLayer extends TileLayerBase
	{
		
		private var srvNum:Number=0;
		private var baseUrl:String;
		private var loader:Loader;		
		
		public var ctlo:CustomTileLayerOverlay;
		
		public function CustomTileLayer(_baseUrl:String)
		{
			baseUrl=_baseUrl;
			var copyrightCollection:CopyrightCollection = new CopyrightCollection();
			copyrightCollection.addCopyright(new Copyright("ennefox", new LatLngBounds(new LatLng(-180, 90), new LatLng(180, -90)), 21,"ennefox"));			
			super(copyrightCollection, 0, 23,0.7);
			
		}
		
		public override function loadTile(tile:Point,zoom:Number):DisplayObject {
			
			loader = new Loader()
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler,false,0,true);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaded,false,0,true);
		
           	srvNum++;
           	if (srvNum>3)
           		srvNum=0;		
           		
           	var tileUrl:String = baseUrl;	
           	if (tileUrl.indexOf("|N|")>0)
           		tileUrl = tileUrl.replace("|N|",srvNum);
           	
           	tileUrl = tileUrl.replace("|X|",tile.x);	
           	tileUrl = tileUrl.replace("|Y|",tile.y);	
           	tileUrl = tileUrl.replace("|Z|",zoom);	
           	
            loader.load(new URLRequest(tileUrl));
			ctlo.numRunningRequest++;
			
			
            return loader;           	           		
		}
		
		private function ioErrorHandler(event:IOErrorEvent):void {
			event.currentTarget.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			ctlo.numRunningRequest--;
		}
		
		private function loaded(event:Event):void {
			event.currentTarget.removeEventListener(Event.COMPLETE, loaded);
			ctlo.numRunningRequest--;
			
		}
		
		
	}
}
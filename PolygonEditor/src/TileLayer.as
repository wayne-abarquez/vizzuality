package
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

	public class TileLayer extends TileLayerBase
	{
		public function TileLayer()
		{
			
			var copyrightCollection:CopyrightCollection = new CopyrightCollection();
			copyrightCollection.addCopyright(new Copyright("ennefox", new LatLngBounds(new LatLng(-180, 90), new LatLng(180, -90)), 21,"ennefox"));			
			super(copyrightCollection, 0, 23,0.7);
			
		}
		
		public override function loadTile(tile:Point,zoom:Number):DisplayObject {
			
			var ct:CustomTile = new CustomTile();
			ct.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler,false,0,true);
			ct.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaded,false,0,true);
			
			
			var tileUrl:String="http://ec2-67-202-26-58.compute-1.amazonaws.com:8080/geoserver/gwc/service/gmaps?layers=groms:countries";
			tileUrl+="&zoom="+zoom;
			tileUrl+="&x="+tile.x;
			tileUrl+="&y="+tile.y;
           	
            ct.loader.load(new URLRequest(tileUrl));
			
			
            return ct;           	           		
		}
		
		private function ioErrorHandler(event:IOErrorEvent):void {
			event.currentTarget.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		}
		
		private function loaded(event:Event):void {
			event.currentTarget.removeEventListener(Event.COMPLETE, loaded);
			
		}		
		
	}
}
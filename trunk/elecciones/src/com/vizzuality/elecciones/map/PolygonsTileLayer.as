package com.vizzuality.elecciones.map
{
	import com.adobe.serialization.json.JSON;
	import com.google.maps.Copyright;
	import com.google.maps.CopyrightCollection;
	import com.google.maps.LatLng;
	import com.google.maps.LatLngBounds;
	import com.google.maps.TileLayerBase;
	import com.google.maps.interfaces.ICopyrightCollection;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	public class PolygonsTileLayer extends TileLayerBase {
		
		public var loadedPolys:Vector.<uint>=new Vector.<uint>();
		public var polysCache:Dictionary = new Dictionary();
		
		
		public function PolygonsTileLayer()	{
			var copyrightCollection:CopyrightCollection=new CopyrightCollection();
			super(copyrightCollection, 10, 19);
			copyrightCollection.addCopyright(new Copyright("MyCopyright", new LatLngBounds(new LatLng(-90, -180), new LatLng(90, 180)), 0, "My Data"));
			loadedPolys.push(0);
		}
		
		public override function loadTile(tile:Point,zoom:Number):DisplayObject {

			
			var url:String="http://api.localhost.lan:3000/v1/?sql="+
				escape("select cartodb_id,geojson(the_geom,6) from adm2 where the_geom_webmercator " +
					"&& v_get_tile("+tile.x+","+tile.y+","+zoom+") and cartodb_id not in " +
					"("+loadedPolys.join(",")+")");
			trace(url);
			
			var ureq:URLRequest = new URLRequest(url);
			ureq.contentType = "application/json";
			var uload:URLLoader = new URLLoader();
			uload.addEventListener(Event.COMPLETE, cartoDBRequestcomplete);
			uload.load(ureq);
			
			return new Sprite();
		}
		
		private function cartoDBRequestcomplete(e:Event):void {
			var res:Object = JSON.decode(e.currentTarget.data);
			for each(var p:Object in res.rows) {
				var geojson:Object =JSON.decode(p.st_asgeojson);
				loadedPolys.push(p.cartodb_id)
			}
		}
		
		private function ioErrorHandler(event:IOErrorEvent):void {
			trace("ioErrorHandler: " + event);
		}		
		
		
	}
}
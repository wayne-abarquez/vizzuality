package com.vizzuality.maps
{
	import com.google.maps.Copyright;
	import com.google.maps.CopyrightCollection;
	import com.google.maps.LatLng;
	import com.google.maps.LatLngBounds;
	import com.google.maps.TileLayerBase;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.IOErrorEvent;
	import flash.geom.Point;

	public class MaskLayer extends TileLayerBase
	{
 
		public function MaskLayer() {
			
            var copyrightCollection:CopyrightCollection = new CopyrightCollection();
            copyrightCollection.addCopyright(new Copyright("ennefox", new LatLngBounds(new LatLng(-180, 90), new LatLng(180, -90)), 21,"ennefox"));            
            
            super(copyrightCollection, 0, 6,0.8); 
		}
		
		public override function loadTile(tile:Point, zoom:Number):DisplayObject {
			var ms:Sprite = new Sprite();
			ms.graphics.beginFill(0x000000);
			ms.graphics.drawRect(0,0,256,256);
			ms.graphics.endFill();		
			
			return ms;
		}
		
	}
}
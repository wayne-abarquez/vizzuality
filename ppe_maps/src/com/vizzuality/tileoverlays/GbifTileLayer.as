package com.vizzuality.tileoverlays 
{
	import com.google.maps.Copyright;
	import com.google.maps.CopyrightCollection;
	import com.google.maps.LatLng;
	import com.google.maps.LatLngBounds;
	import com.google.maps.TileLayerBase;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.geom.Point;
	import flash.net.URLRequest;
	
	

	public class GbifTileLayer extends TileLayerBase
	{
		private var srvNum:Number=0;
		
		private var taxonId:Number;
		
		public function GbifTileLayer(_taxonId:Number)
		{
			taxonId=_taxonId;
			var copyrightCollection:CopyrightCollection = new CopyrightCollection();
			copyrightCollection.addCopyright(new Copyright("ennefox", new LatLngBounds(new LatLng(-180, 90), new LatLng(180, -90)), 21,"ennefox"));
			
			super(copyrightCollection, 0, 23,0.7);
			
		}
		
		public override function loadTile(tile:Point,zoom:Number):DisplayObject {
			
			var loader:Loader = new Loader();
            
            //var srvNum:Number = Math.ceil(Math.random()*4) -1;
           	srvNum++;
           	if (srvNum>3)
           		srvNum=0;
           	
           var baseURL:String = "http://maps0.eol.org/php/map/getEolTile.php?tile=|X|_|Y|_|Z|_13140803";
           
           //if (baseURL.indexOf("|N|")>0)
           //		baseURL = baseURL.replace("|N|",srvNum)
           
           
           baseURL = baseURL.replace("|X|",tile.x);
           baseURL = baseURL.replace("|Y|",tile.y);
           baseURL = baseURL.replace("|Z|",zoom);
           baseURL = baseURL.replace("|T|",taxonId);
           			
           	
           //	var tileUrl:String = "http://gbiftilecache"+srvNum+".biodiversityatlas.com/getTile?tile="+tile.x+"_"+tile.y+"_"+zoom+"_"+taxonId;
         	//var tileUrl:String = "http://localhost/php/map/getEolTile.php?tile="+tile.x+"_"+tile.y+"_"+zoom+"_"+taxonId;
            loader.load(new URLRequest(baseURL));
            return loader;
			
			
		}
		
	}
}
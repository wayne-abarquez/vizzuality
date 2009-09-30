package com.vizzuality.data
{
	import com.google.maps.LatLng;
	
	import flash.events.EventDispatcher;
	
	public class ImageData extends EventDispatcher
	{
		public var title:String;
		public var thumbnail:String;
		public var imageUrl:String;
		public var sourceUrl:String;
		public var owner:String;
		public var source:String;
		public var latlng:LatLng;
		public var id:String;
		public var height:Number;
		public var width:Number;

	}
}
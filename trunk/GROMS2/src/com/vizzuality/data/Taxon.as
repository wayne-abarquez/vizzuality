package com.vizzuality.data
{
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class Taxon
	{
		public var id:Number;
		public var gbif_id:Number;
		public var name:String;
		public var source:String;
		public var commonNameEnglish:String;
		public var commonNameGerman:String;
		public var commonNameSpanish:String;
		public var commonNameFreanch:String;
		public var genus:String;
		public var group:String;
		public var className:String;
		public var migrationType:String;
		public var cms:String;
		public var cms_link:String;
		public var red_list:String;
		public var cites:String;	
		public var chart:ArrayCollection;
		
		public var isVisible:Boolean=true;
		public var isHiddenFromMap:Boolean=false;
		public var isGbifDataVisible:Boolean=true;
		
	}
}
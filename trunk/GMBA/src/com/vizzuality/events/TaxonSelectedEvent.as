package com.vizzuality.events
{
	import flash.events.Event;
	
	public class TaxonSelectedEvent extends Event
	{
		
		public static const TAXON_SELECTED:String = "taxonSelected";
		
		public var taxonId:String;
		public var rank:String;
		
		public function TaxonSelectedEvent(type:String,taxonId:String,rank:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			this.taxonId=taxonId;
			this.rank=rank;

			super(type, bubbles, cancelable);
		}

	}
}
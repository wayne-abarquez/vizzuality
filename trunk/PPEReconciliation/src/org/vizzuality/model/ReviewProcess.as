package org.vizzuality.model
{
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class ReviewProcess extends EventDispatcher
	{
		public static const DELETE:String="delete";
		public static const UPDATE:String="update";
		public static const CREATE:String="create";
		
		public static const CONFIRMED:String = "c";
		public static const REJECTED:String = "r";
		
		public var pasDeletedReviewed:ArrayCollection = new ArrayCollection();
		public var pasEditedReviewed:ArrayCollection = new ArrayCollection();
		public var pasNewReviewed:ArrayCollection = new ArrayCollection();
		
		public var isAllDeletedAcceptedChecked:Boolean=false;
		public var isAllNewAcceptedChecked:Boolean=false;
		public var isAllUpdateAcceptedChecked:Boolean=false;
		
		public var pendingDeletedToReview:Number=0;
		public var pendingEditedToReview:Number=0;
		public var pendingNewToReview:Number=0;
	
	
		public function addPa(mode:String,pa:Pa,status:String):void {
			var pasPos:Number =checkIfPaInAc(pa,pasDeletedReviewed);
			
			switch(mode) {
				case DELETE:
					if(pasPos<0) {
						pasDeletedReviewed.addItem(pa);
						pendingDeletedToReview--;
					}
					break;
				case UPDATE:
					if(pasPos<0) {
						pasEditedReviewed.addItem(pa);
						pendingEditedToReview--;
					}
					break;
				case CREATE:
					if(pasPos<0) {
						pasNewReviewed.addItem(pa);
						pendingNewToReview--;
					} else {
						
					}
					break;
			}
		}
		
		private function checkIfPaInAc(pa:Pa,ac:ArrayCollection):Number {
			var i:Number=0;
			for each(var item:Pa in ac) {
				if(item.id == pa.id) {
					return i;
				}
				i++;
			}
			return -1;	
		}
		
		
	}
	
}
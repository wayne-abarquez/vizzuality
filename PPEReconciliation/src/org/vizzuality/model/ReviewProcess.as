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
			switch(mode) {
				case DELETE:
					if(!checkIfPaInAc(pa,pasDeletedReviewed)) {
						pasDeletedReviewed.addItem({pa:pa,status:status});
					}
					break;
				case UPDATE:
					if(!checkIfPaInAc(pa,pasEditedReviewed)) {
						pasEditedReviewed.addItem({pa:pa,status:status});
					}
					break;
				case CREATE:
					if(!checkIfPaInAc(pa,pasNewReviewed)) {
						pasNewReviewed.addItem({pa:pa,status:status});
					}
					break;
			}
		}
		
		private function checkIfPaInAc(pa:Pa,ac:ArrayCollection):Boolean {
			for each(var item:Object in ac) {
				if((item.pa as Pa).id == pa.id) {
					return true;
				}
			}
			return false;	
		}
		
		
	}
	
}
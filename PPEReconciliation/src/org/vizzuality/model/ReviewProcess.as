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
		
		public var deletedReviewed:Number=0;
		public var editedReviewed:Number=0;
		public var newReviewed:Number=0;
		public var totalReviewed:Number=0;
		
		public var deletedPending:Number=0;
		public var editedPending:Number=0;
		public var newPending:Number=0;
		
		public var totalPending:Number=0;
		
		
		public function recalculatePendings():void {
			totalPending=deletedPending + editedPending + newPending;
		}
	
	
		public function addPa(mode:String,pa:Pa,status:String):void {
			var pasPos:Number;
			
			switch(mode) {
				case DELETE:
					 pasPos=checkIfPaInAc(pa,pasDeletedReviewed);
					if(pasPos<0) {
						pasDeletedReviewed.addItem(pa);
						deletedReviewed++;
						totalReviewed++;
						deletedPending--;
						totalPending--;
					} else {
						(pasDeletedReviewed.getItemAt(pasPos) as Pa).status=status;
					}
					break;
				case UPDATE:
					 pasPos=checkIfPaInAc(pa,pasEditedReviewed);
					if(pasPos<0) {
						pasEditedReviewed.addItem(pa);
						editedReviewed++;
						totalReviewed++;
						editedPending--;
						totalPending--;
					} else {
						(pasEditedReviewed.getItemAt(pasPos) as Pa).status=status;
					}
					break;
				case CREATE:
					 pasPos=checkIfPaInAc(pa,pasNewReviewed);
					if(pasPos<0) {
						pasNewReviewed.addItem(pa);
						newReviewed++;
						totalReviewed++;
						newPending--;
						totalPending--;
					} else {
						(pasNewReviewed.getItemAt(pasPos) as Pa).status=status;
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
		
		public function getIfPaIdInReview(paId:String,mode:String):String {			
			var ac:ArrayCollection;
			switch(mode) {
				case ReviewProcess.DELETE:
					ac=pasDeletedReviewed;
					break;
				case ReviewProcess.UPDATE:
					ac=pasEditedReviewed;
					break;
				case ReviewProcess.CREATE:
					ac=pasNewReviewed;
					break;
			}
			var i:Number=0;
			var found:Boolean=false;
			for each(var item:Pa in ac) {
				if(item.id == paId) {
					found=true;
					break;
				}
				i++;
			}
			
			var status:String="";
			if(found) {
				status = (ac[i] as Pa).status;
			} else {
				status="";
			}
			return status;			
			
		}
		
		
	}
	
}
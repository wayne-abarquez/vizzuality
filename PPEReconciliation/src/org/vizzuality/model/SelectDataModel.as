package org.vizzuality.model
{
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class SelectDataModel extends EventDispatcher
	{
		public var selectedCountries:ArrayCollection=new ArrayCollection();
		public var selectedPas:ArrayCollection=new ArrayCollection();
		
		
		public function checkIfCountryInSelected(countryId:Number):Boolean {
			for each(var item:Country in selectedCountries) {
				if(item.id == countryId) {
					return true;
				}
			}
			return false;	
		}
		
		public function addCountry(c:Country):void {
			if(!checkIfCountryInSelected(c.id)) {
				selectedCountries.addItem(c);
			}
		}
		
		public function removeCountry(c:Country):void {
			var pos:Number = checkIfCountryOnSelectedPos(c);
			if(pos>=0) {
				selectedCountries.removeItemAt(pos);
			}
		}
		
		public function checkIfCountryOnSelectedPos(country:Country):Number {
			var i:Number=0;
			for each(var c:Country in selectedCountries) {
				if(c.id==country.id) {
					return i;				
				}
				i++;
			}
			return -1;	
					
		}		
		
		public function checkIfPaInSelected(paId:String):Boolean {
			for each(var item:Pa in selectedPas) {
				if(item.id == paId) {
					return true;
				}
			}
			return false;	
		}
		
		public function addPa(c:Pa):void {
			if(!checkIfPaInSelected(c.id)) {
				selectedPas.addItem(c);
			}
		}
		
		public function removePa(c:Pa):void {
			var pos:Number = checkIfPaOnSelectedPos(c);
			if(pos>=0) {
				selectedPas.removeItemAt(pos);
			}
		}
		
		public function checkIfPaOnSelectedPos(pa:Pa):Number {
			var i:Number=0;
			for each(var c:Pa in selectedPas) {
				if(c.id==pa.id) {
					return i;				
				}
				i++;
			}
			return -1;	
					
		}		
		
		
	}
}
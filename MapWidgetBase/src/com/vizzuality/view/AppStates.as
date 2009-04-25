package com.vizzuality.view
{
	import asual.SWFAddress;
	
	public final class AppStates
	{
		//TOP states
		public static const WORLD:String='world';
		public static const COUNTRIES:String='countries';
		public static const COUNTRY:String='country';
		public static const PA:String='pa';
		
		//TOOLS OR SECOND LEVELS
		public static const SEARCH:String='search';
		public static const FILTER:String='filter';
		public static const ABOUT:String='about';
		public static const HELP:String='help';
		public static const DETAILS:String='details';
		public static const EXTRA_DETAILS:String='extraDetails';
		
		
		//App current state
		[Bindable]
		public var topState:String;
		[Bindable]
		public var secondState:String;
		
		[Bindable]
		public var activePaId:Number;
		[Bindable]
		public var activeCountryIsoCode:String;
		
		
		private static var instance:AppStates = new AppStates();
		
		public function AppStates() {
			if( instance ) throw new Error( "Singleton and can only be accessed through Singleton.getInstance()" ); 
		}
		
		public static function gi():AppStates {
			return instance;
		}
		
		//We dont set the state directly here, it is set by the SWFAddress
		public function setTopState(tState:String):void {
			SWFAddress.setValue(tState);
		}
		public function setSecondState(sState:String):void {
			if (topState==COUNTRY) {
				SWFAddress.setValue(gi().topState + '/' +activeCountryIsoCode +'/' + sState);				
			} 
			else if (topState==PA) {
				SWFAddress.setValue(gi().topState + '/' +activePaId +'/' + sState);							
			} 
			else {
				SWFAddress.setValue(gi().topState + '/' + sState);
			}
		}
		public function setAllStates(tState:String,sState:String):void {
			SWFAddress.setValue(tState + '/' + sState);
		}
		
		
	}
}
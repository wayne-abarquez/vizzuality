package com.vizzuality.view
{
	
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.core.Application;
	
	public final class AppStates
	{
		//TOP states
		public static const FEATURE:String='taxon';
		
		//TOOLS OR SECOND LEVELS
		public static const SEARCH:String='speciesBrowser';
		public static const ABOUT:String='about';
		public static const HELP:String='help';
		public static const DETAILS:String='details';
		public static const EXTRA_DETAILS:String='extraDetails';
		
		
		
		
		private static var instance:AppStates = new AppStates();
		
		//App current state
		[Bindable]
		public var topState:String='about';
		[Bindable]
		public var secondState:String;
		
		public var selectedSpecies:ArrayCollection = new ArrayCollection();
		
		
		public var visibleLayers:Dictionary=new Dictionary();		
		
		
		public function AppStates() {
			//initialize the layers state
			visibleLayers[FEATURE]=[];
			
			if( instance ) throw new Error( "Singleton and can only be accessed through Singleton.getInstance()" ); 
		}
		
		public static function gi():AppStates {
			return instance;
		}

		//We dont set the state directly here, it is set by the SWFAddress

		public function setSecondState(sState:String):void {
			
		}
		public function setAllStates(tState:String,sState:String):void {

		}
		
		public function goToPreviousState():void {

		}
		
		
		
		
		public function debug(value:String):void {
			Application.application.debuggerArea.text="\n"+value +Application.application.debuggerArea.text;
		}
		
		
	}
}
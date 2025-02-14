package com.vizzuality.view
{
	import asual.SWFAddress;
	
	import com.google.analytics.GATracker;
	import com.vizzuality.data.WdpaLayer;
	import com.vizzuality.services.DataServices;
	
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	import mx.core.Application;
	
	[Event(name="areaDetailsDisplay", type="com.vizzuality.services.DataServiceEvent")]
	public final class AppStates extends EventDispatcher
	{
		//TOP states
		public static const WORLD:String='world';
		public static const COUNTRIES:String='countries';
		public static const COUNTRY:String='country';
		public static const PA:String='pa';
		public static const AREA_SELECTOR:String='areaSelector';
		
		//TOOLS OR SECOND LEVELS
		public static const SEARCH:String='search';
		public static const FILTER:String='filter';
		public static const ABOUT:String='about';
		public static const HELP:String='help';
		public static const DETAILS:String='details';
		public static const EXTRA_DETAILS:String='extraDetails';
		public static const AREA_DETAILS:String='extraDetails';
		
		
		public static const AP_TYPE:String='marine';
		
		
		
		private static var instance:AppStates = new AppStates();
		
		//App current state
		[Bindable]
		public var topState:String;
		[Bindable]
		public var secondState:String;
		
		public var worldOrCountries:String=COUNTRIES;
		
		public var visibleLayers:Dictionary=new Dictionary();
		public var mapPositions:Dictionary=new Dictionary();
		
		private var _activePaId:Number;
		private var _activeCountryIsoCode:String;
		[Bindable]		
		public var activeCountryName:String;
		
		public var previousAddress:String="";
		
		public function AppStates() {
			//initialize the layers state
			visibleLayers[WORLD]=[WdpaLayer.ALL];
			visibleLayers[COUNTRIES]=[WdpaLayer.COUNTRY_PER_COVERAGE];
			visibleLayers[COUNTRY]=[WdpaLayer.ALL];
			visibleLayers[PA]=[];
			visibleLayers[AREA_SELECTOR]=[WdpaLayer.ALL];
			
			
			if( instance ) throw new Error( "Singleton and can only be accessed through Singleton.getInstance()" ); 
		}
		
		public static function gi():AppStates {
			return instance;
		}
		
		[Bindable(event="changeActivePaId")]
		public function get activePaId():Number {
			return _activePaId;
		}
		
		public function set activePaId(value:Number):void {
			_activePaId=value;
			dispatchEvent(new Event("changeActivePaId"));
			DataServices.gi().selectedPAId=value;
		}
		
		[Bindable(event="changeActiveCountryIsoCode")]
		public function get activeCountryIsoCode():String {
			return _activeCountryIsoCode;
		}
		
		public function set activeCountryIsoCode(value:String):void {
			_activeCountryIsoCode=value;
			dispatchEvent(new Event("changeActiveCountryIsoCode"));
		}


		//We dont set the state directly here, it is set by the SWFAddress

		public function setSecondState(sState:String):void {
			previousAddress=SWFAddress.getPath();
			
			if (topState==COUNTRY) {
				SWFAddress.setValue(gi().topState + '/' +activeCountryIsoCode +'/' + sState);				
			} 
			else if (topState==PA) {
				SWFAddress.setValue(gi().topState + '/' +activePaId +'/' + sState);						
			} 
			else if(topState==COUNTRIES && sState==FILTER) {
				SWFAddress.setValue(WORLD + '/' +FILTER);							
				
			}
			else {
				SWFAddress.setValue(gi().topState + '/' + sState);
			}
		}
		
		public function removeSecondState():void {
			previousAddress=SWFAddress.getPath();
			
			if (topState==COUNTRY) {
				SWFAddress.setValue(gi().topState + '/' +activeCountryIsoCode);				
			} 
			else if (topState==PA) {
				SWFAddress.setValue(gi().topState + '/' +activePaId);						
			} 
			else if(topState==COUNTRIES && secondState==FILTER) {
				SWFAddress.setValue(WORLD + '/' +FILTER);							
				
			}
			else {
				SWFAddress.setValue(gi().topState);
			}
		}
		public function setAllStates(tState:String,sState:String):void {
			previousAddress=SWFAddress.getPath();
			SWFAddress.setValue(tState + '/' + sState);
			if(tState==COUNTRIES || tState==WORLD)
				worldOrCountries=tState;
		}
		
		public function goToPreviousState():void {
			SWFAddress.back();
		}
		
		public function goToPa(id:Object):void {
			SWFAddress.setValue(PA + '/' + id );
		}
		
		
		
		public function debug(value:String):void {
			Application.application.debuggerArea.text="\n"+value +Application.application.debuggerArea.text;
		}
		
		
	}
}
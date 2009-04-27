package com.vizzuality.services
{
	import com.vizzuality.data.Country;
	import com.vizzuality.data.PA;
	import com.vizzuality.data.WorldStats;
	import com.vizzuality.view.AppStates;
	
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;

	[Event(name="paDataLoaded", type="com.vizzuality.services.DataServiceEvent")]
	public final class DataServices extends EventDispatcher
	{
		
		private static var instance:DataServices = new DataServices();
		
		private var roPa:RemoteObject = new RemoteObject("WDPAServices");		
		private var roCountry:RemoteObject = new RemoteObject("WDPAServices");		
		private var roWorld:RemoteObject = new RemoteObject("WDPAServices");		
		
		private var pasDict:Dictionary=new Dictionary();
		private var countriesDict:Dictionary=new Dictionary();
		
		[Bindable]
		public var worldStats:WorldStats;
		
		[Bindable]
		public var selectedCountry:Country;
		private var resolvingIso:String;

		[Bindable]
		public var selectedPA:PA;
		private var resolvingId:Number;
		
		public function DataServices()
		{
			if( instance ) throw new Error( "Singleton and can only be accessed through Singleton.getInstance()" ); 
			roPa.endpoint=roCountry.endpoint=roCountry.endpoint="http://ec2-67-202-26-58.compute-1.amazonaws.com/wdpa/gateway.php";
			roPa.source=roCountry.source=roWorld.source="WDPAServices";
			
			roPa.addEventListener(ResultEvent.RESULT,onGetPaDataResult);
			roCountry.addEventListener(ResultEvent.RESULT,onGetCountryDataResult);	
			roWorld.addEventListener(ResultEvent.RESULT,onGetWorldStatsResult);	
			
			
			roPa.addEventListener(FaultEvent.FAULT,onFault);		
			roCountry.addEventListener(FaultEvent.FAULT,onFault);		
			roWorld.addEventListener(FaultEvent.FAULT,onFault);		
		}
		
		
		public static function gi():DataServices {
			return instance;
		}
		
		
		/**
		 * 
		 * 
		 * PA
		 * 
		 **/
		 //-----------------------------------------------------------------------------------
		public function set selectedPAId(value:Number):void {
			if(!isNaN(value) && value!=resolvingId) {
				if(pasDict[value]!=null) {
					selectedPA=pasDict[value];
					dispatchEvent(new DataServiceEvent(DataServiceEvent.PA_DATA_LOADED));
				} else {
					roPa.getPaData(value);
					resolvingId=value;
				}
			}
		}
		
		
		private function onGetPaDataResult(event:ResultEvent):void {			
			selectedPA = new PA(event.result);
			AppStates.gi().activeCountryIsoCode = DataServices.gi().selectedPA.countryIsoCode;
			AppStates.gi().activeCountryName = DataServices.gi().selectedPA.country;
			pasDict[selectedPA.id]=selectedPA;
			resolvingId=NaN;
			dispatchEvent(new DataServiceEvent(DataServiceEvent.PA_DATA_LOADED));
		}

		/**
		 * 
		 * 
		 * COUNTRY
		 * 
		 **/
		 //-----------------------------------------------------------------------------------		
		public function set selectedCountryIso(value:String):void {
			if(value!=null && value!=resolvingIso) {
				if(countriesDict[value]!=null) {
					selectedCountry=countriesDict[value];
					dispatchEvent(new DataServiceEvent(DataServiceEvent.COUNTRY_DATA_LOADED));
				} else {
						
					roCountry.getCountryStatsByISO(value);
					resolvingIso=value;
				}
			}
		}
		
		
		private function onGetCountryDataResult(event:ResultEvent):void {			
			selectedCountry = new Country(event.result);
			AppStates.gi().activeCountryIsoCode = selectedCountry.isocode;
			AppStates.gi().activeCountryName = selectedCountry.name;
			countriesDict[selectedCountry.isocode]=selectedCountry;
			resolvingIso=null;
			dispatchEvent(new DataServiceEvent(DataServiceEvent.COUNTRY_DATA_LOADED));
		}		
		
		
		/**
		 * 
		 * 
		 * WORLD
		 * 
		 **/
		 //-----------------------------------------------------------------------------------		
		public function getWorldStats():void {
			roWorld.getWorldStats();
		}
		
		private function onGetWorldStatsResult(event:ResultEvent):void {
			worldStats = new WorldStats(event.result);
			dispatchEvent(new DataServiceEvent(DataServiceEvent.WORLD_DATA_LOADED));
		}
		
		
		private function onFault(event:FaultEvent):void {
			trace(event.message);
		}			
		
		
	}
}
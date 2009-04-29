package com.vizzuality.services
{
	import com.google.maps.LatLng;
	import com.google.maps.LatLngBounds;
	import com.vizzuality.data.Country;
	import com.vizzuality.data.PA;
	import com.vizzuality.data.WorldStats;
	import com.vizzuality.view.AppStates;
	import com.vizzuality.view.map.MapController;
	
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;

	[Event(name="paDataLoaded", type="com.vizzuality.services.DataServiceEvent")]
	[Event(name="countryDataLoaded", type="com.vizzuality.services.DataServiceEvent")]
	[Event(name="worldDataLoaded", type="com.vizzuality.services.DataServiceEvent")]
	[Event(name="areasForLatLngLoaded", type="com.vizzuality.services.DataServiceEvent")]
	public final class DataServices extends EventDispatcher
	{
		
		private static var instance:DataServices = new DataServices();
			
		private var roArea:RemoteObject;
		private var roCountry:RemoteObject;
		private var roWorld:RemoteObject;
		private var roLat:RemoteObject;
		
		private var pasDict:Dictionary=new Dictionary();
		private var countriesDict:Dictionary=new Dictionary();
		
		[Bindable]
		public var areasForLatLng:ArrayCollection=new ArrayCollection();
		
		public var bboxForAreas:LatLngBounds;
		
		[Bindable]
		public var worldStats:WorldStats;
		
		[Bindable]
		public var selectedCountry:Country;
		private var resolvingIso:String;

		[Bindable]
		public var selectedPA:PA;
		private var resolvingId:Number;
		
		private var resolvingLatLng:LatLng;
		
		public function DataServices()
		{
			if( instance ) throw new Error( "Singleton and can only be accessed through Singleton.getInstance()" ); 
			
			roArea=createRemoteObject();
			roCountry=createRemoteObject();
			roWorld=createRemoteObject();
			roLat=createRemoteObject();
			
			roArea.addEventListener(ResultEvent.RESULT,onGetPaDataResult);
			roArea.addEventListener(FaultEvent.FAULT,onFault);	
			
			roCountry.addEventListener(ResultEvent.RESULT,onGetCountryDataResult);	
			roCountry.addEventListener(FaultEvent.FAULT,onFault);		
			
			roWorld.addEventListener(ResultEvent.RESULT,onGetWorldStatsResult);	
			roWorld.addEventListener(FaultEvent.FAULT,onFault);		
			
			roLat.addEventListener(ResultEvent.RESULT,onGetAreasByLatLngResult);	
			roLat.addEventListener(FaultEvent.FAULT,onFault);		
		
		}
		
		
		public static function gi():DataServices {
			return instance;
		}
		
		private function createRemoteObject():RemoteObject {     
		    var ro:RemoteObject = new RemoteObject("WDPAServices");   
		    ro.source="WDPAServices";
		    ro.endpoint="http://ec2-67-202-26-58.compute-1.amazonaws.com/wdpa/gateway.php";   
		    return ro;   
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
					roArea.getPaData(value);
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
		
		
		/**
		 * 
		 * 
		 * AREAS BY LAT LON
		 * 
		 **/
		 //-----------------------------------------------------------------------------------			
		public function getAreasByLatLng(latlng:LatLng):void {
			MapController.gi().setMapLoading();
			resolvingLatLng=latlng;
			roLat.getAreasByLatLng(latlng.lat(),latlng.lng());
		}
		
		private function onGetAreasByLatLngResult(event:ResultEvent):void {
			if ((event.result.areas as Array).length>0) {
				areasForLatLng = new ArrayCollection(event.result.areas as Array);
				bboxForAreas = new LatLngBounds(
						new LatLng(event.result.south,event.result.west),
						new LatLng(event.result.north,event.result.east));
				
				AppStates.gi().setAllStates(AppStates.AREA_SELECTOR,resolvingLatLng.lat() +"_"+resolvingLatLng.lng());
			} else {
				areasForLatLng=null;
				AppStates.gi().goToPreviousState();
			}
			MapController.gi().setMapLoaded();
		}
		
		
		
		private function onFault(event:FaultEvent):void {
			trace(event.message);
		}			
		
		
	}
}
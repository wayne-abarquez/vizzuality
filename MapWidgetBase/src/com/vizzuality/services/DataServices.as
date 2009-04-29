package com.vizzuality.services
{
	import com.adobe.serialization.json.JSON;
	import com.google.maps.LatLng;
	import com.google.maps.LatLngBounds;
	import com.google.maps.overlays.EncodedPolylineData;
	import com.google.maps.overlays.Polygon;
	import com.google.maps.overlays.PolygonOptions;
	import com.google.maps.styles.FillStyle;
	import com.google.maps.styles.StrokeStyle;
	import com.vizzuality.data.Country;
	import com.vizzuality.data.PA;
	import com.vizzuality.data.WorldStats;
	import com.vizzuality.utils.PolylineEncoder;
	import com.vizzuality.view.AppStates;
	import com.vizzuality.view.map.MapController;
	
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.mxml.HTTPService;
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
		
		private var wdpaRestServ:HTTPService = new HTTPService();
		
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
			
			wdpaRestServ.resultFormat = 'text';	
			wdpaRestServ.addEventListener(ResultEvent.RESULT,onGetAreasByLatLngResult);
			
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
					MapController.gi().setMapLoading();
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
			
			MapController.gi().zoomToBbox(selectedCountry.bbox);
			MapController.gi().setMapLoaded();
		}		
		
		
		/**
		 * 
		 * 
		 * WORLD
		 * 
		 **/
		 //-----------------------------------------------------------------------------------		
		public function getWorldStats():void {
			MapController.gi().setMapLoading();
			roWorld.getWorldStats();
		}
		
		private function onGetWorldStatsResult(event:ResultEvent):void {
			worldStats = new WorldStats(event.result);
			dispatchEvent(new DataServiceEvent(DataServiceEvent.WORLD_DATA_LOADED));
			MapController.gi().setMapLoaded();
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
			//roLat.getAreasByLatLng(latlng.lat(),latlng.lng());
			
		 		
		 	wdpaRestServ.url = "http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv1_IdentifyResults/MapServer/0//query?text=&geometry=%7B%22x%22%3A"+latlng.lng()+"%2C%22y%22%3A"+latlng.lat()+"%7D&geometryType=esriGeometryPoint&inSR=4326&spatialRel=esriSpatialRelIntersects&where=&returnGeometry=true&outSR=&outFields=Site_ID,English_Name&f=json";
			trace(wdpaRestServ.url);
			wdpaRestServ.send();
		}
		
		private function onGetAreasByLatLngResult(event:ResultEvent):void {
			
			var res:Object = JSON.decode(String(event.result));
			if ((res.features as Array).length>0) {
				areasForLatLng=new ArrayCollection();
				
				for each(var feature:Object in res.features) {
					
					//check if the area is already on the areasForLatLng arrayCollection.
					//	THIS IS AN ERROR ON THE WDPA REST SERVICES
					var alreadyAdded:Boolean=false;
					for each(var o:Object in areasForLatLng) {
						if (o.name == feature.attributes['English_Name']) {
							alreadyAdded=true;
							break;
						}
					}
					if(alreadyAdded)
						break;
					
					
					var polygon:Polygon;
					var attributes:Object =  feature.attributes;
					var rings:Array = feature.geometry.rings;
					var p:PolylineEncoder = new PolylineEncoder(18,2,0.00001,true);
					var encodedPolyLines:Array = new Array();
					
					for each(var ring:Array in rings) {
						var innerRing:Array = new Array();
						for each(var j:Array in ring) {
							innerRing.push(new LatLng(j[1],j[0]));
						}
						var inner:Object = p.dpEncode(innerRing);
						encodedPolyLines.push(new EncodedPolylineData(inner.encodedPoints, 2, inner.encodedLevels, 18));
					}
					
		
				    var polOpt:PolygonOptions = new PolygonOptions({ 
					        strokeStyle: new StrokeStyle({
					        	color: 0xFFBB08,
					        	thickness: 2,
					        	alpha: 1}), 
					        fillStyle: new FillStyle({
					        	color: 0xFFBB08,
					        	alpha:0.2})
					        });		
					        
				    polygon = Polygon.fromEncoded(encodedPolyLines, polOpt);		
				    
				    areasForLatLng.addItem({name:attributes['English_Name'],siteid:attributes['Site_ID'],polygon:polygon});
				    			
					MapController.gi().map.addOverlay(polygon);
					MapController.gi().zoomToBbox(polygon.getLatLngBounds());
				}
				
				AppStates.gi().setAllStates(AppStates.AREA_SELECTOR,resolvingLatLng.lat() +"_"+resolvingLatLng.lng());	
				
				
			} else {
				areasForLatLng=null;
				//AppStates.gi().goToPreviousState();
			}
			MapController.gi().setMapLoaded();
		}
		
		
		
		private function onFault(event:FaultEvent):void {
			trace(event.message);
		}			
		
		
	}
}
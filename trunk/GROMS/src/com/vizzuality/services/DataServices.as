package com.vizzuality.services
{
	import asual.SWFAddress;
	
	import com.adobe.utils.StringUtil;
	import com.google.maps.Color;
	import com.google.maps.LatLng;
	import com.google.maps.LatLngBounds;
	import com.google.maps.overlays.EncodedPolylineData;
	import com.google.maps.overlays.Marker;
	import com.google.maps.overlays.MarkerOptions;
	import com.google.maps.overlays.Polygon;
	import com.google.maps.overlays.PolygonOptions;
	import com.google.maps.styles.FillStyle;
	import com.google.maps.styles.StrokeStyle;
	import com.vizzuality.data.Country;
	import com.vizzuality.data.PA;
	import com.vizzuality.data.WorldStats;
	import com.vizzuality.utils.MapUtils;
	import com.vizzuality.utils.PolylineEncoder;
	import com.vizzuality.view.AppStates;
	import com.vizzuality.view.map.MapController;
	import com.vizzuality.view.map.overlays.PaTitleMarkerIcon;
	
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	
	import mx.formatters.NumberFormatter;
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
		private var roSearch:RemoteObject;
		
		public var nf:NumberFormatter;
		
		private var wdpaRestServ:HTTPService = new HTTPService();
		
		private var pasDict:Dictionary=new Dictionary();
		private var countriesDict:Dictionary=new Dictionary();	
		
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
		
		
		public var activePA:PA;	
		public var preselectedPAsBounds:LatLngBounds;
		public var preselectedPAsDic:Dictionary = new Dictionary(true);
		
		
		public function DataServices()
		{
			if( instance ) throw new Error( "Singleton and can only be accessed through Singleton.getInstance()" ); 
			
			roArea=createRemoteObject();
			roCountry=createRemoteObject();
			roWorld=createRemoteObject();
			roLat=createRemoteObject();
			roSearch=createRemoteObject();
			
			roArea.addEventListener(ResultEvent.RESULT,onGetPaDataResult);
			roArea.addEventListener(FaultEvent.FAULT,onFault);	
			
			roCountry.addEventListener(ResultEvent.RESULT,onGetCountryDataResult);	
			roCountry.addEventListener(FaultEvent.FAULT,onFault);		
			
			roWorld.addEventListener(ResultEvent.RESULT,onGetWorldStatsResult);	
			roWorld.addEventListener(FaultEvent.FAULT,onFault);		
				
			
			
			nf=new NumberFormatter();
			nf.useThousandsSeparator=true;
		
		
		}
		
		
		public static function gi():DataServices {
			return instance;
		}
		
		public function createRemoteObject():RemoteObject {     
		    var ro:RemoteObject = new RemoteObject("GROMSServices");   
		    ro.source="GROMSServices";
		    ro.endpoint="http://ec2-67-202-26-58.compute-1.amazonaws.com/groms/amfphp/gateway.php";   
		    return ro;   
		}   		
		
		
		/**
		 * 
		 * 5
		 * PA
		 * 
		 **/
		 //-----------------------------------------------------------------------------------
		public function set selectedPAId(value:Number):void {
			MapController.gi().setMapLoading();
			if(!isNaN(value) && value!=resolvingId) {
				if(pasDict[value]!=null) {
					selectedPA=pasDict[value];
					dispatchEvent(new DataServiceEvent(DataServiceEvent.PA_DATA_LOADED));
					//display the polygon
					MapController.gi().addPa(selectedPA);
					MapController.gi().setMapLoaded();
					MapController.gi().zoomToBbox(selectedPA.getBbox());
				} else {
					AppStates.gi().debug("Requesting Feature: "+value);
					roArea.showBusyCursor=true;
					roArea.getTaxonById(value);
					resolvingId=value;
				}
			}
		}
		
		
		private function onGetPaDataResult(event:ResultEvent):void {			

			var res:Object=event.result;
			selectedPA = new PA();			
			
			selectedPA.id=res.id;
			selectedPA.name=res.name;
			selectedPA.source=res.source;
			selectedPA.commonNameEnglish=res.commonNameEnglish;
			selectedPA.commonNameGerman=res.commonNameGerman;
			selectedPA.commonNameSpanish=res.commonNameSpanish;
			selectedPA.commonNameFreanch=res.commonNameFreanch;
			selectedPA.genus=res.genus;
			selectedPA.group=res.group;
			selectedPA.className=res.className;
			selectedPA.migrationType=res.migrationType;
			selectedPA.cms=res.cms;
			selectedPA.cms_link=res.cms_link;
			selectedPA.red_list=res.red_list;
			selectedPA.cites=res.cites;
	
			

			MapController.gi().addPa(selectedPA);
			
			pasDict[selectedPA.id]=selectedPA;
			activePA= selectedPA;
			resolvingId=NaN;
			dispatchEvent(new DataServiceEvent(DataServiceEvent.PA_DATA_LOADED));
			MapController.gi().setMapLoaded();
			
			
			//Start loading multimedia resources
			MediaServices.gi().getAllMedia(selectedPA.getBbox());
			
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
					AppStates.gi().activeCountryIsoCode = selectedCountry.isocode;
					AppStates.gi().activeCountryName = selectedCountry.name;	
					MapController.gi().zoomToBbox(selectedCountry.bbox);
					MapController.gi().setMapLoaded();									
					
					dispatchEvent(new DataServiceEvent(DataServiceEvent.COUNTRY_DATA_LOADED));
				} else {
					MapController.gi().setMapLoading();
					roCountry.getCountryStatsByISO(value,0,0);
					resolvingIso=value;
				}
			}
		}
		
		
		private function onGetCountryDataResult(event:ResultEvent):void {		
			if(event.result!=null) {
				var reso:Object = event.result[0];
				selectedCountry = new Country();
				selectedCountry.name = reso.Country;
				selectedCountry.isocode = reso.ISO2;
				selectedCountry.numberCoral = reso.CoralArea;
				selectedCountry.numMangrove = reso.MangroveArea;
				selectedCountry.coveragePercentage = reso.TerrestrialCoveragePercentage + reso.MarineCoveragePercentage;
				selectedCountry.marineCoveragePercentage = reso.MarineCoveragePercentage;
				selectedCountry.terrestrialCoveragePercentage = reso.TerrestrialCoveragePercentage;
				selectedCountry.numAreas = reso.PATotal;
				selectedCountry.terrestrialNumAreas = reso.PATerrestrialTotal;
				selectedCountry.marineNumAreas = reso.PAMarineTotal;
				var geom:String = reso.Geometry;
				//POLYGON ((-18.169 27.637486, 4.316 27.6374, 4.31695 43.76, -18.1698 43.7642, -18.169 27.6374))
				var ta:Array = geom.replace("POLYGON ((","").replace("))","").split(",");
				var s1:Array = (ta[0] as String).split(" ");
				var s2:Array = (ta[2] as String).split(" ");		
				var eastSouth:LatLng = new LatLng(
					s1[1],
					s1[0]);	
				var westNorth:LatLng = new LatLng(
					s2[2],
					s2[1]);
	
				
				selectedCountry.bbox = new LatLngBounds(eastSouth,westNorth);	
	
				countriesDict[selectedCountry.isocode]=selectedCountry;
				resolvingIso=null;
						
				dispatchEvent(new DataServiceEvent(DataServiceEvent.COUNTRY_DATA_LOADED));			
				
				//the request is comming from a click on the map. We have to change the URL
				if(AppStates.gi().topState!=AppStates.COUNTRY) {
					SWFAddress.setValue('/'+AppStates.COUNTRY+'/'+selectedCountry.isocode);
				} 
				// the request is comming from a direct link via ISO code. No need to go further
				else {
					MapController.gi().zoomToBbox(selectedCountry.bbox);
					MapController.gi().setMapLoaded();	
				}			
			} else {
				AppStates.gi().activeCountryIsoCode = selectedCountry.isocode;
				AppStates.gi().activeCountryName = selectedCountry.name;	
				MapController.gi().setMapLoaded();
				MapController.gi().showMapWarning("No countries where you have clicked",2);				
			}
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
		
			worldStats = new WorldStats();
			worldStats.numberSpecies=event.result.numberSpecies;
			
			dispatchEvent(new DataServiceEvent(DataServiceEvent.WORLD_DATA_LOADED));
			MapController.gi().setMapLoaded();
		}
		
		
		/**
		 * 
		 * 
		 * COUNTRIES BY LAT LON
		 * 
		 **/
		 //-----------------------------------------------------------------------------------			
		public function getCountryByLatLng(latlng:LatLng):void {
						
			MapController.gi().setMapLoading();
			roCountry.getCountryStatsByISO("",latlng.lng(),latlng.lat());
		}	

		/**
		 * 
		 * 
		 * AREAS BY LAT LON
		 * 
		 **/
		 //-----------------------------------------------------------------------------------	
		private var clickedLatLng:LatLng;		
		public function getAreasByLatLng(latlng:LatLng):void {
			MapController.gi().setMapLoading();
			resolvingLatLng=latlng;
			//roLat.getAreasByLatLng(latlng.lat(),latlng.lng());
			
			var mapBounds:LatLngBounds =MapController.gi().map.getLatLngBounds();
			var mapSize:Point = MapController.gi().map.getSize();
				
			
		 	var url:String ="http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/wdpa_all_WGS84/MapServer/identify" + 
		 			"?geometryType=esriGeometryPoint" + 
		 			"&geometry="+latlng.lng()+"%2C"+latlng.lat()+
		 			"&layers=All" + 
		 			"&tolerance=2" + 
		 			"&mapExtent="+mapBounds.getWest()+"%2C"+mapBounds.getSouth()+"%2C"+mapBounds.getEast()+"%2C" + mapBounds.getNorth() +
		 			"&imageDisplay="+mapSize.x+"%2C"+mapSize.y+"%2C96" + 
		 			"&returnGeometry=true" + 
		 			"&f=json";	
		 	//wdpaRestServ.url=url;
		 	//wdpaRestServ.url = "http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv1_IdentifyResults/MapServer/0//query?text=&geometry=%7B%22x%22%3A"+latlng.lng()+"%2C%22y%22%3A"+latlng.lat()+"%7D&geometryType=esriGeometryPoint&inSR=4326&spatialRel=esriSpatialRelIntersects&where=&returnGeometry=true&outSR=&outFields=Site_ID,English_Name&f=json";
			trace(url);
			//wdpaRestServ.send();
			
			clickedLatLng=latlng;
			roLat.getAreasByLatLng(url);
		}
		
		
		
		private function createPolygon(geometry:Object):Polygon {
			var rings:Array = geometry.rings;
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
			        
		    return Polygon.fromEncoded(encodedPolyLines, polOpt);		

		}
		
		private function createCircleArea(center:LatLng, area:Number):Polygon {
			var radius_km:Number = 20;
			if (!isNaN(area)) {
				radius_km = Math.sqrt((Number(area)/100)/Math.PI);
			}
			var radius:Number = Math.round((Number(radius_km)/1.609)*100000)/100000;
			//var center:LatLng = new LatLng(geometry.points[0][1],geometry.points[0][0]);															
			return MapUtils.drawCircle(center.lat(),center.lng(),radius,0x0099FF,1,1,0x0099FF,0.5);						
		}	
		
		
		private function onFault(event:FaultEvent):void {
			trace(event.message);
		}		
		
		
	}
}
package com.vizzuality.services
{
	import asual.SWFAddress;
	
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
	import com.vizzuality.view.map.overlays.MultiPolygon;
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
			
			nf=new NumberFormatter();
			nf.useThousandsSeparator=true;
		
		
		}
		
		
		public static function gi():DataServices {
			return instance;
		}
		
		public function createRemoteObject():RemoteObject {     
		    var ro:RemoteObject = new RemoteObject("GenericDestination");   
		    ro.source="WDPASummary.WDPAQuery";
		    ro.endpoint="http://development3.unep-wcmc.org/weborb30/console/weborb.aspx";   
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
					AppStates.gi().debug("Requesting PA: "+value);
					roArea.showBusyCursor=true;
					roArea.getPAData(value);
					resolvingId=value;
				}
			}
		}
		
		
		private function onGetPaDataResult(event:ResultEvent):void {			

			var res:Object=event.result[0]['PAData'][0];
			var epolygons:Array = event.result[0]['epolygons'] as Array;
			selectedPA = new PA();
			//Mandatory
			selectedPA.id=res.Site_ID;
			selectedPA.name=res.English_Name;
			selectedPA.country=res.Country;
			selectedPA.countryIsoCode=res.ISO2;		
			selectedPA.geomType = event.result[0].geometryType;
			
			
			if(res['Designation']!=null) {
				selectedPA.designation = res.Designation;
			}
			if(res['TotalArea']!=null) {
				selectedPA.has = res.TotalArea;
				selectedPA.totalArea = res.TotalArea;
			}
			if(res['CurrentStatus']!=null) {
				selectedPA.currentStatus = res.CurrentStatus;
				selectedPA.status = res.CurrentStatus;
			}
			if(res['EstablishmentYear']!=null) {
				selectedPA.establishmentYear = res.EstablishmentYear;
			}
			if(res['IUCNCategory']!=null) {
				selectedPA.iucnCategory = res.IUCNCategory;
			}
			if(res['SiteGovernance']!=null) {
				selectedPA.siteGovernance = res.SiteGovernance;
			}
			if(res['Designation']!=null) {
				selectedPA.designation = res.Designation;
			}
			if(res['SiteType']!=null) {
				selectedPA.siteType = res.SiteType;
			}
			
			if (selectedPA.geomType=="polygon") {
				var mp:MultiPolygon=createPolygon(epolygons);
			    selectedPA.geometry=mp;
				
			} 
			else if (selectedPA.geomType== "point") {
				var mpp:MultiPolygon=new MultiPolygon();
 				var pol:Polygon = createCircleArea(new LatLng(event.result[0]['lat'],event.result[0]['_long']),event.result[0]['_area']);				
				mpp.addPolygon(pol);
				selectedPA.geometry=mpp;
				
			} else {
				
			}

			
			//display the polygon
			MapController.gi().addPa(selectedPA);
			MapController.gi().zoomToBbox(selectedPA.getBbox());
			
			
			AppStates.gi().activeCountryIsoCode = selectedPA.countryIsoCode;
			AppStates.gi().activeCountryName = selectedPA.country;
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
			var res:Object = event.result[0];
			
			worldStats = new WorldStats();
			worldStats.coveragePercentage = res.CoveragePercentage;
			worldStats.international = res.InternationalCount;
			worldStats.marine = res.MarineCount;
			worldStats.totalAreas = res.TotalAreasCount;
			worldStats.terrestrial = res.TerrestrialCount;
			
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
		public function getAreasByLatLng(latlng:LatLng):void {
			MapController.gi().setMapLoading();
			resolvingLatLng=latlng;			
			
			//Create a 2 by 2 pixels box
			var centerPoint:Point = MapController.gi().map.fromLatLngToPoint(latlng);
			var llPoint:Point = new Point(centerPoint.x-1,centerPoint.y-1);
			var urPoint:Point = new Point(centerPoint.x+1,centerPoint.y+1);
			var bbox:LatLngBounds = new LatLngBounds(
				MapController.gi().map.fromPointToLatLng(llPoint),
				MapController.gi().map.fromPointToLatLng(urPoint));
			
			
/* 			MapController.gi().map.addOverlay(new Polygon([
				bbox.getNorthEast(),
				bbox.getNorthWest(),
				bbox.getSouthWest(),
				bbox.getSouthEast(),
				bbox.getNorthEast()
				
			])); */
			
			roLat.getThePADetailsFromBB(
				bbox.getNorth(),
				bbox.getSouth(),
				bbox.getEast(),
				bbox.getWest(),
				true,
				'0');
		}
		
		private function onGetAreasByLatLngResult(event:ResultEvent):void {
			
			//After Click on the map 4 things can happen:
			//1) There is nothing were it has been clicked -> Show warning.
			//2) There is only 1 area where clicked. Go to this area directly
			//3) There is <=10 areas for the clic. Go to PRESELCT state
			//4) There is >10 areas. Show a warning (and maybe zoom?).
			
			var res:Object = event.result as Array;
			
			//This scenario is very unlikely to happen as we are controlling the mouse click on the map loking
			//at the layers
			if(res.length==0) {
				MapController.gi().setMapLoaded();
				MapController.gi().showMapWarning("No Protected Areas where you have clicked",2);
				return;
			}
			if(res.length>10) {
				MapController.gi().setMapLoaded();
				MapController.gi().showMapWarning("There are too many areas where you have clicked. Please Zoom further",2);
				MapController.gi().map.setCenter(resolvingLatLng,MapController.gi().map.getZoom()+1);
				MapController.gi().map.setZoom(MapController.gi().map.getZoom()+1,true);
				return;
			}
			if(res.length==1) {
				AppStates.gi().goToPa(res[0]['site_Id']);
				return;
			}
			
			//There are less than 10 but more than 1. PRESELECTION!
			if (res.length>0) {
				preselectedPAsDic= new Dictionary(true);
				preselectedPAsDic["numElements"]=0;
				preselectedPAsBounds = new LatLngBounds();
				var pas:Array = [];
				
				//First create the PAs and at the same time
				//calculate the preselectedPAsBounds
				for each(var feature:Object in res) {				
				    pas.push(createPa(feature));
				}
				
				//Now create the markers
				var contentFormat:TextFormat = new TextFormat("Arial", 10,Color.WHITE);				
				var i:Number=0;
				var num_res:Number = (res as Array).length;
				var ang:Number = (360/5) /(180/Math.PI) ;
				var radio:Number = preselectedPAsBounds.getEast() - preselectedPAsBounds.getCenter().lng();
				var radio2:Number =  preselectedPAsBounds.getNorth() - preselectedPAsBounds.getCenter().lat();
				if(radio2<radio)
					radio=radio2;
				for each(var pa:PA in pas) {    
				    i++;
				    var lng:Number = (Math.cos(ang*i) * radio)+pa.getCenter().lng();
				    var lat:Number = (Math.sin(ang*i) * radio)+pa.getCenter().lat();		    
				    
				    var markerPosition:LatLng = new LatLng(lat,lng);		 
				       
					var icon:PaTitleMarkerIcon = new PaTitleMarkerIcon(pa.name + ' [' + pa.siteType + ']',pa.id);
					icon.buttonMode=true;
	       			 var m:Marker = new Marker(markerPosition, new MarkerOptions(
			       		{
			       			clickable:true,
			       			hasShadow:false,
			       	 	draggable:false,
			       	 	icon: icon}));	
					//var customToolTip:ToolTipOverlay = new ToolTipOverlay(center_tooltip,pa.name);
					
					preselectedPAsDic[m]=pa;		
					preselectedPAsDic["numElements"]++;					
				}
				AppStates.gi().setAllStates(AppStates.AREA_SELECTOR,resolvingLatLng.lat() +"_"+resolvingLatLng.lng());	
				
				
			} else {
				preselectedPAsDic=new Dictionary(true);
				//AppStates.gi().goToPreviousState();
			}
			MapController.gi().setMapLoaded();
		}
		
		private function createPa(feature:Object):PA {
			var polygon:Polygon;
			var point:LatLng;
		    var pa:PA = new PA();
		    pa.id =feature['site_Id'];
		    pa.name = feature['Name'];	
		    pa.siteType = feature['SiteType'];		
		    pa.geomType = feature.geometryType;			
			
			
			if (pa.geomType=="polygon") {
				var mp:MultiPolygon=createPolygon(feature.epolygons as Array);
				        		
			    preselectedPAsBounds.union(mp.getBBox());
			    pa.geometry=mp;
				
			} 
			else if (pa.geomType== "point") {
				var mpp:MultiPolygon=new MultiPolygon();
 				var pol:Polygon = createCircleArea(new LatLng(feature.lat,feature['_long']),feature['_area']);				
				preselectedPAsBounds.union(pol.getLatLngBounds());
				mpp.addPolygon(pol);
				pa.geometry=mpp;
				
			} else {
				
			}		    
			
			return pa;
		}
		
		private function createPolygon(epolygons:Array):MultiPolygon {
 			var mp:MultiPolygon = new MultiPolygon();
 			for each (var pol:Object in epolygons) {
				var rings:Array = pol.rings;
				var p:PolylineEncoder = new PolylineEncoder(18,2,0.00001,true);
				var encodedPolyLines:Array = new Array();
				
				for each(var ring:Object in rings) {
					encodedPolyLines.push(new EncodedPolylineData(ring['Points'], ring['ZoomFactor'], ring['Levels'], ring['NumLevels']));
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
				        
				mp.addEncodedPolygon(encodedPolyLines,polOpt);
				
			} 		
			        
		    return mp;		

		}
		
		private function createCircleArea(center:LatLng, area:Number):Polygon {
			var radius_km:Number = 20;
			if (!isNaN(area)) {
				radius_km = Math.sqrt((Number(area)/100)/Math.PI);
			}
			var radius:Number = Math.round((Number(radius_km)/1.609)*100000)/100000;
			
			if (radius<2) {
				radius=2;
			}
			//var center:LatLng = new LatLng(geometry.points[0][1],geometry.points[0][0]);															
			return MapUtils.drawCircle(center.lat(),center.lng(),radius,0x0099FF,1,1,0x0099FF,0.5);						
		}	
		
		
		private function onFault(event:FaultEvent):void {
			trace(event.message);
		}		
		
		
	}
}
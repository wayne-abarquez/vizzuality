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
			//TEMPORARY HACK
			roLat.endpoint="http://localhost/gateway.php";
			roLat.source="WDPAServices";
			roLat.source="WDPAServices";
			roLat.destination="WDPAServices";
			
			
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

			var res:Object=event.result[0];
			selectedPA = new PA();
			//selectedPA.geomType = res.GeommetryType;
			selectedPA.geomType = PA.POINT;
			selectedPA.name=res.English_Name;
			selectedPA.country=res.Country;
			selectedPA.id=res.Site_ID;
			selectedPA.has=res.DocumentedTotalArea;
			selectedPA.countryIsoCode=res.ISO3;			
			
			selectedPA.point = createCircleArea(new LatLng(36.97582451068759,-6.442108154296875),50000);
			
/* 			if(selectedPA.geomType==PA.POINT) {
				selectedPA.point = createCircleArea(res.geometry,selectedPA.has);
			}
			else if (selectedPA.geomType==PA.POLYGON) {
				selectedPA.polygon = createPolygon(res.geometry);	
			} */
			
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
		
		private function onGetAreasByLatLngResult(event:ResultEvent):void {
			
			//After Click on the map 4 things can happen:
			//1) There is nothing were it has been clicked -> Show warning.
			//2) There is only 1 area where clicked. Go to this area directly
			//3) There is <=10 areas for the clic. Go to PRESELCT state
			//4) There is >10 areas. Show a warning (and maybe zoom?).
			
			
			
			//var res:Object = JSON.decode(String(event.result));
			var res:Object = event.result;
			
			if(res.numres==0) {
				MapController.gi().setMapLoaded();
				MapController.gi().showMapWarning("No Protected Areas where you have clicked",2);
				return;
			}
			if(res.numres>10) {
				MapController.gi().setMapLoaded();
				MapController.gi().showMapWarning("There are too many areas where you have clicked. Please Zoom further",2);
				MapController.gi().map.setCenter(clickedLatLng,MapController.gi().map.getZoom()+1);
				MapController.gi().map.setZoom(MapController.gi().map.getZoom()+1,true);
				return;
			}
			if(res.numres==1) {
				AppStates.gi().setAllStates(AppStates.FEATURE,res.siteid);
				//MapController.gi().setMapLoaded();
				return;
			}
			
			//There are less than 5 but more than 1. PRESELECTION!
			if ((res.results as Array).length>0) {
				preselectedPAsDic= new Dictionary(true);
				preselectedPAsBounds = new LatLngBounds();
				var pas:Array = [];
				
				//First create the PAs and at the same time
				//calculate the preselectedPAsBounds
				for each(var feature:Object in res.results) {				
				    pas.push(createPa(feature));
				}
				
				//Now create the markers
				var contentFormat:TextFormat = new TextFormat("Arial", 10,Color.WHITE);				
				var i:Number=0;
				var num_res:Number = (res.results as Array).length;
				var ang:Number = (360/5) /(180/Math.PI) ;
				var radio:Number = preselectedPAsBounds.getEast() - preselectedPAsBounds.getCenter().lng();
				var radio2:Number =  preselectedPAsBounds.getNorth() - preselectedPAsBounds.getCenter().lat();
				if(radio2<radio)
					radio=radio2;
				for each(var pa:PA in pas) {    
				    i++;
				    trace(pa.getCenter());
				    var lng:Number = (Math.cos(ang*i) * radio)+pa.getCenter().lng();
				    var lat:Number = (Math.sin(ang*i) * radio)+pa.getCenter().lat();		    
				    
				    var markerPosition:LatLng = new LatLng(lat,lng);		 
				       
					var icon:PaTitleMarkerIcon = new PaTitleMarkerIcon(pa.name + ' [' + pa.countryIsoCode + ']',pa.id);
					icon.buttonMode=true;
	       			 var m:Marker = new Marker(markerPosition, new MarkerOptions(
			       		{
			       			clickable:true,
			       			hasShadow:false,
			       	 	draggable:false,
			       	 	icon: icon}));	
					//var customToolTip:ToolTipOverlay = new ToolTipOverlay(center_tooltip,pa.name);
					
					preselectedPAsDic[m]=pa;		
					if (preselectedPAsDic["numElements"]==null) {
						preselectedPAsDic["numElements"]=1;						
					} else {
						preselectedPAsDic["numElements"]++;					
					}
				}
				
				
				
				
				AppStates.gi().setAllStates(AppStates.FEATURE_SELECTOR,resolvingLatLng.lat() +"_"+resolvingLatLng.lng());	
				
				
			} else {
				preselectedPAsDic=new Dictionary(true);
				//AppStates.gi().goToPreviousState();
			}
			MapController.gi().setMapLoaded();
		}
		
		private function createPa(feature:Object):PA {
			var polygon:Polygon;
			var point:LatLng;
			var attributes:Object =  feature.attributes;
		    var pa:PA = new PA();
		    pa.id =attributes['Site ID'];
		    pa.name = attributes['English Name'];	
		    pa.designation = attributes['English Designation'];		
		    pa.geomType = feature.geometryType;			
			
			if (pa.geomType==PA.POLYGON) {
				var poli:Polygon=createPolygon(feature.geometry);
				        		
			    preselectedPAsBounds.union(poli.getLatLngBounds());
			    pa.polygon=poli;
				
			} 
			else if (pa.geomType==PA.POINT) {
				var pol:Polygon = createCircleArea(feature.geometry,attributes['Documented Total Area (HA)']);				
				preselectedPAsBounds.union(pol.getLatLngBounds());
				pa.point=pol;
				
			} else {
				
			}		    
			
			return pa;
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
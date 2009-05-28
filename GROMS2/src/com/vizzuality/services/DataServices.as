package com.vizzuality.services
{
	
	import com.google.maps.LatLng;
	import com.google.maps.LatLngBounds;
	import com.google.maps.overlays.EncodedPolylineData;
	import com.google.maps.overlays.Polygon;
	import com.google.maps.overlays.PolygonOptions;
	import com.google.maps.styles.FillStyle;
	import com.google.maps.styles.StrokeStyle;
	import com.vizzuality.data.Taxon;
	import com.vizzuality.utils.MapUtils;
	import com.vizzuality.utils.PolylineEncoder;
	import com.vizzuality.view.AppStates;
	
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.core.Application;
	import mx.formatters.NumberFormatter;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;

	[Event(name="paDataLoaded", type="com.vizzuality.services.DataServiceEvent")]
	[Event(name="countryDataLoaded", type="com.vizzuality.services.DataServiceEvent")]
	[Event(name="worldDataLoaded", type="com.vizzuality.services.DataServiceEvent")]
	[Event(name="areasForLatLngLoaded", type="com.vizzuality.services.DataServiceEvent")]
	public final class DataServices extends EventDispatcher
	{
		
		private static var instance:DataServices = new DataServices();
			
		private var roTaxon:RemoteObject;
		
		public var nf:NumberFormatter;
		
		public var bboxForAreas:LatLngBounds;
		
		public var selectedTaxon1:Taxon;
		public var selectedTaxon2:Taxon;
		public var selectedTaxon3:Taxon;
		
		[Bindable]
		public var selectedTaxons:ArrayCollection=new ArrayCollection();

		
		
		public function DataServices()
		{
			if( instance ) throw new Error( "Singleton and can only be accessed through Singleton.getInstance()" ); 
			
			roTaxon=createRemoteObject();
			
			//roArea.addEventListener(ResultEvent.RESULT,onGetPaDataResult);
			roTaxon.addEventListener(FaultEvent.FAULT,onFault);	
				
			
			
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
		
		
		public function getTaxon(id:Number):void {
			selectedTaxon1= new Taxon();
			selectedTaxon1.cites="I";
			selectedTaxon1.className="Mammalia";
			selectedTaxon1.cms="App I & II";
			selectedTaxon1.commonNameEnglish="lalaen";
			selectedTaxon1.commonNameFreanch="lalafr";
			selectedTaxon1.commonNameGerman="lalade";
			selectedTaxon1.commonNameSpanish="lalaes";
			selectedTaxon1.genus="Balaena";
			selectedTaxon1.group="Whales";
			selectedTaxon1.id=id;
			selectedTaxon1.migrationType="Range extension";
			selectedTaxon1.name="Balaena mysticetus";
			selectedTaxon1.red_list="CR";
			selectedTaxon1.source="Ridgway SH & Harrisson SR (1985), Handbook of marine Mammals: Sirenians and baleen whales, Academic Press, London";
			selectedTaxon1.chart = new ArrayCollection( [{ monthStart: 0, monthEnd: 4, style:"s11",status:"breeding"},
            													{ monthStart: 4, monthEnd: 8, style:"s12",status:"feeding,wintering"},
            													{ monthStart: 8, monthEnd: 10, style:"s13",status:"resident"},
            													{ monthStart: 10, monthEnd: 12, style:"s14",status:"all year round"}]);
			
			selectedTaxons.addItem(selectedTaxon1);
			
			
			AppStates.gi().topState='';
			Application.application.currentState='timeline';
		
			Application.application.timeLine.dataProvider=selectedTaxons;
			
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
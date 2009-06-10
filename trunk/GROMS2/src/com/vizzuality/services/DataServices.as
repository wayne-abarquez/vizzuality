package com.vizzuality.services
{
	
	import com.adobe.utils.StringUtil;
	import com.google.maps.Color;
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
	import com.vizzuality.view.map.overlays.MultiPolygon;
	
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.core.Application;
	import mx.formatters.NumberFormatter;
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
			
			roTaxon.addEventListener(ResultEvent.RESULT,onTaxonResult);
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
		    //ro.endpoint="http://ec2-67-202-26-58.compute-1.amazonaws.com/groms/amfphp/gateway.php";   
		    ro.endpoint="http://localhost/amfphp/gateway.php";   
		    return ro;   
		}   		
		
		
		public function getTaxon(id:Number):void {
			
			roTaxon.getTaxonById(1036);
			trace(id);
			
			
		}		
		
		private function onTaxonResult(event:ResultEvent):void {

			var c:Object=event.result;

			selectedTaxon1= new Taxon();
			selectedTaxon1.cites=c.cites;
			selectedTaxon1.className=c.className;
			selectedTaxon1.cms=c.cms;
			selectedTaxon1.commonNameEnglish=c.commonNameEnglish;
			selectedTaxon1.commonNameFreanch=c.commonNameFreanch;
			selectedTaxon1.commonNameGerman=c.commonNameGerman;
			selectedTaxon1.commonNameSpanish=c.commonNameSpanish;
			selectedTaxon1.genus=c.genus;
			selectedTaxon1.group=c.group;
			selectedTaxon1.id=c.id;
			selectedTaxon1.migrationType=c.migrationType;
			selectedTaxon1.name=c.name;
			selectedTaxon1.red_list=c.red_list;
			selectedTaxon1.source=c.source;
			
			
			selectedTaxon1.chart =  new ArrayCollection();
			
			var p:PolylineEncoder = new PolylineEncoder(18,2,0.00001,true);
			var currentGid:Number=0;
			var currentChart:Object;
			for each(var geom:Object in c.geometries) {
				if(geom.gid!=currentGid) {
					if(currentGid!=0) {
						selectedTaxon1.chart.addItem(currentChart);
						(currentChart.geometry as MultiPolygon).addToMap();

					}
					currentChart=new Object();
					currentChart.monthStart = geom.monthstart;
					currentChart.monthEnd = geom.monthend;
					currentChart.status = geom.status;
					currentChart.style = "s11";
					currentChart.geometry=new MultiPolygon();
					
					var color:Number = Math.random()*0xFFFFFF;
					
					var polOp:PolygonOptions = new PolygonOptions({
					fillStyle: {alpha:1,color:color},
					strokeStyle: {alpha:1,thickness: 1,color:Color.GRAY4},
					tooltip:'<b>'+currentChart.status+'</b>\n'
					});	
					
				}
				
				var encodedPolyLines:Array=[];
				var parsing_string:String = (geom.the_geom as String).replace("POLYGON((","");
				var paths:Array = parsing_string.split(")");
				for each(var ring:String in paths) {
					if (ring!=""){
						var currentRingPoints:Array =[];
						if(ring.indexOf(",(")==0)
							ring=ring.substring(2);
							
						ring=	StringUtil.replace(ring,")","");
						ring=	StringUtil.replace(ring,"(","");
						trace(ring);
						var points:Array = ring.split( "," );
						for each(var point:String in points) {
							var coords:Array = point.split(" ");
							if(!isNaN(Number(coords[1])) && !isNaN(Number(coords[0]))) {
								currentRingPoints.push(new LatLng(coords[1],coords[0]));
							}
						}
						var encodedRing:Object = p.dpEncode(currentRingPoints);
						encodedPolyLines.push(new EncodedPolylineData(encodedRing.encodedPoints, 2, encodedRing.encodedLevels, 18));
					}
					
					
				}
				(currentChart.geometry as MultiPolygon).addEncodedPolygon(encodedPolyLines,polOp);
				
				currentGid=geom.gid;
			}
			
			selectedTaxon1.chart.addItem(currentChart);
			(currentChart.geometry as MultiPolygon).addToMap();
			

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
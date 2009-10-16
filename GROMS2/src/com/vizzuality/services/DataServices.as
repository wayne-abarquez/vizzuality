package com.vizzuality.services
{
	
	import com.google.maps.Color;
	import com.google.maps.LatLngBounds;
	import com.vizzuality.data.Taxon;
	import com.vizzuality.view.AppStates;
	import com.vizzuality.view.map.MapController;
	
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
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
		
		private var lastTaxonInserted:Number =0;
		
		public var taxonDictionary:Dictionary=new Dictionary();
		
		[Bindable]
		public var selectedTaxons:ArrayCollection=new ArrayCollection();


		public var statesStyles:Dictionary=new Dictionary();
		public var statesColors:Dictionary=new Dictionary();
		public var listIcons:Dictionary= new Dictionary();
		
		public var availableColors:Array=[NaN,Color.RED,Color.GREEN];
		
		
		public function DataServices()
		{
			if( instance ) throw new Error( "Singleton and can only be accessed through Singleton.getInstance()" ); 
			
			roTaxon=createRemoteObject();
			
			roTaxon.addEventListener(ResultEvent.RESULT,onTaxonResult);
			roTaxon.addEventListener(FaultEvent.FAULT,onFault);	
				
			
			
			nf=new NumberFormatter();
			nf.useThousandsSeparator=true;
		
			
			statesStyles['none']='s21';
			statesStyles['0']='s21';
			statesStyles['all year round']='s22';
			statesStyles['breeding']='s23';
			statesStyles['feeding, wintering']='s31';
			statesStyles['general distribution']='s21';
			statesStyles['moulting']='s24';
			statesStyles['non breeding summer']='s11';
			statesStyles['prior wintering area']='s32';
			statesStyles['resident']='s34';
			statesStyles['sightings']='s31';
			statesStyles['staging areas']='s13';
			
			statesColors['none']='0xFE81D6';
			statesColors['all year round']='0xFE2CD4';
			statesColors['breeding']='0xE700B8';
			statesColors['feeding, wintering']='0x29ADE9';
			statesColors['general distribution']='0xFE81D6';
			statesColors['moulting']='0x7915A7';
			statesColors['non breeding summer']='0xF0C001';
			statesColors['prior wintering area']='0x3677E5';
			statesColors['resident']='0x00289C';
			statesColors['sightings']='0x1BA6E4';
			statesColors['staging areas']='0xED5E00';
			
/* 			listIcons['Not listed']="@Embed('/assets/categories/cd.jpg')";
			listIcons['(CR) Critically Endangered']="@Embed('/assets/categories/cr.jpg')";
			listIcons['(LR/nt) Lower Risk, near threatened']="@Embed('/assets/categories/nt.jpg')";
			listIcons['(VU) Vulnerable']="@Embed('/assets/categories/vu.jpg')";
			listIcons['(DD) Data Deficient']="@Embed('/assets/categories/elc.jpg')";
			listIcons['(LR/cd) Lower Risk, conservation dependent']="@Embed('/assets/categories/cd.jpg')";
			listIcons['(EX) Extinct']="@Embed('/assets/categories/ex.jpg')";
			listIcons['(EW) Extinct in the Wild']="@Embed('/assets/categories/ew.jpg')";
			listIcons['(EN) Endangered']="@Embed('/assets/categories/en.jpg')"; */
			
	
		}	
		
		
		public static function gi():DataServices {
			return instance;
		}
		
		public function createRemoteObject():RemoteObject {     
		    var ro:RemoteObject = new RemoteObject("GROMSServices");   
		    ro.source="GROMSServices";
		    //ro.endpoint="http://ec2-67-202-26-58.compute-1.amazonaws.com/groms/amfphp/gateway.php";   
		    ro.endpoint=Application.application.parameters.data_server_endpoint;
		    //ro.endpoint="http://localhost/amfphp/gateway.php";   
		    return ro;   
		}   		
		
		
		public function getTaxon(id:Number):void {
			
			if((Application.application.selectedTaxon1!=null &&
				Application.application.selectedTaxon1.id==id) ||
				(Application.application.selectedTaxon2!=null &&
				Application.application.selectedTaxon2.id==id) ||
				(Application.application.selectedTaxon3!=null &&
				Application.application.selectedTaxon3.id==id)) {
					MapController.gi().showMapWarning("You have already included this species, please select another",2);
					return;
				}
				
			if (taxonDictionary[id]!=null) {
				addTaxon(taxonDictionary[id]);
			}else {
				Application.application.currentState="loading";
				roTaxon.getTaxonById(id);		
				Application.application.gaTracker.trackPageview("/taxon/"+id);
				trace("requestion ID: " + id);
				AppStates.gi().debug("Requesting ID: "+id);
			}
				
		}		
		
		
		private function onTaxonResult(event:ResultEvent):void {
			//check which slot is free
			var taxon:Taxon;			
			
			var c:Object=event.result;

			taxon= new Taxon();
			taxon.cites=c.cites;
			taxon.className=c.className;
			taxon.cms=c.cms;
			taxon.commonNameEnglish=c.commonNameEnglish;
			taxon.commonNameFreanch=c.commonNameFreanch;
			taxon.commonNameGerman=c.commonNameGerman;
			taxon.commonNameSpanish=c.commonNameSpanish;
			taxon.genus=c.genus;
			taxon.group=c.group;
			taxon.id=c.id;
			taxon.gbif_id=c.gbif_id;
			taxon.migrationType=c.migrationType;
			taxon.name=c.name;
			taxon.red_list=c.red_list;
			taxon.source=c.source;
			if(String(c.redlist_id).length>0)
				taxon.redlist_id=c.redlist_id;
			taxon.cms_status=c.cms_status_2;
			taxon.cms_description=c.cms_description;
			if(String(c.external_url).length>0)
				taxon.external_url=String(c.external_url).substr(1,String(c.external_url).length-2);	
			
			
			taxon.chart =  new ArrayCollection();
			
			for each(var ch:Object in c.charts) {
				
				var st:String = ch.status;
				if(st=='' || st==null || st=='0')
					st='none';
				taxon.chart.addItem(
					{
						monthStart:ch.monthstart,
						monthEnd:ch.monthend,
						status:st
					});
			}
			
			taxonDictionary[c.id]=taxon;
			addTaxon(taxon);
			
/* 			var p:PolylineEncoder = new PolylineEncoder(18,2,0.00001,true);
			var currentGid:Number=0;
			var currentChart:Object;
			for each(var geom:Object in c.geometries) {
				if(geom.gid!=currentGid) {
					if(currentGid!=0) {
						taxon.chart.addItem(currentChart);
					}
					currentChart=new Object();
					currentChart.monthStart = geom.monthstart;
					currentChart.monthEnd = geom.monthend;
					currentChart.status = geom.status;
					currentChart.style = "s11";
					currentChart.geometry=new MultiPolygon();
					
/					var color:Number = Math.random()*0xFFFFFF;
					
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
			taxon.chart.addItem(currentChart); */
			
			
			
/* 			for each(var ch:Object in taxon.chart) {
				(ch.geometry as MultiPolygon).addToMap(lastTaxonInserted);
			} */
			
			
		}
		
		
		private function addTaxon(taxon:Taxon):void {
			
			if(Application.application.selectedTaxon1==null) {
				taxon.colorizedColor =availableColors[0];
				Application.application.selectedTaxon1 = taxon;
			} else if(Application.application.selectedTaxon2==null) {
				taxon.colorizedColor =availableColors[1];
				Application.application.selectedTaxon2 = taxon;
			} else if(Application.application.selectedTaxon3==null) {
				
				taxon.colorizedColor =availableColors[2];
				Application.application.selectedTaxon3 = taxon;
			} else {
				taxon.colorizedColor= Application.application.selectedTaxon1.colorizedColor;
				MapController.gi().removeGbifTileLayer(Application.application.selectedTaxon1.id);
				MapController.gi().removeWMSTileLayer(Application.application.selectedTaxon1.id);
				Application.application.selectedTaxon1 = Application.application.selectedTaxon2;
				Application.application.selectedTaxon2 = Application.application.selectedTaxon3;
				Application.application.selectedTaxon3 = taxon;
				
			}	
	
			
			
			MapController.gi().createWMSTileLayer(taxon.id,taxon.colorizedColor);
			MapController.gi().createGbifLayer(taxon.gbif_id,taxon.id);
			
			var t:Taxon;
			selectedTaxons.removeAll();
			if(Application.application.selectedTaxon1!=null) {
				
 				for each(var c:Object in Application.application.selectedTaxon1.chart) {
					c.colorizeColor=Application.application.selectedTaxon1.colorizedColor;
				} 
				
				t=Application.application.selectedTaxon1;
				selectedTaxons.addItem(t);	
			}if(Application.application.selectedTaxon2!=null){
				for each(var c1:Object in Application.application.selectedTaxon2.chart) {
					c1.colorizeColor=Application.application.selectedTaxon2.colorizedColor;
				}
				t=Application.application.selectedTaxon2;
				selectedTaxons.addItem(t);	
			}if(Application.application.selectedTaxon3!=null){
				for each(var c2:Object in Application.application.selectedTaxon3.chart) {
					c2.colorizeColor=Application.application.selectedTaxon3.colorizedColor;
				}
				t=Application.application.selectedTaxon3;
				selectedTaxons.addItem(t);	
			}	
			
			
			Application.application.timeLine.dataProvider = selectedTaxons;
			Application.application.expandWidget();
			dispatchEvent(new DataServiceEvent(DataServiceEvent.PA_DATA_LOADED,true));
		}
		
		
		
/* 		private function createPolygon(geometry:Object):Polygon {
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

		} */
		
/* 		private function createCircleArea(center:LatLng, area:Number):Polygon {
			var radius_km:Number = 20;
			if (!isNaN(area)) {
				radius_km = Math.sqrt((Number(area)/100)/Math.PI);
			}
			var radius:Number = Math.round((Number(radius_km)/1.609)*100000)/100000;
			//var center:LatLng = new LatLng(geometry.points[0][1],geometry.points[0][0]);															
			return MapUtils.drawCircle(center.lat(),center.lng(),radius,0x0099FF,1,1,0x0099FF,0.5);						
		}	 */
		
		
		private function onFault(event:FaultEvent):void {
			trace(event.message);
		}		
		
		
	}
}
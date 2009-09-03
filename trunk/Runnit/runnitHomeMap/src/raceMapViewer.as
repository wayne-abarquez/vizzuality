package
{
	import com.google.maps.LatLng;
	import com.google.maps.LatLngBounds;
	import com.google.maps.Map;
	import com.google.maps.MapEvent;
	import com.google.maps.MapOptions;
	import com.google.maps.controls.ControlPosition;
	import com.google.maps.controls.ZoomControl;
	import com.google.maps.controls.ZoomControlOptions;
	import com.google.maps.overlays.Marker;
	import com.google.maps.overlays.Polyline;
	import com.google.maps.styles.FillStyle;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.text.TextField;
	
	import rosa.RosaSettings;
	import rosa.events.RosaEvent;
	import rosa.services.ServiceProxy;

	[SWF(backgroundColor=0xFFFFFF, width=598, height=400)]
	public class raceMapViewer extends Sprite
	{
		
		private var map:Map;
		[Embed('assets/cargandomapa1.png')] 
		private var loadingImg:Class;	
		private var imgLoading:Bitmap;	
		private var square:Sprite;			
		private var line:Sprite;			
		private var service:ServiceProxy;
		private var track:Polyline;
		private var trackLength:Number;
		private var altim:Array;
		private var altimetriaMarker:Marker;
		
		public function raceMapViewer()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;					
			
			imgLoading= new loadingImg() as Bitmap;
			imgLoading.x = 200;
			imgLoading.y = 150;
			mouseChildren = true;		
			
				
			initMap();
		}
		
		
		private function initMap():void {
			map=new Map();
			map.addEventListener(MapEvent.MAP_PREINITIALIZE, preinit);
			map.key="ABQIAAAAtDJGVn6RztUmxjnX5hMzjRTy9E-TgLeuCHEEJunrcdV8Bjp5lBTu2Rw7F-koeV8TrxpLHZPXoYd2BA";
			map.addEventListener(MapEvent.MAP_READY, onMapReady);
			map.setSize(new Point(610, 250));
			addChild(map);
 			square = new Sprite();
			square.graphics.beginFill(0xFFFFFF);
			square.graphics.drawRect(0,0,650,400);
			square.graphics.endFill();
			square.x = 0;
			square.y = 0;			
			
 			line = new Sprite();
			line.graphics.beginFill(0x000000);
			line.graphics.drawRect(0,0,1,130);
			line.graphics.endFill();
			line.y = 250;					
			
			
			var debugText:TextField=new TextField();
			debugText.text="DEBUG: "+ root.loaderInfo.parameters.id;
			
			addChild(square);
			addChild(imgLoading);
			//addChild(debugText);
		}		
		
		private function preinit(ev:Event):void {
				var mo:MapOptions = new MapOptions();
				mo.backgroundFillStyle = new FillStyle({color:0xFFFFFF});
				map.setInitOptions(mo);
		}		
		
		private function onMapReady(event:MapEvent):void
		{
			var zco:ZoomControlOptions= new ZoomControlOptions({
				position:new ControlPosition(ControlPosition.ANCHOR_TOP_LEFT, 10, 10)
			});
			map.addControl(new ZoomControl(zco));
			map.enableScrollWheelZoom();
			//downloadData();
			
			with(RosaSettings) {
				localTestGatewayURL="http://localhost/amfphp/gateway.php";
				gatewayURL = "http://runnity.com/amfphp/gateway.php";
				
			}
			service = new ServiceProxy("RunnitServices");
			service.addEventListener(RosaEvent.RESULT, getTrackGeometryResult);
			service.addEventListener(RosaEvent.FAULT, getTrackGeometryResult);
			service.getTrackGeometry(root.loaderInfo.parameters.id);
			
			removeChild(imgLoading);	
			removeChild(square);	

		}		
		
		private function 	getTrackGeometryFault(event:RosaEvent):void {
			trace(event.error);
		}
		
		private function getTrackGeometryResult(event:RosaEvent):void {
			
			
			var points:Array=[];
			for each(var p:Object in event.result.track as Array) {
				points.push(new LatLng(p.lat,p.lon));
			}
			if(points.length>2) {
				track =  new Polyline(points);
				map.addOverlay(track);
				map.setCenter(track.getLatLngBounds().getCenter(),map.getBoundsZoomLevel(track.getLatLngBounds()));
				
				//craete Google Charts URL
				var url:String="http://chart.apis.google.com/chart?cht=lc&chxt=x,y&chs=610x150&chco=0077CC&chm=B,E6F2FA,0,0,0";
				var maxAltitude:Number=0;
				var minAltitude:Number=1000000;
				altim = (event.result.altimetria as String).split(",");
				for each(var al:Number in altim) {
					if (maxAltitude<al)
						maxAltitude=al;
					if (minAltitude>al)
						minAltitude=al;	
				}		
				
				trackLength=track.getLength();
			
				//add 10% around

 				var diff:Number = Math.round((maxAltitude-minAltitude)*.1);
				url+="&chxr=0,0," + trackLength.toString() +
					 "|1," + (minAltitude-diff) +","+(maxAltitude+diff) +
					 "&chds=" + (minAltitude-diff) +","+(maxAltitude+diff);

				url+="&chd=t:" + event.result.altimetria;
				var imgLoader:Loader = new Loader();
				imgLoader.x=0;
				imgLoader.y=250;
				addChild(imgLoader);
				imgLoader.load(new URLRequest(url)); 
				this.addEventListener(MouseEvent.MOUSE_MOVE,onImgLoader);
				this.addEventListener(MouseEvent.ROLL_OUT,onImageRollOut);
				


			} else {
				map.setSize(new Point(600,400));
				var startMarker:Marker = new Marker(new LatLng(event.result.start.lat,event.result.start.lon));
				map.addOverlay(startMarker);
				if(event.result.end.lat !=null) {
					var endMarker:Marker = new Marker(new LatLng(event.result.end.lat,event.result.end.lon));
					map.addOverlay(endMarker);
					var bounds:LatLngBounds = new LatLngBounds(startMarker.getLatLng(),endMarker.getLatLng());
					map.setCenter(bounds.getCenter(),map.getBoundsZoomLevel(bounds)-1);
					
				} else {
					map.setCenter(startMarker.getLatLng(),10);
				}
			}
		}
		
		private function onImgLoader(ev:MouseEvent):void {
			var posX:Number = ev.localX-30;
			if(ev.localX-30>=0) {
					var ll:LatLng = getPointAtDistance((((ev.localX-30)*trackLength)/580));
					if(altimetriaMarker!=null)
						map.removeOverlay(altimetriaMarker);
							
					//var altitude:Number = altim[Math.round(((((ev.localX-30)*trackLength)/580)*altim.length)/trackLength)];
					altimetriaMarker=new Marker(ll);
					map.addOverlay(altimetriaMarker);
					
					
					//add the line
					line.x=ev.localX;
					addChild(line);
					
					//find altitude at point:
					
			}
		}
		
		private function onImageRollOut(event:MouseEvent):void {
			if(altimetriaMarker!=null)
				map.removeOverlay(altimetriaMarker);
				
			removeChild(line);
		}
		
        private function getPointAtDistance(metres:Number):LatLng {

            if (metres == 0) return track.getVertex(0);
            if (metres < 0) return null;
            var dist:Number=0;
               var olddist:Number=0;
               for (var i:uint=1; (i < track.getVertexCount() && dist < metres); i++) {
                       olddist = dist;
                       dist += track.getVertex(i).distanceFrom(track.getVertex(i-1));
               }
               if (dist < metres) {return null;}
                       var p1:LatLng= track.getVertex(i-2);
                       var p2:LatLng= track.getVertex(i-1);
                       var m:Number = (metres-olddist)/(dist-olddist);

                // Use linear interpolation on the last bit
               return new LatLng(p1.lat() + (p2.lat()-p1.lat())*m,
                   p1.lng() + (p2.lng()-p1.lng())*m);
         }		
		
		
		
		
		
	}
}
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
	import com.google.maps.overlays.MarkerOptions;
	import com.google.maps.overlays.Polyline;
	import com.google.maps.overlays.PolylineOptions;
	import com.google.maps.styles.FillStyle;
	import com.vizzuality.gmaps.GenericMarkerIcon;
	
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
	import flash.text.TextFormat;
	
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
		private var altitudeText:TextField;
		private var distanceText:TextField;
		private var markerRunnerOpt:MarkerOptions;
		
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
			if(this.root.loaderInfo.parameters.mapkey!=null) {
				map.key=this.root.loaderInfo.parameters.mapkey;							
			} else {
				map.key="ABQIAAAAtDJGVn6RztUmxjnX5hMzjRT2yXp_ZAY8_ufC3CFXhHIE1NvwkxSPLBWm1r4y_v-I6fII4c2FT0yK6w";
			}
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
			
			
			altitudeText = new TextField();
			var format:TextFormat = altitudeText.getTextFormat();
			//format.font = '_sans';
			format.bold=true;
			altitudeText.defaultTextFormat = format;
			altitudeText.text = " ";
			altitudeText.textColor = 0x000000;
			//tf.x = -int(tf.textWidth / 2) - 2;
			//tf.y = -int(tf.textHeight / 2);
			altitudeText.x = 550;
			altitudeText.y = 260;
			altitudeText.mouseEnabled = false;
			altitudeText.width = altitudeText.textWidth + 4;		
			
			
			
			//runner marker opt;
			markerRunnerOpt = new MarkerOptions();
			markerRunnerOpt.iconOffset = new Point(-13,-30);
			markerRunnerOpt.hasShadow = false;
			markerRunnerOpt.draggable = false;		
			markerRunnerOpt.icon = new GenericMarkerIcon("runner");
			
			
			
/* 			var debugText:TextField=new TextField();
			debugText.text="DEBUG: "+ root.loaderInfo.parameters.id; */
			
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
			

		}		
		
		private function getTrackGeometryFault(event:RosaEvent):void {
			trace(event.error);
		}
		
		private function getTrackGeometryResult(event:RosaEvent):void {
			
			
			var points:Array=[];
			for each(var p:Object in event.result.track as Array) {
				points.push(new LatLng(p.lat,p.lon));
			}
			
			if(points.length>1) {
				var polyOpt:PolylineOptions=new PolylineOptions({
					strokeStyle: {
						thickness: 3,
						color: 0xFF2614,
						alpha: 0.7
					}
				});
				track =  new Polyline(points,polyOpt);
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
			
			
			
			
				if(maxAltitude==0 && minAltitude==0) {
					url+="&chxr=0,0," + trackLength.toString() +
					 "|1,-50,50" +
					 "&chds=-50,50";					
				} else if(maxAltitude-minAltitude<100) {								
					url+="&chxr=0,0," + trackLength.toString() +
						 "|1," + Math.floor(minAltitude*0.7) +","+Math.ceil(maxAltitude*1.8) +
						 "&chds=" + Math.floor(minAltitude*0.7) +","+Math.ceil(maxAltitude*1.8);
				} else {
					url+="&chxr=0,0," + trackLength.toString() +
						 "|1," + Math.floor(minAltitude*0.7) +","+Math.ceil(maxAltitude*1.3) +
						 "&chds=" + Math.floor(minAltitude*0.7) +","+Math.ceil(maxAltitude*1.3);
				}
			

				url+="&chd=t:" + event.result.altimetria;
				var imgLoader:Loader = new Loader();
				imgLoader.x=0;
				imgLoader.y=250;
				addChild(imgLoader);
				addChild(altitudeText);
				imgLoader.load(new URLRequest(url)); 
				this.addEventListener(MouseEvent.MOUSE_MOVE,onImgLoader);
				this.addEventListener(MouseEvent.ROLL_OUT,onImageRollOut);
				
				var startOpt:MarkerOptions = new MarkerOptions();
				startOpt.iconOffset = new Point(-10,-10);
				startOpt.hasShadow = true;
				startOpt.draggable = false;
				startOpt.icon = new GenericMarkerIcon("start");
				var sMarker:Marker= new Marker(points[0],startOpt);
				map.addOverlay(sMarker);
				
				var endOpt:MarkerOptions = new MarkerOptions();
				endOpt.iconOffset = new Point(-10,-10);
				endOpt.hasShadow = true;
				endOpt.draggable = false;
				endOpt.icon = new GenericMarkerIcon("end");
				var eMarker:Marker= new Marker(points[points.length-1],endOpt);
				map.addOverlay(eMarker);
				
				//find the intermediate markers
				//dive the length by 10000
				
				var kmBetweenMarkers:Number;
				if(trackLength<10000) {
					kmBetweenMarkers=1000;
				} else if(trackLength<20000) {
					kmBetweenMarkers=2000;			
				} else {
					kmBetweenMarkers=5000;								
				}
				for (var n:Number=1;n<=Math.floor(trackLength/kmBetweenMarkers);n++) { 
					var pos:LatLng = getPointAtDistance(n*kmBetweenMarkers);
					var interOpt:MarkerOptions = new MarkerOptions();
					interOpt.iconOffset = new Point(-10,-10);
					interOpt.hasShadow = false;
					interOpt.draggable = false;
					interOpt.tooltip=(n*kmBetweenMarkers/1000).toString() + 'Km.: '+altim[Math.round((n*kmBetweenMarkers*altim.length)/trackLength)]+" m.";
					interOpt.icon = new GenericMarkerIcon("km",(n*kmBetweenMarkers/1000).toString());
					var kMarker:Marker= new Marker(pos,interOpt);
					map.addOverlay(kMarker);
				}
				

			} else {
				
				var startOpt2:MarkerOptions = new MarkerOptions();
				startOpt2.iconOffset = new Point(-10,-10);
				startOpt2.hasShadow = true;
				startOpt2.draggable = false;
				startOpt2.icon = new GenericMarkerIcon("start");
				
				var endOpt2:MarkerOptions = new MarkerOptions();
				endOpt2.iconOffset = new Point(-10,-10);
				endOpt2.hasShadow = true;
				endOpt2.draggable = false;
				endOpt2.icon = new GenericMarkerIcon("end");			
				
				map.setSize(new Point(610,400));
				var startMarker:Marker = new Marker(new LatLng(event.result.start.lat,event.result.start.lon),startOpt2);
				map.addOverlay(startMarker);
				if(event.result.end.lat !=null) {
					var endMarker:Marker = new Marker(new LatLng(event.result.end.lat,event.result.end.lon),endOpt2);
					map.addOverlay(endMarker);
					var bounds:LatLngBounds= new LatLngBounds();
					bounds.extend(startMarker.getLatLng());
					bounds.extend(endMarker.getLatLng());
					map.setCenter(bounds.getCenter(),map.getBoundsZoomLevel(bounds)-1);
					
				} else {
					map.setCenter(startMarker.getLatLng(),10);
				}
			}
			
			removeChild(imgLoading);	
			removeChild(square);				
			
		}
		
		private var lineAdded:Boolean=false;
		private function onImgLoader(ev:MouseEvent):void {
			var posX:Number = ev.localX-30;
			if(ev.localX-30>=0) {
					var ll:LatLng = getPointAtDistance((((ev.localX-30)*trackLength)/580));
					if(altimetriaMarker!=null)
						map.removeOverlay(altimetriaMarker);
							
					//var altitude:Number = altim[Math.round(((((ev.localX-30)*trackLength)/580)*altim.length)/trackLength)];
					//altitudeText.text=altitude +"m.";
					if(altimetriaMarker==null) {
						
						
						altimetriaMarker=new Marker(ll,markerRunnerOpt);
					} else {
						altimetriaMarker.setLatLng(ll);
					}
					map.addOverlay(altimetriaMarker);
					
					
					//add the line
					line.x=ev.localX;
					if(!lineAdded) {
						addChild(line);
						lineAdded=true;						
					}
					
					
			}
		}
		
		private function onImageRollOut(event:MouseEvent):void {
			if(altimetriaMarker!=null)
				map.removeOverlay(altimetriaMarker);
			
			lineAdded=false;	
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
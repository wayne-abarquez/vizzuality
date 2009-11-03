package com.vizzuality.tileoverlays
{
	import com.google.maps.LatLng;
	import com.google.maps.MapEvent;
	import com.google.maps.PaneId;
	import com.google.maps.interfaces.IMap;
	import com.google.maps.interfaces.IPane;
	import com.google.maps.overlays.OverlayBase;
	import com.vizzuality.markers.ClusterMarkerIcon;
	import com.vizzuality.markers.SearchMarkerIcon;
	
	import flare.vis.data.NodeSprite;
	
	import flash.events.Event;
	import flash.geom.Point;

	public class MarkersOverlay extends OverlayBase
	{
		
		public var graphSprite:MarkersGraphSprite;
		
		public var markersGraph:Object;
				
		public function MarkersOverlay() {
			super();
    		addEventListener(MapEvent.OVERLAY_ADDED, handleOverlayAdded,false,0,true);
    		addEventListener(MapEvent.OVERLAY_REMOVED, handleOverlayRemoved,false,0,true);			
			
		}
		
		private function handleOverlayAdded(event:Event):void {
			graphSprite = new MarkersGraphSprite(pane.map.getSize());
		    addChild(graphSprite);
		}
		  
		private function handleOverlayRemoved(event:Event):void {
		    removeChild(graphSprite);
		}		
		
		override public function getDefaultPane(map:IMap):IPane {
		    return map.getPaneManager().getPaneById(PaneId.PANE_OVERLAYS);
		}
		
		
		override public function positionOverlay(zoom:Boolean):void
		{
		    if (zoom){
		    	
		    }
		
			for each(var node:NodeSprite in graphSprite.data.nodes) {
				if (node is ClusterMarkerIcon) {					
					var pos:Point = pane.fromLatLngToPaneCoords((node as ClusterMarkerIcon).location);
					node.x=pos.x;
					node.y=pos.y;
				}
			}
			
		}	
		
		public function clearOverlays():void {
			//graphSprite.data=new Data();
			graphSprite.clear();
		}
		
		public function addMarkerCluster(markers:Array,llatlng:LatLng):void {
			
			//create the anchor
			var baseAnchor:ClusterMarkerIcon = new ClusterMarkerIcon(llatlng);			
			graphSprite.data.addNode(baseAnchor);
	        baseAnchor.fix(1);
	        baseAnchor.size = 0.5;
	        baseAnchor.fillColor = 0x88aaaaaa;
	        var pos:Point = pane.fromLatLngToPaneCoords(llatlng);
	        baseAnchor.x=pos.x;
			baseAnchor.y=pos.y;
	        
	        for each(var m:Object in markers) {
		        var m2:SearchMarkerIcon=new SearchMarkerIcon("http://localhost:3000/images/thumbnails/thumb01.jpg",1,true);
		        graphSprite.data.addNode(m2);
		        //m1.size = 1;
		        graphSprite.data.addEdgeFor(baseAnchor,m2);	        	
	        }
	        
	        var edgesStyle:Object = {
				lineColor: 0x00000000,
				lineWidth: 3,
				alpha: 1,
				visible: true			
				};
	        graphSprite.data.edges.setProperties(edgesStyle);	
	        graphSprite.vis.update();
	        
		}	
		
		
	}
}
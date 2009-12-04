package com.vizzuality.tileoverlays
{
	import com.google.maps.Color;
	import com.google.maps.MapEvent;
	import com.google.maps.PaneId;
	import com.google.maps.interfaces.IMap;
	import com.google.maps.interfaces.IPane;
	import com.google.maps.overlays.OverlayBase;
	import com.vizzuality.markers.ClusterMarkerIcon;
	import com.vizzuality.markers.CustomEdgeSprite;
	import com.vizzuality.markers.SearchMarkerIcon;
	
	import flare.physics.Simulation;
	import flare.vis.Visualization;
	import flare.vis.data.Data;
	import flare.vis.data.EdgeSprite;
	import flare.vis.data.NodeSprite;
	import flare.vis.operator.layout.ForceDirectedLayout;
	
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class MarkersOverlay extends OverlayBase
	{		
		
		private var data:Data;
		private var vis:Visualization;
				
		public function MarkersOverlay() {
			super();
    		addEventListener(MapEvent.OVERLAY_ADDED, handleOverlayAdded,false,0,true);
    		addEventListener(MapEvent.OVERLAY_REMOVED, handleOverlayRemoved,false,0,true);			
			
		}
		
		private function handleOverlayAdded(event:Event):void {
			//graphSprite = new MarkersGraphSprite(pane.map.getSize());
		    //addChild(graphSprite);
		}
		  
		private function handleOverlayRemoved(event:Event):void {
		    removeChild(vis);
		}		
		
		override public function getDefaultPane(map:IMap):IPane {
		    return map.getPaneManager().getPaneById(PaneId.PANE_OVERLAYS);
		}
		
		
		override public function positionOverlay(zoom:Boolean):void
		{
			if (vis!=null && data!=null) {
			    if (zoom){
			    	
			    }
			
				for each(var node:NodeSprite in data.nodes) {
					if (node is ClusterMarkerIcon) {					
						var pos:Point = pane.fromLatLngToPaneCoords((node as ClusterMarkerIcon).location);
						node.x=pos.x;
						node.y=pos.y;
						
					}
				}
				vis.update();
			}
			
		}	
		
		public function clearOverlays():void {
			//graphSprite.data=new Data();
			//graphSprite.data.clear();
			if (vis!=null && data!=null) {
				removeChild(vis);
				vis=null;
				data=null;
			}
		}
		
		public function addMarkerCluster(markers:Array):void {

	        data = new Data();	
			
	        

	        for each(var m:Object in markers) {
				//create the anchor
				var baseAnchor:ClusterMarkerIcon = new ClusterMarkerIcon(m.latlng);			
				//var baseAnchor:NodeSprite=data.addNode();
		        baseAnchor.fix(1);
		        var pos:Point = pane.fromLatLngToPaneCoords(m.latlng);
		        baseAnchor.x=pos.x;
				baseAnchor.y=pos.y;
				data.addNode(baseAnchor);
				
		        var m2:SearchMarkerIcon=new SearchMarkerIcon(m.image,1,true);
		        //var m2:NodeSprite=data.addNode();
		        data.addNode(m2);
		        
		        //mDict[baseAnchor]=m2;
		        var ed:CustomEdgeSprite = new CustomEdgeSprite(baseAnchor,m2);
		        ed.lineWidth=3;
		        ed.lineColor=0xffffffff * Math.random();
		       	var res:EdgeSprite = data.addEdge(ed);
		        
	        }
	        
	        
	        
	        data.nodes.sortBy("depth");
	        
/* 	        var edgDefaults:Object = {
	        	lineColor:Color.RED,
	        	lineWidth:3,
	        	visible:true
	        }; */
	        
	        //graphSprite.vis.update();
	        
	        
            vis = new Visualization(data);
	        vis.bounds = new Rectangle(0, 0, pane.map.getSize().x, pane.map.getSize().y);			
	        //data.edges.setDefaults(defaultEdgeStyle);		
 
 			var fdl:ForceDirectedLayout=new ForceDirectedLayout(true,1,new Simulation(0,0,0.5,-4005));
 			fdl.defaultSpringLength=50;
 			fdl.defaultSpringTension=0.1;
            vis.operators.add(fdl);
      			            
            vis.continuousUpdates = true;          				      
            vis.update();	        
            addChild(vis);
	        
		}	
		
		
	
	
		
	}
}
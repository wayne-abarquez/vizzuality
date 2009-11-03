package com.vizzuality.tileoverlays
{
	import flare.physics.Simulation;
	import flare.vis.Visualization;
	import flare.vis.data.Data;
	import flare.vis.data.NodeSprite;
	import flare.vis.operator.layout.ForceDirectedLayout;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class MarkersGraphSprite extends Sprite
	{
		
		public var vis:Visualization;
		public var data:Data;
		public var defaultEdgeStyle:Object= {
				lineColor: 0xFFFFFFFF,
				lineWidth: 3,
				alpha: 1,
				visible: true			
		};

		public function MarkersGraphSprite(size:Point)
		{
			super();                 
	        data = new Data();	   
            vis = new Visualization(data as Data);
	        vis.bounds = new Rectangle(0, 0, size.x, size.y);			
	        data.edges.setProperties(defaultEdgeStyle);		
 
 			var fdl:ForceDirectedLayout=new ForceDirectedLayout(true,1,new Simulation(0,0,0.6,-1005));
 			fdl.defaultSpringLength=50;
            vis.operators.add(fdl);
      			            
            vis.update();
            vis.continuousUpdates = true;     						
       
            addChild(vis);
			
		}		
		
		public function clear():void {
			for each(var n:NodeSprite in data.nodes) {
				data.removeNode(n);
			}
			vis.update();
		}
		
	}
}
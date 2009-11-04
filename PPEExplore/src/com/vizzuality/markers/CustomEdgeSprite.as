package com.vizzuality.markers
{
	
	import flare.vis.data.EdgeSprite;
	import flare.vis.data.NodeSprite;

	public class CustomEdgeSprite extends EdgeSprite
	{
		public function CustomEdgeSprite(source:NodeSprite=null, target:NodeSprite=null, directed:Boolean=false)
		{
			
			super(source, target, directed);
			//this.render();
			
	        //addChild(this);
		}
		
	}
}
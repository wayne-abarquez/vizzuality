package com.vizzuality.markers
{
	import flash.display.Sprite;
	
	public class OriginMarkerIcon extends Sprite
	{
	  
		public function OriginMarkerIcon()
		{
            var Circle2:Sprite = new Sprite();
			Circle2.graphics.beginFill(0x818181);
            Circle2.graphics.drawCircle(0,0,12);
            Circle2.graphics.endFill();
            addChild(Circle2);
            
            var Circle:Sprite = new Sprite();
			Circle.graphics.beginFill(0x5f5f5f);
            Circle.graphics.drawCircle(0,0,6);
            Circle.graphics.endFill();
            addChild(Circle);
		}
	}
}
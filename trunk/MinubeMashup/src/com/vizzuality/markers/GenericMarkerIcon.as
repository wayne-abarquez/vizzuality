package com.vizzuality.markers
{
	import flash.display.Sprite;
	
	public class GenericMarkerIcon extends Sprite
	{
	  
		public function GenericMarkerIcon(color:String)
		{
			var Circle:Sprite = new Sprite();
			switch(color)
			{
			    case 'yellow':
			        Circle.graphics.beginFill(0xffcc00);
			        break;
			    case 'orange':
			        Circle.graphics.beginFill(0xff9900);
			        break;
			    case 'darkorange':
			        Circle.graphics.beginFill(0xff6600);
			        break;
			    case 'red':
			        Circle.graphics.beginFill(0xff3300);
			        break;
			    case 'special':
			        Circle.graphics.beginFill(0x000000);
			        break;
			}
            Circle.graphics.drawCircle(0,0,6);
            Circle.graphics.endFill();
            addChild(Circle);
		}
	}
}
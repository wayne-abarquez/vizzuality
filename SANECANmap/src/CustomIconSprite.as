package
{
import flash.display.Sprite;

/**
 * InfoWindowSprite is a sprite that contains sub sprites that function as tabs.
 */
public class CustomIconSprite extends Sprite {
  [Embed('assets/blue.png')] private var blue:Class;
  [Embed('assets/green.png')] private var green:Class;
  [Embed('assets/grey.png')] private var grey:Class;
  [Embed('assets/red.png')] private var red:Class;
  [Embed('assets/picOrange.png')] private var picOrange:Class;
  
  
  public function CustomIconSprite(type:String) {
      switch (type) {
      	case "1":
		      addChild(new red());
      		break;
      	case "2":
		      addChild(new green());
      		break;
      	case "3":
		      addChild(new grey());
      		break;
      	case "4":
		      addChild(new blue());
      		break;
      	case "position":
		      addChild(new picOrange());
      		break;
      }
    cacheAsBitmap = true;
  }
  
}

}
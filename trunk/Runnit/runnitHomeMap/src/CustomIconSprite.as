package
{
import flash.display.Sprite;

/**
 * InfoWindowSprite is a sprite that contains sub sprites that function as tabs.
 */
public class CustomIconSprite extends Sprite {
  [Embed('assets/markerIcon.png')] 
  private var icon:Class;
  
  
  public function CustomIconSprite() {
		addChild(new icon());
		cacheAsBitmap = true;
  }
  
}

}
package
{
import flash.display.Sprite;

/**
 * InfoWindowSprite is a sprite that contains sub sprites that function as tabs.
 */
public class IconCustomSprite extends Sprite {
  [Embed('marker.png')] private var marker:Class;
  
  
  public function IconCustomSprite() {
	addChild(new marker());
    cacheAsBitmap = true;
  }
  
}
}
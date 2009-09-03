package
{
import flash.display.Sprite;

/**
 * InfoWindowSprite is a sprite that contains sub sprites that function as tabs.
 */
public class RaceNoActiveMarker extends Sprite {
  [Embed('assets/raceNoActive.png')] 
  private var icon:Class;
  
  
  public function RaceNoActiveMarker() {
		addChild(new icon());
		cacheAsBitmap = true;
  }
  
}

}
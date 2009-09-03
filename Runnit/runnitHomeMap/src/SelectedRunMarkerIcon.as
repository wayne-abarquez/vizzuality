package
{
import flash.display.Sprite;

/**
 * InfoWindowSprite is a sprite that contains sub sprites that function as tabs.
 */
public class SelectedRunMarkerIcon extends Sprite {
  [Embed('assets/race.png')] 
  private var icon:Class;
  
  
  public function SelectedRunMarkerIcon() {
		addChild(new icon());
		cacheAsBitmap = true;
  }
  
}

}
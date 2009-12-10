package
{
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import mx.core.BitmapAsset;

/**
 * InfoWindowSprite is a sprite that contains sub sprites that function as tabs.
 */
public class CustomIconSprite extends Sprite {
  [Embed('assets/square.gif')] private var square:Class;
  
  private var icon:BitmapAsset;
  
  public function CustomIconSprite() {
    icon = new square() as BitmapAsset;
    addChild(icon);
    cacheAsBitmap = true;
    
    this.addEventListener(MouseEvent.MOUSE_OVER,function(event:Event):void {
    	icon.alpha=0.6;
    });
    this.addEventListener(MouseEvent.MOUSE_OUT,function(event:Event):void {
    	icon.alpha=1;
    });
  }
  
}

}
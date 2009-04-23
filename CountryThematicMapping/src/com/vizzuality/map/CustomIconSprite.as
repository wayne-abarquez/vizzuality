package com.vizzuality.map
{
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

/**
 * InfoWindowSprite is a sprite that contains sub sprites that function as tabs.
 */
public class CustomIconSprite extends Sprite {
  [Embed('assets/marker.png')] private var TestImg:Class;
  
  
  public function CustomIconSprite() {
      addChild(new TestImg());
    cacheAsBitmap = true;
  }
  
}

}
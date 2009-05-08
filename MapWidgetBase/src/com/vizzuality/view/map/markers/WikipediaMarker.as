package com.vizzuality.view.map.markers
{
	import flash.display.Sprite;
	
	public class WikipediaMarker extends Sprite
	{
		[Embed('assets/wikipediaIcon.png')] private var Icon:Class;
  
  
		  public function WikipediaMarker() {
		      addChild(new Icon());
		    cacheAsBitmap = true;
		  }
  
}

}
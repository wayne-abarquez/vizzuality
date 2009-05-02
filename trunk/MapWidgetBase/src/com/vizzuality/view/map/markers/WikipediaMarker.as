package com.vizzuality.view.map.markers
{
	public class WikipediaMarker
	{
		[Embed('assets/marker.png')] private var Icon:Class;
  
  
		  public function WikipediaMarker() {
		      addChild(new Icon());
		    cacheAsBitmap = true;
		  }
  
}

}
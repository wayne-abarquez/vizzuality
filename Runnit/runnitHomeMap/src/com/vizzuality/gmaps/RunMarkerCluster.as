package com.vizzuality.gmaps 
{
	import com.google.maps.overlays.Marker;
	import com.google.maps.overlays.MarkerOptions;
	
	import flash.geom.Point;

	/**
	 * @author kelvinluck
	 */
	public class RunMarkerCluster extends Marker 
	{

		public function RunMarkerCluster(cluster:Array)
		{
			var options:MarkerOptions = new MarkerOptions();
			options.iconOffset = new Point(-15,-34);
			options.icon = new RunMarkerClusterIcon(cluster.length);
			options.hasShadow = false; 		
			
			super((cluster[0] as Marker).getLatLng(), options);
		}
	}
}

import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFormat; 

internal class RunMarkerClusterIcon extends Sprite
{

  [Embed('assets/groupMarkerIcon.png')] 
  private var icon:Class;
  
	public function RunMarkerClusterIcon(numChildren:int)
	{
		addChild(new icon());
		//graphics.beginFill(0x336699);
		//graphics.drawCircle(0, 0, 15);
		var tf:TextField = new TextField();
		var format:TextFormat = tf.getTextFormat();
		format.font = 'Arial';
		format.bold=true;
		tf.defaultTextFormat = format;
		tf.text = numChildren + '';
		tf.textColor = 0xffffff;
		//tf.x = -int(tf.textWidth / 2) - 2;
		//tf.y = -int(tf.textHeight / 2);
		tf.x = 10;
		tf.y = 7;
		tf.mouseEnabled = false;
		tf.width = tf.textWidth + 4;
		mouseChildren = false;
		addChild(tf);
	}
}
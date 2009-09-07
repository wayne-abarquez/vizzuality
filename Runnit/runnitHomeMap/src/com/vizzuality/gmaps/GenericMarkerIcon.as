package com.vizzuality.gmaps
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat; 
	
	public class GenericMarkerIcon extends Sprite
	{
	
	  [Embed('assets/end.png')] 
	  private var end:Class;
	  [Embed('assets/km.png')] 
	  private var km:Class;
	  [Embed('assets/start.png')] 
	  private var start:Class;
	  [Embed('assets/runner.png')] 
	  private var runner:Class;
	  [Embed('assets/groupMarkerIcon.png')] 
	  private var groupMarkerIcon:Class;
	  [Embed('assets/markerIcon.png')] 
	  private var markerIcon:Class;
	  [Embed('assets/raceNoActive.png')] 
	  private var raceNoActive:Class;
	  [Embed('assets/raceNoActiveEmpty.png')] 
	  private var raceNoActiveEmpty:Class;
	  
		public function GenericMarkerIcon(icon:String,texto:String="")
		{
			switch(icon) {
				case "end":
					addChild(new end());
					break;
				case "km":
					addChild(new km());
					break;
				case "start":
					addChild(new start());
					break;
				case "runner":
					addChild(new runner());
					break;
				case "groupMarkerIcon":
					addChild(new groupMarkerIcon());
					break;
				case "markerIcon":
					addChild(new markerIcon());
					break;
				case "raceNoActive":
					addChild(new raceNoActive());
					break;
				case "raceNoActiveEmpty":
					addChild(new raceNoActiveEmpty());
					break;
			}
			if(texto!="") {
				//graphics.beginFill(0x336699);
				//graphics.drawCircle(0, 0, 15);
				var tf:TextField = new TextField();
				var format:TextFormat = tf.getTextFormat();
				format.font = 'Arial';
				format.bold=true;
				tf.defaultTextFormat = format;
				tf.text = texto;
				tf.textColor = 0xffffff;
				//tf.x = -int(tf.textWidth / 2) - 2;
				//tf.y = -int(tf.textHeight / 2);
				if(icon!="km") {
					tf.y = 7;
					if(texto.length>2) {
						tf.x = 3;				
					} else if (texto.length>1) {
						tf.x = 6;
					} else {
						tf.x = 9;
					}					
				} else {
					tf.y = 0;
					tf.x = 4;
					
				}
				
				tf.mouseEnabled = false;
				tf.width = tf.textWidth + 4;
				mouseChildren = false;
				addChild(tf);
			}
		}
	}
}
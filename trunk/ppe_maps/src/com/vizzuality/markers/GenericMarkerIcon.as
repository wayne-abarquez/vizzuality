package com.vizzuality.markers
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat; 
	
	public class GenericMarkerIcon extends Sprite
	{
	

	  [Embed('assets/cluster.png')] 
	  private var clusterIcon:Class;
	  [Embed('assets/comment.png')] 
	  private var comment:Class;
	  [Embed('assets/activity.png')] 
	  private var activity:Class;

	  
		public function GenericMarkerIcon(icon:String,texto:String="")
		{
			switch(icon) {
				case "clusterIcon":
					addChild(new clusterIcon());
					break;
				case "commentIcon":
					addChild(new comment());
					break;
				case "activityIcon":
					addChild(new activity());
					break;
			}
			if(texto!="") {

				var tf:TextField = new TextField();
				var format:TextFormat = tf.getTextFormat();
				format.font = 'Arial';
				format.bold=true;
				tf.defaultTextFormat = format;
				tf.text = texto;
				tf.textColor = 0xffffff;

				tf.y = 5;
				if(texto.length>2) {
					tf.x = 3;				
				} else if (texto.length>1) {
					tf.x = 6;
				} else {
					tf.x = 9;
				}
				
				tf.mouseEnabled = false;
				tf.width = tf.textWidth + 4;
				tf.height=20;
				mouseChildren = false;
				addChild(tf);
			}
		}
	}
}
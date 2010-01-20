package com.vizzuality.tests{
	
	import com.google.maps.Color;
	import com.google.maps.LatLng;
	
	import flare.vis.data.NodeSprite;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class SearchClusterMarkerIcon extends NodeSprite {	

		public var location:LatLng;
		
        public function SearchClusterMarkerIcon(number:String) {
    		super();
    		
    		this.buttonMode = true;
			this.useHandCursor = true;
			this.mouseChildren = false;
			
    		addEventListener(MouseEvent.CLICK,onClickCluster);
            var background:Shape = new Shape();
            background.graphics.beginFill(Color.RED,1);
            background.graphics.drawCircle(0,0,20);
            background.graphics.endFill();
            addChild(background);   
            
	        var mainNameSprite: Sprite = new Sprite();
            var nameText: TextField = new TextField();
            nameText.text = number;
            var newFormat:TextFormat = new TextFormat(); 
   			newFormat.size = 20; 
   			newFormat.color = 0xFFFFFF;
   			newFormat.bold = true;
   			newFormat.letterSpacing = 0;
			newFormat.font = "Helvetica";
    		nameText.setTextFormat(newFormat); 
            nameText.wordWrap = true;
            nameText.width = 30;
            nameText.height = 30;
            nameText.x = -16;
            nameText.y = -13;
            mainNameSprite.x = 10;
            mainNameSprite.y = 3;
            mainNameSprite.addChild(nameText);
            mainNameSprite.width = 30;
            mainNameSprite.height = 30;
            mainNameSprite.mouseChildren=false;
            mainNameSprite.buttonMode=true;
            mainNameSprite.useHandCursor=true;
            addChild(mainNameSprite);
       }
       
       private function onClickCluster(event:MouseEvent):void {
	       	
       }
   }
            
 }

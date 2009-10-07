package com.vizzuality.markers
{
	import flash.display.Sprite;
	
	public class SearchInfowindow
	{

		public function SearchInfowindow() extends Sprite {
          
            public function SearchInfowindow(ob:Object) {
 
            		var labelBackground2:Sprite = new Sprite();
		            labelBackground2.graphics.beginFill(0x000000,0.6);
 		            labelBackground2.graphics.drawRoundRect(0,0,200,60+ob.sites*18,7,7);
		            labelBackground2.graphics.endFill();
		            labelBackground2.mouseChildren=false;
		            addChild(labelBackground2);  
		            
		            var labelBackground:Sprite = new Sprite();
		            labelBackground.graphics.beginFill(0xFFFFFF,0.4);
		            labelBackground.graphics.drawCircle(10+2*ob.sites+15,15+2*ob.sites+8,17+2*ob.sites);
		            labelBackground.graphics.endFill();
		            labelBackground.mouseChildren=false;
		            addChild(labelBackground);		 
		            
		            var labelBackground3:Sprite = new Sprite();
		            labelBackground3.graphics.beginFill(0xFFFFFF,0.8);
		            labelBackground3.graphics.drawCircle(10+2*ob.sites+15,12+2*ob.sites+11,12+2*ob.sites);
		            labelBackground3.graphics.endFill();
		            labelBackground3.mouseChildren=false;
		            addChild(labelBackground3);		                       
            	
		            var tf:TextField = new TextField();
                    var format:TextFormat = tf.getTextFormat();
                    format.align = "center";
                    format.font = 'Arial';
                    format.size = 12;
                    format.bold=true;
                    tf.defaultTextFormat = format;
                    tf.textColor = 0x000000;
                    tf.text = ob.short;
                    tf.mouseEnabled = true;
                    tf.width = 30;
                    tf.height=18;
                    tf.x=10+2*ob.sites;
                    tf.y=15+2*ob.sites;
                    addChild(tf);            	

					var shape1: VizzualityShape = new VizzualityShape(ob.url);
                    var tf2:TextField = new TextField();
                    var format2:TextFormat = tf2.getTextFormat();
                    format2.align = "left";
                    format2.font = 'Arial';
                    format2.size = 20;
                    format2.letterSpacing = -1;
                    format2.bold=true;
                    tf2.defaultTextFormat = format2;
                    tf2.text = ob.name;
                    tf2.textColor = 0xffffff;
                    tf2.width = 130;
                    tf2.height=22;
                    tf2.x=((10+2*ob.sites+15)*2);
                    tf2.y=13;
                    tf2.multiline = true;
                    shape1.addChild(tf2);
                    shape1.mouseChildren=false;
                    shape1.buttonMode=true;
                    shape1.useHandCursor=true;
                    addChild(shape1);
                    shape1.addEventListener(MouseEvent.CLICK,clicked);           
                    
                    	
            	
                    var shape2: Sprite = new Sprite();
                    var tf3:TextField = new TextField();
                    var format3:TextFormat = tf3.getTextFormat();
                    format3.align = "left";
                    format3.font = 'Arial';
                    format3.size = 11;
                    format3.bold=true;
                    tf3.defaultTextFormat = format3;
                    if (ob.sites>1) {
                    	tf3.text = ob.sites + " ICCA SITES";
                    } else {
                    	tf3.text = ob.sites + " ICCA SITE";
                    }
                    tf3.textColor = 0x99cc33;
                    tf3.mouseEnabled = false;
                    tf3.width = 130;
                    tf3.height = 18;
                    tf3.x=0;
                    tf3.y=0;
                    shape2.mouseChildren=false;
                    shape2.addChild(tf3);
                    shape2.x=((10+2*ob.sites+15)*2);
                    shape2.y=34;
                    shape2.width=tf3.width;
                    shape2.height=tf3.height;
                    
                    addChild(shape2);    
      
                    
                     for(var i:int = 0; i<(ob.textSites as Array).length;i++) {
                     	var shape3: VizzualityShape = new VizzualityShape((ob.textSites as Array)[i].url);
                    	var tf4:TextField = new TextField();
	                    var format4:TextFormat = tf4.getTextFormat();
	                    format4.align = "left";
	                    format4.font = 'Arial';
	                    format4.size = 12;
	                    format4.bold=true;
	                    tf4.defaultTextFormat = format4;
						tf4.text = "- " + (ob.textSites as Array)[i].name;
	                    tf4.textColor = 0xFFFFFF;
	                    tf4.width = 130;
	                    tf4.height=20;
	                    tf4.x=((10+2*ob.sites+15)*2);
	                    tf4.y=55+i*15;
	                    shape3.addChild(tf4);
	                    shape3.mouseChildren=false;
                    	shape3.buttonMode=true;
                    	shape3.useHandCursor=true;
	                    addChild(shape3);
	                    shape3.addEventListener(MouseEvent.CLICK,clicked);
                    } 
            }
            
          	private function clicked(event:MouseEvent):void {
			    navigateToURL(new URLRequest(event.target.url));
			}
      }
}
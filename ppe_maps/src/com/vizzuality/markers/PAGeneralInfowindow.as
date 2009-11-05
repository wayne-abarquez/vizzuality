package com.vizzuality.markers
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class PAGeneralInfowindow extends Sprite{
		
			private var imageLoader:Loader = new Loader();
			private var imageMask:Sprite = new Sprite();
			
			public var targetUrl:String;
			
			[Embed('assets/bkg.png')] 
	  		private var bkg:Class;
          
            public function PAGeneralInfowindow(ob:Object) {
 					
				this.buttonMode = true;
				this.useHandCursor = true;
				this.mouseChildren = false; 					
 				
				imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, displayImg);
			
				var fileRequest:URLRequest = new URLRequest("http://localhost:3000"+ob.user.avatar);
				
				imageLoader.load(fileRequest);
 				
				addChild(new bkg());

		        /* var lin:Sprite = new Sprite();
		        lin.graphics.lineStyle(1,0xcccccc);
		   		lin.graphics.beginFill(0xFFFFFF,1);
		   		lin.graphics.drawRoundRect(0,0,140,72,5);
		        addChild(lin);
		        
		        var triangleHeight:uint = 20;
				var triangleShape:Shape = new Shape();
				triangleShape.graphics.lineStyle(1,0xcccccc);
				triangleShape.graphics.beginFill(0xFFFFFF);
				triangleShape.graphics.moveTo(triangleHeight/2, 5);
				triangleShape.graphics.lineTo(triangleHeight, triangleHeight+5);
				triangleShape.graphics.lineTo(0,triangleHeight+5);
				triangleShape.graphics.lineTo(triangleHeight/2, 5);
				triangleShape.x = 55;
				triangleShape.y = 63;
				addChild(triangleShape); */
 				
 				var background:Sprite = new Sprite();
 				background.graphics.lineStyle(1,0xdde3e8);
	            background.graphics.drawRect(5,5,58,58);
	            background.graphics.endFill();
	            addChild(background);
	            
                var mainNameSprite: Sprite = new Sprite();
	            var nameText: TextField = new TextField();
	            nameText.text =  ob.user.username;
	            var newFormat:TextFormat = new TextFormat(); 
	   			newFormat.size = 11; 
	   			newFormat.color = 0x336699;
	   			newFormat.bold = true;
	   			newFormat.letterSpacing = 0;
				newFormat.font = "Helvetica";
	    		nameText.setTextFormat(newFormat); 
	            nameText.wordWrap = true;
	            nameText.width = 70;
	            nameText.height = 15;
	            nameText.x = 0;
	            nameText.y = 0;
	            mainNameSprite.x = 67;
	            mainNameSprite.y = 11;
	            mainNameSprite.addChild(nameText);
	            mainNameSprite.width = 70;
	            mainNameSprite.height = 15;
	            mainNameSprite.mouseChildren=false;
	            mainNameSprite.buttonMode=true;
	            mainNameSprite.useHandCursor=true;
	            addChild(mainNameSprite);

	            
	            var exampleSprite2: Sprite = new Sprite();
	            var countryText2: TextField = new TextField();
	            countryText2.text =  returnTweetAge(ob.created_at);
	            var newFormat2:TextFormat = new TextFormat(); 
	   			newFormat2.size = 11; 
	   			newFormat2.color = 0x999999;
	   			newFormat2.letterSpacing = 0;
				newFormat2.font = "Helvetica";
	    		countryText2.setTextFormat(newFormat2); 
	            countryText2.width = 70;
	            countryText2.height = 15;
	            countryText2.x = 0;
	            countryText2.y = 0;
	            exampleSprite2.x = 67;
	            exampleSprite2.y = 24;
	            exampleSprite2.addChild(countryText2);
	            exampleSprite2.width = 70;
	            exampleSprite2.height = 15; 
	            exampleSprite2.mouseChildren=false;
	            exampleSprite2.buttonMode=true;
	            exampleSprite2.useHandCursor=true;
	            addChild(exampleSprite2);
	            
	            if (ob.action!=null) {
		            var mainNameSprite3: Sprite = new Sprite();
		            var nameText3: TextField = new TextField();
		            var newFormat3:TextFormat = new TextFormat(); 
		   			newFormat3.size = 11; 
		   			newFormat3.color = 0x666666;
		   			newFormat3.bold = true;
		   			newFormat3.letterSpacing = 0;
					newFormat3.font = "Helvetica";
		            nameText3.text =  ob.action;
		    		nameText3.setTextFormat(newFormat3); 
		            nameText3.wordWrap = true;
		            nameText3.width = 70;
		            nameText3.height = 15;
		            nameText3.x = 0;
		            nameText3.y = 0;
		            mainNameSprite3.x = 67;
		            mainNameSprite3.y = 40;
		            mainNameSprite3.addChild(nameText3);
		            mainNameSprite3.width = 70;
		            mainNameSprite3.height = 15;
		            mainNameSprite3.mouseChildren=false;
		            mainNameSprite3.buttonMode=true;
		            mainNameSprite3.useHandCursor=true;
		            addChild(mainNameSprite3);	            	
	            }
	            
	            
	            
	            var mainNameSprite2: Sprite = new Sprite();
	            var nameText2: TextField = new TextField();
	            nameText2.text =  "view";
	    		nameText2.setTextFormat(newFormat); 
	            nameText2.wordWrap = true;
	            nameText2.width = 70;
	            nameText2.height = 15;
	            nameText2.x = 0;
	            nameText2.y = 0;
	            mainNameSprite2.x = 67;
	            mainNameSprite2.y = 50;
	            mainNameSprite2.addChild(nameText2);
	            mainNameSprite2.width = 70;
	            mainNameSprite2.height = 15;
	            mainNameSprite2.mouseChildren=false;
	            mainNameSprite2.buttonMode=true;
	            mainNameSprite2.useHandCursor=true;
	            addChild(mainNameSprite2);
	            
            }
            

			
			private function displayImg(e:Event):void{
  			
	  			imageMask.graphics.beginFill(0x330000,1);
	  			imageMask.graphics.drawRect(9,10,58,58);
	  			imageMask.graphics.endFill();
	  			
	  			addChild(imageMask);
	  			imageLoader.mask = imageMask;
	  			imageLoader.x = 4;
	  			imageLoader.y = 4; 
	  			addChildAt(imageLoader,2);
  			}
  			
  			private function returnTweetAge(created_at:String):String
                {
                        var time:Date = new Date();
                        var tp:Array; var year:int; var month:int; var date:int;
                        var hour:int; var minutes:int; var seconds:int; var timezone:int;

                        if (created_at.match(/\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}Z/g).length==1)
                        {
                                // match 2008-12-07T16:24:24Z
                                tp = created_at.split(/[-T:Z]/g);
                                year = tp[0];
                                month = tp[1];
                                date = tp[2];
                                hour = tp[3];
                                minutes = tp[4];
                                seconds = tp[5];
                                month--;
                        }
                        else if (created_at.match(/[a-zA-z]{3}, \d{2} [a-zA-Z]{3} \d{4} \d{2}:\d{2}:\d{2} \+\d{4}/g).length==1)
                        {
                                // match Fri Dec 05 16:40:02 +0000 2008
                                tp = created_at.split(/[ :]/g);
                                if (tp[3]=="Jan")
                                        month = 0;
                                else if (tp[2]=="Feb")
                                        month = 1;
                                else if (tp[2]=="Mar")
                                        month = 2;
                                else if (tp[2]=="Apr")
                                        month = 3;
                                else if (tp[2]=="May")
                                        month = 4;
                                else if (tp[2]=="Jun")
                                        month = 5;
                                else if (tp[2]=="Jul")
                                        month = 6;
                                else if (tp[2]=="Aug")
                                        month = 7;
                                else if (tp[2]=="Sep")
                                        month = 8;
                                else if (tp[2]=="Oct")
                                        month = 9;
                                else if (tp[2]=="Nov")
                                        month = 10;
                                else if (tp[2]=="Dec")
                                        month = 11;

                                date = tp[1];
                                hour = tp[4];
                                minutes = tp[5];
                                seconds = tp[6];
                                timezone = tp[7];
                                year = tp[3];
                        }

                        time.setUTCFullYear(year, month, date);
                        time.setUTCHours(hour, minutes, seconds);

                        var currentTime:Date = new Date();
                        currentTime.setHours(currentTime.hours);
                        var diffTime:int = currentTime.getTime() - time.getTime();
                        var diff:Date = new Date();
                        diff.setTime(diffTime);

            var txt:String;
                        if(diff.date > 1)
                        {
                            txt = diff.date + " days ago...";
                        }
                        else if(diff.hours > 0)
                        {
                        txt = diff.hours+" hours ago";
                        }
                        else if(diff.minutes > 0)
                        {
                        txt = diff.minutes+" minutes ago";
                        }
                        else if(diff.seconds > 0)
                        {
                        txt = diff.seconds+" seconds ago";
                        }

                        return txt;
                }

  			
  			
      }
}
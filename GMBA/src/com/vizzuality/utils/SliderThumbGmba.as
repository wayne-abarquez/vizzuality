package com.vizzuality.utils
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.controls.sliderClasses.Slider;
	import mx.controls.sliderClasses.SliderThumb;
	import mx.core.mx_internal;
	use namespace mx_internal;


    public class SliderThumbGmba extends SliderThumb {

		public var isMoving:Boolean = false;
        public var spr:DataTipeSlider;
        public var isDisplayed:Boolean = false;
        
        public function SliderThumbGmba() {
        	super();
            initListeners();
            initSprite();
            spr.visible = false    
            addChild(spr);
            useHandCursor = true;
            buttonMode = true;
            mouseChildren = false;
        }
        
         private function initListeners():void{
            addEventListener(MouseEvent.MOUSE_MOVE, myMouseMoveHandler);
            addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
            addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
            /* addEventListener(Event.CHANGE, change);
 */        }
        
        
        
        
        private function myMouseMoveHandler(event:MouseEvent):void {   
        	trace('jamon mueve raton'); 
            if (isMoving) {
            	if (thumbNumber()==1) {
                	spr.setValue(String(Slider(owner).values[1]));
                } else {
                	spr.setValue(String(Slider(owner).values[0]));
                }
            	spr.x = (spr.width/2) - 10;
            	spr.y = 20;
            }
        }
            
            
        private function mouseOver(evt:MouseEvent):void {
            if(!isDisplayed){
                isDisplayed = true;
                if (thumbNumber()==1) {
                	spr.setValue(String(Slider(owner).values[1]));
                } else {
                	spr.setValue(String(Slider(owner).values[0]));
                }
                spr.visible = true;
                spr.x = (spr.width/2) - 10;
            	spr.y = 20;
            }
                
        }
        
        private function mouseOut(evt:MouseEvent):void {
            if(!isMoving){
                 isDisplayed = false;
                 spr.visible = false;
            } else {
            	
				if (thumbNumber()==1) {
	            	spr.setValue(String(Slider(owner).values[1]));
	            	trace(String(Slider(owner).values[1]));
	            } else {
	            	spr.setValue(String(Slider(owner).values[0]));
	            	trace(String(Slider(owner).values[1]));
	            }
            }
                
        }
        
        override protected function mouseDownHandler(event:MouseEvent):void {
        	trace('jamon');
            super.mouseDownHandler(event);
            isMoving = true;
        }
        
  
        override protected function mouseUpHandler(event:MouseEvent):void {
            super.mouseUpHandler(event);
            isMoving = false;
            
         }

        private function initSprite():void{
            spr = new DataTipeSlider();
            spr.x = (spr.width/2);
            spr.y = 20;
        }
        
        private function thumbNumber():Number {
        	return mx_internal::thumbIndex;
        }

    }
}

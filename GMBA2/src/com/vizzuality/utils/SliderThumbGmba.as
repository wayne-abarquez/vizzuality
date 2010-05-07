package com.vizzuality.utils
{
	import flash.events.MouseEvent;
	
	import mx.controls.sliderClasses.Slider;
	import mx.controls.sliderClasses.SliderThumb;
	import mx.core.Application;
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
            spr.visible = false;   
            addChild(spr);
            useHandCursor = true;
            buttonMode = true;
            mouseChildren = false;
        }
        
        private function initListeners():void{
            addEventListener(MouseEvent.MOUSE_MOVE, myMouseMoveHandler);
            addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
            addEventListener(MouseEvent.MOUSE_OUT, mouseOut); 
            Application.application.addEventListener(MouseEvent.MOUSE_MOVE, mouseOutMove);
            Application.application.addEventListener(MouseEvent.MOUSE_UP, mouseOutUp);          
        }
        
        private function mouseOutMove(event:MouseEvent): void {
        	if (isMoving) {
        		changeValue();
        	}	
        }
        
         private function mouseOutUp(event:MouseEvent):void {
         	if (!isDisplayed) {
            	spr.visible = false;
            }
         }
        
        
        private function myMouseMoveHandler(event:MouseEvent):void {
            if (isMoving) {
            	changeValue();
            }
        }
                    
            
        private function mouseOver(evt:MouseEvent):void {
            if(!isDisplayed){
                isDisplayed = true;
                changeValue();
                spr.visible = true;
            }    
        }
        
        private function mouseOut(evt:MouseEvent):void {
            if(!isMoving){
                 spr.visible = false;
            } else {
            	changeValue();
            }
            isDisplayed = false;    
        }
        
        override protected function mouseDownHandler(event:MouseEvent):void {
            super.mouseDownHandler(event);
            isMoving = true;
        }
        
  
        override protected function mouseUpHandler(event:MouseEvent):void {
            super.mouseUpHandler(event);
            isMoving = false;
         }

        private function initSprite():void{
            spr = new DataTipeSlider();
            spr.x = (spr.width/2) - 13;
            spr.y = 18;
        }
        
        private function changeValue():void {
        	if (thumbNumber()==1) {
            	spr.setValue(String(Slider(owner).values[1]));
            } else {
            	spr.setValue(String(Slider(owner).values[0]));
            }
        }
        
        private function thumbNumber():Number {
        	return mx_internal::thumbIndex;
        }
        
		override protected function measure():void {
            super.measure();
            measuredWidth = currentSkin.measuredWidth;
            measuredHeight = currentSkin.measuredHeight;
        }
        
        public function showSliderValue():void{
        	this.spr.visible = true;
        }

    }
}

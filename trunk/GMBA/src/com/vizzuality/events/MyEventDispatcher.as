package com.vizzuality.events
{
  	import flash.events.Event;
  	import flash.events.EventDispatcher;
  	
  	import mx.collections.ArrayCollection;
  	
  	public class MyEventDispatcher extends EventDispatcher {
    	protected static var disp:MyEventDispatcher;
    	
    	
    	public static function addEventListener(p_type:String, p_listener:Function, p_useCapture:Boolean=false, p_priority:int=0, p_useWeakReference:Boolean=false):void {
  			if (disp == null) { disp = new MyEventDispatcher(); }
  			disp.addEventListener(p_type, p_listener, p_useCapture, p_priority, p_useWeakReference);
  		}
		public static function removeEventListener(p_type:String, p_listener:Function, p_useCapture:Boolean=false):void {
  			if (disp == null) { return; }
  			disp.removeEventListener(p_type, p_listener, p_useCapture);
  		}
		public static function dispatchEvent(p_event:Event):void {
  			if (disp == null) { return; }
  			disp.dispatchEvent(p_event);
  		}
    		
    		
    		
  		// Public API that dispatches an event
    	public static function updatedSliders(altitudeRange:Array,reliefRange:Array,vegtypes:Array):void {
   			dispatchEvent(new SliderChangeEvent(SliderChangeEvent.SLIDER_CHANGED,altitudeRange,reliefRange,vegtypes));
    	}
    	
    	public static function onCloseDownloadWindow():void {
    		dispatchEvent(new CloseDownloadWindowEvent(CloseDownloadWindowEvent.CLOSE_WINDOW));
    	}
    	
    	public static function onChangeThumbRelease(altitudeRange:Array,reliefRange:Array,vegtypes:ArrayCollection):void {
   			dispatchEvent(new SliderThumbRelease(SliderThumbRelease.SLIDER_VALUE_CHANGED,altitudeRange,reliefRange,vegtypes));
   			dispatchEvent(new SliderChangeEvent(SliderChangeEvent.SLIDER_CHANGED,altitudeRange,reliefRange,vegtypes.source));
    	}
    	
		public static function onOpenTaxonomic():void {
   			dispatchEvent(new OpenTaxonomicEvent(OpenTaxonomicEvent.OPEN));
    	}
    	
		public static function onChangeMapZoom(zoom:Number):void {
   			dispatchEvent(new ChangeMapZoom(ChangeMapZoom.CHANGED,zoom));
    	}    
    	
    	public static function onChooseTaxon(information:Object):void {
    		dispatchEvent(new ChooseTaxonEvent(ChooseTaxonEvent.CHOSEN,information));
    	}
    		

    }
}
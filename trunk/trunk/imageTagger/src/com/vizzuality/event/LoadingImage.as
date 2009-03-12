package com.vizzuality.event
{
        
        import flash.events.Event;


        public class LoadingImage extends Event
        {
                public static const TAG_COMPLETED : String = "onTaggedGbifComplete";
        		public var dir:String;
                public var name:String;
                public var tag:String;

                public function LoadingImage(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
                {
                        super(type, bubbles, cancelable);
                }       
                
        }
}
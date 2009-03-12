package com.vizzuality.event
{
        
        import flash.events.Event;


        public class GetTokenOK extends Event
        {
                public static const OK_TOKEN : String = "onGetTokenOK";
        
                public function GetTokenOK(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
                {
                        super(type, bubbles, cancelable);
                }       
                
        }
}
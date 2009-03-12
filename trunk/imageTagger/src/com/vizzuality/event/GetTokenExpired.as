package com.vizzuality.event
{
        
        import flash.events.Event;


        public class GetTokenExpired extends Event
        {
                public static const KO_TOKEN : String = "onGetTokenKO";
        
                public function GetTokenExpired(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
                {
                        super(type, bubbles, cancelable);
                }       
                
        }
}
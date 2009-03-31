package com.vizzuality.event
{
	public class GetTokenEvent
	{
        public static const KO_TOKEN : String = "onGetTokenKO";
        public static const OK_TOKEN:  String = "onGetTokenOK";

        public function GetTokenEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
        {
                super(type, bubbles, cancelable);
        }       
                


	}
}
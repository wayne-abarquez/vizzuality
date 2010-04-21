package com.vizzuality.events
{
	 import flash.events.MouseEvent;
 
    // our custom event extends flash.events.Event
    public class DeselectedEvent extends MouseEvent
    {
        // the string must be the same with the one specified
        // in the Event metatag in name attribute
        public static const MY_EVENT:String = "clickOnDeselectEvent";
 
        // constructor
        public function DeselectedEvent(type:String):void
        {
            super(type);
        }
    }

}
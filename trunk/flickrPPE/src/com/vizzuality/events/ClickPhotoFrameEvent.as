package com.vizzuality.events
{
	import com.adobe.webapis.flickr.Photo;
	
	import flash.events.Event;
	
	public class ClickPhotoFrameEvent extends Event
	{
		public static const PHOTOFRAME_CLICKED:String = "photoClicked";
		
		public var flickrPhoto:Photo;
		public var selected:Boolean;
		
		public function ClickPhotoFrameEvent(type:String, flickrPhoto:Photo,selected:Boolean=false, bubbles:Boolean=false, cancelable:Boolean=false):void {
			this.flickrPhoto = flickrPhoto;
			this.selected = selected;
			
			super(type,bubbles,cancelable);
			
		}


	}
}
package
{
	import flash.events.Event;
	
	public class FlickrImageEvent extends Event
	{
		public static const IMAGE_URL:String = "Image_URL_Complete";
		
		public var url: String;
		public var name:String;

		
		public function FlickrImageEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
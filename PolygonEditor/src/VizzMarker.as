package
{
	import com.google.maps.LatLng;
	import com.google.maps.overlays.Marker;
	import com.google.maps.overlays.MarkerOptions;

	public class VizzMarker extends Marker
	{
		public var medium: Boolean;
		
		public function VizzMarker(arg0:LatLng, arg1:MarkerOptions=null,arg3:Boolean=false)
		{
			medium = arg3;
			super(arg0, arg1);
		}
		
	}
}
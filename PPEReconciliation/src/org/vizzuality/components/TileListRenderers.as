package org.vizzuality.components
{
	import mx.controls.TileList;
	import mx.core.mx_internal;

	public class TileListRenderers extends TileList
	{
		use namespace mx_internal;
		
		public function TileListRenderers()
		{
			super();
		}
		
		public function get renderers():Array
        {
            return mx_internal::rendererArray;
        }
		
	}
}
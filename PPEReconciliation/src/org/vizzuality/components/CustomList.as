package org.vizzuality.components
{
	import mx.controls.List;
	import mx.core.mx_internal; //this import statement should appear be last

	public class CustomList extends List
	{
		use namespace mx_internal;
		
		public function CustomList()
		{
			super();
		}
		
        //The array of renderers being used in this list
        public function get renderers():Array
        {
            //prefix the internal property name with its namespace
            return mx_internal::rendererArray;
        }		
		
	}
}
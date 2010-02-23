package com.vizzuality.model
{
	import flash.utils.Dictionary;
	
	public final class StateSingletonModel
	{
		private static var instance:StateSingletonModel = new StateSingletonModel();
		
		public var altitudeRange:Array=[0,7889];
		public var reliefRange:Array=[0,3397];
		public var vegtypeRange:Array=[0,0];
		
		
	  public static function gi():StateSingletonModel {
	     return instance;
	   }		
		
		
		public function StateSingletonModel()
		{
			if( instance ) throw new Error( "Singleton and can only be accessed through Singleton.getInstance()" ); 

		}

	}
}
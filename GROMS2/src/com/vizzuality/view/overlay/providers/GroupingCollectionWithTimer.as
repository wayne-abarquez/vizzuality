package com.vizzuality.view.overlay.providers
{
	import flash.utils.Timer;
	
	import mx.collections.GroupingCollection2;

	public class GroupingCollectionWithTimer extends GroupingCollection2
	{
		public function GroupingCollectionWithTimer()
		{
			super();
		}
		
		public function get protectedTimer():Timer{
			return this.timer;
		}
		
		public function set protectedTimer(v:Timer):void {
			this.timer = v;
		}
	}
}
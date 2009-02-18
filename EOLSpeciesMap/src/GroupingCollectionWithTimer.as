package
{
	import flash.utils.Timer;
	
	import mx.collections.GroupingCollection;

	public class GroupingCollectionWithTimer extends GroupingCollection
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
package org.vizzuality.model
{
	import flash.events.EventDispatcher;
	
	[Bindable]
	public class Task extends EventDispatcher
	{
		public static const PREPARING_DOWNLOAD:String="preparingDownload";
		public static const AWAITING_REVIEW:String="awaitingReview";
		public static const ERROR_IN_DATA:String="errorInData";
		public static const REVIEW_STARTED:String="reviewStarted";
		public static const REVIEW_PROCESSING:String="reviewProcessing";
		public static const TASK_FINISHED:String="taskFinished";
		
		public var id:Number;
		public var type:String;
		public var code:String;
		public var description:String;
		public var what:String;
		public var numareas:Number;
		public var status:String;
		public var statusPercen:Number;
		public var date:Date;

	}
}
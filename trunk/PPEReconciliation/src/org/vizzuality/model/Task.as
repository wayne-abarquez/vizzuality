package org.vizzuality.model
{
	import flash.events.EventDispatcher;
	
	[Bindable]
	public class Task extends EventDispatcher
	{
		public static const PREPARING_DOWNLOAD:String="preparingDownload"; //ff9900  //wait //processing
		public static const WAITING_FOR_DOWNLOAD:String="waitingForDownload"; //ff9900 //downloadable
		public static const WAITING_FOR_UPLOAD:String="waitingForUpload"; //ff9900 //completed
		public static const UPLOAD_PROCESSING:String="uploadProcessing"; //ff9900 // started
		public static const ERROR_IN_DATA:String="errorInData"; //ff3300  //rejected
		public static const TASK_READY_FOR_REVIEW:String="taskReadForReview"; //ff9900 // verified
		public static const REVIEW_STARTED:String="reviewStarted"; //ff9900 // saved
		public static const REVIEW_PROCESSING:String="reviewProcessing"; //ff9900 //working
		public static const TASK_FINISHED:String="taskFinished"; //339900 //rec_completed
		
		public static const TASK_CANCEL:String="taskCancel"; //339900 //canceled
		
		
		
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
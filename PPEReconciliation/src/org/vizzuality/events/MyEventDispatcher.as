package org.vizzuality.events
{
  	import flash.events.Event;
  	import flash.events.EventDispatcher;
  	
  	import org.vizzuality.model.Country;
  	import org.vizzuality.model.Pa;
  	import org.vizzuality.model.Task;
  	public class MyEventDispatcher {
    		protected static var disp:EventDispatcher;
    		public static function addEventListener(p_type:String, p_listener:Function, p_useCapture:Boolean=false, p_priority:int=0, p_useWeakReference:Boolean=false):void {
      			if (disp == null) { disp = new EventDispatcher(); }
      			disp.addEventListener(p_type, p_listener, p_useCapture, p_priority, p_useWeakReference);
      		}
    		public static function removeEventListener(p_type:String, p_listener:Function, p_useCapture:Boolean=false):void {
      			if (disp == null) { return; }
      			disp.removeEventListener(p_type, p_listener, p_useCapture);
      		}
    		public static function dispatchEvent(p_event:Event):void {
      			if (disp == null) { return; }
      			disp.dispatchEvent(p_event);
      		}
    		
  		// Public API that dispatches an event
  		public static function selectCountryForDownload(country:Country):void {
   			dispatchEvent(new DataSelectionEvent(DataSelectionEvent.COUNTRY_ADDED,country));
   		}
   		
  		public static function selectPaForDownload(pa:Pa):void {
   			dispatchEvent(new DataSelectionEvent(DataSelectionEvent.PA_ADDED,null,pa));
   		}   		
   		
   		public static function removeCountryForDownload(country:Country):void {
   			dispatchEvent(new DataSelectionEvent(DataSelectionEvent.COUNTRY_REMOVED,country));
   		}
   		public static function removePaForDownload(pa:Pa):void {
   			dispatchEvent(new DataSelectionEvent(DataSelectionEvent.PA_REMOVED,null,pa));
   		}
   		
   		public static function selectTaskForOverview(task:Task):void {
   			dispatchEvent(new TaskSelectionEvent(TaskSelectionEvent.SELECTED_TASK,task));		
   		}
   		public static function selectTaskForErrors(task:Task):void {
   			dispatchEvent(new TaskSelectionEvent(TaskSelectionEvent.SELECTED_PA_FOR_ERRORS,task));		
   		}
   		
   		public static function selectPaForOverview(pa:Pa):void {
   			dispatchEvent(new TaskSelectionEvent(TaskSelectionEvent.SELECTED_PA_FOR_REVIEW,null,pa));
   		}
   		
   		public static function rejectPa(pa:Pa,mode:String):void {
   			dispatchEvent(new TaskSelectionEvent(TaskSelectionEvent.PA_REJECTED,null,pa,mode));
   		}
   		public static function confirmPa(pa:Pa,mode:String):void {
   			dispatchEvent(new TaskSelectionEvent(TaskSelectionEvent.PA_CONFIRMED,null,pa,mode));
   		}
   		public static function cancelTask(task:Task,positionX:Number,positionY:Number):void {
   			dispatchEvent(new CancelTaskEvent(CancelTaskEvent.CANCEL_TASK,task,positionX,positionY));
   		}
   		public static function uploadTaskFile(task:Task):void {
   			dispatchEvent(new TaskSelectionEvent(TaskSelectionEvent.SELECTED_TASK_FOR_UPLOAD,task));
   		}
   		public static function taskUploaded(task:Task):void {
   			dispatchEvent(new TaskSelectionEvent(TaskSelectionEvent.TASK_UPLOADED,task));
   		}
   		
   		public static function taskListNotification(message:String):void {
   			dispatchEvent(new NotificationEvent(NotificationEvent.TASK_LIST_NOTIFICATION,message));
   		}
   		public static function dataDownloaded():void {
   			dispatchEvent(new DataSelectionEvent(DataSelectionEvent.DATA_DOWNLOADED));
   		}
   		public static function continueDownload():void {
   			dispatchEvent(new ConfirmationAlertEvent(ConfirmationAlertEvent.GO_ON));
   		}
   		public static function stopDownload():void {
   			dispatchEvent(new ConfirmationAlertEvent(ConfirmationAlertEvent.STOP_NOW));
   		}
   		
   		
    }
}
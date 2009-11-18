package org.vizzuality.components
{
	public class ReturnTimeAgo {
		public function ReturnTimeAgo(){
			
		}

		public function returnTimeAgo(created_at:String):String {
            var time:Date = new Date();
            var tp:Array; var year:int; var month:int; var date:int;
            var hour:int; var minutes:int; var seconds:int; var timezone:int;

            tp = created_at.split(/[ :]/g);
            if (tp[1]=="Jan")
                    month = 0;
            else if (tp[1]=="Feb")
                    month = 1;
            else if (tp[1]=="Mar")
                    month = 2;
            else if (tp[1]=="Apr")
                    month = 3;
            else if (tp[1]=="May")
                    month = 4;
            else if (tp[1]=="Jun")
                    month = 5;
            else if (tp[1]=="Jul")
                    month = 6;
            else if (tp[1]=="Aug")
                    month = 7;
            else if (tp[1]=="Sep")
                    month = 8;
            else if (tp[1]=="Oct")
                    month = 9;
            else if (tp[1]=="Nov")
                    month = 10;
            else if (tp[1]=="Dec")
                    month = 11;

            date = tp[2];
            hour = tp[3];
            minutes = tp[4];
            seconds = tp[5];
            timezone = tp[6];
            year = tp[7];


            time.setUTCFullYear(year, month, date);
            time.setUTCHours(hour, minutes, seconds);

            var currentTime:Date = new Date();
            //currentTime.setHours(currentTime.hours-1);
            var diffTime:int = currentTime.getTime() - time.getTime();
            //var diff:Date = new Date();
            //diff.setTime(diffTime);
            var diffDays:int = (diffTime-(diffTime%86400000))/86400000;
            diffTime=diffTime-(diffDays*86400000);
            var diffHours:int = (diffTime-(diffTime%3600000))/3600000;
            diffTime = diffTime-(diffHours*3600000);
            var diffMins:int = (diffTime-(diffTime%60000))/60000;
            diffTime = diffTime-(diffMins*60000);
            var diffSecs:int = (diffTime-(diffTime%1000))/1000;
               

            var txt:String;
            if(diffDays > 0) {
            	if (diffHours > 0) {
            		txt = (diffDays+1)+" days";
            	} else {
            		txt = diffDays+" days";
            	}
            }

            if(diffDays <= 0) 
            	txt = txt+diffHours+" hours";

            if(diffHours <= 0)
            	txt = txt+diffMins+" minutes";

            if(diffMins <= 0)
            	txt = txt+diffSecs+" seconds";

            if (txt !=null)
                txt = txt+" ago";

                return txt;
        }
        
        public function parseDate (str:String):String {
        	var time:Date = new Date();
            var tp:Array; var year:int; var month:String; var date:int;

            tp = str.split(/[ :]/g);
            if (tp[1]=="Jan")
                    month = "January";
            else if (tp[1]=="Feb")
                    month = "February";
            else if (tp[1]=="Mar")
                    month = "March";
            else if (tp[1]=="Apr")
                    month = "April";
            else if (tp[1]=="May")
                    month = "May";
            else if (tp[1]=="Jun")
                    month = "June";
            else if (tp[1]=="Jul")
                    month = "July";
            else if (tp[1]=="Aug")
                    month = "August";
            else if (tp[1]=="Sep")
                    month = "September";
            else if (tp[1]=="Oct")
                    month = "October";
            else if (tp[1]=="Nov")
                    month = "November";
            else if (tp[1]=="Dec")
                    month = "December";

            date = tp[2];
            year = tp[7];
            
            return date + ' ' + month +', ' + year;
        }

	}
}
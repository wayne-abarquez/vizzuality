package com.vizzuality.utils {
    
    import mx.collections.ArrayCollection;
    import mx.core.Application;
    import mx.core.UIComponent;
    
    import swf.SWFAddress;
    import swf.SWFAddressEvent;

    public class Helper {
    
        public static function toTitleCase(str:String):String {
            return str.substr(0,1).toUpperCase() + 
                str.substr(1);
        }
        
        public static function handleSWFAddress(scope:UIComponent, event:SWFAddressEvent, depth:int=0):void {
            var value:String = toTitleCase(event.pathNames.length > depth ? event.pathNames[depth] : '');
            if (scope.currentState != value && value!='') {
                scope.currentState = value;
            }
            var title:String = 'GMBA';
             if (event.pathNames.length > 0) {
            	title += ' > ' + toTitleCase(event.pathNames[0]);
            	if (event.pathNames[1] == 'help')
            		title += ' > ' + toTitleCase(event.pathNames[1]);
            } else {
            	//SWFAddress.setValue("map/2_40.73_-3.99/0_7889/0_3397/0");
            	scope.currentState = 'Map';
            } 
            /*  for (var i:int = 0; i < event.pathNames.length; i++) {
                title += ' » ' + toTitleCase(event.pathNames[i]);
            }  */
            SWFAddress.setTitle(title);
        }
        
        public static function setSWFAddress(scope:UIComponent, path:String='', depth:int=0):void {
            if (path!='') {
	            Application.application.tracker.trackPageview( path );
            }
            var value:String = '';
            if (scope.currentState != '' && scope.currentState != null) {
                value += scope.currentState.toLowerCase();
            }
            if (value != SWFAddress.getPathNames()[depth]) {
                var parts:Array = new Array();
                if (path != '') parts.push(path);
                if (value != '') parts.push(value);
                SWFAddress.setValue('/' + parts.join('/'));
            }
        }
        
        
        
        //Other operations with URL
        
        public static function getPoint(str: String):Object {
        	var a:Array = str.split('_');
        	var obj: Object = new Object();
        	if (checkIfNumbers(a) && a.length==3) {
        		obj.zoom = Number(a[0]).toFixed(2);
        		obj.lat = Number(a[1]).toFixed(2);
        		obj.lon = Number(a[2]).toFixed(2);        		
        	}
        	return obj;
        }
        
        public static function getSliderParams(str: String):Object {
        	var a:Array = str.split('_');
        	var obj: Object = new Object();
        	if (checkIfNumbers(a) && a.length==2 && Number(a[0])<Number(a[1])) {
        		obj.min = Number(a[0]);
        		obj.max = Number(a[1]);      		
        	}
        	return obj;
        }
        
        public static function getVegetationParams(str:String):ArrayCollection {
        	var a:Array = str.split('_');
        	var vegeValues: ArrayCollection;
        	if(a.length<2) {
        		vegeValues = new ArrayCollection([true,true,true,true,true,true,true,true]);
        	} else {
	        	vegeValues = new ArrayCollection();
	        	if (checkIfNumbers(a)) {
	        		for (var i:Number = 0; i<a.length;i++) {
		        		vegeValues.addItem(Number(a[i]));
	        		}	    		
	        	}
        	}
        	return vegeValues;
        }
        
          
        private static function checkIfNumbers(array:Array):Boolean {
        	for (var i:Number = 0; i < array.length; i++) {
        		var ext:Number = Number(array[i]);
        		if (isNaN(ext)) 
        			return false;
        	}
        	return true;
        }
    }
}
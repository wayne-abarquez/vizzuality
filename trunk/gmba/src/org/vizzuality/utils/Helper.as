package org.vizzuality.utils {
    
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
            if (scope.currentState != value) {
                scope.currentState = value;
            }
            var title:String = 'GMBA';
            for (var i:int = 0; i < event.pathNames.length; i++) {
                title += ' » ' + toTitleCase(event.pathNames[i]);
            }
            SWFAddress.setTitle(title);
        }
        
        public static function setSWFAddress(scope:UIComponent, path:String='', depth:int=0):void {
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
    }
}
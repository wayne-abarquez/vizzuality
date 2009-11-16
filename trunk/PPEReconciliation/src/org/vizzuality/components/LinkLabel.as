package org.vizzuality.components
{
    import flash.events.MouseEvent;
    import flash.net.URLRequest;
    import flash.net.navigateToURL;
    
    import mx.controls.Label;
    import mx.utils.ArrayUtil;

    [Style(name="linkColor", type="uint", format="Color", inherit="no")]

    [Style(name="linkDecoration", type="String", inherit="no")]

    [Style(name="hoverColor", type="uint", format="Color", inherit="no")]

    [Style(name="hoverDecoration", type="String", inherit="no")]
    
    public class LinkLabel extends Label
    {

        
        public var text_decoration:String;
        public var default_color:Number;
        public var default_hover_color:Number;
        public var default_hover_decoration:String;
        public var default_weight:String;
        public var default_hover_weight:String;
        private const DEFAULT_TARGET:String = "_self";
        private const TARGETS:Array = [
            "_self",
            "_blank",
            "_parent",
            "_top"
        ]

        
        private var _url:String;
        private var _target:String;
        public var callBackFunction:Function;

        
        public function LinkLabel()
        {
            super();
            
            
            addEventListener(MouseEvent.CLICK, clickEventListener);
            addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
            addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
        }
        
        
        override protected function commitProperties():void
        {
            super.commitProperties();
            
            useHandCursor = true;
            buttonMode = true;
            mouseChildren = false;
        }
        

        
        public function set url(value:String):void
        {
            if(_url == value)
                return;
            
            _url = value;
            //toolTip = value;
        }
        
        public function get url():String
        {
            return _url;
        }
        
        public function set target(value:String):void
        {
            if(_target == value)
                return;
            if(ArrayUtil.getItemIndex(value, TARGETS) == -1)
            {
                _target = DEFAULT_TARGET;
                return;
            }
            
            _target = value;
        }
        public function get target():String
        {
            if(_target == null)
                _target = DEFAULT_TARGET;
            
            return _target;
        }

        
        protected function clickEventListener(event:MouseEvent):void
        {
            if(callBackFunction == null)
                callBackFunction = navigateURL;
            callBackFunction({url: url, target: target});
        }
        
        private function navigateURL(value:Object):void
        {
            var urlRequest:URLRequest = new URLRequest(value.url);
            navigateToURL(urlRequest, value.target);
        }

        
        private function mouseOverHandler(event:MouseEvent):void
        {
            setStyle("color", default_hover_color);
            setStyle("textDecoration", default_hover_decoration);
             setStyle("fontWeight", default_hover_weight);
         }
        
        private function mouseOutHandler(event:MouseEvent):void
        {
            setStyle("color", default_color);
            setStyle("textDecoration", text_decoration);
            setStyle("fontWeight", default_weight);
         }
    }
}
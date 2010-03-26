package com.vizzuality.utils
{
	import mx.containers.Canvas;
	import mx.styles.StyleManager;

	public class GradientCanvas extends Canvas
	{
		public var firstColor: uint ;
		public var secondColor: uint;
		
		public function GradientCanvas() {
			super();
		}
		
		override protected function updateDisplayList(unscaledWidth:Number,unscaledHeight:Number):void {
                super.updateDisplayList(unscaledWidth,unscaledHeight);
                var fillColors : Array = [firstColor,secondColor];
                var fillAlphas : Array = [100,100]
                var cornerRadius : Number = 2
                StyleManager.getColorNames (fillColors);
                graphics.clear ();
                drawRoundRect (0, 0, unscaledWidth, unscaledHeight, cornerRadius,fillColors, fillAlphas,verticalGradientMatrix (0, 0, unscaledWidth,unscaledHeight));
        } 
		
	}
}
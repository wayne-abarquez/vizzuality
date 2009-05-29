/**
 * draws a heat map from the feeded data, fully parametrable
 * 
 * This software is provided 'as-is', without any express or implied warranty.
 * In no event will the authors be held liable for any damages arising from the use of this software.
 *
 * This file is released under the Creative Commons
 * "Attribution-Noncommercial-Share Alike 3.0" License
 * More information can be found here:
 * http://creativecommons.org/licenses/by-nc-sa/3.0/
 *
 * @author     Jordi Boggiano <j.boggiano@seld.be>
 * @copyright  2007 Jordi Boggiano
 * @license    http://creativecommons.org/licenses/by-nc-sa/3.0/  Creative Commons BY-NC-SA 3.0
 * @link       http://www.seld.be/
 * @version    1.0.0
 * @date       2007-12-16
 * @package    com.seld.draw
 */
package com.seld.draw
{
	import flash.display.Sprite;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.display.Shape;
	import flash.geom.Rectangle;
	import flash.display.GradientType;

	public class HeatMap extends Sprite
	{
		// map settings
		protected var 
			w:int = 600,
			h:int = 600,
			bmp:Bitmap = new Bitmap(),
			pencil:Shape = new Shape(),
			penRadius:Number = 0,
			minAlpha:Number = 0,
			xData:Array,
			yData:Array,
			dataScale:Rectangle,
			scaleRender:int = 1,
			scaleCpu:int = 1;
		
		// current render settings
		protected var
			cellWidth:Number,
			cellHeight:Number,
			max:Number,
			loop:int,
			i:int,
			j:int,
			cnt:int=0;
		
		/**
		 * constructor
		 * 
		 * sets the width
		 * 
		 * @param width
		 * @param height
		 */
		public function HeatMap(width:uint, height:uint):void
		{
			w = width;
			h = height;
			addChild(bmp);
		}
		
		/**
		 * loads the data from two array, one containing X coordinates of points and the second containing Y coordinates
		 * 
		 * @param dataX x-coordinates
		 * @param dataY y-coordinates
		 * @param originalSize a Rectangle object containing the original bounds / scale of the data so it can be scaled down to the heatmap's size
		 */
		public function setData(dataX:Array, dataY:Array, originalSize:Rectangle):void
		{
			xData = dataX;
			yData = dataY;
			dataScale = originalSize;
			
			draw();
		}

		/**
		 * sets the quality settings, allowing you to degrade visual quality to gain performances
		 * 
		 * restarts the drawing process
		 * 
		 * @param renderScaling scales down the whole rendering to make it a lot faster but it gets blurry as well, use 1, 2 or 4
		 * @param computationScaling scales down some internal computations to go a bit faster at nearly no quality cost, use 1, 2 or 4
		 */
		public function setQuality(renderScaling:uint = 2, computationScaling:uint = 4):void
		{
			var t:Array = [1,2,4];
			if(t.indexOf(renderScaling)>=0)
				scaleRender = renderScaling;
			if(t.indexOf(computationScaling)>=0)
				scaleCpu = computationScaling;
				
			draw();
		}
	
		/**
		 * sets pen properties
		 * 
		 * restarts the drawing process
		 * 
		 * setting both properties to zero will enable the auto-properties feature, which might or might not work
		 * 
		 * @param radius the pen radius in pixels
		 * @param strength the pen strength, ranging from 0 to 1, acceptable values being generally between 15/256 and 100/256
		 */ 
		public function setPenProperties(radius:Number = 6, strength:Number = 0.1):void
		{
			penRadius = radius;
			minAlpha = strength;
			
			draw();
		}
		
		/**
		 * initializes the drawing process
		 * 
		 * automatically called by setter functions
		 */
		public function draw():void
		{
			if(xData == null)
				return;
				
			// auto set pen properties depending on the data samples if both are zero, kind of experimental
			if(penRadius == 0 && minAlpha == 0)
			{
				if(xData.length < 50)
				{
					minAlpha = 100/256;
					penRadius= 3;
				}
				else if(xData.length < 400)
				{
					minAlpha = 20/256;
					penRadius= 6;
				}
				else if(xData.length < 1000)
				{
					minAlpha = 25/256;
					penRadius= 6;
				}
				else
				{
					minAlpha = 20/256;
					penRadius= 6;
				}
			}
			
			// build pencil
			with(pencil.graphics)
			{
				clear();
				beginGradientFill(GradientType.RADIAL, [0,0], [minAlpha, 0], [0, 255]);
				drawCircle(0, 0, penRadius);
				endFill();
			}
			
			// build bitmap
			if(bmp.bitmapData != null)
				bmp.bitmapData.dispose();
			bmp.bitmapData = new BitmapData(w / scaleRender, h / scaleRender, true, 0);
			bmp.scaleX = scaleRender;
			bmp.scaleY = scaleRender;
			bmp.smoothing = scaleRender > 1;
			
			// init vars
			cellWidth = (dataScale.right - dataScale.x) / w * scaleRender;
			cellHeight = (dataScale.bottom - dataScale.y) / h * scaleRender;
			max = loop = i = j = 0;
			
			addEventListener(Event.ENTER_FRAME, work);
		}
		
		/**
		 * renders a chunk of data every frame until the job is done
		 */
		protected function work(e:Event = null):void
		{
			// init vars
			var 
				xGrid:int,
				yGrid:int,
				tmp:int,
				b:BitmapData = bmp.bitmapData;
		
			// add heat
			if(loop == 0)
			{
				// process 400 heat spots per pass
				tmp = Math.min(i + 400, xData.length);
				for(i; i < tmp; i++) {
			   		xGrid = (xData[i] - dataScale.x) / cellWidth;
					yGrid = (yData[i] - dataScale.y) / cellHeight;
					b.draw(pencil, new Matrix(1,0,0,1, xGrid, yGrid));
				}
				// go to next
				if(tmp == xData.length)
				{
					loop = 1;
					i = 0;
					return;
				}
			}
			
			// find max
			if(loop == 1)
			{
				// process 30000 pixels per pass
				tmp = Math.min(i + Math.max(1, 30000/h), w);
				for (i; i < tmp; i+= scaleCpu) {
					for (j = 0; j < h; j+= scaleCpu) {
						max = Math.max(max, (b.getPixel32(i,j) >> 8) & 0xFFFFFF);
					}
				}
				// go to next
				if(tmp == w)
				{
					loop = 2;
					i = 0;
					return;
				}
			}

		
			// normalize & colorize
			if(loop == 2)
			{
				// process 15000 pixels per pass
				tmp = Math.min(i + Math.max(1, 15000/b.width), b.height);
				for (i; i < tmp; i++) {
					for (j = 0; j<b.width; j++) {
						var pixel:int = b.getPixel32(j, i);
						if(pixel == 0) continue;
						b.setPixel32(j, i, colorize(((pixel >> 8) & 0xFFFFFF) / max));
					}
				}
				// render complete
				if(tmp == b.height)
				{
					removeEventListener(Event.ENTER_FRAME, work);
					dispatchEvent(new Event(Event.RENDER));
				}
			}
		}
		
		/**
		 * helper function, defines a color based on an intensity (aka brightness)
		 */
		protected function colorize(intensity:Number):uint
		{
			var a:int = Math.min(255 * intensity, 255);
	
			var temp:Number, r:int = 0, g:int = 0, b:int = 0;
		
			// blue
			if (intensity < 0.33) {
				b = 0;
			}
			else if (intensity >= 0.33 && intensity < 0.66) {
				temp = (intensity - 0.33) / 0.33;
				b = (1-temp) * 255;
			}
			else {
				b = 0;
			}
		
			// green
			if (intensity < 0.33) {
				temp = intensity / 0.33;
				g = temp * 255;
			}
			else if (intensity >= 0.33 && intensity < 0.66)	{
				g = 255;
			}
			else {
				temp = (intensity - 0.66) / 0.34;
				g = (1 - temp) * 255;
			}
		
			// red
			if (intensity < 0.33) {
				r = 0;
			}
			else if (intensity >= 0.33 && intensity < 0.66)	{
				temp = (intensity - 0.33) / 0.33;
				r = temp * 255;
			}
			else {
				r = 255;
			}
			
			return (a << 24) + (r << 16) + (g << 8) + b;
		}
	}
}